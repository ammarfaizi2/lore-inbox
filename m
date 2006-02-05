Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWBEOYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWBEOYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 09:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBEOYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 09:24:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53931 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750818AbWBEOYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 09:24:10 -0500
Date: Sun, 5 Feb 2006 15:22:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nigel@suspend2.net,
       Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH -mm] swsusp: freeze user space processes first
Message-ID: <20060205142226.GA20141@elte.hu>
References: <200602051014.43938.rjw@sisk.pl> <20060205013859.60a6e5ab.akpm@osdl.org> <200602051134.19490.rjw@sisk.pl> <20060205105037.GA26222@elte.hu> <20060205111145.GE1790@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205111145.GE1790@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@suse.cz> wrote:

> > then i'd suggest to change the vfork implementation to make this code 
> > freezable. Nothing that userspace does should cause freezing to fail.  
> > If it does, we've designed things incorrectly on the kernel side.
> 
> Does that also mean we have bugs with signal delivery? If vfork(); 
> sleep(100000); causes process to be uninterruptible for few days, it 
> will not be killable and increase load average...

"half-done" vforks are indeed in uninterruptible sleep. They are not 
directly killable, but they are killable indirectly through their 
parent. But yes, in theory it would be cleaner if the vfork code used 
wait_for_completion_interruptible(). It has to be done carefully though, 
for two reasons:

- implementational: use task_lock()/task_unlock() to protect
  p->vfork_done in mm_release() and in do_fork().

- semantical: signals to a vfork-ing parent are defined to be delayed
  to after the child has released the parent/MM.

the (untested) patch below handles issue #1, but doesnt handle issue #2: 
this patch opens up a vfork parent to get interrupted early, with any 
signal.

a full approach would probably be to set up a restart handler perhaps, 
and restart the wait later on? This would also require the &vfork 
completion structure [which is on the kernel stack right now] to be 
embedded in task_struct, to make sure the parent can wait on the child 
without extra state. (one more detail is nesting: a signal handler could 
do another vfork(), which thus needs to initialize the &vfork safely and 
in a race-free manner.)

i'm wondering whether signals handled in the parent during a vfork wait 
would be the correct semantics though. Ulrich?

	Ingo

--- linux/kernel/fork.c.orig
+++ linux/kernel/fork.c
@@ -423,16 +423,24 @@ EXPORT_SYMBOL_GPL(get_task_mm);
  */
 void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
-	struct completion *vfork_done = tsk->vfork_done;
-
 	/* Get rid of any cached register state */
 	deactivate_mm(tsk, mm);
 
-	/* notify parent sleeping on vfork() */
-	if (vfork_done) {
-		tsk->vfork_done = NULL;
-		complete(vfork_done);
+	if (unlikely(tsk->vfork_done)) {
+		task_lock(tsk);
+		/*
+		 * notify parent sleeping on vfork().
+		 *
+		 * (re-check vfork_done under the task lock, to make sure
+		 *  we did not race with a signal sent to the parent)
+		 */
+		if (tsk->vfork_done) {
+			complete(tsk->vfork_done);
+			tsk->vfork_done = NULL;
+		}
+		task_unlock(tsk);
 	}
+
 	if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
 		u32 __user * tidptr = tsk->clear_child_tid;
 		tsk->clear_child_tid = NULL;
@@ -1287,7 +1295,21 @@ long do_fork(unsigned long clone_flags,
 		}
 
 		if (clone_flags & CLONE_VFORK) {
-			wait_for_completion(&vfork);
+			int ret = wait_for_completion_interruptible(&vfork);
+			if (unlikely(ret)) {
+				/*
+				 * make sure we did not race with
+				 * mm_release():
+				 */
+				task_lock(p);
+				if (p->vfork_done)
+					p->vfork_done = NULL;
+				else
+					ret = 0;
+				task_unlock(p);
+				if (ret)
+					return -EINTR;
+			}
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
 				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
 		}
