Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWHQTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWHQTzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHQTyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:54:52 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:15550 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030206AbWHQTyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:54:03 -0400
Subject: [RFC][PATCH 1/8] mprotect patch for use by SLIM
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:53:05 -0700
Message-Id: <1155844385.6788.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch makes mprotect available for use by SLIM for
write revocation.

Updated to allow the usage locking to work properly.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 include/linux/mm.h |    2 ++
 mm/mprotect.c      |   23 +++++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

--- linux-2.6.18-rc3/mm/mprotect.c	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/mm/mprotect.c	2006-08-07 13:11:07.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/module.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm/uaccess.h>
@@ -202,9 +203,10 @@ fail:
 	vm_unacct_memory(charged);
 	return error;
 }
-
-asmlinkage long
-sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+/* 
+ * Call holding the current->mm->mmap_sem for writing
+ */
+int do_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
 	unsigned long vm_flags, nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
@@ -234,8 +236,6 @@ sys_mprotect(unsigned long start, size_t
 
 	vm_flags = calc_vm_prot_bits(prot);
 
-	down_write(&current->mm->mmap_sem);
-
 	vma = find_vma_prev(current->mm, start, &prev);
 	error = -ENOMEM;
 	if (!vma)
@@ -298,6 +298,17 @@ sys_mprotect(unsigned long start, size_t
 		}
 	}
 out:
-	up_write(&current->mm->mmap_sem);
 	return error;
 }
+EXPORT_SYMBOL_GPL(do_mprotect);
+
+asmlinkage long
+sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+{
+	int ret;
+
+	down_write(&current->mm->mmap_sem);
+	ret = do_mprotect(start, len, prot);
+	up_write(&current->mm->mmap_sem);
+	return ret;
+}
--- linux-2.6.18-rc3/include/linux/mm.h	2006-07-30 01:15:36.000000000 -0500
+++ linux-2.6.18-rc3-working/include/linux/mm.h	2006-08-01 12:18:13.000000000 -0500
@@ -137,6 +137,8 @@ extern unsigned int kobjsize(const void 
 #define VM_EXEC		0x00000004
 #define VM_SHARED	0x00000008
 
+extern int do_mprotect(unsigned long start, size_t len, unsigned long prot);
+
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
 #define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
 #define VM_MAYWRITE	0x00000020


