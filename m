Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUGADWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUGADWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUGADWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:22:38 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:9418 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S263769AbUGADWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:22:33 -0400
Date: Wed, 30 Jun 2004 20:22:25 -0700
Message-Id: <200407010322.i613MPDr016785@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
X-Fcc: ~/Mail/linus
Cc: Andreas Schwab <schwab@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Andreas Schwab's message of  Wednesday, 30 June 2004 11:04:46 +0200 <je8ye5ct75.fsf@sykes.suse.de>
Emacs: Lovecraft was an optimist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reason strace hangs in that case is an strace bug.  strace is
blocking in a wait4 call on the specific PID of the zombie group leader,
which will never report until strace reaps the other non-leader thread
it is tracing.  But strace won't ever do that, because it's blocked
saying it only cares about the zombie leader's PID.  You should report
that bug in strace.  I pity the fool who agreed to maintain that unholy
pile of spaghetti--what a maroon!

The kernel bug is that when you kill strace, the non-leader zombie hangs
around and that keeps the zombie leader around too (which is the one
you'll see in ps).  The following patch fixes that for me.  I am not
100% confident that the locking dance required here doesn't create some
weird issue (and it certainly seems inefficient how many times the lock
is released and retaken in this sequence), but maybe 92% sure.


Thanks,
Roland


--- linux-2.6.7-mm4/kernel/exit.c.~1~	2004-06-30 16:29:06.000000000 -0700
+++ linux-2.6.7-mm4/kernel/exit.c	2004-06-30 18:55:36.000000000 -0700
@@ -618,9 +618,21 @@ static inline void forget_original_paren
 			reparent_thread(p, father, 0);
 		} else {
 			ptrace_unlink (p);
-			if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
-			    thread_group_empty(p))
-				do_notify_parent(p, p->exit_signal);
+			if (p->state == TASK_ZOMBIE) {
+				if (p->exit_signal == -1) {
+					/*
+					 * This was only a zombie because
+					 * we were tracing it.  Now it should
+					 * disappear as it would have done
+					 * if we hadn't been tracing it.
+					 */
+					write_unlock_irq(&tasklist_lock);
+					release_task(p);
+					write_lock_irq(&tasklist_lock);
+				}
+				else if (thread_group_empty(p))
+					do_notify_parent(p, p->exit_signal);
+			}
 		}
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {


