Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946094AbWJ0B7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946094AbWJ0B7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 21:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946104AbWJ0B7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 21:59:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46004 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946094AbWJ0B7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 21:59:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ernie Petrides <petrides@redhat.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       "Ulrich Drepper <drepper@redhat.com>Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for zeroed user-space tids in multi-threaded core dumps
In-Reply-To: Ernie Petrides's message of  Wednesday, 25 October 2006 21:41:42 -0400 <200610260141.k9Q1fgUW026204@pasta.boston.redhat.com>
X-Shopping-List: (1) Furious bomb confessions
   (2) Cosmetic hair opinions
   (3) Starboard crosswords
   (4) Furious interruption rodents
   (5) Puritanical exclamations
Message-Id: <20061027015930.40C67180057@magilla.sf.frob.com>
Date: Thu, 26 Oct 2006 18:59:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I concur with the analysis and the approach to avoiding the problem.  Any
change half this subtle deserves some comments in the code.  Other places
that look at mm->core_waiters hold mm->mmap_sem, though I'm not entirely
sure it matters in practice here.  

I would actually go further and skip the clearing on any signal exit,
rather than looking specifically for the core dump issue.  I've CC'd
Ulrich, the creator of the feature, who can verify that the intended
userland ABI specification has always been concerned only with the sys_exit
path.  It's arguably incorrect by POSIX as it is now (and would still be
with just Ernie's change), in that a thread taking SIGTERM should not cause
the race where another thread's pthread_join on that thread might return
before the SIGTERM took effect to kill all the threads.  (I'm not at all
sure such a race is actually possible, due to other interactions.)

This patch is race-free in that it depends only on the activities of the
current thread itself.  If it had started exiting normally before the
process-wide core dump happened, then the core dump can show it that way.
The PF_SIGNALED check covers the core dump case, and also the normal
no-core fatal signal case (so a superset of what Ernie's change covers
modulo the race difference, though still not including the several obscure
cases of direct do_exit calls that aren't from the normal signal code).


Thanks,
Roland

---
[PATCH] Disable CLONE_CHILD_CLEARTID for abnormal exit.

The CLONE_CHILD_CLEARTID flag is used by NPTL to have its threads
communicate via memory/futex when they exit, so pthread_join can
synchronize using a simple futex wait.  The word of user memory where NPTL
stores a thread's own TID is what it passes; this gets reset to zero at
thread exit.

It is not desireable to touch this user memory when threads are dying due
to a fatal signal.  A core dump is more usefully representative of the
dying program state if the threads live at the time of the crash have their
NPTL data structures unperturbed.  The userland expectation of
CLONE_CHILD_CLEARTID has only ever been that it works for a thread making
an _exit system call.

This problem was identified by Ernie Petrides <petrides@redhat.com>.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 kernel/fork.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 29ebb30..da3e2e1 100644  
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -448,7 +448,16 @@ void mm_release(struct task_struct *tsk,
 		tsk->vfork_done = NULL;
 		complete(vfork_done);
 	}
-	if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
+
+	/*
+	 * If we're exiting normally, clear a user-space tid field if
+	 * requested.  We leave this alone when dying by signal, to leave
+	 * the value intact in a core dump, and to save the unnecessary
+	 * trouble otherwise.  Userland only wants this done for a sys_exit.
+	 */
+	if (tsk->clear_child_tid
+	    && !(tsk->flags & PF_SIGNALED)
+	    && atomic_read(&mm->mm_users) > 1) {
 		u32 __user * tidptr = tsk->clear_child_tid;
 		tsk->clear_child_tid = NULL;
 
