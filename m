Return-Path: <linux-kernel-owner+w=401wt.eu-S1030334AbWLTTwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWLTTwb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWLTTwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:52:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33604 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030334AbWLTTw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:52:29 -0500
Date: Wed, 20 Dec 2006 20:50:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1-rt15: BUG in __tasklet_action at kernel/softirq.c:568
Message-ID: <20061220195008.GB14316@elte.hu>
References: <e6babb600612180948n7820c038k148a5a514d541b2e@mail.gmail.com> <20061219175728.GA20262@elte.hu> <e6babb600612200437n6c5ff4d4lf86e60c309dd1b6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600612200437n6c5ff4d4lf86e60c309dd1b6e@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Robert Crocombe <rcrocomb@gmail.com> wrote:

> On 12/19/06, Ingo Molnar <mingo@elte.hu> wrote:
> >yeah. This is something that triggers very rarely on certain boxes. Not
> >fixed yet, and it's been around for some time.
> 
> Is there anything you would like me to do to help diagnose this?

to figure out what the bug is :-/ Below is the tasklet redesign patch - 
the bug must be in there somewhere.

	Ingo

---------------->
From: Ingo Molnar <mingo@elte.hu>

tasklet redesign: make it saner and make it easier to thread.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----
 include/linux/interrupt.h |   39 ++++++-----
 kernel/softirq.c          |  155 +++++++++++++++++++++++++++++++---------------
 2 files changed, 128 insertions(+), 66 deletions(-)

Index: linux/include/linux/interrupt.h
===================================================================
--- linux.orig/include/linux/interrupt.h
+++ linux/include/linux/interrupt.h
@@ -288,8 +288,9 @@ extern void wait_for_softirq(int softirq
      to be executed on some cpu at least once after this.
    * If the tasklet is already scheduled, but its excecution is still not
      started, it will be executed only once.
-   * If this tasklet is already running on another CPU (or schedule is called
-     from tasklet itself), it is rescheduled for later.
+   * If this tasklet is already running on another CPU, it is rescheduled
+     for later.
+   * Schedule must not be called from the tasklet itself (a lockup occurs)
    * Tasklet is strictly serialized wrt itself, but not
      wrt another tasklets. If client needs some intertask synchronization,
      he makes it with spinlocks.
@@ -314,15 +315,25 @@ struct tasklet_struct name = { NULL, 0, 
 enum
 {
 	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
-	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
+	TASKLET_STATE_RUN,	/* Tasklet is running (SMP only) */
+	TASKLET_STATE_PENDING	/* Tasklet is pending */
 };
 
-#ifdef CONFIG_SMP
+#define TASKLET_STATEF_SCHED	(1 << TASKLET_STATE_SCHED)
+#define TASKLET_STATEF_RUN	(1 << TASKLET_STATE_RUN)
+#define TASKLET_STATEF_PENDING	(1 << TASKLET_STATE_PENDING)
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
+static inline int tasklet_tryunlock(struct tasklet_struct *t)
+{
+	return cmpxchg(&t->state, TASKLET_STATEF_RUN, 0) == TASKLET_STATEF_RUN;
+}
+
 static inline void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_clear_bit(); 
@@ -334,9 +345,10 @@ static inline void tasklet_unlock_wait(s
 	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
 }
 #else
-#define tasklet_trylock(t) 1
-#define tasklet_unlock_wait(t) do { } while (0)
-#define tasklet_unlock(t) do { } while (0)
+# define tasklet_trylock(t)		1
+# define tasklet_tryunlock(t)		1
+# define tasklet_unlock_wait(t)		do { } while (0)
+# define tasklet_unlock(t)		do { } while (0)
 #endif
 
 extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));
@@ -369,17 +381,8 @@ static inline void tasklet_disable(struc
 	smp_mb();
 }
 
-static inline void tasklet_enable(struct tasklet_struct *t)
-{
-	smp_mb__before_atomic_dec();
-	atomic_dec(&t->count);
-}
-
-static inline void tasklet_hi_enable(struct tasklet_struct *t)
-{
-	smp_mb__before_atomic_dec();
-	atomic_dec(&t->count);
-}
+extern fastcall void tasklet_enable(struct tasklet_struct *t);
+extern fastcall void tasklet_hi_enable(struct tasklet_struct *t);
 
 extern void tasklet_kill(struct tasklet_struct *t);
 extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -463,14 +463,24 @@ struct tasklet_head
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec) = { NULL };
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
 
+static void inline
+__tasklet_common_schedule(struct tasklet_struct *t, struct tasklet_head *head, unsigned int nr)
+{
+	if (tasklet_trylock(t)) {
+		WARN_ON(t->next != NULL);
+		t->next = head->list;
+		head->list = t;
+		raise_softirq_irqoff(nr);
+		tasklet_unlock(t);
+	}
+}
+
 void fastcall __tasklet_schedule(struct tasklet_struct *t)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = __get_cpu_var(tasklet_vec).list;
-	__get_cpu_var(tasklet_vec).list = t;
-	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_vec), TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -481,81 +491,130 @@ void fastcall __tasklet_hi_schedule(stru
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = __get_cpu_var(tasklet_hi_vec).list;
-	__get_cpu_var(tasklet_hi_vec).list = t;
-	raise_softirq_irqoff(HI_SOFTIRQ);
+	__tasklet_common_schedule(t, &__get_cpu_var(tasklet_hi_vec), HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
-static void tasklet_action(struct softirq_action *a)
+void fastcall tasklet_enable(struct tasklet_struct *t)
 {
-	struct tasklet_struct *list;
+	if (!atomic_dec_and_test(&t->count))
+		return;
+	if (test_and_clear_bit(TASKLET_STATE_PENDING, &t->state))
+		tasklet_schedule(t);
+}
 
-	local_irq_disable();
-	list = __get_cpu_var(tasklet_vec).list;
-	__get_cpu_var(tasklet_vec).list = NULL;
-	local_irq_enable();
+EXPORT_SYMBOL(tasklet_enable);
+
+void fastcall tasklet_hi_enable(struct tasklet_struct *t)
+{
+	if (!atomic_dec_and_test(&t->count))
+		return;
+	if (test_and_clear_bit(TASKLET_STATE_PENDING, &t->state))
+		tasklet_hi_schedule(t);
+}
+
+EXPORT_SYMBOL(tasklet_hi_enable);
+
+static void
+__tasklet_action(struct softirq_action *a, struct tasklet_struct *list)
+{
+	int loops = 1000000;
 
 	while (list) {
 		struct tasklet_struct *t = list;
 
 		list = list->next;
+		/*
+		 * Should always succeed - after a tasklist got on the
+		 * list (after getting the SCHED bit set from 0 to 1),
+		 * nothing but the tasklet softirq it got queued to can
+		 * lock it:
+		 */
+		if (!tasklet_trylock(t)) {
+			WARN_ON(1);
+			continue;
+		}
+
+		t->next = NULL;
+
+		/*
+		 * If we cannot handle the tasklet because it's disabled,
+		 * mark it as pending. tasklet_enable() will later
+		 * re-schedule the tasklet.
+		 */
+		if (unlikely(atomic_read(&t->count))) {
+out_disabled:
+			/* implicit unlock: */
+			wmb();
+			t->state = TASKLET_STATEF_PENDING;
+			continue;
+		}
 
-		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
-				t->func(t->data);
+		/*
+		 * After this point on the tasklet might be rescheduled
+		 * on another CPU, but it can only be added to another
+		 * CPU's tasklet list if we unlock the tasklet (which we
+		 * dont do yet).
+		 */
+		if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+			WARN_ON(1);
+
+again:
+		t->func(t->data);
+
+		/*
+		 * Try to unlock the tasklet. We must use cmpxchg, because
+		 * another CPU might have scheduled or disabled the tasklet.
+		 * We only allow the STATE_RUN -> 0 transition here.
+		 */
+		while (!tasklet_tryunlock(t)) {
+			/*
+			 * If it got disabled meanwhile, bail out:
+			 */
+			if (atomic_read(&t->count))
+				goto out_disabled;
+			/*
+			 * If it got scheduled meanwhile, re-execute
+			 * the tasklet function:
+			 */
+			if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+				goto again;
+			if (!--loops) {
+				printk("hm, tasklet state: %08lx\n", t->state);
+				WARN_ON(1);
 				tasklet_unlock(t);
-				continue;
+				break;
 			}
-			tasklet_unlock(t);
 		}
-
-		local_irq_disable();
-		t->next = __get_cpu_var(tasklet_vec).list;
-		__get_cpu_var(tasklet_vec).list = t;
-		__do_raise_softirq_irqoff(TASKLET_SOFTIRQ);
-		local_irq_enable();
 	}
 }
 
-static void tasklet_hi_action(struct softirq_action *a)
+static void tasklet_action(struct softirq_action *a)
 {
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = __get_cpu_var(tasklet_hi_vec).list;
-	__get_cpu_var(tasklet_hi_vec).list = NULL;
+	list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
 	local_irq_enable();
 
-	while (list) {
-		struct tasklet_struct *t = list;
+	__tasklet_action(a, list);
+}
 
-		list = list->next;
+static void tasklet_hi_action(struct softirq_action *a)
+{
+	struct tasklet_struct *list;
 
-		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
-					BUG();
-				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
-			}
-			tasklet_unlock(t);
-		}
+	local_irq_disable();
+	list = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = NULL;
+	local_irq_enable();
 
-		local_irq_disable();
-		t->next = __get_cpu_var(tasklet_hi_vec).list;
-		__get_cpu_var(tasklet_hi_vec).list = t;
-		__do_raise_softirq_irqoff(HI_SOFTIRQ);
-		local_irq_enable();
-	}
+	__tasklet_action(a, list);
 }
 
-
 void tasklet_init(struct tasklet_struct *t,
 		  void (*func)(unsigned long), unsigned long data)
 {
