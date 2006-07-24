Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWGXRvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWGXRvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWGXRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:51:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:13765 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932242AbWGXRvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:51:06 -0400
Subject: [RFC][PATCH 1/6] mprotect patch for use by SLIM
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 10:51:16 -0700
Message-Id: <1153763476.5171.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch makes mprotect available for use by SLIM for
write revocation.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 include/linux/mm.h |    2 ++
 mm/mprotect.c      |   14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6.17/mm/mprotect.c
===================================================================
--- linux-2.6.17.orig/mm/mprotect.c
+++ linux-2.6.17/mm/mprotect.c
@@ -19,6 +19,7 @@
 #include <linux/mempolicy.h>
 #include <linux/personality.h>
 #include <linux/syscalls.h>
+#include <linux/module.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm/uaccess.h>
@@ -179,8 +180,7 @@ fail:
 	return error;
 }
 
-asmlinkage long
-sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+int do_mprotect(unsigned long start, size_t len, unsigned long prot)
 {
 	unsigned long vm_flags, nstart, end, tmp, reqprot;
 	struct vm_area_struct *vma, *prev;
@@ -278,3 +278,13 @@ out:
 	up_write(&current->mm->mmap_sem);
 	return error;
 }
+EXPORT_SYMBOL_GPL(do_mprotect);
+
+asmlinkage long
+sys_mprotect(unsigned long start, size_t len, unsigned long prot)
+{
+	int ret;
+
+	ret = do_mprotect(start, len, prot);
+	return ret;
+}
Index: linux-2.6.17/include/linux/mm.h
===================================================================
--- linux-2.6.17.orig/include/linux/mm.h
+++ linux-2.6.17/include/linux/mm.h
@@ -138,6 +138,8 @@ extern unsigned int kobjsize(const void 
 #define VM_EXEC		0x00000004
 #define VM_SHARED	0x00000008
 
+extern int do_mprotect(unsigned long start, size_t len, unsigned long prot);
+
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
 #define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
 #define VM_MAYWRITE	0x00000020


