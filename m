Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279631AbRKIH4y>; Fri, 9 Nov 2001 02:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279674AbRKIH4p>; Fri, 9 Nov 2001 02:56:45 -0500
Received: from mmohlmann.demon.nl ([212.238.27.16]:39176 "HELO
	brand.mmohlmann.demon.nl") by vger.kernel.org with SMTP
	id <S279631AbRKIH4i>; Fri, 9 Nov 2001 02:56:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: why reschedule a disabled tasklet?
Date: Fri, 9 Nov 2001 08:56:51 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011108163552.B7B0B231A4@brand.mmohlmann.demon.nl>
In-Reply-To: <20011108163552.B7B0B231A4@brand.mmohlmann.demon.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011109075636.53C13231A4@brand.mmohlmann.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 November 2001 17:36, Mathijs Mohlmann wrote:
> 	Attached is a patch i use to get my sparc LX to boot (against 2.4.14).
> Without it the SUN does not work. I'm not sure if this is the right way to
> fix it, but i fail to see way softirq should be raised again if there are
> no enabled  tasklets left. Am i missing anything?

	Oke, forget that last patch  :(

There is however -i feel- an issue to be addressed here. To clarify i wrote a 
module. Here it is:

#define MODULE
#include <linux/sched.h>
#include <linux/module.h>
#include <linux/interrupt.h>

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
	schedule_timeout(5*HZ); /* some time to do dummy_lockit */

	printk("bye\n");
}

When you insert this in a 2.4.x machine, the CPU ide time will go to 0%. (and 
your kernel will be tained ;). When the idletask is trying to boot your 
system, this is bad.

Looking at kernel/softirq.c tasklet_action:  i don't see:
	a)	why we have to retry to run a tasklet that is already runnning.
	b)	when a tasklet is disabled, why we immediately have to a
		__cpu_raise_softirq. This will starve the rest of the system.
		(we could consider doing __cpu_raise_softirq in tasklet_enable?)

IMHO the following patch will "fix" this. I was unable to test it on a SMP 
system, but my SUN4M is running 2.4.14 now!

	me


--- linux-2.4.14/kernel/softirq.c	Thu Nov  8 15:58:24 2001
+++ linux-sparc/kernel/softirq.c	Fri Nov  9 08:19:43 2001
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

