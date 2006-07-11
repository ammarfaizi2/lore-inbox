Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWGKNov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWGKNov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGKNov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:44:51 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5640 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750784AbWGKNot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:44:49 -0400
Subject: Re: [PATCH -mm 2/7] add execns syscall to s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060711075409.113248000@localhost.localdomain>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075409.113248000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 11 Jul 2006 15:44:47 +0200
Message-Id: <1152625488.18034.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 09:50 +0200, Cedric Le Goater wrote: 
> This patch adds the execns() syscall to the s390 architecture.

Fixed whitespace and added glue code for compat_do_execns.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

--

This patch adds the execns() syscall to the s390 architecture.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Andrey Savochkin <saw@sw.ru>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>

--- 
--
 arch/s390/kernel/compat_linux.c |   29 +++++++++++++++++++++++++++++
 arch/s390/kernel/entry.S        |   10 ++++++++++
 arch/s390/kernel/entry64.S      |   18 ++++++++++++++++++
 arch/s390/kernel/process.c      |   34 ++++++++++++++++++++++++++++++++++
 arch/s390/kernel/syscalls.S     |    1 +
 include/asm-s390/unistd.h       |    3 ++-
 kernel/sys_ni.c                 |    1 +
 7 files changed, 95 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-execns/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	2006-07-11 14:06:59.000000000 +0200
+++ linux-2.6-execns/arch/s390/kernel/compat_linux.c	2006-07-11 15:21:20.000000000 +0200
@@ -551,6 +551,35 @@ out:
         return error;
 }
 
+#ifdef CONFIG_UTS_NS
+
+asmlinkage long sys32_execns(struct pt_regs regs)
+{
+	int error;
+	int flags;
+	char * filename;
+
+	flags = regs.orig_gpr2;
+	filename = getname(compat_ptr(regs.gprs[3]));
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		goto out;
+	error = compat_do_execns(flags, filename, compat_ptr(regs.gprs[3]),
+				 compat_ptr(regs.gprs[4]), &regs);
+	if (error == 0) {
+		task_lock(current);
+		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+		current->thread.fp_regs.fpc = 0;
+		asm volatile("sfpc %0,%0" : : "d" (0));
+	}
+	putname(filename);
+out:
+	return error;
+}
+
+#endif /* CONFIG_UTS_NS */
+
 
 #ifdef CONFIG_MODULES
 
diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-execns/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2006-07-11 14:06:59.000000000 +0200
+++ linux-2.6-execns/arch/s390/kernel/entry64.S	2006-07-11 15:02:50.000000000 +0200
@@ -403,6 +403,15 @@ sys_execve_glue:        
         bnz     0(%r12)               # it did fail -> store result in gpr2
         b       6(%r12)               # SKIP STG 2,SP_R2(15) in
                                       # system_call/sysc_tracesys
+sys_execns_glue:
+	la	%r2,SP_PTREGS(%r15)   # load pt_regs
+	lgr	%r12,%r14	      # save return address
+	brasl	%r14,sys_execns       # call sys_execns
+	ltgr	%r2,%r2		      # check if execns failed
+	bnz	0(%r12)		      # it did fail -> store result in gpr2
+	b	6(%r12)		      # SKIP STG 2,SP_R2(15) in
+				      # system_call/sysc_tracesys
+
 #ifdef CONFIG_COMPAT
 sys32_execve_glue:        
         la      %r2,SP_PTREGS(%r15)   # load pt_regs
@@ -412,6 +421,15 @@ sys32_execve_glue:        
         bnz     0(%r12)               # it did fail -> store result in gpr2
         b       6(%r12)               # SKIP STG 2,SP_R2(15) in
                                       # system_call/sysc_tracesys
+
+sys32_execns_glue:
+	la	%r2,SP_PTREGS(%r15)   # load pt_regs
+	lgr	%r12,%r14	      # save return address
+	brasl	%r14,sys32_execns     # call sys_execns
+	ltgr	%r2,%r2		      # check if execns failed
+	bnz	0(%r12)		      # it did fail -> store result in gpr2
+	b	6(%r12)		      # SKIP STG 2,SP_R2(15) in
+				      # system_call/sysc_tracesys
 #endif
 
 sys_sigreturn_glue:     
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-execns/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2006-07-11 14:06:59.000000000 +0200
+++ linux-2.6-execns/arch/s390/kernel/entry.S	2006-07-11 15:02:50.000000000 +0200
@@ -410,6 +410,15 @@ sys_execve_glue:        
         bnz     0(%r12)               # it did fail -> store result in gpr2
         b       4(%r12)               # SKIP ST 2,SP_R2(15) after BASR 14,8
                                       # in system_call/sysc_tracesys
+sys_execns_glue:
+	la	%r2,SP_PTREGS(%r15)   # load pt_regs
+	l	%r1,BASED(.Lexecns)
+	lr	%r12,%r14	      # save return address
+	basr	%r14,%r1	      # call sys_execns
+	ltr	%r2,%r2		      # check if execns failed
+	bnz	0(%r12)		      # it did fail -> store result in gpr2
+	b	4(%r12)		      # SKIP ST 2,SP_R2(15) after BASR 14,8
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
diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-execns/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2006-07-11 14:06:59.000000000 +0200
+++ linux-2.6-execns/arch/s390/kernel/process.c	2006-07-11 15:22:47.000000000 +0200
@@ -343,6 +343,40 @@ out:
         return error;
 }
 
+#ifdef CONFIG_UTS_NS
+
+/*
+ * sys_execns() executes a new program and unshares selected
+ * namespaces.
+ */
+asmlinkage long sys_execns(struct pt_regs regs)
+{
+	int error;
+	int flags;
+	char * filename;
+
+	flags = regs.orig_gpr2;
+	filename = getname((char __user *) regs.gprs[3]);
+	error = PTR_ERR(filename);
+	if (IS_ERR(filename))
+		goto out;
+	error = do_execns(flags, filename,
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
+	putname(filename);
+out:
+	return error;
+}
+
+#endif /* CONFIG_UTS_NS */
 
 /*
  * fill in the FPU structure for a core dump.
diff -urpN linux-2.6/arch/s390/kernel/syscalls.S linux-2.6-execns/arch/s390/kernel/syscalls.S
--- linux-2.6/arch/s390/kernel/syscalls.S	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-execns/arch/s390/kernel/syscalls.S	2006-07-11 15:02:50.000000000 +0200
@@ -318,3 +318,4 @@ SYSCALL(sys_splice,sys_splice,sys_splice
 SYSCALL(sys_sync_file_range,sys_sync_file_range,sys_sync_file_range_wrapper)
 SYSCALL(sys_tee,sys_tee,sys_tee_wrapper)
 SYSCALL(sys_vmsplice,sys_vmsplice,compat_sys_vmsplice_wrapper)
+SYSCALL(sys_execns_glue,sys_execns_glue,sys32_execns_glue)
diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-execns/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2006-07-11 14:07:43.000000000 +0200
+++ linux-2.6-execns/include/asm-s390/unistd.h	2006-07-11 15:02:50.000000000 +0200
@@ -302,8 +302,9 @@
 #define __NR_sync_file_range	307
 #define __NR_tee		308
 #define __NR_vmsplice		309
+#define __NR_execns		310
 
-#define NR_syscalls 310
+#define NR_syscalls 311
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff -urpN linux-2.6/kernel/sys_ni.c linux-2.6-execns/kernel/sys_ni.c
--- linux-2.6/kernel/sys_ni.c	2006-07-11 14:11:23.000000000 +0200
+++ linux-2.6-execns/kernel/sys_ni.c	2006-07-11 15:21:44.000000000 +0200
@@ -121,6 +121,7 @@ cond_syscall(sys32_sysctl);
 cond_syscall(ppc_rtas);
 cond_syscall(sys_spu_run);
 cond_syscall(sys_spu_create);
+cond_syscall(sys32_execns);
 
 /* mmu depending weak syscall entries */
 cond_syscall(sys_mprotect);


