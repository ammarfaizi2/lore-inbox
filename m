Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280620AbRKJMV6>; Sat, 10 Nov 2001 07:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280624AbRKJMVt>; Sat, 10 Nov 2001 07:21:49 -0500
Received: from mmohlmann.demon.nl ([212.238.27.16]:12548 "HELO
	brand.mmohlmann.demon.nl") by vger.kernel.org with SMTP
	id <S280623AbRKJMVp>; Sat, 10 Nov 2001 07:21:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: andrea@suse.de, jgarzik@mandrakesoft.com
Subject: [PATCH] fix loop with disabled tasklets
Date: Sat, 10 Nov 2001 13:21:56 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011110122141.B2C68231A4@brand.mmohlmann.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I have a questions about the current softirq implementation.

Looking at kernel/softirq.c:418 and futher. When the tasklet is disabled it 
is rescheduled. This is fine, but __cpu_raise_softirq is also called. This 
means that ksoftirqd will loop until the tasklet is enabled. 
Normaly this is no biggy, because user processes still come through.
But during boot -when the tasklet_enable is yet to be called by "the idle 
thread"- the system will lockup. This happens during the boot of my sun4m 
with the keyboard tasklet.

To demonstrate, i wrote a module. Inserting this will result in 0% idle time. 
Inserting this with the below patch, the system simply goes on.

If this really is an issue, this patch fixes it. It does change the current
behavior a bit though. Currently when a tasklet is run while it is already
running on a different cpu, the task is rescheduled. This results in the 
tasklet being executed two times. With this patch applied, it will not. (this 
is still good according to kernel/include/interrups.h:83 and futher).

	i'm not sure about the enable_tasklet bit. I think it will prevent
people from calling tasklet_enable from within an interrupt handler. But then
again, why do you want to do that? Thanx, velco and
	
	Any comments?

	me

#define MODULE
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/interrupt.h>

MODULE_LICENSE("GPL");

void
dummy_lockit(unsigned long nill)
{
	printk("doing the lockit\n");
	return;
}

DECLARE_TASKLET_DISABLED(lockit, dummy_lockit, 0);
int
init_module(void)
{
	printk("going to lock\n");
	tasklet_schedule(&lockit);
	return(0);
}

void
cleanup_module(void)
{
	tasklet_enable(&lockit);
	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(HZ); /* some time to do dummy_lockit */

	printk("bye\n");
}


diff -ruN linux-2.4.14/include/linux/interrupt.h 
linux/include/linux/interrupt.h
--- linux-2.4.14/include/linux/interrupt.h	Sat Nov  3 11:20:41 2001
+++ linux/include/linux/interrupt.h	Sat Nov 10 12:28:14 2001
@@ -185,13 +185,15 @@
 static inline void tasklet_enable(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic_dec();
-	atomic_dec(&t->count);
+	if (atomic_dec_and_test(&t->count))
+		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 }
 
 static inline void tasklet_hi_enable(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic_dec();
-	atomic_dec(&t->count);
+	if (atomic_dec_and_test(&t->count))
+		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
diff -ruN linux-2.4.14/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.4.14/kernel/softirq.c	Thu Nov  8 15:58:24 2001
+++ linux/kernel/softirq.c	Sat Nov 10 12:27:24 2001
@@ -188,21 +188,19 @@
 
 		list = list->next;
 
-		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
+		if (!atomic_read(&t->count)) {
+			if (tasklet_trylock(t)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
 				t->func(t->data);
 				tasklet_unlock(t);
-				continue;
 			}
-			tasklet_unlock(t);
+			continue;
 		}
 
 		local_irq_disable();
 		t->next = tasklet_vec[cpu].list;
 		tasklet_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
 }
@@ -222,21 +220,19 @@
 
 		list = list->next;
 
-		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
+		if (!atomic_read(&t->count)) {
+			if (tasklet_trylock(t)) {
 				if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
 					BUG();
 				t->func(t->data);
 				tasklet_unlock(t);
-				continue;
 			}
-			tasklet_unlock(t);
+			continue;
 		}
 
 		local_irq_disable();
 		t->next = tasklet_hi_vec[cpu].list;
 		tasklet_hi_vec[cpu].list = t;
-		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
 		local_irq_enable();
 	}
 }
