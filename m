Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTDNSFc (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTDNSFc (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:05:32 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:27884 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S263609AbTDNRph (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:37 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (14/16): s390/s390x unification - part 5.
Date: Mon, 14 Apr 2003 19:53:52 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141953.52116.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge s390x and s390 to one architecture.

diffstat:
 kernel/syscalls.S |  273 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/time.c     |   27 +++--
 kernel/traps.c    |  115 ++++++++++++----------
 lib/Makefile      |    4 
 lib/memset64.S    |   30 +++++
 lib/strcmp64.S    |   27 +++++
 lib/strncpy64.S   |   30 +++++
 lib/uaccess64.S   |  107 +++++++++++++++++++++
 mm/fault.c        |   49 ++++++++-
 mm/init.c         |   92 ++++++++++++++++--
 vmlinux.lds.S     |    9 +
 11 files changed, 690 insertions(+), 73 deletions(-)

diff -urN linux-2.5.67/arch/s390/kernel/syscalls.S linux-2.5.67-s390/arch/s390/kernel/syscalls.S
--- linux-2.5.67/arch/s390/kernel/syscalls.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/kernel/syscalls.S	Mon Apr 14 19:11:57 2003
@@ -0,0 +1,273 @@
+/*
+ * definitions for sys_call_table, each line represents an
+ * entry in the table in the form 
+ * SYSCALL(31 bit syscall, 64 bit syscall, 31 bit emulated syscall)
+ *
+ * this file is meant to be included from entry.S and entry64.S
+ */
+
+#define NI_SYSCALL SYSCALL(sys_ni_syscall,sys_ni_syscall,sys_ni_syscall)
+
+NI_SYSCALL							/* 0 */
+SYSCALL(sys_exit,sys_exit,sys32_exit_wrapper)
+SYSCALL(sys_fork_glue,sys_fork_glue,sys_fork_glue)
+SYSCALL(sys_read,sys_read,sys32_read_wrapper)
+SYSCALL(sys_write,sys_write,sys32_write_wrapper)
+SYSCALL(sys_open,sys_open,sys32_open_wrapper)			/* 5 */
+SYSCALL(sys_close,sys_close,sys32_close_wrapper)
+SYSCALL(sys_restart_syscall,sys_restart_syscall,sys_ni_syscall)
+SYSCALL(sys_creat,sys_creat,sys32_creat_wrapper)
+SYSCALL(sys_link,sys_link,sys32_link_wrapper)
+SYSCALL(sys_unlink,sys_unlink,sys32_unlink_wrapper)		/* 10 */
+SYSCALL(sys_execve_glue,sys_execve_glue,sys32_execve_glue)
+SYSCALL(sys_chdir,sys_chdir,sys32_chdir_wrapper)
+SYSCALL(sys_time,sys_ni_syscall,sys32_time_wrapper)		/* old time syscall */
+SYSCALL(sys_mknod,sys_mknod,sys32_mknod_wrapper)
+SYSCALL(sys_chmod,sys_chmod,sys32_chmod_wrapper)		/* 15 */
+SYSCALL(sys_lchown16,sys_ni_syscall,sys32_lchown16_wrapper)	/* old lchown16 syscall*/
+NI_SYSCALL							/* old break syscall holder */
+NI_SYSCALL							/* old stat syscall holder */
+SYSCALL(sys_lseek,sys_lseek,sys32_lseek_wrapper)
+SYSCALL(sys_getpid,sys_getpid,sys_getpid)			/* 20 */
+SYSCALL(sys_mount,sys_mount,sys32_mount_wrapper)
+SYSCALL(sys_oldumount,sys_oldumount,sys32_oldumount_wrapper)
+SYSCALL(sys_setuid16,sys_ni_syscall,sys32_setuid16_wrapper)	/* old setuid16 syscall*/
+SYSCALL(sys_getuid16,sys_ni_syscall,sys32_getuid16)		/* old getuid16 syscall*/
+SYSCALL(sys_stime,sys_ni_syscall,sys32_stime_wrapper)		/* 25 old stime syscall */
+SYSCALL(sys_ptrace,sys_ptrace,sys32_ptrace_wrapper)
+SYSCALL(sys_alarm,sys_alarm,sys32_alarm_wrapper)
+NI_SYSCALL							/* old fstat syscall */
+SYSCALL(sys_pause,sys_pause,sys32_pause)
+SYSCALL(sys_utime,sys_utime,compat_sys_utime_wrapper)		/* 30 */
+NI_SYSCALL							/* old stty syscall */
+NI_SYSCALL							/* old gtty syscall */
+SYSCALL(sys_access,sys_access,sys32_access_wrapper)
+SYSCALL(sys_nice,sys_nice,sys32_nice_wrapper)
+NI_SYSCALL							/* 35 old ftime syscall */
+SYSCALL(sys_sync,sys_sync,sys_sync)
+SYSCALL(sys_kill,sys_kill,sys32_kill_wrapper)
+SYSCALL(sys_rename,sys_rename,sys32_rename_wrapper)
+SYSCALL(sys_mkdir,sys_mkdir,sys32_mkdir_wrapper)
+SYSCALL(sys_rmdir,sys_rmdir,sys32_rmdir_wrapper)		/* 40 */
+SYSCALL(sys_dup,sys_dup,sys32_dup_wrapper)
+SYSCALL(sys_pipe,sys_pipe,sys32_pipe_wrapper)
+SYSCALL(sys_times,sys_times,compat_sys_times_wrapper)
+NI_SYSCALL							/* old prof syscall */
+SYSCALL(sys_brk,sys_brk,sys32_brk_wrapper)			/* 45 */
+SYSCALL(sys_setgid16,sys_ni_syscall,sys32_setgid16)		/* old setgid16 syscall*/
+SYSCALL(sys_getgid16,sys_ni_syscall,sys32_getgid16)		/* old getgid16 syscall*/
+SYSCALL(sys_signal,sys_signal,sys32_signal_wrapper)
+SYSCALL(sys_geteuid16,sys_ni_syscall,sys32_geteuid16)		/* old geteuid16 syscall */
+SYSCALL(sys_getegid16,sys_ni_syscall,sys32_getegid16)		/* 50 old getegid16 syscall */
+SYSCALL(sys_acct,sys_acct,sys32_acct_wrapper)
+SYSCALL(sys_umount,sys_umount,sys32_umount_wrapper)
+NI_SYSCALL							/* old lock syscall */
+SYSCALL(sys_ioctl,sys_ioctl,sys32_ioctl_wrapper)
+SYSCALL(sys_fcntl,sys_fcntl,compat_sys_fcntl_wrapper)		/* 55 */
+NI_SYSCALL							/* intel mpx syscall */
+SYSCALL(sys_setpgid,sys_setpgid,sys32_setpgid_wrapper)
+NI_SYSCALL							/* old ulimit syscall */
+NI_SYSCALL							/* old uname syscall */
+SYSCALL(sys_umask,sys_umask,sys32_umask_wrapper)		/* 60 */
+SYSCALL(sys_chroot,sys_chroot,sys32_chroot_wrapper)
+SYSCALL(sys_ustat,sys_ustat,sys32_ustat_wrapper)
+SYSCALL(sys_dup2,sys_dup2,sys32_dup2_wrapper)
+SYSCALL(sys_getppid,sys_getppid,sys_getppid)
+SYSCALL(sys_getpgrp,sys_getpgrp,sys_getpgrp)			/* 65 */
+SYSCALL(sys_setsid,sys_setsid,sys_setsid)
+SYSCALL(sys_sigaction,sys_sigaction,sys32_sigaction_wrapper)
+NI_SYSCALL							/* old sgetmask syscall*/
+NI_SYSCALL							/* old ssetmask syscall*/
+SYSCALL(sys_setreuid16,sys_ni_syscall,sys32_setreuid16_wrapper)	/* old setreuid16 syscall */
+SYSCALL(sys_setregid16,sys_ni_syscall,sys32_setregid16_wrapper)	/* old setregid16 syscall */
+SYSCALL(sys_sigsuspend_glue,sys_sigsuspend_glue,sys32_sigsuspend_glue)
+SYSCALL(sys_sigpending,sys_sigpending,compat_sys_sigpending_wrapper)
+SYSCALL(sys_sethostname,sys_sethostname,sys32_sethostname_wrapper)
+SYSCALL(sys_setrlimit,sys_setrlimit,sys32_setrlimit_wrapper)	/* 75 */
+SYSCALL(sys_old_getrlimit,sys_getrlimit,sys32_old_getrlimit_wrapper)
+SYSCALL(sys_getrusage,sys_getrusage,sys32_getrusage_wrapper)
+SYSCALL(sys_gettimeofday,sys_gettimeofday,sys32_gettimeofday_wrapper)
+SYSCALL(sys_settimeofday,sys_settimeofday,sys32_settimeofday_wrapper)
+SYSCALL(sys_getgroups16,sys_ni_syscall,sys32_getgroups16_wrapper)	/* 80 old getgroups16 syscall */
+SYSCALL(sys_setgroups16,sys_ni_syscall,sys32_setgroups16_wrapper)	/* old setgroups16 syscall */
+NI_SYSCALL							/* old select syscall */
+SYSCALL(sys_symlink,sys_symlink,sys32_symlink_wrapper)
+NI_SYSCALL							/* old lstat syscall */
+SYSCALL(sys_readlink,sys_readlink,sys32_readlink_wrapper)	/* 85 */
+SYSCALL(sys_uselib,sys_uselib,sys32_uselib_wrapper)
+SYSCALL(sys_swapon,sys_swapon,sys32_swapon_wrapper)
+SYSCALL(sys_reboot,sys_reboot,sys32_reboot_wrapper)
+SYSCALL(sys_ni_syscall,sys_ni_syscall,old32_readdir_wrapper)	/* old readdir syscall */
+SYSCALL(old_mmap,old_mmap,old32_mmap_wrapper)			/* 90 */
+SYSCALL(sys_munmap,sys_munmap,sys32_munmap_wrapper)
+SYSCALL(sys_truncate,sys_truncate,sys32_truncate_wrapper)
+SYSCALL(sys_ftruncate,sys_ftruncate,sys32_ftruncate_wrapper)
+SYSCALL(sys_fchmod,sys_fchmod,sys32_fchmod_wrapper)
+SYSCALL(sys_fchown16,sys_ni_syscall,sys32_fchown16_wrapper)	/* 95 old fchown16 syscall*/
+SYSCALL(sys_getpriority,sys_getpriority,sys32_getpriority_wrapper)
+SYSCALL(sys_setpriority,sys_setpriority,sys32_setpriority_wrapper)
+NI_SYSCALL							/* old profil syscall */
+SYSCALL(sys_statfs,sys_statfs,compat_sys_statfs_wrapper)
+SYSCALL(sys_fstatfs,sys_fstatfs,compat_sys_fstatfs_wrapper)	/* 100 */
+SYSCALL(sys_ioperm,sys_ni_syscall,sys_ni_syscall)
+SYSCALL(sys_socketcall,sys_socketcall,compat_sys_socketcall_wrapper)
+SYSCALL(sys_syslog,sys_syslog,sys32_syslog_wrapper)
+SYSCALL(sys_setitimer,sys_setitimer,compat_sys_setitimer_wrapper)
+SYSCALL(sys_getitimer,sys_getitimer,compat_sys_getitimer_wrapper)	/* 105 */
+SYSCALL(sys_newstat,sys_newstat,compat_sys_newstat_wrapper)
+SYSCALL(sys_newlstat,sys_newlstat,compat_sys_newlstat_wrapper)
+SYSCALL(sys_newfstat,sys_newfstat,compat_sys_newfstat_wrapper)
+NI_SYSCALL							/* old uname syscall */
+NI_SYSCALL							/* 110 iopl for i386 */
+SYSCALL(sys_vhangup,sys_vhangup,sys_vhangup)
+NI_SYSCALL							/* old "idle" system call */
+NI_SYSCALL							/* vm86old for i386 */
+SYSCALL(sys_wait4,sys_wait4,sys32_wait4_wrapper)
+SYSCALL(sys_swapoff,sys_swapoff,sys32_swapoff_wrapper)		/* 115 */
+SYSCALL(sys_sysinfo,sys_sysinfo,sys32_sysinfo_wrapper)
+SYSCALL(sys_ipc,sys_ipc,sys32_ipc_wrapper)
+SYSCALL(sys_fsync,sys_fsync,sys32_fsync_wrapper)
+SYSCALL(sys_sigreturn_glue,sys_sigreturn_glue,sys32_sigreturn_glue)
+SYSCALL(sys_clone_glue,sys_clone_glue,sys32_clone_glue)		/* 120 */
+SYSCALL(sys_setdomainname,sys_setdomainname,sys32_setdomainname_wrapper)
+SYSCALL(sys_newuname,s390x_newuname,sys32_newuname_wrapper)
+NI_SYSCALL							/* modify_ldt for i386 */
+SYSCALL(sys_adjtimex,sys_adjtimex,sys32_adjtimex_wrapper)
+SYSCALL(sys_mprotect,sys_mprotect,sys32_mprotect_wrapper)	/* 125 */
+SYSCALL(sys_sigprocmask,sys_sigprocmask,compat_sys_sigprocmask_wrapper)
+NI_SYSCALL							/* old "create module" */
+SYSCALL(sys_init_module,sys_init_module,sys32_init_module_wrapper)
+SYSCALL(sys_delete_module,sys_delete_module,sys32_delete_module_wrapper)
+NI_SYSCALL							/* 130: old get_kernel_syms */
+SYSCALL(sys_quotactl,sys_quotactl,sys32_quotactl_wrapper)
+SYSCALL(sys_getpgid,sys_getpgid,sys32_getpgid_wrapper)
+SYSCALL(sys_fchdir,sys_fchdir,sys32_fchdir_wrapper)
+SYSCALL(sys_bdflush,sys_bdflush,sys32_bdflush_wrapper)
+SYSCALL(sys_sysfs,sys_sysfs,sys32_sysfs_wrapper)		/* 135 */
+SYSCALL(sys_personality,s390x_personality,sys32_personality_wrapper)
+NI_SYSCALL							/* for afs_syscall */
+SYSCALL(sys_setfsuid16,sys_ni_syscall,sys32_setfsuid16_wrapper)	/* old setfsuid16 syscall */
+SYSCALL(sys_setfsgid16,sys_ni_syscall,sys32_setfsgid16_wrapper)	/* old setfsgid16 syscall */
+SYSCALL(sys_llseek,sys_llseek,sys32_llseek_wrapper)		/* 140 */
+SYSCALL(sys_getdents,sys_getdents,sys32_getdents_wrapper)
+SYSCALL(sys_select,sys_select,sys32_select_wrapper)
+SYSCALL(sys_flock,sys_flock,sys32_flock_wrapper)
+SYSCALL(sys_msync,sys_msync,sys32_msync_wrapper)
+SYSCALL(sys_readv,sys_readv,sys32_readv_wrapper)		/* 145 */
+SYSCALL(sys_writev,sys_writev,sys32_writev_wrapper)
+SYSCALL(sys_getsid,sys_getsid,sys32_getsid_wrapper)
+SYSCALL(sys_fdatasync,sys_fdatasync,sys32_fdatasync_wrapper)
+SYSCALL(sys_sysctl,sys_sysctl,sys32_sysctl_wrapper)
+SYSCALL(sys_mlock,sys_mlock,sys32_mlock_wrapper)		/* 150 */
+SYSCALL(sys_munlock,sys_munlock,sys32_munlock_wrapper)
+SYSCALL(sys_mlockall,sys_mlockall,sys32_mlockall_wrapper)
+SYSCALL(sys_munlockall,sys_munlockall,sys_munlockall)
+SYSCALL(sys_sched_setparam,sys_sched_setparam,sys32_sched_setparam_wrapper)
+SYSCALL(sys_sched_getparam,sys_sched_getparam,sys32_sched_getparam_wrapper)	/* 155 */
+SYSCALL(sys_sched_setscheduler,sys_sched_setscheduler,sys32_sched_setscheduler_wrapper)
+SYSCALL(sys_sched_getscheduler,sys_sched_getscheduler,sys32_sched_getscheduler_wrapper)
+SYSCALL(sys_sched_yield,sys_sched_yield,sys_sched_yield)
+SYSCALL(sys_sched_get_priority_max,sys_sched_get_priority_max,sys32_sched_get_priority_max_wrapper)
+SYSCALL(sys_sched_get_priority_min,sys_sched_get_priority_min,sys32_sched_get_priority_min_wrapper)	/* 160 */
+SYSCALL(sys_sched_rr_get_interval,sys_sched_rr_get_interval,sys32_sched_rr_get_interval_wrapper)
+SYSCALL(sys_nanosleep,sys_nanosleep,compat_sys_nanosleep_wrapper)
+SYSCALL(sys_mremap,sys_mremap,sys32_mremap_wrapper)
+SYSCALL(sys_setresuid16,sys_ni_syscall,sys32_setresuid16_wrapper)	/* old setresuid16 syscall */
+SYSCALL(sys_getresuid16,sys_ni_syscall,sys32_getresuid16_wrapper)	/* 165 old getresuid16 syscall */
+NI_SYSCALL							/* for vm86 */
+NI_SYSCALL							/* old sys_query_module */
+SYSCALL(sys_poll,sys_poll,sys32_poll_wrapper)
+SYSCALL(sys_nfsservctl,sys_nfsservctl,sys32_nfsservctl_wrapper)
+SYSCALL(sys_setresgid16,sys_ni_syscall,sys32_setresgid16_wrapper)	/* 170 old setresgid16 syscall */
+SYSCALL(sys_getresgid16,sys_ni_syscall,sys32_getresgid16_wrapper)	/* old getresgid16 syscall */
+SYSCALL(sys_prctl,sys_prctl,sys32_prctl_wrapper)
+SYSCALL(sys_rt_sigreturn_glue,sys_rt_sigreturn_glue,sys32_rt_sigreturn_glue)
+SYSCALL(sys_rt_sigaction,sys_rt_sigaction,sys32_rt_sigaction_wrapper)
+SYSCALL(sys_rt_sigprocmask,sys_rt_sigprocmask,sys32_rt_sigprocmask_wrapper)	/* 175 */
+SYSCALL(sys_rt_sigpending,sys_rt_sigpending,sys32_rt_sigpending_wrapper)
+SYSCALL(sys_rt_sigtimedwait,sys_rt_sigtimedwait,sys32_rt_sigtimedwait_wrapper)
+SYSCALL(sys_rt_sigqueueinfo,sys_rt_sigqueueinfo,sys32_rt_sigqueueinfo_wrapper)
+SYSCALL(sys_rt_sigsuspend_glue,sys_rt_sigsuspend_glue,sys32_rt_sigsuspend_glue)
+SYSCALL(sys_pread64,sys_pread64,sys32_pread64_wrapper)		/* 180 */
+SYSCALL(sys_pwrite64,sys_pwrite64,sys32_pwrite64_wrapper)
+SYSCALL(sys_chown16,sys_ni_syscall,sys32_chown16_wrapper)	/* old chown16 syscall */
+SYSCALL(sys_getcwd,sys_getcwd,sys32_getcwd_wrapper)
+SYSCALL(sys_capget,sys_capget,sys32_capget_wrapper)
+SYSCALL(sys_capset,sys_capset,sys32_capset_wrapper)		/* 185 */
+SYSCALL(sys_sigaltstack_glue,sys_sigaltstack_glue,sys32_sigaltstack_glue)
+SYSCALL(sys_sendfile,sys_sendfile,sys32_sendfile_wrapper)
+NI_SYSCALL							/* streams1 */
+NI_SYSCALL							/* streams2 */
+SYSCALL(sys_vfork_glue,sys_vfork_glue,sys_vfork_glue)		/* 190 */
+SYSCALL(sys_getrlimit,sys_getrlimit,sys32_getrlimit_wrapper)
+SYSCALL(sys_mmap2,sys_mmap2,sys32_mmap2_wrapper)
+SYSCALL(sys_truncate64,sys_ni_syscall,sys32_truncate64_wrapper)
+SYSCALL(sys_ftruncate64,sys_ni_syscall,sys32_ftruncate64_wrapper)
+SYSCALL(sys_stat64,sys_ni_syscall,sys32_stat64_wrapper)		/* 195 */
+SYSCALL(sys_lstat64,sys_ni_syscall,sys32_lstat64_wrapper)
+SYSCALL(sys_fstat64,sys_ni_syscall,sys32_fstat64_wrapper)
+SYSCALL(sys_lchown,sys_lchown,sys32_lchown_wrapper)
+SYSCALL(sys_getuid,sys_getuid,sys_getuid)
+SYSCALL(sys_getgid,sys_getgid,sys_getgid)			/* 200 */
+SYSCALL(sys_geteuid,sys_geteuid,sys_geteuid)
+SYSCALL(sys_getegid,sys_getegid,sys_getegid)
+SYSCALL(sys_setreuid,sys_setreuid,sys32_setreuid_wrapper)
+SYSCALL(sys_setregid,sys_setregid,sys32_setregid_wrapper)
+SYSCALL(sys_getgroups,sys_getgroups,sys32_getgroups_wrapper)	/* 205 */
+SYSCALL(sys_setgroups,sys_setgroups,sys32_setgroups_wrapper)
+SYSCALL(sys_fchown,sys_fchown,sys32_fchown_wrapper)
+SYSCALL(sys_setresuid,sys_setresuid,sys32_setresuid_wrapper)
+SYSCALL(sys_getresuid,sys_getresuid,sys32_getresuid_wrapper)
+SYSCALL(sys_setresgid,sys_setresgid,sys32_setresgid_wrapper)	/* 210 */
+SYSCALL(sys_getresgid,sys_getresgid,sys32_getresgid_wrapper)
+SYSCALL(sys_chown,sys_chown,sys32_chown_wrapper)
+SYSCALL(sys_setuid,sys_setuid,sys32_setuid_wrapper)
+SYSCALL(sys_setgid,sys_setgid,sys32_setgid_wrapper)
+SYSCALL(sys_setfsuid,sys_setfsuid,sys32_setfsuid_wrapper)	/* 215 */
+SYSCALL(sys_setfsgid,sys_setfsgid,sys32_setfsgid_wrapper)
+SYSCALL(sys_pivot_root,sys_pivot_root,sys32_pivot_root_wrapper)
+SYSCALL(sys_mincore,sys_mincore,sys32_mincore_wrapper)
+SYSCALL(sys_madvise,sys_madvise,sys32_madvise_wrapper)
+SYSCALL(sys_getdents64,sys_getdents64,sys32_getdents64_wrapper)	/* 220 */
+SYSCALL(sys_fcntl64,sys_ni_syscall,compat_sys_fcntl64_wrapper)
+SYSCALL(sys_readahead,sys_readahead,sys32_readahead)
+SYSCALL(sys_sendfile64,sys_ni_syscall,sys32_sendfile64)
+SYSCALL(sys_setxattr,sys_setxattr,sys32_setxattr_wrapper)
+SYSCALL(sys_lsetxattr,sys_lsetxattr,sys32_lsetxattr_wrapper)	/* 225 */
+SYSCALL(sys_fsetxattr,sys_fsetxattr,sys32_fsetxattr_wrapper)
+SYSCALL(sys_getxattr,sys_getxattr,sys32_getxattr_wrapper)
+SYSCALL(sys_lgetxattr,sys_lgetxattr,sys32_lgetxattr_wrapper)
+SYSCALL(sys_fgetxattr,sys_fgetxattr,sys32_fgetxattr_wrapper)
+SYSCALL(sys_listxattr,sys_listxattr,sys32_listxattr_wrapper)	/* 230 */
+SYSCALL(sys_llistxattr,sys_llistxattr,sys32_llistxattr_wrapper)
+SYSCALL(sys_flistxattr,sys_flistxattr,sys32_flistxattr_wrapper)
+SYSCALL(sys_removexattr,sys_removexattr,sys32_removexattr_wrapper)
+SYSCALL(sys_lremovexattr,sys_lremovexattr,sys32_lremovexattr_wrapper)
+SYSCALL(sys_fremovexattr,sys_fremovexattr,sys32_fremovexattr_wrapper)	/* 235 */
+SYSCALL(sys_gettid,sys_gettid,sys_gettid)
+SYSCALL(sys_tkill,sys_tkill,sys_tkill)
+SYSCALL(sys_futex,sys_futex,compat_sys_futex_wrapper)
+SYSCALL(sys_sched_setaffinity,sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
+SYSCALL(sys_sched_getaffinity,sys_sched_getaffinity,sys32_sched_getaffinity_wrapper)	/* 240 */
+NI_SYSCALL					
+NI_SYSCALL							/* reserved for TUX */
+SYSCALL(sys_io_setup,sys_io_setup,sys_ni_syscall)
+SYSCALL(sys_io_destroy,sys_io_destroy,sys_ni_syscall)
+SYSCALL(sys_io_getevents,sys_io_getevents,sys_ni_syscall)	/* 245 */
+SYSCALL(sys_io_submit,sys_io_submit,sys_ni_syscall)
+SYSCALL(sys_io_cancel,sys_io_cancel,sys_ni_syscall)
+SYSCALL(sys_exit_group,sys_exit_group,sys32_exit_group_wrapper)
+SYSCALL(sys_epoll_create,sys_epoll_create,sys_ni_syscall)
+SYSCALL(sys_epoll_ctl,sys_epoll_ctl,sys_ni_syscall)		/* 250 */
+SYSCALL(sys_epoll_wait,sys_epoll_wait,sys_ni_syscall)
+SYSCALL(sys_set_tid_address,sys_set_tid_address,sys32_set_tid_address_wrapper)
+SYSCALL(sys_fadvise64,sys_fadvise64,sys_ni_syscall)
+SYSCALL(sys_timer_create,sys_timer_create,sys_ni_syscall)
+SYSCALL(sys_timer_settime,sys_timer_settime,sys_ni_syscall)	/* 255 */
+SYSCALL(sys_timer_gettime,sys_timer_gettime,sys_ni_syscall)
+SYSCALL(sys_timer_getoverrun,sys_timer_getoverrun,sys_ni_syscall)
+SYSCALL(sys_timer_delete,sys_timer_delete,sys_ni_syscall)
+SYSCALL(sys_clock_settime,sys_clock_settime,sys_ni_syscall)
+SYSCALL(sys_clock_gettime,sys_clock_gettime,sys_ni_syscall)
+SYSCALL(sys_clock_getres,sys_clock_getres,sys_ni_syscall)
+SYSCALL(sys_clock_nanosleep,sys_clock_nanosleep,sys_ni_syscall)
diff -urN linux-2.5.67/arch/s390/kernel/time.c linux-2.5.67-s390/arch/s390/kernel/time.c
--- linux-2.5.67/arch/s390/kernel/time.c	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/arch/s390/kernel/time.c	Mon Apr 14 19:11:57 2003
@@ -128,15 +128,28 @@
 	write_sequnlock_irq(&xtime_lock);
 }
 
-static inline __u32 div64_32(__u64 dividend, __u32 divisor)
+#ifndef CONFIG_ARCH_S390X
+
+static inline __u32
+__calculate_ticks(__u64 elapsed)
 {
 	register_pair rp;
 
-	rp.pair = dividend;
-	asm ("dr %0,%1" : "+d" (rp) : "d" (divisor));
+	rp.pair = elapsed >> 1;
+	asm ("dr %0,%1" : "+d" (rp) : "d" (CLK_TICKS_PER_JIFFY >> 1));
 	return rp.subreg.odd;
 }
 
+#else /* CONFIG_ARCH_S390X */
+
+static inline __u32
+__calculate_ticks(__u64 elapsed)
+{
+	return elapsed / CLK_TICKS_PER_JIFFY;
+}
+
+#endif /* CONFIG_ARCH_S390X */
+
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
@@ -150,7 +163,7 @@
 	asm volatile ("STCK 0(%0)" : : "a" (&tmp) : "memory", "cc");
 	tmp = tmp - S390_lowcore.jiffy_timer;
 	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than one tick ? */
-		ticks = div64_32(tmp >> 1, CLK_TICKS_PER_JIFFY >> 1);
+		ticks = __calculate_ticks(tmp);
 		S390_lowcore.jiffy_timer +=
 			CLK_TICKS_PER_JIFFY * (__u64) ticks;
 	} else {
@@ -175,7 +188,7 @@
 
 		tmp = S390_lowcore.jiffy_timer - xtime_cc;
 		if (tmp >= 2*CLK_TICKS_PER_JIFFY) {
-			xticks = div64_32(tmp >> 1, CLK_TICKS_PER_JIFFY >> 1);
+			xticks = __calculate_ticks(tmp);
 			xtime_cc += (__u64) xticks * CLK_TICKS_PER_JIFFY;
 		} else {
 			xticks = 1;
@@ -208,9 +221,9 @@
 	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
 	asm volatile ("SCKC %0" : : "m" (timer));
         /* allow clock comparator timer interrupt */
-        asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
+	__ctl_store(cr0, 0, 0);
         cr0 |= 0x800;
-        asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
+	__ctl_load(cr0, 0, 0);
 }
 
 /*
diff -urN linux-2.5.67/arch/s390/kernel/traps.c linux-2.5.67-s390/arch/s390/kernel/traps.c
--- linux-2.5.67/arch/s390/kernel/traps.c	Mon Apr 14 19:11:52 2003
+++ linux-2.5.67-s390/arch/s390/kernel/traps.c	Mon Apr 14 19:11:57 2003
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -53,6 +54,7 @@
 
 extern pgm_check_handler_t do_protection_exception;
 extern pgm_check_handler_t do_segment_exception;
+extern pgm_check_handler_t do_region_exception;
 extern pgm_check_handler_t do_page_exception;
 extern pgm_check_handler_t do_pseudo_page_fault;
 #ifdef CONFIG_PFAULT
@@ -62,31 +64,37 @@
 static ext_int_info_t ext_int_pfault;
 #endif
 
+#define stack_pointer ({ void **sp; asm("la %0,0(15)" : "=&d" (sp)); sp; })
+
+#ifndef CONFIG_ARCH_S390X
+#define RET_ADDR 56
+#define FOURLONG "%08lx %08lx %08lx %08lx\n"
 static int kstack_depth_to_print = 12;
 
+#else /* CONFIG_ARCH_S390X */
+#define RET_ADDR 112
+#define FOURLONG "%016lx %016lx %016lx %016lx\n"
+static int kstack_depth_to_print = 20;
+
+#endif /* CONFIG_ARCH_S390X */
+
 void show_trace(unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
-	int i;
 
 	if (!stack)
-		stack = (unsigned long*)&stack;
+		stack = *stack_pointer;
 
-	printk("Call Trace: ");
+	printk("Call Trace:\n");
 	low_addr = ((unsigned long) stack) & PSW_ADDR_INSN;
 	high_addr = (low_addr & (-THREAD_SIZE)) + THREAD_SIZE;
 	/* Skip the first frame (biased stack) */
 	backchain = *((unsigned long *) low_addr) & PSW_ADDR_INSN;
 	/* Print up to 8 lines */
-	for (i = 0; i < 8; i++) {
-		if (backchain < low_addr || backchain >= high_addr)
-			break;
-		ret_addr = *((unsigned long *) (backchain+56)) & PSW_ADDR_INSN;
-		if (!kernel_text_address(ret_addr))
-			break;
-		if (i && ((i % 6) == 0))
-			printk("\n   ");
-		printk("[<%08lx>] ", ret_addr);
+	while  (backchain > low_addr && backchain <= high_addr) {
+		ret_addr = *((unsigned long *) (backchain+RET_ADDR)) & PSW_ADDR_INSN;
+		printk(" [<%016lx>] ", ret_addr);
+		print_symbol("%s\n", ret_addr);
 		low_addr = backchain;
 		backchain = *((unsigned long *) backchain) & PSW_ADDR_INSN;
 	}
@@ -113,15 +121,15 @@
 	// back trace for this cpu.
 
 	if(sp == NULL)
-		sp = (unsigned long*) &sp;
+		sp = *stack_pointer;
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (((addr_t) stack & (THREAD_SIZE-1)) == 0)
 			break;
-		if (i && ((i % 8) == 0))
+		if (i && ((i * sizeof (long) % 32) == 0))
 			printk("\n       ");
-		printk("%08lx ", *stack++);
+		printk("%p ", (void *)*stack++);
 	}
 	printk("\n");
 	show_trace(sp);
@@ -142,17 +150,18 @@
 	int i;
 
 	mode = (regs->psw.mask & PSW_MASK_PSTATE) ? "User" : "Krnl";
-	printk("%s PSW : %08lx %08lx\n",
-	       mode, (unsigned long) regs->psw.mask,
-	       (unsigned long) regs->psw.addr);
-	printk("%s GPRS: %08x %08x %08x %08x\n", mode,
+	printk("%s PSW : %p %p\n",
+	       mode, (void *) regs->psw.mask,
+	       (void *) regs->psw.addr);
+	printk("%s GPRS: " FOURLONG, mode,
 	       regs->gprs[0], regs->gprs[1], regs->gprs[2], regs->gprs[3]);
-	printk("           %08x %08x %08x %08x\n",
+	printk("           " FOURLONG,
 	       regs->gprs[4], regs->gprs[5], regs->gprs[6], regs->gprs[7]);
-	printk("           %08x %08x %08x %08x\n",
+	printk("           " FOURLONG,
 	       regs->gprs[8], regs->gprs[9], regs->gprs[10], regs->gprs[11]);
-	printk("           %08x %08x %08x %08x\n",
+	printk("           " FOURLONG,
 	       regs->gprs[12], regs->gprs[13], regs->gprs[14], regs->gprs[15]);
+
 	printk("%s ACRS: %08x %08x %08x %08x\n", mode,
 	       regs->acrs[0], regs->acrs[1], regs->acrs[2], regs->acrs[3]);
 	printk("           %08x %08x %08x %08x\n",
@@ -191,21 +200,21 @@
 	struct pt_regs *regs;
 
 	regs = __KSTK_PTREGS(task);
-	buffer += sprintf(buffer, "task: %08lx, ksp: %08x\n",
-			  (unsigned long) task, task->thread.ksp);
-	buffer += sprintf(buffer, "User PSW : %08lx %08lx\n",
-			  (unsigned long) regs->psw.mask, 
-			  (unsigned long) regs->psw.addr);
-	buffer += sprintf(buffer, "User GPRS: %08x %08x %08x %08x\n",
+	buffer += sprintf(buffer, "task: %p, ksp: %p\n",
+		       task, (void *)task->thread.ksp);
+	buffer += sprintf(buffer, "User PSW : %p %p\n",
+		       (void *) regs->psw.mask, (void *)regs->psw.addr);
+
+	buffer += sprintf(buffer, "User GPRS: " FOURLONG,
 			  regs->gprs[0], regs->gprs[1],
 			  regs->gprs[2], regs->gprs[3]);
-	buffer += sprintf(buffer, "           %08x %08x %08x %08x\n",
+	buffer += sprintf(buffer, "           " FOURLONG,
 			  regs->gprs[4], regs->gprs[5],
 			  regs->gprs[6], regs->gprs[7]);
-	buffer += sprintf(buffer, "           %08x %08x %08x %08x\n",
+	buffer += sprintf(buffer, "           " FOURLONG,
 			  regs->gprs[8], regs->gprs[9],
 			  regs->gprs[10], regs->gprs[11]);
-	buffer += sprintf(buffer, "           %08x %08x %08x %08x\n",
+	buffer += sprintf(buffer, "           " FOURLONG,
 			  regs->gprs[12], regs->gprs[13],
 			  regs->gprs[14], regs->gprs[15]);
 	buffer += sprintf(buffer, "User ACRS: %08x %08x %08x %08x\n",
@@ -271,9 +280,9 @@
 #endif
         } else {
                 const struct exception_table_entry *fixup;
-                fixup = search_exception_tables(regs->psw.addr & 0x7fffffff);
+                fixup = search_exception_tables(regs->psw.addr & PSW_ADDR_INSN);
                 if (fixup)
-                        regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE31;
+                        regs->psw.addr = fixup->fixup | ~PSW_ADDR_INSN;
                 else
                         die(str, regs, interruption_code);
         }
@@ -376,7 +385,7 @@
 	__u16 *location;
 	int signal = 0;
 
-	location = (__u16 *)(regs->psw.addr-S390_lowcore.pgm_ilc);
+	location = (__u16 *) get_check_address(regs);
 
 	/*
 	 * We got all needed information from the lowcore and can
@@ -428,7 +437,6 @@
 }
 
 
-
 #ifdef CONFIG_MATHEMU
 asmlinkage void 
 specification_exception(struct pt_regs * regs, long interruption_code)
@@ -606,33 +614,40 @@
         pgm_check_table[9] = &divide_exception;
         pgm_check_table[0x10] = &do_segment_exception;
         pgm_check_table[0x11] = &do_page_exception;
+        pgm_check_table[0x10] = &do_segment_exception;
+        pgm_check_table[0x11] = &do_page_exception;
         pgm_check_table[0x12] = &translation_exception;
         pgm_check_table[0x13] = &special_op_exception;
+#ifndef CONFIG_ARCH_S390X
  	pgm_check_table[0x14] = &do_pseudo_page_fault;
+#else /* CONFIG_ARCH_S390X */
+        pgm_check_table[0x38] = &addressing_exception;
+        pgm_check_table[0x3B] = &do_region_exception;
+#endif /* CONFIG_ARCH_S390X */
         pgm_check_table[0x15] = &operand_exception;
         pgm_check_table[0x1C] = &privileged_op;
-#ifdef CONFIG_PFAULT
 	if (MACHINE_IS_VM) {
-		/* request the 0x2603 external interrupt */
-		if (register_early_external_interrupt(0x2603, pfault_interrupt,
-						      &ext_int_pfault) != 0)
-			panic("Couldn't request external interrupt 0x2603");
 		/*
 		 * First try to get pfault pseudo page faults going.
 		 * If this isn't available turn on pagex page faults.
 		 */
-		if (pfault_init() != 0) {
-			/* Tough luck, no pfault. */
-			unregister_early_external_interrupt(0x2603,
-							    pfault_interrupt,
-							    &ext_int_pfault);
-			cpcmd("SET PAGEX ON", NULL, 0);
-		}
-	}
-#else
-	if (MACHINE_IS_VM)
+#ifdef CONFIG_PFAULT
+		/* request the 0x2603 external interrupt */
+		if (register_early_external_interrupt(0x2603, pfault_interrupt,
+						      &ext_int_pfault) != 0)
+			panic("Couldn't request external interrupt 0x2603");
+
+		if (pfault_init() == 0) 
+			return;
+		
+		/* Tough luck, no pfault. */
+		unregister_early_external_interrupt(0x2603, pfault_interrupt,
+						    &ext_int_pfault);
+#endif
+#ifndef CONFIG_ARCH_S390X
 		cpcmd("SET PAGEX ON", NULL, 0);
 #endif
+	}
 }
 
 
diff -urN linux-2.5.67/arch/s390/lib/Makefile linux-2.5.67-s390/arch/s390/lib/Makefile
--- linux-2.5.67/arch/s390/lib/Makefile	Mon Apr  7 19:30:39 2003
+++ linux-2.5.67-s390/arch/s390/lib/Makefile	Mon Apr 14 19:11:57 2003
@@ -6,4 +6,6 @@
 
 EXTRA_AFLAGS := -traditional
 
-obj-y = delay.o memset.o strcmp.o strncpy.o uaccess.o
+obj-y += delay.o 
+obj-$(CONFIG_ARCH_S390_31) += memset.o strcmp.o strncpy.o uaccess.o
+obj-$(CONFIG_ARCH_S390X) += memset64.o strcmp64.o strncpy64.o uaccess64.o
diff -urN linux-2.5.67/arch/s390/lib/memset64.S linux-2.5.67-s390/arch/s390/lib/memset64.S
--- linux-2.5.67/arch/s390/lib/memset64.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/lib/memset64.S	Mon Apr 14 19:11:57 2003
@@ -0,0 +1,30 @@
+/*
+ *  arch/s390/lib/memset.S
+ *    S390 fast memset routine
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ */
+
+/*
+ * R2 = address to memory area
+ * R3 = byte to fill memory with
+ * R4 = number of bytes to fill
+ */
+        .globl  memset
+memset:
+        LTGR    4,4
+        JZ      memset_end
+        LGR     0,2                    # save pointer to memory area
+        LGR     1,3                    # move pad byte to R1
+        LGR     3,4
+        SGR     4,4                    # no source for MVCLE, only a pad byte
+        SGR     5,5
+        MVCLE   2,4,0(1)               # thats it, MVCLE is your friend
+        JO      .-4
+        LGR     2,0                    # return pointer to mem.
+memset_end:
+        BR      14
+        
+
diff -urN linux-2.5.67/arch/s390/lib/strcmp64.S linux-2.5.67-s390/arch/s390/lib/strcmp64.S
--- linux-2.5.67/arch/s390/lib/strcmp64.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/lib/strcmp64.S	Mon Apr 14 19:11:57 2003
@@ -0,0 +1,27 @@
+/*
+ *  arch/s390/lib/strcmp.S
+ *    S390 strcmp routine
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ */
+
+/*
+ * R2 = address of compare string
+ * R3 = address of test string
+ */
+        .globl   strcmp
+strcmp:
+        SGR     0,0
+        SGR     1,1
+        CLST    2,3
+        JO      .-4
+        JE      strcmp_equal
+        IC      0,0(3)
+        IC      1,0(2)
+        SGR     1,0
+strcmp_equal:
+        LGR     2,1
+        BR      14
+        
diff -urN linux-2.5.67/arch/s390/lib/strncpy64.S linux-2.5.67-s390/arch/s390/lib/strncpy64.S
--- linux-2.5.67/arch/s390/lib/strncpy64.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/lib/strncpy64.S	Mon Apr 14 19:11:57 2003
@@ -0,0 +1,30 @@
+/*
+ *  arch/s390/kernel/strncpy.S
+ *    S390 strncpy routine
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ */
+
+/*
+ * R2 = address of destination
+ * R3 = address of source string
+ * R4 = max number of bytes to copy
+ */
+        .globl   strncpy
+strncpy:
+        LGR     1,2            # don't touch address in R2
+	LTR     4,4
+        JZ      strncpy_exit   # 0 bytes -> nothing to do
+	SGR     0,0
+strncpy_loop:
+        ICM     0,1,0(3)       # ICM sets the cc, IC does not
+	LA      3,1(3)
+        STC     0,0(1)
+	LA      1,1(1)
+        JZ      strncpy_exit   # ICM inserted a 0x00
+        BRCTG   4,strncpy_loop # R4 -= 1, jump to strncpy_loop if > 0
+strncpy_exit:
+        BR      14
+
diff -urN linux-2.5.67/arch/s390/lib/uaccess64.S linux-2.5.67-s390/arch/s390/lib/uaccess64.S
--- linux-2.5.67/arch/s390/lib/uaccess64.S	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/arch/s390/lib/uaccess64.S	Mon Apr 14 19:11:57 2003
@@ -0,0 +1,107 @@
+/*
+ *  arch/s390x/lib/uaccess.S
+ *    __copy_{from|to}_user functions.
+ *
+ *  s390
+ *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ *  These functions have standard call interface
+ */
+
+#include <asm/lowcore.h>
+
+        .text
+        .align 4
+        .globl __copy_from_user_asm
+__copy_from_user_asm:
+	lgr	%r5,%r3
+	sacf	512
+0:	mvcle	%r2,%r4,0
+	jo	0b
+1:	sacf	0
+	lgr	%r2,%r5
+	br	%r14
+2:	lghi	%r1,-4096
+	lgr	%r3,%r4
+	slgr	%r3,%r1      # %r3 = %r4 + 4096
+	ngr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
+	slgr	%r3,%r4      # %r3 = #bytes to next user page boundary
+	clgr	%r5,%r3      # copy crosses next page boundary ?
+	jnh	1b           # no, this page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r2,%r4,0
+	jo	3b
+	j	1b
+        .section __ex_table,"a"
+	.quad	0b,2b
+	.quad	3b,1b
+        .previous
+
+        .align 4
+        .text
+        .globl __copy_to_user_asm
+__copy_to_user_asm:
+	lgr	%r5,%r3
+	sacf	512
+0:	mvcle	%r4,%r2,0
+	jo	0b
+1:	sacf	0
+	lgr	%r2,%r3
+	br	%r14
+2:	lghi	%r1,-4096
+	lgr	%r5,%r4
+	slgr	%r5,%r1      # %r5 = %r4 + 4096
+	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clgr	%r3,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
+        .section __ex_table,"a"
+	.quad	0b,2b
+	.quad	3b,1b
+        .previous
+
+        .align 4
+        .text
+        .globl __clear_user_asm
+__clear_user_asm:
+	lgr	%r4,%r2
+	lgr	%r5,%r3
+	sgr	%r2,%r2
+	sgr	%r3,%r3
+	sacf	512
+0:	mvcle	%r4,%r2,0
+	jo	0b
+1:	sacf	0
+	br	%r14
+2:	lgr	%r2,%r5
+	lghi	%r1,-4096
+	slgr	%r5,%r1      # %r5 = %r4 + 4096
+	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clgr	%r2,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+	slgr	%r2,%r5
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
+4:	algr	%r2,%r5
+	j	1b
+        .section __ex_table,"a"
+	.quad	0b,2b
+        .quad	3b,4b
+        .previous
diff -urN linux-2.5.67/arch/s390/mm/fault.c linux-2.5.67-s390/arch/s390/mm/fault.c
--- linux-2.5.67/arch/s390/mm/fault.c	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/arch/s390/mm/fault.c	Mon Apr 14 19:11:57 2003
@@ -31,6 +31,18 @@
 #include <asm/pgtable.h>
 #include <asm/hardirq.h>
 
+#ifndef CONFIG_ARCH_S390X
+#define __FAIL_ADDR_MASK 0x7ffff000
+#define __FIXUP_MASK 0x7fffffff
+#define __SUBCODE_MASK 0x0200
+#define __PF_RES_FIELD 0ULL
+#else /* CONFIG_ARCH_S390X */
+#define __FAIL_ADDR_MASK -4096L
+#define __FIXUP_MASK ~0L
+#define __SUBCODE_MASK 0x0600
+#define __PF_RES_FIELD 0x8000000000000000ULL
+#endif /* CONFIG_ARCH_S390X */
+
 #ifdef CONFIG_SYSCTL
 extern int sysctl_userprocess_debug;
 #endif
@@ -143,6 +155,7 @@
  *   04       Protection           ->  Write-Protection  (suprression)
  *   10       Segment translation  ->  Not present       (nullification)
  *   11       Page translation     ->  Not present       (nullification)
+ *   3b       Region third trans.  ->  Not present       (nullification)
  */
 extern inline void do_exception(struct pt_regs *regs, unsigned long error_code)
 {
@@ -182,7 +195,7 @@
          * more specific the segment and page table portion of 
          * the address 
          */
-        address = S390_lowcore.trans_exc_code&0x7ffff000;
+        address = S390_lowcore.trans_exc_code & __FAIL_ADDR_MASK;
 	user_address = check_user_space(regs, error_code);
 
 	/*
@@ -267,9 +280,9 @@
 
 no_context:
         /* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_tables(regs->psw.addr & 0x7fffffff);
+	fixup = search_exception_tables(regs->psw.addr & __FIXUP_MASK);
 	if (fixup) {
-		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE31;
+		regs->psw.addr = fixup->fixup | PSW_ADDR_AMODE;
                 return;
         }
 
@@ -279,10 +292,10 @@
  */
         if (user_address == 0)
                 printk(KERN_ALERT "Unable to handle kernel pointer dereference"
-        	       " at virtual kernel address %08lx\n", address);
+        	       " at virtual kernel address %p\n", (void *)address);
         else
                 printk(KERN_ALERT "Unable to handle kernel paging request"
-		       " at virtual user address %08lx\n", address);
+		       " at virtual user address %p\n", (void *)address);
 
         die("Oops", regs, error_code);
         do_exit(SIGKILL);
@@ -335,6 +348,16 @@
 	do_exception(regs, 0x11);
 }
 
+#ifdef CONFIG_ARCH_S390X
+
+void
+do_region_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	do_exception(regs, 0x3b);
+}
+
+#else /* CONFIG_ARCH_S390X */
+
 typedef struct _pseudo_wait_t {
        struct _pseudo_wait_t *next;
        wait_queue_head_t queue;
@@ -435,6 +458,7 @@
                 wait_event(wait_struct.queue, wait_struct.resolved);
         }
 }
+#endif /* CONFIG_ARCH_S390X */
 
 #ifdef CONFIG_PFAULT 
 /*
@@ -464,7 +488,8 @@
 int pfault_init(void)
 {
 	pfault_refbk_t refbk =
-	{ 0x258, 0, 5, 2, __LC_KERNEL_STACK, 1ULL << 48, 1ULL << 48, 0ULL };
+		{ 0x258, 0, 5, 2, __LC_KERNEL_STACK, 1ULL << 48, 1ULL << 48,
+		  __PF_RES_FIELD };
         int rc;
 
 	if (pfault_disable)
@@ -476,7 +501,11 @@
 		"2:\n"
 		".section __ex_table,\"a\"\n"
 		"   .align 4\n"
+#ifndef CONFIG_ARCH_S390X
 		"   .long  0b,1b\n"
+#else /* CONFIG_ARCH_S390X */
+		"   .quad  0b,1b\n"
+#endif /* CONFIG_ARCH_S390X */
 		".previous"
                 : "=d" (rc) : "a" (&refbk) : "cc" );
         __ctl_set_bit(0, 9);
@@ -496,7 +525,11 @@
 		"0:\n"
 		".section __ex_table,\"a\"\n"
 		"   .align 4\n"
+#ifndef CONFIG_ARCH_S390X
 		"   .long  0b,0b\n"
+#else /* CONFIG_ARCH_S390X */
+		"   .quad  0b,0b\n"
+#endif /* CONFIG_ARCH_S390X */
 		".previous"
 		: : "a" (&refbk) : "cc" );
 }
@@ -516,7 +549,7 @@
          * external interrupt. 
 	 */
 	subcode = S390_lowcore.cpu_addr;
-	if ((subcode & 0xff00) != 0x0200)
+	if ((subcode & 0xff00) != __SUBCODE_MASK)
 		return;
 
 	/*
@@ -524,7 +557,7 @@
 	 */
 	tsk = (struct task_struct *)
 		(*((unsigned long *) __LC_PFAULT_INTPARM) - THREAD_SIZE);
-	
+
 	/*
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
diff -urN linux-2.5.67/arch/s390/mm/init.c linux-2.5.67-s390/arch/s390/mm/init.c
--- linux-2.5.67/arch/s390/mm/init.c	Mon Apr  7 19:32:16 2003
+++ linux-2.5.67-s390/arch/s390/mm/init.c	Mon Apr 14 19:11:57 2003
@@ -79,13 +79,12 @@
 extern unsigned long __init_end;
 
 /*
- * paging_init() sets up the page tables - note that the first 4MB are
- * already mapped by head.S.
- * paging_init will erase this initial mapping
+ * paging_init() sets up the page tables
  */
 
 unsigned long last_valid_pfn;
 
+#ifndef CONFIG_ARCH_S390X
 void __init paging_init(void)
 {
         pgd_t * pg_dir;
@@ -98,12 +97,12 @@
         static const int ssm_mask = 0x04000000L;
 
 	/* unmap whole virtual address space */
-
+	
         pg_dir = swapper_pg_dir;
 
 	for (i=0;i<KERNEL_PGD_PTRS;i++) 
 	        pmd_clear((pmd_t*)pg_dir++);
-
+		
 	/*
 	 * map whole physical memory to virtual memory (identity mapping) 
 	 */
@@ -146,13 +145,92 @@
 		zones_size[ZONE_DMA] = max_low_pfn;
 		free_area_init(zones_size);
 	}
+        return;
+}
+
+#else /* CONFIG_ARCH_S390X */
+void __init paging_init(void)
+{
+        pgd_t * pg_dir;
+	pmd_t * pm_dir;
+        pte_t * pt_dir;
+        pte_t   pte;
+	int     i,j,k;
+        unsigned long pfn = 0;
+        unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) |
+          _KERN_REGION_TABLE;
+	static const int ssm_mask = 0x04000000L;
+
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long dma_pfn, high_pfn;
+
+	dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
+	high_pfn = max_low_pfn;
+
+	if (dma_pfn > high_pfn)
+		zones_size[ZONE_DMA] = high_pfn;
+	else {
+		zones_size[ZONE_DMA] = dma_pfn;
+		zones_size[ZONE_NORMAL] = high_pfn - dma_pfn;
+	}
+
+	/* Initialize mem_map[].  */
+	free_area_init(zones_size);
+
+
+	/*
+	 * map whole physical memory to virtual memory (identity mapping) 
+	 */
+
+        pg_dir = swapper_pg_dir;
+	
+        for (i = 0 ; i < PTRS_PER_PGD ; i++,pg_dir++) {
+	
+                if (pfn >= max_low_pfn) {
+                        pgd_clear(pg_dir);
+                        continue;
+                }          
+        
+	        pm_dir = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE*4);
+                pgd_populate(&init_mm, pg_dir, pm_dir);
+
+                for (j = 0 ; j < PTRS_PER_PMD ; j++,pm_dir++) {
+                        if (pfn >= max_low_pfn) {
+                                pmd_clear(pm_dir);
+                                continue; 
+                        }          
+                        
+                        pt_dir = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+                        pmd_populate_kernel(&init_mm, pm_dir, pt_dir);
+	
+                        for (k = 0 ; k < PTRS_PER_PTE ; k++,pt_dir++) {
+                                pte = pfn_pte(pfn, PAGE_KERNEL);
+                                if (pfn >= max_low_pfn) {
+                                        pte_clear(&pte); 
+                                        continue;
+                                }
+                                set_pte(pt_dir, pte);
+                                pfn++;
+                        }
+                }
+        }
+
+        /* enable virtual mapping in kernel mode */
+        __asm__ __volatile__("lctlg 1,1,%0\n\t"
+                             "lctlg 7,7,%0\n\t"
+                             "lctlg 13,13,%0\n\t"
+                             "ssm   %1"
+			     : :"m" (pgdir_k), "m" (ssm_mask));
+
+        local_flush_tlb();
 
         return;
 }
+#endif /* CONFIG_ARCH_S390X */
 
 void __init mem_init(void)
 {
-	int codesize, reservedpages, datasize, initsize;
+	unsigned long codesize, reservedpages, datasize, initsize;
 
         max_mapnr = num_physpages = max_low_pfn;
         high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
@@ -168,7 +246,7 @@
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;
-        printk("Memory: %luk/%luk available (%dk kernel code, %dk reserved, %dk data, %dk init)\n",
+        printk("Memory: %luk/%luk available (%ldk kernel code, %ldk reserved, %ldk data, %ldk init)\n",
                 (unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
                 max_mapnr << (PAGE_SHIFT-10),
                 codesize >> 10,
diff -urN linux-2.5.67/arch/s390/vmlinux.lds.S linux-2.5.67-s390/arch/s390/vmlinux.lds.S
--- linux-2.5.67/arch/s390/vmlinux.lds.S	Mon Apr 14 19:11:35 2003
+++ linux-2.5.67-s390/arch/s390/vmlinux.lds.S	Mon Apr 14 19:11:57 2003
@@ -3,11 +3,20 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <linux/config.h>
 
+#ifndef CONFIG_ARCH_S390X
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390)
 ENTRY(_start)
 jiffies = jiffies_64 + 4;
+#else
+OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
+OUTPUT_ARCH(s390)
+ENTRY(_start)
+jiffies = jiffies_64;
+#endif
+
 SECTIONS
 {
   . = 0x00000000;

