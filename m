Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbUKHPO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUKHPO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUKHPO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:14:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4804 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261881AbUKHOgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:36:14 -0500
Date: Mon, 8 Nov 2004 14:34:17 GMT
Message-Id: <200411081434.iA8EYHii023530@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 7/20] FRV: Fujitsu FR-V CPU arch implementation part 5
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches provides part 5 of an architecture implementation
for the Fujitsu FR-V CPU series, configurably as Linux or uClinux.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-arch_5-2610rc1mm3.diff
 ptrace.c    |  771 ++++++++++++++++++++++++++++++++++++++
 semaphore.c |  142 +++++++
 setup.c     | 1202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 signal.c    |  595 +++++++++++++++++++++++++++++
 sleep.S     |  356 +++++++++++++++++
 switch_to.S |  486 ++++++++++++++++++++++++
 6 files changed, 3552 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/ptrace.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/ptrace.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/ptrace.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/ptrace.c	2004-11-05 14:13:03.199555230 +0000
@@ -0,0 +1,771 @@
+/*
+ *  linux/arch/m68k/kernel/ptrace.c
+ *
+ *  Copyright (C) 1994 by Hamish Macdonald
+ *  Taken from linux/kernel/ptrace.c and modified for M680x0.
+ *  linux/kernel/ptrace.c is by Ross Biro 1/23/92, edited by Linus Torvalds
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/user.h>
+#include <linux/config.h>
+#include <linux/security.h>
+
+#include <asm/uaccess.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/unistd.h>
+
+/*
+ * does not yet catch signals sent when the child dies.
+ * in exit.c or in signal.c.
+ */
+
+/* determines which bits in the SR the user has access to. */
+/* 1 = access 0 = no access */
+#define SR_MASK 0x001f
+
+/* sets the trace bits. */
+#define TRACE_BITS 0x8000
+
+/*
+ * Get contents of register REGNO in task TASK.
+ */
+static inline long get_reg(struct task_struct *task, int regno)
+{
+	struct user_context *user = task->thread.user;
+
+	if (regno < 0 || regno >= PT__END)
+		return 0;
+
+	return ((unsigned long *) user)[regno];
+}
+
+/*
+ * Write contents of register REGNO in task TASK.
+ */
+static inline int put_reg(struct task_struct *task, int regno,
+			  unsigned long data)
+{
+	struct user_context *user = task->thread.user;
+
+	if (regno < 0 || regno >= PT__END)
+		return -EIO;
+
+	switch (regno) {
+	case PT_GR(0):
+		return 0;
+	case PT_PSR:
+	case PT__STATUS:
+		return -EIO;
+	default:
+		((unsigned long *) user)[regno] = data;
+		return 0;
+	}
+}
+
+/*
+ * check that an address falls within the bounds of the target process's memory mappings
+ */
+static inline int is_user_addr_valid(struct task_struct *child,
+				     unsigned long start, unsigned long len)
+{
+#ifdef CONFIG_MMU
+	if (start >= PAGE_OFFSET || len > PAGE_OFFSET - start)
+		return -EIO;
+	return 0;
+#else
+	struct mm_tblock_struct *tblock;
+
+	for (tblock = child->mm->context.tblock; tblock; tblock = tblock->next)
+		if (start >= tblock->vma->vm_start && start + len <= tblock->vma->vm_end)
+			return 0;
+
+	return -EIO;
+#endif
+}
+
+/*
+ * Called by kernel/ptrace.c when detaching..
+ *
+ * Control h/w single stepping
+ */
+void ptrace_disable(struct task_struct *child)
+{
+	child->thread.frame0->__status &= ~REG__STATUS_STEP;
+}
+
+void ptrace_enable(struct task_struct *child)
+{
+	child->thread.frame0->__status |= REG__STATUS_STEP;
+}
+
+asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
+{
+	struct task_struct *child;
+	unsigned long tmp;
+	int ret;
+
+	lock_kernel();
+	ret = -EPERM;
+	if (request == PTRACE_TRACEME) {
+		/* are we already being traced? */
+		if (current->ptrace & PT_PTRACED)
+			goto out;
+		ret = security_ptrace(current->parent, current);
+		if (ret)
+			goto out;
+		/* set the ptrace bit in the process flags. */
+		current->ptrace |= PT_PTRACED;
+		ret = 0;
+		goto out;
+	}
+	ret = -ESRCH;
+	read_lock(&tasklist_lock);
+	child = find_task_by_pid(pid);
+	if (child)
+		get_task_struct(child);
+	read_unlock(&tasklist_lock);
+	if (!child)
+		goto out;
+
+	ret = -EPERM;
+	if (pid == 1)		/* you may not mess with init */
+		goto out_tsk;
+
+	if (request == PTRACE_ATTACH) {
+		ret = ptrace_attach(child);
+		goto out_tsk;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		goto out_tsk;
+
+	switch (request) {
+		/* when I and D space are separate, these will need to be fixed. */
+	case PTRACE_PEEKTEXT: /* read word at location addr. */
+	case PTRACE_PEEKDATA: {
+		int copied;
+
+		ret = -EIO;
+		if (is_user_addr_valid(child, addr, sizeof(tmp)) < 0)
+			break;
+
+		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+		if (copied != sizeof(tmp))
+			break;
+
+		ret = put_user(tmp,(unsigned long *) data);
+		break;
+	}
+
+		/* read the word at location addr in the USER area. */
+	case PTRACE_PEEKUSR: {
+		tmp = 0;
+		ret = -EIO;
+		if ((addr & 3) || addr < 0)
+			break;
+
+		ret = 0;
+		switch (addr >> 2) {
+		case 0 ... PT__END - 1:
+			tmp = get_reg(child, addr >> 2);
+			break;
+
+		case PT__END + 0:
+			tmp = child->mm->end_code - child->mm->start_code;
+			break;
+
+		case PT__END + 1:
+			tmp = child->mm->end_data - child->mm->start_data;
+			break;
+
+		case PT__END + 2:
+			tmp = child->mm->start_stack - child->mm->start_brk;
+			break;
+
+		case PT__END + 3:
+			tmp = child->mm->start_code;
+			break;
+
+		case PT__END + 4:
+			tmp = child->mm->start_stack;
+			break;
+
+		default:
+			ret = -EIO;
+			break;
+		}
+
+		if (ret == 0)
+			ret = put_user(tmp, (unsigned long *) data);
+		break;
+	}
+
+		/* when I and D space are separate, this will have to be fixed. */
+	case PTRACE_POKETEXT: /* write the word at location addr. */
+	case PTRACE_POKEDATA:
+		ret = -EIO;
+		if (is_user_addr_valid(child, addr, sizeof(tmp)) < 0)
+			break;
+		if (access_process_vm(child, addr, &data, sizeof(data), 1) != sizeof(data))
+			break;
+		ret = 0;
+		break;
+
+	case PTRACE_POKEUSR: /* write the word at location addr in the USER area */
+		ret = -EIO;
+		if ((addr & 3) || addr < 0)
+			break;
+
+		ret = 0;
+		switch (addr >> 2) {
+		case 0 ... PT__END-1:
+			ret = put_reg(child, addr >> 2, data);
+			break;
+
+		default:
+			ret = -EIO;
+			break;
+		}
+		break;
+
+	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
+	case PTRACE_CONT: /* restart after signal. */
+		ret = -EIO;
+		if ((unsigned long) data > _NSIG)
+			break;
+		if (request == PTRACE_SYSCALL)
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		else
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		child->exit_code = data;
+		ptrace_disable(child);
+		wake_up_process(child);
+		ret = 0;
+		break;
+
+		/* make the child exit.  Best I can do is send it a sigkill.
+		 * perhaps it should be put in the status that it wants to
+		 * exit.
+		 */
+	case PTRACE_KILL:
+		ret = 0;
+		if (child->exit_state == EXIT_ZOMBIE)	/* already dead */
+			break;
+		child->exit_code = SIGKILL;
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+		ptrace_disable(child);
+		wake_up_process(child);
+		break;
+
+	case PTRACE_SINGLESTEP:  /* set the trap flag. */
+		ret = -EIO;
+		if ((unsigned long) data > _NSIG)
+			break;
+		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		ptrace_enable(child);
+		child->exit_code = data;
+		wake_up_process(child);
+		ret = 0;
+		break;
+
+	case PTRACE_DETACH:	/* detach a process that was attached. */
+		ret = ptrace_detach(child, data);
+		break;
+
+	case PTRACE_GETREGS: { /* Get all integer regs from the child. */
+		int i;
+		for (i = 0; i < PT__GPEND; i++) {
+			tmp = get_reg(child, i);
+			if (put_user(tmp, (unsigned long *) data)) {
+				ret = -EFAULT;
+				break;
+			}
+			data += sizeof(long);
+		}
+		ret = 0;
+		break;
+	}
+
+	case PTRACE_SETREGS: { /* Set all integer regs in the child. */
+		int i;
+		for (i = 0; i < PT__GPEND; i++) {
+			if (get_user(tmp, (unsigned long *) data)) {
+				ret = -EFAULT;
+				break;
+			}
+			put_reg(child, i, tmp);
+			data += sizeof(long);
+		}
+		ret = 0;
+		break;
+	}
+
+	case PTRACE_GETFPREGS: { /* Get the child FP/Media state. */
+		ret = 0;
+		if (copy_to_user((void *) data,
+				 &child->thread.user->f,
+				 sizeof(child->thread.user->f)))
+			ret = -EFAULT;
+		break;
+	}
+
+	case PTRACE_SETFPREGS: { /* Set the child FP/Media state. */
+		ret = 0;
+		if (copy_from_user(&child->thread.user->f,
+				   (void *) data,
+				   sizeof(child->thread.user->f)))
+			ret = -EFAULT;
+		break;
+	}
+
+	case PTRACE_GETFDPIC:
+		tmp = 0;
+		switch (addr) {
+		case PTRACE_GETFDPIC_EXEC:
+			tmp = child->mm->context.exec_fdpic_loadmap;
+			break;
+		case PTRACE_GETFDPIC_INTERP:
+			tmp = child->mm->context.interp_fdpic_loadmap;
+			break;
+		default:
+			break;
+		}
+
+		ret = 0;
+		if (put_user(tmp, (unsigned long *) data)) {
+			ret = -EFAULT;
+			break;
+		}
+		break;
+
+	default:
+		ret = -EIO;
+		break;
+	}
+out_tsk:
+	free_task_struct(child);
+out:
+	unlock_kernel();
+	return ret;
+}
+
+int __nongprelbss kstrace;
+
+static const struct {
+	const char	*name;
+	unsigned	argmask;
+} __syscall_name_table[NR_syscalls] = {
+	[0]	= { "restart_syscall"			},
+	[1]	= { "exit",		0x000001	},
+	[2]	= { "fork",		0xffffff	},
+	[3]	= { "read",		0x000141	},
+	[4]	= { "write",		0x000141	},
+	[5]	= { "open",		0x000235	},
+	[6]	= { "close",		0x000001	},
+	[7]	= { "waitpid",		0x000141	},
+	[8]	= { "creat",		0x000025	},
+	[9]	= { "link",		0x000055	},
+	[10]	= { "unlink",		0x000005	},
+	[11]	= { "execve",		0x000445	},
+	[12]	= { "chdir",		0x000005	},
+	[13]	= { "time",		0x000004	},
+	[14]	= { "mknod",		0x000325	},
+	[15]	= { "chmod",		0x000025	},
+	[16]	= { "lchown",		0x000025	},
+	[17]	= { "break" },
+	[18]	= { "oldstat",		0x000045	},
+	[19]	= { "lseek",		0x000131	},
+	[20]	= { "getpid",		0xffffff	},
+	[21]	= { "mount",		0x043555	},
+	[22]	= { "umount",		0x000005	},
+	[23]	= { "setuid",		0x000001	},
+	[24]	= { "getuid",		0xffffff	},
+	[25]	= { "stime",		0x000004	},
+	[26]	= { "ptrace",		0x004413	},
+	[27]	= { "alarm",		0x000001	},
+	[28]	= { "oldfstat",		0x000041	},
+	[29]	= { "pause",		0xffffff	},
+	[30]	= { "utime",		0x000045	},
+	[31]	= { "stty" },
+	[32]	= { "gtty" },
+	[33]	= { "access",		0x000025	},
+	[34]	= { "nice",		0x000001	},
+	[35]	= { "ftime" },
+	[36]	= { "sync",		0xffffff	},
+	[37]	= { "kill",		0x000011	},
+	[38]	= { "rename",		0x000055	},
+	[39]	= { "mkdir",		0x000025	},
+	[40]	= { "rmdir",		0x000005	},
+	[41]	= { "dup",		0x000001	},
+	[42]	= { "pipe",		0x000004	},
+	[43]	= { "times",		0x000004	},
+	[44]	= { "prof" },
+	[45]	= { "brk",		0x000004	},
+	[46]	= { "setgid",		0x000001	},
+	[47]	= { "getgid",		0xffffff	},
+	[48]	= { "signal",		0x000041	},
+	[49]	= { "geteuid",		0xffffff	},
+	[50]	= { "getegid",		0xffffff	},
+	[51]	= { "acct",		0x000005	},
+	[52]	= { "umount2",		0x000035	},
+	[53]	= { "lock" },
+	[54]	= { "ioctl",		0x000331	},
+	[55]	= { "fcntl",		0x000331	},
+	[56]	= { "mpx" },
+	[57]	= { "setpgid",		0x000011	},
+	[58]	= { "ulimit" },
+	[60]	= { "umask",		0x000002	},
+	[61]	= { "chroot",		0x000005	},
+	[62]	= { "ustat",		0x000043	},
+	[63]	= { "dup2",		0x000011	},
+	[64]	= { "getppid",		0xffffff	},
+	[65]	= { "getpgrp",		0xffffff	},
+	[66]	= { "setsid",		0xffffff	},
+	[67]	= { "sigaction" },
+	[68]	= { "sgetmask" },
+	[69]	= { "ssetmask" },
+	[70]	= { "setreuid" },
+	[71]	= { "setregid" },
+	[72]	= { "sigsuspend" },
+	[73]	= { "sigpending" },
+	[74]	= { "sethostname" },
+	[75]	= { "setrlimit" },
+	[76]	= { "getrlimit" },
+	[77]	= { "getrusage" },
+	[78]	= { "gettimeofday" },
+	[79]	= { "settimeofday" },
+	[80]	= { "getgroups" },
+	[81]	= { "setgroups" },
+	[82]	= { "select" },
+	[83]	= { "symlink" },
+	[84]	= { "oldlstat" },
+	[85]	= { "readlink" },
+	[86]	= { "uselib" },
+	[87]	= { "swapon" },
+	[88]	= { "reboot" },
+	[89]	= { "readdir" },
+	[91]	= { "munmap",		0x000034	},
+	[92]	= { "truncate" },
+	[93]	= { "ftruncate" },
+	[94]	= { "fchmod" },
+	[95]	= { "fchown" },
+	[96]	= { "getpriority" },
+	[97]	= { "setpriority" },
+	[99]	= { "statfs" },
+	[100]	= { "fstatfs" },
+	[102]	= { "socketcall" },
+	[103]	= { "syslog" },
+	[104]	= { "setitimer" },
+	[105]	= { "getitimer" },
+	[106]	= { "stat" },
+	[107]	= { "lstat" },
+	[108]	= { "fstat" },
+	[111]	= { "vhangup" },
+	[114]	= { "wait4" },
+	[115]	= { "swapoff" },
+	[116]	= { "sysinfo" },
+	[117]	= { "ipc" },
+	[118]	= { "fsync" },
+	[119]	= { "sigreturn" },
+	[120]	= { "clone" },
+	[121]	= { "setdomainname" },
+	[122]	= { "uname" },
+	[123]	= { "modify_ldt" },
+	[123]	= { "cacheflush" },
+	[124]	= { "adjtimex" },
+	[125]	= { "mprotect" },
+	[126]	= { "sigprocmask" },
+	[127]	= { "create_module" },
+	[128]	= { "init_module" },
+	[129]	= { "delete_module" },
+	[130]	= { "get_kernel_syms" },
+	[131]	= { "quotactl" },
+	[132]	= { "getpgid" },
+	[133]	= { "fchdir" },
+	[134]	= { "bdflush" },
+	[135]	= { "sysfs" },
+	[136]	= { "personality" },
+	[137]	= { "afs_syscall" },
+	[138]	= { "setfsuid" },
+	[139]	= { "setfsgid" },
+	[140]	= { "_llseek",			0x014331	},
+	[141]	= { "getdents" },
+	[142]	= { "_newselect",		0x000141	},
+	[143]	= { "flock" },
+	[144]	= { "msync" },
+	[145]	= { "readv" },
+	[146]	= { "writev" },
+	[147]	= { "getsid",			0x000001	},
+	[148]	= { "fdatasync",		0x000001	},
+	[149]	= { "_sysctl",			0x000004	},
+	[150]	= { "mlock" },
+	[151]	= { "munlock" },
+	[152]	= { "mlockall" },
+	[153]	= { "munlockall" },
+	[154]	= { "sched_setparam" },
+	[155]	= { "sched_getparam" },
+	[156]	= { "sched_setscheduler" },
+	[157]	= { "sched_getscheduler" },
+	[158]	= { "sched_yield" },
+	[159]	= { "sched_get_priority_max" },
+	[160]	= { "sched_get_priority_min" },
+	[161]	= { "sched_rr_get_interval" },
+	[162]	= { "nanosleep",		0x000044	},
+	[163]	= { "mremap" },
+	[164]	= { "setresuid" },
+	[165]	= { "getresuid" },
+	[166]	= { "vm86" },
+	[167]	= { "query_module" },
+	[168]	= { "poll" },
+	[169]	= { "nfsservctl" },
+	[170]	= { "setresgid" },
+	[171]	= { "getresgid" },
+	[172]	= { "prctl",			0x333331	},
+	[173]	= { "rt_sigreturn",		0xffffff	},
+	[174]	= { "rt_sigaction",		0x001441	},
+	[175]	= { "rt_sigprocmask",		0x001441	},
+	[176]	= { "rt_sigpending",		0x000014	},
+	[177]	= { "rt_sigtimedwait",		0x001444	},
+	[178]	= { "rt_sigqueueinfo",		0x000411	},
+	[179]	= { "rt_sigsuspend",		0x000014	},
+	[180]	= { "pread",			0x003341	},
+	[181]	= { "pwrite",			0x003341	},
+	[182]	= { "chown",			0x000115	},
+	[183]	= { "getcwd" },
+	[184]	= { "capget" },
+	[185]	= { "capset" },
+	[186]	= { "sigaltstack" },
+	[187]	= { "sendfile" },
+	[188]	= { "getpmsg" },
+	[189]	= { "putpmsg" },
+	[190]	= { "vfork",			0xffffff	},
+	[191]	= { "ugetrlimit" },
+	[192]	= { "mmap2",			0x313314	},
+	[193]	= { "truncate64" },
+	[194]	= { "ftruncate64" },
+	[195]	= { "stat64",			0x000045	},
+	[196]	= { "lstat64",			0x000045	},
+	[197]	= { "fstat64",			0x000041	},
+	[198]	= { "lchown32" },
+	[199]	= { "getuid32",			0xffffff	},
+	[200]	= { "getgid32",			0xffffff	},
+	[201]	= { "geteuid32",		0xffffff	},
+	[202]	= { "getegid32",		0xffffff	},
+	[203]	= { "setreuid32" },
+	[204]	= { "setregid32" },
+	[205]	= { "getgroups32" },
+	[206]	= { "setgroups32" },
+	[207]	= { "fchown32" },
+	[208]	= { "setresuid32" },
+	[209]	= { "getresuid32" },
+	[210]	= { "setresgid32" },
+	[211]	= { "getresgid32" },
+	[212]	= { "chown32" },
+	[213]	= { "setuid32" },
+	[214]	= { "setgid32" },
+	[215]	= { "setfsuid32" },
+	[216]	= { "setfsgid32" },
+	[217]	= { "pivot_root" },
+	[218]	= { "mincore" },
+	[219]	= { "madvise" },
+	[220]	= { "getdents64" },
+	[221]	= { "fcntl64" },
+	[223]	= { "security" },
+	[224]	= { "gettid" },
+	[225]	= { "readahead" },
+	[226]	= { "setxattr" },
+	[227]	= { "lsetxattr" },
+	[228]	= { "fsetxattr" },
+	[229]	= { "getxattr" },
+	[230]	= { "lgetxattr" },
+	[231]	= { "fgetxattr" },
+	[232]	= { "listxattr" },
+	[233]	= { "llistxattr" },
+	[234]	= { "flistxattr" },
+	[235]	= { "removexattr" },
+	[236]	= { "lremovexattr" },
+	[237]	= { "fremovexattr" },
+	[238]	= { "tkill" },
+	[239]	= { "sendfile64" },
+	[240]	= { "futex" },
+	[241]	= { "sched_setaffinity" },
+	[242]	= { "sched_getaffinity" },
+	[243]	= { "set_thread_area" },
+	[244]	= { "get_thread_area" },
+	[245]	= { "io_setup" },
+	[246]	= { "io_destroy" },
+	[247]	= { "io_getevents" },
+	[248]	= { "io_submit" },
+	[249]	= { "io_cancel" },
+	[250]	= { "fadvise64" },
+	[252]	= { "exit_group",		0x000001	},
+	[253]	= { "lookup_dcookie" },
+	[254]	= { "epoll_create" },
+	[255]	= { "epoll_ctl" },
+	[256]	= { "epoll_wait" },
+	[257]	= { "remap_file_pages" },
+	[258]	= { "set_tid_address" },
+	[259]	= { "timer_create" },
+	[260]	= { "timer_settime" },
+	[261]	= { "timer_gettime" },
+	[262]	= { "timer_getoverrun" },
+	[263]	= { "timer_delete" },
+	[264]	= { "clock_settime" },
+	[265]	= { "clock_gettime" },
+	[266]	= { "clock_getres" },
+	[267]	= { "clock_nanosleep" },
+	[268]	= { "statfs64" },
+	[269]	= { "fstatfs64" },
+	[270]	= { "tgkill" },
+	[271]	= { "utimes" },
+	[272]	= { "fadvise64_64" },
+	[273]	= { "vserver" },
+	[274]	= { "mbind" },
+	[275]	= { "get_mempolicy" },
+	[276]	= { "set_mempolicy" },
+	[277]	= { "mq_open" },
+	[278]	= { "mq_unlink" },
+	[279]	= { "mq_timedsend" },
+	[280]	= { "mq_timedreceive" },
+	[281]	= { "mq_notify" },
+	[282]	= { "mq_getsetattr" },
+	[283]	= { "sys_kexec_load" },
+};
+
+asmlinkage void do_syscall_trace(int leaving)
+{
+#if 0
+	unsigned long *argp;
+	const char *name;
+	unsigned argmask;
+	char buffer[16];
+
+	if (!kstrace)
+		return;
+
+	if (!current->mm)
+		return;
+
+	if (__frame->gr7 == __NR_close)
+		return;
+
+#if 0
+	if (__frame->gr7 != __NR_mmap2 &&
+	    __frame->gr7 != __NR_vfork &&
+	    __frame->gr7 != __NR_execve &&
+	    __frame->gr7 != __NR_exit)
+		return;
+#endif
+
+	argmask = 0;
+	name = NULL;
+	if (__frame->gr7 < NR_syscalls) {
+		name = __syscall_name_table[__frame->gr7].name;
+		argmask = __syscall_name_table[__frame->gr7].argmask;
+	}
+	if (!name) {
+		sprintf(buffer, "sys_%lx", __frame->gr7);
+		name = buffer;
+	}
+
+	if (!leaving) {
+		if (!argmask) {
+			printk(KERN_CRIT "[%d] %s(%lx,%lx,%lx,%lx,%lx,%lx)\n",
+			       current->pid,
+			       name,
+			       __frame->gr8,
+			       __frame->gr9,
+			       __frame->gr10,
+			       __frame->gr11,
+			       __frame->gr12,
+			       __frame->gr13);
+		}
+		else if (argmask == 0xffffff) {
+			printk(KERN_CRIT "[%d] %s()\n",
+			       current->pid,
+			       name);
+		}
+		else {
+			printk(KERN_CRIT "[%d] %s(",
+			       current->pid,
+			       name);
+
+			argp = &__frame->gr8;
+
+			do {
+				switch (argmask & 0xf) {
+				case 1:
+					printk("%ld", (long) *argp);
+					break;
+				case 2:
+					printk("%lo", *argp);
+					break;
+				case 3:
+					printk("%lx", *argp);
+					break;
+				case 4:
+					printk("%p", (void *) *argp);
+					break;
+				case 5:
+					printk("\"%s\"", (char *) *argp);
+					break;
+				}
+
+				argp++;
+				argmask >>= 4;
+				if (argmask)
+					printk(",");
+
+			} while (argmask);
+
+			printk(")\n");
+		}
+	}
+	else {
+		if ((int)__frame->gr8 > -4096 && (int)__frame->gr8 < 4096)
+			printk(KERN_CRIT "[%d] %s() = %ld\n", current->pid, name, __frame->gr8);
+		else
+			printk(KERN_CRIT "[%d] %s() = %lx\n", current->pid, name, __frame->gr8);
+	}
+	return;
+#endif
+
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+		return;
+
+	if (!(current->ptrace & PT_PTRACED))
+		return;
+
+	/* we need to indicate entry or exit to strace */
+	if (leaving)
+		__frame->__status |= REG__STATUS_SYSC_EXIT;
+	else
+		__frame->__status |= REG__STATUS_SYSC_ENTRY;
+
+	ptrace_notify(SIGTRAP);
+
+	/*
+	 * this isn't the same as continuing with a signal, but it will do
+	 * for normal use.  strace only continues with a signal if the
+	 * stopping signal is not SIGTRAP.  -brl
+	 */
+	if (current->exit_code) {
+		send_sig(current->exit_code, current, 1);
+		current->exit_code = 0;
+	}
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/semaphore.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/semaphore.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/semaphore.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/semaphore.c	2004-11-05 14:13:03.207554554 +0000
@@ -0,0 +1,142 @@
+/* semaphore.c: FR-V semaphores
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from lib/rwsem-spinlock.c
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <asm/semaphore.h>
+
+struct sem_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+};
+
+#if SEM_DEBUG
+void semtrace(struct semaphore *sem, const char *str)
+{
+	if (sem->debug)
+		printk("[%d] %s({%d,%d})\n",
+		       current->pid,
+		       str,
+		       sem->counter,
+		       list_empty(&sem->wait_list) ? 0 : 1);
+}
+#else
+#define semtrace(SEM,STR) do { } while(0)
+#endif
+
+/*
+ * wait for a token to be granted from a semaphore
+ * - entered with lock held and interrupts disabled
+ */
+void __down(struct semaphore *sem, unsigned long flags)
+{
+	struct task_struct *tsk = current;
+	struct sem_waiter waiter;
+
+	semtrace(sem,"Entering __down");
+
+	/* set up my own style of waitqueue */
+	waiter.task	= tsk;
+
+	list_add_tail(&waiter.list, &sem->wait_list);
+
+	/* we don't need to touch the semaphore struct anymore */
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+
+	/* wait to be given the lock */
+	set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+
+	for (;;) {
+		if (list_empty(&waiter.list))
+			break;
+		schedule();
+		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+	}
+
+	tsk->state = TASK_RUNNING;
+	semtrace(sem,"Leaving __down");
+}
+
+EXPORT_SYMBOL(__down);
+
+/*
+ * interruptibly wait for a token to be granted from a semaphore
+ * - entered with lock held and interrupts disabled
+ */
+int __down_interruptible(struct semaphore *sem, unsigned long flags)
+{
+	struct task_struct *tsk = current;
+	struct sem_waiter waiter;
+	int ret;
+
+	semtrace(sem,"Entering __down_interruptible");
+
+	/* set up my own style of waitqueue */
+	waiter.task = tsk;
+
+	list_add_tail(&waiter.list, &sem->wait_list);
+
+	/* we don't need to touch the semaphore struct anymore */
+	set_task_state(tsk, TASK_INTERRUPTIBLE);
+
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+
+	/* wait to be given the lock */
+	ret = 0;
+	for (;;) {
+		if (list_empty(&waiter.list))
+			break;
+		if (unlikely(signal_pending(current)))
+			goto interrupted;
+		schedule();
+		set_task_state(tsk, TASK_INTERRUPTIBLE);
+	}
+
+ out:
+	tsk->state = TASK_RUNNING;
+	semtrace(sem, "Leaving __down_interruptible");
+	return ret;
+
+ interrupted:
+	spin_lock_irqsave(&sem->wait_lock, flags);
+
+	if (!list_empty(&waiter.list)) {
+		list_del(&waiter.list);
+		ret = -EINTR;
+	}
+
+	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	goto out;
+}
+
+EXPORT_SYMBOL(__down_interruptible);
+
+/*
+ * release a single token back to a semaphore
+ * - entered with lock held and interrupts disabled
+ */
+void __up(struct semaphore *sem)
+{
+	struct sem_waiter *waiter;
+
+	semtrace(sem,"Entering __up");
+
+	/* grant the token to the process at the front of the queue */
+	waiter = list_entry(sem->wait_list.next, struct sem_waiter, list);
+	list_del_init(&waiter->list);
+	wake_up_process(waiter->task);
+
+	semtrace(sem,"Leaving __up");
+}
+
+EXPORT_SYMBOL(__up);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/setup.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/setup.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/setup.c	2004-11-05 14:13:03.213554048 +0000
@@ -0,0 +1,1202 @@
+/*
+ *  linux/arch/frvnommu/kernel/setup.c
+ *
+ *  Copyleft  ()) 2000       James D. Schettine {james@telos-systems.com}
+ *  Copyright (C) 1999-2003  Greg Ungerer (gerg@snapgear.com)
+ *  Copyright (C) 1998,1999  D. Jeff Dionne <jeff@lineo.ca>
+ *  Copyright (C) 1998       Kenneth Albanowski <kjahds@kjahds.com>
+ *  Copyright (C) 1995       Hamish Macdonald
+ *  Copyright (C) 2000       Lineo Inc. (www.lineo.com)
+ *  Copyright (C) 2001 	     Lineo, Inc. <www.lineo.com>
+ *  Copyright (C) 2003 	     David Howells <dhowells@redhat.com>, Red Hat, Inc.
+ */
+
+/*
+ * This file handles the architecture-dependent parts of system setup
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/fb.h>
+#include <linux/console.h>
+#include <linux/genhd.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/major.h>
+#include <linux/bootmem.h>
+#include <linux/highmem.h>
+#include <linux/seq_file.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+#include <asm/setup.h>
+#include <asm/serial.h>
+#include <asm/irq.h>
+#include <asm/sections.h>
+#include <asm/pgalloc.h>
+#include <asm/busctl-regs.h>
+#include <asm/serial-regs.h>
+#include <asm/timer-regs.h>
+#include <asm/irc-regs.h>
+#include <asm/spr-regs.h>
+#include <asm/mb-regs.h>
+#include <asm/mb93493-regs.h>
+#include <asm/gdb-stub.h>
+#include <asm/irq-routing.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#include <linux/blk.h>
+#include <asm/pgtable.h>
+#endif
+
+#include "local.h"
+
+#ifdef CONFIG_MB93090_MB00
+static void __init mb93090_display(void);
+#endif
+#ifdef CONFIG_MMU
+static void __init setup_linux_memory(void);
+#else
+static void __init setup_uclinux_memory(void);
+#endif
+
+#ifdef CONFIG_CONSOLE
+extern struct consw *conswitchp;
+#ifdef CONFIG_FRAMEBUFFER
+extern struct consw fb_con;
+#endif
+#endif
+
+#ifdef CONFIG_MB93090_MB00
+static char __initdata mb93090_banner[] = "FJ/RH FR-V Linux";
+static char __initdata mb93090_version[] = UTS_RELEASE;
+
+int __nongprelbss mb93090_mb00_detected;
+#endif
+
+const char __frv_unknown_system[] = "unknown";
+const char __frv_mb93091_cb10[] = "mb93091-cb10";
+const char __frv_mb93091_cb11[] = "mb93091-cb11";
+const char __frv_mb93091_cb30[] = "mb93091-cb30";
+const char __frv_mb93091_cb41[] = "mb93091-cb41";
+const char __frv_mb93091_cb60[] = "mb93091-cb60";
+const char __frv_mb93091_cb70[] = "mb93091-cb70";
+const char __frv_mb93091_cb451[] = "mb93091-cb451";
+const char __frv_mb93090_mb00[] = "mb93090-mb00";
+
+const char __frv_mb93493[] = "mb93493";
+
+const char __frv_mb93093[] = "mb93093";
+
+static const char *__nongprelbss cpu_series;
+static const char *__nongprelbss cpu_core;
+static const char *__nongprelbss cpu_silicon;
+static const char *__nongprelbss cpu_mmu;
+static const char *__nongprelbss cpu_system;
+static const char *__nongprelbss cpu_board1;
+static const char *__nongprelbss cpu_board2;
+
+static unsigned long __nongprelbss cpu_psr_all;
+static unsigned long __nongprelbss cpu_hsr0_all;
+
+unsigned long __nongprelbss pdm_suspend_mode;
+
+unsigned long __nongprelbss rom_length;
+unsigned long __nongprelbss memory_start;
+unsigned long __nongprelbss memory_end;
+
+unsigned long __nongprelbss dma_coherent_mem_start;
+unsigned long __nongprelbss dma_coherent_mem_end;
+
+unsigned long __initdata __sdram_old_base;
+unsigned long __initdata num_mappedpages;
+
+struct cpuinfo_frv __nongprelbss boot_cpu_data;
+
+char command_line[COMMAND_LINE_SIZE];
+char __initdata redboot_command_line[COMMAND_LINE_SIZE];
+
+#ifdef CONFIG_PM
+#define __pminit
+#define __pminitdata
+#else
+#define __pminit __init
+#define __pminitdata __initdata
+#endif
+
+struct clock_cmode {
+	uint8_t	xbus, sdram, corebus, core, dsu;
+};
+
+#define _frac(N,D) ((N)<<4 | (D))
+#define _x0_16	_frac(1,6)
+#define _x0_25	_frac(1,4)
+#define _x0_33	_frac(1,3)
+#define _x0_375	_frac(3,8)
+#define _x0_5	_frac(1,2)
+#define _x0_66	_frac(2,3)
+#define _x0_75	_frac(3,4)
+#define _x1	_frac(1,1)
+#define _x1_5	_frac(3,2)
+#define _x2	_frac(2,1)
+#define _x3	_frac(3,1)
+#define _x4	_frac(4,1)
+#define _x4_5	_frac(9,2)
+#define _x6	_frac(6,1)
+#define _x8	_frac(8,1)
+#define _x9	_frac(9,1)
+
+int __nongprelbss clock_p0_current;
+int __nongprelbss clock_cm_current;
+int __nongprelbss clock_cmode_current;
+#ifdef CONFIG_PM
+int __nongprelbss clock_cmodes_permitted;
+unsigned long __nongprelbss clock_bits_settable;
+#endif
+
+static struct clock_cmode __pminitdata undef_clock_cmode = { _x1, _x1, _x1, _x1, _x1 };
+
+static struct clock_cmode __pminitdata clock_cmodes_fr401_fr403[16] = {
+	[4]	= {	_x1,	_x1,	_x2,	_x2,	_x0_25	},
+	[5]	= { 	_x1,	_x2,	_x4,	_x4,	_x0_5	},
+	[8]	= { 	_x1,	_x1,	_x1,	_x2,	_x0_25	},
+	[9]	= { 	_x1,	_x2,	_x2,	_x4,	_x0_5	},
+	[11]	= { 	_x1,	_x4,	_x4,	_x8,	_x1	},
+	[12]	= { 	_x1,	_x1,	_x2,	_x4,	_x0_5	},
+	[13]	= { 	_x1,	_x2,	_x4,	_x8,	_x1	},
+};
+
+static struct clock_cmode __pminitdata clock_cmodes_fr405[16] = {
+	[0]	= {	_x1,	_x1,	_x1,	_x1,	_x0_5	},
+	[1]	= {	_x1,	_x1,	_x1,	_x3,	_x0_25	},
+	[2]	= {	_x1,	_x1,	_x2,	_x6,	_x0_5	},
+	[3]	= {	_x1,	_x2,	_x2,	_x6,	_x0_5	},
+	[4]	= {	_x1,	_x1,	_x2,	_x2,	_x0_16	},
+	[8]	= { 	_x1,	_x1,	_x1,	_x2,	_x0_16	},
+	[9]	= { 	_x1,	_x2,	_x2,	_x4,	_x0_33	},
+	[12]	= { 	_x1,	_x1,	_x2,	_x4,	_x0_33	},
+	[14]	= { 	_x1,	_x3,	_x3,	_x9,	_x0_75	},
+	[15]	= { 	_x1,	_x1_5,	_x1_5,	_x4_5,	_x0_375	},
+
+#define CLOCK_CMODES_PERMITTED_FR405 0xd31f
+};
+
+static struct clock_cmode __pminitdata clock_cmodes_fr555[16] = {
+	[0]	= {	_x1,	_x2,	_x2,	_x4,	_x0_33	},
+	[1]	= {	_x1,	_x3,	_x3,	_x6,	_x0_5	},
+	[2]	= {	_x1,	_x2,	_x4,	_x8,	_x0_66	},
+	[3]	= {	_x1,	_x1_5,	_x3,	_x6,	_x0_5	},
+	[4]	= {	_x1,	_x3,	_x3,	_x9,	_x0_75	},
+	[5]	= {	_x1,	_x2,	_x2,	_x6,	_x0_5	},
+	[6]	= {	_x1,	_x1_5,	_x1_5,	_x4_5,	_x0_375	},
+};
+
+static const struct clock_cmode __pminitdata *clock_cmodes;
+static int __pminitdata clock_doubled;
+
+static struct uart_port __initdata __frv_uart0 = {
+	.uartclk		= 0,
+	.membase		= (char *) UART0_BASE,
+	.irq			= IRQ_CPU_UART0,
+	.regshift		= 3,
+	.iotype			= UPIO_MEM,
+	.flags			= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+};
+
+static struct uart_port __initdata __frv_uart1 = {
+	.uartclk		= 0,
+	.membase		= (char *) UART1_BASE,
+	.irq			= IRQ_CPU_UART1,
+	.regshift		= 3,
+	.iotype			= UPIO_MEM,
+	.flags			= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+};
+
+#if 0
+static void __init printk_xampr(unsigned long ampr, unsigned long amlr, char i_d, int n)
+{
+	unsigned long phys, virt, cxn, size;
+
+#ifdef CONFIG_MMU
+	virt = amlr & 0xffffc000;
+	cxn = amlr & 0x3fff;
+#else
+	virt = ampr & 0xffffc000;
+	cxn = 0;
+#endif
+	phys = ampr & xAMPRx_PPFN;
+	size = 1 << (((ampr & xAMPRx_SS) >> 4) + 17);
+
+	printk("%cAMPR%d: va %08lx-%08lx [pa %08lx] %c%c%c%c [cxn:%04lx]\n",
+	       i_d, n,
+	       virt, virt + size - 1,
+	       phys,
+	       ampr & xAMPRx_S  ? 'S' : '-',
+	       ampr & xAMPRx_C  ? 'C' : '-',
+	       ampr & DAMPRx_WP ? 'W' : '-',
+	       ampr & xAMPRx_V  ? 'V' : '-',
+	       cxn
+	       );
+}
+#endif
+
+/*****************************************************************************/
+/*
+ * dump the memory map
+ */
+static void __init dump_memory_map(void)
+{
+
+#if 0
+	/* dump the protection map */
+	printk_xampr(__get_IAMPR(0),  __get_IAMLR(0),  'I', 0);
+	printk_xampr(__get_IAMPR(1),  __get_IAMLR(1),  'I', 1);
+	printk_xampr(__get_IAMPR(2),  __get_IAMLR(2),  'I', 2);
+	printk_xampr(__get_IAMPR(3),  __get_IAMLR(3),  'I', 3);
+	printk_xampr(__get_IAMPR(4),  __get_IAMLR(4),  'I', 4);
+	printk_xampr(__get_IAMPR(5),  __get_IAMLR(5),  'I', 5);
+	printk_xampr(__get_IAMPR(6),  __get_IAMLR(6),  'I', 6);
+	printk_xampr(__get_IAMPR(7),  __get_IAMLR(7),  'I', 7);
+	printk_xampr(__get_IAMPR(8),  __get_IAMLR(8),  'I', 8);
+	printk_xampr(__get_IAMPR(9),  __get_IAMLR(9),  'i', 9);
+	printk_xampr(__get_IAMPR(10), __get_IAMLR(10), 'I', 10);
+	printk_xampr(__get_IAMPR(11), __get_IAMLR(11), 'I', 11);
+	printk_xampr(__get_IAMPR(12), __get_IAMLR(12), 'I', 12);
+	printk_xampr(__get_IAMPR(13), __get_IAMLR(13), 'I', 13);
+	printk_xampr(__get_IAMPR(14), __get_IAMLR(14), 'I', 14);
+	printk_xampr(__get_IAMPR(15), __get_IAMLR(15), 'I', 15);
+
+	printk_xampr(__get_DAMPR(0),  __get_DAMLR(0),  'D', 0);
+	printk_xampr(__get_DAMPR(1),  __get_DAMLR(1),  'D', 1);
+	printk_xampr(__get_DAMPR(2),  __get_DAMLR(2),  'D', 2);
+	printk_xampr(__get_DAMPR(3),  __get_DAMLR(3),  'D', 3);
+	printk_xampr(__get_DAMPR(4),  __get_DAMLR(4),  'D', 4);
+	printk_xampr(__get_DAMPR(5),  __get_DAMLR(5),  'D', 5);
+	printk_xampr(__get_DAMPR(6),  __get_DAMLR(6),  'D', 6);
+	printk_xampr(__get_DAMPR(7),  __get_DAMLR(7),  'D', 7);
+	printk_xampr(__get_DAMPR(8),  __get_DAMLR(8),  'D', 8);
+	printk_xampr(__get_DAMPR(9),  __get_DAMLR(9),  'D', 9);
+	printk_xampr(__get_DAMPR(10), __get_DAMLR(10), 'D', 10);
+	printk_xampr(__get_DAMPR(11), __get_DAMLR(11), 'D', 11);
+	printk_xampr(__get_DAMPR(12), __get_DAMLR(12), 'D', 12);
+	printk_xampr(__get_DAMPR(13), __get_DAMLR(13), 'D', 13);
+	printk_xampr(__get_DAMPR(14), __get_DAMLR(14), 'D', 14);
+	printk_xampr(__get_DAMPR(15), __get_DAMLR(15), 'D', 15);
+#endif
+
+#if 0
+	/* dump the bus controller registers */
+	printk("LGCR: %08lx\n", __get_LGCR());
+	printk("Master: %08lx-%08lx CR=%08lx\n",
+	       __get_LEMBR(), __get_LEMBR() + __get_LEMAM(),
+	       __get_LMAICR());
+
+	int loop;
+	for (loop = 1; loop <= 7; loop++) {
+		unsigned long lcr = __get_LCR(loop), lsbr = __get_LSBR(loop);
+		printk("CS#%d: %08lx-%08lx %c%c%c%c%c%c%c%c%c\n",
+		       loop,
+		       lsbr, lsbr + __get_LSAM(loop),
+		       lcr & 0x80000000 ? 'r' : '-',
+		       lcr & 0x40000000 ? 'w' : '-',
+		       lcr & 0x08000000 ? 'b' : '-',
+		       lcr & 0x04000000 ? 'B' : '-',
+		       lcr & 0x02000000 ? 'C' : '-',
+		       lcr & 0x01000000 ? 'D' : '-',
+		       lcr & 0x00800000 ? 'W' : '-',
+		       lcr & 0x00400000 ? 'R' : '-',
+		       (lcr & 0x00030000) == 0x00000000 ? '4' :
+		       (lcr & 0x00030000) == 0x00010000 ? '2' :
+		       (lcr & 0x00030000) == 0x00020000 ? '1' :
+		       '-'
+		       );
+	}
+#endif
+
+#if 0
+	printk("\n");
+#endif
+} /* end dump_memory_map() */
+
+/*****************************************************************************/
+/*
+ * attempt to detect a VDK motherboard and DAV daughter board on an MB93091 system
+ */
+#ifdef CONFIG_MB93091_VDK
+static void __init detect_mb93091(void)
+{
+#ifdef CONFIG_MB93090_MB00
+	/* Detect CB70 without motherboard */
+	if (!(cpu_system == __frv_mb93091_cb70 && ((*(unsigned short *)0xffc00030) & 0x100))) {
+		cpu_board1 = __frv_mb93090_mb00;
+		mb93090_mb00_detected = 1;
+	}
+#endif
+
+#ifdef CONFIG_FUJITSU_MB93493
+	cpu_board2 = __frv_mb93493;
+#endif
+
+} /* end detect_mb93091() */
+#endif
+
+/*****************************************************************************/
+/*
+ * determine the CPU type and set appropriate parameters
+ *
+ * Family     Series      CPU Core    Silicon    Imple  Vers
+ * ----------------------------------------------------------
+ * FR-V --+-> FR400 --+-> FR401 --+-> MB93401     02     00 [1]
+ *        |           |           |
+ *        |           |           +-> MB93401/A   02     01
+ *        |           |           |
+ *        |           |           +-> MB93403     02     02
+ *        |           |
+ *        |           +-> FR405 ----> MB93405     04     00
+ *        |
+ *        +-> FR450 ----> FR451 ----> MB93451     05     00
+ *        |
+ *        +-> FR500 ----> FR501 --+-> MB93501     01     01 [2]
+ *        |                       |
+ *        |                       +-> MB93501/A   01     02
+ *        |
+ *        +-> FR550 --+-> FR551 ----> MB93555     03     01
+ *
+ *  [1] The MB93401 is an obsolete CPU replaced by the MB93401A
+ *  [2] The MB93501 is an obsolete CPU replaced by the MB93501A
+ *
+ * Imple is PSR(Processor Status Register)[31:28].
+ * Vers is PSR(Processor Status Register)[27:24].
+ *
+ * A "Silicon" consists of CPU core and some on-chip peripherals.
+ */
+static void __init determine_cpu(void)
+{
+	unsigned long hsr0 = __get_HSR(0);
+	unsigned long psr = __get_PSR();
+
+	/* work out what selectable services the CPU supports */
+	__set_PSR(psr | PSR_EM | PSR_EF | PSR_CM | PSR_NEM);
+	cpu_psr_all = __get_PSR();
+	__set_PSR(psr);
+
+	__set_HSR(0, hsr0 | HSR0_GRLE | HSR0_GRHE | HSR0_FRLE | HSR0_FRHE);
+	cpu_hsr0_all = __get_HSR(0);
+	__set_HSR(0, hsr0);
+
+	/* derive other service specs from the CPU type */
+	cpu_series		= "unknown";
+	cpu_core		= "unknown";
+	cpu_silicon		= "unknown";
+	cpu_mmu			= "Prot";
+	cpu_system		= __frv_unknown_system;
+	clock_cmodes		= NULL;
+	clock_doubled		= 0;
+#ifdef CONFIG_PM
+	clock_bits_settable	= CLOCK_BIT_CM_H | CLOCK_BIT_CM_M | CLOCK_BIT_P0;
+#endif
+
+	switch (PSR_IMPLE(psr)) {
+	case PSR_IMPLE_FR401:
+		cpu_series	= "fr400";
+		cpu_core	= "fr401";
+		pdm_suspend_mode = HSR0_PDM_PLL_RUN;
+
+		switch (PSR_VERSION(psr)) {
+		case PSR_VERSION_FR401_MB93401:
+			cpu_silicon	= "mb93401";
+			cpu_system	= __frv_mb93091_cb10;
+			clock_cmodes	= clock_cmodes_fr401_fr403;
+			clock_doubled	= 1;
+			break;
+		case PSR_VERSION_FR401_MB93401A:
+			cpu_silicon	= "mb93401/A";
+			cpu_system	= __frv_mb93091_cb11;
+			clock_cmodes	= clock_cmodes_fr401_fr403;
+			break;
+		case PSR_VERSION_FR401_MB93403:
+			cpu_silicon	= "mb93403";
+#ifndef CONFIG_MB93093_PDK
+			cpu_system	= __frv_mb93091_cb30;
+#else
+			cpu_system	= __frv_mb93093;
+#endif
+			clock_cmodes	= clock_cmodes_fr401_fr403;
+			break;
+		default:
+			break;
+		}
+		break;
+
+	case PSR_IMPLE_FR405:
+		cpu_series	= "fr400";
+		cpu_core	= "fr405";
+		pdm_suspend_mode = HSR0_PDM_PLL_STOP;
+
+		switch (PSR_VERSION(psr)) {
+		case PSR_VERSION_FR405_MB93405:
+			cpu_silicon	= "mb93405";
+			cpu_system	= __frv_mb93091_cb60;
+			clock_cmodes	= clock_cmodes_fr405;
+#ifdef CONFIG_PM
+			clock_bits_settable |= CLOCK_BIT_CMODE;
+			clock_cmodes_permitted = CLOCK_CMODES_PERMITTED_FR405;
+#endif
+
+			/* the FPGA on the CB70 has extra registers
+			 * - it has 0x0046 in the VDK_ID FPGA register at 0x1a0, which is
+			 *   how we tell the difference between it and a CB60
+			 */
+			if (*(volatile unsigned short *) 0xffc001a0 == 0x0046)
+				cpu_system = __frv_mb93091_cb70;
+			break;
+		default:
+			break;
+		}
+		break;
+
+	case PSR_IMPLE_FR451:
+		cpu_series	= "fr450";
+		cpu_core	= "fr451";
+		pdm_suspend_mode = HSR0_PDM_PLL_STOP;
+#ifdef CONFIG_PM
+		clock_bits_settable |= CLOCK_BIT_CMODE;
+		clock_cmodes_permitted = CLOCK_CMODES_PERMITTED_FR405;
+#endif
+		switch (PSR_VERSION(psr)) {
+		case PSR_VERSION_FR451_MB93451:
+			cpu_silicon	= "mb93451";
+			cpu_mmu		= "Prot, SAT, xSAT, DAT";
+			cpu_system	= __frv_mb93091_cb451;
+			clock_cmodes	= clock_cmodes_fr405;
+			break;
+		default:
+			break;
+		}
+		break;
+
+	case PSR_IMPLE_FR501:
+		cpu_series	= "fr500";
+		cpu_core	= "fr501";
+		pdm_suspend_mode = HSR0_PDM_PLL_STOP;
+
+		switch (PSR_VERSION(psr)) {
+		case PSR_VERSION_FR501_MB93501:  cpu_silicon = "mb93501";   break;
+		case PSR_VERSION_FR501_MB93501A: cpu_silicon = "mb93501/A"; break;
+		default:
+			break;
+		}
+		break;
+
+	case PSR_IMPLE_FR551:
+		cpu_series	= "fr550";
+		cpu_core	= "fr551";
+		pdm_suspend_mode = HSR0_PDM_PLL_STOP;
+
+		switch (PSR_VERSION(psr)) {
+		case PSR_VERSION_FR551_MB93555:
+			cpu_silicon	= "mb93555";
+			cpu_mmu		= "Prot, SAT";
+			cpu_system	= __frv_mb93091_cb41;
+			clock_cmodes	= clock_cmodes_fr555;
+			clock_doubled	= 1;
+			break;
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	printk("- Series:%s CPU:%s Silicon:%s\n",
+	       cpu_series, cpu_core, cpu_silicon);
+
+#ifdef CONFIG_MB93091_VDK
+	detect_mb93091();
+#endif
+
+#if defined(CONFIG_MB93093_PDK) && defined(CONFIG_FUJITSU_MB93493)
+	cpu_board2 = __frv_mb93493;
+#endif
+
+} /* end determine_cpu() */
+
+/*****************************************************************************/
+/*
+ * calculate the bus clock speed
+ */
+void __pminit determine_clocks(int verbose)
+{
+	const struct clock_cmode *mode, *tmode;
+	unsigned long clkc, psr, quot;
+
+	clkc = __get_CLKC();
+	psr = __get_PSR();
+
+	clock_p0_current = !!(clkc & CLKC_P0);
+	clock_cm_current = clkc & CLKC_CM;
+	clock_cmode_current = (clkc & CLKC_CMODE) >> CLKC_CMODE_s;
+
+	if (verbose)
+		printk("psr=%08lx hsr0=%08lx clkc=%08lx\n", psr, __get_HSR(0), clkc);
+
+	/* the CB70 has some alternative ways of setting the clock speed through switches accessed
+	 * through the FPGA.  */
+	if (cpu_system == __frv_mb93091_cb70) {
+		unsigned short clkswr = *(volatile unsigned short *) 0xffc00104UL & 0x1fffUL;
+
+		if (clkswr & 0x1000)
+			__clkin_clock_speed_HZ = 60000000UL;
+		else
+			__clkin_clock_speed_HZ =
+				((clkswr >> 8) & 0xf) * 10000000 +
+				((clkswr >> 4) & 0xf) * 1000000 +
+				((clkswr     ) & 0xf) * 100000;
+	}
+	/* the FR451 is currently fixed at 24MHz */
+	else if (cpu_system == __frv_mb93091_cb451) {
+		//__clkin_clock_speed_HZ = 24000000UL; // CB451-FPGA
+		unsigned short clkswr = *(volatile unsigned short *) 0xffc00104UL & 0x1fffUL;
+
+		if (clkswr & 0x1000)
+			__clkin_clock_speed_HZ = 60000000UL;
+		else
+			__clkin_clock_speed_HZ =
+				((clkswr >> 8) & 0xf) * 10000000 +
+				((clkswr >> 4) & 0xf) * 1000000 +
+				((clkswr     ) & 0xf) * 100000;
+	}
+	/* otherwise determine the clockspeed from VDK or other registers */
+	else {
+		__clkin_clock_speed_HZ = __get_CLKIN();
+	}
+
+	/* look up the appropriate clock relationships table entry */
+	mode = &undef_clock_cmode;
+	if (clock_cmodes) {
+		tmode = &clock_cmodes[(clkc & CLKC_CMODE) >> CLKC_CMODE_s];
+		if (tmode->xbus)
+			mode = tmode;
+	}
+
+#define CLOCK(SRC,RATIO) ((SRC) * (((RATIO) >> 4) & 0x0f) / ((RATIO) & 0x0f))
+
+	if (clock_doubled)
+		__clkin_clock_speed_HZ <<= 1;
+
+	__ext_bus_clock_speed_HZ	= CLOCK(__clkin_clock_speed_HZ, mode->xbus);
+	__sdram_clock_speed_HZ		= CLOCK(__clkin_clock_speed_HZ, mode->sdram);
+	__dsu_clock_speed_HZ		= CLOCK(__clkin_clock_speed_HZ, mode->dsu);
+
+	switch (clkc & CLKC_CM) {
+	case 0: /* High */
+		__core_bus_clock_speed_HZ	= CLOCK(__clkin_clock_speed_HZ, mode->corebus);
+		__core_clock_speed_HZ		= CLOCK(__clkin_clock_speed_HZ, mode->core);
+		break;
+	case 1: /* Medium */
+		__core_bus_clock_speed_HZ	= CLOCK(__clkin_clock_speed_HZ, mode->sdram);
+		__core_clock_speed_HZ		= CLOCK(__clkin_clock_speed_HZ, mode->sdram);
+		break;
+	case 2: /* Low; not supported */
+	case 3: /* UNDEF */
+		printk("Unsupported CLKC CM %ld\n", clkc & CLKC_CM);
+		panic("Bye");
+	}
+
+	__res_bus_clock_speed_HZ = __ext_bus_clock_speed_HZ;
+	if (clkc & CLKC_P0)
+		__res_bus_clock_speed_HZ >>= 1;
+
+	if (verbose) {
+		printk("CLKIN: %lu.%3.3luMHz\n",
+		       __clkin_clock_speed_HZ / 1000000,
+		       (__clkin_clock_speed_HZ / 1000) % 1000);
+
+		printk("CLKS:"
+		       " ext=%luMHz res=%luMHz sdram=%luMHz cbus=%luMHz core=%luMHz dsu=%luMHz\n",
+		       __ext_bus_clock_speed_HZ / 1000000,
+		       __res_bus_clock_speed_HZ / 1000000,
+		       __sdram_clock_speed_HZ / 1000000,
+		       __core_bus_clock_speed_HZ / 1000000,
+		       __core_clock_speed_HZ / 1000000,
+		       __dsu_clock_speed_HZ / 1000000
+		       );
+	}
+
+	/* calculate the number of __delay() loop iterations per sec (2 insn loop) */
+	__delay_loops_MHz = __core_clock_speed_HZ / (1000000 * 2);
+
+	/* set the serial prescaler */
+	__serial_clock_speed_HZ = __res_bus_clock_speed_HZ;
+	quot = 1;
+	while (__serial_clock_speed_HZ / quot / 16 / 65536 > 3000)
+		quot += 1;
+
+	/* double the divisor if P0 is clear, so that if/when P0 is set, it's still achievable
+	 * - we have to be careful - dividing too much can mean we can't get 115200 baud
+	 */
+	if (__serial_clock_speed_HZ > 32000000 && !(clkc & CLKC_P0))
+		quot <<= 1;
+
+	__serial_clock_speed_HZ /= quot;
+	__frv_uart0.uartclk = __serial_clock_speed_HZ;
+	__frv_uart1.uartclk = __serial_clock_speed_HZ;
+
+	if (verbose)
+		printk("      uart=%luMHz\n", __serial_clock_speed_HZ / 1000000 * quot);
+
+	while (!(__get_UART0_LSR() & UART_LSR_TEMT))
+		continue;
+
+	while (!(__get_UART1_LSR() & UART_LSR_TEMT))
+		continue;
+
+	__set_UCPVR(quot);
+	__set_UCPSR(0);
+} /* end determine_clocks() */
+
+/*****************************************************************************/
+/*
+ * reserve some DMA consistent memory
+ */
+#ifdef CONFIG_RESERVE_DMA_COHERENT
+static void __init reserve_dma_coherent(void)
+{
+	unsigned long ampr;
+
+	/* find the first non-kernel memory tile and steal it */
+#define __steal_AMPR(r)						\
+	if (__get_DAMPR(r) & xAMPRx_V) {			\
+		ampr = __get_DAMPR(r);				\
+		__set_DAMPR(r, ampr | xAMPRx_S | xAMPRx_C);	\
+		__set_IAMPR(r, 0);				\
+		goto found;					\
+	}
+
+	__steal_AMPR(1);
+	__steal_AMPR(2);
+	__steal_AMPR(3);
+	__steal_AMPR(4);
+	__steal_AMPR(5);
+	__steal_AMPR(6);
+
+	if (PSR_IMPLE(__get_PSR()) == PSR_IMPLE_FR551) {
+		__steal_AMPR(7);
+		__steal_AMPR(8);
+		__steal_AMPR(9);
+		__steal_AMPR(10);
+		__steal_AMPR(11);
+		__steal_AMPR(12);
+		__steal_AMPR(13);
+		__steal_AMPR(14);
+	}
+
+	/* unable to grant any DMA consistent memory */
+	printk("No DMA consistent memory reserved\n");
+	return;
+
+ found:
+	dma_coherent_mem_start = ampr & xAMPRx_PPFN;
+	ampr &= xAMPRx_SS;
+	ampr >>= 4;
+	ampr = 1 << (ampr - 3 + 20);
+	dma_coherent_mem_end = dma_coherent_mem_start + ampr;
+
+	printk("DMA consistent memory reserved %lx-%lx\n",
+	       dma_coherent_mem_start, dma_coherent_mem_end);
+
+} /* end reserve_dma_coherent() */
+#endif
+
+/*****************************************************************************/
+/*
+ * calibrate the delay loop
+ */
+void __init calibrate_delay(void)
+{
+	loops_per_jiffy = __delay_loops_MHz * (1000000 / HZ);
+
+	printk("Calibrating delay loop... %lu.%02lu BogoMIPS\n",
+	       loops_per_jiffy / (500000 / HZ),
+	       (loops_per_jiffy / (5000 / HZ)) % 100);
+
+} /* end calibrate_delay() */
+
+/*****************************************************************************/
+/*
+ * look through the command line for some things we need to know immediately
+ */
+static void __init parse_cmdline_early(char *cmdline)
+{
+	if (!cmdline)
+		return;
+
+	while (*cmdline) {
+		if (*cmdline == ' ')
+			cmdline++;
+
+		/* "mem=XXX[kKmM]" sets SDRAM size to <mem>, overriding the value we worked
+		 * out from the SDRAM controller mask register
+		 */
+		if (!memcmp(cmdline, "mem=", 4)) {
+			unsigned long long mem_size;
+
+			mem_size = memparse(cmdline + 4, &cmdline);
+			memory_end = memory_start + mem_size;
+		}
+
+		while (*cmdline && *cmdline != ' ')
+			cmdline++;
+	}
+
+} /* end parse_cmdline_early() */
+
+/*****************************************************************************/
+/*
+ *
+ */
+void __init setup_arch(char **cmdline_p)
+{
+#ifdef CONFIG_MMU
+	printk("Linux FR-V port done by Red Hat Inc <dhowells@redhat.com>\n");
+#else
+	printk("uClinux FR-V port done by Red Hat Inc <dhowells@redhat.com>\n");
+#endif
+
+	memcpy(saved_command_line, redboot_command_line, COMMAND_LINE_SIZE);
+
+	determine_cpu();
+	determine_clocks(1);
+
+	/* For printk-directly-beats-on-serial-hardware hack */
+	console_set_baud(115200);
+#ifdef CONFIG_GDBSTUB
+	gdbstub_set_baud(115200);
+#endif
+
+#ifdef CONFIG_RESERVE_DMA_COHERENT
+	reserve_dma_coherent();
+#endif
+	dump_memory_map();
+
+#ifdef CONFIG_MB93090_MB00
+	if (mb93090_mb00_detected)
+		mb93090_display();
+#endif
+
+	/* register those serial ports that are available */
+#ifndef CONFIG_GDBSTUB_UART0
+	__reg(UART0_BASE + UART_IER * 8) = 0;
+	early_serial_setup(&__frv_uart0);
+//	register_serial(&__frv_uart0);
+#endif
+#ifndef CONFIG_GDBSTUB_UART1
+	__reg(UART1_BASE + UART_IER * 8) = 0;
+	early_serial_setup(&__frv_uart1);
+//	register_serial(&__frv_uart1);
+#endif
+
+#if defined(CONFIG_CHR_DEV_FLASH) || defined(CONFIG_BLK_DEV_FLASH)
+	/* we need to initialize the Flashrom device here since we might
+	 * do things with flash early on in the boot
+	 */
+	flash_probe();
+#endif
+
+	/* deal with the command line - RedBoot may have passed one to the kernel */
+	memcpy(command_line, saved_command_line, sizeof(command_line));
+	*cmdline_p = &command_line[0];
+	parse_cmdline_early(command_line);
+
+	/* set up the memory description
+	 * - by now the stack is part of the init task */
+	printk("Memory %08lx-%08lx\n", memory_start, memory_end);
+
+	if (memory_start == memory_end) BUG();
+
+	init_mm.start_code = (unsigned long) &_stext;
+	init_mm.end_code = (unsigned long) &_etext;
+	init_mm.end_data = (unsigned long) &_edata;
+#if 0 /* DAVIDM - don't set brk just incase someone decides to use it */
+	init_mm.brk = (unsigned long) &_end;
+#else
+	init_mm.brk = (unsigned long) 0;
+#endif
+
+#ifdef DEBUG
+	printk("KERNEL -> TEXT=0x%06x-0x%06x DATA=0x%06x-0x%06x BSS=0x%06x-0x%06x\n",
+	       (int) &_stext, (int) &_etext,
+	       (int) &_sdata, (int) &_edata,
+	       (int) &_sbss, (int) &_ebss);
+#endif
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+        conswitchp = &vga_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+        conswitchp = &dummy_con;
+#endif
+#endif
+
+#ifdef CONFIG_BLK_DEV_BLKMEM
+	ROOT_DEV = MKDEV(BLKMEM_MAJOR,0);
+#endif
+	/*rom_length = (unsigned long)&_flashend - (unsigned long)&_romvec;*/
+
+#ifdef CONFIG_MMU
+	setup_linux_memory();
+#else
+	setup_uclinux_memory();
+#endif
+
+	/* get kmalloc into gear */
+	paging_init();
+
+	/* init DMA */
+	frv_dma_init();
+#ifdef DEBUG
+	printk("Done setup_arch\n");
+#endif
+
+	/* start the decrement timer running */
+//	asm volatile("movgs %0,timerd" :: "r"(10000000));
+//	__set_HSR(0, __get_HSR(0) | HSR0_ETMD);
+
+} /* end setup_arch() */
+
+#if 0
+/*****************************************************************************/
+/*
+ * 
+ */
+static int __devinit setup_arch_serial(void)
+{
+	/* register those serial ports that are available */
+#ifndef CONFIG_GDBSTUB_UART0
+	early_serial_setup(&__frv_uart0);
+#endif
+#ifndef CONFIG_GDBSTUB_UART1
+	early_serial_setup(&__frv_uart1);
+#endif
+
+	return 0;
+} /* end setup_arch_serial() */
+
+late_initcall(setup_arch_serial);
+#endif
+
+/*****************************************************************************/
+/*
+ * set up the memory map for normal MMU linux
+ */
+#ifdef CONFIG_MMU
+static void __init setup_linux_memory(void)
+{
+	unsigned long bootmap_size, low_top_pfn, kstart, kend, high_mem;
+
+	kstart	= (unsigned long) &__kernel_image_start - PAGE_OFFSET;
+	kend	= (unsigned long) &__kernel_image_end - PAGE_OFFSET;
+
+	kstart = kstart & PAGE_MASK;
+	kend = (kend + PAGE_SIZE - 1) & PAGE_MASK;
+
+	/* give all the memory to the bootmap allocator,  tell it to put the
+	 * boot mem_map immediately following the kernel image
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0),
+					 kend >> PAGE_SHIFT,		/* map addr */
+					 memory_start >> PAGE_SHIFT,	/* start of RAM */
+					 memory_end >> PAGE_SHIFT	/* end of RAM */
+					 );
+
+	/* pass the memory that the kernel can immediately use over to the bootmem allocator */
+	max_mapnr = num_physpages = (memory_end - memory_start) >> PAGE_SHIFT;
+	low_top_pfn = (KERNEL_LOWMEM_END - KERNEL_LOWMEM_START) >> PAGE_SHIFT;
+	high_mem = 0;
+
+	if (num_physpages > low_top_pfn) {
+#ifdef CONFIG_HIGHMEM
+		high_mem = num_physpages - low_top_pfn;
+#else
+		max_mapnr = num_physpages = low_top_pfn;
+#endif
+	}
+	else {
+		low_top_pfn = num_physpages;
+	}
+
+	min_low_pfn = memory_start >> PAGE_SHIFT;
+	max_low_pfn = low_top_pfn;
+	max_pfn = memory_end >> PAGE_SHIFT;
+
+	num_mappedpages = low_top_pfn;
+
+	printk(KERN_NOTICE "%ldMB LOWMEM available.\n", low_top_pfn >> (20 - PAGE_SHIFT));
+
+	free_bootmem(memory_start, low_top_pfn << PAGE_SHIFT);
+
+#ifdef CONFIG_HIGHMEM
+	if (high_mem)
+		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n", high_mem >> (20 - PAGE_SHIFT));
+#endif
+
+	/* take back the memory occupied by the kernel image and the bootmem alloc map */
+	reserve_bootmem(kstart, kend - kstart + bootmap_size);
+
+	/* reserve the memory occupied by the initial ramdisk */
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (LOADER_TYPE && INITRD_START) {
+		if (INITRD_START + INITRD_SIZE <= (low_top_pfn << PAGE_SHIFT)) {
+			reserve_bootmem(INITRD_START, INITRD_SIZE);
+			initrd_start = INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_end = initrd_start + INITRD_SIZE;
+		}
+		else {
+			printk(KERN_ERR
+			       "initrd extends beyond end of memory (0x%08lx > 0x%08lx)\n"
+			       "disabling initrd\n",
+			       INITRD_START + INITRD_SIZE,
+			       low_top_pfn << PAGE_SHIFT);
+			initrd_start = 0;
+		}
+	}
+#endif
+
+} /* end setup_linux_memory() */
+#endif
+
+/*****************************************************************************/
+/*
+ * set up the memory map for uClinux
+ */
+#ifndef CONFIG_MMU
+static void __init setup_uclinux_memory(void)
+{
+#ifdef CONFIG_PROTECT_KERNEL
+	unsigned long dampr;
+#endif
+	unsigned long kend;
+	int bootmap_size;
+
+	kend = (unsigned long) &__kernel_image_end;
+	kend = (kend + PAGE_SIZE - 1) & PAGE_MASK;
+
+	/* give all the memory to the bootmap allocator,  tell it to put the
+	 * boot mem_map immediately following the kernel image
+	 */
+	bootmap_size = init_bootmem_node(NODE_DATA(0),
+					 kend >> PAGE_SHIFT,		/* map addr */
+					 memory_start >> PAGE_SHIFT,	/* start of RAM */
+					 memory_end >> PAGE_SHIFT	/* end of RAM */
+					 );
+
+	/* free all the usable memory */
+	free_bootmem(memory_start, memory_end - memory_start);
+
+	high_memory = (void *) (memory_end & PAGE_MASK);
+	max_mapnr = num_physpages = ((unsigned long) high_memory - PAGE_OFFSET) >> PAGE_SHIFT;
+
+	min_low_pfn = memory_start >> PAGE_SHIFT;
+	max_low_pfn = memory_end >> PAGE_SHIFT;
+	max_pfn = max_low_pfn;
+
+	/* now take back the bits the core kernel is occupying */
+#ifndef CONFIG_PROTECT_KERNEL
+	reserve_bootmem(kend, bootmap_size);
+	reserve_bootmem((unsigned long) &__kernel_image_start,
+			kend - (unsigned long) &__kernel_image_start);
+
+#else
+	dampr = __get_DAMPR(0);
+	dampr &= xAMPRx_SS;
+	dampr = (dampr >> 4) + 17;
+	dampr = 1 << dampr;
+
+	reserve_bootmem(__get_DAMPR(0) & xAMPRx_PPFN, dampr);
+#endif
+
+	/* reserve some memory to do uncached DMA through if requested */
+#ifdef CONFIG_RESERVE_DMA_COHERENT
+	if (dma_coherent_mem_start)
+		reserve_bootmem(dma_coherent_mem_start,
+				dma_coherent_mem_end - dma_coherent_mem_start);
+#endif
+
+} /* end setup_uclinux_memory() */
+#endif
+
+/*****************************************************************************/
+/*
+ * get CPU information for use by procfs
+ */
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	const char *gr, *fr, *fm, *fp, *cm, *nem, *ble;
+#ifdef CONFIG_PM
+	const char *sep;
+#endif
+
+	gr  = cpu_hsr0_all & HSR0_GRHE	? "gr0-63"	: "gr0-31";
+	fr  = cpu_hsr0_all & HSR0_FRHE	? "fr0-63"	: "fr0-31";
+	fm  = cpu_psr_all  & PSR_EM	? ", Media"	: "";
+	fp  = cpu_psr_all  & PSR_EF	? ", FPU"	: "";
+	cm  = cpu_psr_all  & PSR_CM	? ", CCCR"	: "";
+	nem = cpu_psr_all  & PSR_NEM	? ", NE"	: "";
+	ble = cpu_psr_all  & PSR_BE	? "BE"		: "LE";
+
+	seq_printf(m,
+		   "CPU-Series:\t%s\n"
+		   "CPU-Core:\t%s, %s, %s%s%s\n"
+		   "CPU:\t\t%s\n"
+		   "MMU:\t\t%s\n"
+		   "FP-Media:\t%s%s%s\n"
+		   "System:\t\t%s",
+		   cpu_series,
+		   cpu_core, gr, ble, cm, nem,
+		   cpu_silicon,
+		   cpu_mmu,
+		   fr, fm, fp,
+		   cpu_system);
+
+	if (cpu_board1)
+		seq_printf(m, ", %s", cpu_board1);
+
+	if (cpu_board2)
+		seq_printf(m, ", %s", cpu_board2);
+
+	seq_printf(m, "\n");
+
+#ifdef CONFIG_PM
+	seq_printf(m, "PM-Controls:");
+	sep = "\t";
+
+	if (clock_bits_settable & CLOCK_BIT_CMODE) {
+		seq_printf(m, "%scmode=0x%04hx", sep, clock_cmodes_permitted);
+		sep = ", ";
+	}
+
+	if (clock_bits_settable & CLOCK_BIT_CM) {
+		seq_printf(m, "%scm=0x%lx", sep, clock_bits_settable & CLOCK_BIT_CM);
+		sep = ", ";
+	}
+
+	if (clock_bits_settable & CLOCK_BIT_P0) {
+		seq_printf(m, "%sp0=0x3", sep);
+		sep = ", ";
+	}
+
+	seq_printf(m, "%ssuspend=0x22\n", sep);
+#endif
+
+	seq_printf(m,
+		   "PM-Status:\tcmode=%d, cm=%d, p0=%d\n",
+		   clock_cmode_current, clock_cm_current, clock_p0_current);
+
+#define print_clk(TAG, VAR) \
+	seq_printf(m, "Clock-" TAG ":\t%lu.%2.2lu MHz\n", VAR / 1000000, (VAR / 10000) % 100)
+
+	print_clk("In",    __clkin_clock_speed_HZ);
+	print_clk("Core",  __core_clock_speed_HZ);
+	print_clk("SDRAM", __sdram_clock_speed_HZ);
+	print_clk("CBus",  __core_bus_clock_speed_HZ);
+	print_clk("Res",   __res_bus_clock_speed_HZ);
+	print_clk("Ext",   __ext_bus_clock_speed_HZ);
+	print_clk("DSU",   __dsu_clock_speed_HZ);
+
+	seq_printf(m,
+		   "BogoMips:\t%lu.%02lu\n",
+		   (loops_per_jiffy * HZ) / 500000, ((loops_per_jiffy * HZ) / 5000) % 100);
+
+	return 0;
+} /* end show_cpuinfo() */
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	return *pos < NR_CPUS ? (void *) 0x12345678 : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
+};
+
+void arch_gettod(int *year, int *mon, int *day, int *hour,
+		 int *min, int *sec)
+{
+	*year = *mon = *day = *hour = *min = *sec = 0;
+}
+
+/*****************************************************************************/
+/*
+ *
+ */
+#ifdef CONFIG_MB93090_MB00
+static void __init mb93090_sendlcdcmd(uint32_t cmd)
+{
+	unsigned long base = __addr_LCD();
+	int loop;
+
+	/* request reading of the busy flag */
+	__set_LCD(base, LCD_CMD_READ_BUSY);
+	__set_LCD(base, LCD_CMD_READ_BUSY & ~LCD_E);
+
+	/* wait for the busy flag to become clear */
+	for (loop = 10000; loop > 0; loop--)
+		if (!(__get_LCD(base) & 0x80))
+			break;
+
+	/* send the command */
+	__set_LCD(base, cmd);
+	__set_LCD(base, cmd & ~LCD_E);
+
+} /* end mb93090_sendlcdcmd() */
+
+/*****************************************************************************/
+/*
+ * write to the MB93090 LEDs and LCD
+ */
+static void __init mb93090_display(void)
+{
+	const char *p;
+
+	__set_LEDS(0);
+
+	/* set up the LCD */
+	mb93090_sendlcdcmd(LCD_CMD_CLEAR);
+	mb93090_sendlcdcmd(LCD_CMD_FUNCSET(1,1,0));
+	mb93090_sendlcdcmd(LCD_CMD_ON(0,0));
+	mb93090_sendlcdcmd(LCD_CMD_HOME);
+
+	mb93090_sendlcdcmd(LCD_CMD_SET_DD_ADDR(0));
+	for (p = mb93090_banner; *p; p++)
+		mb93090_sendlcdcmd(LCD_DATA_WRITE(*p));
+
+	mb93090_sendlcdcmd(LCD_CMD_SET_DD_ADDR(64));
+	for (p = mb93090_version; *p; p++)
+		mb93090_sendlcdcmd(LCD_DATA_WRITE(*p));
+
+} /* end mb93090_display() */
+
+#endif // CONFIG_MB93090_MB00
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/signal.c linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/signal.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/signal.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/signal.c	2004-11-05 14:13:03.219553541 +0000
@@ -0,0 +1,595 @@
+/*
+ *  linux/arch/frvnommu/kernel/signal.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
+ *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
+ */
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+#include <linux/unistd.h>
+#include <linux/personality.h>
+#include <linux/suspend.h>
+#include <asm/ucontext.h>
+#include <asm/uaccess.h>
+#include <asm/cacheflush.h>
+
+#define DEBUG_SIG 0
+
+#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
+
+struct fdpic_func_descriptor {
+	unsigned long	text;
+	unsigned long	GOT;
+};
+
+asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
+
+/*
+ * Atomically swap in the new signal mask, and wait for a signal.
+ */
+asmlinkage int sys_sigsuspend(int history0, int history1, old_sigset_t mask)
+{
+	sigset_t saveset;
+
+	mask &= _BLOCKABLE;
+	spin_lock_irq(&current->sighand->siglock);
+	saveset = current->blocked;
+	siginitset(&current->blocked, mask);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	__frame->gr8 = -EINTR;
+	while (1) {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule();
+		if (do_signal(__frame, &saveset))
+			/* return the signal number as the return value of this function
+			 * - this is an utterly evil hack. syscalls should not invoke do_signal()
+			 *   as entry.S sets regs->gr8 to the return value of the system call
+			 * - we can't just use sigpending() as we'd have to discard SIG_IGN signals
+			 *   and call waitpid() if SIGCHLD needed discarding
+			 * - this only works on the i386 because it passes arguments to the signal
+			 *   handler on the stack, and the return value in EAX is effectively
+			 *   discarded
+			 */
+			return __frame->gr8;
+	}
+}
+
+asmlinkage int sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
+{
+	sigset_t saveset, newset;
+
+	/* XXX: Don't preclude handling different sized sigset_t's.  */
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (copy_from_user(&newset, unewset, sizeof(newset)))
+		return -EFAULT;
+	sigdelsetmask(&newset, ~_BLOCKABLE);
+
+	spin_lock_irq(&current->sighand->siglock);
+	saveset = current->blocked;
+	current->blocked = newset;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	__frame->gr8 = -EINTR;
+	while (1) {
+		current->state = TASK_INTERRUPTIBLE;
+		schedule();
+		if (do_signal(__frame, &saveset))
+			/* return the signal number as the return value of this function
+			 * - this is an utterly evil hack. syscalls should not invoke do_signal()
+			 *   as entry.S sets regs->gr8 to the return value of the system call
+			 * - we can't just use sigpending() as we'd have to discard SIG_IGN signals
+			 *   and call waitpid() if SIGCHLD needed discarding
+			 * - this only works on the i386 because it passes arguments to the signal
+			 *   handler on the stack, and the return value in EAX is effectively
+			 *   discarded
+			 */
+			return __frame->gr8;
+	}
+}
+
+asmlinkage int sys_sigaction(int sig,
+			     const struct old_sigaction __user *act,
+			     struct old_sigaction __user *oact)
+{
+	struct k_sigaction new_ka, old_ka;
+	int ret;
+
+	if (act) {
+		old_sigset_t mask;
+		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
+		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
+			return -EFAULT;
+		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
+		__get_user(mask, &act->sa_mask);
+		siginitset(&new_ka.sa.sa_mask, mask);
+	}
+
+	ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
+
+	if (!ret && oact) {
+		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
+		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
+			return -EFAULT;
+		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
+		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
+	}
+
+	return ret;
+}
+
+asmlinkage
+int sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
+{
+	return do_sigaltstack(uss, uoss, __frame->sp);
+}
+
+
+/*
+ * Do a signal return; undo the signal stack.
+ */
+
+struct sigframe
+{
+	void (*pretcode)(void);
+	int sig;
+	struct sigcontext sc;
+	unsigned long extramask[_NSIG_WORDS-1];
+	uint32_t retcode[2];
+};
+
+struct rt_sigframe
+{
+	void (*pretcode)(void);
+	int sig;
+	struct siginfo *pinfo;
+	void *puc;
+	struct siginfo info;
+	struct ucontext uc;
+	uint32_t retcode[2];
+};
+
+static int restore_sigcontext(struct sigcontext __user *sc, int *_gr8)
+{
+	struct user_context *user = current->thread.user;
+	unsigned long tbr, psr;
+
+	tbr = user->i.tbr;
+	psr = user->i.psr;
+	if (copy_from_user(user, &sc->sc_context, sizeof(sc->sc_context)))
+		goto badframe;
+	user->i.tbr = tbr;
+	user->i.psr = psr;
+
+	restore_user_regs(user);
+
+	user->i.syscallno = -1;		/* disable syscall checks */
+
+	*_gr8 = user->i.gr[8];
+	return 0;
+
+ badframe:
+	return 1;
+}
+
+asmlinkage int sys_sigreturn(void)
+{
+	struct sigframe __user *frame = (struct sigframe __user *) __frame->sp;
+	sigset_t set;
+	int gr8;
+
+	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(set.sig[0], &frame->sc.sc_oldmask))
+		goto badframe;
+
+	if (_NSIG_WORDS > 1 &&
+	    __copy_from_user(&set.sig[1], &frame->extramask, sizeof(frame->extramask)))
+		goto badframe;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+	spin_lock_irq(&current->sighand->siglock);
+	current->blocked = set;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	if (restore_sigcontext(&frame->sc, &gr8))
+		goto badframe;
+	return gr8;
+
+ badframe:
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+asmlinkage int sys_rt_sigreturn(void)
+{
+	struct rt_sigframe __user *frame = (struct rt_sigframe __user *) __frame->sp;
+	sigset_t set;
+	stack_t st;
+	int gr8;
+
+	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+	spin_lock_irq(&current->sighand->siglock);
+	current->blocked = set;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	if (restore_sigcontext(&frame->uc.uc_mcontext, &gr8))
+		goto badframe;
+
+	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
+		goto badframe;
+
+	/* It is more difficult to avoid calling this function than to
+	 * call it and ignore errors.  */
+	/*
+	 * THIS CANNOT WORK! "&st" is a kernel address, and "do_sigaltstack()"
+	 * takes a user address (and verifies that it is a user address). End
+	 * result: it does exactly _nothing_.
+	 */
+	do_sigaltstack(&st, NULL, __frame->sp);
+
+	return gr8;
+
+badframe:
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+/*
+ * Set up a signal frame
+ */
+static int setup_sigcontext(struct sigcontext __user *sc, unsigned long mask)
+{
+	save_user_regs(current->thread.user);
+
+	if (copy_to_user(&sc->sc_context, current->thread.user, sizeof(sc->sc_context)) != 0)
+		goto badframe;
+
+	/* non-iBCS2 extensions.. */
+	if (__put_user(mask, &sc->sc_oldmask) < 0)
+		goto badframe;
+
+	return 0;
+
+ badframe:
+	return 1;
+}
+
+/*****************************************************************************/
+/*
+ * Determine which stack to use..
+ */
+static inline void __user *get_sigframe(struct k_sigaction *ka,
+					struct pt_regs *regs,
+					size_t frame_size)
+{
+	unsigned long sp;
+
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/* This is the X/Open sanctioned signal stack switching.  */
+	if (ka->sa.sa_flags & SA_ONSTACK) {
+		if (! on_sig_stack(sp))
+			sp = current->sas_ss_sp + current->sas_ss_size;
+	}
+
+	return (void __user *) ((sp - frame_size) & ~7UL);
+} /* end get_sigframe() */
+
+/*****************************************************************************/
+/*
+ *
+ */
+static void setup_frame(int sig, struct k_sigaction *ka, sigset_t *set, struct pt_regs * regs)
+{
+	struct sigframe __user *frame;
+	int rsig;
+
+	frame = get_sigframe(ka, regs, sizeof(*frame));
+
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		goto give_sigsegv;
+
+	rsig = sig;
+	if (sig < 32 &&
+	    __current_thread_info->exec_domain &&
+	    __current_thread_info->exec_domain->signal_invmap)
+		rsig = __current_thread_info->exec_domain->signal_invmap[sig];
+
+	if (__put_user(rsig, &frame->sig) < 0)
+		goto give_sigsegv;
+
+	if (setup_sigcontext(&frame->sc, set->sig[0]))
+		goto give_sigsegv;
+
+	if (_NSIG_WORDS > 1) {
+		if (__copy_to_user(frame->extramask, &set->sig[1],
+				   sizeof(frame->extramask)))
+			goto give_sigsegv;
+	}
+
+	/* Set up to return from userspace.  If provided, use a stub
+	 * already in userspace.  */
+	if (ka->sa.sa_flags & SA_RESTORER) {
+		if (__put_user(ka->sa.sa_restorer, &frame->pretcode) < 0)
+			goto give_sigsegv;
+	}
+	else {
+		/* Set up the following code on the stack:
+		 *	setlos	#__NR_sigreturn,gr7
+		 *	tira	gr0,0
+		 */
+		if (__put_user((void (*)(void))frame->retcode, &frame->pretcode) ||
+		    __put_user(0x8efc0000|__NR_sigreturn, &frame->retcode[0]) ||
+		    __put_user(0xc0700000, &frame->retcode[1]))
+			goto give_sigsegv;
+
+		flush_icache_range((unsigned long) frame->retcode,
+				   (unsigned long) (frame->retcode + 2));
+	}
+
+	/* set up registers for signal handler */
+	regs->sp   = (unsigned long) frame;
+	regs->lr   = (unsigned long) &frame->retcode;
+	regs->gr8  = sig;
+
+	if (get_personality & FDPIC_FUNCPTRS) {
+		struct fdpic_func_descriptor __user *funcptr =
+			(struct fdpic_func_descriptor *) ka->sa.sa_handler;
+		__get_user(regs->pc, &funcptr->text);
+		__get_user(regs->gr15, &funcptr->GOT);
+	} else {
+		regs->pc   = (unsigned long) ka->sa.sa_handler;
+		regs->gr15 = 0;
+	}
+
+	set_fs(USER_DS);
+
+#if DEBUG_SIG
+	printk("SIG deliver %d (%s:%d): sp=%p pc=%lx ra=%p\n",
+		sig, current->comm, current->pid, frame, regs->pc, frame->pretcode);
+#endif
+
+	return;
+
+give_sigsegv:
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+
+	force_sig(SIGSEGV, current);
+} /* end setup_frame() */
+
+/*****************************************************************************/
+/*
+ *
+ */
+static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+			   sigset_t *set, struct pt_regs * regs)
+{
+	struct rt_sigframe __user *frame;
+	int rsig;
+
+	frame = get_sigframe(ka, regs, sizeof(*frame));
+
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		goto give_sigsegv;
+
+	rsig = sig;
+	if (sig < 32 &&
+	    __current_thread_info->exec_domain &&
+	    __current_thread_info->exec_domain->signal_invmap)
+		rsig = __current_thread_info->exec_domain->signal_invmap[sig];
+
+	if (__put_user(rsig,		&frame->sig) ||
+	    __put_user(&frame->info,	&frame->pinfo) ||
+	    __put_user(&frame->uc,	&frame->puc))
+		goto give_sigsegv;
+
+	if (copy_siginfo_to_user(&frame->info, info))
+		goto give_sigsegv;
+
+	/* Create the ucontext.  */
+	if (__put_user(0, &frame->uc.uc_flags) ||
+	    __put_user(0, &frame->uc.uc_link) ||
+	    __put_user((void*)current->sas_ss_sp, &frame->uc.uc_stack.ss_sp) ||
+	    __put_user(sas_ss_flags(regs->sp), &frame->uc.uc_stack.ss_flags) ||
+	    __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size))
+		goto give_sigsegv;
+
+	if (setup_sigcontext(&frame->uc.uc_mcontext, set->sig[0]))
+		goto give_sigsegv;
+
+	if (__copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set)))
+		goto give_sigsegv;
+
+	/* Set up to return from userspace.  If provided, use a stub
+	 * already in userspace.  */
+	if (ka->sa.sa_flags & SA_RESTORER) {
+		if (__put_user(ka->sa.sa_restorer, &frame->pretcode))
+			goto give_sigsegv;
+	}
+	else {
+		/* Set up the following code on the stack:
+		 *	setlos	#__NR_sigreturn,gr7
+		 *	tira	gr0,0
+		 */
+		if (__put_user((void (*)(void))frame->retcode, &frame->pretcode) ||
+		    __put_user(0x8efc0000|__NR_rt_sigreturn, &frame->retcode[0]) ||
+		    __put_user(0xc0700000, &frame->retcode[1]))
+			goto give_sigsegv;
+
+		flush_icache_range((unsigned long) frame->retcode,
+				   (unsigned long) (frame->retcode + 2));
+	}
+
+	/* Set up registers for signal handler */
+	regs->sp  = (unsigned long) frame;
+	regs->lr   = (unsigned long) &frame->retcode;
+	regs->gr8 = sig;
+	regs->gr9 = (unsigned long) &frame->info;
+
+	if (get_personality & FDPIC_FUNCPTRS) {
+		struct fdpic_func_descriptor *funcptr =
+			(struct fdpic_func_descriptor __user *) ka->sa.sa_handler;
+		__get_user(regs->pc, &funcptr->text);
+		__get_user(regs->gr15, &funcptr->GOT);
+	} else {
+		regs->pc   = (unsigned long) ka->sa.sa_handler;
+		regs->gr15 = 0;
+	}
+
+	set_fs(USER_DS);
+
+#if DEBUG_SIG
+	printk("SIG deliver %d (%s:%d): sp=%p pc=%lx ra=%p\n",
+		sig, current->comm, current->pid, frame, regs->pc, frame->pretcode);
+#endif
+
+	return;
+
+give_sigsegv:
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
+
+} /* end setup_rt_frame() */
+
+/*****************************************************************************/
+/*
+ * OK, we're invoking a handler
+ */
+static void handle_signal(unsigned long sig, siginfo_t *info,
+			  struct k_sigaction *ka, sigset_t *oldset,
+			  struct pt_regs *regs)
+{
+	/* Are we from a system call? */
+	if (in_syscall(regs)) {
+		/* If so, check system call restarting.. */
+		switch (regs->gr8) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->gr8 = -EINTR;
+			break;
+
+		case -ERESTARTSYS:
+			if (!(ka->sa.sa_flags & SA_RESTART)) {
+				regs->gr8 = -EINTR;
+				break;
+			}
+			/* fallthrough */
+		case -ERESTARTNOINTR:
+			regs->gr8 = regs->orig_gr8;
+			regs->pc -= 4;
+		}
+	}
+
+	/* Set up the stack frame */
+	if (ka->sa.sa_flags & SA_SIGINFO)
+		setup_rt_frame(sig, ka, info, oldset, regs);
+	else
+		setup_frame(sig, ka, oldset, regs);
+
+	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+		spin_lock_irq(&current->sighand->siglock);
+		sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+		sigaddset(&current->blocked, sig);
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+} /* end handle_signal() */
+
+/*****************************************************************************/
+/*
+ * Note that 'init' is a special process: it doesn't get signals it doesn't
+ * want to handle. Thus you cannot kill init even with a SIGKILL even by
+ * mistake.
+ */
+int do_signal(struct pt_regs *regs, sigset_t *oldset)
+{
+	struct k_sigaction ka;
+	siginfo_t info;
+	int signr;
+
+	/*
+	 * We want the common case to go fast, which
+	 * is why we may in certain cases get here from
+	 * kernel mode. Just return without doing anything
+	 * if so.
+	 */
+	if (!user_mode(regs))
+		return 1;
+
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		goto no_signal;
+	}
+
+	if (!oldset)
+		oldset = &current->blocked;
+
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
+	if (signr > 0) {
+		handle_signal(signr, &info, &ka, oldset, regs);
+		return 1;
+	}
+
+ no_signal:
+	/* Did we come from a system call? */
+	if (regs->syscallno >= 0) {
+		/* Restart the system call - no handlers present */
+		if (regs->gr8 == -ERESTARTNOHAND ||
+		    regs->gr8 == -ERESTARTSYS ||
+		    regs->gr8 == -ERESTARTNOINTR) {
+			regs->gr8 = regs->orig_gr8;
+			regs->pc -= 4;
+		}
+
+		if (regs->gr8 == -ERESTART_RESTARTBLOCK){
+			regs->gr8 = __NR_restart_syscall;
+			regs->pc -= 4;
+		}
+	}
+
+	return 0;
+} /* end do_signal() */
+
+/*****************************************************************************/
+/*
+ * notification of userspace execution resumption
+ * - triggered by current->work.notify_resume
+ */
+asmlinkage void do_notify_resume(__u32 thread_info_flags)
+{
+	/* pending single-step? */
+	if (thread_info_flags & _TIF_SINGLESTEP)
+		clear_thread_flag(TIF_SINGLESTEP);
+
+	/* deal with pending signal delivery */
+	if (thread_info_flags & _TIF_SIGPENDING)
+		do_signal(__frame, NULL);
+	
+} /* end do_notify_resume() */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/sleep.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/sleep.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/sleep.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/sleep.S	2004-11-05 14:13:03.223553203 +0000
@@ -0,0 +1,356 @@
+/* sleep.S: power saving mode entry
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Woodhouse (dwmw2@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sys.h>
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/setup.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
+#include <asm/errno.h>
+#include <asm/cache.h>
+#include <asm/spr-regs.h>
+
+#define __addr_MASK	0xfeff9820	/* interrupt controller mask */
+
+#define __addr_SDRAMC	0xfe000400	/* SDRAM controller regs */
+#define SDRAMC_DSTS	0x28		/* SDRAM status */
+#define SDRAMC_DSTS_SSI	0x00000001	/* indicates that the SDRAM is in self-refresh mode */
+#define SDRAMC_DRCN	0x30		/* SDRAM refresh control */
+#define SDRAMC_DRCN_SR	0x00000001	/* transition SDRAM into self-refresh mode */
+
+	.section	.bss
+	.balign		8
+	.globl		__sleep_save_area
+__sleep_save_area:
+	.space		16
+
+
+	.text
+	.balign		4
+
+.macro li v r
+	sethi.p		%hi(\v),\r
+	setlo		%lo(\v),\r
+.endm
+
+#ifdef CONFIG_PM
+###############################################################################
+#
+# CPU suspension routine
+# - void frv_cpu_suspend(unsigned long pdm_mode)
+#
+###############################################################################
+	.globl		frv_cpu_suspend
+        .type		frv_cpu_suspend,@function
+frv_cpu_suspend:
+
+	#----------------------------------------------------
+	# save hsr0, psr, isr, and lr for resume code
+	#----------------------------------------------------
+	li		__sleep_save_area,gr11
+
+	movsg		hsr0,gr4
+	movsg		psr,gr5
+	movsg		isr,gr6
+	movsg		lr,gr7
+	stdi		gr4,@(gr11,#0)
+	stdi		gr6,@(gr11,#8)
+
+	# store the return address from sleep in GR14, and its complement in GR13 as a check
+	li		__ramboot_resume,gr14
+#ifdef CONFIG_MMU
+	# Resume via RAMBOOT# will turn MMU off, so bootloader needs a physical address.
+	sethi.p		%hi(__page_offset),gr13
+	setlo		%lo(__page_offset),gr13
+	sub		gr14,gr13,gr14
+#endif
+	not		gr14,gr13
+
+	#----------------------------------------------------
+	# preload and lock into icache that code which may have to run
+	# when dram is in self-refresh state.
+	#----------------------------------------------------
+	movsg		hsr0, gr3
+	li		HSR0_ICE,gr4
+	or		gr3,gr4,gr3
+	movgs		gr3,hsr0
+	or		gr3,gr8,gr7	// add the sleep bits for later
+	
+	li		#__icache_lock_start,gr3
+	li		#__icache_lock_end,gr4
+1:	icpl		gr3,gr0,#1
+	addi		gr3,#L1_CACHE_BYTES,gr3
+	cmp		gr4,gr3,icc0
+	bhi		icc0,#0,1b
+
+	# disable exceptions
+	movsg		psr,gr8
+	andi.p		gr8,#~PSR_PIL,gr8
+	andi		gr8,~PSR_ET,gr8
+	movgs		gr8,psr
+	ori		gr8,#PSR_ET,gr8
+
+	bra		__icache_lock_start
+
+	.size		frv_cpu_suspend, .-frv_cpu_suspend
+
+#
+# the final part of the sleep sequence...
+# - we want it to be be cacheline aligned so we can lock it into the icache easily
+#  On entry:	gr7 holds desired hsr0 sleep value
+#               gr8 holds desired psr sleep value
+#
+	.balign		L1_CACHE_BYTES
+        .type		__icache_lock_start,@function
+__icache_lock_start:
+
+	#----------------------------------------------------
+	# put SDRAM in self-refresh mode
+	#----------------------------------------------------
+	li		__sleep_save_area,gr4
+	
+	# Flush all data in the cache using the DCEF instruction.
+	dcef		@(gr0,gr0),#1
+
+	# Stop DMAC transfer
+
+	# Execute dummy load from SDRAM
+	ldi.p		@(gr4,#0),gr4
+
+	# put the SDRAM into self-refresh mode
+	setlos		SDRAMC_DRCN_SR,gr3
+	li		__addr_SDRAMC,gr4
+	sti		gr3,@(gr4,#SDRAMC_DRCN)
+	membar
+
+	# wait for SDRAM to reach self-refresh mode
+1:	ldi		@(gr4,#SDRAMC_DSTS),gr3
+	andicc		gr3,#SDRAMC_DSTS_SSI,gr3,icc0
+	beq		icc0,#0,1b
+
+	#  Set the GPIO register so that the IRQ[3:0] pins become valid, as required.
+	#  Set the clock mode (CLKC register) as required.
+	#     - At this time, also set the CLKC register P0 bit.
+	
+	# Set the HSR0 register PDM field.
+	movgs		gr7,hsr0
+
+	# Execute NOP 32 times.
+	.rept		32
+	nop
+	.endr
+
+#if 0 // Fujitsu recommend to skip this and will update docs.
+	#      Release the interrupt mask setting of the MASK register of the 
+	#      interrupt controller if necessary.
+	sti		gr10,@(gr9,#0)
+	membar
+#endif
+		
+	# Set the PSR register ET bit to 1 to enable interrupts.
+	movgs		gr8,psr
+
+	###################################################
+	# this is only reached if waking up via interrupt
+	###################################################
+
+	# Execute NOP 32 times.
+	.rept		32
+	nop
+	.endr
+
+	#----------------------------------------------------
+	# wake SDRAM from self-refresh mode
+	#----------------------------------------------------
+	li		__addr_SDRAMC,gr4
+	sti		gr0,@(gr4,#SDRAMC_DRCN) // Turn off self-refresh.
+2:	
+	ldi		@(gr4,#SDRAMC_DSTS),gr3	// Wait for it to come back...
+	andicc		gr3,#SDRAMC_DSTS_SSI,gr0,icc0
+	bne		icc0,0,2b
+	
+	# wait for the SDRAM to stabilise
+	li		0x0100000,gr3
+3:	subicc		gr3,#1,gr3,icc0
+	bne		icc0,#0,3b
+
+	# now that DRAM is back, this is the end of the code which gets
+	# locked in icache.
+__icache_lock_end:
+	.size		__icache_lock_start, .-__icache_lock_start
+
+	# Fall-through to the RAMBOOT# wakeup path
+	
+###############################################################################
+#
+#  resume from suspend re-entry point reached via RAMBOOT# and bootloader
+#
+###############################################################################
+__ramboot_resume:
+	
+	#----------------------------------------------------
+	# restore hsr0, psr, isr, and leave saved lr in gr7
+	#----------------------------------------------------
+	li		__sleep_save_area,gr11
+#ifdef CONFIG_MMU
+	movsg		hsr0,gr4
+	sethi.p		%hi(HSR0_EXMMU),gr3
+	setlo		%lo(HSR0_EXMMU),gr3
+	andcc		gr3,gr4,gr0,icc0
+	bne		icc0,#0,2f
+	
+	# need to use physical address
+	sethi.p		%hi(__page_offset),gr3
+	setlo		%lo(__page_offset),gr3
+	sub		gr11,gr3,gr11
+	
+	# flush all tlb entries
+	setlos		#64,gr4
+	setlos.p	#PAGE_SIZE,gr5
+	setlos		#0,gr6
+1:
+	tlbpr		gr6,gr0,#6,#0
+	subicc.p	gr4,#1,gr4,icc0
+	add		gr6,gr5,gr6
+	bne		icc0,#2,1b
+
+	# need a temporary mapping for the current physical address we are
+	# using between time MMU is enabled and jump to virtual address is
+	# made.
+	sethi.p		%hi(0x00000000),gr4
+	setlo		%lo(0x00000000),gr4		; physical address
+	setlos		#xAMPRx_L|xAMPRx_M|xAMPRx_SS_256Mb|xAMPRx_S_KERNEL|xAMPRx_V,gr5
+	or		gr4,gr5,gr5
+
+	movsg		cxnr,gr13
+	or		gr4,gr13,gr4	
+
+	movgs		gr4,iamlr1			; mapped from real address 0
+	movgs		gr5,iampr1			; cached kernel memory at 0x00000000
+2:
+#endif
+
+	lddi		@(gr11,#0),gr4 ; hsr0, psr 
+	lddi		@(gr11,#8),gr6 ; isr, lr
+	movgs		gr4,hsr0
+	bar
+	
+#ifdef CONFIG_MMU
+	sethi.p		%hi(1f),gr11
+	setlo		%lo(1f),gr11
+	jmpl		@(gr11,gr0)
+1:
+	movgs		gr0,iampr1 	; get rid of temporary mapping
+#endif
+	movgs		gr5,psr
+	movgs		gr6,isr
+	
+	#----------------------------------------------------
+	# unlock the icache which was locked before going to sleep
+	#----------------------------------------------------
+	li		__icache_lock_start,gr3
+	li		__icache_lock_end,gr4
+1:	icul		gr3
+	addi		gr3,#L1_CACHE_BYTES,gr3
+	cmp		gr4,gr3,icc0
+	bhi		icc0,#0,1b
+
+	#----------------------------------------------------
+	# back to business as usual
+	#----------------------------------------------------
+	jmpl		@(gr7,gr0)		;
+
+#endif /* CONFIG_PM */
+
+###############################################################################
+#
+# CPU core sleep mode routine
+#
+###############################################################################
+	.globl		frv_cpu_core_sleep
+        .type		frv_cpu_core_sleep,@function
+frv_cpu_core_sleep:
+
+	# Preload into icache.
+	li		#__core_sleep_icache_lock_start,gr3
+	li		#__core_sleep_icache_lock_end,gr4
+
+1:	icpl		gr3,gr0,#1
+	addi		gr3,#L1_CACHE_BYTES,gr3
+	cmp		gr4,gr3,icc0
+	bhi		icc0,#0,1b
+
+	bra	__core_sleep_icache_lock_start
+
+	.balign L1_CACHE_BYTES
+__core_sleep_icache_lock_start:
+	
+	# (1) Set the PSR register ET bit to 0 to disable interrupts.
+	movsg		psr,gr8
+	andi.p		gr8,#~(PSR_PIL),gr8
+	andi		gr8,#~(PSR_ET),gr4
+	movgs		gr4,psr
+
+#if 0 // Fujitsu recommend to skip this and will update docs.
+	# (2) Set '1' to all bits in the MASK register of the interrupt 
+	#     controller and mask interrupts.
+	sethi.p		%hi(__addr_MASK),gr9
+	setlo		%lo(__addr_MASK),gr9
+	sethi.p		%hi(0xffff0000),gr4
+	setlo		%lo(0xffff0000),gr4
+	ldi		@(gr9,#0),gr10
+	sti		gr4,@(gr9,#0)
+#endif
+	# (3) Flush all data in the cache using the DCEF instruction.
+	dcef		@(gr0,gr0),#1
+
+	# (4) Execute the memory barrier instruction
+	membar
+
+	# (5) Set the GPIO register so that the IRQ[3:0] pins become valid, as required.
+	# (6) Set the clock mode (CLKC register) as required.
+	#     - At this time, also set the CLKC register P0 bit.
+	# (7) Set the HSR0 register PDM field to  001 .
+	movsg		hsr0,gr4
+	ori		gr4,HSR0_PDM_CORE_SLEEP,gr4
+	movgs		gr4,hsr0
+
+	# (8) Execute NOP 32 times.
+	.rept		32
+	nop
+	.endr
+
+#if 0 // Fujitsu recommend to skip this and will update docs.
+	# (9) Release the interrupt mask setting of the MASK register of the 
+	#     interrupt controller if necessary.
+	sti		gr10,@(gr9,#0)
+	membar
+#endif
+		
+	# (10) Set the PSR register ET bit to 1 to enable interrupts.
+	movgs		gr8,psr
+
+__core_sleep_icache_lock_end:
+
+	# Unlock from icache
+	li	__core_sleep_icache_lock_start,gr3
+	li	__core_sleep_icache_lock_end,gr4
+1:	icul		gr3
+	addi		gr3,#L1_CACHE_BYTES,gr3
+	cmp		gr4,gr3,icc0
+	bhi		icc0,#0,1b
+
+	bralr
+		
+	.size		frv_cpu_core_sleep, .-frv_cpu_core_sleep
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/switch_to.S linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/switch_to.S
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/frv/kernel/switch_to.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/frv/kernel/switch_to.S	2004-11-05 14:13:03.229552696 +0000
@@ -0,0 +1,486 @@
+###############################################################################
+#
+# switch_to.S: context switch operation
+#
+# Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+# Written by David Howells (dhowells@redhat.com)
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+#
+###############################################################################
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/thread_info.h>
+#include <asm/processor.h>
+#include <asm/registers.h>
+#include <asm/spr-regs.h>
+
+.macro LEDS val
+	setlos		#~\val,gr27
+	st		gr27,@(gr30,gr0)
+	membar
+	dcf		@(gr30,gr0)
+.endm
+
+	.section	.sdata
+	.balign		8
+
+	# address of frame 0 (userspace) on current kernel stack
+	.globl		__kernel_frame0_ptr
+__kernel_frame0_ptr:
+	.long		init_thread_union + THREAD_SIZE - USER_CONTEXT_SIZE
+
+	# address of current task
+	.globl		__kernel_current_task
+__kernel_current_task:
+	.long		init_task
+
+	.section	.text
+	.balign		4
+
+###############################################################################
+#
+# struct task_struct *__switch_to(struct thread_struct *prev, struct thread_struct *next)
+#
+###############################################################################
+	.globl		__switch_to
+__switch_to:
+	# save outgoing process's context
+	sethi.p		%hi(__switch_back),gr11
+	setlo		%lo(__switch_back),gr11
+	movsg		lr,gr10
+
+	stdi		gr28,@(gr8,#__THREAD_FRAME)
+	sti		sp  ,@(gr8,#__THREAD_SP)
+	sti		fp  ,@(gr8,#__THREAD_FP)
+	stdi		gr10,@(gr8,#__THREAD_LR)
+	stdi		gr16,@(gr8,#__THREAD_GR(16))
+	stdi		gr18,@(gr8,#__THREAD_GR(18))
+	stdi		gr20,@(gr8,#__THREAD_GR(20))
+	stdi		gr22,@(gr8,#__THREAD_GR(22))
+	stdi		gr24,@(gr8,#__THREAD_GR(24))
+	stdi.p		gr26,@(gr8,#__THREAD_GR(26))
+
+	or		gr8,gr8,gr22
+	ldi.p		@(gr8,#__THREAD_USER),gr8
+	call		save_user_regs
+	or		gr22,gr22,gr8
+
+	# retrieve the new context
+	sethi.p		%hi(__kernel_frame0_ptr),gr6
+	setlo		%lo(__kernel_frame0_ptr),gr6
+	movsg		psr,gr4
+
+	lddi.p		@(gr9,#__THREAD_FRAME),gr10
+	or		gr29,gr29,gr27		; ret_from_fork needs to know old current
+
+	ldi		@(gr11,#4),gr19		; get new_current->thread_info
+
+	lddi		@(gr9,#__THREAD_SP),gr12
+	ldi		@(gr9,#__THREAD_LR),gr14
+	ldi		@(gr9,#__THREAD_PC),gr18
+	ldi.p		@(gr9,#__THREAD_FRAME0),gr7
+
+	# actually switch kernel contexts with ordinary exceptions disabled
+	andi		gr4,#~PSR_ET,gr5
+	movgs		gr5,psr
+
+	or.p		gr10,gr0,gr28
+	or		gr11,gr0,gr29
+	or.p		gr12,gr0,sp
+	or		gr13,gr0,fp
+	or		gr19,gr0,gr15		; set __current_thread_info
+
+	sti		gr7,@(gr6,#0)		; set __kernel_frame0_ptr
+	sti		gr29,@(gr6,#4)		; set __kernel_current_task
+
+	movgs		gr14,lr
+	bar
+
+	srli		gr15,#28,gr5
+	subicc		gr5,#0xc,gr0,icc0
+	beq		icc0,#0,111f
+	break
+	nop
+111:
+	
+	# jump to __switch_back or ret_from_fork as appropriate
+	movgs		gr4,psr
+	jmpl		@(gr18,gr0)
+
+###############################################################################
+#
+# restore incoming process's context
+# - on entry:
+#   - SP, FP, LR, GR15, GR28 and GR29 will have been set up appropriately
+#   - GR9 will point to the incoming thread_struct
+#
+###############################################################################
+__switch_back:
+	lddi		@(gr9,#__THREAD_GR(16)),gr16
+	lddi		@(gr9,#__THREAD_GR(18)),gr18
+	lddi		@(gr9,#__THREAD_GR(20)),gr20
+	lddi		@(gr9,#__THREAD_GR(22)),gr22
+	lddi		@(gr9,#__THREAD_GR(24)),gr24
+	lddi		@(gr9,#__THREAD_GR(26)),gr26
+
+	# fall through into restore_user_regs()
+	ldi		@(gr9,#__THREAD_USER),gr8
+
+###############################################################################
+#
+# restore extra general regs and FP/Media regs
+# - void restore_user_regs(const struct user_context *target)
+#
+###############################################################################
+	.globl		restore_user_regs
+restore_user_regs:
+	movsg		hsr0,gr6
+	ori		gr6,#HSR0_GRHE|HSR0_FRLE|HSR0_FRHE,gr6
+	movgs		gr6,hsr0
+	movsg		hsr0,gr6
+
+	movsg		psr,gr7
+	ori		gr7,#PSR_EF|PSR_EM,gr7
+	movgs		gr7,psr
+	movsg		psr,gr7
+	srli		gr7,#24,gr7
+	bar
+
+	lddi		@(gr8,#__FPMEDIA_MSR(0)),gr4
+
+	movgs		gr4,msr0
+	movgs		gr5,msr1
+
+	lddfi		@(gr8,#__FPMEDIA_ACC(0)),fr16
+	lddfi		@(gr8,#__FPMEDIA_ACC(2)),fr18
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(0)),fr20
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(1)),fr21
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(2)),fr22
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(3)),fr23
+
+	mwtacc		fr16,acc0
+	mwtacc		fr17,acc1
+	mwtacc		fr18,acc2
+	mwtacc		fr19,acc3
+	mwtaccg		fr20,accg0
+	mwtaccg		fr21,accg1
+	mwtaccg		fr22,accg2
+	mwtaccg		fr23,accg3
+
+	# some CPUs have extra ACCx and ACCGx regs and maybe FSRx regs
+	subicc.p	gr7,#0x50,gr0,icc0
+	subicc		gr7,#0x31,gr0,icc1
+	beq		icc0,#0,__restore_acc_fr451
+	beq		icc1,#0,__restore_acc_fr555
+__restore_acc_cont:
+
+	# some CPU's have GR32-GR63
+	setlos		#HSR0_FRHE,gr4
+	andcc		gr6,gr4,gr0,icc0
+	beq		icc0,#1,__restore_skip_gr32_gr63
+
+	lddi		@(gr8,#__INT_GR(32)),gr32
+	lddi		@(gr8,#__INT_GR(34)),gr34
+	lddi		@(gr8,#__INT_GR(36)),gr36
+	lddi		@(gr8,#__INT_GR(38)),gr38
+	lddi		@(gr8,#__INT_GR(40)),gr40
+	lddi		@(gr8,#__INT_GR(42)),gr42
+	lddi		@(gr8,#__INT_GR(44)),gr44
+	lddi		@(gr8,#__INT_GR(46)),gr46
+	lddi		@(gr8,#__INT_GR(48)),gr48
+	lddi		@(gr8,#__INT_GR(50)),gr50
+	lddi		@(gr8,#__INT_GR(52)),gr52
+	lddi		@(gr8,#__INT_GR(54)),gr54
+	lddi		@(gr8,#__INT_GR(56)),gr56
+	lddi		@(gr8,#__INT_GR(58)),gr58
+	lddi		@(gr8,#__INT_GR(60)),gr60
+	lddi		@(gr8,#__INT_GR(62)),gr62
+__restore_skip_gr32_gr63:
+
+	# all CPU's have FR0-FR31
+	lddfi		@(gr8,#__FPMEDIA_FR( 0)),fr0
+	lddfi		@(gr8,#__FPMEDIA_FR( 2)),fr2
+	lddfi		@(gr8,#__FPMEDIA_FR( 4)),fr4
+	lddfi		@(gr8,#__FPMEDIA_FR( 6)),fr6
+	lddfi		@(gr8,#__FPMEDIA_FR( 8)),fr8
+	lddfi		@(gr8,#__FPMEDIA_FR(10)),fr10
+	lddfi		@(gr8,#__FPMEDIA_FR(12)),fr12
+	lddfi		@(gr8,#__FPMEDIA_FR(14)),fr14
+	lddfi		@(gr8,#__FPMEDIA_FR(16)),fr16
+	lddfi		@(gr8,#__FPMEDIA_FR(18)),fr18
+	lddfi		@(gr8,#__FPMEDIA_FR(20)),fr20
+	lddfi		@(gr8,#__FPMEDIA_FR(22)),fr22
+	lddfi		@(gr8,#__FPMEDIA_FR(24)),fr24
+	lddfi		@(gr8,#__FPMEDIA_FR(26)),fr26
+	lddfi		@(gr8,#__FPMEDIA_FR(28)),fr28
+	lddfi.p		@(gr8,#__FPMEDIA_FR(30)),fr30
+
+	# some CPU's have FR32-FR63
+	setlos		#HSR0_FRHE,gr4
+	andcc		gr6,gr4,gr0,icc0
+	beq		icc0,#1,__restore_skip_fr32_fr63
+
+	lddfi		@(gr8,#__FPMEDIA_FR(32)),fr32
+	lddfi		@(gr8,#__FPMEDIA_FR(34)),fr34
+	lddfi		@(gr8,#__FPMEDIA_FR(36)),fr36
+	lddfi		@(gr8,#__FPMEDIA_FR(38)),fr38
+	lddfi		@(gr8,#__FPMEDIA_FR(40)),fr40
+	lddfi		@(gr8,#__FPMEDIA_FR(42)),fr42
+	lddfi		@(gr8,#__FPMEDIA_FR(44)),fr44
+	lddfi		@(gr8,#__FPMEDIA_FR(46)),fr46
+	lddfi		@(gr8,#__FPMEDIA_FR(48)),fr48
+	lddfi		@(gr8,#__FPMEDIA_FR(50)),fr50
+	lddfi		@(gr8,#__FPMEDIA_FR(52)),fr52
+	lddfi		@(gr8,#__FPMEDIA_FR(54)),fr54
+	lddfi		@(gr8,#__FPMEDIA_FR(56)),fr56
+	lddfi		@(gr8,#__FPMEDIA_FR(58)),fr58
+	lddfi		@(gr8,#__FPMEDIA_FR(60)),fr60
+	lddfi		@(gr8,#__FPMEDIA_FR(62)),fr62
+__restore_skip_fr32_fr63:
+
+	lddi		@(gr8,#__FPMEDIA_FNER(0)),gr4
+	movsg		fner0,gr4
+	movsg		fner1,gr5
+	bralr
+
+	# the FR451 also has ACC8-11/ACCG8-11 regs (but not 4-7...)
+__restore_acc_fr451:
+	lddfi		@(gr8,#__FPMEDIA_ACC(4)),fr16
+	lddfi		@(gr8,#__FPMEDIA_ACC(6)),fr18
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(4)),fr20
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(5)),fr21
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(6)),fr22
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(7)),fr23
+
+	mwtacc		fr16,acc8
+	mwtacc		fr17,acc9
+	mwtacc		fr18,acc10
+	mwtacc		fr19,acc11
+	mwtaccg		fr20,accg8
+	mwtaccg		fr21,accg9
+	mwtaccg		fr22,accg10
+	mwtaccg		fr23,accg11
+	bra		__restore_acc_cont
+
+	# the FR555 also has ACC4-7/ACCG4-7 regs and an FSR0 reg
+__restore_acc_fr555:
+	lddfi		@(gr8,#__FPMEDIA_ACC(4)),fr16
+	lddfi		@(gr8,#__FPMEDIA_ACC(6)),fr18
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(4)),fr20
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(5)),fr21
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(6)),fr22
+	ldbfi		@(gr8,#__FPMEDIA_ACCG(7)),fr23
+
+	mnop.p
+	mwtacc		fr16,acc4
+	mnop.p
+	mwtacc		fr17,acc5
+	mnop.p
+	mwtacc		fr18,acc6
+	mnop.p
+	mwtacc		fr19,acc7
+	mnop.p
+	mwtaccg		fr20,accg4
+	mnop.p
+	mwtaccg		fr21,accg5
+	mnop.p
+	mwtaccg		fr22,accg6
+	mnop.p
+	mwtaccg		fr23,accg7
+
+	ldi		@(gr8,#__FPMEDIA_FSR(0)),gr4
+	movgs		gr4,fsr0
+
+	bra		__restore_acc_cont
+
+
+###############################################################################
+#
+# save extra general regs and FP/Media regs
+# - void save_user_regs(struct user_context *target)
+#
+###############################################################################
+	.globl		save_user_regs
+save_user_regs:
+	movsg		hsr0,gr6
+	ori		gr6,#HSR0_GRHE|HSR0_FRLE|HSR0_FRHE,gr6
+	movgs		gr6,hsr0
+	movsg		hsr0,gr6
+
+	movsg		psr,gr7
+	ori		gr7,#PSR_EF|PSR_EM,gr7
+	movgs		gr7,psr
+	movsg		psr,gr7
+	srli		gr7,#24,gr7
+	bar
+
+	movsg		fner0,gr4
+	movsg		fner1,gr5
+	stdi.p		gr4,@(gr8,#__FPMEDIA_FNER(0))
+	
+	# some CPU's have GR32-GR63
+	setlos		#HSR0_GRHE,gr4
+	andcc		gr6,gr4,gr0,icc0
+	beq		icc0,#1,__save_skip_gr32_gr63
+
+	stdi		gr32,@(gr8,#__INT_GR(32))
+	stdi		gr34,@(gr8,#__INT_GR(34))
+	stdi		gr36,@(gr8,#__INT_GR(36))
+	stdi		gr38,@(gr8,#__INT_GR(38))
+	stdi		gr40,@(gr8,#__INT_GR(40))
+	stdi		gr42,@(gr8,#__INT_GR(42))
+	stdi		gr44,@(gr8,#__INT_GR(44))
+	stdi		gr46,@(gr8,#__INT_GR(46))
+	stdi		gr48,@(gr8,#__INT_GR(48))
+	stdi		gr50,@(gr8,#__INT_GR(50))
+	stdi		gr52,@(gr8,#__INT_GR(52))
+	stdi		gr54,@(gr8,#__INT_GR(54))
+	stdi		gr56,@(gr8,#__INT_GR(56))
+	stdi		gr58,@(gr8,#__INT_GR(58))
+	stdi		gr60,@(gr8,#__INT_GR(60))
+	stdi		gr62,@(gr8,#__INT_GR(62))
+__save_skip_gr32_gr63:
+	
+	# all CPU's have FR0-FR31
+	stdfi		fr0 ,@(gr8,#__FPMEDIA_FR( 0))
+	stdfi		fr2 ,@(gr8,#__FPMEDIA_FR( 2))
+	stdfi		fr4 ,@(gr8,#__FPMEDIA_FR( 4))
+	stdfi		fr6 ,@(gr8,#__FPMEDIA_FR( 6))
+	stdfi		fr8 ,@(gr8,#__FPMEDIA_FR( 8))
+	stdfi		fr10,@(gr8,#__FPMEDIA_FR(10))
+	stdfi		fr12,@(gr8,#__FPMEDIA_FR(12))
+	stdfi		fr14,@(gr8,#__FPMEDIA_FR(14))
+	stdfi		fr16,@(gr8,#__FPMEDIA_FR(16))
+	stdfi		fr18,@(gr8,#__FPMEDIA_FR(18))
+	stdfi		fr20,@(gr8,#__FPMEDIA_FR(20))
+	stdfi		fr22,@(gr8,#__FPMEDIA_FR(22))
+	stdfi		fr24,@(gr8,#__FPMEDIA_FR(24))
+	stdfi		fr26,@(gr8,#__FPMEDIA_FR(26))
+	stdfi		fr28,@(gr8,#__FPMEDIA_FR(28))
+	stdfi.p		fr30,@(gr8,#__FPMEDIA_FR(30))
+
+	# some CPU's have FR32-FR63
+	setlos		#HSR0_FRHE,gr4
+	andcc		gr6,gr4,gr0,icc0
+	beq		icc0,#1,__save_skip_fr32_fr63
+
+	stdfi		fr32,@(gr8,#__FPMEDIA_FR(32))
+	stdfi		fr34,@(gr8,#__FPMEDIA_FR(34))
+	stdfi		fr36,@(gr8,#__FPMEDIA_FR(36))
+	stdfi		fr38,@(gr8,#__FPMEDIA_FR(38))
+	stdfi		fr40,@(gr8,#__FPMEDIA_FR(40))
+	stdfi		fr42,@(gr8,#__FPMEDIA_FR(42))
+	stdfi		fr44,@(gr8,#__FPMEDIA_FR(44))
+	stdfi		fr46,@(gr8,#__FPMEDIA_FR(46))
+	stdfi		fr48,@(gr8,#__FPMEDIA_FR(48))
+	stdfi		fr50,@(gr8,#__FPMEDIA_FR(50))
+	stdfi		fr52,@(gr8,#__FPMEDIA_FR(52))
+	stdfi		fr54,@(gr8,#__FPMEDIA_FR(54))
+	stdfi		fr56,@(gr8,#__FPMEDIA_FR(56))
+	stdfi		fr58,@(gr8,#__FPMEDIA_FR(58))
+	stdfi		fr60,@(gr8,#__FPMEDIA_FR(60))
+	stdfi		fr62,@(gr8,#__FPMEDIA_FR(62))
+__save_skip_fr32_fr63:
+
+	mrdacc		acc0 ,fr4
+	mrdacc		acc1 ,fr5
+
+	stdfi.p		fr4 ,@(gr8,#__FPMEDIA_ACC(0))
+
+	mrdacc		acc2 ,fr6
+	mrdacc		acc3 ,fr7
+
+	stdfi.p		fr6 ,@(gr8,#__FPMEDIA_ACC(2))
+
+	mrdaccg		accg0,fr4
+	stbfi.p		fr4 ,@(gr8,#__FPMEDIA_ACCG(0))
+
+	mrdaccg		accg1,fr5
+	stbfi.p		fr5 ,@(gr8,#__FPMEDIA_ACCG(1))
+
+	mrdaccg		accg2,fr6
+	stbfi.p		fr6 ,@(gr8,#__FPMEDIA_ACCG(2))
+
+	mrdaccg		accg3,fr7
+	stbfi		fr7 ,@(gr8,#__FPMEDIA_ACCG(3))
+
+	movsg		msr0 ,gr4
+	movsg		msr1 ,gr5
+
+	stdi		gr4 ,@(gr8,#__FPMEDIA_MSR(0))
+
+	# some CPUs have extra ACCx and ACCGx regs and maybe FSRx regs
+	subicc.p	gr7,#0x50,gr0,icc0
+	subicc		gr7,#0x31,gr0,icc1
+	beq		icc0,#0,__save_acc_fr451
+	beq		icc1,#0,__save_acc_fr555
+__save_acc_cont:
+
+	lddfi		@(gr8,#__FPMEDIA_FR(4)),fr4
+	lddfi.p		@(gr8,#__FPMEDIA_FR(6)),fr6
+	bralr
+
+	# the FR451 also has ACC8-11/ACCG8-11 regs (but not 4-7...)
+__save_acc_fr451:
+	mrdacc		acc8 ,fr4
+	mrdacc		acc9 ,fr5
+
+	stdfi.p		fr4 ,@(gr8,#__FPMEDIA_ACC(4))
+
+	mrdacc		acc10,fr6
+	mrdacc		acc11,fr7
+
+	stdfi.p		fr6 ,@(gr8,#__FPMEDIA_ACC(6))
+
+	mrdaccg		accg8,fr4
+	stbfi.p		fr4 ,@(gr8,#__FPMEDIA_ACCG(4))
+
+	mrdaccg		accg9,fr5
+	stbfi.p		fr5 ,@(gr8,#__FPMEDIA_ACCG(5))
+
+	mrdaccg		accg10,fr6
+	stbfi.p		fr6 ,@(gr8,#__FPMEDIA_ACCG(6))
+
+	mrdaccg		accg11,fr7
+	stbfi		fr7 ,@(gr8,#__FPMEDIA_ACCG(7))
+	bra		__save_acc_cont
+
+	# the FR555 also has ACC4-7/ACCG4-7 regs and an FSR0 reg
+__save_acc_fr555:
+	mnop.p
+	mrdacc		acc4 ,fr4
+	mnop.p
+	mrdacc		acc5 ,fr5
+
+	stdfi		fr4 ,@(gr8,#__FPMEDIA_ACC(4))
+
+	mnop.p
+	mrdacc		acc6 ,fr6
+	mnop.p
+	mrdacc		acc7 ,fr7
+
+	stdfi		fr6 ,@(gr8,#__FPMEDIA_ACC(6))
+
+	mnop.p
+	mrdaccg		accg4,fr4
+	stbfi		fr4 ,@(gr8,#__FPMEDIA_ACCG(4))
+
+	mnop.p
+	mrdaccg		accg5,fr5
+	stbfi		fr5 ,@(gr8,#__FPMEDIA_ACCG(5))
+
+	mnop.p
+	mrdaccg		accg6,fr6
+	stbfi		fr6 ,@(gr8,#__FPMEDIA_ACCG(6))
+
+	mnop.p
+	mrdaccg		accg7,fr7
+	stbfi		fr7 ,@(gr8,#__FPMEDIA_ACCG(7))
+
+	movsg		fsr0 ,gr4
+	sti		gr4 ,@(gr8,#__FPMEDIA_FSR(0))
+	bra		__save_acc_cont
