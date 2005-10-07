Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVJGNds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVJGNds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJGNds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:33:48 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:41864 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932559AbVJGNdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:33:47 -0400
Message-ID: <43467C2B.14D992B4@tv-sign.ru>
Date: Fri, 07 Oct 2005 17:46:19 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix do_coredump() vs SIGSTOP race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's suppose we have 2 threads in thread group:
	A - does coredump
	B - has pending SIGSTOP

thread A						thread B

do_coredump:						get_signal_to_deliver:

  lock(->sighand)
  ->signal->flags = SIGNAL_GROUP_EXIT
  unlock(->sighand)

							lock(->sighand)
							signr = dequeue_signal()
								->signal->flags |= SIGNAL_STOP_DEQUEUED
								return SIGSTOP;

							do_signal_stop:
							    unlock(->sighand)

  coredump_wait:

      zap_threads:
          lock(tasklist_lock)
          send SIGKILL to B
              // signal_wake_up() does nothing
          unlock(tasklist_lock)

							    lock(tasklist_lock)
							    lock(->sighand)
							    re-check sig->flags & SIGNAL_STOP_DEQUEUED, yes
							    set_current_state(TASK_STOPPED);
							    finish_stop:
							        schedule();
							            // ->state == TASK_STOPPED

      wait_for_completion(&startup_done)
         // waits for complete() from B,
         // ->state == TASK_UNINTERRUPTIBLE



We can't wake up 'B' in any way:

	SIGCONT will be ignored because handle_stop_signal() sees
	->signal->flags & SIGNAL_GROUP_EXIT.

	sys_kill(SIGKILL)->__group_complete_signal() will choose
	uninterruptible 'A', so it can't help.

	sys_tkill(B, SIGKILL) will be ignored by specific_send_sig_info()
	because B already has pending SIGKILL.


This scenario is not possbile if 'A' does do_group_exit(), because
it sets sig->flags = SIGNAL_GROUP_EXIT and delivers SIGKILL to
subthreads atomically, holding both tasklist_lock and sighand->lock.
That means that do_signal_stop() will notice !SIGNAL_STOP_DEQUEUED
after re-locking ->sighand. And it is not possible to any other
thread to re-add SIGNAL_STOP_DEQUEUED later, because dequeue_signal()
can only return SIGKILL.

I think it is better to change do_coredump() to do sigaddset(SIGKILL)
and signal_wake_up() under sighand->lock, but this patch is much
simpler.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc3/kernel/signal.c~	2005-10-01 17:01:52.000000000 +0400
+++ 2.6.14-rc3/kernel/signal.c	2005-10-07 21:31:56.000000000 +0400
@@ -578,7 +578,8 @@ int dequeue_signal(struct task_struct *t
  		 * is to alert stop-signal processing code when another
  		 * processor has come along and cleared the flag.
  		 */
- 		tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
+ 		if (!(tsk->signal->flags & SIGNAL_GROUP_EXIT))
+ 			tsk->signal->flags |= SIGNAL_STOP_DEQUEUED;
  	}
 	if ( signr &&
 	     ((info->si_code & __SI_MASK) == __SI_TIMER) &&
