Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVELBpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVELBpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVELBoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:44:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23520 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261236AbVELBno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:43:44 -0400
Date: Wed, 11 May 2005 18:43:52 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
Message-ID: <20050512014352.GH1342@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050510144531.GA1566@us.ibm.com> <Pine.OSF.4.05.10505111837580.6202-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10505111837580.6202-200000@da410.phys.au.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 08:14:49PM +0200, Esben Nielsen wrote:
> On Tue, 10 May 2005, Paul E. McKenney wrote:
> 
> > On Tue, May 10, 2005 at 12:55:31PM +0200, Esben Nielsen wrote:
> > [...]
> > > > 
> > > > The current implementation in Ingo's CONFIG_PREEMPT_RT patch uses a
> > > > counter-based approach, which seems to work, but which can result in
> > > > indefinite-duration grace periods.
> > >
> > > Is that really a problem in practise? For RCU updates should happen
> > > rarely.
> > 
> > Yes.  Several people have run into serious problems on small-memory
> > machines under denial-of-service workloads.  Not pretty.
> >
> That is what I tell people at work: Dynamic memory allocation is _not_ a
> good thing in real-time embedded systems. They call be old fashioned when
> I say I want anything important pre-allocated in seperate pools. But it
> exactly avoids these kind of surprises, makes the system more
> deterministic and makes it easier to find leaks.

As always, depends on the situation.  Configuring all the separate
pools can be a bit on the painful side, right?  ;-)

> > [...]
> > > 
> > > Why bother? What is the overhead of checking relative to just doing the
> > > increment/decrement?
> > 
> > The increment of the per-CPU counter pair is likely to incur a cache miss,
> > and thus be orders of magnitude more expensive than the increment of
> > the variable in the task structure.  I did not propose this optimization
> > lightly.  ;-)
> > 
> > > I had another idea: Do it in the scheduler:
> > >   per_cpu_rcu_count += prev->rcu_read_count;
> > >   if(per_cpu_rcu_count==0) {
> > >      /* grace period encountered */
> > >   }
> > >   (do the task switch)
> > >   
> > >   per_cpu_rcu_count -= count->rcu_read_count;
> > > 
> > > Then per_cpu_rcu_count is the rcu-read-count for all tasks except the
> > > current. During schedule there is no current and therefore it is the total
> > > count.
> > 
> > One downside of this approach is that it would maximally expand the
> > RCU read-side critical sections -- one of the things we need is to
> > avoid holding onto memory longer than necessary, as noted above.
> > 
> > Also, what prevents a grace period from ending while a task is
> > preempted in an RCU read-side critical section?  Or are you intending
> > that synchronize_rcu() scan the task list as well as the per-CPU
> > counters?
>
> Eh, if a RCU task is preempted in a read-side CS there IS no grace period!
> The trick is to avoid having it haning there for too long (see my boosting
> mechanismen below).

There is not -supposed- to be a grace period in that case.

> > > > [...] 
> > > > 2.	#1 above, but use a seqlock to guard the counter selection in
> > > > 	rcu_read_lock().  One potential disadvantage of this approach
> > > > 	is that an extremely unlucky instance of rcu_read_lock() might
> > > > 	be indefinitely delayed by a series of counter flips.  I am
> > > > 	concerned that this might actually happen under low-memory
> > > > 	conditions.  Also requires memory barriers on the read side,
> > > > 	which we might be stuck with, but still hope to be able to
> > > > 	get rid of.  And the per-CPU counter manipulation must use
> > > > 	atomic instructions.
> > >
> > > Why not just use 
> > >  preempt_disable(); 
> > >  manipulate counters; 
> > >  preempt_enable();
> > > ??
> > 
> > Because we can race with the counter switch, which can happen on some
> > other CPU.  Therefore, preempt_disable() does not help with this race.
> 
> Well, the per-cpu counters should be truely per-cpu. I.e. all tasks must
> _only_ touch the counter on their current cpu. preempt_disable() prevents
> the migration of the current task, right?
>  
> > 
> > > > 3.	#1 above, but use per-CPU locks to guard the counter selection.
> > > > 	I don't like this any better than #2, worse, in fact, since it
> > > > 	requires expensive atomic instructions as well.
> > >
> > > local_irqs_disable() andor preempt_disable() should work as they counters
> > > are per-cpu, right?
> > 
> > Again, neither of these help with the race against the counter-switch,
> > which would likely be happening on some other CPU.
> As above :-)
> 
> > 
> > > Or see the alternative above: The counter is per task but latched to a
> > > per-cpu on schedule().
> > 
> > This could work (assuming that synchronize_rcu() scanned the task list
> > as well as the per-CPU counters), but again would extend grace periods
> > too long for small-memory machines subject to denial-of-service attacks.
> > 
> No, need to traverse the list. Again the syncronize_rcu() waits for all
> CPU to check their number _locally_. The task doing that can simply check
> it's the latched number as it knows it is not in a read-side CS.
> 
> > > [...] 
> > > I was playing around with it a little while back. I didn't sned a patch
> > > though as I didn't have time. It works on a UP machine but I don't have a
> > > SMP to test on :-(
> > 
> > There are some available from OSDL, right?  Or am I out of date here?
> Honestly, I can't remember if I mailed it to anyone. I only have the code
> on my home PC, which broke down. I am right now running off a backup. I
> have attached the patch to this mail. I don't have time to clean it up :-(
> I see it also includes code for a testing device trying where I try 
> to meassure the grace period.
> 
> > 
> > > The ingreedients are:
> > > 1) A per-cpu read-side counter, protected locally by preempt_disable().
> > 
> > In order to avoid too-long grace periods, you need a pair of counters.
> > If you only have a single counter, you can end up with a series of
> > RCU read-side critical-section preemptions resulting in the counter
> > never reaching zero, and thus the grace period never terminating.
> > Not good, especially in small-memory machines subject to denial-of-service
> > attacks.
> See the boosting trick below. That will do the trick.
> 
> > 
> > > 2) A task read-side counter (doesn't need protectection at all).
> > 
> > Yep.  Also a field in the task struct indicating which per-CPU counter
> > applies (unless the scheduler is managing this).
> No, it is _always_ the local CPU which alplies as I have tried to make 3)
> below (which isn't tested at all).
> > 
> > > 3) Tasks having non-zero read-side counter can't be migrated to other
> > > CPUs. That is to make the per-cpu counter truely per-cpu.
> > 
> > If CPU hotplug can be disallowed, then this can work.  Do we really want
> > to disallow CPU hotplug?  Especially given that some implementations
> > might want to use CPU hotplug to reduce power consumption?  There also
> > might be issues with tickless operation.
> > 
> Yeah, I noticed the hotplog code. What are the RT requirements for
> hotplugging? With 4) below it shouldn't be a problem to wait until all
> tasks ar out of the read-lock session.
> 
> A better alternative is to make migration work like this:
> 1) Deactive the task.
> 2) Make the target cpu increment it's rcu-counter.
> 3) Migrate the task.
> 4) Make the source cpu increment it's rcu-counter.
> Then you can safely migrate tasks preempted in read-side CS as well.
> Harder to code than my small hack, though.
> 
> > > 4) When the scheduler sees a SCHED_OTHER task with a rcu-read-counter>0 it
> > > boost the priority to the maximum non-RT priority such it will not be 
> > > preempted by other SCHED_OTHER tasks. This makes the  delay in
> > > syncronize_kernel() somewhat deterministic (it depends on how
> > > "deterministic" the RT tasks in the system are.)
> > 
> > But one would only want to do this boost if there was a synchronize_rcu()
> > waiting -and- if there is some reason to accelerate grace periods (e.g.,
> > low on memory), right?  If there is no reason to accelerate grace periods,
> > then extending them increases efficiency by amortizing grace-period
> > overhead over many updates.
> Well, I only do the boost if the task is actually preempted in the
> read-side CS - it should be relatively rare. I could make a check and
> only do the boost if their is an request for a grace-period set. BUT the
> problem is that when somebody requests a grace-period later on it would
> have to traverse the runqueue and boost the tasks in read-side CS. That
> sounds like more expensive, but one can only know that by testing....
> 
> > 
> > > I'll try to send you what I got when I get my computer at home back up.
> > > I have only testet id on my UP labtop, where it seems to run fine.
> > 
> > I look forward to seeing it!
> > 
> Attached here :-)

Thank you, see comments interspersed.

> > 							Thanx, Paul
> > 
> 
> Esben

> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/Makefile linux-2.6.12-rc1-RCU/Makefile
> --- Orig/linux-2.6.12-rc1/Makefile	Sun Mar 20 20:30:55 2005
> +++ linux-2.6.12-rc1-RCU/Makefile	Sun Mar 27 21:05:58 2005
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 12
> -EXTRAVERSION =-rc1
> +EXTRAVERSION =-rc1-RCU-SMP
>  NAME=Woozy Numbat
>  
>  # *DOCUMENTATION*
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/drivers/char/Kconfig linux-2.6.12-rc1-RCU/drivers/char/Kconfig
> --- Orig/linux-2.6.12-rc1/drivers/char/Kconfig	Sun Mar 20 20:31:03 2005
> +++ linux-2.6.12-rc1-RCU/drivers/char/Kconfig	Fri Mar 25 00:19:07 2005
> @@ -978,6 +978,13 @@
>  	  The mmtimer device allows direct userspace access to the
>  	  Altix system timer.
>  
> +
> +config RCU_TESTER
> +	tristate "Test device for testing RCU code."
> +	default n
> +	help
> +	  To help debugging the RCU code. Don't include this.
> +
>  source "drivers/char/tpm/Kconfig"
>  
>  endmenu
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/drivers/char/Makefile linux-2.6.12-rc1-RCU/drivers/char/Makefile
> --- Orig/linux-2.6.12-rc1/drivers/char/Makefile	Sun Mar 20 20:31:03 2005
> +++ linux-2.6.12-rc1-RCU/drivers/char/Makefile	Fri Mar 25 00:19:11 2005
> @@ -48,6 +48,8 @@
>  obj-$(CONFIG_VIOTAPE)		+= viotape.o
>  obj-$(CONFIG_HVCS)		+= hvcs.o
>  
> +obj-$(CONFIG_RCU_TESTER)	+= rcu_tester.o
> +
>  obj-$(CONFIG_PRINTER) += lp.o
>  obj-$(CONFIG_TIPAR) += tipar.o
>  
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/drivers/char/rcu_tester.c linux-2.6.12-rc1-RCU/drivers/char/rcu_tester.c
> --- Orig/linux-2.6.12-rc1/drivers/char/rcu_tester.c	Thu Jan  1 01:00:00 1970
> +++ linux-2.6.12-rc1-RCU/drivers/char/rcu_tester.c	Wed Mar 30 00:15:52 2005
> @@ -0,0 +1,120 @@
> +/*
> + * test device for testing RCU code
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +
> +#define RCU_TESTER_MINOR	 222
> +
> +#define RCU_TESTER_WRITE	4247
> +#define RCU_TESTER_READ 	4248
> +
> +#define ERCU_FAILED               35
> +
> +#ifndef notrace
> +#define notrace
> +#endif
> +
> +u64 notrace get_cpu_tick(void)
> +{
> +	u64 tsc;
> +#ifdef ARCHARM
> +	tsc = *oscr;
> +#else
> +	__asm__ __volatile__("rdtsc" : "=A" (tsc));
> +#endif
> +	return tsc;
> +}
> +
> +void notrace loop(int loops)
> +{
> +	int i;
> +
> +	for (i = 0; i < loops; i++)
> +		get_cpu_tick();
> +}
> +
> +static spinlock_t write_lock;
> +static int *protected_data = NULL;
> +
> +static int rcu_tester_open(struct inode *in, struct file *file)
> +{
> +	return 0;
> +}
> +
> +static long rcu_tester_ioctl(struct file *file,
> +			  unsigned int cmd, unsigned long args)
> +{
> +	switch(cmd) {
> +	case RCU_TESTER_READ: {
> +		int *dataptr, data1,data2;
> +		rcu_read_lock();
> +		dataptr = protected_data;
> +		data1 = *dataptr;
> +		loop(args);
> +		data2 = *dataptr;
> +		rcu_read_unlock();
> +		if(data1!=data2)
> +			return -ERCU_FAILED;
> +		else
> +			return 0; /* ok */
> +	}
> +	case RCU_TESTER_WRITE: {
> +		int *newdata, *olddata;
> +		newdata = kmalloc(sizeof(int), GFP_KERNEL);
> +		if(!newdata)
> +			return -ENOMEM;
> +
> +		spin_lock(&write_lock);
> +		olddata = rcu_dereference(protected_data);
> +		*newdata = *olddata + 1;
> +		rcu_assign_pointer(protected_data, newdata);
> +		spin_unlock(&write_lock);
> +		synchronize_kernel();
> +		kfree(olddata);
> +		return 0;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

Cute RCU test code!

You could get better coverage by switching between two different structs,
with each containing a pair of integers.

Initialize both, point to one of them.  Repeatedly do the following
in RCU_TESTER_WRITE:

1.	Point to the other struct.

2.	Wait for a grace period to elapse.

3.	Increment one of the integers in the not-pointed-to structure.

4.	Delay for some time.

5.	Increment the other integer in the not-pointed-to structure.

Then RCU_TESTER_READ can repeatedly dereference the pointer under RCU
protection, and compare the two integers.  If they differ, RCU's grace
period was not long enough.

> +
> +static struct file_operations rcu_tester_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= no_llseek,
> +	.unlocked_ioctl = rcu_tester_ioctl,
> +	.open		= rcu_tester_open,
> +};
> +
> +static struct miscdevice rcu_tester_dev =
> +{
> +	RCU_TESTER_MINOR,
> +	"rcu_tester",
> +	&rcu_tester_fops
> +};
> +
> +static int __init rcu_tester_init(void)
> +{
> +	if (misc_register(&rcu_tester_dev))
> +		return -ENODEV;
> +
> +	protected_data = kmalloc(sizeof(int), GFP_KERNEL);
> +	*protected_data = 0;
> +	
> +	spin_lock_init(&write_lock);
> +
> +	return 0;
> +}
> +
> +void __exit rcu_tester_exit(void)
> +{
> +	printk(KERN_INFO "rcu-tester device uninstalled\n");
> +	misc_deregister(&rcu_tester_dev);
> +}
> +
> +module_init(rcu_tester_init);
> +module_exit(rcu_tester_exit);
> +
> +MODULE_LICENSE("GPL");
> +
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/include/linux/init_task.h linux-2.6.12-rc1-RCU/include/linux/init_task.h
> --- Orig/linux-2.6.12-rc1/include/linux/init_task.h	Sun Mar 20 20:31:28 2005
> +++ linux-2.6.12-rc1-RCU/include/linux/init_task.h	Fri Mar 25 00:22:00 2005
> @@ -74,6 +74,7 @@
>  	.usage		= ATOMIC_INIT(2),				\
>  	.flags		= 0,						\
>  	.lock_depth	= -1,						\
> +	.rcu_read_lock_nesting = 0,				       	\
>  	.prio		= MAX_PRIO-20,					\
>  	.static_prio	= MAX_PRIO-20,					\
>  	.policy		= SCHED_NORMAL,					\
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/include/linux/rcupdate.h linux-2.6.12-rc1-RCU/include/linux/rcupdate.h
> --- Orig/linux-2.6.12-rc1/include/linux/rcupdate.h	Wed Mar  2 08:37:50 2005
> +++ linux-2.6.12-rc1-RCU/include/linux/rcupdate.h	Sun Mar 27 18:12:45 2005
> @@ -41,6 +41,8 @@
>  #include <linux/percpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/seqlock.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
>  
>  /**
>   * struct rcu_head - callback structure for use with RCU
> @@ -85,6 +87,7 @@
>   * curlist - current batch for which quiescent cycle started if any
>   */
>  struct rcu_data {
> +	int             active_readers;
>  	/* 1) quiescent state handling : */
>  	long		quiescbatch;     /* Batch # for grace period */
>  	int		passed_quiesc;	 /* User-mode/idle loop etc. */
> @@ -115,12 +118,14 @@
>  static inline void rcu_qsctr_inc(int cpu)
>  {
>  	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> -	rdp->passed_quiesc = 1;
> +	if(rdp->active_readers==0)
> +		rdp->passed_quiesc = 1;
>  }
>  static inline void rcu_bh_qsctr_inc(int cpu)
>  {
>  	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
> -	rdp->passed_quiesc = 1;
> +	if(rdp->active_readers==0)
> +		rdp->passed_quiesc = 1;
>  }

This seems to suffer from extended grace periods.  Or am I missing something?

>  static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
> @@ -183,14 +188,34 @@
>   *
>   * It is illegal to block while in an RCU read-side critical section.
>   */
> -#define rcu_read_lock()		preempt_disable()
> +static inline void rcu_read_lock(void)
> +{	
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> + 	__get_cpu_var(rcu_data).active_readers++;
> +	current->rcu_read_lock_nesting++;
> +	local_irq_restore(flags);
> +}
>  
>  /**
>   * rcu_read_unlock - marks the end of an RCU read-side critical section.
>   *
>   * See rcu_read_lock() for more information.
>   */
> -#define rcu_read_unlock()	preempt_enable()
> +static inline void rcu_read_unlock(void)
> +{
> +	unsigned long flags;
> +	int cpu;
> +
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	
> + 	per_cpu(rcu_data,cpu).active_readers--;
> +	current->rcu_read_lock_nesting--;
> +	rcu_qsctr_inc(cpu);
> +	local_irq_restore(flags);
> +}
>  
>  /*
>   * So where is rcu_write_lock()?  It does not exist, as there is no
> @@ -213,14 +238,34 @@
>   * can use just rcu_read_lock().
>   *
>   */
> -#define rcu_read_lock_bh()	local_bh_disable()
> +static inline void rcu_read_lock_bh(void)
> +{ 
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> + 	__get_cpu_var(rcu_bh_data).active_readers++;
> +	current->rcu_read_lock_nesting++;
> +	local_irq_restore(flags);
> +}
>  
>  /*
>   * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
>   *
>   * See rcu_read_lock_bh() for more information.
>   */
> -#define rcu_read_unlock_bh()	local_bh_enable()
> +static inline void rcu_read_unlock_bh(void)	
> +{ 
> +	unsigned long flags;
> +	int cpu;
> +
> +	local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	
> + 	per_cpu(rcu_bh_data,cpu).active_readers--;
> +	current->rcu_read_lock_nesting--;
> +	rcu_bh_qsctr_inc(cpu);
> +	local_irq_restore(flags);
> +}
>  
>  /**
>   * rcu_dereference - fetch an RCU-protected pointer in an
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/include/linux/sched.h linux-2.6.12-rc1-RCU/include/linux/sched.h
> --- Orig/linux-2.6.12-rc1/include/linux/sched.h	Sun Mar 20 20:31:29 2005
> +++ linux-2.6.12-rc1-RCU/include/linux/sched.h	Fri Mar 25 00:22:00 2005
> @@ -569,6 +569,9 @@
>  	unsigned long ptrace;
>  
>  	int lock_depth;		/* Lock depth */
> +	
> +	int rcu_read_lock_nesting; /* How many RCU read reagions the thread is 
> +				      in */
>  
>  	int prio, static_prio;
>  	struct list_head run_list;
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/init/main.c linux-2.6.12-rc1-RCU/init/main.c
> --- Orig/linux-2.6.12-rc1/init/main.c	Sun Mar 20 20:31:30 2005
> +++ linux-2.6.12-rc1-RCU/init/main.c	Fri Mar 25 13:36:26 2005
> @@ -688,8 +688,11 @@
>  	system_state = SYSTEM_RUNNING;
>  	numa_default_policy();
>  
> -	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> -		printk(KERN_WARNING "Warning: unable to open an initial console.\n");
> +	{
> +	  int res = sys_open((const char __user *) "/dev/console", O_RDWR, 0);
> +	  if(res<0)
> +	    printk(KERN_WARNING "Warning: unable to open an initial console.: retval=%d\n",res);
> +	}
>  
>  	(void) sys_dup(0);
>  	(void) sys_dup(0);
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/kernel/rcupdate.c linux-2.6.12-rc1-RCU/kernel/rcupdate.c
> --- Orig/linux-2.6.12-rc1/kernel/rcupdate.c	Wed Mar  2 08:37:30 2005
> +++ linux-2.6.12-rc1-RCU/kernel/rcupdate.c	Fri Mar 25 13:08:38 2005
> @@ -66,7 +66,10 @@
>  	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
>  
>  DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
> +EXPORT_PER_CPU_SYMBOL(rcu_data);
>  DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
> +EXPORT_PER_CPU_SYMBOL(rcu_bh_data);
> +
>  
>  /* Fake initialization required by compiler */
>  static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
> diff -Naur --exclude-from=diff_exclude Orig/linux-2.6.12-rc1/kernel/sched.c linux-2.6.12-rc1-RCU/kernel/sched.c
> --- Orig/linux-2.6.12-rc1/kernel/sched.c	Sun Mar 20 20:31:30 2005
> +++ linux-2.6.12-rc1-RCU/kernel/sched.c	Wed Mar 30 00:06:39 2005
> @@ -594,6 +594,9 @@
>  	if (rt_task(p))
>  		return p->prio;
>  
> +	if (p->rcu_read_lock_nesting)
> +		return MAX_RT_PRIO;
> +

Do you really want to do this priority boost unconditionally?
Seems like you would only want to if there are callbacks waiting
for a grace period when the system is low on memory.

Otherwise, how does boosting the priority help?

>  	bonus = CURRENT_BONUS(p) - MAX_BONUS / 2;
>  
>  	prio = p->static_prio - bonus;
> @@ -986,6 +989,9 @@
>  	if (unlikely(task_running(rq, p)))
>  		goto out_activate;
>  
> +	if (unlikely(p->rcu_read_lock_nesting))
> +		goto out_activate;
> +
>  #ifdef CONFIG_SCHEDSTATS
>  	schedstat_inc(rq, ttwu_cnt);
>  	if (cpu == this_cpu) {
> @@ -1644,6 +1650,8 @@
>  		return 0;
>  	if (!cpu_isset(this_cpu, p->cpus_allowed))
>  		return 0;
> +	if (p->rcu_read_lock_nesting)
> +		return 0;

Could you please add "p" to your "diff" command so that the function
is listed?

>  	/*
>  	 * Aggressive migration if:
> @@ -2633,6 +2641,7 @@
>  need_resched:
>  	preempt_disable();
>  	prev = current;
> +	  
>  	release_kernel_lock(prev);
>  need_resched_nonpreemptible:
>  	rq = this_rq();
> @@ -2675,6 +2684,7 @@
>  		else {
>  			if (prev->state == TASK_UNINTERRUPTIBLE)
>  				rq->nr_uninterruptible++;
> +
>  			deactivate_task(prev, rq);
>  		}
>  	}
> @@ -2710,6 +2720,17 @@
>  	}
>  
>  	array = rq->active;
> +
> +	if( unlikely(prev->rcu_read_lock_nesting) && 
> +	    prev->prio > MAX_RT_PRIO ) {
> +		prio_array_t *prev_array = prev->array;
> +		if(prev_array)
> +			dequeue_task(prev, prev_array);
> +		prev->prio = MAX_RT_PRIO;
> +		if(prev_array)
> +			enqueue_task_head(prev, prev_array);
> +	}
> +

Again, do you really want to boost priority unconditionally when in
an RCU read-side critical section?

>  	if (unlikely(!array->nr_active)) {
>  		/*
>  		 * Switch the active and expired arrays.

