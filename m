Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVAUKID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVAUKID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 05:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVAUKHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 05:07:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61555
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262245AbVAUKGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 05:06:08 -0500
Date: Fri, 21 Jan 2005 11:06:06 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121100606.GB8042@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the seccomp patch ported to 2.6.11-rc1-bk8, that I need for
Cpushare (until trusted computing will hit the hardware market). This is
against 2.6.11-rc1-bk8. The progress is on schedule so far, so it might
not be a bad idea to merge this into the kernel sooner than later, so that
there will be some significant userbase capable of running the Cpushare client
as soon as it becomes available (plus I won't have to forward port the patch
all the time ;). Getting this merged anytime before the end of 2005 is going to
be fundamental for my project if my forecasts will turn out to be correct
(which is not guaranteed, but if I'm wrong that could also mean I need it
sooner ;), but anyway there is no short term urgency, so even 2.6.12/13 will be
ok, but if you can merge it now it's even better and it'll certainly save me
some time.

I remember you asked for syscalls, I can add them but I wouldn't mind to
be able to get/set the value still from the /proc API. I don't really
feel the need of syscalls, this is all but a fast path. The overhead of
creating the pipes and forking would be significant too. Ideally I could
add syscalls to make it easier to use in chroot environment (just in
case someone feels the need to stack seccomp on top of chroot), that's
the only reason why syscalls might ever be useful. But this is still is
nice to have in /proc at least in readonly mode, so I see the current
patch as a good starting point and as valid code for the long term (not
overlapping with syscalls since `cat/echo` cannot be used with the syscalls).

As usual this is theoretically useful to run any kind of untrusted
bytecode on the computer. This means also code that might have bugs.
Like to decompress a mpeg stream securely regardless of the decoder lib,
or stuff like that. I've no idea if somebody is going to use it for that
though. I only know I'm going to use it with Cpushare 8).

Works for me:

andrea@dualathlon:~/cpushare/client/cpushare> python seccomp_test.py 
gcc -march=i686 -Os -Wall -fomit-frame-pointer -fno-common seccomp-loader.c -o seccomp-loader
gcc -c -march=i686 -Os -Wall -fomit-frame-pointer -fno-common bytecode.c -o bytecode.o
cpp bytecode.lds.S -o bytecode.lds.s
grep -A100000000 SECTION bytecode.lds.s > bytecode.lds
ld -T bytecode.lds bytecode.o /usr/lib/gcc-lib/i586-suse-linux/3.3.4/libgcc.a /usr/lib/libc.a /usr/lib/libm.a -N -o bytecode
objcopy -O binary bytecode -j .text bytecode.text.bin
objcopy -O binary bytecode -j .data bytecode.data.bin
gcc -c -march=i686 -Os -Wall -fomit-frame-pointer -fno-common -DMALICIOUS bytecode.c -o bytecode-malicious.o
ld -T bytecode.lds bytecode-malicious.o /usr/lib/gcc-lib/i586-suse-linux/3.3.4/libgcc.a /usr/lib/libc.a /usr/lib/libm.a -N -o bytecode-malicious
objcopy -O binary bytecode-malicious -j .text bytecode-malicious.text.bin
objcopy -O binary bytecode-malicious -j .data bytecode-malicious.data.bin
Starting computing some malicious bytecode
init
load
start
stop
receive_data failure
kill
exit_code 0 signal 9
The malicious bytecode has been killed successfully by seccomp
Starting computing some safe bytecode
init
load
start
stop
1509 counts
kill
exit_code 0 signal 0
The seccomp_test.py completed successfully, thank you for testing.
andrea@dualathlon:~/cpushare/client/cpushare> 

Thanks.
 
--- xxx/arch/i386/Kconfig	2005-01-21 09:14:54.000000000 +0100
+++ xx/arch/i386/Kconfig	2005-01-21 09:07:57.000000000 +0100
@@ -33,6 +33,10 @@ config GENERIC_IOMAP
 	bool
 	default y
 
+config SECCOMP
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"
--- xxx/arch/i386/kernel/entry.S	2005-01-15 20:44:49.000000000 +0100
+++ xx/arch/i386/kernel/entry.S	2005-01-21 09:07:57.000000000 +0100
@@ -221,7 +221,8 @@ sysenter_past_esp:
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
 
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
+	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
@@ -245,7 +246,8 @@ ENTRY(system_call)
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
 					# system call tracing in operation
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
+	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
--- xxx/arch/i386/kernel/ptrace.c	2005-01-15 20:44:49.000000000 +0100
+++ xx/arch/i386/kernel/ptrace.c	2005-01-21 09:07:57.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
+#include <linux/seccomp.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -678,6 +679,10 @@ void send_sigtrap(struct task_struct *ts
 __attribute__((regparm(3)))
 void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+	/* do the secure computing check first */
+	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+		secure_computing(regs->orig_eax);
+
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
--- xxx/arch/x86_64/ia32/ia32entry.S	2005-01-21 09:14:54.000000000 +0100
+++ xx/arch/x86_64/ia32/ia32entry.S	2005-01-21 09:07:57.000000000 +0100
@@ -78,7 +78,7 @@ ENTRY(ia32_sysenter_target)
  	.quad 1b,ia32_badarg
  	.previous	
 	GET_THREAD_INFO(%r10)
-	testl  $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%r10)
+	testl  $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
 	jnz  sysenter_tracesys
 sysenter_do_call:	
 	cmpl	$(IA32_NR_syscalls),%eax
@@ -163,7 +163,7 @@ ENTRY(ia32_cstar_target)
 	.quad 1b,ia32_badarg
 	.previous	
 	GET_THREAD_INFO(%r10)
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%r10)
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
 	jnz   cstar_tracesys
 cstar_do_call:	
 	cmpl $IA32_NR_syscalls,%eax
@@ -236,7 +236,7 @@ ENTRY(ia32_syscall)
 	   this could be a problem. */
 	SAVE_ARGS 0,0,1
 	GET_THREAD_INFO(%r10)
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%r10)
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
 	jnz ia32_tracesys
 ia32_do_syscall:	
 	cmpl $(IA32_NR_syscalls),%eax
--- xxx/arch/x86_64/Kconfig	2005-01-15 20:44:50.000000000 +0100
+++ xx/arch/x86_64/Kconfig	2005-01-21 09:07:57.000000000 +0100
@@ -87,6 +87,10 @@ config GENERIC_IOMAP
 	bool
 	default y
 
+config SECCOMP
+	bool
+	default y
+
 source "init/Kconfig"
 
 
--- xxx/arch/x86_64/kernel/entry.S	2005-01-15 20:44:50.000000000 +0100
+++ xx/arch/x86_64/kernel/entry.S	2005-01-21 09:07:57.000000000 +0100
@@ -185,7 +185,7 @@ ENTRY(system_call)
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) 
 	movq  %rcx,RIP-ARGOFFSET(%rsp)  
 	GET_THREAD_INFO(%rcx)
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%rcx)
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%rcx)
 	jnz tracesys
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
--- xxx/arch/x86_64/kernel/ptrace.c	2005-01-04 01:13:11.000000000 +0100
+++ xx/arch/x86_64/kernel/ptrace.c	2005-01-21 09:07:57.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
+#include <linux/seccomp.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -521,6 +522,10 @@ static void syscall_trace(struct pt_regs
 
 asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 {
+	/* do the secure computing check first */
+	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+		secure_computing(regs->orig_rax);
+
 	if (unlikely(current->audit_context))
 		audit_syscall_entry(current, regs->orig_rax,
 				    regs->rdi, regs->rsi,
--- xxx/fs/proc/base.c	2005-01-15 20:44:58.000000000 +0100
+++ xx/fs/proc/base.c	2005-01-21 09:07:57.000000000 +0100
@@ -32,6 +32,9 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#ifdef CONFIG_SECCOMP
+#include <linux/seccomp.h>
+#endif
 #include "internal.h"
 
 /*
@@ -49,6 +52,9 @@ enum pid_directory_inos {
 	PROC_TGID_TASK,
 	PROC_TGID_STATUS,
 	PROC_TGID_MEM,
+#ifdef CONFIG_SECCOMP
+	PROC_TGID_SECCOMP,
+#endif
 	PROC_TGID_CWD,
 	PROC_TGID_ROOT,
 	PROC_TGID_EXE,
@@ -75,6 +81,9 @@ enum pid_directory_inos {
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
+#ifdef CONFIG_SECCOMP
+	PROC_TID_SECCOMP,
+#endif
 	PROC_TID_CWD,
 	PROC_TID_ROOT,
 	PROC_TID_EXE,
@@ -120,6 +129,9 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
 	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+#ifdef CONFIG_SECCOMP
+	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
+#endif
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
@@ -145,6 +157,9 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
 	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+#ifdef CONFIG_SECCOMP
+	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
+#endif
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
@@ -661,6 +676,60 @@ static struct inode_operations proc_mem_
 	.permission	= proc_permission,
 };
 
+#ifdef CONFIG_SECCOMP
+static ssize_t seccomp_read(struct file * file, char * buf,
+			    size_t count, loff_t *ppos)
+{
+	struct task_struct * tsk = proc_task(file->f_dentry->d_inode);
+	char __buf[20];
+	loff_t __ppos = *ppos;
+	size_t len;
+
+	len = sprintf(__buf, "%u\n", tsk->seccomp_mode) + 1;
+	if (__ppos >= len)
+		return 0;
+	if (count > len-__ppos)
+		count = len-__ppos;
+	if (copy_to_user(buf, __buf + __ppos, count))
+		return -EFAULT;
+	*ppos += count;
+	return count;
+}
+
+static ssize_t seccomp_write(struct file * file, const char * buf,
+			     size_t count, loff_t *ppos)
+{
+	struct task_struct * tsk = proc_task(file->f_dentry->d_inode);
+	char __buf[20], * end;
+	unsigned int seccomp_mode;
+
+	/* can set it only once to be even more secure */
+	if (unlikely(tsk->seccomp_mode))
+		return -EPERM;
+
+	memset(__buf, 0, 20);
+	if (count > 19)
+		count = 19;
+	if (copy_from_user(__buf, buf, count))
+		return -EFAULT;
+	seccomp_mode = simple_strtoul(__buf, &end, 0);
+	if (*end == '\n')
+		end++;
+	if (seccomp_mode && seccomp_mode <= NR_SECCOMP_MODES) {
+		tsk->seccomp_mode = seccomp_mode;
+		set_tsk_thread_flag(tsk, TIF_SECCOMP);
+	}
+	if (unlikely(!(end - __buf)))
+		return -EIO;
+	return end - __buf;
+}
+
+static struct file_operations proc_seccomp_operations = {
+	.read		= seccomp_read,
+	.write		= seccomp_write,
+};
+#endif /* CONFIG_SECCOMP */
+
 static int proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1296,6 +1365,12 @@ static struct dentry *proc_pident_lookup
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
 			break;
+#ifdef CONFIG_SECCOMP
+		case PROC_TID_SECCOMP:
+		case PROC_TGID_SECCOMP:
+			inode->i_fop = &proc_seccomp_operations;
+			break;
+#endif /* CONFIG_SECCOMP */
 		case PROC_TID_MOUNTS:
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
--- xxx/include/asm-i386/thread_info.h	2005-01-04 01:13:27.000000000 +0100
+++ xx/include/asm-i386/thread_info.h	2005-01-21 09:07:57.000000000 +0100
@@ -140,6 +140,7 @@ register unsigned long current_stack_poi
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
+#define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -149,12 +150,14 @@ register unsigned long current_stack_poi
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
-#define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP|_TIF_SECCOMP))
+/* work to do on any return to u-space */
+#define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
 /*
  * Thread-synchronous status.
--- xxx/include/asm-x86_64/thread_info.h	2005-01-04 01:13:29.000000000 +0100
+++ xx/include/asm-x86_64/thread_info.h	2005-01-21 09:07:57.000000000 +0100
@@ -102,6 +102,7 @@ static inline struct thread_info *stack_
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_IRET		5	/* force IRET */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
+#define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
@@ -114,6 +115,7 @@ static inline struct thread_info *stack_
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)
@@ -121,9 +123,9 @@ static inline struct thread_info *stack_
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP|_TIF_SECCOMP))
 /* work to do on any return to user space */
-#define _TIF_ALLWORK_MASK 0x0000FFFF	
+#define _TIF_ALLWORK_MASK (0x0000FFFF & ~_TIF_SECCOMP)
 
 #define PREEMPT_ACTIVE     0x10000000
 
--- xxx/include/linux/sched.h	2005-01-21 09:14:55.000000000 +0100
+++ xx/include/linux/sched.h	2005-01-21 09:07:57.000000000 +0100
@@ -643,6 +643,7 @@ struct task_struct {
 	
 	void *security;
 	struct audit_context *audit_context;
+	unsigned int seccomp_mode;
 
 /* Thread group tracking */
    	u32 parent_exec_id;
--- xxx/include/linux/seccomp.h	1970-01-01 01:00:00.000000000 +0100
+++ xx/include/linux/seccomp.h	2005-01-21 09:07:57.000000000 +0100
@@ -0,0 +1,8 @@
+#ifndef _LINUX_SECCOMP_H
+#define _LINUX_SECCOMP_H
+
+#define NR_SECCOMP_MODES 1
+
+extern void secure_computing(int);
+
+#endif /* _LINUX_SECCOMP_H */
--- xxx/kernel/Makefile	2005-01-04 01:13:30.000000000 +0100
+++ xx/kernel/Makefile	2005-01-21 09:07:57.000000000 +0100
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o
+	    kthread.o wait.o kfifo.o sys_ni.o seccomp.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- xxx/kernel/seccomp.c	1970-01-01 01:00:00.000000000 +0100
+++ xx/kernel/seccomp.c	2005-01-21 09:07:57.000000000 +0100
@@ -0,0 +1,74 @@
+/*
+ * linux/kernel/seccomp.c
+ *
+ * Copyright 2004-2005  Andrea Arcangeli <andrea@cpushare.com>
+ *
+ * This defines a simple but solid secure-computing mode.
+ */
+
+#include <linux/seccomp.h>
+#include <linux/sched.h>
+#include <asm/unistd.h>
+#ifdef TIF_IA32
+#include <asm/ia32_unistd.h>
+#endif
+
+/* #define SECCOMP_DEBUG 1 */
+
+/*
+ * Secure computing mode 1 allows only read/write/exit/sigreturn.
+ * To be fully secure this must be combined with rlimit
+ * to limit the stack allocations too.
+ */
+static int mode1_syscalls[] = {
+	__NR_read, __NR_write, __NR_exit,
+	/*
+	 * Allow either sigreturn or rt_sigreturn, newer archs
+	 * like x86-64 only defines __NR_rt_sigreturn.
+	 */
+#ifdef __NR_sigreturn
+	__NR_sigreturn,
+#else
+	__NR_rt_sigreturn,
+#endif
+	0, /* null terminated */
+};
+
+#ifdef TIF_IA32
+static int mode1_syscalls_32bit[] = {
+	__NR_ia32_read, __NR_ia32_write, __NR_ia32_exit,
+	/*
+	 * Allow either sigreturn or rt_sigreturn, newer archs
+	 * like x86-64 only defines __NR_rt_sigreturn.
+	 */
+	__NR_ia32_sigreturn,
+	0, /* null terminated */
+};
+#endif
+
+void secure_computing(int this_syscall)
+{
+	int mode = current->seccomp_mode;
+	int * syscall;
+
+	switch (mode) {
+	case 1:
+		syscall = mode1_syscalls;
+#ifdef TIF_IA32
+		if (test_thread_flag(TIF_IA32))
+			syscall = mode1_syscalls_32bit;
+#endif
+		do {
+			if (*syscall == this_syscall)
+				return;
+		} while (*++syscall);
+		break;
+	default:
+		BUG();
+	}
+
+#ifdef SECCOMP_DEBUG
+	dump_stack();
+#endif
+	do_exit(SIGKILL);
+}
