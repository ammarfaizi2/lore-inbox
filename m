Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWFBVXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWFBVXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWFBVXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:23:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:32417 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030290AbWFBVXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:23:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:cc:subject:message-id:references:mime-version:content-type;
        b=SyYxn6S4NsIcXhvqlIPY/tg8poRhR+4rsXhws9G+bqBQXHJBh21VVgvUKJ0E98qWnB+syUrJObSk4fhxb2tvDAyjMbDKQJcp8ER1M2aBqxWBoqdysPpJ0iZqzBJHSgbsWizjueJY3b56TpgCYFvCYP3gdPNcMxZUIrECXh3N4a4=
Date: Fri, 2 Jun 2006 23:23:15 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost
To: linux-kernel@vger.kernel.org
cc: Ingo Molnar <mingo@elte.hu>
Subject: [patch 2/5] [PREEMPT_RT] Changing interrupt handlers from running
 in thread to hardirq and back runtime.
Message-ID: <Pine.LNX.4.64.0606022321440.9307@localhost>
References: <20060602165336.147812000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it possible to change which context the interrupt handlers
for each interrupt run in, hard-irq or threaded if CONFIG_PREEMPT_HARDIRQS is 
set.

The interface is the file
  /proc/irq/<irq number>/threaded
You can read it to see what the context is now or write one of

  irq
  fifo <rt priority>
  rr <rt priority>
  normal <nice value>
  batch <nice value>

where one of the latter makes the interrupt handler threaded.

A replacement for request_irq(), called request_irq2(), is added. When a driver
uses this to install it's irq-handler it can also give a change_irq_context
call-back. This call-back is called whenever the irq-context is changed or 
going to be changed. The call-back must be of the form

int driver_change_context(int irq, void *dev_id, enum change_context_cmd cmd)

where

enum change_context_cmd {
 	IRQ_TO_HARDIRQ,
 	IRQ_CAN_THREAD,
 	IRQ_TO_THREADED
};

The call-back is supposed to do the following on
  IRQ_TO_HARDIRQ: make sure everything in the interrupt handler is non-blocking
                  or return a non-zero error code.
  IRQ_CAN_THREAD: Return 0 if it is ok for the interrupt handler to be run in
                  thread context. Return a non-zero error code otherwise.
  IRQ_TO_THREAD: Now the interrupt handler does run in thread context. The
                 driver can now change it's locks to being mutexes. The return
                 value is ignored as the driver already got a chance to protest
                 above.

Index: linux-2.6.16-rt23.spin_mutex/include/linux/interrupt.h
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/include/linux/interrupt.h
+++ linux-2.6.16-rt23.spin_mutex/include/linux/interrupt.h
@@ -34,21 +34,38 @@ typedef int irqreturn_t;
  #define IRQ_HANDLED	(1)
  #define IRQ_RETVAL(x)	((x) != 0)

+enum change_context_cmd {
+	IRQ_TO_HARDIRQ,
+	IRQ_CAN_THREAD,
+	IRQ_TO_THREADED
+};
+
  struct irqaction {
  	irqreturn_t (*handler)(int, void *, struct pt_regs *);
  	unsigned long flags;
  	cpumask_t mask;
  	const char *name;
  	void *dev_id;
+#ifdef CONFIG_CHANGE_IRQ_CONTEXT
+	int (*change_context)(int, void *,
+			      enum change_context_cmd);
+#endif
  	struct irqaction *next;
  	int irq;
-	struct proc_dir_entry *dir, *threaded;
+	struct proc_dir_entry *dir;
+	struct rcu_head rcu;
  };

  extern irqreturn_t no_action(int cpl, void *dev_id, struct pt_regs *regs);
  extern int request_irq(unsigned int,
  		       irqreturn_t (*handler)(int, void *, struct pt_regs *),
  		       unsigned long, const char *, void *);
+extern int request_irq2(unsigned int irq,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned long irqflags, const char * devname,
+			void *dev_id,
+			int (*change_context)(int, void *,
+					      enum change_context_cmd));
  extern void free_irq(unsigned int, void *);


Index: linux-2.6.16-rt23.spin_mutex/include/linux/irq.h
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/include/linux/irq.h
+++ linux-2.6.16-rt23.spin_mutex/include/linux/irq.h
@@ -47,6 +47,18 @@
  # define SA_NODELAY 0x01000000
  #endif

+#ifndef SA_MUST_THREAD
+# define SA_MUST_THREAD 0x02000000
+#endif
+
+/* Set this flag if the irq handler must thread under preempt-rt otherwise not
+ */
+#ifdef CONFIG_PREEMPT_RT
+# define SA_MUST_THREAD_RT SA_MUST_THREAD
+#else
+# define SA_MUST_THREAD_RT 0
+#endif
+
  /*
   * IRQ types
   */
@@ -147,12 +159,13 @@ struct irq_type {
   * @chip:		low level hardware access functions - comes from type
   * @action:		the irq action chain
   * @status:		status information
+ *                      (protected by the spinlock )
   * @depth:		disable-depth, for nested irq_disable() calls
   * @irq_count:		stats field to detect stalled irqs
   * @irqs_unhandled:	stats field for spurious unhandled interrupts
   * @thread:		Thread pointer for threaded preemptible irq handling
   * @wait_for_handler:	Waitqueue to wait for a running preemptible handler
- * @lock:		locking for SMP
+ * @lock:		lock around the action list
   * @move_irq:		Flag need to re-target interrupt destination
   *
   * Pad this out to 32 bytes for cache and indexing reasons.
Index: linux-2.6.16-rt23.spin_mutex/kernel/Kconfig.preempt
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/kernel/Kconfig.preempt
+++ linux-2.6.16-rt23.spin_mutex/kernel/Kconfig.preempt
@@ -119,6 +119,17 @@ config PREEMPT_HARDIRQS

  	  Say N if you are unsure.

+config CHANGE_IRQ_CONTEXT
+	bool "Change the irq context runtime"
+	depends on PREEMPT_HARDIRQS && (PREEMPT_RCU || !SPIN_MUTEXES)
+	help
+	  You can change wether the IRQ handler(s) for each IRQ number is
+          running in hardirq context or as threaded by writing to
+          /proc/irq/<number>/threaded
+          If PREEMPT_RT is selected the drivers involved must be ready for it,
+          though, or the write will fail. Remember to switch on SPIN_MUTEXES as
+          well in that case as the drivers which are ready uses spin-mutexes.
+
  config SPINLOCK_BKL
  	bool "Old-Style Big Kernel Lock"
  	depends on (PREEMPT || SMP) && !PREEMPT_RT
Index: linux-2.6.16-rt23.spin_mutex/kernel/irq/internals.h
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/kernel/irq/internals.h
+++ linux-2.6.16-rt23.spin_mutex/kernel/irq/internals.h
@@ -22,6 +22,10 @@ static inline void end_irq(irq_desc_t *d
  }

  #ifdef CONFIG_PROC_FS
+#ifdef CONFIG_CHANGE_IRQ_CONTEXT
+extern int make_irq_nodelay(int irq, struct irq_desc *desc);
+extern int make_irq_threaded(int irq, struct irq_desc *desc);
+#endif
  extern void register_irq_proc(unsigned int irq);
  extern void register_handler_proc(unsigned int irq, struct irqaction *action);
  extern void unregister_handler_proc(unsigned int irq, struct irqaction *action);
Index: linux-2.6.16-rt23.spin_mutex/kernel/irq/manage.c
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/kernel/irq/manage.c
+++ linux-2.6.16-rt23.spin_mutex/kernel/irq/manage.c
@@ -206,6 +206,153 @@ int can_request_irq(unsigned int irq, un
  	return !action;
  }

+
+#ifdef CONFIG_CHANGE_IRQ_CONTEXT
+int make_action_nodelay(int irq, struct irqaction *act)
+{
+	unsigned long flags;
+
+	if(!(act->flags & SA_MUST_THREAD)) {
+		return 0;
+	}
+
+	if( act->change_context ) {
+		int ret =
+			act->change_context(irq, act->dev_id, IRQ_TO_HARDIRQ);
+		if(ret) {
+			printk(KERN_ERR "Failed to change irq handler "
+			       "for dev %s on IRQ%d to hardirq "
+			       "context (ret: %d)\n", act->name, irq, ret);
+			return ret;
+		}
+		spin_lock_irqsave(&irq_desc[irq].lock, flags);
+		act->flags &=~SA_MUST_THREAD;
+		act->flags |= SA_NODELAY;
+		spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
+		return 0;
+	}
+	else {
+		printk(KERN_ERR "Irq handler "
+		       "for dev %s on IRQ%d can not be changed"
+		       " to hardirq context\n", act->name, irq);
+		return -ENOSYS;
+	}
+
+}
+
+
+static int __make_irq_threaded(int irq, struct irq_desc *desc);
+
+int make_irq_nodelay(int irq, struct irq_desc *desc)
+{
+	int ret = 0;
+	struct irqaction *act;
+	unsigned long flags;
+
+	rcu_read_lock();
+	for(act = desc->action; act; act = act->next) {
+		WARN_ON(((~act->flags) & (SA_MUST_THREAD|SA_NODELAY)) == 0);
+		if(act->flags & SA_MUST_THREAD) {
+			ret = make_action_nodelay(irq, act);
+			if(ret) {
+				printk(KERN_ERR "Could not make irq %d "
+				       "nodelay (errno %d)\n",
+				       irq, ret);
+				goto failed;
+			}
+		}
+	}
+	spin_lock_irqsave(&desc->lock, flags);
+	desc->status |= IRQ_NODELAY;
+	spin_unlock_irqrestore(&desc->lock, flags);
+	rcu_read_unlock();
+
+	return 0;
+ failed:
+	__make_irq_threaded(irq, desc);
+	rcu_read_unlock();
+	return ret;
+}
+
+int action_may_thread(int irq, struct irqaction *act)
+{
+	if(!act->change_context)
+		return !(act->flags & SA_NODELAY);
+
+	return act->change_context(irq, act->dev_id, IRQ_CAN_THREAD) == 0;
+}
+
+
+static int __make_irq_threaded(int irq, struct irq_desc *desc)
+{
+	struct irqaction *act;
+
+	for(act = desc->action; act; act = act->next) {
+		WARN_ON(((~act->flags) & (SA_MUST_THREAD|SA_NODELAY)) == 0);
+		if(!action_may_thread(irq, act)) {
+			return -EINVAL;
+		}
+	}
+
+	if (start_irq_thread(irq, desc))
+		return -ENOMEM;
+
+	spin_lock_irq(&desc->lock);
+	desc->status &= ~IRQ_NODELAY;
+	spin_unlock_irq(&desc->lock);
+
+	/* We can't make irq handlers change their context before we
+	   are sure no CPU is running them in hard irq context */
+	synchronize_irq(irq);
+
+	for(act = desc->action; act; act = act->next) {
+		WARN_ON(((~act->flags) & (SA_MUST_THREAD|SA_NODELAY)) == 0);
+		if(act->change_context) {
+			/* This callback can't fail */
+			act->change_context(irq, act->dev_id, IRQ_TO_THREADED);
+			spin_lock_irq(&desc->lock);
+			act->flags &=~SA_NODELAY;
+			act->flags |= SA_MUST_THREAD;
+			spin_unlock_irq(&desc->lock);
+		}
+	}
+
+	return 0;
+}
+
+int make_irq_threaded(int irq, struct irq_desc *desc)
+{
+	int ret;
+	rcu_read_lock();
+	ret = __make_irq_threaded(irq, desc);
+	rcu_read_unlock();
+	return ret;
+}
+#else /* CONFIG_CHANGE_IRQ_CONTEXT */
+int make_action_nodelay(int irq, struct irqaction *act)
+{
+	return -EINVAL;
+}
+int make_irq_nodelay(int irq, struct irq_desc *desc)
+{
+	unsigned long flags;
+	struct irqaction *act;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	for(act = desc->action; act; act = act->next) {
+		WARN_ON((~act->flags) & (SA_MUST_THREAD|SA_NODELAY) == 0);
+		if(act->flags & SA_MUST_THREAD)
+			return -EINVAL;
+	}
+
+	desc->status |= IRQ_NODELAY;
+	spin_unlock_irqrestore(&desc->lock, flags);
+
+	return 0;
+}
+
+#endif /* !CONFIG_CHANGE_IRQ_CONTEXT */
+
  /*
   * Internal function to register an irqaction - typically used to
   * allocate special interrupts that are part of the architecture.
@@ -239,11 +386,28 @@ int setup_irq(unsigned int irq, struct i
  		rand_initialize_irq(irq);
  	}

+	WARN_ON(((~new->flags) & (SA_MUST_THREAD|SA_NODELAY)) == 0);
  	if (!(new->flags & SA_NODELAY))
  		if (start_irq_thread(irq, desc))
  			return -ENOMEM;
+
+	if( (desc->status & IRQ_NODELAY) && (new->flags & SA_MUST_THREAD) ) {
+		int ret = make_action_nodelay(irq, new);
+		if(ret)
+			return ret;
+	}
+
+
+	if( (new->flags & SA_NODELAY) && !(desc->status & IRQ_NODELAY) ) {
+		int ret = make_irq_nodelay(irq, desc);
+		if(ret)
+			return ret;
+	}
+
+
  	/*
-	 * The following block of code has to be executed atomically
+	 * The following block of code has to be executed atomically due
+	 * to the hard irq context
  	 */
  	spin_lock_irqsave(&desc->lock, flags);
  	p = &desc->action;
@@ -262,7 +426,7 @@ int setup_irq(unsigned int irq, struct i
  		shared = 1;
  	}

-	*p = new;
+	rcu_assign_pointer(*p, new);

  	/*
  	 * Propagate any possible SA_NODELAY flag into IRQ_NODELAY:
@@ -282,13 +446,25 @@ int setup_irq(unsigned int irq, struct i

  	new->irq = irq;
  	register_irq_proc(irq);
-	new->dir = new->threaded = NULL;
+	new->dir = NULL;
  	register_handler_proc(irq, new);

  	return 0;
  }

  /**
+ *      free_irqaction_rcu - free the actual memory block of a struct irqaction
+ *      @rcu: Pointer to the struct rcu_head
+ *
+ *      Is called after RCU syncronization
+ */
+static void free_irqaction_rcu(struct rcu_head *rcu)
+{
+	struct irqaction *p = container_of(rcu, struct irqaction, rcu);
+	kfree(p);
+}
+
+/**
   *	free_irq - free an interrupt
   *	@irq: Interrupt line to free
   *	@dev_id: Device identity to free
@@ -312,6 +488,7 @@ void free_irq(unsigned int irq, void *de
  		return;

  	desc = irq_desc + irq;
+
  	spin_lock_irqsave(&desc->lock, flags);
  	p = &desc->action;
  	for (;;) {
@@ -325,7 +502,7 @@ void free_irq(unsigned int irq, void *de
  				continue;

  			/* Found it - now remove it from the list of entries */
-			*pp = action->next;
+			rcu_assign_pointer(*pp, action->next);

  			/* Currently used only by UML, might disappear one day.*/
  #ifdef CONFIG_IRQ_RELEASE_METHOD
@@ -344,9 +521,8 @@ void free_irq(unsigned int irq, void *de
  			spin_unlock_irqrestore(&desc->lock, flags);
  			unregister_handler_proc(irq, action);

-			/* Make sure it's not being used on another CPU */
  			synchronize_irq(irq);
-			kfree(action);
+			call_rcu(&action->rcu, free_irqaction_rcu);
  			return;
  		}
  		printk(KERN_ERR "Trying to free free IRQ%d\n", irq);
@@ -358,12 +534,14 @@ void free_irq(unsigned int irq, void *de
  EXPORT_SYMBOL(free_irq);

  /**
- *	request_irq - allocate an interrupt line
+ *	request_irq2 - allocate an interrupt line
   *	@irq: Interrupt line to allocate
   *	@handler: Function to be called when the IRQ occurs
   *	@irqflags: Interrupt type flags
   *	@devname: An ascii name for the claiming device
   *	@dev_id: A cookie passed back to the handler function
+ *      @change_context: call back for requesting a change of context
+ *       (threaded vs hardirq)
   *
   *	This call allocates interrupt resources and enables the
   *	interrupt line and IRQ handling. From the point this
@@ -381,18 +559,23 @@ EXPORT_SYMBOL(free_irq);
   *
   *	Flags:
   *
- *	SA_SHIRQ		Interrupt is shared
+ *	SA_SHIRQ		Interrupt can be shared
   *	SA_INTERRUPT		Disable local interrupts while processing
   *	SA_SAMPLE_RANDOM	The interrupt can be used for entropy
+ *      SA_NODELAY              The handler must run in hardirq context
+ *      SA_MUSTTHREAD           The handler can not run in hardirq context
   *
   */
-int request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		unsigned long irqflags, const char * devname, void *dev_id)
+int request_irq2(unsigned int irq,
+		 irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		 unsigned long irqflags, const char * devname, void *dev_id,
+		 int (*change_context)(int, void *,
+				       enum change_context_cmd))
  {
  	struct irqaction * action;
  	int retval;

+
  	/*
  	 * Sanity-check: shared interrupts must pass in a real dev-ID,
  	 * otherwise we'll have trouble later trying to figure out
@@ -416,8 +599,11 @@ int request_irq(unsigned int irq,
  	action->flags = irqflags;
  	cpus_clear(action->mask);
  	action->name = devname;
-	action->next = NULL;
  	action->dev_id = dev_id;
+#ifdef CONFIG_CHANGE_IRQ_CONTEXT
+	action->change_context = change_context;
+#endif
+	action->next = NULL;

  	select_smp_affinity(irq);

@@ -427,7 +613,17 @@ int request_irq(unsigned int irq,

  	return retval;
  }
+EXPORT_SYMBOL(request_irq2);

+int request_irq(unsigned int irq,
+		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		unsigned long irqflags, const char * devname, void *dev_id)
+{
+	if( !(irqflags & SA_NODELAY) )
+		irqflags |= SA_MUST_THREAD_RT;
+
+	return request_irq2(irq, handler, irqflags, devname, dev_id, NULL);
+}
  EXPORT_SYMBOL(request_irq);

  /**
Index: linux-2.6.16-rt23.spin_mutex/kernel/irq/proc.c
===================================================================
--- linux-2.6.16-rt23.spin_mutex.orig/kernel/irq/proc.c
+++ linux-2.6.16-rt23.spin_mutex/kernel/irq/proc.c
@@ -11,6 +11,7 @@
  #include <linux/profile.h>
  #include <linux/proc_fs.h>
  #include <linux/interrupt.h>
+#include <linux/ctype.h>

  #include "internals.h"

@@ -83,6 +84,138 @@ static int irq_affinity_write_proc(struc

  #endif

+
+#ifdef CONFIG_CHANGE_IRQ_CONTEXT
+/*
+ * The /proc/irq/<irq>/threaded values:
+ */
+static struct proc_dir_entry *irq_threaded_entry[NR_IRQS];
+
+static const char *sched_policies[] = {
+	"normal",
+	"fifo",
+	"rr",
+	"batch"
+};
+
+static int irq_threaded_read_proc(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	unsigned int irq = (int)(long)data;
+	task_t *t;
+
+	if ( (irq_desc[irq].status & IRQ_NODELAY)
+	    || !irq_desc[irq].thread ) {
+		return scnprintf(page, count, "IRQ\n");
+	}
+
+	t = irq_desc[irq].thread;
+	if (t->policy==SCHED_NORMAL &&  t->policy == SCHED_BATCH )
+		return scnprintf(page, count, "%s %d\n",
+				 sched_policies[t->policy],
+				 task_prio(t));
+	else
+		return scnprintf(page, count, "%s %lu\n",
+				 sched_policies[t->policy],
+				 t->rt_priority);
+}
+
+
+static int set_rt_prio(int irq, int policy, char *arg)
+{
+	char *tmp;
+	struct sched_param prm;
+	int ret;
+	task_t *t;
+
+	while(isspace(*arg))
+		arg++;
+
+	if(*arg) {
+		prm.sched_priority = simple_strtol(arg,&tmp,10);
+		if (tmp == arg)
+			return -EINVAL;
+	}
+	else
+	  return -EINVAL;
+
+	ret = make_irq_threaded(irq, &irq_desc[irq]);
+	if(ret)
+		return ret;
+
+	t = irq_desc[irq].thread;
+	return sched_setscheduler(t, policy, &prm);
+}
+
+static int set_nonrt_prio(int irq, int policy, char *arg)
+{
+	char *tmp;
+	long prio;
+	int ret;
+	struct sched_param prm;
+	task_t *t;
+
+	while(isspace(*arg))
+		arg++;
+
+
+	if(*arg) {
+		prio = simple_strtol(arg,&tmp,10);
+		if (tmp == arg || prio < -20 || prio > 19)
+			return -EINVAL;
+	}
+	else
+		prio = 0;
+
+	ret = make_irq_threaded(irq, &irq_desc[irq]);
+	if(ret)
+		return ret;
+
+	t = irq_desc[irq].thread;
+	prm.sched_priority = 0;
+	ret = sched_setscheduler(t, policy, &prm);
+	if(ret)
+		return ret;
+
+	set_user_nice(t, prio);
+	return 0;
+}
+
+static int irq_threaded_write_proc(struct file *file,
+				   const char __user *buffer,
+				   unsigned long count, void *data)
+{
+	unsigned int irq = (int)(long)data;
+	int ret = 0;
+	char buf[20];
+
+	if(copy_from_user( (void*)&buf[0], (void*)buffer,
+			   count>20 ? 20: count ) )
+		return -EFAULT;
+
+	buf[19] = 0;
+
+	if(!strnicmp(buf,"irq",3))
+ 		ret = make_irq_nodelay(irq, &irq_desc[irq]);
+	else if(!strnicmp(buf,"normal",3))
+		ret = set_nonrt_prio(irq, SCHED_NORMAL, buf+6);
+	else if(!strnicmp(buf,"fifo",3))
+		ret = set_rt_prio(irq, SCHED_FIFO, buf+4);
+	else  if(!strnicmp(buf,"rr",2))
+		ret = set_rt_prio(irq, SCHED_RR, buf+2);
+	else  if(!strnicmp(buf,"batch",3))
+		ret = set_nonrt_prio(irq, SCHED_BATCH, buf+5);
+	else
+		ret = -EINVAL;
+
+
+	if(ret)
+		return ret;
+	else
+		return count;
+}
+#endif /* CONFIG_CHANGE_IRQ_CONTEXT */
+
  #define MAX_NAMELEN 10

  void register_irq_proc(unsigned int irq)
@@ -116,58 +249,33 @@ void register_irq_proc(unsigned int irq)
  		smp_affinity_entry[irq] = entry;
  	}
  #endif
+
+#ifdef CONFIG_CHANGE_IRQ_CONTEXT
+	{
+		struct proc_dir_entry *entry;
+
+		/* create /proc/irq/<irq>/threaded */
+		entry = create_proc_entry("threaded", 0600, irq_dir[irq]);
+
+		if (entry) {
+			entry->nlink = 1;
+			entry->data = (void *)(long)irq;
+			entry->read_proc = irq_threaded_read_proc;
+			entry->write_proc = irq_threaded_write_proc;
+		}
+		irq_threaded_entry[irq] = entry;
+	}
+#endif
  }

  #undef MAX_NAMELEN

  void unregister_handler_proc(unsigned int irq, struct irqaction *action)
  {
-	if (action->threaded)
-		remove_proc_entry(action->threaded->name, action->dir);
  	if (action->dir)
  		remove_proc_entry(action->dir->name, irq_dir[irq]);
  }

-#ifndef CONFIG_PREEMPT_RT
-
-#ifndef CONFIG_PREEMPT_RT
-
-static int threaded_read_proc(char *page, char **start, off_t off,
-			      int count, int *eof, void *data)
-{
-	return sprintf(page, "%c\n",
-		((struct irqaction *)data)->flags & SA_NODELAY ? '0' : '1');
-}
-
-static int threaded_write_proc(struct file *file, const char __user *buffer,
-			       unsigned long count, void *data)
-{
-	int c;
-	struct irqaction *action = data;
-	irq_desc_t *desc = irq_desc + action->irq;
-
-	if (get_user(c, buffer))
-		return -EFAULT;
-	if (c != '0' && c != '1')
-		return -EINVAL;
-
-	spin_lock_irq(&desc->lock);
-
-	if (c == '0')
-		action->flags |= SA_NODELAY;
-	if (c == '1')
-		action->flags &= ~SA_NODELAY;
-	recalculate_desc_flags(desc);
-
-	spin_unlock_irq(&desc->lock);
-
-	return 1;
-}
-
-#endif
-
-#endif
-
  #define MAX_NAMELEN 128

  static int name_unique(unsigned int irq, struct irqaction *new_action)
@@ -197,20 +305,6 @@ void register_handler_proc(unsigned int
  	action->dir = proc_mkdir(name, irq_dir[irq]);
  	if (!action->dir)
  		return;
-#ifndef CONFIG_PREEMPT_RT
-	{
-		struct proc_dir_entry *entry;
-		/* create /proc/irq/1234/handler/threaded */
-		entry = create_proc_entry("threaded", 0600, action->dir);
-		if (!entry)
-			return;
-		entry->nlink = 1;
-		entry->data = (void *)action;
-		entry->read_proc = threaded_read_proc;
-		entry->write_proc = threaded_write_proc;
-		action->threaded = entry;
-	}
-#endif
  }

  #undef MAX_NAMELEN

--
