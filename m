Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWHCApF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWHCApF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHCApF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:45:05 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62157 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750792AbWHCApE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:45:04 -0400
Subject: [BUG] futex_unlock_pi returns w/o unlocking
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Dinakar Guniguntala <dino@in.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 17:43:59 -0700
Message-Id: <1154565839.14522.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
	So we've just hunted down a nasty bug w/ 2.6.17-rt8. We've had some odd
test failures where userspace apps were hanging when dealing w/ pi
mutexes.

After a good bit of debugging (not by me) it was found that we were
deadlocking by double locking a mutex, however it wasn't userland's
fault. On top of that, the mutex __owner field was null, so something
was wrong.

We found that futex_unlock_pi() was somehow returning without error
while not actually clearing the mutex __lock value. Further digging
found the failure case, and its a bit obscure.

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

This very simple and hackish fix for issue #2 is probably not the
correct solution, but with the odd if(attempt++) logic all over futex.c
it might actually be the right thing to do.

Your thoughts?

thanks
-john

Index: 2.6-rt/kernel/futex.c
===================================================================
--- 2.6-rt.orig/kernel/futex.c	2006-08-01 13:14:50.000000000 -0700
+++ 2.6-rt/kernel/futex.c	2006-08-02 17:25:32.000000000 -0700
@@ -298,7 +298,7 @@
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
 
-	if (attempt >= 2 || !(vma = find_vma(mm, address)) ||
+	if (attempt > 2 || !(vma = find_vma(mm, address)) ||
 	    vma->vm_start > address || !(vma->vm_flags & VM_WRITE))
 		return -EFAULT;
 



