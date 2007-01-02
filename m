Return-Path: <linux-kernel-owner+w=401wt.eu-S965048AbXABXfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXABXfQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbXABXfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:35:15 -0500
Received: from nevyn.them.org ([66.93.172.17]:45801 "EHLO nevyn.them.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965005AbXABXfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:35:12 -0500
X-Greylist: delayed 1996 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 18:35:12 EST
Date: Tue, 2 Jan 2007 18:01:49 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [Bug 7210] New: Clone flag CLONE_PARENT_TIDPTR leaves invalid results in memory.
Message-ID: <20070102230149.GA24475@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060927033048.AAB8D18007A@magilla.sf.frob.com> <Pine.LNX.4.64.0609262056150.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609262056150.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jacobowitz <dan@codesourcery.com>

Do not implement CLONE_PARENT_SETTID until we know that clone will succeed.
If we do it too early NPTL's data structures temporarily reference a
non-existant TID.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

---
On Tue, Sep 26, 2006 at 08:59:15PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 26 Sep 2006, Roland McGrath wrote:
> >
> > It can go last, right before return, after unlock.
> > Userland only cares that parent_tidptr set before parent syscall returns,
> > and child_tidptr set before child returns.
> 
> Ok, as long as people are sure, I don't care. Then we have to just ignore 
> the error, though, since we can't recover (we've already "exposed" the 
> child on the task lists).
> 
> I don't think it's a big deal. Ignoring the error just means that if you 
> pass in an invalid ptr, it's as if the bit to set that value wasn't set. 
> Not a problem.
> 
> Especially if there is a test-program, can we just have a patch to try 
> that has been verified? It _sounded_ like somebody actually had a program 
> that could trigger this with some horrid code that sent signals and cloned 
> all the time?

I never got back to you about this...

Refresher, if there isn't enough above: CLONE_PARENT_SETTID is
currently implemented right after a TID is assigned.  There's a lot of
clone left to go at that point including a check for pending signals
which can lead to clone failing.  This leaves a TID in NPTL's thread
list which doesn't correspond to a thread.

I found Sunday another place where this is a problem, besides the
process-global UID stuff in glibc.  GDB tries to attach to the
nonexistant thread and gets upset.  I've made it cope, but at the same
time it provides a convenient test case.

Without the attached patch, tls.exp in the GDB testsuite would
intermittently report that it could not attach to a thread - always
within half an hour.  With the patch it ran for four hours without
a problem.

 kernel/fork.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: linux-source-2.6.18/kernel/fork.c
===================================================================
--- linux-source-2.6.18.orig/kernel/fork.c	2007-01-02 13:45:28.000000000 -0500
+++ linux-source-2.6.18/kernel/fork.c	2007-01-02 13:52:09.000000000 -0500
@@ -1012,10 +1012,6 @@ static struct task_struct *copy_process(
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	copy_flags(clone_flags, p);
 	p->pid = pid;
-	retval = -EFAULT;
-	if (clone_flags & CLONE_PARENT_SETTID)
-		if (put_user(p->pid, parent_tidptr))
-			goto bad_fork_cleanup_delays_binfmt;
 
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
@@ -1251,6 +1247,14 @@ static struct task_struct *copy_process(
 	total_forks++;
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+
+	/*
+	 * Now that we know the fork has succeeded, record the new
+	 * TID.  It's too late to back out if this fails.
+	 */
+	if (clone_flags & CLONE_PARENT_SETTID)
+		put_user(p->pid, parent_tidptr);
+
 	proc_fork_connector(p);
 	return p;
 
@@ -1281,7 +1285,6 @@ bad_fork_cleanup_policy:
 bad_fork_cleanup_cpuset:
 #endif
 	cpuset_exit(p);
-bad_fork_cleanup_delays_binfmt:
 	delayacct_tsk_free(p);
 	if (p->binfmt)
 		module_put(p->binfmt->module);

-- 
Daniel Jacobowitz
CodeSourcery
