Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWHGVkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWHGVkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHGVkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:40:07 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:65198 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750899AbWHGVkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:40:06 -0400
Subject: [BUG] futex_handle_fault always fails.
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au,
       jakub@redhat.com
Content-Type: text/plain
Date: Mon, 07 Aug 2006 14:39:58 -0700
Message-Id: <1154986798.5343.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We found this issue last week w/ the -RT kernel, but it seems the same
issue is in mainline as well.

Basically is possible for futex_unlock_pi to return without actually
freeing the lock. This is due to buggy logic in the use of
futex_handle_fault() and its attempt argument in a failure case.

Looking at futex.c the logic is as follows:
1) In futex_unlock_pi() we start w/ ret=0 and we go down to the first
futex_atomic_cmpxchg_inatomic(), where we find uval==-EFAULT.  We then
jump to the pi_faulted label.
2) From pi_faulted: We increment attempt, unlock the sem and hit the
retry label.
3) From the retry label, with ret still zero, we again hit EFAULT on the
first futex_atomic_cmpxchg_inatomic(), and again goto the pi_faulted
label.
4) Again from pi_faulted: we increment attempt and enter the
conditional, where we call futex_handle_fault.
5) futex_handle_fault fails, and we goto the out_unlock_release_sem
label.
6) From out_unlock_release_sem we return, and since ret is still zero,
we return without error, while never actually unlocking the lock.

Issue #1: at the first futex_atomic_cmpxchg_inatomic() we should
probably be setting ret=-EFAULT before jumping to pi_faulted:  However
in our case this doesn't really affect anything, as the glibc we're
using ignores the error value from futex_unlock_pi().

Issue #2: Look at futex_handle_fault(), its first conditional will
return -EFAULT if attempt is >= 2. However, from the "if(attempt++)
futex_handle_fault(attempt)" logic above, we'll *never* call
futex_handle_fault when attempt is less then two. So we never get a
chance to even try to fault the page in.

The following patch addresses these two issues by 1) Always setting ret
to -EFAULT if futex_handle_fault fails, and 2) Removing the = in
futex_handle_fault's (attempt >= 2) check.

I'm really not sure this is the right fix, but wanted to bring it up so
folks knew the issue is alive and well in the current -git tree. From
looking at the git logs the logic was first introduced (then later
copied to other places) in the following commit almost a year ago:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4732efbeb997189d9f9b04708dc26bf8613ed721;hp=5b039e681b8c5f30aac9cc04385cc94be45d0823

Thoughts, comments?

thanks
-john


diff --git a/kernel/futex.c b/kernel/futex.c
index c2b2e0b..d4633c5 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -297,7 +297,7 @@ static int futex_handle_fault(unsigned l
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
 
-	if (attempt >= 2 || !(vma = find_vma(mm, address)) ||
+	if (attempt > 2 || !(vma = find_vma(mm, address)) ||
 	    vma->vm_start > address || !(vma->vm_flags & VM_WRITE))
 		return -EFAULT;
 
@@ -747,8 +747,10 @@ retry:
 		 */
 		if (attempt++) {
 			if (futex_handle_fault((unsigned long)uaddr2,
-					       attempt))
+						attempt)) {
+				ret = -EFAULT;
 				goto out;
+			}
 			goto retry;
 		}
 
@@ -1322,9 +1324,10 @@ static int do_futex_lock_pi(u32 __user *
 	 * still holding the mmap_sem.
 	 */
 	if (attempt++) {
-		if (futex_handle_fault((unsigned long)uaddr, attempt))
+		if (futex_handle_fault((unsigned long)uaddr, attempt)) {
+			ret = -EFAULT;
 			goto out_unlock_release_sem;
-
+		}
 		goto retry_locked;
 	}
 
@@ -1506,9 +1509,10 @@ pi_faulted:
 	 * still holding the mmap_sem.
 	 */
 	if (attempt++) {
-		if (futex_handle_fault((unsigned long)uaddr, attempt))
+		if (futex_handle_fault((unsigned long)uaddr, attempt)) {
+			ret = -EFAULT;
 			goto out_unlock;
-
+		}
 		goto retry_locked;
 	}
 


