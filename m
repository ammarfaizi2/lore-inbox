Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWDKH1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWDKH1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 03:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWDKH1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 03:27:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932224AbWDKH1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 03:27:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
In-Reply-To: Oleg Nesterov's message of  Monday, 10 April 2006 21:43:46 +0400 <20060410174346.GA100@oleg>
X-Windows: the cutting edge of obsolescence.
Message-Id: <20060411072722.0953A1809BB@magilla.sf.frob.com>
Date: Tue, 11 Apr 2006 00:27:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, de_thread() sets SIGNAL_GROUP_EXEC and sends SIGKILL to other thereads.
> 
> Sub-thread receives the signal, and calls get_signal_to_deliver->do_group_exit.
> do_group_exit() calls zap_other_threads(SIGNAL_GROUP_EXIT) because there is no
> SIGNAL_GROUP_EXIT set. zap_other_threads() notices SIGNAL_GROUP_EXEC, wakes up
> execer, and changes ->signal->flags to SIGNAL_GROUP_EXIT.
> 
> de_thread() re-locks sighand, sees !SIGNAL_GROUP_EXEC and goes to 'dying:'.

That is what I intend.  The exec'ing thread backs out and processes its SIGKILL.
It sounds like you are calling this scenario a problem, but I don't know why.

> Another problem. de_thread() sets '->group_exit_task = current' _only_ if
> 'atomic_read(&sig->count) > count', so wake_up_process(->group_exit_task)
> in zap_other_threads() is unsafe.

Ah, this is indeed a problem when the only other thread is the old leader.
I think it's easy enough just to set it unconditionally and clear it at the
end, after the leader too is gone.  i.e., this on top of the previous patch:

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -659,8 +659,8 @@ static int de_thread(struct task_struct 
 			goto dying;
 		}
 	}
+	sig->group_exit_task = current;
 	while (atomic_read(&sig->count) > count) {
-		sig->group_exit_task = current;
 		sig->notify_count = count;
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(lock);
@@ -675,7 +675,6 @@ static int de_thread(struct task_struct 
 			goto dying;
 		}
 	}
-	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
 	spin_unlock_irq(lock);
 
@@ -774,6 +773,7 @@ static int de_thread(struct task_struct 
 	 * but it's safe to stop telling the group to kill themselves.
 	 */
 	sig->flags = 0;
+	sig->group_exit_task = NULL;
 
 no_thread_group:
 	exit_itimers(sig);



Thanks,
Roland
