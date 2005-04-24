Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVDXSzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVDXSzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVDXSzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:55:22 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:45722 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262372AbVDXSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:44:44 -0400
Subject: [patch 1/7] uml: fix syscall table by including $(SUBARCH)'s one, for i386
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:19:07 +0200
Message-Id: <20050424181909.81B8F33AED@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Split the i386 entry.S files into entry.S and syscall_table.S which
is included in the previous one (so actually there is no difference between
them) and use the syscall_table.S in the UML build, instead of tracking by
hand the syscall table changes (which is inherently error-prone).

We must only insert the right #defines to inject the changes we need from the
i386 syscall table (for instance some different function names); also, we
don't implement some i386 syscalls, as ioperm(), nor some TLS-related ones
(yet to provide).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/i386/kernel/entry.S                 |  292 ------------
 linux-2.6.12-paolo/arch/i386/kernel/syscall_table.S         |  291 +++++++++++
 linux-2.6.12-paolo/arch/um/include/sysdep-i386/syscalls.h   |   99 ----
 linux-2.6.12-paolo/arch/um/include/sysdep-x86_64/syscalls.h |   11 
 linux-2.6.12-paolo/arch/um/kernel/Makefile                  |    2 
 linux-2.6.12-paolo/arch/um/sys-i386/Makefile                |    3 
 linux-2.6.12-paolo/arch/um/sys-i386/sys_call_table.S        |   16 
 linux-2.6.12-paolo/arch/um/sys-x86_64/Makefile              |    2 
 linux-2.6.12-paolo/arch/um/sys-x86_64/sys_call_table.c      |  276 +++++++++++
 linux-2.6.12/arch/um/kernel/sys_call_table.c                |  270 -----------
 10 files changed, 588 insertions(+), 674 deletions(-)

diff -puN arch/i386/kernel/entry.S~uml-fix-syscall-table-i386 arch/i386/kernel/entry.S
--- linux-2.6.12/arch/i386/kernel/entry.S~uml-fix-syscall-table-i386	2005-04-24 20:17:02.000000000 +0200
+++ linux-2.6.12-paolo/arch/i386/kernel/entry.S	2005-04-24 20:17:02.000000000 +0200
@@ -667,296 +667,6 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
-.data
-ENTRY(sys_call_table)
-	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
-	.long sys_exit
-	.long sys_fork
-	.long sys_read
-	.long sys_write
-	.long sys_open		/* 5 */
-	.long sys_close
-	.long sys_waitpid
-	.long sys_creat
-	.long sys_link
-	.long sys_unlink	/* 10 */
-	.long sys_execve
-	.long sys_chdir
-	.long sys_time
-	.long sys_mknod
-	.long sys_chmod		/* 15 */
-	.long sys_lchown16
-	.long sys_ni_syscall	/* old break syscall holder */
-	.long sys_stat
-	.long sys_lseek
-	.long sys_getpid	/* 20 */
-	.long sys_mount
-	.long sys_oldumount
-	.long sys_setuid16
-	.long sys_getuid16
-	.long sys_stime		/* 25 */
-	.long sys_ptrace
-	.long sys_alarm
-	.long sys_fstat
-	.long sys_pause
-	.long sys_utime		/* 30 */
-	.long sys_ni_syscall	/* old stty syscall holder */
-	.long sys_ni_syscall	/* old gtty syscall holder */
-	.long sys_access
-	.long sys_nice
-	.long sys_ni_syscall	/* 35 - old ftime syscall holder */
-	.long sys_sync
-	.long sys_kill
-	.long sys_rename
-	.long sys_mkdir
-	.long sys_rmdir		/* 40 */
-	.long sys_dup
-	.long sys_pipe
-	.long sys_times
-	.long sys_ni_syscall	/* old prof syscall holder */
-	.long sys_brk		/* 45 */
-	.long sys_setgid16
-	.long sys_getgid16
-	.long sys_signal
-	.long sys_geteuid16
-	.long sys_getegid16	/* 50 */
-	.long sys_acct
-	.long sys_umount	/* recycled never used phys() */
-	.long sys_ni_syscall	/* old lock syscall holder */
-	.long sys_ioctl
-	.long sys_fcntl		/* 55 */
-	.long sys_ni_syscall	/* old mpx syscall holder */
-	.long sys_setpgid
-	.long sys_ni_syscall	/* old ulimit syscall holder */
-	.long sys_olduname
-	.long sys_umask		/* 60 */
-	.long sys_chroot
-	.long sys_ustat
-	.long sys_dup2
-	.long sys_getppid
-	.long sys_getpgrp	/* 65 */
-	.long sys_setsid
-	.long sys_sigaction
-	.long sys_sgetmask
-	.long sys_ssetmask
-	.long sys_setreuid16	/* 70 */
-	.long sys_setregid16
-	.long sys_sigsuspend
-	.long sys_sigpending
-	.long sys_sethostname
-	.long sys_setrlimit	/* 75 */
-	.long sys_old_getrlimit
-	.long sys_getrusage
-	.long sys_gettimeofday
-	.long sys_settimeofday
-	.long sys_getgroups16	/* 80 */
-	.long sys_setgroups16
-	.long old_select
-	.long sys_symlink
-	.long sys_lstat
-	.long sys_readlink	/* 85 */
-	.long sys_uselib
-	.long sys_swapon
-	.long sys_reboot
-	.long old_readdir
-	.long old_mmap		/* 90 */
-	.long sys_munmap
-	.long sys_truncate
-	.long sys_ftruncate
-	.long sys_fchmod
-	.long sys_fchown16	/* 95 */
-	.long sys_getpriority
-	.long sys_setpriority
-	.long sys_ni_syscall	/* old profil syscall holder */
-	.long sys_statfs
-	.long sys_fstatfs	/* 100 */
-	.long sys_ioperm
-	.long sys_socketcall
-	.long sys_syslog
-	.long sys_setitimer
-	.long sys_getitimer	/* 105 */
-	.long sys_newstat
-	.long sys_newlstat
-	.long sys_newfstat
-	.long sys_uname
-	.long sys_iopl		/* 110 */
-	.long sys_vhangup
-	.long sys_ni_syscall	/* old "idle" system call */
-	.long sys_vm86old
-	.long sys_wait4
-	.long sys_swapoff	/* 115 */
-	.long sys_sysinfo
-	.long sys_ipc
-	.long sys_fsync
-	.long sys_sigreturn
-	.long sys_clone		/* 120 */
-	.long sys_setdomainname
-	.long sys_newuname
-	.long sys_modify_ldt
-	.long sys_adjtimex
-	.long sys_mprotect	/* 125 */
-	.long sys_sigprocmask
-	.long sys_ni_syscall	/* old "create_module" */ 
-	.long sys_init_module
-	.long sys_delete_module
-	.long sys_ni_syscall	/* 130:	old "get_kernel_syms" */
-	.long sys_quotactl
-	.long sys_getpgid
-	.long sys_fchdir
-	.long sys_bdflush
-	.long sys_sysfs		/* 135 */
-	.long sys_personality
-	.long sys_ni_syscall	/* reserved for afs_syscall */
-	.long sys_setfsuid16
-	.long sys_setfsgid16
-	.long sys_llseek	/* 140 */
-	.long sys_getdents
-	.long sys_select
-	.long sys_flock
-	.long sys_msync
-	.long sys_readv		/* 145 */
-	.long sys_writev
-	.long sys_getsid
-	.long sys_fdatasync
-	.long sys_sysctl
-	.long sys_mlock		/* 150 */
-	.long sys_munlock
-	.long sys_mlockall
-	.long sys_munlockall
-	.long sys_sched_setparam
-	.long sys_sched_getparam   /* 155 */
-	.long sys_sched_setscheduler
-	.long sys_sched_getscheduler
-	.long sys_sched_yield
-	.long sys_sched_get_priority_max
-	.long sys_sched_get_priority_min  /* 160 */
-	.long sys_sched_rr_get_interval
-	.long sys_nanosleep
-	.long sys_mremap
-	.long sys_setresuid16
-	.long sys_getresuid16	/* 165 */
-	.long sys_vm86
-	.long sys_ni_syscall	/* Old sys_query_module */
-	.long sys_poll
-	.long sys_nfsservctl
-	.long sys_setresgid16	/* 170 */
-	.long sys_getresgid16
-	.long sys_prctl
-	.long sys_rt_sigreturn
-	.long sys_rt_sigaction
-	.long sys_rt_sigprocmask	/* 175 */
-	.long sys_rt_sigpending
-	.long sys_rt_sigtimedwait
-	.long sys_rt_sigqueueinfo
-	.long sys_rt_sigsuspend
-	.long sys_pread64	/* 180 */
-	.long sys_pwrite64
-	.long sys_chown16
-	.long sys_getcwd
-	.long sys_capget
-	.long sys_capset	/* 185 */
-	.long sys_sigaltstack
-	.long sys_sendfile
-	.long sys_ni_syscall	/* reserved for streams1 */
-	.long sys_ni_syscall	/* reserved for streams2 */
-	.long sys_vfork		/* 190 */
-	.long sys_getrlimit
-	.long sys_mmap2
-	.long sys_truncate64
-	.long sys_ftruncate64
-	.long sys_stat64	/* 195 */
-	.long sys_lstat64
-	.long sys_fstat64
-	.long sys_lchown
-	.long sys_getuid
-	.long sys_getgid	/* 200 */
-	.long sys_geteuid
-	.long sys_getegid
-	.long sys_setreuid
-	.long sys_setregid
-	.long sys_getgroups	/* 205 */
-	.long sys_setgroups
-	.long sys_fchown
-	.long sys_setresuid
-	.long sys_getresuid
-	.long sys_setresgid	/* 210 */
-	.long sys_getresgid
-	.long sys_chown
-	.long sys_setuid
-	.long sys_setgid
-	.long sys_setfsuid	/* 215 */
-	.long sys_setfsgid
-	.long sys_pivot_root
-	.long sys_mincore
-	.long sys_madvise
-	.long sys_getdents64	/* 220 */
-	.long sys_fcntl64
-	.long sys_ni_syscall	/* reserved for TUX */
-	.long sys_ni_syscall
-	.long sys_gettid
-	.long sys_readahead	/* 225 */
-	.long sys_setxattr
-	.long sys_lsetxattr
-	.long sys_fsetxattr
-	.long sys_getxattr
-	.long sys_lgetxattr	/* 230 */
-	.long sys_fgetxattr
-	.long sys_listxattr
-	.long sys_llistxattr
-	.long sys_flistxattr
-	.long sys_removexattr	/* 235 */
-	.long sys_lremovexattr
-	.long sys_fremovexattr
-	.long sys_tkill
-	.long sys_sendfile64
-	.long sys_futex		/* 240 */
-	.long sys_sched_setaffinity
-	.long sys_sched_getaffinity
-	.long sys_set_thread_area
-	.long sys_get_thread_area
-	.long sys_io_setup	/* 245 */
-	.long sys_io_destroy
-	.long sys_io_getevents
-	.long sys_io_submit
-	.long sys_io_cancel
-	.long sys_fadvise64	/* 250 */
-	.long sys_ni_syscall
-	.long sys_exit_group
-	.long sys_lookup_dcookie
-	.long sys_epoll_create
-	.long sys_epoll_ctl	/* 255 */
-	.long sys_epoll_wait
- 	.long sys_remap_file_pages
- 	.long sys_set_tid_address
- 	.long sys_timer_create
- 	.long sys_timer_settime		/* 260 */
- 	.long sys_timer_gettime
- 	.long sys_timer_getoverrun
- 	.long sys_timer_delete
- 	.long sys_clock_settime
- 	.long sys_clock_gettime		/* 265 */
- 	.long sys_clock_getres
- 	.long sys_clock_nanosleep
-	.long sys_statfs64
-	.long sys_fstatfs64	
-	.long sys_tgkill	/* 270 */
-	.long sys_utimes
- 	.long sys_fadvise64_64
-	.long sys_ni_syscall	/* sys_vserver */
-	.long sys_mbind
-	.long sys_get_mempolicy
-	.long sys_set_mempolicy
-	.long sys_mq_open
-	.long sys_mq_unlink
-	.long sys_mq_timedsend
-	.long sys_mq_timedreceive	/* 280 */
-	.long sys_mq_notify
-	.long sys_mq_getsetattr
-	.long sys_ni_syscall		/* reserved for kexec */
-	.long sys_waitid
-	.long sys_ni_syscall		/* 285 */ /* available */
-	.long sys_add_key
-	.long sys_request_key
-	.long sys_keyctl
+#include "syscall_table.S"
 
 syscall_table_size=(.-sys_call_table)
diff -puN /dev/null arch/i386/kernel/syscall_table.S
--- /dev/null	2005-04-22 23:47:00.498361144 +0200
+++ linux-2.6.12-paolo/arch/i386/kernel/syscall_table.S	2005-04-24 20:17:02.000000000 +0200
@@ -0,0 +1,291 @@
+.data
+ENTRY(sys_call_table)
+	.long sys_restart_syscall	/* 0 - old "setup()" system call, used for restarting */
+	.long sys_exit
+	.long sys_fork
+	.long sys_read
+	.long sys_write
+	.long sys_open		/* 5 */
+	.long sys_close
+	.long sys_waitpid
+	.long sys_creat
+	.long sys_link
+	.long sys_unlink	/* 10 */
+	.long sys_execve
+	.long sys_chdir
+	.long sys_time
+	.long sys_mknod
+	.long sys_chmod		/* 15 */
+	.long sys_lchown16
+	.long sys_ni_syscall	/* old break syscall holder */
+	.long sys_stat
+	.long sys_lseek
+	.long sys_getpid	/* 20 */
+	.long sys_mount
+	.long sys_oldumount
+	.long sys_setuid16
+	.long sys_getuid16
+	.long sys_stime		/* 25 */
+	.long sys_ptrace
+	.long sys_alarm
+	.long sys_fstat
+	.long sys_pause
+	.long sys_utime		/* 30 */
+	.long sys_ni_syscall	/* old stty syscall holder */
+	.long sys_ni_syscall	/* old gtty syscall holder */
+	.long sys_access
+	.long sys_nice
+	.long sys_ni_syscall	/* 35 - old ftime syscall holder */
+	.long sys_sync
+	.long sys_kill
+	.long sys_rename
+	.long sys_mkdir
+	.long sys_rmdir		/* 40 */
+	.long sys_dup
+	.long sys_pipe
+	.long sys_times
+	.long sys_ni_syscall	/* old prof syscall holder */
+	.long sys_brk		/* 45 */
+	.long sys_setgid16
+	.long sys_getgid16
+	.long sys_signal
+	.long sys_geteuid16
+	.long sys_getegid16	/* 50 */
+	.long sys_acct
+	.long sys_umount	/* recycled never used phys() */
+	.long sys_ni_syscall	/* old lock syscall holder */
+	.long sys_ioctl
+	.long sys_fcntl		/* 55 */
+	.long sys_ni_syscall	/* old mpx syscall holder */
+	.long sys_setpgid
+	.long sys_ni_syscall	/* old ulimit syscall holder */
+	.long sys_olduname
+	.long sys_umask		/* 60 */
+	.long sys_chroot
+	.long sys_ustat
+	.long sys_dup2
+	.long sys_getppid
+	.long sys_getpgrp	/* 65 */
+	.long sys_setsid
+	.long sys_sigaction
+	.long sys_sgetmask
+	.long sys_ssetmask
+	.long sys_setreuid16	/* 70 */
+	.long sys_setregid16
+	.long sys_sigsuspend
+	.long sys_sigpending
+	.long sys_sethostname
+	.long sys_setrlimit	/* 75 */
+	.long sys_old_getrlimit
+	.long sys_getrusage
+	.long sys_gettimeofday
+	.long sys_settimeofday
+	.long sys_getgroups16	/* 80 */
+	.long sys_setgroups16
+	.long old_select
+	.long sys_symlink
+	.long sys_lstat
+	.long sys_readlink	/* 85 */
+	.long sys_uselib
+	.long sys_swapon
+	.long sys_reboot
+	.long old_readdir
+	.long old_mmap		/* 90 */
+	.long sys_munmap
+	.long sys_truncate
+	.long sys_ftruncate
+	.long sys_fchmod
+	.long sys_fchown16	/* 95 */
+	.long sys_getpriority
+	.long sys_setpriority
+	.long sys_ni_syscall	/* old profil syscall holder */
+	.long sys_statfs
+	.long sys_fstatfs	/* 100 */
+	.long sys_ioperm
+	.long sys_socketcall
+	.long sys_syslog
+	.long sys_setitimer
+	.long sys_getitimer	/* 105 */
+	.long sys_newstat
+	.long sys_newlstat
+	.long sys_newfstat
+	.long sys_uname
+	.long sys_iopl		/* 110 */
+	.long sys_vhangup
+	.long sys_ni_syscall	/* old "idle" system call */
+	.long sys_vm86old
+	.long sys_wait4
+	.long sys_swapoff	/* 115 */
+	.long sys_sysinfo
+	.long sys_ipc
+	.long sys_fsync
+	.long sys_sigreturn
+	.long sys_clone		/* 120 */
+	.long sys_setdomainname
+	.long sys_newuname
+	.long sys_modify_ldt
+	.long sys_adjtimex
+	.long sys_mprotect	/* 125 */
+	.long sys_sigprocmask
+	.long sys_ni_syscall	/* old "create_module" */
+	.long sys_init_module
+	.long sys_delete_module
+	.long sys_ni_syscall	/* 130:	old "get_kernel_syms" */
+	.long sys_quotactl
+	.long sys_getpgid
+	.long sys_fchdir
+	.long sys_bdflush
+	.long sys_sysfs		/* 135 */
+	.long sys_personality
+	.long sys_ni_syscall	/* reserved for afs_syscall */
+	.long sys_setfsuid16
+	.long sys_setfsgid16
+	.long sys_llseek	/* 140 */
+	.long sys_getdents
+	.long sys_select
+	.long sys_flock
+	.long sys_msync
+	.long sys_readv		/* 145 */
+	.long sys_writev
+	.long sys_getsid
+	.long sys_fdatasync
+	.long sys_sysctl
+	.long sys_mlock		/* 150 */
+	.long sys_munlock
+	.long sys_mlockall
+	.long sys_munlockall
+	.long sys_sched_setparam
+	.long sys_sched_getparam   /* 155 */
+	.long sys_sched_setscheduler
+	.long sys_sched_getscheduler
+	.long sys_sched_yield
+	.long sys_sched_get_priority_max
+	.long sys_sched_get_priority_min  /* 160 */
+	.long sys_sched_rr_get_interval
+	.long sys_nanosleep
+	.long sys_mremap
+	.long sys_setresuid16
+	.long sys_getresuid16	/* 165 */
+	.long sys_vm86
+	.long sys_ni_syscall	/* Old sys_query_module */
+	.long sys_poll
+	.long sys_nfsservctl
+	.long sys_setresgid16	/* 170 */
+	.long sys_getresgid16
+	.long sys_prctl
+	.long sys_rt_sigreturn
+	.long sys_rt_sigaction
+	.long sys_rt_sigprocmask	/* 175 */
+	.long sys_rt_sigpending
+	.long sys_rt_sigtimedwait
+	.long sys_rt_sigqueueinfo
+	.long sys_rt_sigsuspend
+	.long sys_pread64	/* 180 */
+	.long sys_pwrite64
+	.long sys_chown16
+	.long sys_getcwd
+	.long sys_capget
+	.long sys_capset	/* 185 */
+	.long sys_sigaltstack
+	.long sys_sendfile
+	.long sys_ni_syscall	/* reserved for streams1 */
+	.long sys_ni_syscall	/* reserved for streams2 */
+	.long sys_vfork		/* 190 */
+	.long sys_getrlimit
+	.long sys_mmap2
+	.long sys_truncate64
+	.long sys_ftruncate64
+	.long sys_stat64	/* 195 */
+	.long sys_lstat64
+	.long sys_fstat64
+	.long sys_lchown
+	.long sys_getuid
+	.long sys_getgid	/* 200 */
+	.long sys_geteuid
+	.long sys_getegid
+	.long sys_setreuid
+	.long sys_setregid
+	.long sys_getgroups	/* 205 */
+	.long sys_setgroups
+	.long sys_fchown
+	.long sys_setresuid
+	.long sys_getresuid
+	.long sys_setresgid	/* 210 */
+	.long sys_getresgid
+	.long sys_chown
+	.long sys_setuid
+	.long sys_setgid
+	.long sys_setfsuid	/* 215 */
+	.long sys_setfsgid
+	.long sys_pivot_root
+	.long sys_mincore
+	.long sys_madvise
+	.long sys_getdents64	/* 220 */
+	.long sys_fcntl64
+	.long sys_ni_syscall	/* reserved for TUX */
+	.long sys_ni_syscall
+	.long sys_gettid
+	.long sys_readahead	/* 225 */
+	.long sys_setxattr
+	.long sys_lsetxattr
+	.long sys_fsetxattr
+	.long sys_getxattr
+	.long sys_lgetxattr	/* 230 */
+	.long sys_fgetxattr
+	.long sys_listxattr
+	.long sys_llistxattr
+	.long sys_flistxattr
+	.long sys_removexattr	/* 235 */
+	.long sys_lremovexattr
+	.long sys_fremovexattr
+	.long sys_tkill
+	.long sys_sendfile64
+	.long sys_futex		/* 240 */
+	.long sys_sched_setaffinity
+	.long sys_sched_getaffinity
+	.long sys_set_thread_area
+	.long sys_get_thread_area
+	.long sys_io_setup	/* 245 */
+	.long sys_io_destroy
+	.long sys_io_getevents
+	.long sys_io_submit
+	.long sys_io_cancel
+	.long sys_fadvise64	/* 250 */
+	.long sys_ni_syscall
+	.long sys_exit_group
+	.long sys_lookup_dcookie
+	.long sys_epoll_create
+	.long sys_epoll_ctl	/* 255 */
+	.long sys_epoll_wait
+ 	.long sys_remap_file_pages
+ 	.long sys_set_tid_address
+ 	.long sys_timer_create
+ 	.long sys_timer_settime		/* 260 */
+ 	.long sys_timer_gettime
+ 	.long sys_timer_getoverrun
+ 	.long sys_timer_delete
+ 	.long sys_clock_settime
+ 	.long sys_clock_gettime		/* 265 */
+ 	.long sys_clock_getres
+ 	.long sys_clock_nanosleep
+	.long sys_statfs64
+	.long sys_fstatfs64
+	.long sys_tgkill	/* 270 */
+	.long sys_utimes
+ 	.long sys_fadvise64_64
+	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_mbind
+	.long sys_get_mempolicy
+	.long sys_set_mempolicy
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive	/* 280 */
+	.long sys_mq_notify
+	.long sys_mq_getsetattr
+	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_waitid
+	.long sys_ni_syscall		/* 285 */ /* available */
+	.long sys_add_key
+	.long sys_request_key
+	.long sys_keyctl
diff -puN arch/um/include/sysdep-i386/syscalls.h~uml-fix-syscall-table-i386 arch/um/include/sysdep-i386/syscalls.h
--- linux-2.6.12/arch/um/include/sysdep-i386/syscalls.h~uml-fix-syscall-table-i386	2005-04-24 20:17:02.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/include/sysdep-i386/syscalls.h	2005-04-24 20:17:02.000000000 +0200
@@ -22,102 +22,3 @@ extern syscall_handler_t old_mmap_i386;
 extern long sys_mmap2(unsigned long addr, unsigned long len,
 		      unsigned long prot, unsigned long flags,
 		      unsigned long fd, unsigned long pgoff);
-
-/* On i386 they choose a meaningless naming.*/
-#define __NR_kexec_load __NR_sys_kexec_load
-
-#define ARCH_SYSCALLS \
-	[ __NR_waitpid ] = (syscall_handler_t *) sys_waitpid, \
-	[ __NR_break ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_oldstat ] = (syscall_handler_t *) sys_stat, \
-	[ __NR_umount ] = (syscall_handler_t *) sys_oldumount, \
-	[ __NR_stime ] = um_stime, \
-	[ __NR_oldfstat ] = (syscall_handler_t *) sys_fstat, \
-	[ __NR_stty ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_gtty ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_nice ] = (syscall_handler_t *) sys_nice, \
-	[ __NR_ftime ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_prof ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_signal ] = (syscall_handler_t *) sys_signal, \
-	[ __NR_lock ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_mpx ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_ulimit ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_oldolduname ] = (syscall_handler_t *) sys_olduname, \
-	[ __NR_sigaction ] = (syscall_handler_t *) sys_sigaction, \
-	[ __NR_sgetmask ] = (syscall_handler_t *) sys_sgetmask, \
-	[ __NR_ssetmask ] = (syscall_handler_t *) sys_ssetmask, \
-	[ __NR_sigsuspend ] = (syscall_handler_t *) sys_sigsuspend, \
-	[ __NR_sigpending ] = (syscall_handler_t *) sys_sigpending, \
-	[ __NR_oldlstat ] = (syscall_handler_t *) sys_lstat, \
-	[ __NR_readdir ] = old_readdir, \
-	[ __NR_profil ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_socketcall ] = (syscall_handler_t *) sys_socketcall, \
-	[ __NR_olduname ] = (syscall_handler_t *) sys_uname, \
-	[ __NR_iopl ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_idle ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_ipc ] = (syscall_handler_t *) sys_ipc, \
-	[ __NR_sigreturn ] = (syscall_handler_t *) sys_sigreturn, \
-	[ __NR_sigprocmask ] = (syscall_handler_t *) sys_sigprocmask, \
-	[ __NR_bdflush ] = (syscall_handler_t *) sys_bdflush, \
-	[ __NR__llseek ] = (syscall_handler_t *) sys_llseek, \
-	[ __NR__newselect ] = (syscall_handler_t *) sys_select, \
-	[ __NR_vm86 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_mmap ] = (syscall_handler_t *) old_mmap_i386, \
-	[ __NR_ugetrlimit ] = (syscall_handler_t *) sys_getrlimit, \
-	[ __NR_mmap2 ] = (syscall_handler_t *) sys_mmap2, \
-	[ __NR_truncate64 ] = (syscall_handler_t *) sys_truncate64, \
-	[ __NR_ftruncate64 ] = (syscall_handler_t *) sys_ftruncate64, \
-	[ __NR_stat64 ] = (syscall_handler_t *) sys_stat64, \
-	[ __NR_lstat64 ] = (syscall_handler_t *) sys_lstat64, \
-	[ __NR_fstat64 ] = (syscall_handler_t *) sys_fstat64, \
-	[ __NR_fcntl64 ] = (syscall_handler_t *) sys_fcntl64, \
-	[ __NR_sendfile64 ] = (syscall_handler_t *) sys_sendfile64, \
-	[ __NR_statfs64 ] = (syscall_handler_t *) sys_statfs64, \
-	[ __NR_fstatfs64 ] = (syscall_handler_t *) sys_fstatfs64, \
-	[ __NR_fadvise64_64 ] = (syscall_handler_t *) sys_fadvise64_64, \
-	[ __NR_select ] = (syscall_handler_t *) old_select, \
-	[ __NR_vm86old ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_modify_ldt ] = (syscall_handler_t *) sys_modify_ldt, \
-	[ __NR_lchown32 ] = (syscall_handler_t *) sys_lchown, \
-	[ __NR_getuid32 ] = (syscall_handler_t *) sys_getuid, \
-	[ __NR_getgid32 ] = (syscall_handler_t *) sys_getgid, \
-	[ __NR_geteuid32 ] = (syscall_handler_t *) sys_geteuid, \
-	[ __NR_getegid32 ] = (syscall_handler_t *) sys_getegid, \
-	[ __NR_setreuid32 ] = (syscall_handler_t *) sys_setreuid, \
-	[ __NR_setregid32 ] = (syscall_handler_t *) sys_setregid, \
-	[ __NR_getgroups32 ] = (syscall_handler_t *) sys_getgroups, \
-	[ __NR_setgroups32 ] = (syscall_handler_t *) sys_setgroups, \
-	[ __NR_fchown32 ] = (syscall_handler_t *) sys_fchown, \
-	[ __NR_setresuid32 ] = (syscall_handler_t *) sys_setresuid, \
-	[ __NR_getresuid32 ] = (syscall_handler_t *) sys_getresuid, \
-	[ __NR_setresgid32 ] = (syscall_handler_t *) sys_setresgid, \
-	[ __NR_getresgid32 ] = (syscall_handler_t *) sys_getresgid, \
-	[ __NR_chown32 ] = (syscall_handler_t *) sys_chown, \
-	[ __NR_setuid32 ] = (syscall_handler_t *) sys_setuid, \
-	[ __NR_setgid32 ] = (syscall_handler_t *) sys_setgid, \
-	[ __NR_setfsuid32 ] = (syscall_handler_t *) sys_setfsuid, \
-	[ __NR_setfsgid32 ] = (syscall_handler_t *) sys_setfsgid, \
-	[ __NR_pivot_root ] = (syscall_handler_t *) sys_pivot_root, \
-	[ __NR_mincore ] = (syscall_handler_t *) sys_mincore, \
-	[ __NR_madvise ] = (syscall_handler_t *) sys_madvise, \
-	[ 222 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ 223 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_set_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ __NR_get_thread_area ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ 251 ] = (syscall_handler_t *) sys_ni_syscall, \
-	[ 285 ] = (syscall_handler_t *) sys_ni_syscall,
-
-/* 222 doesn't yet have a name in include/asm-i386/unistd.h */
-
-#define LAST_ARCH_SYSCALL 285
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/include/sysdep-x86_64/syscalls.h~uml-fix-syscall-table-i386 arch/um/include/sysdep-x86_64/syscalls.h
--- linux-2.6.12/arch/um/include/sysdep-x86_64/syscalls.h~uml-fix-syscall-table-i386	2005-04-24 20:17:02.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/include/sysdep-x86_64/syscalls.h	2005-04-24 20:17:02.000000000 +0200
@@ -78,14 +78,3 @@ extern syscall_handler_t sys_arch_prctl;
 #define NR_syscalls 1024
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/Makefile~uml-fix-syscall-table-i386 arch/um/kernel/Makefile
--- linux-2.6.12/arch/um/kernel/Makefile~uml-fix-syscall-table-i386	2005-04-24 20:17:02.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/Makefile	2005-04-24 20:17:02.000000000 +0200
@@ -10,7 +10,7 @@ obj-y = checksum.o config.o exec_kern.o 
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
-	syscall_kern.o sysrq.o sys_call_table.o tempfile.o time.o time_kern.o \
+	syscall_kern.o sysrq.o tempfile.o time.o time_kern.o \
 	tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o umid.o \
 	user_util.o
 
diff -L arch/um/kernel/sys_call_table.c -puN arch/um/kernel/sys_call_table.c~uml-fix-syscall-table-i386 /dev/null
--- linux-2.6.12/arch/um/kernel/sys_call_table.c
+++ /dev/null	2005-04-22 23:47:00.498361144 +0200
@@ -1,270 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Copyright 2003 PathScale, Inc.
- * Licensed under the GPL
- */
-
-#include "linux/config.h"
-#include "linux/unistd.h"
-#include "linux/sys.h"
-#include "linux/swap.h"
-#include "linux/syscalls.h"
-#include "linux/sysctl.h"
-#include "asm/signal.h"
-#include "sysdep/syscalls.h"
-#include "kern_util.h"
-
-#define LAST_GENERIC_SYSCALL __NR_keyctl
-
-#if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
-#define LAST_SYSCALL LAST_GENERIC_SYSCALL
-#else
-#define LAST_SYSCALL LAST_ARCH_SYSCALL
-#endif
-
-extern syscall_handler_t sys_fork;
-extern syscall_handler_t sys_execve;
-extern syscall_handler_t um_time;
-extern syscall_handler_t um_stime;
-extern syscall_handler_t sys_pipe;
-extern syscall_handler_t sys_olduname;
-extern syscall_handler_t sys_sigaction;
-extern syscall_handler_t sys_sigsuspend;
-extern syscall_handler_t old_readdir;
-extern syscall_handler_t sys_uname;
-extern syscall_handler_t sys_ipc;
-extern syscall_handler_t sys_sigreturn;
-extern syscall_handler_t sys_clone;
-extern syscall_handler_t sys_rt_sigreturn;
-extern syscall_handler_t sys_sigaltstack;
-extern syscall_handler_t sys_vfork;
-extern syscall_handler_t old_select;
-extern syscall_handler_t sys_modify_ldt;
-extern syscall_handler_t sys_rt_sigsuspend;
-extern syscall_handler_t sys_mbind;
-extern syscall_handler_t sys_get_mempolicy;
-extern syscall_handler_t sys_set_mempolicy;
-extern syscall_handler_t sys_sys_setaltroot;
-
-syscall_handler_t *sys_call_table[] = {
-	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
-	[ __NR_exit ] = (syscall_handler_t *) sys_exit,
-	[ __NR_fork ] = (syscall_handler_t *) sys_fork,
-	[ __NR_read ] = (syscall_handler_t *) sys_read,
-	[ __NR_write ] = (syscall_handler_t *) sys_write,
-
-	/* These three are declared differently in asm/unistd.h */
-	[ __NR_open ] = (syscall_handler_t *) sys_open,
-	[ __NR_close ] = (syscall_handler_t *) sys_close,
-	[ __NR_creat ] = (syscall_handler_t *) sys_creat,
-	[ __NR_link ] = (syscall_handler_t *) sys_link,
-	[ __NR_unlink ] = (syscall_handler_t *) sys_unlink,
-	[ __NR_execve ] = (syscall_handler_t *) sys_execve,
-
-	/* declared differently in kern_util.h */
-	[ __NR_chdir ] = (syscall_handler_t *) sys_chdir,
-	[ __NR_time ] = um_time,
-	[ __NR_mknod ] = (syscall_handler_t *) sys_mknod,
-	[ __NR_chmod ] = (syscall_handler_t *) sys_chmod,
-	[ __NR_lchown ] = (syscall_handler_t *) sys_lchown16,
-	[ __NR_lseek ] = (syscall_handler_t *) sys_lseek,
-	[ __NR_getpid ] = (syscall_handler_t *) sys_getpid,
-	[ __NR_mount ] = (syscall_handler_t *) sys_mount,
-	[ __NR_setuid ] = (syscall_handler_t *) sys_setuid16,
-	[ __NR_getuid ] = (syscall_handler_t *) sys_getuid16,
- 	[ __NR_ptrace ] = (syscall_handler_t *) sys_ptrace,
-	[ __NR_alarm ] = (syscall_handler_t *) sys_alarm,
-	[ __NR_pause ] = (syscall_handler_t *) sys_pause,
-	[ __NR_utime ] = (syscall_handler_t *) sys_utime,
-	[ __NR_access ] = (syscall_handler_t *) sys_access,
-	[ __NR_sync ] = (syscall_handler_t *) sys_sync,
-	[ __NR_kill ] = (syscall_handler_t *) sys_kill,
-	[ __NR_rename ] = (syscall_handler_t *) sys_rename,
-	[ __NR_mkdir ] = (syscall_handler_t *) sys_mkdir,
-	[ __NR_rmdir ] = (syscall_handler_t *) sys_rmdir,
-
-	/* Declared differently in asm/unistd.h */
-	[ __NR_dup ] = (syscall_handler_t *) sys_dup,
-	[ __NR_pipe ] = (syscall_handler_t *) sys_pipe,
-	[ __NR_times ] = (syscall_handler_t *) sys_times,
-	[ __NR_brk ] = (syscall_handler_t *) sys_brk,
-	[ __NR_setgid ] = (syscall_handler_t *) sys_setgid16,
-	[ __NR_getgid ] = (syscall_handler_t *) sys_getgid16,
-	[ __NR_geteuid ] = (syscall_handler_t *) sys_geteuid16,
-	[ __NR_getegid ] = (syscall_handler_t *) sys_getegid16,
-	[ __NR_acct ] = (syscall_handler_t *) sys_acct,
-	[ __NR_umount2 ] = (syscall_handler_t *) sys_umount,
-	[ __NR_ioctl ] = (syscall_handler_t *) sys_ioctl,
-	[ __NR_fcntl ] = (syscall_handler_t *) sys_fcntl,
-	[ __NR_setpgid ] = (syscall_handler_t *) sys_setpgid,
-	[ __NR_umask ] = (syscall_handler_t *) sys_umask,
-	[ __NR_chroot ] = (syscall_handler_t *) sys_chroot,
-	[ __NR_ustat ] = (syscall_handler_t *) sys_ustat,
-	[ __NR_dup2 ] = (syscall_handler_t *) sys_dup2,
-	[ __NR_getppid ] = (syscall_handler_t *) sys_getppid,
-	[ __NR_getpgrp ] = (syscall_handler_t *) sys_getpgrp,
-	[ __NR_setsid ] = (syscall_handler_t *) sys_setsid,
-	[ __NR_setreuid ] = (syscall_handler_t *) sys_setreuid16,
-	[ __NR_setregid ] = (syscall_handler_t *) sys_setregid16,
-	[ __NR_sethostname ] = (syscall_handler_t *) sys_sethostname,
-	[ __NR_setrlimit ] = (syscall_handler_t *) sys_setrlimit,
-	[ __NR_getrlimit ] = (syscall_handler_t *) sys_old_getrlimit,
-	[ __NR_getrusage ] = (syscall_handler_t *) sys_getrusage,
-	[ __NR_gettimeofday ] = (syscall_handler_t *) sys_gettimeofday,
-	[ __NR_settimeofday ] = (syscall_handler_t *) sys_settimeofday,
-	[ __NR_getgroups ] = (syscall_handler_t *) sys_getgroups16,
-	[ __NR_setgroups ] = (syscall_handler_t *) sys_setgroups16,
-	[ __NR_symlink ] = (syscall_handler_t *) sys_symlink,
-	[ __NR_readlink ] = (syscall_handler_t *) sys_readlink,
-	[ __NR_uselib ] = (syscall_handler_t *) sys_uselib,
-	[ __NR_swapon ] = (syscall_handler_t *) sys_swapon,
-	[ __NR_reboot ] = (syscall_handler_t *) sys_reboot,
-	[ __NR_munmap ] = (syscall_handler_t *) sys_munmap,
-	[ __NR_truncate ] = (syscall_handler_t *) sys_truncate,
-	[ __NR_ftruncate ] = (syscall_handler_t *) sys_ftruncate,
-	[ __NR_fchmod ] = (syscall_handler_t *) sys_fchmod,
-	[ __NR_fchown ] = (syscall_handler_t *) sys_fchown16,
-	[ __NR_getpriority ] = (syscall_handler_t *) sys_getpriority,
-	[ __NR_setpriority ] = (syscall_handler_t *) sys_setpriority,
-	[ __NR_statfs ] = (syscall_handler_t *) sys_statfs,
-	[ __NR_fstatfs ] = (syscall_handler_t *) sys_fstatfs,
-	[ __NR_ioperm ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_syslog ] = (syscall_handler_t *) sys_syslog,
-	[ __NR_setitimer ] = (syscall_handler_t *) sys_setitimer,
-	[ __NR_getitimer ] = (syscall_handler_t *) sys_getitimer,
-	[ __NR_stat ] = (syscall_handler_t *) sys_newstat,
-	[ __NR_lstat ] = (syscall_handler_t *) sys_newlstat,
-	[ __NR_fstat ] = (syscall_handler_t *) sys_newfstat,
-	[ __NR_vhangup ] = (syscall_handler_t *) sys_vhangup,
-	[ __NR_wait4 ] = (syscall_handler_t *) sys_wait4,
-	[ __NR_swapoff ] = (syscall_handler_t *) sys_swapoff,
-	[ __NR_sysinfo ] = (syscall_handler_t *) sys_sysinfo,
-	[ __NR_fsync ] = (syscall_handler_t *) sys_fsync,
-	[ __NR_clone ] = (syscall_handler_t *) sys_clone,
-	[ __NR_setdomainname ] = (syscall_handler_t *) sys_setdomainname,
-	[ __NR_uname ] = (syscall_handler_t *) sys_newuname,
-	[ __NR_adjtimex ] = (syscall_handler_t *) sys_adjtimex,
-	[ __NR_mprotect ] = (syscall_handler_t *) sys_mprotect,
-	[ __NR_create_module ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_init_module ] = (syscall_handler_t *) sys_init_module,
-	[ __NR_delete_module ] = (syscall_handler_t *) sys_delete_module,
-	[ __NR_get_kernel_syms ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_quotactl ] = (syscall_handler_t *) sys_quotactl,
-	[ __NR_getpgid ] = (syscall_handler_t *) sys_getpgid,
-	[ __NR_fchdir ] = (syscall_handler_t *) sys_fchdir,
-	[ __NR_sysfs ] = (syscall_handler_t *) sys_sysfs,
-	[ __NR_personality ] = (syscall_handler_t *) sys_personality,
-	[ __NR_afs_syscall ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_setfsuid ] = (syscall_handler_t *) sys_setfsuid16,
-	[ __NR_setfsgid ] = (syscall_handler_t *) sys_setfsgid16,
-	[ __NR_getdents ] = (syscall_handler_t *) sys_getdents,
-	[ __NR_flock ] = (syscall_handler_t *) sys_flock,
-	[ __NR_msync ] = (syscall_handler_t *) sys_msync,
-	[ __NR_readv ] = (syscall_handler_t *) sys_readv,
-	[ __NR_writev ] = (syscall_handler_t *) sys_writev,
-	[ __NR_getsid ] = (syscall_handler_t *) sys_getsid,
-	[ __NR_fdatasync ] = (syscall_handler_t *) sys_fdatasync,
-	[ __NR__sysctl ] = (syscall_handler_t *) sys_sysctl,
-	[ __NR_mlock ] = (syscall_handler_t *) sys_mlock,
-	[ __NR_munlock ] = (syscall_handler_t *) sys_munlock,
-	[ __NR_mlockall ] = (syscall_handler_t *) sys_mlockall,
-	[ __NR_munlockall ] = (syscall_handler_t *) sys_munlockall,
-	[ __NR_sched_setparam ] = (syscall_handler_t *) sys_sched_setparam,
-	[ __NR_sched_getparam ] = (syscall_handler_t *) sys_sched_getparam,
-	[ __NR_sched_setscheduler ] = (syscall_handler_t *) sys_sched_setscheduler,
-	[ __NR_sched_getscheduler ] = (syscall_handler_t *) sys_sched_getscheduler,
-	[ __NR_sched_yield ] = (syscall_handler_t *) yield,
-	[ __NR_sched_get_priority_max ] = (syscall_handler_t *) sys_sched_get_priority_max,
-	[ __NR_sched_get_priority_min ] = (syscall_handler_t *) sys_sched_get_priority_min,
-	[ __NR_sched_rr_get_interval ] = (syscall_handler_t *) sys_sched_rr_get_interval,
-	[ __NR_nanosleep ] = (syscall_handler_t *) sys_nanosleep,
-	[ __NR_mremap ] = (syscall_handler_t *) sys_mremap,
-	[ __NR_setresuid ] = (syscall_handler_t *) sys_setresuid16,
-	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
-	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
-	[ __NR_nfsservctl ] = (syscall_handler_t *) sys_nfsservctl,
-	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
-	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
-	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
-	[ __NR_rt_sigreturn ] = (syscall_handler_t *) sys_rt_sigreturn,
-	[ __NR_rt_sigaction ] = (syscall_handler_t *) sys_rt_sigaction,
-	[ __NR_rt_sigprocmask ] = (syscall_handler_t *) sys_rt_sigprocmask,
-	[ __NR_rt_sigpending ] = (syscall_handler_t *) sys_rt_sigpending,
-	[ __NR_rt_sigtimedwait ] = (syscall_handler_t *) sys_rt_sigtimedwait,
-	[ __NR_rt_sigqueueinfo ] = (syscall_handler_t *) sys_rt_sigqueueinfo,
-	[ __NR_rt_sigsuspend ] = (syscall_handler_t *) sys_rt_sigsuspend,
-	[ __NR_pread64 ] = (syscall_handler_t *) sys_pread64,
-	[ __NR_pwrite64 ] = (syscall_handler_t *) sys_pwrite64,
-	[ __NR_chown ] = (syscall_handler_t *) sys_chown16,
-	[ __NR_getcwd ] = (syscall_handler_t *) sys_getcwd,
-	[ __NR_capget ] = (syscall_handler_t *) sys_capget,
-	[ __NR_capset ] = (syscall_handler_t *) sys_capset,
-	[ __NR_sigaltstack ] = (syscall_handler_t *) sys_sigaltstack,
-	[ __NR_sendfile ] = (syscall_handler_t *) sys_sendfile,
-	[ __NR_getpmsg ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_putpmsg ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_vfork ] = (syscall_handler_t *) sys_vfork,
-	[ __NR_getdents64 ] = (syscall_handler_t *) sys_getdents64,
-	[ __NR_gettid ] = (syscall_handler_t *) sys_gettid,
-	[ __NR_readahead ] = (syscall_handler_t *) sys_readahead,
-	[ __NR_setxattr ] = (syscall_handler_t *) sys_setxattr,
-	[ __NR_lsetxattr ] = (syscall_handler_t *) sys_lsetxattr,
-	[ __NR_fsetxattr ] = (syscall_handler_t *) sys_fsetxattr,
-	[ __NR_getxattr ] = (syscall_handler_t *) sys_getxattr,
-	[ __NR_lgetxattr ] = (syscall_handler_t *) sys_lgetxattr,
-	[ __NR_fgetxattr ] = (syscall_handler_t *) sys_fgetxattr,
-	[ __NR_listxattr ] = (syscall_handler_t *) sys_listxattr,
-	[ __NR_llistxattr ] = (syscall_handler_t *) sys_llistxattr,
-	[ __NR_flistxattr ] = (syscall_handler_t *) sys_flistxattr,
-	[ __NR_removexattr ] = (syscall_handler_t *) sys_removexattr,
-	[ __NR_lremovexattr ] = (syscall_handler_t *) sys_lremovexattr,
-	[ __NR_fremovexattr ] = (syscall_handler_t *) sys_fremovexattr,
-	[ __NR_tkill ] = (syscall_handler_t *) sys_tkill,
-	[ __NR_futex ] = (syscall_handler_t *) sys_futex,
-	[ __NR_sched_setaffinity ] = (syscall_handler_t *) sys_sched_setaffinity,
-	[ __NR_sched_getaffinity ] = (syscall_handler_t *) sys_sched_getaffinity,
-	[ __NR_io_setup ] = (syscall_handler_t *) sys_io_setup,
-	[ __NR_io_destroy ] = (syscall_handler_t *) sys_io_destroy,
-	[ __NR_io_getevents ] = (syscall_handler_t *) sys_io_getevents,
-	[ __NR_io_submit ] = (syscall_handler_t *) sys_io_submit,
-	[ __NR_io_cancel ] = (syscall_handler_t *) sys_io_cancel,
-	[ __NR_exit_group ] = (syscall_handler_t *) sys_exit_group,
-	[ __NR_lookup_dcookie ] = (syscall_handler_t *) sys_lookup_dcookie,
-	[ __NR_epoll_create ] = (syscall_handler_t *) sys_epoll_create,
-	[ __NR_epoll_ctl ] = (syscall_handler_t *) sys_epoll_ctl,
-	[ __NR_epoll_wait ] = (syscall_handler_t *) sys_epoll_wait,
-	[ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages,
-	[ __NR_set_tid_address ] = (syscall_handler_t *) sys_set_tid_address,
-	[ __NR_timer_create ] = (syscall_handler_t *) sys_timer_create,
-	[ __NR_timer_settime ] = (syscall_handler_t *) sys_timer_settime,
-	[ __NR_timer_gettime ] = (syscall_handler_t *) sys_timer_gettime,
-	[ __NR_timer_getoverrun ] = (syscall_handler_t *) sys_timer_getoverrun,
-	[ __NR_timer_delete ] = (syscall_handler_t *) sys_timer_delete,
-	[ __NR_clock_settime ] = (syscall_handler_t *) sys_clock_settime,
-	[ __NR_clock_gettime ] = (syscall_handler_t *) sys_clock_gettime,
-	[ __NR_clock_getres ] = (syscall_handler_t *) sys_clock_getres,
-	[ __NR_clock_nanosleep ] = (syscall_handler_t *) sys_clock_nanosleep,
-	[ __NR_tgkill ] = (syscall_handler_t *) sys_tgkill,
-	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
-	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_mbind ] = (syscall_handler_t *) sys_mbind,
-	[ __NR_get_mempolicy ] = (syscall_handler_t *) sys_get_mempolicy,
-	[ __NR_set_mempolicy ] = (syscall_handler_t *) sys_set_mempolicy,
-	[ __NR_mq_open ] = (syscall_handler_t *) sys_mq_open,
-	[ __NR_mq_unlink ] = (syscall_handler_t *) sys_mq_unlink,
-	[ __NR_mq_timedsend ] = (syscall_handler_t *) sys_mq_timedsend,
-	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
-	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
-	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-	[ __NR_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
-	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
-	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
-	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
-	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
-
-	ARCH_SYSCALLS
-	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 
-		(syscall_handler_t *) sys_ni_syscall
-};
diff -puN arch/um/sys-i386/Makefile~uml-fix-syscall-table-i386 arch/um/sys-i386/Makefile
--- linux-2.6.12/arch/um/sys-i386/Makefile~uml-fix-syscall-table-i386	2005-04-24 20:17:02.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-i386/Makefile	2005-04-24 20:17:02.000000000 +0200
@@ -1,5 +1,6 @@
 obj-y = bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o
+	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
+	sys_call_table.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
diff -puN /dev/null arch/um/sys-i386/sys_call_table.S
--- /dev/null	2005-04-22 23:47:00.498361144 +0200
+++ linux-2.6.12-paolo/arch/um/sys-i386/sys_call_table.S	2005-04-24 20:17:02.000000000 +0200
@@ -0,0 +1,16 @@
+#include <linux/linkage.h>
+/* Steal i386 syscall table for our purposes, but with some slight changes.*/
+
+#define sys_iopl sys_ni_syscall
+#define sys_ioperm sys_ni_syscall
+
+#define sys_vm86old sys_ni_syscall
+#define sys_vm86 sys_ni_syscall
+#define sys_set_thread_area sys_ni_syscall
+#define sys_get_thread_area sys_ni_syscall
+
+#define sys_stime um_stime
+#define sys_time um_time
+#define old_mmap old_mmap_i386
+
+#include "../../i386/kernel/syscall_table.S"
diff -puN arch/um/sys-x86_64/Makefile~uml-fix-syscall-table-i386 arch/um/sys-x86_64/Makefile
--- linux-2.6.12/arch/um/sys-x86_64/Makefile~uml-fix-syscall-table-i386	2005-04-24 20:17:02.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/Makefile	2005-04-24 20:17:02.000000000 +0200
@@ -6,7 +6,7 @@
 
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
 	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o \
-	syscalls.o sysrq.o thunk.o
+	syscalls.o sysrq.o thunk.o sys_call_table.o
 
 USER_OBJS := ptrace_user.o sigcontext.o
 
diff -puN /dev/null arch/um/sys-x86_64/sys_call_table.c
--- /dev/null	2005-04-22 23:47:00.498361144 +0200
+++ linux-2.6.12-paolo/arch/um/sys-x86_64/sys_call_table.c	2005-04-24 20:17:02.000000000 +0200
@@ -0,0 +1,276 @@
+/*
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
+ * Licensed under the GPL
+ */
+
+#include "linux/config.h"
+#include "linux/unistd.h"
+#include "linux/sys.h"
+#include "linux/swap.h"
+#include "linux/syscalls.h"
+#include "linux/sysctl.h"
+#include "asm/signal.h"
+#include "sysdep/syscalls.h"
+#include "kern_util.h"
+
+#ifdef CONFIG_NFSD
+#define NFSSERVCTL sys_nfsservctl
+#else
+#define NFSSERVCTL sys_ni_syscall
+#endif
+
+#define LAST_GENERIC_SYSCALL __NR_keyctl
+
+#if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
+#define LAST_SYSCALL LAST_GENERIC_SYSCALL
+#else
+#define LAST_SYSCALL LAST_ARCH_SYSCALL
+#endif
+
+extern syscall_handler_t sys_fork;
+extern syscall_handler_t sys_execve;
+extern syscall_handler_t um_time;
+extern syscall_handler_t um_stime;
+extern syscall_handler_t sys_pipe;
+extern syscall_handler_t sys_olduname;
+extern syscall_handler_t sys_sigaction;
+extern syscall_handler_t sys_sigsuspend;
+extern syscall_handler_t old_readdir;
+extern syscall_handler_t sys_uname;
+extern syscall_handler_t sys_ipc;
+extern syscall_handler_t sys_sigreturn;
+extern syscall_handler_t sys_clone;
+extern syscall_handler_t sys_rt_sigreturn;
+extern syscall_handler_t sys_sigaltstack;
+extern syscall_handler_t sys_vfork;
+extern syscall_handler_t old_select;
+extern syscall_handler_t sys_modify_ldt;
+extern syscall_handler_t sys_rt_sigsuspend;
+extern syscall_handler_t sys_mbind;
+extern syscall_handler_t sys_get_mempolicy;
+extern syscall_handler_t sys_set_mempolicy;
+extern syscall_handler_t sys_sys_setaltroot;
+
+syscall_handler_t *sys_call_table[] = {
+	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
+	[ __NR_exit ] = (syscall_handler_t *) sys_exit,
+	[ __NR_fork ] = (syscall_handler_t *) sys_fork,
+	[ __NR_read ] = (syscall_handler_t *) sys_read,
+	[ __NR_write ] = (syscall_handler_t *) sys_write,
+
+	/* These three are declared differently in asm/unistd.h */
+	[ __NR_open ] = (syscall_handler_t *) sys_open,
+	[ __NR_close ] = (syscall_handler_t *) sys_close,
+	[ __NR_creat ] = (syscall_handler_t *) sys_creat,
+	[ __NR_link ] = (syscall_handler_t *) sys_link,
+	[ __NR_unlink ] = (syscall_handler_t *) sys_unlink,
+	[ __NR_execve ] = (syscall_handler_t *) sys_execve,
+
+	/* declared differently in kern_util.h */
+	[ __NR_chdir ] = (syscall_handler_t *) sys_chdir,
+	[ __NR_time ] = um_time,
+	[ __NR_mknod ] = (syscall_handler_t *) sys_mknod,
+	[ __NR_chmod ] = (syscall_handler_t *) sys_chmod,
+	[ __NR_lchown ] = (syscall_handler_t *) sys_lchown16,
+	[ __NR_lseek ] = (syscall_handler_t *) sys_lseek,
+	[ __NR_getpid ] = (syscall_handler_t *) sys_getpid,
+	[ __NR_mount ] = (syscall_handler_t *) sys_mount,
+	[ __NR_setuid ] = (syscall_handler_t *) sys_setuid16,
+	[ __NR_getuid ] = (syscall_handler_t *) sys_getuid16,
+ 	[ __NR_ptrace ] = (syscall_handler_t *) sys_ptrace,
+	[ __NR_alarm ] = (syscall_handler_t *) sys_alarm,
+	[ __NR_pause ] = (syscall_handler_t *) sys_pause,
+	[ __NR_utime ] = (syscall_handler_t *) sys_utime,
+	[ __NR_access ] = (syscall_handler_t *) sys_access,
+	[ __NR_sync ] = (syscall_handler_t *) sys_sync,
+	[ __NR_kill ] = (syscall_handler_t *) sys_kill,
+	[ __NR_rename ] = (syscall_handler_t *) sys_rename,
+	[ __NR_mkdir ] = (syscall_handler_t *) sys_mkdir,
+	[ __NR_rmdir ] = (syscall_handler_t *) sys_rmdir,
+
+	/* Declared differently in asm/unistd.h */
+	[ __NR_dup ] = (syscall_handler_t *) sys_dup,
+	[ __NR_pipe ] = (syscall_handler_t *) sys_pipe,
+	[ __NR_times ] = (syscall_handler_t *) sys_times,
+	[ __NR_brk ] = (syscall_handler_t *) sys_brk,
+	[ __NR_setgid ] = (syscall_handler_t *) sys_setgid16,
+	[ __NR_getgid ] = (syscall_handler_t *) sys_getgid16,
+	[ __NR_geteuid ] = (syscall_handler_t *) sys_geteuid16,
+	[ __NR_getegid ] = (syscall_handler_t *) sys_getegid16,
+	[ __NR_acct ] = (syscall_handler_t *) sys_acct,
+	[ __NR_umount2 ] = (syscall_handler_t *) sys_umount,
+	[ __NR_ioctl ] = (syscall_handler_t *) sys_ioctl,
+	[ __NR_fcntl ] = (syscall_handler_t *) sys_fcntl,
+	[ __NR_setpgid ] = (syscall_handler_t *) sys_setpgid,
+	[ __NR_umask ] = (syscall_handler_t *) sys_umask,
+	[ __NR_chroot ] = (syscall_handler_t *) sys_chroot,
+	[ __NR_ustat ] = (syscall_handler_t *) sys_ustat,
+	[ __NR_dup2 ] = (syscall_handler_t *) sys_dup2,
+	[ __NR_getppid ] = (syscall_handler_t *) sys_getppid,
+	[ __NR_getpgrp ] = (syscall_handler_t *) sys_getpgrp,
+	[ __NR_setsid ] = (syscall_handler_t *) sys_setsid,
+	[ __NR_setreuid ] = (syscall_handler_t *) sys_setreuid16,
+	[ __NR_setregid ] = (syscall_handler_t *) sys_setregid16,
+	[ __NR_sethostname ] = (syscall_handler_t *) sys_sethostname,
+	[ __NR_setrlimit ] = (syscall_handler_t *) sys_setrlimit,
+	[ __NR_getrlimit ] = (syscall_handler_t *) sys_old_getrlimit,
+	[ __NR_getrusage ] = (syscall_handler_t *) sys_getrusage,
+	[ __NR_gettimeofday ] = (syscall_handler_t *) sys_gettimeofday,
+	[ __NR_settimeofday ] = (syscall_handler_t *) sys_settimeofday,
+	[ __NR_getgroups ] = (syscall_handler_t *) sys_getgroups16,
+	[ __NR_setgroups ] = (syscall_handler_t *) sys_setgroups16,
+	[ __NR_symlink ] = (syscall_handler_t *) sys_symlink,
+	[ __NR_readlink ] = (syscall_handler_t *) sys_readlink,
+	[ __NR_uselib ] = (syscall_handler_t *) sys_uselib,
+	[ __NR_swapon ] = (syscall_handler_t *) sys_swapon,
+	[ __NR_reboot ] = (syscall_handler_t *) sys_reboot,
+	[ __NR_munmap ] = (syscall_handler_t *) sys_munmap,
+	[ __NR_truncate ] = (syscall_handler_t *) sys_truncate,
+	[ __NR_ftruncate ] = (syscall_handler_t *) sys_ftruncate,
+	[ __NR_fchmod ] = (syscall_handler_t *) sys_fchmod,
+	[ __NR_fchown ] = (syscall_handler_t *) sys_fchown16,
+	[ __NR_getpriority ] = (syscall_handler_t *) sys_getpriority,
+	[ __NR_setpriority ] = (syscall_handler_t *) sys_setpriority,
+	[ __NR_statfs ] = (syscall_handler_t *) sys_statfs,
+	[ __NR_fstatfs ] = (syscall_handler_t *) sys_fstatfs,
+	[ __NR_ioperm ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_syslog ] = (syscall_handler_t *) sys_syslog,
+	[ __NR_setitimer ] = (syscall_handler_t *) sys_setitimer,
+	[ __NR_getitimer ] = (syscall_handler_t *) sys_getitimer,
+	[ __NR_stat ] = (syscall_handler_t *) sys_newstat,
+	[ __NR_lstat ] = (syscall_handler_t *) sys_newlstat,
+	[ __NR_fstat ] = (syscall_handler_t *) sys_newfstat,
+	[ __NR_vhangup ] = (syscall_handler_t *) sys_vhangup,
+	[ __NR_wait4 ] = (syscall_handler_t *) sys_wait4,
+	[ __NR_swapoff ] = (syscall_handler_t *) sys_swapoff,
+	[ __NR_sysinfo ] = (syscall_handler_t *) sys_sysinfo,
+	[ __NR_fsync ] = (syscall_handler_t *) sys_fsync,
+	[ __NR_clone ] = (syscall_handler_t *) sys_clone,
+	[ __NR_setdomainname ] = (syscall_handler_t *) sys_setdomainname,
+	[ __NR_uname ] = (syscall_handler_t *) sys_newuname,
+	[ __NR_adjtimex ] = (syscall_handler_t *) sys_adjtimex,
+	[ __NR_mprotect ] = (syscall_handler_t *) sys_mprotect,
+	[ __NR_create_module ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_init_module ] = (syscall_handler_t *) sys_init_module,
+	[ __NR_delete_module ] = (syscall_handler_t *) sys_delete_module,
+	[ __NR_get_kernel_syms ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_quotactl ] = (syscall_handler_t *) sys_quotactl,
+	[ __NR_getpgid ] = (syscall_handler_t *) sys_getpgid,
+	[ __NR_fchdir ] = (syscall_handler_t *) sys_fchdir,
+	[ __NR_sysfs ] = (syscall_handler_t *) sys_sysfs,
+	[ __NR_personality ] = (syscall_handler_t *) sys_personality,
+	[ __NR_afs_syscall ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_setfsuid ] = (syscall_handler_t *) sys_setfsuid16,
+	[ __NR_setfsgid ] = (syscall_handler_t *) sys_setfsgid16,
+	[ __NR_getdents ] = (syscall_handler_t *) sys_getdents,
+	[ __NR_flock ] = (syscall_handler_t *) sys_flock,
+	[ __NR_msync ] = (syscall_handler_t *) sys_msync,
+	[ __NR_readv ] = (syscall_handler_t *) sys_readv,
+	[ __NR_writev ] = (syscall_handler_t *) sys_writev,
+	[ __NR_getsid ] = (syscall_handler_t *) sys_getsid,
+	[ __NR_fdatasync ] = (syscall_handler_t *) sys_fdatasync,
+	[ __NR__sysctl ] = (syscall_handler_t *) sys_sysctl,
+	[ __NR_mlock ] = (syscall_handler_t *) sys_mlock,
+	[ __NR_munlock ] = (syscall_handler_t *) sys_munlock,
+	[ __NR_mlockall ] = (syscall_handler_t *) sys_mlockall,
+	[ __NR_munlockall ] = (syscall_handler_t *) sys_munlockall,
+	[ __NR_sched_setparam ] = (syscall_handler_t *) sys_sched_setparam,
+	[ __NR_sched_getparam ] = (syscall_handler_t *) sys_sched_getparam,
+	[ __NR_sched_setscheduler ] = (syscall_handler_t *) sys_sched_setscheduler,
+	[ __NR_sched_getscheduler ] = (syscall_handler_t *) sys_sched_getscheduler,
+	[ __NR_sched_yield ] = (syscall_handler_t *) yield,
+	[ __NR_sched_get_priority_max ] = (syscall_handler_t *) sys_sched_get_priority_max,
+	[ __NR_sched_get_priority_min ] = (syscall_handler_t *) sys_sched_get_priority_min,
+	[ __NR_sched_rr_get_interval ] = (syscall_handler_t *) sys_sched_rr_get_interval,
+	[ __NR_nanosleep ] = (syscall_handler_t *) sys_nanosleep,
+	[ __NR_mremap ] = (syscall_handler_t *) sys_mremap,
+	[ __NR_setresuid ] = (syscall_handler_t *) sys_setresuid16,
+	[ __NR_getresuid ] = (syscall_handler_t *) sys_getresuid16,
+	[ __NR_query_module ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_poll ] = (syscall_handler_t *) sys_poll,
+	[ __NR_nfsservctl ] = (syscall_handler_t *) NFSSERVCTL,
+	[ __NR_setresgid ] = (syscall_handler_t *) sys_setresgid16,
+	[ __NR_getresgid ] = (syscall_handler_t *) sys_getresgid16,
+	[ __NR_prctl ] = (syscall_handler_t *) sys_prctl,
+	[ __NR_rt_sigreturn ] = (syscall_handler_t *) sys_rt_sigreturn,
+	[ __NR_rt_sigaction ] = (syscall_handler_t *) sys_rt_sigaction,
+	[ __NR_rt_sigprocmask ] = (syscall_handler_t *) sys_rt_sigprocmask,
+	[ __NR_rt_sigpending ] = (syscall_handler_t *) sys_rt_sigpending,
+	[ __NR_rt_sigtimedwait ] = (syscall_handler_t *) sys_rt_sigtimedwait,
+	[ __NR_rt_sigqueueinfo ] = (syscall_handler_t *) sys_rt_sigqueueinfo,
+	[ __NR_rt_sigsuspend ] = (syscall_handler_t *) sys_rt_sigsuspend,
+	[ __NR_pread64 ] = (syscall_handler_t *) sys_pread64,
+	[ __NR_pwrite64 ] = (syscall_handler_t *) sys_pwrite64,
+	[ __NR_chown ] = (syscall_handler_t *) sys_chown16,
+	[ __NR_getcwd ] = (syscall_handler_t *) sys_getcwd,
+	[ __NR_capget ] = (syscall_handler_t *) sys_capget,
+	[ __NR_capset ] = (syscall_handler_t *) sys_capset,
+	[ __NR_sigaltstack ] = (syscall_handler_t *) sys_sigaltstack,
+	[ __NR_sendfile ] = (syscall_handler_t *) sys_sendfile,
+	[ __NR_getpmsg ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_putpmsg ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_vfork ] = (syscall_handler_t *) sys_vfork,
+	[ __NR_getdents64 ] = (syscall_handler_t *) sys_getdents64,
+	[ __NR_gettid ] = (syscall_handler_t *) sys_gettid,
+	[ __NR_readahead ] = (syscall_handler_t *) sys_readahead,
+	[ __NR_setxattr ] = (syscall_handler_t *) sys_setxattr,
+	[ __NR_lsetxattr ] = (syscall_handler_t *) sys_lsetxattr,
+	[ __NR_fsetxattr ] = (syscall_handler_t *) sys_fsetxattr,
+	[ __NR_getxattr ] = (syscall_handler_t *) sys_getxattr,
+	[ __NR_lgetxattr ] = (syscall_handler_t *) sys_lgetxattr,
+	[ __NR_fgetxattr ] = (syscall_handler_t *) sys_fgetxattr,
+	[ __NR_listxattr ] = (syscall_handler_t *) sys_listxattr,
+	[ __NR_llistxattr ] = (syscall_handler_t *) sys_llistxattr,
+	[ __NR_flistxattr ] = (syscall_handler_t *) sys_flistxattr,
+	[ __NR_removexattr ] = (syscall_handler_t *) sys_removexattr,
+	[ __NR_lremovexattr ] = (syscall_handler_t *) sys_lremovexattr,
+	[ __NR_fremovexattr ] = (syscall_handler_t *) sys_fremovexattr,
+	[ __NR_tkill ] = (syscall_handler_t *) sys_tkill,
+	[ __NR_futex ] = (syscall_handler_t *) sys_futex,
+	[ __NR_sched_setaffinity ] = (syscall_handler_t *) sys_sched_setaffinity,
+	[ __NR_sched_getaffinity ] = (syscall_handler_t *) sys_sched_getaffinity,
+	[ __NR_io_setup ] = (syscall_handler_t *) sys_io_setup,
+	[ __NR_io_destroy ] = (syscall_handler_t *) sys_io_destroy,
+	[ __NR_io_getevents ] = (syscall_handler_t *) sys_io_getevents,
+	[ __NR_io_submit ] = (syscall_handler_t *) sys_io_submit,
+	[ __NR_io_cancel ] = (syscall_handler_t *) sys_io_cancel,
+	[ __NR_exit_group ] = (syscall_handler_t *) sys_exit_group,
+	[ __NR_lookup_dcookie ] = (syscall_handler_t *) sys_lookup_dcookie,
+	[ __NR_epoll_create ] = (syscall_handler_t *) sys_epoll_create,
+	[ __NR_epoll_ctl ] = (syscall_handler_t *) sys_epoll_ctl,
+	[ __NR_epoll_wait ] = (syscall_handler_t *) sys_epoll_wait,
+	[ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages,
+	[ __NR_set_tid_address ] = (syscall_handler_t *) sys_set_tid_address,
+	[ __NR_timer_create ] = (syscall_handler_t *) sys_timer_create,
+	[ __NR_timer_settime ] = (syscall_handler_t *) sys_timer_settime,
+	[ __NR_timer_gettime ] = (syscall_handler_t *) sys_timer_gettime,
+	[ __NR_timer_getoverrun ] = (syscall_handler_t *) sys_timer_getoverrun,
+	[ __NR_timer_delete ] = (syscall_handler_t *) sys_timer_delete,
+	[ __NR_clock_settime ] = (syscall_handler_t *) sys_clock_settime,
+	[ __NR_clock_gettime ] = (syscall_handler_t *) sys_clock_gettime,
+	[ __NR_clock_getres ] = (syscall_handler_t *) sys_clock_getres,
+	[ __NR_clock_nanosleep ] = (syscall_handler_t *) sys_clock_nanosleep,
+	[ __NR_tgkill ] = (syscall_handler_t *) sys_tgkill,
+	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes,
+	[ __NR_fadvise64 ] = (syscall_handler_t *) sys_fadvise64,
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_mbind ] = (syscall_handler_t *) sys_mbind,
+	[ __NR_get_mempolicy ] = (syscall_handler_t *) sys_get_mempolicy,
+	[ __NR_set_mempolicy ] = (syscall_handler_t *) sys_set_mempolicy,
+	[ __NR_mq_open ] = (syscall_handler_t *) sys_mq_open,
+	[ __NR_mq_unlink ] = (syscall_handler_t *) sys_mq_unlink,
+	[ __NR_mq_timedsend ] = (syscall_handler_t *) sys_mq_timedsend,
+	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
+	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
+	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
+	[ __NR_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
+	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
+	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
+	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
+
+	ARCH_SYSCALLS
+	[ LAST_SYSCALL + 1 ... NR_syscalls ] =
+		(syscall_handler_t *) sys_ni_syscall
+};
_
