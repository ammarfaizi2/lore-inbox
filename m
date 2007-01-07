Return-Path: <linux-kernel-owner+w=401wt.eu-S932487AbXAGKo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbXAGKo2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAGKo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:44:28 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:59124 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbXAGKoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:44:24 -0500
Date: Sun, 7 Jan 2007 11:44:21 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] don't call handle_mm_fault() if in an atomic context.
Message-ID: <20070107104421.GE14724@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] don't call handle_mm_fault() if in an atomic context.

There are several places in the futex code where a spin_lock is held
and still uaccesses happen. Deadlocks are avoided by increasing the
preempt count. The pagefault handler will then not take any locks
but will immediately search the fixup tables.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/uaccess_pt.c  |    3 +++
 arch/s390/lib/uaccess_std.c |    3 ---
 include/asm-s390/futex.h    |    2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/uaccess_pt.c linux-2.6-patched/arch/s390/lib/uaccess_pt.c
--- linux-2.6/arch/s390/lib/uaccess_pt.c	2007-01-06 15:20:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_pt.c	2007-01-06 15:20:34.000000000 +0100
@@ -8,6 +8,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/hardirq.h>
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 #include <asm/futex.h>
@@ -18,6 +19,8 @@ static inline int __handle_fault(struct 
 	struct vm_area_struct *vma;
 	int ret = -EFAULT;
 
+	if (in_atomic())
+		return ret;
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (unlikely(!vma))
diff -urpN linux-2.6/arch/s390/lib/uaccess_std.c linux-2.6-patched/arch/s390/lib/uaccess_std.c
--- linux-2.6/arch/s390/lib/uaccess_std.c	2007-01-06 15:20:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_std.c	2007-01-06 15:20:34.000000000 +0100
@@ -258,8 +258,6 @@ int futex_atomic_op(int op, int __user *
 {
 	int oldval = 0, newval, ret;
 
-	pagefault_disable();
-
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("lr %2,%5\n",
@@ -284,7 +282,6 @@ int futex_atomic_op(int op, int __user *
 	default:
 		ret = -ENOSYS;
 	}
-	pagefault_enable();
 	*old = oldval;
 	return ret;
 }
diff -urpN linux-2.6/include/asm-s390/futex.h linux-2.6-patched/include/asm-s390/futex.h
--- linux-2.6/include/asm-s390/futex.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/futex.h	2007-01-06 15:20:34.000000000 +0100
@@ -21,7 +21,9 @@ static inline int futex_atomic_op_inuser
 	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
 		return -EFAULT;
 
+	pagefault_disable();
 	ret = uaccess.futex_atomic_op(op, uaddr, oparg, &oldval);
+	pagefault_enable();
 
 	if (!ret) {
 		switch (cmp) {
