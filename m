Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbUKOCsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUKOCsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUKOCsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:48:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:18895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbUKOCpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:45:11 -0500
Date: Sun, 14 Nov 2004 18:44:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: x86: only single-step into signal handlers if the tracer
Message-Id: <20041114184456.6bfd07d3.akpm@osdl.org>
In-Reply-To: <41981266.2070707@pobox.com>
References: <200411150203.iAF23Trb024677@hera.kernel.org>
	<41981266.2070707@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.2159, 2004/11/15 00:56:31-08:00, torvalds@ppc970.osdl.org
> > 
> > 	x86: only single-step into signal handlers if the tracer
> > 	asked for it.
> 
> 
> This reminds me of a problem I am seeing under recent -bk kernels.
> 
> Mozilla (FC2) will freeze (no screen redraws, etc.).  'ps xf' shows 
> mozilla sleeping.  If I strace the process, Mozilla will un-freeze and 
> continue as expected.
> 

Presumably the futex thing:


diff -puN kernel/futex.c~revert-futex_wait-fix kernel/futex.c
--- 25/kernel/futex.c~revert-futex_wait-fix	2004-11-14 18:43:56.841300400 -0800
+++ 25-akpm/kernel/futex.c	2004-11-14 18:43:56.845299792 -0800
@@ -6,7 +6,7 @@
  *  (C) Copyright 2003 Red Hat Inc, All Rights Reserved
  *
  *  Removed page pinning, fix privately mapped COW pages and other cleanups
- *  (C) Copyright 2003 Jamie Lokier
+ *  (C) Copyright 2003, 2004 Jamie Lokier
  *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
@@ -486,22 +486,37 @@ static int futex_wait(unsigned long uadd
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
+	queue_me(&q, -1, NULL);
+
 	/*
-	 * Access the page after the futex is queued.
+	 * Access the page AFTER the futex is queued.
+	 * Order is important:
+	 *
+	 *   Userspace waiter: val = var; if (cond(val)) futex_wait(&var, val);
+	 *   Userspace waker:  if (cond(var)) { var = new; futex_wake(&var); }
+	 *
+	 * The basic logical guarantee of a futex is that it blocks ONLY
+	 * if cond(var) is known to be true at the time of blocking, for
+	 * any cond.  If we queued after testing *uaddr, that would open
+	 * a race condition where we could block indefinitely with
+	 * cond(var) false, which would violate the guarantee.
+	 *
+	 * A consequence is that futex_wait() can return zero and absorb
+	 * a wakeup when *uaddr != val on entry to the syscall.  This is
+	 * rare, but normal.
+	 *
 	 * We hold the mmap semaphore, so the mapping cannot have changed
-	 * since we looked it up.
+	 * since we looked it up in get_futex_key.
 	 */
 	if (get_user(curval, (int __user *)uaddr) != 0) {
 		ret = -EFAULT;
-		goto out_release_sem;
+		goto out_unqueue;
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
-		goto out_release_sem;
+		goto out_unqueue;
 	}
 
-	queue_me(&q, -1, NULL);
-
 	/*
 	 * Now the futex is queued and we have checked the data, we
 	 * don't want to hold mmap_sem while we sleep.
@@ -542,10 +557,11 @@ static int futex_wait(unsigned long uadd
 	WARN_ON(!signal_pending(current));
 	return -EINTR;
 
+ out_unqueue:
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!unqueue_me(&q))
 		ret = 0;
-out_release_sem:
+ out_release_sem:
 	up_read(&current->mm->mmap_sem);
 	return ret;
 }
_

