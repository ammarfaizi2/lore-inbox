Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRCIO0B>; Fri, 9 Mar 2001 09:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRCIOZv>; Fri, 9 Mar 2001 09:25:51 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:50148 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130510AbRCIOZq>; Fri, 9 Mar 2001 09:25:46 -0500
Message-ID: <3AA8E7D7.9805ABF7@uow.edu.au>
Date: Sat, 10 Mar 2001 01:25:27 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] printk.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan.

Seems that Vibol's BUG() in call_console_drivers() was caused
by:

1: Task A takes console_sem
2: Task B is running
3: NMI watchdog fires, resets console_sem, kills Task B
4: Task A releases console_sem - sem.count goes to 2.
5: Task C takes console_sem, sees that it's still free,
   goes BUG().

It would have been fine if the watchdog had killed task A.
That's what it does in all my testing :(

If we had real mutexes rather than up/down counting semaphores, or
if there was a cross-architecture unracy way of setting
a semaphore's count to 1 without zapping all its other
members then the fix is straightforward.

Solutions to this are so arcane I don't think it's worth
trying.  The best approach is to simply remove the BUG
checks.  So if the above scenario occurs, the console drivers
won't have locking after the crash.  The user will still be
able to resync and reboot.

They need to come out anyway - when it fails, down_trylock()
is fairly expensive and locky - it does a wake_up() in the
contended case.


--- linux-2.4.2-ac16/kernel/printk.c	Fri Mar  9 17:11:18 2001
+++ linux-ac/kernel/printk.c	Fri Mar  9 22:47:39 2001
@@ -321,12 +321,6 @@
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
-	/* Check that the semaphore is held */
-	if (down_trylock(&console_sem) == 0) {
-		up(&console_sem);
-		BUG();
-	}
-
 	if (((long)(start - end)) > 0)
 		BUG();
 
@@ -516,11 +510,6 @@
 void console_conditional_schedule(void)
 {
 	if (console_may_schedule && current->need_resched) {
-		/* Check that the semaphore is held */
-		if (down_trylock(&console_sem) == 0) {
-			up(&console_sem);
-			BUG();
-		}
 		set_current_state(TASK_RUNNING);
 		schedule();
 	}
