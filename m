Return-Path: <linux-kernel-owner+w=401wt.eu-S1761834AbWLITQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761834AbWLITQg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761835AbWLITQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:16:36 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:50811 "HELO slimak.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761834AbWLITQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:16:34 -0500
Date: Sat, 9 Dec 2006 20:16:25 +0100
From: iSteve <isteve@rulez.cz>
To: linux-kernel@vger.kernel.org
Subject: Systrace 2.6.19 patch -- need comments
Message-ID: <20061209201625.20f4210b@silver>
X-Mailer: Claws Mail 2.6.0cvs69 (GTK+ 2.10.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_WKGoaYb4ntjg1HSsIf86.DN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_WKGoaYb4ntjg1HSsIf86.DN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
while getting familiar with OpenBSD, I've noticed a utility called systrace
(http://www.citi.umich.edu/u/provos/systrace/, http://www.systrace.org/). This
application can alter behavior of syscalls on a simple rules basis; it can
operate on various backends and systems: it's native in OpenBSD and NetBSD, it
has generic ptrace backend (yes, I know that's not really safe) and it has a
Linux kernel patch.

The latest Linux kernel patch I've found was for 2.6.13.4; I've found no mention
of systrace whatsoever when searching through LKML, so I've decided to try my
best and upgrade it to 2.6.19.

Please see the attached patch; it basically only fixes of what didn't apply
clean with the old patch. It's been vaguely tested and it appears to work
as expected.

As I'm not the author, nor do I understand exactly the internals, I'd merely
like to ask someone to look at it, comment it, perhaps even fix it; in the most
optimistic thoughts, maintain it.

My thought on the patch is that linux_sysent.c could be replaced by something
way cleaner. Also, I'm not entirely certain whether it should be in drivers/
instead of security/. Last but definitely not least, only x86 asm code is
available, so it'd have to be ported to other architectures as well.

Thanks in advance for any reply.

PS.: Please, CC me, I'm off-list.
PPS.: To build systrace userland application to use the Linux kernel backend,
ensure that the configure script has access to systrace header files.

--MP_WKGoaYb4ntjg1HSsIf86.DN
Content-Type: text/x-patch; name=systrace-2.6.19.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=systrace-2.6.19.diff

diff -ruN linux-2.6.19-vanilla/arch/i386/kernel/entry.S linux-2.6.19/arch/i386/kernel/entry.S
--- linux-2.6.19-vanilla/arch/i386/kernel/entry.S	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/arch/i386/kernel/entry.S	2006-12-09 18:53:27.000000000 +0100
@@ -330,8 +330,23 @@
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
+#ifdef CONFIG_SYSTRACE
+	movl %esp,%eax
+	call systrace_intercept
+	cmpl $0,%eax
+	jl ret1
+	movl ORIG_EAX(%esp),%eax
+#endif /* CONFIG_SYSTRACE */
 	call *sys_call_table(,%eax,4)
+#ifdef CONFIG_SYSTRACE
+	ret1:
+#endif /* CONFIG_SYSTRACE */
 	movl %eax,EAX(%esp)
+#ifdef CONFIG_SYSTRACE
+	movl %esp,%eax                  # pass in stack
+	call systrace_result
+	movl EAX(%esp),%eax             # XXX: ?to be on the safe side
+#endif /* CONFIG_SYSTRACE */
 	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
@@ -363,9 +378,25 @@
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
+#ifdef CONFIG_SYSTRACE
+	movl %esp,%eax
+	call systrace_intercept
+	cmpl $0,%eax
+	jl ret
+	movl ORIG_EAX(%esp),%eax
+#endif /* CONFIG_SYSTRACE */
 syscall_call:
 	call *sys_call_table(,%eax,4)
+#ifdef CONFIG_SYSTRACE
+	ret:
+#endif /* CONFIG_SYSTRACE */
 	movl %eax,EAX(%esp)		# store the return value
+#ifdef CONFIG_SYSTRACE
+	movl %esp,%eax                  # pass in stack
+	call systrace_result
+	movl EAX(%esp),%eax             # XXX: ?to be on the safe side
+#endif /* CONFIG_SYSTRACE */
+
 syscall_exit:
 	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
diff -ruN linux-2.6.19-vanilla/drivers/Makefile linux-2.6.19/drivers/Makefile
--- linux-2.6.19-vanilla/drivers/Makefile	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/drivers/Makefile	2006-12-07 18:27:10.000000000 +0100
@@ -67,6 +67,7 @@
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
+obj-$(CONFIG_SYSTRACE)		+= systrace/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
diff -ruN linux-2.6.19-vanilla/drivers/systrace/Kconfig linux-2.6.19/drivers/systrace/Kconfig
--- linux-2.6.19-vanilla/drivers/systrace/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/drivers/systrace/Kconfig	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,7 @@
+config SYSTRACE
+        bool "Systrace support"
+        help
+          This enables systrace support.  See http://www.systrace.org/ for details.
+          
+          Also enable Default Linux Capabilites (CONFIG_SECURITY_CAPABILITIES)!
+
diff -ruN linux-2.6.19-vanilla/drivers/systrace/linux_sysent.c linux-2.6.19/drivers/systrace/linux_sysent.c
--- linux-2.6.19-vanilla/drivers/systrace/linux_sysent.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/drivers/systrace/linux_sysent.c	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,296 @@
+/*
+ * file taken from openbsd's compat/linux/linux_sysent.c
+ */
+
+/*	$OpenBSD: linux_sysent.c,v 1.36 2002/06/05 19:43:44 jasoni Exp $	*/
+
+
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/fs.h>
+#include <linux/wait.h>
+#include <linux/queue.h>
+
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/semaphore.h>
+
+#include <linux/systrace.h>
+
+/* #define	s(type)	sizeof(type) */
+#define	s(type)	0
+
+struct sysent linux_sysent[] = {
+	{ 0, 0 },			/* 0 = syscall */
+	{ 1, s(struct sys_exit_args) },				/* 1 = exit */
+	{ 0, 0 },				/* 2 = fork */
+	{ 3, s(struct sys_read_args) },				/* 3 = read */
+	{ 3, s(struct sys_write_args) },			/* 4 = write */
+	{ 3, s(struct linux_sys_open_args) },			/* 5 = open */
+	{ 1, s(struct sys_close_args) },			/* 6 = close */
+	{ 3, s(struct linux_sys_waitpid_args) },		/* 7 = waitpid */
+	{ 2, s(struct linux_sys_creat_args) },			/* 8 = creat */
+	{ 2, s(struct sys_link_args) },				/* 9 = link */
+	{ 1, s(struct linux_sys_unlink_args) },			/* 10 = unlink */
+	{ 3, s(struct linux_sys_execve_args) },			/* 11 = execve */
+	{ 1, s(struct linux_sys_chdir_args) },			/* 12 = chdir */
+	{ 1, s(struct linux_sys_time_args) },			/* 13 = time */
+	{ 3, s(struct linux_sys_mknod_args) },			/* 14 = mknod */
+	{ 2, s(struct linux_sys_chmod_args) },			/* 15 = chmod */
+	{ 3, s(struct linux_sys_lchown16_args) },		/* 16 = lchown16 */
+	{ 1, s(struct linux_sys_break_args) },			/* 17 = break */
+	{ 0, 0 },			/* 18 = ostat */
+	{ 3, s(struct compat_43_sys_lseek_args) },		/* 19 = lseek */
+	{ 0, 0 },			/* 20 = getpid */
+	{ 5, s(struct linux_sys_mount_args) },			/* 21 = mount */
+	{ 1, s(struct linux_sys_umount_args) },			/* 22 = umount */
+	{ 1, s(struct sys_setuid_args) },			/* 23 = linux_setuid16 */
+	{ 0, 0 },			/* 24 = linux_getuid16 */
+	{ 1, s(struct linux_sys_stime_args) },			/* 25 = stime */
+	{ 0, 0 },			/* 26 = unimplemented ptrace */
+	{ 1, s(struct linux_sys_alarm_args) },			/* 27 = alarm */
+	{ 0, 0 },			/* 28 = ofstat */
+	{ 0, 0 },			/* 29 = pause */
+	{ 2, s(struct linux_sys_utime_args) },			/* 30 = utime */
+	{ 0, 0 },			/* 31 = stty */
+	{ 0, 0 },			/* 32 = gtty */
+	{ 2, s(struct linux_sys_access_args) },			/* 33 = access */
+	{ 1, s(struct linux_sys_nice_args) },			/* 34 = nice */
+	{ 0, 0 },			/* 35 = ftime */
+	{ 0, 0 },				/* 36 = sync */
+	{ 2, s(struct linux_sys_kill_args) },			/* 37 = kill */
+	{ 2, s(struct linux_sys_rename_args) },			/* 38 = rename */
+	{ 2, s(struct linux_sys_mkdir_args) },			/* 39 = mkdir */
+	{ 1, s(struct linux_sys_rmdir_args) },			/* 40 = rmdir */
+	{ 1, s(struct sys_dup_args) },				/* 41 = dup */
+	{ 1, s(struct linux_sys_pipe_args) },			/* 42 = pipe */
+	{ 1, s(struct linux_sys_times_args) },			/* 43 = times */
+	{ 0, 0 },			/* 44 = prof */
+	{ 1, s(struct linux_sys_brk_args) },			/* 45 = brk */
+	{ 1, s(struct sys_setgid_args) },			/* 46 = linux_setgid16 */
+	{ 0, 0 },			/* 47 = linux_getgid16 */
+	{ 2, s(struct linux_sys_signal_args) },			/* 48 = signal */
+	{ 0, 0 },			/* 49 = linux_geteuid16 */
+	{ 0, 0 },			/* 50 = linux_getegid16 */
+	{ 1, s(struct sys_acct_args) },				/* 51 = acct */
+	{ 0, 0 },			/* 52 = phys */
+	{ 0, 0 },			/* 53 = lock */
+	{ 3, s(struct linux_sys_ioctl_args) },			/* 54 = ioctl */
+	{ 3, s(struct linux_sys_fcntl_args) },			/* 55 = fcntl */
+	{ 0, 0 },			/* 56 = mpx */
+	{ 2, s(struct sys_setpgid_args) },			/* 57 = setpgid */
+	{ 0, 0 },			/* 58 = ulimit */
+	{ 1, s(struct linux_sys_oldolduname_args) },		/* 59 = oldolduname */
+	{ 1, s(struct sys_umask_args) },			/* 60 = umask */
+	{ 1, s(struct sys_chroot_args) },			/* 61 = chroot */
+	{ 0, 0 },			/* 62 = ustat */
+	{ 2, s(struct sys_dup2_args) },				/* 63 = dup2 */
+	{ 0, 0 },			/* 64 = getppid */
+	{ 0, 0 },			/* 65 = getpgrp */
+	{ 0, 0 },			/* 66 = setsid */
+	{ 3, s(struct linux_sys_sigaction_args) },		/* 67 = sigaction */
+	{ 0, 0 },		/* 68 = siggetmask */
+	{ 1, s(struct linux_sys_sigsetmask_args) },		/* 69 = sigsetmask */
+	{ 2, s(struct linux_sys_setreuid16_args) },		/* 70 = setreuid16 */
+	{ 2, s(struct linux_sys_setregid16_args) },		/* 71 = setregid16 */
+	{ 3, s(struct linux_sys_sigsuspend_args) },		/* 72 = sigsuspend */
+	{ 1, s(struct linux_sys_sigpending_args) },		/* 73 = sigpending */
+	{ 2, s(struct compat_43_sys_sethostname_args) },	/* 74 = sethostname */
+	{ 2, s(struct linux_sys_setrlimit_args) },		/* 75 = setrlimit */
+	{ 2, s(struct linux_sys_getrlimit_args) },		/* 76 = getrlimit */
+	{ 2, s(struct sys_getrusage_args) },			/* 77 = getrusage */
+	{ 2, s(struct sys_gettimeofday_args) },			/* 78 = gettimeofday */
+	{ 2, s(struct sys_settimeofday_args) },			/* 79 = settimeofday */
+	{ 2, s(struct sys_getgroups_args) },			/* 80 = linux_getgroups */
+	{ 2, s(struct sys_setgroups_args) },			/* 81 = linux_setgroups */
+	{ 1, s(struct linux_sys_oldselect_args) },		/* 82 = oldselect */
+	{ 2, s(struct linux_sys_symlink_args) },		/* 83 = symlink */
+	{ 2, s(struct compat_43_sys_lstat_args) },		/* 84 = olstat */
+	{ 3, s(struct linux_sys_readlink_args) },		/* 85 = readlink */
+	{ 1, s(struct linux_sys_uselib_args) },			/* 86 = uselib */
+	{ 1, s(struct sys_swapon_args) },			/* 87 = swapon */
+	{ 1, s(struct sys_reboot_args) },			/* 88 = reboot */
+	{ 3, s(struct linux_sys_readdir_args) },		/* 89 = readdir */
+	{ 1, s(struct linux_sys_mmap_args) },			/* 90 = mmap */
+	{ 2, s(struct sys_munmap_args) },			/* 91 = munmap */
+	{ 2, s(struct linux_sys_truncate_args) },		/* 92 = truncate */
+	{ 2, s(struct compat_43_sys_ftruncate_args) },		/* 93 = ftruncate */
+	{ 2, s(struct sys_fchmod_args) },			/* 94 = fchmod */
+	{ 3, s(struct linux_sys_fchown16_args) },		/* 95 = fchown16 */
+	{ 2, s(struct sys_getpriority_args) },			/* 96 = getpriority */
+	{ 3, s(struct sys_setpriority_args) },			/* 97 = setpriority */
+	{ 4, s(struct sys_profil_args) },			/* 98 = profil */
+	{ 2, s(struct linux_sys_statfs_args) },			/* 99 = statfs */
+	{ 2, s(struct linux_sys_fstatfs_args) },		/* 100 = fstatfs */
+#ifdef __i386__
+	{ 3, s(struct linux_sys_ioperm_args) },			/* 101 = ioperm */
+#else
+	{ 0, 0 },			/* 101 = ioperm */
+#endif
+	{ 2, s(struct linux_sys_socketcall_args) },		/* 102 = socketcall */
+	{ 0, 0 },			/* 103 = klog */
+	{ 3, s(struct sys_setitimer_args) },			/* 104 = setitimer */
+	{ 2, s(struct sys_getitimer_args) },			/* 105 = getitimer */
+	{ 2, s(struct linux_sys_stat_args) },			/* 106 = stat */
+	{ 2, s(struct linux_sys_lstat_args) },			/* 107 = lstat */
+	{ 2, s(struct linux_sys_fstat_args) },			/* 108 = fstat */
+	{ 1, s(struct linux_sys_olduname_args) },		/* 109 = olduname */
+#ifdef __i386__
+	{ 1, s(struct linux_sys_iopl_args) },			/* 110 = iopl */
+#else
+	{ 0, 0 },			/* 110 = iopl */
+#endif
+	{ 0, 0 },		/* 111 = vhangup */
+	{ 0, 0 },			/* 112 = idle */
+	{ 0, 0 },		/* 113 = vm86old */
+	{ 4, s(struct linux_sys_wait4_args) },			/* 114 = wait4 */
+	{ 0, 0 },		/* 115 = swapoff */
+	{ 0, 0 },		/* 116 = sysinfo */
+	{ 5, s(struct linux_sys_ipc_args) },			/* 117 = ipc */
+	{ 1, s(struct sys_fsync_args) },			/* 118 = fsync */
+	{ 1, s(struct linux_sys_sigreturn_args) },		/* 119 = sigreturn */
+	{ 2, s(struct linux_sys_clone_args) },			/* 120 = clone */
+	{ 2, s(struct compat_09_sys_setdomainname_args) },	/* 121 = setdomainname */
+	{ 1, s(struct linux_sys_uname_args) },			/* 122 = uname */
+#ifdef __i386__
+	{ 3, s(struct linux_sys_modify_ldt_args) },		/* 123 = modify_ldt */
+#else
+	{ 0, 0 },		/* 123 = modify_ldt */
+#endif
+	{ 0, 0 },		/* 124 = adjtimex */
+	{ 3, s(struct sys_mprotect_args) },			/* 125 = mprotect */
+	{ 3, s(struct linux_sys_sigprocmask_args) },		/* 126 = sigprocmask */
+	{ 0, 0 },		/* 127 = create_module */
+	{ 0, 0 },		/* 128 = init_module */
+	{ 0, 0 },		/* 129 = delete_module */
+	{ 0, 0 },	/* 130 = get_kernel_syms */
+	{ 0, 0 },		/* 131 = quotactl */
+	{ 1, s(struct linux_sys_getpgid_args) },		/* 132 = getpgid */
+	{ 1, s(struct sys_fchdir_args) },			/* 133 = fchdir */
+	{ 0, 0 },		/* 134 = bdflush */
+	{ 0, 0 },			/* 135 = sysfs */
+	{ 1, s(struct linux_sys_personality_args) },		/* 136 = personality */
+	{ 0, 0 },		/* 137 = afs_syscall */
+	{ 1, s(struct linux_sys_setfsuid_args) },		/* 138 = linux_setfsuid16 */
+	{ 0, 0 },		/* 139 = linux_getfsuid16 */
+	{ 5, s(struct linux_sys_llseek_args) },			/* 140 = llseek */
+	{ 3, s(struct linux_sys_getdents_args) },		/* 141 = getdents */
+	{ 5, s(struct linux_sys_select_args) },			/* 142 = select */
+	{ 2, s(struct sys_flock_args) },			/* 143 = flock */
+	{ 3, s(struct sys_msync_args) },			/* 144 = msync */
+	{ 3, s(struct sys_readv_args) },			/* 145 = readv */
+	{ 3, s(struct sys_writev_args) },			/* 146 = writev */
+	{ 1, s(struct linux_sys_getsid_args) },			/* 147 = getsid */
+	{ 1, s(struct linux_sys_fdatasync_args) },		/* 148 = fdatasync */
+	{ 1, s(struct linux_sys___sysctl_args) },		/* 149 = __sysctl */
+	{ 2, s(struct sys_mlock_args) },			/* 150 = mlock */
+	{ 2, s(struct sys_munlock_args) },			/* 151 = munlock */
+	{ 0, 0 },		/* 152 = mlockall */
+	{ 0, 0 },		/* 153 = munlockall */
+	{ 2, s(struct linux_sys_sched_setparam_args) },		/* 154 = sched_setparam */
+	{ 2, s(struct linux_sys_sched_getparam_args) },		/* 155 = sched_getparam */
+	{ 3, s(struct linux_sys_sched_setscheduler_args) },	/* 156 = sched_setscheduler */
+	{ 1, s(struct linux_sys_sched_getscheduler_args) },	/* 157 = sched_getscheduler */
+	{ 0, 0 },		/* 158 = sched_yield */
+	{ 1, s(struct linux_sys_sched_get_priority_max_args) },	/* 159 = sched_get_priority_max */
+	{ 1, s(struct linux_sys_sched_get_priority_min_args) },	/* 160 = sched_get_priority_min */
+	{ 0, 0 },	/* 161 = sched_rr_get_interval */
+	{ 2, s(struct sys_nanosleep_args) },			/* 162 = nanosleep */
+	{ 4, s(struct linux_sys_mremap_args) },			/* 163 = mremap */
+	{ 3, s(struct linux_sys_setresuid16_args) },		/* 164 = setresuid16 */
+	{ 3, s(struct linux_sys_getresuid_args) },		/* 165 = linux_getresuid16 */
+	{ 0, 0 },			/* 166 = vm86 */
+	{ 0, 0 },		/* 167 = query_module */
+	{ 3, s(struct sys_poll_args) },				/* 168 = poll */
+	{ 0, 0 },		/* 169 = nfsservctl */
+	{ 3, s(struct linux_sys_setresgid16_args) },		/* 170 = setresgid16 */
+	{ 3, s(struct linux_sys_getresgid16_args) },		/* 171 = getresgid16 */
+	{ 0, 0 },			/* 172 = prctl */
+	{ 1, s(struct linux_sys_rt_sigreturn_args) },	/* 173 = rt_sigreturn */
+	{ 4, s(struct linux_sys_rt_sigaction_args) },	/* 174 = rt_sigaction */
+	{ 4, s(struct linux_sys_rt_sigprocmask_args) },	/* 175 = rt_sigprocmask */
+	{ 2, s(struct linux_sys_rt_sigpending_args) },	/* 176 = rt_sigpending */
+	{ 0, 0 },	/* 177 = rt_sigtimedwait */
+	{ 0, 0 },		/* 178 = rt_queueinfo */
+	{ 2, s(struct linux_sys_rt_sigsuspend_args) },	/* 179 = rt_sigsuspend */
+	{ 4, s(struct linux_sys_pread_args) },		/* 180 = pread */
+	{ 4, s(struct linux_sys_pwrite_args) },		/* 181 = pwrite */
+	{ 3, s(struct linux_sys_chown16_args) },	/* 182 = chown16 */
+	{ 2, s(struct linux_sys_getcwd_args) },		/* 183 = getcwd */
+	{ 0, 0 },			/* 184 = capget */
+	{ 0, 0 },			/* 185 = capset */
+	{ 2, s(struct linux_sys_sigaltstack_args) },	/* 186 = sigaltstack */
+	{ 0, 0 },		/* 187 = sendfile */
+	{ 0, 0 },		/* 188 = getpmsg */
+	{ 0, 0 },		/* 189 = putpmsg */
+	{ 0, 0 },			/* 190 = vfork */
+	{ 2, s(struct linux_sys_ugetrlimit_args) },	/* 191 = ugetrlimit */
+	{ 0, 0 },			/* 192 = mmap2 */
+	{ 2, s(struct linux_sys_truncate64_args) },	/* 193 = truncate64 */
+	{ 2, s(struct sys_ftruncate_args) },		/* 194 = linux_ftruncate64 */
+	{ 2, s(struct linux_sys_stat64_args) },		/* 195 = stat64 */
+	{ 2, s(struct linux_sys_lstat64_args) },	/* 196 = lstat64 */
+	{ 2, s(struct linux_sys_fstat64_args) },	/* 197 = fstat64 */
+	{ 0, 0 },			/* 198 = lchown */
+	{ 0, 0 },			/* 199 = getuid */
+	{ 0, 0 },			/* 200 = getgid */
+	{ 0, 0 },			/* 201 = geteuid */
+	{ 0, 0 },			/* 202 = getegid */
+	{ 0, 0 },		/* 203 = setreuid */
+	{ 0, 0 },		/* 204 = setregid */
+	{ 2, s(struct sys_getgroups_args) },		/* 205 = getgroups */
+	{ 2, s(struct sys_setgroups_args) },		/* 206 = setgroups */
+	{ 0, 0 },			/* 207 = fchown */
+	{ 0, 0 },		/* 208 = setresuid */
+	{ 3, s(struct linux_sys_getresuid_args) },	/* 209 = getresuid */
+	{ 0, 0 },		/* 210 = setresgid */
+	{ 0, 0 },		/* 211 = getresgid */
+	{ 0, 0 },			/* 212 = chown */
+	{ 1, s(struct sys_setuid_args) },	/* 213 = setuid */
+	{ 1, s(struct sys_setgid_args) },	/* 214 = setgid */
+	{ 1, s(struct linux_sys_setfsuid_args) },		/* 215 = setfsuid */
+	{ 0, 0 },		/* 216 = setfsgid */
+	{ 0, 0 },		/* 217 = pivot_root */
+	{ 0, 0 },		/* 218 = mincore */
+	{ 0, 0 },		/* 219 = madvise */
+	{ 0, 0 },		/* 220 = getdents64 */
+	{ 3, s(struct linux_sys_fcntl64_args) },		/* 221 = fcntl64 */
+	/* XXX These need to be filled out */
+	{ 0, 0 },		/* 222 */  
+	{ 0, 0 },		/* 223 */
+	{ 0, 0 },		/* 224 */
+	{ 0, 0 },		/* 225 */
+	{ 0, 0 },		/* 226 */
+	{ 0, 0 },		/* 227 */
+	{ 0, 0 },		/* 228 */
+	{ 0, 0 },		/* 229 */
+	{ 0, 0 },		/* 230 */
+	{ 0, 0 },		/* 231 */
+	{ 0, 0 },		/* 232 */
+	{ 0, 0 },		/* 233 */
+	{ 0, 0 },		/* 234 */
+	{ 0, 0 },		/* 235 */
+	{ 0, 0 },		/* 236 */
+	{ 0, 0 },		/* 237 */
+	{ 0, 0 },		/* 238 */
+	{ 0, 0 },		/* 239 */
+	{ 0, 0 },		/* 240 */
+	{ 0, 0 },		/* 241 */
+	{ 0, 0 },		/* 242 */
+	{ 0, 0 },		/* 243 */
+	{ 0, 0 },		/* 244 */
+	{ 0, 0 },		/* 245 */
+	{ 0, 0 },		/* 246 */
+	{ 0, 0 },		/* 247 */
+	{ 0, 0 },		/* 248 */
+	{ 0, 0 },		/* 249 */
+	{ 0, 0 },		/* 250 */
+	{ 0, 0 },		/* 251 */
+	{ 0, 0 },		/* 252 */
+	{ 0, 0 },		/* 253 */
+	{ 0, 0 },		/* 254 */
+	{ 0, 0 },		/* 255 */
+	{ 0, 0 },		/* 256 */
+};
diff -ruN linux-2.6.19-vanilla/drivers/systrace/Makefile linux-2.6.19/drivers/systrace/Makefile
--- linux-2.6.19-vanilla/drivers/systrace/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/drivers/systrace/Makefile	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1 @@
+obj-y    := systrace.o policy.o linux_sysent.o
diff -ruN linux-2.6.19-vanilla/drivers/systrace/policy.c linux-2.6.19/drivers/systrace/policy.c
--- linux-2.6.19-vanilla/drivers/systrace/policy.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/drivers/systrace/policy.c	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,159 @@
+/*
+ * policy.c
+ *
+ * Copyright (c) 2002 Marius Aamodt Eriksen <marius@umich.edu>
+ * Copyright (c) 2002 Niels Provos <provos@citi.umich.edu>
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *  3. The names of the copyright holders may not be used to endorse or
+ *     promote products derived from this software without specific
+ *     prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ *  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
+ *  AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ *  THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ *  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ *  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ *  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ *  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/fs.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <linux/queue.h>
+
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+
+#include <linux/queue.h>	
+#include <linux/systrace.h>
+
+#include "systrace-private.h"
+
+extern int systrace_debug;
+
+int
+systrace_policy(struct fsystrace *fst, struct systrace_policy *pol)
+{
+	struct str_policy *strpol;
+	struct str_process *strp;
+
+	switch(pol->strp_op) {
+	case SYSTR_POLICY_NEW:
+		DPRINTF(("%s: new, ents %d\n", __func__, pol->strp_maxents));
+
+		if (pol->strp_maxents <= 0 || pol->strp_maxents > 1024)
+			return (-EINVAL);
+		strpol = systrace_newpolicy(fst, pol->strp_maxents);
+		if (strpol == NULL)
+			return (-ENOBUFS);
+		pol->strp_num = strpol->nr;
+		break;
+	case SYSTR_POLICY_ASSIGN:
+		DPRINTF(("%s: %d -> pid %d\n", __func__,
+			    pol->strp_num, pol->strp_pid));
+
+		/* Find right policy by number */
+		TAILQ_FOREACH(strpol, &fst->policies, next)
+		    if (strpol->nr == pol->strp_num)
+			    break;
+		if (strpol == NULL)
+			return (-EINVAL);
+
+		strp = systrace_findpid(fst, pol->strp_pid);
+		if (strp == NULL)
+			return (-EINVAL);
+
+		if (strp->policy != NULL)
+			systrace_closepolicy(fst, strp->policy);
+		strp->policy = strpol;
+		strpol->refcount++;
+		break;
+	case SYSTR_POLICY_MODIFY:
+		DPRINTF(("%s: %d: code %d -> policy %d\n", __func__,
+			    pol->strp_num, pol->strp_code, pol->strp_policy));
+
+		if (!POLICY_VALID(pol->strp_policy) && pol->strp_policy >= 0)
+			return (-EINVAL);
+		TAILQ_FOREACH(strpol, &fst->policies, next)
+		    if (strpol->nr == pol->strp_num)
+			    break;
+		if (strpol == NULL)
+			return (-EINVAL);
+		if (pol->strp_code < 0 || pol->strp_code >= strpol->nsysent)
+			return (-EINVAL);
+		strpol->sysent[pol->strp_code] = pol->strp_policy;
+		break;
+	default:
+		return (-EINVAL);
+	}
+
+	return (0);
+}
+
+struct str_policy *
+systrace_newpolicy(struct fsystrace *fst, int maxents)
+{
+	struct str_policy *pol;
+	int i;
+
+	if (fst->npolicies > SYSTR_MAX_POLICIES /* && !fst->issuser */)
+		return (NULL);
+
+	if ((pol = kmalloc(sizeof(*pol), GFP_KERNEL)) == NULL)
+		return (NULL);
+
+	DPRINTF(("%s: allocating %d -> %lu\n", __func__,
+		    maxents, (u_long)maxents * sizeof(int)));
+
+	memset(pol, 0, sizeof(*pol));
+
+	if ((pol->sysent = kmalloc(maxents * sizeof(short), GFP_KERNEL)) == NULL) {
+		kfree(pol);
+		return (NULL);
+	}
+	pol->nsysent = maxents;
+	for (i = 0; i < maxents; i++)
+		pol->sysent[i] = SYSTR_POLICY_ASK;
+
+	fst->npolicies++;
+	pol->nr = fst->npolicynr++;
+	pol->refcount = 1;
+
+	TAILQ_INSERT_TAIL(&fst->policies, pol, next);
+
+	return (pol);
+}
+
+void
+systrace_closepolicy(struct fsystrace *fst, struct str_policy *policy)
+{
+	if (--policy->refcount)
+		return;
+
+	fst->npolicies--;
+
+	if (policy->nsysent)
+		kfree(policy->sysent);
+
+	TAILQ_REMOVE(&fst->policies, policy, next);
+
+	kfree(policy);
+}
diff -ruN linux-2.6.19-vanilla/drivers/systrace/systrace.c linux-2.6.19/drivers/systrace/systrace.c
--- linux-2.6.19-vanilla/drivers/systrace/systrace.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/drivers/systrace/systrace.c	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,1378 @@
+/*
+ * systrace.c
+ *
+ * Copyright (c) 2002 Marius Aamodt Eriksen <marius@umich.edu>
+ * Copyright (c) 2002 Niels Provos <provos@citi.umich.edu>
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *  3. The names of the copyright holders may not be used to endorse or
+ *     promote products derived from this software without specific
+ *     prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ *  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
+ *  AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ *  THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ *  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ *  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ *  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ *  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/*
+ * XXX clone()'s with same PID
+ */
+
+#include <linux/sched.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/fs.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <linux/sys.h>
+#include <linux/miscdevice.h>
+#include <linux/queue.h>
+#include <linux/mount.h>
+#include <linux/init.h>
+
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+
+#include <linux/queue.h>	
+#include <linux/systrace.h>
+#include <linux/poll.h>
+
+#include "systrace-private.h"
+
+#define FIXARGS(argsize, args, regs) do {   \
+	switch (argsize) {                  \
+	case 20:                            \
+		args[4] = regs->edi;        \
+	case 16:                            \
+		args[3] = regs->esi;        \
+	case 12:                            \
+		args[2] = regs->edx;        \
+	case 8:                             \
+		args[1] = regs->ecx;        \
+	case 4:                             \
+		args[0] = regs->ebx;        \
+	case 0:                             \
+		break;                      \
+	default:                            \
+		printk(KERN_ERR "systrace: (FIXARGS) Illegal argument size %d\n", argsize);\
+		BUG();                      \
+	}                                   \
+} while (0)
+
+#define SAVEARGS(argsize, args, regs) do {  \
+	switch (argsize) {                  \
+	case 20:                            \
+		regs->edi = args[4];        \
+	case 16:                            \
+		regs->esi = args[3];        \
+	case 12:                            \
+		regs->edx = args[2];        \
+	case 8:                             \
+		regs->ecx = args[1];        \
+	case 4:                             \
+		regs->ebx = args[0];        \
+	case 0:                             \
+		break;                      \
+	default:                            \
+		printk(KERN_ERR "systrace: Illegal argument size %d\n", argsize);\
+		BUG();                      \
+	}                                   \
+} while (0)
+
+#define PRINTARGS(argsize, regs) do {                \
+	switch (argsize) {                           \
+	case 20:                                     \
+		printk("    edi: %lx\n", regs->edi); \
+	case 16:                                     \
+		printk("    esi: %lx\n", regs->esi); \
+	case 12:                                     \
+		printk("    edx: %lx\n", regs->edx); \
+	case 8:                                      \
+		printk("    ecx: %lx\n", regs->ecx); \
+	case 4:                                      \
+		printk("    ebx: %lx\n", regs->ebx); \
+	case 0:                                      \
+		break;                               \
+	default:                                     \
+		printk(KERN_ERR "systrace: Illegal argument size %d\n", argsize);\
+		BUG();                               \
+	}                                            \
+} while (0)
+
+#define SYSTRACE_MINOR 226
+
+spinlock_t str_lck = SPIN_LOCK_UNLOCKED;
+int systrace_debug = 0;
+
+
+/*
+ * Pass by registers; we need the stack that the system call will see
+ * in order to examine it and possibly modify.
+ */
+
+int  FASTCALL(systrace_intercept(struct pt_regs *));
+void FASTCALL(systrace_result(struct pt_regs *));
+
+static struct file_operations systrace_fops = {
+	read:    &systracef_read,
+	write:   &systracef_write,
+	ioctl:   &systracef_ioctl,
+	release: &systracef_release,
+	open:    &systracef_open,
+	poll:    &systracef_poll
+};
+
+static struct miscdevice systrace_dev = {
+	SYSTRACE_MINOR,
+	"systrace",
+	&systrace_fops
+};
+
+void
+_systrace_lock(void)
+{
+	spin_lock(&str_lck);
+}
+
+void
+_systrace_unlock(void)
+{
+	spin_unlock(&str_lck);
+}
+
+int
+init_systrace(void)
+{
+	if (misc_register(&systrace_dev) < 0) {
+		printk(KERN_INFO "systrace: unable to register device\n");
+		return (-EIO);
+	}
+
+	printk(KERN_INFO "systrace: systrace initialized\n");
+
+	return (0);
+}
+subsys_initcall(init_systrace);
+
+int
+systracef_open(struct inode *inode, struct file *file)
+{
+	struct fsystrace *fst;
+	int error = 0;
+
+	if ((fst = kmalloc(sizeof(*fst), GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "systrace: Failed to allocate kernel memory.\n");
+		error = 0;
+		goto out;
+	}
+
+	memset(fst, 0, sizeof(*fst));
+
+	TAILQ_INIT(&fst->processes);
+	TAILQ_INIT(&fst->policies);
+	TAILQ_INIT(&fst->messages);
+
+	init_MUTEX(&fst->lock);
+	init_waitqueue_head(&fst->wqh);
+
+	fst->euid = current->euid;
+	fst->egid = current->egid;
+	fst->issuser = capable(CAP_SYS_ADMIN);
+	fst->pid = current->pid;
+
+	file->private_data = fst;
+
+ out:
+	return (error);
+}
+
+int
+systracef_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+    unsigned long arg)
+{
+	struct fsystrace *fst = (struct fsystrace *)file->private_data;
+	pid_t pid = 0;
+	struct str_process *strp = NULL;
+	int error = 0;
+	void *data = NULL;
+
+	if (fst == NULL) {
+		printk(KERN_ERR "systrace: in impossible state!\n");
+		BUG();
+	}
+
+	/* Argument santizing */
+	switch (cmd) {
+	case STRIOCATTACH:
+	case STRIOCANSWER:
+	case STRIOCIO:
+	case STRIOCGETCWD:
+	case STRIOCDETACH:
+	case STRIOCPOLICY:
+	case STRIOCREPLACE:
+		if ((void *)arg == NULL)
+			error = -EINVAL;
+		break;
+	case STRIOCRESCWD:
+	default:
+		break;
+	}
+
+	if (error != 0)
+		goto out;
+
+	switch (cmd) {
+	case STRIOCANSWER:
+		if ((data = kmalloc(sizeof(struct systrace_answer),
+			 GFP_KERNEL)) == NULL) {
+			error = -ENOSPC;
+			break;
+		}
+		if (copy_from_user((struct systrace_answer *)data,
+			(struct systrace_answer *)arg,
+			sizeof(struct systrace_answer)) != 0) {
+			kfree(data);
+			error = -EFAULT;
+			break;
+		}
+
+		pid = ((struct systrace_answer *)data)->stra_pid;
+		break;
+	case STRIOCIO:
+		if ((data = kmalloc(sizeof(struct systrace_io),
+			 GFP_KERNEL)) == NULL) { 
+			error = -ENOSPC;
+			break;
+		}
+		if (copy_from_user((struct systrace_io *)data,
+			(struct systrace_io *)arg,
+			sizeof(struct systrace_io)) != 0) {
+			kfree(data);
+			error = -EFAULT;
+			break;
+		}
+
+		pid = ((struct systrace_io *)data)->strio_pid;
+		break;
+	case STRIOCGETCWD:
+	case STRIOCDETACH:
+		if (get_user(pid, (pid_t *)arg) != 0)
+			error = -EFAULT;
+
+		if (pid == 0)
+			error = -EINVAL;
+		break;
+	case STRIOCATTACH:
+	case STRIOCRESCWD:
+		break;
+	case STRIOCPOLICY:
+		if ((data = kmalloc(sizeof(struct systrace_policy),
+			 GFP_KERNEL)) == NULL) {
+			error = -ENOSPC;
+			break;
+		}
+		if (copy_from_user((struct systrace_policy *)data,
+			(struct systrace_policy *)arg,
+			sizeof(struct systrace_policy)) != 0) {
+			kfree(data);
+			error = -EFAULT;
+			break;
+		}
+		break;
+	case STRIOCREPLACE:
+		if ((data = kmalloc(sizeof(struct systrace_replace),
+			 GFP_KERNEL)) == NULL) {
+			error = -ENOSPC;
+			break;
+		}
+		if (copy_from_user((struct systrace_replace *)data,
+			(struct systrace_replace *)arg,
+			sizeof(struct systrace_replace)) != 0) {
+			kfree(data);
+			error = -EFAULT;
+			break;
+		}
+
+		pid = ((struct systrace_replace *)data)->strr_pid;
+		break;
+	default:
+		error = -EINVAL;
+	}
+
+	if (error != 0)
+		goto out;
+
+	systrace_lock();
+	down(&fst->lock);
+	systrace_unlock();
+
+	if (pid != 0)
+		if ((strp = systrace_findpid(fst, pid)) == NULL) {
+			error = -EINVAL;
+			goto unlock;
+		}
+
+	switch (cmd) {
+	case STRIOCATTACH:
+		if (get_user(pid, (pid_t *)arg) != 0)
+			error = -EFAULT;
+
+		if (pid == 0)
+			error = -EINVAL;
+		else
+			error = systrace_attach(fst, *(pid_t *)arg);
+		break;
+	case STRIOCDETACH:
+		error = systrace_detach(strp);
+		break;
+	case STRIOCANSWER:
+		error = systrace_answer(strp, (struct systrace_answer *)data);
+		break;
+	case STRIOCIO:
+		error = systrace_io(strp, (struct systrace_io *)data);
+		break;
+	case STRIOCGETCWD:
+		error = systrace_getcwd(fst, strp);
+		break;
+	case STRIOCRESCWD:
+		error = systrace_rescwd(fst);
+		break;
+	case STRIOCPOLICY:
+		error = systrace_policy(fst, (struct systrace_policy *)data);
+		if (copy_to_user((struct systrace_policy *)arg,
+			(struct systrace_policy *)data,
+			sizeof(struct systrace_policy)) != 0)
+			error = -EFAULT;
+		break;
+	case STRIOCREPLACE:
+		error = systrace_preprepl(strp, (struct systrace_replace *)data);
+		break;
+	default:
+		/* XXX */
+		break;
+	}
+
+	if (data != NULL)
+		kfree(data);
+
+ unlock:
+	up(&fst->lock);
+ out:
+	return (error);
+}
+
+unsigned int
+systracef_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct fsystrace *fst = (struct fsystrace *)file->private_data;
+	unsigned int ret = 0;
+
+	systrace_lock();
+	down(&fst->lock);
+	systrace_unlock();
+
+	poll_wait(file, &fst->wqh, wait);
+
+	if (TAILQ_FIRST(&fst->messages) != NULL)
+		ret = POLLIN | POLLRDNORM;
+
+	up(&fst->lock);
+
+	return (ret);
+}
+
+ssize_t
+systracef_read(struct file *filp, char *buf, size_t count, loff_t *off)
+{
+	struct fsystrace *fst = (struct fsystrace *)filp->private_data;
+	struct str_process *strp;
+	int error = 0;
+
+	if (count != sizeof(struct str_message))
+		return (-EINVAL);
+
+ again:
+	systrace_lock();
+	down(&fst->lock);
+	systrace_unlock();
+
+	if ((strp = TAILQ_FIRST(&fst->messages)) != NULL) {
+		error = copy_to_user(buf, &strp->msg, sizeof(struct str_message));
+		if (error != 0) {
+			error = -EFAULT;
+		} else {
+			error = sizeof(struct str_message);
+			TAILQ_REMOVE(&fst->messages, strp, msg_next);
+			CLR(strp->flags, STR_PROC_ONQUEUE);
+
+			if (SYSTR_MSG_NOPROCESS(strp))
+				kfree(strp);
+		}
+	} else if (TAILQ_FIRST(&fst->processes) == NULL) {
+		/* EOF situation */
+		;
+	} else {
+		if (filp->f_flags & O_NONBLOCK) {
+			error = -EAGAIN;
+		} else {
+			up(&fst->lock);
+			interruptible_sleep_on(&fst->wqh);
+
+			if (signal_pending(current)) {
+				error = -ERESTARTSYS;
+				goto out;
+			}
+			goto again;
+		}
+	}
+
+	up(&fst->lock);
+ out:
+	return (error);
+}
+
+ssize_t
+systracef_write(struct file *filp, const char *buf, size_t count, loff_t *off)
+{
+	return (-ENOTSUPP);
+}
+
+int
+systracef_release(struct inode *inode, struct file *filp)
+{
+	struct str_process *strp;
+	struct fsystrace *fst = filp->private_data;
+	struct str_policy *strpol;
+
+	systrace_lock();
+	down(&fst->lock);
+	systrace_unlock();
+
+	/* Kill all traced processes */
+	while ((strp = TAILQ_FIRST(&fst->processes)) != NULL) {
+		struct task_struct *p = strp->proc;
+
+		systrace_detach(strp);
+		kill_proc(p->pid, SIGKILL, 1);
+	}
+
+	/* Clean up fork and exit messages */
+	while ((strp = TAILQ_FIRST(&fst->messages)) != NULL) {
+		TAILQ_REMOVE(&fst->messages, strp, msg_next);
+		kfree(strp);
+	}
+
+	/* Clean up policies */
+	while ((strpol = TAILQ_FIRST(&fst->policies)) != NULL)
+		systrace_closepolicy(fst, strpol);
+
+	up(&fst->lock);
+
+	kfree(filp->private_data);
+	filp->private_data = NULL;
+
+	return (0);
+}
+
+void
+systrace_fork(struct task_struct *parent, struct task_struct *child)
+{
+	struct str_process *parentstrp, *strp;
+	struct fsystrace *fst;
+
+	systrace_lock();
+	if ((parentstrp = parent->systrace) == NULL) {
+		systrace_unlock();
+		return;
+	}
+
+	fst = parentstrp->parent;
+	down(&fst->lock);
+	systrace_unlock();
+
+	if (systrace_insert_process(fst, child) != 0) {
+		printk(KERN_ERR "systrace: failed inserting process!\n");
+		goto out;
+	}
+
+	/* XXX make sure we have pid by this time in fork() */
+	if ((strp = systrace_findpid(fst, child->pid)) == NULL) {
+		printk(KERN_ERR "systrace: inconsistency in tracked process!\n");
+		BUG();
+	}
+
+	if ((strp->policy = parentstrp->policy) != NULL)
+		strp->policy->refcount++;
+
+	/* Fork message */
+	systrace_msg_child(fst, parentstrp, child->pid);
+ out:
+	up(&fst->lock);
+}
+
+void
+systrace_exit(struct task_struct *p)
+{
+	struct str_process *strp;
+	struct fsystrace *fst;
+
+	systrace_lock();
+	if ((strp = p->systrace) != NULL) {
+		fst = strp->parent;
+		down(&fst->lock);
+		systrace_unlock();
+
+		/* Notify our monitor of our death */
+		systrace_msg_child(fst, strp, -1);
+
+		systrace_detach(strp);
+		up(&fst->lock);
+	} else {
+		systrace_unlock();
+	}
+}
+
+void fastcall
+systrace_result(struct pt_regs *regs)
+{
+	struct str_process *strp;
+	struct fsystrace *fst;
+	int error, argsize, narg, code;
+	extern struct sysent linux_sysent[];
+
+	systrace_lock();
+
+	if ((strp = current->systrace) == NULL)
+		goto out;
+
+	code = strp->code;
+	narg = linux_sysent[code].sy_narg;
+	argsize = sizeof(register_t) * narg;
+
+	fst = strp->parent;
+
+	/* Restore elevated priveliges if appropriate */
+	if (strp->issuser) {
+		if (ISSET(strp->flags, STR_PROC_SETEUID)) {
+			if (current->euid == strp->seteuid) {
+				systrace_seteuid(current, strp->savedeuid);
+				CLR(strp->flags, STR_PROC_SETEUID);
+			}
+			if (current->egid == strp->setegid) {
+				systrace_setegid(current, strp->savedegid);
+				CLR(strp->flags, STR_PROC_SETEGID);
+			}
+		}
+	}
+
+	/* Change in UID/GID */
+	if (strp->oldegid != current->egid || strp->oldeuid != current->euid) {
+		down(&fst->lock);
+		systrace_unlock();
+
+		systrace_msg_ugid(fst, strp);
+		systrace_lock();
+		if ((strp = current->systrace) == NULL)
+			goto out;
+	}
+
+	if (ISSET(strp->flags, STR_PROC_SYSCALLRES)) {
+		CLR(strp->flags, STR_PROC_SYSCALLRES);
+
+ 		down(&fst->lock);
+		systrace_unlock();
+
+		error = regs->eax;
+
+		systrace_msg_result(fst, strp, error, code, argsize, strp->args);
+		systrace_lock();
+		if ((strp = current->systrace) == NULL)
+			goto out;
+	}
+
+	if (strp->replace != NULL) {
+		kfree(strp->replace);
+		strp->replace = NULL;
+	}
+
+	if (ISSET(strp->flags, STR_PROC_FSCHANGE))
+		set_fs(strp->oldfs);
+
+ out:
+	systrace_unlock();
+}
+
+/*
+ * XXX serialize system calls
+ */
+int fastcall
+systrace_intercept(struct pt_regs *regs)
+{
+	register_t args[8];
+	int argsize, narg, code, error = 0, maycontrol = 0, issuser = 0;
+	short policy;
+	struct str_process *strp;
+	struct fsystrace *fst = NULL;
+	extern struct sysent linux_sysent[];
+	struct str_policy *strpolicy;
+
+	systrace_lock();
+
+	if ((strp = current->systrace) == NULL) {
+		systrace_unlock();
+		goto out;
+	}
+
+	fst = strp->parent;
+
+	down(&fst->lock);
+	systrace_unlock();
+
+	CLR(strp->flags, STR_PROC_FSCHANGE);
+
+	if (regs != NULL) {
+		code = regs->orig_eax;
+	} else {
+		error = -EPERM;
+		goto out;
+ 	}
+
+	if (code > NR_syscalls) {
+		printk(KERN_ERR "systrace: in impossible state!\n");
+		BUG();
+	}
+
+	narg = linux_sysent[code].sy_narg;
+	argsize = sizeof(register_t) * narg;
+
+	/*
+	 * Linux passes system call arguments in registers.  We want
+	 * to be able to pass back an args array; convert
+	 * appropriately.
+	 */
+
+	FIXARGS(argsize, args, regs);
+
+	if (strp->proc != current) {
+		printk(KERN_ERR "systrace: inconsistency in process states!\n");
+		BUG();
+	}
+
+	if (fst->issuser) {
+		maycontrol = 1;
+		issuser = 1;
+	} else if (cap_isclear(current->cap_effective) &&
+	    !(current->flags & PF_SUPERPRIV) &&
+	    current->mm->dumpable) {
+		maycontrol = fst->euid == current->euid &&
+		    fst->egid == current->egid;
+	}
+
+	strp->code = code;
+	strp->maycontrol = maycontrol;
+	memcpy(strp->args, args, sizeof(strp->args));
+	strp->oldeuid = current->euid;
+	strp->oldegid = current->egid;
+	strp->issuser = fst->issuser;
+
+	if (!maycontrol) {
+		policy = SYSTR_POLICY_PERMIT;
+	} else {
+		/* Find out current policy */
+		if ((strpolicy = strp->policy) == NULL) {
+			policy = SYSTR_POLICY_ASK;
+		} else {
+			if (code >= strpolicy->nsysent)
+				policy = SYSTR_POLICY_NEVER;
+			else
+				policy = strpolicy->sysent[code];
+		}
+	}
+
+	switch (policy) {
+	case SYSTR_POLICY_PERMIT:
+		break;
+	case SYSTR_POLICY_ASK:
+		error = systrace_msg_ask(fst, strp, code, argsize, args);
+		/* systrace_msg_ask releases lock */
+		fst = NULL;
+		/* We might have detached by now for some reason */
+		if (error == 0 && (strp = current->systrace) != NULL) {
+			/* XXX - do I need to lock here? */
+			if (strp->answer == SYSTR_POLICY_NEVER) {
+				error = strp->error;
+				if (strp->replace != NULL) {
+					kfree(strp->replace);
+					strp->replace = NULL;
+				}
+			} else if (strp->replace != NULL) {
+				if ((error = systrace_replace(strp,
+					 argsize, args) == 0)) {
+					SAVEARGS(argsize, args, regs);
+					strp->oldfs = get_fs();
+					set_fs(get_ds());
+					SET(strp->flags, STR_PROC_FSCHANGE);
+				}
+			}
+		}
+		break;
+	case SYSTR_POLICY_NEVER:
+		error = -EPERM;
+		break;
+	default:
+		if (policy < 0)
+			error = policy;
+		else
+			error = -EPERM;
+		break;
+	}
+
+	/* XXX */
+/*
+	if (error != 0)
+		goto out;
+*/
+	systrace_lock();
+	if ((strp = current->systrace) != NULL) {
+		if (issuser) {
+			if (ISSET(strp->flags, STR_PROC_SETEUID)) {
+				strp->savedeuid = systrace_seteuid(current, strp->seteuid);
+			}
+			if (ISSET(strp->flags, STR_PROC_SETEGID)) {
+				strp->savedegid = systrace_setegid(current, strp->setegid);
+			}
+		} else {
+			CLR(strp->flags, STR_PROC_SETEUID | STR_PROC_SETEGID);
+		}
+	}
+	systrace_unlock();
+
+ out:
+	if (fst != NULL)
+		up(&fst->lock);
+
+	return (error);
+}
+
+int
+systrace_preprepl(struct str_process *strp, struct systrace_replace *repl)
+{
+	size_t len;
+	int i, error = 0;
+
+	if ((error = systrace_processready(strp)) != 0)
+		return (error);
+
+	if (strp->replace != NULL) {
+		kfree(strp->replace);
+		strp->replace = NULL;
+	}
+
+	if (repl->strr_nrepl < 0 || repl->strr_nrepl > SYSTR_MAXARGS)
+		return (-EINVAL);
+
+	for (i = 0, len = 0; i < repl->strr_nrepl; i++) {
+		len += repl->strr_offlen[i];
+		if (repl->strr_offlen[i] == 0)
+			continue;
+		if (repl->strr_offlen[i] + repl->strr_off[i] > len)
+			return (-EINVAL);
+	}
+
+	/* Make sure that the length adds up */
+	if (repl->strr_len != len)
+		return (-EINVAL);
+
+	/* Check against a maximum length */
+	if (repl->strr_len > 2048)
+		return (-EINVAL);
+
+	if ((strp->replace = kmalloc(sizeof(*strp->replace) + len, GFP_KERNEL))
+	    == NULL) 
+		return (-ENOSPC);
+
+	memcpy(strp->replace, repl, sizeof(*strp->replace));
+
+	if (copy_from_user(strp->replace + 1, repl->strr_base, len) != 0) {
+		kfree(strp->replace);
+		strp->replace = NULL;
+		return (-EFAULT);
+	}
+
+	/* Adjust the offset */
+	repl = strp->replace;
+	repl->strr_base = (void *)(repl + 1);
+
+	return (0);
+}
+
+/*
+ * Replace the arguments with arguments from the monitoring process.
+ */
+int
+systrace_replace(struct str_process *strp, size_t argsize, register_t args[])
+{
+	struct systrace_replace *repl = strp->replace;
+	void *kbase;
+	int i, maxarg, ind, ret = 0;
+
+	maxarg = argsize / sizeof(register_t);
+
+	kbase = repl->strr_base;
+	for (i = 0; i < maxarg && i < repl->strr_nrepl; i++) {
+		ind = repl->strr_argind[i];
+		if (ind < 0 || ind >= maxarg) {
+			kfree(repl);
+			strp->replace = NULL;
+			return (-EINVAL);
+		}
+		if (repl->strr_offlen[i] == 0) {
+			args[ind] = repl->strr_off[i];
+			continue;
+		}
+
+		/* Replace the argument with the new address */
+		args[ind] = (register_t)(kbase + repl->strr_off[i]);
+	}
+
+	return (ret);
+}
+
+int
+systrace_answer(struct str_process *strp, struct systrace_answer *ans)
+{
+	int error = 0;
+
+	if (!POLICY_VALID(ans->stra_policy)) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	/* Check if answer is in sync with us */
+	if (ans->stra_seqnr != strp->seqnr) {
+		error = -EINVAL;
+		goto out;
+	}
+
+	if ((error = systrace_processready(strp)) != 0)
+		goto out;
+
+	strp->answer = ans->stra_policy;
+	strp->error = ans->stra_error;
+	if (!strp->error)
+		strp->error = -EPERM;
+	if (ISSET(ans->stra_flags, SYSTR_FLAGS_RESULT))
+		SET(strp->flags, STR_PROC_SYSCALLRES);
+
+        /* See if we should elevate privileges for this system call */
+        if (ISSET(ans->stra_flags, SYSTR_FLAGS_SETEUID)) {
+                SET(strp->flags, STR_PROC_SETEUID);
+                strp->seteuid = ans->stra_seteuid;
+        }
+        if (ISSET(ans->stra_flags, SYSTR_FLAGS_SETEGID)) {
+                SET(strp->flags, STR_PROC_SETEGID);
+                strp->setegid = ans->stra_setegid;
+        }
+
+	/* Clearing the flag indicates to the process that it woke up */
+	CLR(strp->flags, STR_PROC_WAITANSWER);
+	wake_up(&strp->wqh);
+ out:
+
+	return (error);
+}
+
+int
+systrace_io(struct str_process *strp, struct systrace_io *io)
+{
+	int rw, ret = 0, copied, maycontrol = 0;
+	void *buf;
+	struct fsystrace *fst = strp->parent;
+	struct task_struct *tsk = strp->proc;
+
+	if (fst->issuser) {
+		maycontrol = 1;
+	} else if (cap_isclear(tsk->cap_effective) &&
+	    !(tsk->flags & PF_SUPERPRIV) &&
+	    tsk->mm->dumpable) {
+		maycontrol = current->euid == tsk->euid &&
+		    current->egid == tsk->egid;
+	}
+
+	if (!maycontrol)
+		return (-EPERM);
+
+	if ((buf = kmalloc(io->strio_len, GFP_KERNEL)) == NULL) {
+		printk(KERN_ERR "systrace: failed to allocate kernel memory!\n");
+		return (-ENOMEM);
+	}
+
+	switch (io->strio_op) {
+	case SYSTR_READ:
+		rw = 0;
+		break;
+	case SYSTR_WRITE:
+		rw = 1;
+		if (copy_from_user(buf, io->strio_addr, io->strio_len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	default:
+		return (-EINVAL);
+	}
+
+	copied = access_process_vm(tsk, (unsigned long)io->strio_offs, buf,
+	    io->strio_len, rw);
+
+	if (copied != io->strio_len) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	switch (io->strio_op) {
+	case SYSTR_READ:
+		if (copy_to_user(io->strio_addr, buf, io->strio_len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		break;
+	}
+
+ out:
+	kfree(buf);
+
+	return (ret);
+}
+
+int
+systrace_getcwd(struct fsystrace *fst, struct str_process *strp)
+{
+	struct fs_struct *fsc, *fsp;
+	int error = 0;
+
+	if ((error = systrace_processready(strp)) != 0)
+		return (error);
+
+	task_lock(current);
+	task_lock(strp->proc);
+	fsc = current->fs;
+	fsp = strp->proc->fs;
+
+	if (fsc == NULL || fsp == NULL) {
+		task_unlock(current);
+		task_unlock(strp->proc);
+		return (-EINVAL);
+	}
+
+	fst->pwd_pid = strp->pid;
+
+	/* XXX altroot? */
+	write_lock(&fsc->lock);
+
+	fst->pwd_mnt = fsc->pwdmnt;
+	fst->pwd_dentry = fsc->pwd;
+	fst->root_mnt = fsc->rootmnt;
+	fst->root_dentry = fsc->root;
+
+	read_lock(&fsp->lock);
+	fsc->pwdmnt = mntget(fsp->pwdmnt);
+	fsc->pwd = dget(fsp->pwd);
+	fsc->rootmnt = mntget(fsp->rootmnt);
+	fsc->root = dget(fsp->root);
+	read_unlock(&fsp->lock);
+
+	write_unlock(&fsc->lock);
+
+	task_unlock(current);
+	task_unlock(strp->proc);
+
+	return (0);
+}
+
+int
+systrace_rescwd(struct fsystrace *fst)
+{
+	struct fs_struct *fsc;
+
+	if (fst->pwd_pid == 0)
+		return (-EINVAL);
+
+	fsc = current->fs;
+
+	write_lock(&fsc->lock);
+	dput(fsc->pwd);
+	mntput(fsc->pwdmnt);
+	dput(fsc->root);
+	mntput(fsc->rootmnt);
+
+	fsc->pwd = fst->pwd_dentry;
+	fsc->pwdmnt = fst->pwd_mnt;
+	fsc->root = fst->root_dentry;
+	fsc->rootmnt = fst->root_mnt;
+	write_unlock(&fsc->lock);
+
+	fst->pwd_pid = 0;
+
+	return (0);
+}
+
+int
+systrace_processready(struct str_process *strp)
+{
+	if (ISSET(strp->flags, STR_PROC_ONQUEUE))
+		return (-EBUSY);
+
+	if (!ISSET(strp->flags, STR_PROC_WAITANSWER))
+		return (-EBUSY);
+
+	if (ISSET(strp->proc->flags, PF_EXITING))
+		return (-EBUSY);
+
+#if 0
+	if (strp->proc->state != 0)
+		return (-EBUSY);
+#endif /* 0 */
+
+	return (0);
+}
+
+int
+systrace_insert_process(struct fsystrace *fst, struct task_struct *p)
+{
+	struct str_process *strp;
+
+	if ((strp = kmalloc(sizeof(*strp), GFP_KERNEL)) == NULL)
+		return (-ENOMEM);
+
+	memset(strp, 0, sizeof(*strp));
+
+	strp->pid = p->pid;
+	strp->proc = p;
+	strp->parent = fst;
+
+	init_waitqueue_head(&strp->wqh);
+	init_MUTEX(&strp->lock);
+
+	/* Insert into parent's process list */
+	TAILQ_INSERT_TAIL(&fst->processes, strp, next);
+	fst->nprocesses++;
+
+	/* XXX need process flag*/
+	p->systrace = strp;
+
+	return (0);
+}
+
+struct str_process *
+systrace_findpid(struct fsystrace *fst, pid_t pid)
+{
+	struct str_process *strp;
+	struct task_struct *proc;
+
+	TAILQ_FOREACH(strp, &fst->processes, next)
+	    if (strp->pid == pid)
+		    break;
+
+	if (strp == NULL)
+		return (NULL);
+
+	proc = systrace_find(strp);
+
+	return (proc != NULL ? strp : NULL);
+}
+
+int
+systrace_attach(struct fsystrace *fst, pid_t pid)
+{
+	struct task_struct *proc;
+
+	proc = find_task_by_pid(pid);
+	if (proc == NULL)
+		return (-EINVAL);
+
+	/* (1) Same process */
+
+	if (proc->pid == current->pid)
+		return (-EINVAL);
+
+	/* (2) System process */
+	/* XXX */
+
+	/* (3) Already being systraced */
+
+	if (proc->systrace != NULL)
+		return (-EBUSY);
+
+	/*
+	 * (4) We do not own it, it's not set{u,g}id AND we are not
+	 *     root
+	 */
+	if ((!cap_isclear(proc->cap_permitted) || proc->flags & PF_SUPERPRIV ||
+		proc->euid != current->euid || proc->egid != current->egid) &&
+	   !capable(CAP_SYS_ADMIN))
+		return (-EPERM);
+
+	/* (5) It's init */
+	if (proc->pid == 1)
+		return (-EPERM);
+
+	return (systrace_insert_process(fst, proc));
+}
+
+int
+systrace_detach(struct str_process *strp)
+{
+	struct fsystrace *fst = strp->parent;
+	struct task_struct *proc;
+	int error = 0;
+
+	if ((proc = systrace_find(strp)) != NULL)
+		proc->systrace = NULL;
+	else
+		error = -EINVAL;
+
+	if (ISSET(strp->flags, STR_PROC_WAITANSWER)) {
+		CLR(strp->flags, STR_PROC_WAITANSWER);
+		wake_up(&strp->wqh);
+	}
+
+	fst = strp->parent;
+	wake_up(&fst->wqh);
+
+	if (ISSET(strp->flags, STR_PROC_ONQUEUE)) 
+		TAILQ_REMOVE(&fst->messages, strp, msg_next);
+
+	TAILQ_REMOVE(&fst->processes, strp, next);
+	fst->nprocesses--;
+
+	if (strp->policy != NULL)
+		systrace_closepolicy(fst, strp->policy);
+	if (strp->replace != NULL)
+		kfree(strp->replace);
+
+	kfree(strp);
+
+	return (error);
+}
+
+int
+systrace_msg_result(struct fsystrace *fst, struct str_process *strp,
+    int error, int code, size_t argsize, register_t args[])
+{
+	struct str_msg_ask *msg_ask = &strp->msg.msg_data.msg_ask;
+	int i;
+
+	msg_ask->code = code;
+	/* XXX argsize */
+	/* += fixup_socket_argsize ... () */
+	msg_ask->argsize = argsize;
+	msg_ask->result = error;
+	for (i = 0; i < argsize / sizeof(register_t) && i < SYSTR_MAXARGS; i++)
+		msg_ask->args[i] = args[i];
+
+	msg_ask->rval[0] = 0x42;
+	msg_ask->rval[1] = 0x42;
+
+	return (systrace_make_msg(strp, SYSTR_MSG_RES));
+}
+
+int
+systrace_msg_ask(struct fsystrace *fst, struct str_process *strp, int code,
+    size_t argsize, register_t args[])
+{
+	struct str_msg_ask *msg_ask = &strp->msg.msg_data.msg_ask;
+	int i;
+
+	msg_ask->code = code;
+	/* XXX argsize */
+	msg_ask->argsize = argsize;
+	for (i = 0; i < (argsize / sizeof(register_t)) && i < SYSTR_MAXARGS; i++)
+		msg_ask->args[i] = args[i];
+
+	return (systrace_make_msg(strp, SYSTR_MSG_ASK));
+}
+
+int
+systrace_msg_ugid(struct fsystrace *fst, struct str_process *strp)  
+{
+        struct str_msg_ugid *msg_ugid = &strp->msg.msg_data.msg_ugid;
+        struct task_struct *tsk = strp->proc;
+
+        msg_ugid->uid = tsk->euid;
+        msg_ugid->gid = tsk->egid;
+
+        return (systrace_make_msg(strp, SYSTR_MSG_UGID));
+}
+
+int
+systrace_msg_execve(struct fsystrace *fst, struct str_process *strp, register_t patharg)
+{
+        struct str_msg_execve *msg_execve = &strp->msg.msg_data.msg_execve;
+
+	msg_execve->patharg = patharg;
+
+        return (systrace_make_msg(strp, SYSTR_MSG_EXECVE));
+}
+
+int
+systrace_msg_child(struct fsystrace *fst, struct str_process *strp, pid_t npid)
+{
+	struct str_process *nstrp;
+	struct str_message *msg;
+	struct str_msg_child *msg_child;
+
+	/* XXX - use kmem cache!@; pool_*() like interface to it? */
+	if ((nstrp = kmalloc(sizeof(*nstrp), GFP_KERNEL)) == NULL)
+		return (-1);
+
+	memset(nstrp, 0, sizeof(*nstrp));
+
+	DPRINTF(("%s: %p: pid %d -> pid %d\n", __func__, nstrp, strp->pid, npid));
+
+	msg = &nstrp->msg;
+	msg_child = &msg->msg_data.msg_child;
+
+	msg->msg_type = SYSTR_MSG_CHILD;
+	msg->msg_pid = strp->pid;
+	if (strp->policy)
+		msg->msg_policy = strp->policy->nr;
+	else
+		msg->msg_policy = -1;
+	msg_child->new_pid = npid;
+
+	TAILQ_INSERT_TAIL(&fst->messages, nstrp, msg_next);
+
+	wake_up(&fst->wqh);
+
+	return (0);
+}
+
+int
+systrace_make_msg(struct str_process *strp, int type)
+{
+	struct str_message *msg = &strp->msg;
+	struct fsystrace *fst = strp->parent;
+	int error = 0;
+
+	msg->msg_seqnr = ++strp->seqnr;
+	msg->msg_type = type;
+	msg->msg_pid = strp->pid;
+
+	if (strp->policy)
+		msg->msg_policy = strp->policy->nr;
+	else
+		msg->msg_policy = -1;
+
+	SET(strp->flags, STR_PROC_WAITANSWER);
+	if (ISSET(strp->flags, STR_PROC_ONQUEUE))
+		goto out;
+
+	TAILQ_INSERT_TAIL(&fst->messages, strp, msg_next);
+	SET(strp->flags, STR_PROC_ONQUEUE);
+	/*
+	 * XXX; need to do schedule trick here; what if we sleep on
+	 * up(), then we might have awoken again, without knowing
+	 */
+ out:
+	wake_up(&fst->wqh);
+	lock_kernel();
+	up(&fst->lock);
+
+	/* Sleep until we have got a reply */
+	for (;;) {
+		interruptible_sleep_on(&strp->wqh);
+
+		if (signal_pending(current)) {
+			error = -EINTR;
+			break;
+		}
+
+		/* If we detach, then everything is permitted */
+		if ((strp = current->systrace) == NULL)
+			break;
+
+		if (!ISSET(strp->flags, STR_PROC_WAITANSWER))
+			break;
+	}
+
+	unlock_kernel();
+
+	return (0);
+}
+
+uid_t
+systrace_seteuid(struct task_struct *tsk, uid_t euid)
+{
+	uid_t oldeuid = tsk->euid;
+
+	if (euid == oldeuid)
+		return (oldeuid);
+
+	/* XXX */
+	tsk->mm->dumpable = 0;
+	wmb();
+
+	tsk->euid = euid;
+	tsk->fsuid = euid;
+
+	if (oldeuid != 0 && euid == 0)
+		current->cap_effective = CAP_FULL_SET;
+	else if (oldeuid == 0 && euid != 0)
+		cap_clear(current->cap_effective);
+
+	return (oldeuid);
+}
+
+gid_t
+systrace_setegid(struct task_struct *tsk, gid_t egid)
+{
+	uid_t oldegid = tsk->egid;
+
+	if (egid == oldegid)
+		return (oldegid);
+
+	/* XXX */
+	tsk->mm->dumpable = 0;
+	wmb();
+
+	tsk->egid = egid;
+	tsk->fsgid = egid;
+
+	return (oldegid);
+}
+
+struct task_struct *
+systrace_find(struct str_process *strp)
+{
+        struct task_struct *proc;
+
+        if ((proc = find_task_by_pid(strp->pid)) == NULL)
+                return (NULL);
+
+        if (proc != strp->proc)
+                return (NULL);
+
+	if (proc->systrace == NULL)
+                return (NULL);
+
+        return (proc);
+}
diff -ruN linux-2.6.19-vanilla/drivers/systrace/systrace-private.h linux-2.6.19/drivers/systrace/systrace-private.h
--- linux-2.6.19-vanilla/drivers/systrace/systrace-private.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/drivers/systrace/systrace-private.h	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,144 @@
+/*
+ * systrace-private.h
+ *
+ * Copyright (c) 2002 Marius Aamodt Eriksen <marius@umich.edu>
+ * Copyright (c) 2002 Niels Provos <provos@citi.umich.edu>
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *  1. Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *  2. Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in the
+ *     documentation and/or other materials provided with the distribution.
+ *  3. The names of the copyright holders may not be used to endorse or
+ *     promote products derived from this software without specific
+ *     prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ *  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
+ *  AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
+ *  THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
+ *  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ *  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
+ *  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ *  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef SYSTRACE_PRIVATE_H
+#define SYSTRACE_PRIVATE_H
+
+#define POLICY_VALID(x)	((x) == SYSTR_POLICY_PERMIT || \
+			 (x) == SYSTR_POLICY_ASK ||    \
+			 (x) == SYSTR_POLICY_NEVER)
+
+#define DPRINTF(x) if (systrace_debug) printk x
+
+struct str_policy {
+	int                      nr;
+	struct emul             *emul;	   /* XXX */
+	int                      refcount;
+	int                      nsysent;
+	short                   *sysent;
+	TAILQ_ENTRY(str_policy)  next;
+};
+
+#define STR_PROC_ONQUEUE	0x01
+#define STR_PROC_WAITANSWER	0x02
+#define STR_PROC_SYSCALLRES	0x04
+#define STR_PROC_REPORT		0x08	/* Report emulation */
+#define STR_PROC_FSCHANGE	0x10
+#define STR_PROC_SETEUID        0x20    /* Elevate privileges */ 
+#define STR_PROC_SETEGID        0x40
+
+struct str_process {
+	TAILQ_ENTRY(str_process)  next;
+	TAILQ_ENTRY(str_process)  msg_next;
+	struct semaphore          lock;	
+	struct task_struct       *proc;
+	pid_t pid;
+	struct fsystrace         *parent;
+	struct str_policy        *policy;
+	wait_queue_head_t         wqh;	
+	int                       flags;
+	short                     answer;
+	short                     error;
+	u16                       seqnr; /* XXX: convert to u_int16_t  */
+	struct str_message        msg;
+	struct systrace_replace  *replace;
+	int                       report;
+	mm_segment_t              oldfs;
+	int                       maycontrol;
+	int                       code;
+	register_t                args[8];
+	uid_t                     oldeuid;
+	gid_t                     oldegid;
+	uid_t                     savedeuid;
+	uid_t                     savedegid;
+	uid_t                     seteuid;
+	uid_t                     setegid;
+	int                       issuser;
+};
+
+/* VFS interface */
+int                systracef_ioctl(struct inode *, struct file *, unsigned int,
+                       unsigned long);
+ssize_t            systracef_read(struct file *, char *, size_t, loff_t *);
+ssize_t            systracef_write(struct file *, const char *, size_t, loff_t *);
+int                systracef_open(struct inode *, struct file *);
+int                systracef_release(struct inode *, struct file *);
+unsigned int       systracef_poll(struct file *, struct poll_table_struct *);
+
+/* Policy handling */
+struct str_policy *systrace_newpolicy(struct fsystrace *, int);
+void               systrace_closepolicy(struct fsystrace *, struct str_policy *);
+int                systrace_policy(struct fsystrace *, struct systrace_policy *);
+struct str_policy *systrace_newpolicy(struct fsystrace *, int);
+
+/* Message utility functions */
+int                 systrace_msg_child(struct fsystrace *, struct str_process *, pid_t);
+int                 systrace_msg_result(struct fsystrace *, struct str_process *, int, int,
+                        size_t, register_t[]);
+int                 systrace_msg_ask(struct fsystrace *, struct str_process *, int, size_t, register_t[]);
+int                 systrace_msg_ugid(struct fsystrace *, struct str_process *);
+int                 systrace_msg_execve(struct fsystrace *, struct str_process *, register_t);
+int                 systrace_make_msg(struct str_process *, int);
+int                 systrace_make_msg(struct str_process *, int);
+
+int                 systrace_io(struct str_process *, struct systrace_io *);
+int                 systrace_getcwd(struct fsystrace *, struct str_process *);
+int                 systrace_rescwd(struct fsystrace *);
+int                 systrace_attach(struct fsystrace *, pid_t);
+int                 systrace_detach(struct str_process *);
+int                 systrace_answer(struct str_process *, struct systrace_answer *);
+int                 systrace_insert_process(struct fsystrace *, struct task_struct *);
+int                 systrace_processready(struct str_process *);
+struct str_process *systrace_findpid(struct fsystrace *, pid_t);
+struct task_struct *systrace_find(struct str_process *);
+
+int                 systrace_preprepl(struct str_process *, struct systrace_replace *);
+int                 systrace_replace(struct str_process *, size_t, register_t[]);
+uid_t               systrace_seteuid(struct task_struct *, uid_t);
+gid_t               systrace_setegid(struct task_struct *, gid_t);
+
+#if 0
+void                systrace_lock(void);
+void                systrace_unlock(void);
+#endif /* 0 */
+/*
+ * Currently, disable the fine grained locking and use the big kernel
+ * lock instead.  The only thing keeping me from using the fine
+ * grained locking is in systrace_make_msg(); when fst->lock is
+ * relinquished, there is a race condition until we sleep on the strp;
+ * it could have been detached in the mean time, causing nasty things
+ * to happen.  When using the kernel lock, it is automatically
+ * relinquished when needed.
+ */
+#define systrace_lock(...) lock_kernel();
+#define systrace_unlock(...) unlock_kernel();
+
+#endif /* SYSTRACE_PRIVATE_H */
diff -ruN linux-2.6.19-vanilla/include/linux/queue.h linux-2.6.19/include/linux/queue.h
--- linux-2.6.19-vanilla/include/linux/queue.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/include/linux/queue.h	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,145 @@
+/*	$OpenBSD: queue.h,v 1.22 2001/06/23 04:39:35 angelos Exp $	*/
+/*	$NetBSD: queue.h,v 1.11 1996/05/16 05:17:14 mycroft Exp $	*/
+
+/*
+ * Copyright (c) 1991, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. All advertising materials mentioning features or use of this software
+ *    must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Berkeley and its contributors.
+ * 4. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ *	@(#)queue.h	8.5 (Berkeley) 8/20/94
+ */
+
+#ifndef	_SYS_QUEUE_H_
+#define	_SYS_QUEUE_H_
+
+/*
+ * Tail queue definitions.
+ */
+#define TAILQ_HEAD(name, type)						\
+struct name {								\
+	struct type *tqh_first;	/* first element */			\
+	struct type **tqh_last;	/* addr of last next element */		\
+}
+
+#define TAILQ_HEAD_INITIALIZER(head)					\
+	{ NULL, &(head).tqh_first }
+
+#define TAILQ_ENTRY(type)						\
+struct {								\
+	struct type *tqe_next;	/* next element */			\
+	struct type **tqe_prev;	/* address of previous next element */	\
+}
+
+/* 
+ * tail queue access methods 
+ */
+#define	TAILQ_FIRST(head)		((head)->tqh_first)
+#define	TAILQ_END(head)			NULL
+#define	TAILQ_NEXT(elm, field)		((elm)->field.tqe_next)
+#define TAILQ_LAST(head, headname)					\
+	(*(((struct headname *)((head)->tqh_last))->tqh_last))
+/* XXX */
+#define TAILQ_PREV(elm, headname, field)				\
+	(*(((struct headname *)((elm)->field.tqe_prev))->tqh_last))
+#define	TAILQ_EMPTY(head)						\
+	(TAILQ_FIRST(head) == TAILQ_END(head))
+
+#define TAILQ_FOREACH(var, head, field)					\
+	for((var) = TAILQ_FIRST(head);					\
+	    (var) != TAILQ_END(head);					\
+	    (var) = TAILQ_NEXT(var, field))
+
+#define TAILQ_FOREACH_REVERSE(var, head, field, headname)		\
+	for((var) = TAILQ_LAST(head, headname);				\
+	    (var) != TAILQ_END(head);					\
+	    (var) = TAILQ_PREV(var, headname, field))
+
+/*
+ * Tail queue functions.
+ */
+#define	TAILQ_INIT(head) do {						\
+	(head)->tqh_first = NULL;					\
+	(head)->tqh_last = &(head)->tqh_first;				\
+} while (0)
+
+#define TAILQ_INSERT_HEAD(head, elm, field) do {			\
+	if (((elm)->field.tqe_next = (head)->tqh_first) != NULL)	\
+		(head)->tqh_first->field.tqe_prev =			\
+		    &(elm)->field.tqe_next;				\
+	else								\
+		(head)->tqh_last = &(elm)->field.tqe_next;		\
+	(head)->tqh_first = (elm);					\
+	(elm)->field.tqe_prev = &(head)->tqh_first;			\
+} while (0)
+
+#define TAILQ_INSERT_TAIL(head, elm, field) do {			\
+	(elm)->field.tqe_next = NULL;					\
+	(elm)->field.tqe_prev = (head)->tqh_last;			\
+	*(head)->tqh_last = (elm);					\
+	(head)->tqh_last = &(elm)->field.tqe_next;			\
+} while (0)
+
+#define TAILQ_INSERT_AFTER(head, listelm, elm, field) do {		\
+	if (((elm)->field.tqe_next = (listelm)->field.tqe_next) != NULL)\
+		(elm)->field.tqe_next->field.tqe_prev =			\
+		    &(elm)->field.tqe_next;				\
+	else								\
+		(head)->tqh_last = &(elm)->field.tqe_next;		\
+	(listelm)->field.tqe_next = (elm);				\
+	(elm)->field.tqe_prev = &(listelm)->field.tqe_next;		\
+} while (0)
+
+#define	TAILQ_INSERT_BEFORE(listelm, elm, field) do {			\
+	(elm)->field.tqe_prev = (listelm)->field.tqe_prev;		\
+	(elm)->field.tqe_next = (listelm);				\
+	*(listelm)->field.tqe_prev = (elm);				\
+	(listelm)->field.tqe_prev = &(elm)->field.tqe_next;		\
+} while (0)
+
+#define TAILQ_REMOVE(head, elm, field) do {				\
+	if (((elm)->field.tqe_next) != NULL)				\
+		(elm)->field.tqe_next->field.tqe_prev =			\
+		    (elm)->field.tqe_prev;				\
+	else								\
+		(head)->tqh_last = (elm)->field.tqe_prev;		\
+	*(elm)->field.tqe_prev = (elm)->field.tqe_next;			\
+} while (0)
+
+#define TAILQ_REPLACE(head, elm, elm2, field) do {			\
+	if (((elm2)->field.tqe_next = (elm)->field.tqe_next) != NULL)	\
+		(elm2)->field.tqe_next->field.tqe_prev =		\
+		    &(elm2)->field.tqe_next;				\
+	else								\
+		(head)->tqh_last = &(elm2)->field.tqe_next;		\
+	(elm2)->field.tqe_prev = (elm)->field.tqe_prev;			\
+	*(elm2)->field.tqe_prev = (elm2);				\
+} while (0)
+
+#endif	/* !_SYS_QUEUE_H_ */
diff -ruN linux-2.6.19-vanilla/include/linux/sched.h linux-2.6.19/include/linux/sched.h
--- linux-2.6.19-vanilla/include/linux/sched.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/include/linux/sched.h	2006-12-07 18:27:10.000000000 +0100
@@ -982,6 +982,10 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+#ifdef CONFIG_SYSTRACE
+	void *systrace;
+#endif
+
 /*
  * current io wait handle: wait queue entry to use for io waits
  * If this thread is processing aio, this points at the waitqueue
diff -ruN linux-2.6.19-vanilla/include/linux/systrace.h linux-2.6.19/include/linux/systrace.h
--- linux-2.6.19-vanilla/include/linux/systrace.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19/include/linux/systrace.h	2006-12-07 18:55:36.000000000 +0100
@@ -0,0 +1,216 @@
+/*
+ * systrace.h
+ *
+ * Copyright (c) 2002 Marius Aamodt Eriksen <marius@umich.edu>
+ *
+ * These definitions are muchly replicated from Niels Provos' OpenBSD
+ * implementation.
+ */
+
+#ifndef _INCLUDE_LINUX_SYSTRACE_H
+#define _INCLUDE_LINUX_SYSTRACE_H
+
+/*
+ * XXX this is kind of nasty -- should add manually to everything that
+ * needs it
+ */
+
+#define SYSTR_EMULEN    8       /* sync with sys proc */
+
+#ifdef __KERNEL__
+/* XXX ugly.  argh... linux... */
+typedef u32 register_t;
+#endif /* __KERNEL__ */
+
+struct str_msg_emul {
+        char emul[SYSTR_EMULEN];
+};
+
+#define SYSTR_MAX_POLICIES      64
+#define SYSTR_MAXARGS           64
+
+/* XXX change register_t (args, rval) to something portable. */
+struct str_msg_ask {
+        int code;
+        int argsize;
+        u32 args[SYSTR_MAXARGS];
+        u32 rval[2];
+        int result;
+};
+
+/* Queued on fork or exit of a process */
+
+struct str_msg_child {
+        pid_t new_pid;
+};
+struct str_msg_ugid {
+        uid_t uid;
+        gid_t gid;
+};
+
+struct str_msg_execve {
+	register_t patharg;
+};
+
+#define SYSTR_MSG_ASK     1
+#define SYSTR_MSG_RES     2
+#define SYSTR_MSG_EMUL    3
+#define SYSTR_MSG_CHILD   4
+#define SYSTR_MSG_UGID    5
+#define SYSTR_MSG_EXECVE  6
+
+#define SYSTR_MSG_NOPROCESS(x) \
+        ((x)->msg.msg_type == SYSTR_MSG_CHILD)
+
+#define MAXPATHLEN PATH_MAX
+
+struct str_message {
+	/* XXX - should be u_int16_t */
+	int   msg_seqnr;
+        int   msg_type;
+        pid_t msg_pid;
+        short msg_policy;
+        short reserved;
+        union {
+                struct str_msg_emul    msg_emul;
+                struct str_msg_ask     msg_ask;
+                struct str_msg_child   msg_child;
+                struct str_msg_ugid    msg_ugid;
+                struct str_msg_execve  msg_execve;
+        }     msg_data;
+};
+
+struct systrace_answer {
+	/* XXX - should be u_int16_t */
+	int   stra_seqnr;
+        pid_t stra_pid;
+        int   stra_policy;
+        int   stra_error;
+        int   stra_flags;
+	uid_t stra_seteuid;     /* elevated privileges for system call */
+        gid_t stra_setegid;
+};
+
+#define SYSTR_READ              1
+#define SYSTR_WRITE             2
+
+struct systrace_io {
+        pid_t   strio_pid;
+        int     strio_op;
+        void   *strio_offs;
+        void   *strio_addr;
+        size_t  strio_len;
+};
+
+#define SYSTR_POLICY_NEW        1
+#define SYSTR_POLICY_ASSIGN     2
+#define SYSTR_POLICY_MODIFY     3
+
+struct systrace_policy {
+        int strp_op;
+        int strp_num;
+        union {
+                struct {
+                        short code;
+                        short policy;
+                } assign;
+                pid_t pid;
+                int maxents;
+        } strp_data;
+};
+
+
+struct systrace_replace {
+	pid_t strr_pid;
+	int strr_nrepl;
+	void *strr_base;
+	size_t strr_len;
+	int strr_argind[SYSTR_MAXARGS];
+	size_t strr_off[SYSTR_MAXARGS];
+	size_t strr_offlen[SYSTR_MAXARGS];
+};
+
+#define strp_pid        strp_data.pid
+#define strp_maxents    strp_data.maxents
+#define strp_code       strp_data.assign.code
+#define strp_policy     strp_data.assign.policy
+
+/* ioctl definitions */
+#define STR_MAGIC 's'
+
+#define STRIOCATTACH  _IOW(STR_MAGIC, 101, pid_t)
+#define STRIOCDETACH  _IOW(STR_MAGIC, 102, pid_t)
+#define STRIOCANSWER  _IOW(STR_MAGIC, 103, struct systrace_answer)
+#define STRIOCIO      _IOWR(STR_MAGIC, 104, struct systrace_io)
+#define STRIOCPOLICY  _IOWR(STR_MAGIC, 105, struct systrace_policy)
+#define STRIOCGETCWD  _IOW(STR_MAGIC, 106, pid_t)
+#define STRIOCRESCWD  _IO(STR_MAGIC, 107)
+#define STRIOWAKE     _IO(STR_MAGIC, 108)
+#define STRIOCLONE    _IOW(STR_MAGIC, 109, int *);
+#define STRIOCREPLACE _IOW(STR_MAGIC, 110, struct systrace_replace)
+
+#define SYSTR_POLICY_ASK        0
+#define SYSTR_POLICY_PERMIT     1
+#define SYSTR_POLICY_NEVER      2
+
+#define SYSTR_FLAGS_RESULT      0x001
+#define SYSTR_FLAGS_SETEUID     0x002
+#define SYSTR_FLAGS_SETEGID     0x004
+
+#ifdef __KERNEL__
+
+struct str_process;
+struct fsystrace {
+	struct semaphore                      lock;
+	wait_queue_head_t                     wqh;
+        TAILQ_HEAD(strprocessq, str_process)  processes;
+        TAILQ_HEAD(strpolicyq, str_policy)    policies;
+        int                                   nprocesses;
+        struct strprocessq                    messages;
+        int                                   npolicynr;
+        int                                   npolicies;
+
+        int                                   issuser;
+	uid_t                                 euid;
+	gid_t                                 egid;
+
+	pid_t                                 pid;
+        /* cwd magic */
+        pid_t                                 pwd_pid;
+	struct vfsmount                      *pwd_mnt;
+        struct dentry                        *pwd_dentry;
+        struct vfsmount                      *root_mnt;
+        struct dentry                        *root_dentry;
+};
+
+/* Internal prototypes */
+
+/*
+  int systrace_redirect(int, struct proc *, void *, register_t *);
+  void systrace_exit(struct proc *);
+  void systrace_fork(struct proc *, struct proc *);
+*/
+
+int  init_systrace(void);
+void systrace_fork(struct task_struct *, struct task_struct *);
+void systrace_exit(struct task_struct *);
+
+/* crud needed to make systrace happy */
+struct sysent {             /* system call table */
+	short   sy_narg;    /* number of args */
+	short   sy_argsize; /* total size of arguments */
+};
+
+/* Macros to set/clear/test flags. */
+#define SET(t, f)       ((t) |= (f))
+#define CLR(t, f)       ((t) &= ~(f))
+#define ISSET(t, f)     ((t) & (f))
+
+
+#endif /* __KERNEL__ */
+
+#ifndef __KERNEL__
+//typedef u_int32_t register_t;
+#endif /* !__KERNEL__ */
+
+#endif /* _INCLUDE_LINUX_SYSTRACE_H */
diff -ruN linux-2.6.19-vanilla/kernel/exit.c linux-2.6.19/kernel/exit.c
--- linux-2.6.19-vanilla/kernel/exit.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/kernel/exit.c	2006-12-07 20:37:51.000000000 +0100
@@ -42,6 +42,12 @@
 #include <linux/resource.h>
 #include <linux/blkdev.h>
 
+#ifdef CONFIG_SYSTRACE
+#include <linux/queue.h>
+#include <asm/semaphore.h>
+#include <linux/systrace.h>
+#endif
+
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/pgtable.h>
@@ -914,6 +920,10 @@
 	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
 	taskstats_exit_free(tidstats);
 
+#ifdef CONFIG_SYSTRACE
+	systrace_exit(tsk);
+#endif
+
 	exit_mm(tsk);
 
 	if (group_dead)
diff -ruN linux-2.6.19-vanilla/kernel/fork.c linux-2.6.19/kernel/fork.c
--- linux-2.6.19-vanilla/kernel/fork.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/kernel/fork.c	2006-12-07 18:27:10.000000000 +0100
@@ -39,6 +39,11 @@
 #include <linux/rcupdate.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#ifdef CONFIG_SYSTRACE
+#include <linux/queue.h>
+#include <asm/semaphore.h>
+#include <linux/systrace.h>
+#endif /* CONFIG_SYSTRACE */
 #include <linux/audit.h>
 #include <linux/profile.h>
 #include <linux/rmap.h>
@@ -1385,6 +1390,11 @@
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
+#ifdef CONFIG_SYSTRACE
+		if (current->systrace != NULL)
+			systrace_fork(current, p);
+#endif
+
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_new_task(p, clone_flags);
 		else
Files linux-2.6.19-vanilla/scripts/kconfig/mconf and linux-2.6.19/scripts/kconfig/mconf differ
diff -ruN linux-2.6.19-vanilla/security/Kconfig linux-2.6.19/security/Kconfig
--- linux-2.6.19-vanilla/security/Kconfig	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19/security/Kconfig	2006-12-07 18:27:10.000000000 +0100
@@ -94,6 +94,7 @@
 	  If you are unsure how to answer this question, answer N.
 
 source security/selinux/Kconfig
+source drivers/systrace/Kconfig
 
 endmenu
 

--MP_WKGoaYb4ntjg1HSsIf86.DN--
