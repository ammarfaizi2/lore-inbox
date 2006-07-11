Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWGKHzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWGKHzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWGKHyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:54:44 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:52119 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750707AbWGKHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:54:42 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075413.264879000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:54 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 3/7] add execns syscall to x86_64
Content-Disposition: inline; filename=execns-syscall-x86_64.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the execns() syscall to the x86_64 architecture.

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
 arch/x86_64/kernel/entry.S      |   30 ++++++++++++++++++++++++++++++
 arch/x86_64/kernel/functionlist |    3 +++
 arch/x86_64/kernel/process.c    |   25 +++++++++++++++++++++++++
 include/asm-x86_64/unistd.h     |    4 +++-
 4 files changed, 61 insertions(+), 1 deletion(-)

Index: 2.6.18-rc1-mm1/arch/x86_64/kernel/entry.S
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/x86_64/kernel/entry.S
+++ 2.6.18-rc1-mm1/arch/x86_64/kernel/entry.S
@@ -453,6 +453,21 @@ ENTRY(stub_execve)
 	CFI_ENDPROC
 END(stub_execve)
 	
+ENTRY(stub_execns)
+	CFI_STARTPROC
+	popq %r11
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_REGISTER rip, r11
+	SAVE_REST
+	FIXUP_TOP_OF_STACK %r11
+	call sys_execns
+	RESTORE_TOP_OF_STACK %r11
+	movq %rax,RAX(%rsp)
+	RESTORE_REST
+	jmp int_ret_from_sys_call
+	CFI_ENDPROC
+END(stub_execns)
+
 /*
  * sigreturn is special because it needs to restore all registers on return.
  * This cannot be done with SYSRET, so use the IRET return path instead.
@@ -1014,6 +1029,21 @@ ENTRY(execve)
 	CFI_ENDPROC
 ENDPROC(execve)
 
+ENTRY(execns)
+	CFI_STARTPROC
+	FAKE_STACK_FRAME $0
+	SAVE_ALL
+	call sys_execns
+	movq %rax, RAX(%rsp)
+	RESTORE_REST
+	testq %rax,%rax
+	je int_ret_from_sys_call
+	RESTORE_ARGS
+	UNFAKE_STACK_FRAME
+	ret
+	CFI_ENDPROC
+ENDPROC(execns)
+
 KPROBE_ENTRY(page_fault)
 	errorentry do_page_fault
 END(page_fault)
Index: 2.6.18-rc1-mm1/arch/x86_64/kernel/functionlist
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/x86_64/kernel/functionlist
+++ 2.6.18-rc1-mm1/arch/x86_64/kernel/functionlist
@@ -551,6 +551,7 @@
 *(.text.sys_getdents)
 *(.text.sys_dup)
 *(.text.stub_execve)
+*(.text.stub_execns)
 *(.text.sha_transform)
 *(.text.radix_tree_tag_clear)
 *(.text.put_unused_fd)
@@ -678,6 +679,7 @@
 *(.text.__find_symbol)
 *(.text.do_futex)
 *(.text.do_execve)
+*(.text.do_execns)
 *(.text.dirty_writeback_centisecs_handler)
 *(.text.dev_watchdog)
 *(.text.can_share_swap_page)
@@ -1098,6 +1100,7 @@
 *(.text.sys_fstat)
 *(.text.sysfs_readdir)
 *(.text.sys_execve)
+*(.text.sys_execns)
 *(.text.sysenter_tracesys)
 *(.text.sys_chown)
 *(.text.stub_clone)
Index: 2.6.18-rc1-mm1/arch/x86_64/kernel/process.c
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/x86_64/kernel/process.c
+++ 2.6.18-rc1-mm1/arch/x86_64/kernel/process.c
@@ -697,6 +697,31 @@ long sys_execve(char __user *name, char 
 	return error;
 }
 
+/*
+ * sys_execns() executes a new program and unshares selected
+ * namespaces.
+ */
+asmlinkage
+long sys_execns(int flags, char __user *name, char __user * __user *argv,
+		char __user * __user *envp, struct pt_regs regs)
+{
+	long error;
+	char * filename;
+
+	filename = getname(name);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		return error;
+	error = do_execns(flags, filename, argv, envp, &regs);
+	if (error == 0) {
+		task_lock(current);
+		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
+	putname(filename);
+	return error;
+}
+
 void set_personality_64bit(void)
 {
 	/* inherit personality from parent */
Index: 2.6.18-rc1-mm1/include/asm-x86_64/unistd.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/asm-x86_64/unistd.h
+++ 2.6.18-rc1-mm1/include/asm-x86_64/unistd.h
@@ -619,10 +619,12 @@ __SYSCALL(__NR_sync_file_range, sys_sync
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_execns		280
+__SYSCALL(__NR_execns, stub_execns)
 
 #ifdef __KERNEL__
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_execns
 #include <linux/err.h>
 
 #ifndef __NO_STUBS

--
