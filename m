Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVBVX2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVBVX2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVBVX1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:27:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:27279 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261354AbVBVX1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:27:14 -0500
Date: Tue, 22 Feb 2005 17:23:15 -0600
To: Andrew Morton <akpm@osdl.org>
Cc: jamie@shareable.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222232315.GA1730@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050222223457.GK22555@mail.shareable.org> <20050222224256.GA31341@austin.ibm.com> <20050222152027.7ace52e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222152027.7ace52e8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 03:20:27PM -0800, Andrew Morton wrote:
> olof@austin.ibm.com (Olof Johansson) wrote:
> >
> > +		inc_preempt_count();
> > +		ret = get_user(curval, (int __user *)uaddr1);
> > +		dec_preempt_count();
> 
> That _should_ generate a might_sleep() warning, except it looks like we
> forgot to add a check to get_user().
> 
> It would be better to use __copy_from_user_inatomic() here, I think.

Thanks for catching that. New rev below.

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
+++ linux-2.5/kernel/futex.c	2005-02-22 17:20:22.000000000 -0600
@@ -329,6 +329,7 @@
 	int ret, drop_count = 0;
 	unsigned int nqueued;
 
+ retry:
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr1, &key1);
@@ -355,9 +356,19 @@
 		   before *uaddr1.  */
 		smp_mb();
 
-		if (get_user(curval, (int __user *)uaddr1) != 0) {
-			ret = -EFAULT;
-			goto out;
+		inc_preempt_count();
+		ret = __copy_from_user_inatomic(&curval, (int __user *)uaddr1, sizeof(int));
+		dec_preempt_count();
+
+		if (unlikely(ret)) {
+			up_read(&current->mm->mmap_sem);
+			/* Re-do the access outside the lock */
+			ret = get_user(curval, (int __user *)uaddr1);
+
+			if (!ret)
+				goto retry;
+
+			return ret;
 		}
 		if (curval != *valp) {
 			ret = -EAGAIN;
@@ -480,6 +491,7 @@
 	int ret, curval;
 	struct futex_q q;
 
+ retry:
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr, &q.key);
@@ -508,9 +520,21 @@
 	 * We hold the mmap semaphore, so the mapping cannot have changed
 	 * since we looked it up in get_futex_key.
 	 */
-	if (get_user(curval, (int __user *)uaddr) != 0) {
-		ret = -EFAULT;
-		goto out_unqueue;
+	inc_preempt_count();
+	ret = __copy_from_user_inatomic(&curval, (int __user *)uaddr, sizeof(int));
+	dec_preempt_count();
+	if (unlikely(ret)) {
+		up_read(&current->mm->mmap_sem);
+
+		if (!unqueue_me(&q)) /* There's a chance we got woken already */
+			return 0;
+
+		/* Re-do the access outside the lock */
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
+++ linux-2.5/mm/mempolicy.c	2005-02-22 14:34:19.000000000 -0600
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
