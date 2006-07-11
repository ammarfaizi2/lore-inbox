Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWGKHz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWGKHz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWGKHzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:55:20 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:53655 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750715AbWGKHyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:54:44 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075416.997850000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:55 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 4/7] add execns syscall to i386
Content-Disposition: inline; filename=execns-syscall-i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the execns() syscall to the i386 architecture.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

---
 arch/i386/kernel/process.c       |   31 +++++++++++++++++++++++++++++++
 arch/i386/kernel/syscall_table.S |    1 +
 include/asm-i386/unistd.h        |    3 ++-
 3 files changed, 34 insertions(+), 1 deletion(-)

Index: 2.6.18-rc1-mm1/arch/i386/kernel/process.c
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc1-mm1/arch/i386/kernel/process.c
@@ -768,6 +768,37 @@ out:
 	return error;
 }
 
+/*
+ * sys_execns() executes a new program and unshares selected
+ * namespaces.
+ */
+asmlinkage int sys_execns(struct pt_regs regs)
+{
+	int error;
+	int flags;
+	char * filename;
+
+	flags = regs.ebx;
+	filename = getname((char __user *) regs.ecx);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		goto out;
+	error = do_execns(flags, filename,
+			(char __user * __user *) regs.edx,
+			(char __user * __user *) regs.edi,
+			&regs);
+	if (error == 0) {
+		task_lock(current);
+		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+		/* Make sure we don't return using sysenter.. */
+		set_thread_flag(TIF_IRET);
+	}
+	putname(filename);
+out:
+	return error;
+}
+
 #define top_esp                (THREAD_SIZE - sizeof(unsigned long))
 #define top_ebp                (THREAD_SIZE - 2*sizeof(unsigned long))
 
Index: 2.6.18-rc1-mm1/arch/i386/kernel/syscall_table.S
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/i386/kernel/syscall_table.S
+++ 2.6.18-rc1-mm1/arch/i386/kernel/syscall_table.S
@@ -317,3 +317,4 @@ ENTRY(sys_call_table)
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
 	.long sys_move_pages
+	.long sys_execns
Index: 2.6.18-rc1-mm1/include/asm-i386/unistd.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/asm-i386/unistd.h
+++ 2.6.18-rc1-mm1/include/asm-i386/unistd.h
@@ -323,10 +323,11 @@
 #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
+#define __NR_execns		318
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 318
+#define NR_syscalls 319
 #include <linux/err.h>
 
 /*

--
