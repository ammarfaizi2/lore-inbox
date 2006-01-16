Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWAQUV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWAQUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWAQUVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:21:19 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53454 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964812AbWAQUVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:21:00 -0500
Message-Id: <20060117195015.280749000@klappe.arndb.de>
References: <20060117194942.647145000@klappe.arndb.de>
Date: Tue, 17 Jan 2006 00:00:01 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jordi_caubet@es.ibm.com,
       Mark Nutter <mnutter@us.ibm.com>, Arnd Bergmann <arndb@de.ibm.com>
Subject: [RFC/PATCH 1/3] spufs: allow SPU code to do syscalls
Content-Disposition: inline; filename=spufs-callbacks-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An SPU does not have a way to implement system calls
itself, but it can create intercepts to the kernel.

This patch uses the method defined by the JSRE interface
for C99 host library calls from an SPU to implement
Linux system calls. It uses the reserved SPU stop code
0x2104 for this, using the structure layout and syscall
numbers for ppc64-linux.

I'm still undecided wether it is better to have a list
of allowed syscalls or a list of forbidden syscalls,
since we can't allow an SPU to call all syscalls that
are defined for ppc64-linux.

This patch implements the easier choice of them, with a
blacklist that only prevents an SPU from calling anything
that interacts with its own execution, namely fork, execve,
clone, vfork, exit, spu_run and spu_create.

The current implementation works by including systbl.S
from another file and redefining a few symbols there.
This is anything but nice, and I'm still looking for
better alternatives here.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/Makefile
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/Makefile
@@ -6,5 +6,11 @@ obj-$(CONFIG_SPU_FS)	+= spufs/ spu-base.
 
 spu-base-y		+= spu_base.o spu_priv1.o
 
-builtin-spufs-$(CONFIG_SPU_FS)	+= spu_syscalls.o
-obj-y			+= $(builtin-spufs-m)
+# needed only when building loadable spufs.ko
+spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
+obj-y			+= $(spufs-modular-m)
+
+# always needed in kernel
+spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o
+obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
+
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spufs/run.c
@@ -76,6 +76,90 @@ static inline int spu_reacquire_runnable
 	return 0;
 }
 
+/*
+ * SPU syscall restarting is tricky because we violate the basic
+ * assumption that the signal handler is running on the interrupted
+ * thread. Here instead, the handler runs on PowerPC user space code,
+ * while the syscall was called from the SPU.
+ * This means we can only do a very rough approximation of POSIX
+ * signal semantics.
+ */
+int spu_handle_restartsys(struct spu_context *ctx, long *spu_ret,
+			  unsigned int *npc)
+{
+	int ret;
+
+	switch (*spu_ret) {
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+		/*
+		 * Enter the regular syscall restarting for
+		 * sys_spu_run, then restart the SPU syscall
+		 * callback.
+		 */
+		*npc -= 8;
+		ret = -ERESTARTSYS;
+		break;
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/*
+		 * Restart block is too hard for now, just return -EINTR
+		 * to the SPU.
+		 * ERESTARTNOHAND comes from sys_pause, we also return
+		 * -EINTR from there.
+		 * Assume that we need to be restarted ourselves though.
+		 */
+		*spu_ret = -EINTR;
+		ret = -ERESTARTSYS;
+		break;
+	default:
+		printk(KERN_WARNING "%s: unexpected return code %ld\n",
+			__FUNCTION__, *spu_ret);
+		ret = 0;
+	}
+	return ret;
+}
+
+int spu_process_callback(struct spu_context *ctx)
+{
+	struct spu_syscall_block s;
+	u32 ls_pointer, npc;
+	char *ls;
+	long spu_ret;
+	int ret;
+
+	/* get syscall block from local store */
+	npc = ctx->ops->npc_read(ctx);
+	ls = ctx->ops->get_ls(ctx);
+	ls_pointer = *(u32*)(ls + npc);
+	if (ls_pointer > (LS_SIZE - sizeof(s)))
+		return -EFAULT;
+	memcpy(&s, ls + ls_pointer, sizeof (s));
+
+	/* do actual syscall without pinning the spu */
+	ret = 0;
+	spu_ret = -ENOSYS;
+	npc += 4;
+
+	if (s.nr_ret < __NR_syscalls) {
+		spu_release(ctx);
+		/* do actual system call from here */
+		spu_ret = spu_sys_callback(&s);
+		if (spu_ret <= -ERESTARTSYS) {
+			ret = spu_handle_restartsys(ctx, &spu_ret, &npc);
+		}
+		spu_acquire(ctx);
+		if (ret == -ERESTARTSYS)
+			return ret;
+	}
+
+	/* write result, jump over indirect pointer */
+	memcpy(ls + ls_pointer, &spu_ret, sizeof (spu_ret));
+	ctx->ops->npc_write(ctx, npc);
+	ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
+	return ret;
+}
+
 static inline int spu_process_events(struct spu_context *ctx)
 {
 	struct spu *spu = ctx->spu;
@@ -107,6 +191,13 @@ long spufs_run_spu(struct file *file, st
 		ret = spufs_wait(ctx->stop_wq, spu_stopped(ctx, status));
 		if (unlikely(ret))
 			break;
+		if ((*status & SPU_STATUS_STOPPED_BY_STOP) &&
+		    (*status >> SPU_STOP_STATUS_SHIFT == 0x2104)) {
+			ret = spu_process_callback(ctx);
+			if (ret)
+				break;
+			*status &= ~SPU_STATUS_STOPPED_BY_STOP;
+		}
 		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
 			ret = spu_reacquire_runnable(ctx, npc, status);
 			if (ret)
Index: linux-2.6.16-rc/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.16-rc.orig/include/asm-powerpc/spu.h
+++ linux-2.6.16-rc/include/asm-powerpc/spu.h
@@ -149,6 +149,14 @@ int spu_irq_class_0_bottom(struct spu *s
 int spu_irq_class_1_bottom(struct spu *spu);
 void spu_irq_setaffinity(struct spu *spu, int cpu);
 
+/* system callbacks from the SPU */
+struct spu_syscall_block {
+	u64 nr_ret;
+	u64 parm[6];
+};
+extern long spu_sys_callback(struct spu_syscall_block *s);
+
+/* syscalls implemented in spufs */
 extern struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode);
@@ -399,7 +407,6 @@ struct spu_priv1 {
 #define SPU_GET_REVISION_BITS(vr)	(vr & SPU_REVISION_BITS)
 	u8  pad_0x28_0x100[0x100 - 0x28];			/* 0x28 */
 
-
 	/* Interrupt Area */
 	u64 int_mask_RW[3];					/* 0x100 */
 #define CLASS0_ENABLE_DMA_ALIGNMENT_INTR		0x1L
Index: linux-2.6.16-rc/arch/powerpc/platforms/cell/spu_callbacks.c
===================================================================
--- /dev/null
+++ linux-2.6.16-rc/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -0,0 +1,342 @@
+/*
+ * System call callback functions for SPUs
+ */
+
+#define DEBUG
+
+#include <linux/kallsyms.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+
+#include <asm/spu.h>
+#include <asm/syscalls.h>
+#include <asm/unistd.h>
+
+/*
+ * This table defines the system calls that an SPU can call.
+ * It is currently a subset of the 64 bit powerpc system calls,
+ * with the exact semantics.
+ *
+ * The reasons for disabling some of the system calls are:
+ * 1. They interact with the way SPU syscalls are handled
+ *    and we can't let them execute ever:
+ *	restart_syscall, exit, for, execve, ptrace, ...
+ * 2. They are deprecated and replaced by other means:
+ *	uselib, pciconfig_*, sysfs, ...
+ * 3. They are somewhat interacting with the system in a way
+ *    we don't want an SPU to:
+ *	reboot, init_module, mount, kexec_load
+ * 4. They are optional and we can't rely on them being
+ *    linked into the kernel. Unfortunately, the cond_syscall
+ *    helper does not work here as it does not add the necessary
+ *    opd symbols:
+ *	mbind, mq_open, ipc, ...
+ */
+
+void *spu_syscall_table[] = {
+	[__NR_restart_syscall]		sys_ni_syscall, /* sys_restart_syscall */
+	[__NR_exit]			sys_ni_syscall, /* sys_exit */
+	[__NR_fork]			sys_ni_syscall, /* ppc_fork */
+	[__NR_read]			sys_read,
+	[__NR_write]			sys_write,
+	[__NR_open]			sys_open,
+	[__NR_close]			sys_close,
+	[__NR_waitpid]			sys_waitpid,
+	[__NR_creat]			sys_creat,
+	[__NR_link]			sys_link,
+	[__NR_unlink]			sys_unlink,
+	[__NR_execve]			sys_ni_syscall, /* sys_execve */
+	[__NR_chdir]			sys_chdir,
+	[__NR_time]			sys_time,
+	[__NR_mknod]			sys_mknod,
+	[__NR_chmod]			sys_chmod,
+	[__NR_lchown]			sys_lchown,
+	[__NR_break]			sys_ni_syscall,
+	[__NR_oldstat]			sys_ni_syscall,
+	[__NR_lseek]			sys_lseek,
+	[__NR_getpid]			sys_getpid,
+	[__NR_mount]			sys_ni_syscall, /* sys_mount */
+	[__NR_umount]			sys_ni_syscall,
+	[__NR_setuid]			sys_setuid,
+	[__NR_getuid]			sys_getuid,
+	[__NR_stime]			sys_stime,
+	[__NR_ptrace]			sys_ni_syscall, /* sys_ptrace */
+	[__NR_alarm]			sys_alarm,
+	[__NR_oldfstat]			sys_ni_syscall,
+	[__NR_pause]			sys_ni_syscall, /* sys_pause */
+	[__NR_utime]			sys_ni_syscall, /* sys_utime */
+	[__NR_stty]			sys_ni_syscall,
+	[__NR_gtty]			sys_ni_syscall,
+	[__NR_access]			sys_access,
+	[__NR_nice]			sys_nice,
+	[__NR_ftime]			sys_ni_syscall,
+	[__NR_sync]			sys_sync,
+	[__NR_kill]			sys_kill,
+	[__NR_rename]			sys_rename,
+	[__NR_mkdir]			sys_mkdir,
+	[__NR_rmdir]			sys_rmdir,
+	[__NR_dup]			sys_dup,
+	[__NR_pipe]			sys_pipe,
+	[__NR_times]			sys_times,
+	[__NR_prof]			sys_ni_syscall,
+	[__NR_brk]			sys_brk,
+	[__NR_setgid]			sys_setgid,
+	[__NR_getgid]			sys_getgid,
+	[__NR_signal]			sys_ni_syscall, /* sys_signal */
+	[__NR_geteuid]			sys_geteuid,
+	[__NR_getegid]			sys_getegid,
+	[__NR_acct]			sys_ni_syscall, /* sys_acct */
+	[__NR_umount2]			sys_ni_syscall, /* sys_umount */
+	[__NR_lock]			sys_ni_syscall,
+	[__NR_ioctl]			sys_ioctl,
+	[__NR_fcntl]			sys_fcntl,
+	[__NR_mpx]			sys_ni_syscall,
+	[__NR_setpgid]			sys_setpgid,
+	[__NR_ulimit]			sys_ni_syscall,
+	[__NR_oldolduname]		sys_ni_syscall,
+	[__NR_umask]			sys_umask,
+	[__NR_chroot]			sys_chroot,
+	[__NR_ustat]			sys_ni_syscall, /* sys_ustat */
+	[__NR_dup2]			sys_dup2,
+	[__NR_getppid]			sys_getppid,
+	[__NR_getpgrp]			sys_getpgrp,
+	[__NR_setsid]			sys_setsid,
+	[__NR_sigaction]		sys_ni_syscall,
+	[__NR_sgetmask]			sys_sgetmask,
+	[__NR_ssetmask]			sys_ssetmask,
+	[__NR_setreuid]			sys_setreuid,
+	[__NR_setregid]			sys_setregid,
+	[__NR_sigsuspend]		sys_ni_syscall,
+	[__NR_sigpending]		sys_ni_syscall,
+	[__NR_sethostname]		sys_sethostname,
+	[__NR_setrlimit]		sys_setrlimit,
+	[__NR_getrlimit]		sys_ni_syscall,
+	[__NR_getrusage]		sys_getrusage,
+	[__NR_gettimeofday]		sys_gettimeofday,
+	[__NR_settimeofday]		sys_settimeofday,
+	[__NR_getgroups]		sys_getgroups,
+	[__NR_setgroups]		sys_setgroups,
+	[__NR_select]			sys_ni_syscall,
+	[__NR_symlink]			sys_symlink,
+	[__NR_oldlstat]			sys_ni_syscall,
+	[__NR_readlink]			sys_readlink,
+	[__NR_uselib]			sys_ni_syscall, /* sys_uselib */
+	[__NR_swapon]			sys_ni_syscall, /* sys_swapon */
+	[__NR_reboot]			sys_ni_syscall, /* sys_reboot */
+	[__NR_readdir]			sys_ni_syscall,
+	[__NR_mmap]			sys_mmap,
+	[__NR_munmap]			sys_munmap,
+	[__NR_truncate]			sys_truncate,
+	[__NR_ftruncate]		sys_ftruncate,
+	[__NR_fchmod]			sys_fchmod,
+	[__NR_fchown]			sys_fchown,
+	[__NR_getpriority]		sys_getpriority,
+	[__NR_setpriority]		sys_setpriority,
+	[__NR_profil]			sys_ni_syscall,
+	[__NR_statfs]			sys_ni_syscall, /* sys_statfs */
+	[__NR_fstatfs]			sys_ni_syscall, /* sys_fstatfs */
+	[__NR_ioperm]			sys_ni_syscall,
+	[__NR_socketcall]		sys_socketcall,
+	[__NR_syslog]			sys_syslog,
+	[__NR_setitimer]		sys_setitimer,
+	[__NR_getitimer]		sys_getitimer,
+	[__NR_stat]			sys_newstat,
+	[__NR_lstat]			sys_newlstat,
+	[__NR_fstat]			sys_newfstat,
+	[__NR_olduname]			sys_ni_syscall,
+	[__NR_iopl]			sys_ni_syscall,
+	[__NR_vhangup]			sys_vhangup,
+	[__NR_idle]			sys_ni_syscall,
+	[__NR_vm86]			sys_ni_syscall,
+	[__NR_wait4]			sys_wait4,
+	[__NR_swapoff]			sys_ni_syscall, /* sys_swapoff */
+	[__NR_sysinfo]			sys_sysinfo,
+	[__NR_ipc]			sys_ni_syscall, /* sys_ipc */
+	[__NR_fsync]			sys_fsync,
+	[__NR_sigreturn]		sys_ni_syscall,
+	[__NR_clone]			sys_ni_syscall, /* ppc_clone */
+	[__NR_setdomainname]		sys_setdomainname,
+	[__NR_uname]			ppc_newuname,
+	[__NR_modify_ldt]		sys_ni_syscall,
+	[__NR_adjtimex]			sys_adjtimex,
+	[__NR_mprotect]			sys_mprotect,
+	[__NR_sigprocmask]		sys_ni_syscall,
+	[__NR_create_module]		sys_ni_syscall,
+	[__NR_init_module]		sys_ni_syscall, /* sys_init_module */
+	[__NR_delete_module]		sys_ni_syscall, /* sys_delete_module */
+	[__NR_get_kernel_syms]		sys_ni_syscall,
+	[__NR_quotactl]			sys_ni_syscall, /* sys_quotactl */
+	[__NR_getpgid]			sys_getpgid,
+	[__NR_fchdir]			sys_fchdir,
+	[__NR_bdflush]			sys_bdflush,
+	[__NR_sysfs]			sys_ni_syscall, /* sys_sysfs */
+	[__NR_personality]		ppc64_personality,
+	[__NR_afs_syscall]		sys_ni_syscall,
+	[__NR_setfsuid]			sys_setfsuid,
+	[__NR_setfsgid]			sys_setfsgid,
+	[__NR__llseek]			sys_llseek,
+	[__NR_getdents]			sys_getdents,
+	[__NR__newselect]		sys_select,
+	[__NR_flock]			sys_flock,
+	[__NR_msync]			sys_msync,
+	[__NR_readv]			sys_readv,
+	[__NR_writev]			sys_writev,
+	[__NR_getsid]			sys_getsid,
+	[__NR_fdatasync]		sys_fdatasync,
+	[__NR__sysctl]			sys_ni_syscall, /* sys_sysctl */
+	[__NR_mlock]			sys_mlock,
+	[__NR_munlock]			sys_munlock,
+	[__NR_mlockall]			sys_mlockall,
+	[__NR_munlockall]		sys_munlockall,
+	[__NR_sched_setparam]		sys_sched_setparam,
+	[__NR_sched_getparam]		sys_sched_getparam,
+	[__NR_sched_setscheduler]	sys_sched_setscheduler,
+	[__NR_sched_getscheduler]	sys_sched_getscheduler,
+	[__NR_sched_yield]		sys_sched_yield,
+	[__NR_sched_get_priority_max]	sys_sched_get_priority_max,
+	[__NR_sched_get_priority_min]	sys_sched_get_priority_min,
+	[__NR_sched_rr_get_interval]	sys_sched_rr_get_interval,
+	[__NR_nanosleep]		sys_nanosleep,
+	[__NR_mremap]			sys_mremap,
+	[__NR_setresuid]		sys_setresuid,
+	[__NR_getresuid]		sys_getresuid,
+	[__NR_query_module]		sys_ni_syscall,
+	[__NR_poll]			sys_poll,
+	[__NR_nfsservctl]		sys_ni_syscall, /* sys_nfsservctl */
+	[__NR_setresgid]		sys_setresgid,
+	[__NR_getresgid]		sys_getresgid,
+	[__NR_prctl]			sys_prctl,
+	[__NR_rt_sigreturn]		sys_ni_syscall, /* ppc64_rt_sigreturn */
+	[__NR_rt_sigaction]		sys_ni_syscall, /* sys_rt_sigaction */
+	[__NR_rt_sigprocmask]		sys_ni_syscall, /* sys_rt_sigprocmask */
+	[__NR_rt_sigpending]		sys_ni_syscall, /* sys_rt_sigpending */
+	[__NR_rt_sigtimedwait]		sys_ni_syscall, /* sys_rt_sigtimedwait */
+	[__NR_rt_sigqueueinfo]		sys_ni_syscall, /* sys_rt_sigqueueinfo */
+	[__NR_rt_sigsuspend]		sys_ni_syscall, /* sys_rt_sigsuspend */
+	[__NR_pread64]			sys_pread64,
+	[__NR_pwrite64]			sys_pwrite64,
+	[__NR_chown]			sys_chown,
+	[__NR_getcwd]			sys_getcwd,
+	[__NR_capget]			sys_capget,
+	[__NR_capset]			sys_capset,
+	[__NR_sigaltstack]		sys_ni_syscall, /* sys_sigaltstack */
+	[__NR_sendfile]			sys_sendfile64,
+	[__NR_getpmsg]			sys_ni_syscall,
+	[__NR_putpmsg]			sys_ni_syscall,
+	[__NR_vfork]			sys_ni_syscall, /* ppc_vfork */
+	[__NR_ugetrlimit]		sys_getrlimit,
+	[__NR_readahead]		sys_readahead,
+	[192]				sys_ni_syscall,
+	[193]				sys_ni_syscall,
+	[194]				sys_ni_syscall,
+	[195]				sys_ni_syscall,
+	[196]				sys_ni_syscall,
+	[197]				sys_ni_syscall,
+	[__NR_pciconfig_read]		sys_ni_syscall, /* sys_pciconfig_read */
+	[__NR_pciconfig_write]		sys_ni_syscall, /* sys_pciconfig_write */
+	[__NR_pciconfig_iobase]		sys_ni_syscall, /* sys_pciconfig_iobase */
+	[__NR_multiplexer]		sys_ni_syscall,
+	[__NR_getdents64]		sys_getdents64,
+	[__NR_pivot_root]		sys_pivot_root,
+	[204]				sys_ni_syscall,
+	[__NR_madvise]			sys_madvise,
+	[__NR_mincore]			sys_mincore,
+	[__NR_gettid]			sys_gettid,
+	[__NR_tkill]			sys_tkill,
+	[__NR_setxattr]			sys_setxattr,
+	[__NR_lsetxattr]		sys_lsetxattr,
+	[__NR_fsetxattr]		sys_fsetxattr,
+	[__NR_getxattr]			sys_getxattr,
+	[__NR_lgetxattr]		sys_lgetxattr,
+	[__NR_fgetxattr]		sys_fgetxattr,
+	[__NR_listxattr]		sys_listxattr,
+	[__NR_llistxattr]		sys_llistxattr,
+	[__NR_flistxattr]		sys_flistxattr,
+	[__NR_removexattr]		sys_removexattr,
+	[__NR_lremovexattr]		sys_lremovexattr,
+	[__NR_fremovexattr]		sys_fremovexattr,
+	[__NR_futex]			sys_futex,
+	[__NR_sched_setaffinity]	sys_sched_setaffinity,
+	[__NR_sched_getaffinity]	sys_sched_getaffinity,
+	[__NR_tuxcall]			sys_ni_syscall,
+	[226]				sys_ni_syscall,
+	[__NR_io_setup]			sys_io_setup,
+	[__NR_io_destroy]		sys_io_destroy,
+	[__NR_io_getevents]		sys_io_getevents,
+	[__NR_io_submit]		sys_io_submit,
+	[__NR_io_cancel]		sys_io_cancel,
+	[__NR_set_tid_address]		sys_ni_syscall, /* sys_set_tid_address */
+	[__NR_fadvise64]		sys_fadvise64,
+	[__NR_exit_group]		sys_ni_syscall, /* sys_exit_group */
+	[__NR_lookup_dcookie]		sys_ni_syscall, /* sys_lookup_dcookie */
+	[__NR_epoll_create]		sys_epoll_create,
+	[__NR_epoll_ctl]		sys_epoll_ctl,
+	[__NR_epoll_wait]		sys_epoll_wait,
+	[__NR_remap_file_pages]		sys_remap_file_pages,
+	[__NR_timer_create]		sys_timer_create,
+	[__NR_timer_settime]		sys_timer_settime,
+	[__NR_timer_gettime]		sys_timer_gettime,
+	[__NR_timer_getoverrun]		sys_timer_getoverrun,
+	[__NR_timer_delete]		sys_timer_delete,
+	[__NR_clock_settime]		sys_clock_settime,
+	[__NR_clock_gettime]		sys_clock_gettime,
+	[__NR_clock_getres]		sys_clock_getres,
+	[__NR_clock_nanosleep]		sys_clock_nanosleep,
+	[__NR_swapcontext]		sys_ni_syscall, /* ppc64_swapcontext */
+	[__NR_tgkill]			sys_tgkill,
+	[__NR_utimes]			sys_utimes,
+	[__NR_statfs64]			sys_statfs64,
+	[__NR_fstatfs64]		sys_fstatfs64,
+	[254]				sys_ni_syscall,
+	[__NR_rtas]			ppc_rtas,
+	[256]				sys_ni_syscall,
+	[257]				sys_ni_syscall,
+	[258]				sys_ni_syscall,
+	[__NR_mbind]			sys_ni_syscall, /* sys_mbind */
+	[__NR_get_mempolicy]		sys_ni_syscall, /* sys_get_mempolicy */
+	[__NR_set_mempolicy]		sys_ni_syscall, /* sys_set_mempolicy */
+	[__NR_mq_open]			sys_ni_syscall, /* sys_mq_open */
+	[__NR_mq_unlink]		sys_ni_syscall, /* sys_mq_unlink */
+	[__NR_mq_timedsend]		sys_ni_syscall, /* sys_mq_timedsend */
+	[__NR_mq_timedreceive]		sys_ni_syscall, /* sys_mq_timedreceive */
+	[__NR_mq_notify]		sys_ni_syscall, /* sys_mq_notify */
+	[__NR_mq_getsetattr]		sys_ni_syscall, /* sys_mq_getsetattr */
+	[__NR_kexec_load]		sys_ni_syscall, /* sys_kexec_load */
+	[__NR_add_key]			sys_ni_syscall, /* sys_add_key */
+	[__NR_request_key]		sys_ni_syscall, /* sys_request_key */
+	[__NR_keyctl]			sys_ni_syscall, /* sys_keyctl */
+	[__NR_waitid]			sys_ni_syscall, /* sys_waitid */
+	[__NR_ioprio_set]		sys_ni_syscall, /* sys_ioprio_set */
+	[__NR_ioprio_get]		sys_ni_syscall, /* sys_ioprio_get */
+	[__NR_inotify_init]		sys_ni_syscall, /* sys_inotify_init */
+	[__NR_inotify_add_watch]	sys_ni_syscall, /* sys_inotify_add_watch */
+	[__NR_inotify_rm_watch]		sys_ni_syscall, /* sys_inotify_rm_watch */
+	[__NR_spu_run]			sys_ni_syscall, /* sys_spu_run */
+	[__NR_spu_create]		sys_ni_syscall, /* sys_spu_create */
+};
+
+long spu_sys_callback(struct spu_syscall_block *s)
+{
+	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
+
+	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);
+
+	syscall = spu_syscall_table[s->nr_ret];
+
+	if (s->nr_ret >= __NR_syscalls) {
+		pr_debug("%s: invalid syscall #%ld", __FUNCTION__, s->nr_ret);
+		return -ENOSYS;
+	}
+
+#ifdef DEBUG
+	print_symbol(KERN_DEBUG "SPU-syscall %s:", (unsigned long)syscall);
+	printk("syscall%ld(%lx, %lx, %lx, %lx, %lx, %lx)\n",
+			s->nr_ret,
+			s->parm[0], s->parm[1], s->parm[2],
+			s->parm[3], s->parm[4], s->parm[5]);
+#endif
+
+	return syscall(s->parm[0], s->parm[1], s->parm[2],
+		       s->parm[3], s->parm[4], s->parm[5]);
+}
+EXPORT_SYMBOL_GPL(spu_sys_callback);

--

