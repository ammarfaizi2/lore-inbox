Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKREcM>; Fri, 17 Nov 2000 23:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKREcC>; Fri, 17 Nov 2000 23:32:02 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:56485 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129091AbQKREbu>; Fri, 17 Nov 2000 23:31:50 -0500
Message-ID: <3A15FF3F.9692D272@uow.edu.au>
Date: Sat, 18 Nov 2000 15:02:07 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] potential death in disassociate_ctty()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The call to disassociate_ctty() in exit_notify() is very dangerous.  If
disassociate_ctty() calls schedule() then either:

- a parent process who is spinning in fork.c:release() will stop
  spinning and will proceed to deallocate the child process's kernel
  stack.  This will probably have adverse effects when it is rewoken.

- Or, if disassociate_ctty() sets current->state to TASK_RUNNING and
  the timing is right, the exitting child will no longer be in state
  TASK_ZOMBIE and will continue to run.  It hits the fake_volatile goto
  in do_exit() and has another go at zombifying itself.

  Not sure what happens next, but you end up with every process
  sleeping and your machine freezes halfway through your initscripts.

Basically, we mustn't sleep in disassociate_ctty().  But this function
does all sorts of things, inclusing calling the open and close methods
of tty drivers and ldisc drivers.  They _do_ call functions which can
sleep.

I think it's safer to not call disassociate_ctty() when we're in state
TASK_ZOMBIE.  This patch moves the parent notification and the task
state change to _after_ the call to disassociate_ctty().  As an added
bonus, it's a little more efficient: the later we wake the parent, the
less time the parent has to spend spinning on current->has_cpu.

I'm not particularly confident about this one.  What are the effects of
moving the call to do_notify_parent()? None, I think - if it mattered
we'd be racy anyway.

Also, somewhere on the path from kernel 2.2 to 2.4 the call to
do_notify_parent() was moved inside the tasklist lock.  Why was this?
It seems unnecessary.  This patch backs out that change, perhaps
wrongly...



--- linux-2.4.0-test11-pre7/kernel/exit.c	Sat Nov 18 13:55:32 2000
+++ linux-akpm/kernel/exit.c	Sat Nov 18 14:37:39 2000
@@ -382,7 +382,6 @@
 	 */
 
 	write_lock_irq(&tasklist_lock);
-	do_notify_parent(current, current->exit_signal);
 	while (current->p_cptr != NULL) {
 		p = current->p_cptr;
 		current->p_cptr = p->p_osptr;
@@ -418,6 +417,10 @@
 
 	if (current->leader)
 		disassociate_ctty(1);
+
+	/* From now on, we must not sleep */
+	set_current_state(TASK_ZOMBIE);
+	do_notify_parent(current, current->exit_signal);
 }
 
 NORET_TYPE void do_exit(long code)
@@ -444,7 +447,6 @@
 	__exit_fs(tsk);
 	exit_sighand(tsk);
 	exit_thread();
-	tsk->state = TASK_ZOMBIE;
 	tsk->exit_code = code;
 	exit_notify();
 	put_exec_domain(tsk->exec_domain);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
