Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWGKHz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWGKHz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGKHzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:55:16 -0400
Received: from cimai.net4.nerim.net ([62.212.121.89]:54935 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750707AbWGKHys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:54:48 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20060711075409.113248000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 11 Jul 2006 09:50:53 +0200
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH -mm 2/7] add execns syscall to s390
Content-Disposition: inline; filename=execns-syscall-s390.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the execns() syscall to the s390 architecture.

The 32bits syscall is not implemented. 

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

--
 arch/s390/kernel/entry.S    |   10 ++++++++++
 arch/s390/kernel/entry64.S  |    8 ++++++++
 arch/s390/kernel/process.c  |   31 +++++++++++++++++++++++++++++++
 arch/s390/kernel/syscalls.S |    1 +
 include/asm-s390/unistd.h   |    3 ++-
 5 files changed, 52 insertions(+), 1 deletion(-)

Index: 2.6.18-rc1-mm1/arch/s390/kernel/entry.S
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/s390/kernel/entry.S
+++ 2.6.18-rc1-mm1/arch/s390/kernel/entry.S
@@ -410,6 +410,15 @@ sys_execve_glue:        
         bnz     0(%r12)               # it did fail -> store result in gpr2
         b       4(%r12)               # SKIP ST 2,SP_R2(15) after BASR 14,8
                                       # in system_call/sysc_tracesys
+sys_execns_glue:
+        la      %r2,SP_PTREGS(%r15)   # load pt_regs
+        l       %r1,BASED(.Lexecns)
+	lr      %r12,%r14             # save return address
+        basr    %r14,%r1              # call sys_execns
+        ltr     %r2,%r2               # check if execns failed
+        bnz     0(%r12)               # it did fail -> store result in gpr2
+        b       4(%r12)               # SKIP ST 2,SP_R2(15) after BASR 14,8
+                                      # in system_call/sysc_tracesys
 
 sys_sigreturn_glue:     
         la      %r2,SP_PTREGS(%r15)   # load pt_regs as parameter
@@ -1024,6 +1033,7 @@ cleanup_io_leave_insn:
 .Lschedule:    .long  schedule
 .Lclone:       .long  sys_clone
 .Lexecve:      .long  sys_execve
+.Lexecns:      .long  sys_execns
 .Lfork:        .long  sys_fork
 .Lrt_sigreturn:.long  sys_rt_sigreturn
 .Lrt_sigsuspend:
Index: 2.6.18-rc1-mm1/arch/s390/kernel/process.c
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/s390/kernel/process.c
+++ 2.6.18-rc1-mm1/arch/s390/kernel/process.c
@@ -343,6 +343,37 @@ out:
         return error;
 }
 
+/*
+ * sys_execns() executes a new program and unshares selected
+ * namespaces.
+ */
+asmlinkage long sys_execns(struct pt_regs regs)
+{
+        int error;
+	int flags;
+        char * filename;
+
+	flags = regs.orig_gpr2;
+        filename = getname((char __user *) regs.gprs[3]);
+        error = PTR_ERR(filename);
+        if (IS_ERR(filename))
+                goto out;
+        error = do_execns(flags, filename,
+			  (char __user * __user *) regs.gprs[4],
+			  (char __user * __user *) regs.gprs[5], &regs);
+	if (error == 0) {
+		task_lock(current);
+		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+		current->thread.fp_regs.fpc = 0;
+		if (MACHINE_HAS_IEEE)
+			asm volatile("sfpc %0,%0" : : "d" (0));
+	}
+        putname(filename);
+out:
+        return error;
+}
+
 
 /*
  * fill in the FPU structure for a core dump.
Index: 2.6.18-rc1-mm1/arch/s390/kernel/syscalls.S
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/s390/kernel/syscalls.S
+++ 2.6.18-rc1-mm1/arch/s390/kernel/syscalls.S
@@ -318,3 +318,4 @@ SYSCALL(sys_splice,sys_splice,sys_splice
 SYSCALL(sys_sync_file_range,sys_sync_file_range,sys_sync_file_range_wrapper)
 SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
+SYSCALL(sys_execns_glue,sys_execns_glue,sys_execns_glue)
Index: 2.6.18-rc1-mm1/arch/s390/kernel/entry64.S
===================================================================
--- 2.6.18-rc1-mm1.orig/arch/s390/kernel/entry64.S
+++ 2.6.18-rc1-mm1/arch/s390/kernel/entry64.S
@@ -403,6 +403,14 @@ sys_execve_glue:        
         bnz     0(%r12)               # it did fail -> store result in gpr2
         b       6(%r12)               # SKIP STG 2,SP_R2(15) in
                                       # system_call/sysc_tracesys
+sys_execns_glue:
+        la      %r2,SP_PTREGS(%r15)   # load pt_regs
+	lgr     %r12,%r14             # save return address
+        brasl   %r14,sys_execns       # call sys_execns
+        ltgr    %r2,%r2               # check if execns failed
+        bnz     0(%r12)               # it did fail -> store result in gpr2
+        b       6(%r12)               # SKIP STG 2,SP_R2(15) in
+                                      # system_call/sysc_tracesys
 #ifdef CONFIG_COMPAT
 sys32_execve_glue:        
         la      %r2,SP_PTREGS(%r15)   # load pt_regs
Index: 2.6.18-rc1-mm1/include/asm-s390/unistd.h
===================================================================
--- 2.6.18-rc1-mm1.orig/include/asm-s390/unistd.h
+++ 2.6.18-rc1-mm1/include/asm-s390/unistd.h
@@ -302,8 +302,9 @@
 #define __NR_sync_file_range	307
 #define __NR_tee		308
 #define __NR_vmsplice		309
+#define __NR_execns		310
 
-#define NR_syscalls 310
+#define NR_syscalls 311
 
 /* 
  * There are some system calls that are not present on 64 bit, some

--
