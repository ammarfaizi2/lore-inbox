Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUGDRkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUGDRkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbUGDRkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:40:47 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:23785 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S265232AbUGDRjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:39:24 -0400
Date: Sun, 4 Jul 2004 19:39:03 +0200
From: andrea@cpushare.com
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: secure computing for 2.6.7
Message-ID: <20040704173903.GE7281@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need this new kernel feature for a reseach spare time project I'm
developing in the weekends.  The fast path cost is basically only the
s/testb/testw/ change in entry.S. (and even that might be removed with a
more signficant effort but I don't think anybody could worry about that
change).

This might be better off for 2.7 but I would like if people could have a
look, and it's simple enough that it might be included in 2.6 too later
on. (it just need to be ported to the other archs, only x86 is
implemented here, but that's easy)

Especially I would like to know if anybody can see an hole in this. This
is an order of magnitude more secure of chroot and of capabilities and
much simpler and it doesn't require root privilegies to activate. I
wasn't forced to take secure computing down into kernel space but I
believe it's the simplest and most secure and most efficient approch. An
userspace alternative would been to elaborate this below bytecode
userspace approch but besides being an order of magnitude slower it also
is a lot more complicated and less secure, and it keeps into the
equation the virtual machine that executes the code later on:

	http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/286134

Furthermore I much prefer to run the bytecode on the bare hardware for
performance reasons, and the less layering the more secure.

I tested it with this:

#include <stdio.h>
#include <signal.h>
#include <unistd.h>

static void sigint(int s)
{
	printf("SIGINT\n");
}
static void sigpipe(int s)
{
	printf("SIGPIPE\n");
	pause();
}

int main(void) {

        signal(SIGINT, sigint);
        signal(SIGPIPE, sigpipe);
	printf("start\n");

	while (1);
        return 0;
}

on one shell:

andrea@xeon:~> echo 1 > /proc/`pidof seccomp`/seccomp
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGINT `pidof seccomp`
andrea@xeon:~> kill -SIGPIPE `pidof seccomp`
andrea@xeon:~> 

on the other:
andrea@xeon:~> ./seccomp
start
SIGINT
SIGINT
SIGINT
SIGINT
SIGINT
SIGINT
SIGINT
SIGPIPE
Killed
andrea@xeon:~> echo $?
137
andrea@xeon:~> 

(pause isn't allowed and the secure computing sigkill the task)

diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/arch/i386/kernel/entry.S seccomp/arch/i386/kernel/entry.S
--- 2.6.7/arch/i386/kernel/entry.S	2004-05-10 08:59:10.000000000 +0200
+++ seccomp/arch/i386/kernel/entry.S	2004-07-04 18:22:23.862198096 +0200
@@ -163,12 +163,19 @@ do_lcall:
 	movl %edx,EIP(%ebp)	# Now we move them to their "normal" places
 	movl %ecx,CS(%ebp)	#
 	GET_THREAD_INFO_WITH_ESP(%ebp)	# GET_THREAD_INFO
+	/* call gates cannot run with SECCOMP enabled */
+	testw $(_TIF_SECCOMP),TI_FLAGS(%ebp)
+	jnz sigkill
 	movl TI_EXEC_DOMAIN(%ebp), %edx	# Get the execution domain
 	call *4(%edx)		# Call the lcall7 handler for the domain
 	addl $4, %esp
 	popl %eax
 	jmp resume_userspace
 
+sigkill:
+	pushl $9
+	call do_exit		
+
 ENTRY(lcall27)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
@@ -264,7 +271,7 @@ sysenter_past_esp:
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_FLAGS(%ebp)
+	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
@@ -287,7 +294,7 @@ ENTRY(system_call)
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 					# system call tracing in operation
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),TI_FLAGS(%ebp)
+	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
 	call *sys_call_table(,%eax,4)
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/arch/i386/kernel/ptrace.c seccomp/arch/i386/kernel/ptrace.c
--- 2.6.7/arch/i386/kernel/ptrace.c	2004-05-10 08:59:10.000000000 +0200
+++ seccomp/arch/i386/kernel/ptrace.c	2004-07-04 18:23:28.597356856 +0200
@@ -15,6 +15,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
+#include <linux/seccomp.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -534,6 +535,8 @@ void do_syscall_trace(struct pt_regs *re
 			audit_syscall_exit(current, regs->eax);
 	}
 
+	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+		secure_computing(regs->orig_eax);
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/fs/proc/base.c seccomp/fs/proc/base.c
--- 2.6.7/fs/proc/base.c	2004-05-10 08:59:34.000000000 +0200
+++ seccomp/fs/proc/base.c	2004-07-04 18:43:37.103635976 +0200
@@ -32,6 +32,7 @@
 #include <linux/mount.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/seccomp.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -48,6 +49,7 @@ enum pid_directory_inos {
 	PROC_TGID_TASK,
 	PROC_TGID_STATUS,
 	PROC_TGID_MEM,
+	PROC_TGID_SECCOMP,
 	PROC_TGID_CWD,
 	PROC_TGID_ROOT,
 	PROC_TGID_EXE,
@@ -71,6 +73,7 @@ enum pid_directory_inos {
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
+	PROC_TID_SECCOMP,
 	PROC_TID_CWD,
 	PROC_TID_ROOT,
 	PROC_TID_EXE,
@@ -113,6 +116,7 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
 	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TGID_CWD,       "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_ROOT,      "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TGID_EXE,       "exe",     S_IFLNK|S_IRWXUGO),
@@ -135,6 +139,7 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
 	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
+	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
 	E(PROC_TID_CWD,        "cwd",     S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_ROOT,       "root",    S_IFLNK|S_IRWXUGO),
 	E(PROC_TID_EXE,        "exe",     S_IFLNK|S_IRWXUGO),
@@ -689,6 +694,58 @@ static struct inode_operations proc_mem_
 	.permission	= proc_permission,
 };
 
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
+
 static int proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1342,6 +1399,10 @@ static struct dentry *proc_pident_lookup
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
 			break;
+		case PROC_TID_SECCOMP:
+		case PROC_TGID_SECCOMP:
+			inode->i_fop = &proc_seccomp_operations;
+			break;
 		case PROC_TID_MOUNTS:
 		case PROC_TGID_MOUNTS:
 			inode->i_fop = &proc_mounts_operations;
Files 2.6.7/ID and seccomp/ID differ
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/include/asm-i386/thread_info.h seccomp/include/asm-i386/thread_info.h
--- 2.6.7/include/asm-i386/thread_info.h	2004-05-10 08:59:36.000000000 +0200
+++ seccomp/include/asm-i386/thread_info.h	2004-07-04 18:25:17.304830808 +0200
@@ -152,6 +152,7 @@ static inline unsigned long current_stac
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
+#define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -161,12 +162,13 @@ static inline unsigned long current_stac
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
-#define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP))
+#define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP) /* work to do on any return to u-space */
 
 /*
  * Thread-synchronous status.
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/include/linux/sched.h seccomp/include/linux/sched.h
--- 2.6.7/include/linux/sched.h	2004-05-10 08:59:41.000000000 +0200
+++ seccomp/include/linux/sched.h	2004-07-04 17:34:34.601392040 +0200
@@ -480,6 +480,7 @@ struct task_struct {
 	
 	void *security;
 	struct audit_context *audit_context;
+	unsigned int seccomp_mode;
 
 /* Thread group tracking */
    	u32 parent_exec_id;
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/include/linux/seccomp.h seccomp/include/linux/seccomp.h
--- 2.6.7/include/linux/seccomp.h	1970-01-01 01:00:00.000000000 +0100
+++ seccomp/include/linux/seccomp.h	2004-07-04 17:39:40.097949504 +0200
@@ -0,0 +1,8 @@
+#ifndef _LINUX_SECCOMP_H
+#define _LINUX_SECCOMP_H
+
+#define NR_SECCOMP_MODES 1
+
+extern void secure_computing(int);
+
+#endif /* _LINUX_SECCOMP_H */
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/kernel/Makefile seccomp/kernel/Makefile
--- 2.6.7/kernel/Makefile	2004-05-10 08:59:41.000000000 +0200
+++ seccomp/kernel/Makefile	2004-07-04 18:28:31.347331864 +0200
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o seccomp.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids 2.6.7/kernel/seccomp.c seccomp/kernel/seccomp.c
--- 2.6.7/kernel/seccomp.c	1970-01-01 01:00:00.000000000 +0100
+++ seccomp/kernel/seccomp.c	2004-07-04 19:12:51.063993472 +0200
@@ -0,0 +1,54 @@
+/*
+ * linux/kernel/seccomp.c
+ *
+ * Copyright 2004  Andrea Arcangeli <andrea@cpushare.com>
+ *
+ * This defines a simple but solid secure-computing mode.
+ */
+
+#include <linux/seccomp.h>
+#include <linux/sched.h>
+#include <asm/unistd.h>
+
+/* #define SECCOMP_DEBUG 1 */
+
+/*
+ * Secure computing mode 1 allows only read/write/close/exit.
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
+};
+
+void secure_computing(int this_syscall)
+{
+	int mode = current->seccomp_mode;
+	int * syscall;
+
+	switch (mode) {
+	case 1:
+		for (syscall = mode1_syscalls;
+		     syscall < mode1_syscalls + sizeof(mode1_syscalls)/sizeof(int);
+		     syscall++)
+			if (*syscall == this_syscall)
+				return;
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
