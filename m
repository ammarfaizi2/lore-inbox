Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRG1Avz>; Fri, 27 Jul 2001 20:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266093AbRG1Avq>; Fri, 27 Jul 2001 20:51:46 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:41859 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266067AbRG1Ave>; Fri, 27 Jul 2001 20:51:34 -0400
Message-Id: <4.3.1.0.20010727141716.05651ac0@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Fri, 27 Jul 2001 17:52:01 -0700
To: kuznet@ms2.inr.ac.ru
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
Cc: andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, mingo@redhat.com
In-Reply-To: <200107271935.XAA27068@ms2.inr.ac.ru>
In-Reply-To: <4.3.1.0.20010727121014.055d4c90@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> > Also don't you agree with that it's possible (at least in theory) to hit that trylock/BUG in tasklet_action ?
>
>Alas, I am not an expert in this area after Ingo's patch. Let's learn
>together. At first sight, it must crash at this BUG() instead of serialization, indeed. :-)
>
>I am still afraid to boot kernels after 2.4.5. Feel discomfort. :-)
You have a very valid reasons for this :). 
I just tried 2.4.5 and guess what, it works _correctly_ e.g. it does not run same tasklet on several cpus.

I looked at the tasklet_schedule and friends. And what I found surprised me quite a bit. How did it went in ;)
Somebody misunderstood the purpose of the STATE_RUN (tasklet_trylock/unlock) and STATE_SCHED bits.
Here is how it should work (Alex correct me if I'm wrong here).
Purpose of STATE_SCHED is to protect tasklet from being _scheduled_ on the several cpus at the same time. 
When we run a tasklet we unlink it from the queue and clear STATE_SCHED to allow it to be scheduled again.
Purpose of STATE_RUN is to protect tasklet from being _run_ on the several cpu at the same time.
Before we run a tasklet we set STATE_RUN (tasklet_trylock) and we clear STATE_RUN(tasklet_unlock) when 
we're done with this tasklet.
In other word we run tasklet with STATE_RUN set (locked tasklet) but with STATE_SCHED cleared.

In 2.4.7 and 2.4.8pre1 (and probably in 2.4.6) 
tasklet_schedule calls tasklet_unlock after it schedules tasklet, which is _totaly_ wrong.
(that's why I was not hitting that trylock/BUG in tasklet_action)
tasklet_action assumes that if we found locked tasklet in our sched queue it's a BUG which is again wrong. 
Locked tasklet in the sched queue is prefectly fine, it just means that tasklet is still running on other cpu and we 
should just reschedule it (and that's what original code does btw).

Also I think uninlining tasklet_schedule was not a good idea. It's kinda critical especially for already scheduled case.
We make a function call just to find out that tasklet is already scheduled.  And there is no point in call disable_irq if
we're not gonna schedule tasklet. And there is no point in locking tasklet on the UP machines.

So, the patch (Alex you can safely boot latest kernels now :)). It restores original (correct) functionality and makes tasklet 
code a little more readable. It also includes patch to tasklet_enable/disable suggested by Andrea. 
Tested on my dual PPro SMP box, PII UP and Sparc64 UP.

Linus, please consider applying it because current code is _broken_.
(http://bluez.sf.net/tasklet_patch.gz in case my mailer messed it up)

Thanks
Max

--- linux/kernel/softirq.c.old  Fri Jul 27 17:19:52 2001
+++ linux/kernel/softirq.c      Fri Jul 27 15:57:50 2001
@@ -140,43 +140,7 @@
  /* Tasklets */
  
  struct tasklet_head tasklet_vec[NR_CPUS] __cacheline_aligned;
-
-void tasklet_schedule(struct tasklet_struct *t)
-{
-       unsigned long flags;
-       int cpu;
-
-       cpu = smp_processor_id();
-       local_irq_save(flags);
-       /*
-        * If nobody is running it then add it to this CPU's
-        * tasklet queue.
-        */
-       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-               t->next = tasklet_vec[cpu].list;
-               tasklet_vec[cpu].list = t;
-               cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
-               tasklet_unlock(t);
-       }
-       local_irq_restore(flags);
-}
-
-void tasklet_hi_schedule(struct tasklet_struct *t)
-{
-       unsigned long flags;
-       int cpu;
-
-       cpu = smp_processor_id();
-       local_irq_save(flags);
-
-       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-               t->next = tasklet_hi_vec[cpu].list;
-               tasklet_hi_vec[cpu].list = t;
-               cpu_raise_softirq(cpu, HI_SOFTIRQ);
-               tasklet_unlock(t);
-       }
-       local_irq_restore(flags);
-}
+struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
  
  static void tasklet_action(struct softirq_action *a)
  {
@@ -193,16 +157,16 @@
  
                 list = list->next;
  
-               if (!tasklet_trylock(t))
-                       BUG();
-               if (!atomic_read(&t->count)) {
-                       if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-                               BUG();
-                       t->func(t->data);
+               if (tasklet_trylock(t)) {
+                       if (!atomic_read(&t->count)) {
+                               if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+                                       BUG();
+                               t->func(t->data);
+                               tasklet_unlock(t);
+                               continue;
+                       }
                         tasklet_unlock(t);
-                       continue;
                 }
-               tasklet_unlock(t);
  
                 local_irq_disable();
                 t->next = tasklet_vec[cpu].list;
@@ -212,10 +176,6 @@
         }
  }
  
-
-
-struct tasklet_head tasklet_hi_vec[NR_CPUS] __cacheline_aligned;
-
  static void tasklet_hi_action(struct softirq_action *a)
  {
         int cpu = smp_processor_id();
@@ -231,16 +191,16 @@
  
                 list = list->next;
  
-               if (!tasklet_trylock(t))
-                       BUG();
-               if (!atomic_read(&t->count)) {
-                       if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-                               BUG();
-                       t->func(t->data);
+               if (tasklet_trylock(t)) {
+                       if (!atomic_read(&t->count)) {
+                               if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+                                       BUG();
+                               t->func(t->data);
+                               tasklet_unlock(t);
+                               continue;
+                       }
                         tasklet_unlock(t);
-                       continue;
                 }
-               tasklet_unlock(t);
  
                 local_irq_disable();
                 t->next = tasklet_hi_vec[cpu].list;
@@ -249,7 +209,6 @@
                 local_irq_enable();
         }
  }
-
  
  void tasklet_init(struct tasklet_struct *t,
                   void (*func)(unsigned long), unsigned long data)
--- linux/include/linux/interrupt.h.old Fri Jul 27 17:20:11 2001
+++ linux/include/linux/interrupt.h     Fri Jul 27 17:26:37 2001
@@ -114,49 +114,93 @@
  #define DECLARE_TASKLET_DISABLED(name, func, data) \
  struct tasklet_struct name = { NULL, 0, ATOMIC_INIT(1), func, data }
  
+#define        TASKLET_STATE_SCHED 0x01        /* Tasklet is scheduled for execution */
+#define        TASKLET_STATE_RUN   0x02        /* Tasklet is running */
  
-enum
+struct tasklet_head {
+       struct tasklet_struct *list;
+} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
+
+extern  struct tasklet_head tasklet_vec[NR_CPUS];
+extern  struct tasklet_head tasklet_hi_vec[NR_CPUS];
+
+#ifdef CONFIG_SMP
+static inline int tasklet_trylock(struct tasklet_struct *t)
  {
-       TASKLET_STATE_SCHED,    /* Tasklet is scheduled for execution */
-       TASKLET_STATE_RUN       /* Tasklet is running */
-};
+       return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
+}
  
-struct tasklet_head
+static inline void tasklet_unlock(struct tasklet_struct *t)
  {
-       struct tasklet_struct *list;
-} __attribute__ ((__aligned__(SMP_CACHE_BYTES)));
+       smp_mb__before_clear_bit(); 
+       clear_bit(TASKLET_STATE_RUN, &(t)->state);
+}
  
-extern struct tasklet_head tasklet_vec[NR_CPUS];
-extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
+static inline void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+       while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+}
+#else
+#define tasklet_trylock(t) 1
+#define tasklet_unlock_wait(t)
+#define tasklet_unlock(t)
+#endif
+
+static inline void tasklet_schedule(struct tasklet_struct *t)
+{
+       unsigned long flags;
+       int cpu;
+
+       cpu = smp_processor_id();
+
+       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+               local_irq_save(flags);
+               t->next = tasklet_vec[cpu].list;
+               tasklet_vec[cpu].list = t;
+               cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+               local_irq_restore(flags);
+       }
+}
  
-#define tasklet_trylock(t) (!test_and_set_bit(TASKLET_STATE_RUN, &(t)->state))
-#define tasklet_unlock(t) do { smp_mb__before_clear_bit(); clear_bit(TASKLET_STATE_RUN, &(t)->state); } while(0)
-#define tasklet_unlock_wait(t) while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+static inline void tasklet_hi_schedule(struct tasklet_struct *t)
+{
+       unsigned long flags;
+       int cpu;
+
+       cpu = smp_processor_id();
  
-extern void tasklet_schedule(struct tasklet_struct *t);
-extern void tasklet_hi_schedule(struct tasklet_struct *t);
+       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+               local_irq_save(flags);
+               t->next = tasklet_hi_vec[cpu].list;
+               tasklet_hi_vec[cpu].list = t;
+               cpu_raise_softirq(cpu, HI_SOFTIRQ);
+               local_irq_restore(flags);
+       }
+}
  
  static inline void tasklet_disable_nosync(struct tasklet_struct *t)
  {
         atomic_inc(&t->count);
+       smp_mb__after_atomic_inc();
  }
  
  static inline void tasklet_disable(struct tasklet_struct *t)
  {
         tasklet_disable_nosync(t);
         tasklet_unlock_wait(t);
+       smp_mb();
  }
  
  static inline void tasklet_enable(struct tasklet_struct *t)
  {
-       if (atomic_dec_and_test(&t->count))
-               tasklet_schedule(t);
+       smp_mb__before_atomic_dec();
+       atomic_dec(&t->count);
  }
  
  static inline void tasklet_hi_enable(struct tasklet_struct *t)
  {
-       if (atomic_dec_and_test(&t->count))
-               tasklet_hi_schedule(t);
+       smp_mb__before_atomic_dec();
+       atomic_dec(&t->count);
  }
  
  extern void tasklet_kill(struct tasklet_struct *t);

-----------------



  


Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

