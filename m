Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVJBBMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVJBBMW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 21:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVJBBMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 21:12:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51604 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750932AbVJBBMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 21:12:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
In-Reply-To: Linus Torvalds's message of  Friday, 30 September 2005 10:18:02 -0700 <Pine.LNX.4.64.0509301006580.3378@g5.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: (setq software-quality (/ 1 number-of-authors))
Message-Id: <20051002011201.D40A3180E23@magilla.sf.frob.com>
Date: Sat,  1 Oct 2005 18:12:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It looks like "WSTOPPED | WNOWAIT is illegal for TASK_TRACED child"
> > to me. Is this correct? I think no.
> 
> No, I think it's correct. If you have a traced child, you can't just wait 
> for it. You need to use ptrace to release it first.

That's correct.  If your child is in TASK_TRACED because someone else is
ptrace'ing it, then you don't notice its state.

> > Actually, I don't understand why we are checking p->state at all, we
> > already dropped tasklist_lock, the state can change at any monent.
> 
> If it's TASK_TRACED, and it's our child, then it shouldn't be changing. 

Actually, it can in two cases.  First is SIGKILL, which can always wake it
up suddenly.  The second is when we are not the actual ptrace parent, but
another thread in the same thread group.  (do_wait loops on all the threads
in the group and checks each one's children list.  my_ptrace_child does not
distinguish the ptracer from other threads in its group.)

> Besides, even if it does, we had a perfectly fine race, and we'll have 
> been woken up again and we'll just go through the do_wait() loop once 
> more.
>
> So I think the code is mostly correct. But that ">" is definitely 
> incorrect.

Indeed.  I failed to notice this > test when the other just came up recently,
because I had a change to it kicking around in my tree for a long time.
I can't honestly recall and would have to reconstruct why I wrote it this way.
The simple change Linus suggested seems fine too, probably better.


Thanks,
Roland


--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1199,14 +1188,15 @@ static int wait_task_stopped(task_t *p, 
 	if (unlikely(noreap)) {
 		pid_t pid = p->pid;
 		uid_t uid = p->uid;
-		int why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
+		int state = p->state;
 
 		exit_code = p->exit_code;
-		if (unlikely(!exit_code) ||
-		    unlikely(p->state > TASK_STOPPED))
+		if (unlikely(!exit_code) || unlikely(p->state != state))
 			goto bail_ref;
+
+		state = (state == TASK_TRACED) ? CLD_TRAPPED : CLD_STOPPED;
 		return wait_noreap_copyout(p, pid, uid,
-					   why, (exit_code << 8) | 0x7f,
+					   state, (exit_code << 8) | 0x7f,
 					   infop, ru);
 	}
 
