Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVBVTPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVBVTPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBVTPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:15:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19088 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261465AbVBVTKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:10:55 -0500
Date: Tue, 22 Feb 2005 13:06:46 -0600
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, jamie@shareable.org,
       rusty@rustcorp.com.au
Subject: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222190646.GA7079@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Consider a small testcase that spawns off two threads, either thread
doing a loop of:

	buf = mmap /dev/zero MAP_SHARED for 0x100000 bytes
	call sys_futex (buf+page, FUTEX_WAIT, 1, NULL, NULL) for each page in said mmap
	munmap(buf)
	repeat

This will quickly lock up, since the futex_wait code dows a
down_read(mmap_sem), then a get_user().

The do_page_fault code on ppc64 (as well as other architectures) needs
to take the same semaphore for reading. This is all good until the
second thread comes into play: Its mmap call tries to take the same
semaphore for writing which causes in the do_page_fault down_read()
to get stuck. Classic deadlock.

Stacks are as follows:

a.out         S 000000000ff9772c 12288  6491   6484  6492               (NOTLB)
Call Trace:
[c0000003eb72fa10] [0000000030ecbd28] 0x30ecbd28 (unreliable)
[c0000003eb72fbe0] [c0000000000119ec] .__switch_to+0xa4/0xf0
[c0000003eb72fc70] [c00000000043ffbc] .schedule+0x4d4/0xe5c
[c0000003eb72fd90] [c0000000000247c8] .sys32_rt_sigsuspend+0xe0/0x120
[c0000003eb72fe30] [c00000000000d7e8] .ppc32_rt_sigsuspend+0x8/0x14
a.out         D 000000000ff0ad38 13632  6492   6491  6493               (NOTLB)
Call Trace:
[c00000003a1a7830] [c00000003a1a7850] 0xc00000003a1a7850 (unreliable)
[c00000003a1a7a00] [c0000000000119ec] .__switch_to+0xa4/0xf0
[c00000003a1a7a90] [c00000000043ffbc] .schedule+0x4d4/0xe5c
[c00000003a1a7bb0] [c000000000441ec0] .rwsem_down_write_failed+0x138/0x2f0
[c00000003a1a7c90] [c000000000098db0] .sys_mprotect+0x7bc/0x81c
[c00000003a1a7e30] [c00000000000d600] syscall_exit+0x0/0x18
a.out         D 0000000010000654 12832  6493   6492                     (NOTLB)
Call Trace:
[c00000000f2674f0] [c0000000000119ec] .__switch_to+0xa4/0xf0
[c00000000f267580] [c00000000043ffbc] .schedule+0x4d4/0xe5c
[c00000000f2676a0] [c0000000004421b4] .rwsem_down_read_failed+0x13c/0x2f4
[c00000000f267780] [c00000000003ba6c] .do_page_fault+0x66c/0x738
[c00000000f267900] [c00000000000b2dc] .handle_page_fault+0x20/0x54
--- Exception: 301 at .do_futex+0x5d4/0x720
    LR = .do_futex+0x1e0/0x720
[c00000000f267d60] [c000000000078124] .compat_sys_futex+0xa4/0x16c
[c00000000f267e30] [c00000000000d600] syscall_exit+0x0/0x18


One attempt to fix this is included below. It works, but I'm not entirely
happy with the fact that it's a bit messy solution. If anyone has a
better idea for how to solve it I'd be all ears.

Auditing other read-takers of mmap_sem, I found one more exposure that
could be solved by just moving code around.

-----

Some futex functions do get_user calls while holding mmap_sem for
reading. If get_user() faults, and another thread happens to be in mmap
(or somewhere else holding waiting on down_write for the same semaphore),
then do_page_fault will deadlock. Most architectures seem to be exposed
to this.

To avoid it, make sure the page is available. If not, release the
semaphore, fault it in and retake it.

I also found another exposure by inspection, moving some of the code
around avoids the possible deadlock there.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>


Index: linux-2.5/kernel/futex.c
===================================================================
--- linux-2.5.orig/kernel/futex.c	2005-02-21 16:09:38.000000000 -0600
+++ linux-2.5/kernel/futex.c	2005-02-22 12:35:01.000000000 -0600
@@ -326,11 +326,22 @@
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head1;
 	struct futex_q *this, *next;
-	int ret, drop_count = 0;
+	int ret, curval, drop_count = 0;
 	unsigned int nqueued;
 
 	down_read(&current->mm->mmap_sem);
 
+	/* Make sure we can access the page, since there's a risk to
+	 * deadlock with do_page_fault() if get_user() faults.
+	 */
+	while (!check_user_page_readable(current->mm, uaddr1)) {
+		up_read(&current->mm->mmap_sem);
+		/* Fault in the page through get_user() but discard result */
+		if (get_user(curval, (int __user *)uaddr1) != 0)
+			return -EFAULT;
+		down_read(&current->mm->mmap_sem);
+	}
+
 	ret = get_futex_key(uaddr1, &key1);
 	if (unlikely(ret != 0))
 		goto out;
@@ -343,8 +354,6 @@
 
 	nqueued = bh1->nqueued;
 	if (likely(valp != NULL)) {
-		int curval;
-
 		/* In order to avoid doing get_user while
 		   holding bh1->lock and bh2->lock, nqueued
 		   (monotonically increasing field) must be first
@@ -482,6 +491,19 @@
 
 	down_read(&current->mm->mmap_sem);
 
+	/* Make sure we can access the page, since there's a risk to
+	 * deadlock with do_page_fault() if get_user() faults.
+	 */
+	while (!check_user_page_readable(current->mm, uaddr)) {
+		up_read(&current->mm->mmap_sem);
+
+		/* Fault in the page through get_user() but discard result */
+		if (get_user(curval, (int __user *)uaddr) != 0)
+			return -EFAULT;
+
+		down_read(&current->mm->mmap_sem);
+	}
+
 	ret = get_futex_key(uaddr, &q.key);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
Index: linux-2.5/mm/mempolicy.c
===================================================================
--- linux-2.5.orig/mm/mempolicy.c	2005-02-04 00:27:40.000000000 -0600
+++ linux-2.5/mm/mempolicy.c	2005-02-21 16:43:08.000000000 -0600
@@ -486,6 +486,7 @@
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	struct mempolicy *pol = current->mempolicy;
+	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
@@ -524,16 +525,21 @@
 	} else
 		pval = pol->policy;
 
+	if (nmask)
+		get_zonemask(pol, nodes);
+
+	if (vma) {
+		up_read(&current->mm->mmap_sem);
+		vma = NULL;
+	}
+
 	err = -EFAULT;
 	if (policy && put_user(pval, policy))
 		goto out;
 
 	err = 0;
-	if (nmask) {
-		DECLARE_BITMAP(nodes, MAX_NUMNODES);
-		get_zonemask(pol, nodes);
+	if (nmask)
 		err = copy_nodes_to_user(nmask, maxnode, nodes, sizeof(nodes));
-	}
 
  out:
 	if (vma)
