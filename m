Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265405AbUFCPJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUFCPJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUFCPJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:09:21 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:11746 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264108AbUFCPAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:00:47 -0400
Message-ID: <40BF3D17.8030504@acm.org>
Date: Thu, 03 Jun 2004 10:00:39 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Possible race between multi-threaded coredumps and fork
Content-Type: multipart/mixed;
 boundary="------------000007000606080109080909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000007000606080109080909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A customer had a field problem with multi-threaded coredumps,
and I think the fix is the exit race (already fixed in 2.6), but I
also noticed a possible race between taking a coredump and fork().

If zap_threads() in fs/exec.c is called while a thread is in do_fork(),
but before the newly created thread is in the thread list, it is possible
to have a running thread during the coredump.  This is bad, but not
terribly bad.  However, in this situation it is also possible in
__exit_mm() that the final two threads check mm->core_waiters at
the same time and then both decrement mm->core_waiters, causing
it to go negative, and thus causing a BUG() in coredump_wait().

To fix this, I would like to propose the attached patch to 2.6.

Signed-off-by: Corey Minyard <minyard@acm.org>


--------------000007000606080109080909
Content-Type: text/plain;
 name="coredump-fork-race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coredump-fork-race.diff"

--- linux.orig/kernel/fork.c	2004-05-21 11:49:07.000000000 -0500
+++ linux/kernel/fork.c	2004-06-03 09:46:00.000000000 -0500
@@ -1011,6 +1011,9 @@
 	INIT_LIST_HEAD(&p->ptrace_children);
 	INIT_LIST_HEAD(&p->ptrace_list);
 
+	/* Need the mmap_sem lock for coredump synchronization. */
+	if (p->mm)
+		down_read(&p->mm->mmap_sem);
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 	/*
@@ -1019,6 +1022,7 @@
 	 */
 	if (sigismember(&current->pending.signal, SIGKILL)) {
 		write_unlock_irq(&tasklist_lock);
+		up_read(&p->mm->mmap_sem);
 		retval = -EINTR;
 		goto bad_fork_cleanup_namespace;
 	}
@@ -1040,6 +1044,7 @@
 		if (current->signal->group_exit) {
 			spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
+			up_read(&p->mm->mmap_sem);
 			retval = -EAGAIN;
 			goto bad_fork_cleanup_namespace;
 		}
@@ -1075,6 +1080,23 @@
 
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
+
+	if (p->mm) {
+		if (p->mm->core_waiters) {
+			/*
+			 * The thread group I am in is currently
+			 * taking a coredump so add the new thread as
+			 * a coredump candidate force the new thread
+			 * to die immediately.
+			 */
+			up_read(&p->mm->mmap_sem);
+			down_write(&p->mm->mmap_sem);
+			force_sig_specific(SIGKILL, p);
+			p->mm->core_waiters++;
+			up_write(&p->mm->mmap_sem);
+		} else
+			up_read(&p->mm->mmap_sem);
+	}
 	retval = 0;
 
 fork_out:

--------------000007000606080109080909--

