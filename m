Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVBWTR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVBWTR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 14:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVBWTR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 14:17:57 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33261 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261535AbVBWTRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 14:17:01 -0500
Date: Wed, 23 Feb 2005 13:12:54 -0600
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Joe Korty <joe.korty@ccur.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050223191254.GA5608@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org> <20050223171015.GD10256@austin.ibm.com> <20050223182203.GA10931@mail.shareable.org> <Pine.LNX.4.58.0502231033540.2378@ppc970.osdl.org> <20050223184946.GA11473@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223184946.GA11473@mail.shareable.org>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 06:49:46PM +0000, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > > I suggest putting it into futex.c, and make it an inline function
> > > which takes "u32 __user *".
> > 
> > Agreed, except we've traditionally just made it "int __user *".
> 
> The type signatures in futex.c are a bit mixed up - most places say
> "int __user *" but sys_futex() says "u32 __user *".  get_futex_key
> uses sizeof(u32) to check the address.

How's this? I went with get_val_no_fault(), since it isn't really a
get_user.*() any more (ptr being passed in), and no_paging is a little
misleading (not all faults are due to paging).


-----

Some futex functions do get_user calls while holding mmap_sem for
reading. If get_user() faults, and another thread happens to be in mmap
(or somewhere else holding waiting on down_write for the same semaphore),
then do_page_fault will deadlock. Most architectures seem to be exposed
to this.

To avoid it, make sure the page is available. If not, release the
semaphore, fault it in and retry.

I also found another exposure by inspection, moving some of the code
around avoids the possible deadlock there.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>


Index: linux-2.5/kernel/futex.c
===================================================================
--- linux-2.5.orig/kernel/futex.c	2005-02-21 16:09:38.000000000 -0600
+++ linux-2.5/kernel/futex.c	2005-02-23 13:10:16.000000000 -0600
@@ -258,6 +258,18 @@
 	}
 }
 
+static inline int get_val_no_fault(int *dest, int __user *from)
+{
+	int ret;
+
+	inc_preempt_count();
+	ret = __copy_from_user_inatomic(dest, from, sizeof(int));
+	dec_preempt_count();
+	preempt_check_resched();
+
+	return ret;
+}
+
 /*
  * The hash bucket lock must be held when this is called.
  * Afterwards, the futex_q must not be accessed.
@@ -329,6 +341,7 @@
 	int ret, drop_count = 0;
 	unsigned int nqueued;
 
+ retry:
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr1, &key1);
@@ -355,9 +368,20 @@
 		   before *uaddr1.  */
 		smp_mb();
 
-		if (get_user(curval, (int __user *)uaddr1) != 0) {
-			ret = -EFAULT;
-			goto out;
+		ret = get_val_no_fault(&curval, (int __user *)uaddr1);
+
+		if (unlikely(ret)) {
+			/* If we would have faulted, release mmap_sem, fault
+			 * it in and start all over again.
+			 */
+			up_read(&current->mm->mmap_sem);
+
+			ret = get_user(curval, (int __user *)uaddr1);
+
+			if (!ret)
+				goto retry;
+
+			return ret;
 		}
 		if (curval != *valp) {
 			ret = -EAGAIN;
@@ -480,6 +504,7 @@
 	int ret, curval;
 	struct futex_q q;
 
+ retry:
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr, &q.key);
@@ -508,9 +533,23 @@
 	 * We hold the mmap semaphore, so the mapping cannot have changed
 	 * since we looked it up in get_futex_key.
 	 */
-	if (get_user(curval, (int __user *)uaddr) != 0) {
-		ret = -EFAULT;
-		goto out_unqueue;
+
+	ret = get_val_no_fault(&curval, (int __user *)uaddr);
+
+	if (unlikely(ret)) {
+		/* If we would have faulted, release mmap_sem, fault it in and
+		 * start all over again.
+		 */
+		up_read(&current->mm->mmap_sem);
+
+		if (!unqueue_me(&q)) /* There's a chance we got woken already */
+			return 0;
+
+		ret = get_user(curval, (int __user *)uaddr);
+
+		if (!ret)
+			goto retry;
+		return ret;
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
Index: linux-2.5/mm/mempolicy.c
===================================================================
--- linux-2.5.orig/mm/mempolicy.c	2005-02-04 00:27:40.000000000 -0600
+++ linux-2.5/mm/mempolicy.c	2005-02-23 12:53:22.000000000 -0600
@@ -524,9 +524,13 @@
 	} else
 		pval = pol->policy;
 
-	err = -EFAULT;
+	if (vma) {
+		up_read(&current->mm->mmap_sem);
+		vma = NULL;
+	}
+
 	if (policy && put_user(pval, policy))
-		goto out;
+		return -EFAULT;
 
 	err = 0;
 	if (nmask) {
