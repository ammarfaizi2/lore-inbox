Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbUKHPWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUKHPWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 10:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUKHPWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 10:22:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261878AbUKHOf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:57 -0500
Date: Mon, 8 Nov 2004 14:34:19 GMT
Message-Id: <200411081434.iA8EYJs4023595@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 15/20] FRV: Fujitsu FR-V arch include files
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides the arch-specific include files for the Fujitsu
FR-V CPU arch.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-include_4-2610rc1mm3.diff
 asm-frv/unaligned.h   |  203 ++++++++++++++++++++
 asm-frv/unistd.h      |  491 ++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-frv/user.h        |   80 ++++++++
 asm-frv/virtconvert.h |   42 ++++
 linux/elf.h           |    7 
 linux/suspend.h       |    2 
 6 files changed, 822 insertions(+), 3 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/unaligned.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/unaligned.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/unaligned.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/unaligned.h	2004-11-05 14:13:04.310461399 +0000
@@ -0,0 +1,203 @@
+/* unaligned.h: unaligned access handler
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_UNALIGNED_H
+#define _ASM_UNALIGNED_H
+
+#include <linux/config.h>
+
+/*
+ * Unaligned accesses on uClinux can't be performed in a fault handler - the
+ * CPU detects them as imprecise exceptions making this impossible.
+ *
+ * With the FR451, however, they are precise, and so we used to fix them up in
+ * the memory access fault handler.  However, instruction bundling make this
+ * impractical.  So, now we fall back to using memcpy.
+ */
+#ifdef CONFIG_MMU
+
+/*
+ * The asm statement in the macros below is a way to get GCC to copy a
+ * value from one variable to another without having any clue it's
+ * actually doing so, so that it won't have any idea that the values
+ * in the two variables are related.
+ */
+
+#define get_unaligned(ptr) ({				\
+	typeof((*(ptr))) __x;				\
+	void *__ptrcopy;				\
+	asm("" : "=r" (__ptrcopy) : "0" (ptr));		\
+	memcpy(&__x, __ptrcopy, sizeof(*(ptr)));	\
+	__x;						\
+})
+
+#define put_unaligned(val, ptr) ({			\
+	typeof((*(ptr))) __x = (val);			\
+	void *__ptrcopy;				\
+	asm("" : "=r" (__ptrcopy) : "0" (ptr));		\
+	memcpy(__ptrcopy, &__x, sizeof(*(ptr)));	\
+})
+
+extern int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned long epcr0);
+
+#else
+
+#define get_unaligned(ptr)							\
+({										\
+	typeof(*(ptr)) x;							\
+	const char *__p = (const char *) (ptr);					\
+										\
+	switch (sizeof(x)) {							\
+	case 1:									\
+		x = *(ptr);							\
+		break;								\
+	case 2:									\
+	{									\
+		uint8_t a;							\
+		asm("	ldub%I2		%M2,%0		\n"			\
+		    "	ldub%I3.p	%M3,%1		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%1,%0	\n"			\
+		    : "=&r"(x), "=&r"(a)					\
+		    : "m"(__p[0]),  "m"(__p[1])					\
+		    );								\
+		break;								\
+	}									\
+										\
+	case 4:									\
+	{									\
+		uint8_t a;							\
+		asm("	ldub%I2		%M2,%0		\n"			\
+		    "	ldub%I3.p	%M3,%1		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%1,%0	\n"			\
+		    "	ldub%I4.p	%M4,%1		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%1,%0	\n"			\
+		    "	ldub%I5.p	%M5,%1		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%1,%0	\n"			\
+		    : "=&r"(x), "=&r"(a)					\
+		    : "m"(__p[0]),  "m"(__p[1]), "m"(__p[2]), "m"(__p[3])	\
+		    );								\
+		break;								\
+	}									\
+										\
+	case 8:									\
+	{									\
+		union { uint64_t x; u32 y[2]; } z;				\
+		uint8_t a;							\
+		asm("	ldub%I3		%M3,%0		\n"			\
+		    "	ldub%I4.p	%M4,%2		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%2,%0	\n"			\
+		    "	ldub%I5.p	%M5,%2		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%2,%0	\n"			\
+		    "	ldub%I6.p	%M6,%2		\n"			\
+		    "	slli		%0,#8,%0	\n"			\
+		    "	or		%0,%2,%0	\n"			\
+		    "	ldub%I7		%M7,%1		\n"			\
+		    "	ldub%I8.p	%M8,%2		\n"			\
+		    "	slli		%1,#8,%1	\n"			\
+		    "	or		%1,%2,%1	\n"			\
+		    "	ldub%I9.p	%M9,%2		\n"			\
+		    "	slli		%1,#8,%1	\n"			\
+		    "	or		%1,%2,%1	\n"			\
+		    "	ldub%I10.p	%M10,%2		\n"			\
+		    "	slli		%1,#8,%1	\n"			\
+		    "	or		%1,%2,%1	\n"			\
+		    : "=&r"(z.y[0]), "=&r"(z.y[1]), "=&r"(a)			\
+		    : "m"(__p[0]), "m"(__p[1]), "m"(__p[2]), "m"(__p[3]),	\
+		      "m"(__p[4]), "m"(__p[5]), "m"(__p[6]), "m"(__p[7])	\
+		    );								\
+		x = z.x;							\
+		break;								\
+	}									\
+										\
+	default:								\
+		x = 0;								\
+		BUG();								\
+		break;								\
+	}									\
+										\
+	x;									\
+})
+
+#define put_unaligned(val, ptr)								\
+do {											\
+	char *__p = (char *) (ptr);							\
+	int x;										\
+											\
+	switch (sizeof(*ptr)) {								\
+	case 2:										\
+	{										\
+		asm("	stb%I1.p	%0,%M1		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I2		%0,%M2		\n"				\
+		    : "=r"(x), "=m"(__p[1]),  "=m"(__p[0])				\
+		    : "0"(val)								\
+		    );									\
+		break;									\
+	}										\
+											\
+	case 4:										\
+	{										\
+		asm("	stb%I1.p	%0,%M1		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I2.p	%0,%M2		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I3.p	%0,%M3		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I4		%0,%M4		\n"				\
+		    : "=r"(x), "=m"(__p[3]),  "=m"(__p[2]), "=m"(__p[1]), "=m"(__p[0])	\
+		    : "0"(val)								\
+		    );									\
+		break;									\
+	}										\
+											\
+	case 8:										\
+	{										\
+		uint32_t __high, __low;							\
+		__high = (uint64_t)val >> 32;						\
+		__low = val & 0xffffffff;						\
+		asm("	stb%I2.p	%0,%M2		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I3.p	%0,%M3		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I4.p	%0,%M4		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I5.p	%0,%M5		\n"				\
+		    "	srli		%0,#8,%0	\n"				\
+		    "	stb%I6.p	%1,%M6		\n"				\
+		    "	srli		%1,#8,%1	\n"				\
+		    "	stb%I7.p	%1,%M7		\n"				\
+		    "	srli		%1,#8,%1	\n"				\
+		    "	stb%I8.p	%1,%M8		\n"				\
+		    "	srli		%1,#8,%1	\n"				\
+		    "	stb%I9		%1,%M9		\n"				\
+		    : "=&r"(__low), "=&r"(__high), "=m"(__p[7]), "=m"(__p[6]), 		\
+		      "=m"(__p[5]), "=m"(__p[4]), "=m"(__p[3]), "=m"(__p[2]), 		\
+		      "=m"(__p[1]), "=m"(__p[0])					\
+		    : "0"(__low), "1"(__high)						\
+		    );									\
+		break;									\
+	}										\
+											\
+        default:									\
+		*(ptr) = (val);								\
+		break;									\
+	}										\
+} while(0)
+
+#endif
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/unistd.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/unistd.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/unistd.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/unistd.h	2004-11-05 14:13:04.315460977 +0000
@@ -0,0 +1,491 @@
+#ifndef _ASM_UNISTD_H_
+#define _ASM_UNISTD_H_
+
+/*
+ * This file contains the system call numbers.
+ */
+
+#define __NR_restart_syscall      0
+#define __NR_exit		  1
+#define __NR_fork		  2
+#define __NR_read		  3
+#define __NR_write		  4
+#define __NR_open		  5
+#define __NR_close		  6
+#define __NR_waitpid		  7
+#define __NR_creat		  8
+#define __NR_link		  9
+#define __NR_unlink		 10
+#define __NR_execve		 11
+#define __NR_chdir		 12
+#define __NR_time		 13
+#define __NR_mknod		 14
+#define __NR_chmod		 15
+#define __NR_lchown		 16
+#define __NR_break		 17
+#define __NR_oldstat		 18
+#define __NR_lseek		 19
+#define __NR_getpid		 20
+#define __NR_mount		 21
+#define __NR_umount		 22
+#define __NR_setuid		 23
+#define __NR_getuid		 24
+#define __NR_stime		 25
+#define __NR_ptrace		 26
+#define __NR_alarm		 27
+#define __NR_oldfstat		 28
+#define __NR_pause		 29
+#define __NR_utime		 30
+#define __NR_stty		 31
+#define __NR_gtty		 32
+#define __NR_access		 33
+#define __NR_nice		 34
+#define __NR_ftime		 35
+#define __NR_sync		 36
+#define __NR_kill		 37
+#define __NR_rename		 38
+#define __NR_mkdir		 39
+#define __NR_rmdir		 40
+#define __NR_dup		 41
+#define __NR_pipe		 42
+#define __NR_times		 43
+#define __NR_prof		 44
+#define __NR_brk		 45
+#define __NR_setgid		 46
+#define __NR_getgid		 47
+#define __NR_signal		 48
+#define __NR_geteuid		 49
+#define __NR_getegid		 50
+#define __NR_acct		 51
+#define __NR_umount2		 52
+#define __NR_lock		 53
+#define __NR_ioctl		 54
+#define __NR_fcntl		 55
+#define __NR_mpx		 56
+#define __NR_setpgid		 57
+#define __NR_ulimit		 58
+// #define __NR_oldolduname	 /* 59 */ obsolete
+#define __NR_umask		 60
+#define __NR_chroot		 61
+#define __NR_ustat		 62
+#define __NR_dup2		 63
+#define __NR_getppid		 64
+#define __NR_getpgrp		 65
+#define __NR_setsid		 66
+#define __NR_sigaction		 67
+#define __NR_sgetmask		 68
+#define __NR_ssetmask		 69
+#define __NR_setreuid		 70
+#define __NR_setregid		 71
+#define __NR_sigsuspend		 72
+#define __NR_sigpending		 73
+#define __NR_sethostname	 74
+#define __NR_setrlimit		 75
+#define __NR_getrlimit		 76	/* Back compatible 2Gig limited rlimit */
+#define __NR_getrusage		 77
+#define __NR_gettimeofday	 78
+#define __NR_settimeofday	 79
+#define __NR_getgroups		 80
+#define __NR_setgroups		 81
+#define __NR_select		 82
+#define __NR_symlink		 83
+#define __NR_oldlstat		 84
+#define __NR_readlink		 85
+#define __NR_uselib		 86
+#define __NR_swapon		 87
+#define __NR_reboot		 88
+#define __NR_readdir		 89
+// #define __NR_mmap		 90	/* obsolete - not implemented */
+#define __NR_munmap		 91
+#define __NR_truncate		 92
+#define __NR_ftruncate		 93
+#define __NR_fchmod		 94
+#define __NR_fchown		 95
+#define __NR_getpriority	 96
+#define __NR_setpriority	 97
+// #define __NR_profil		 /* 98 */ obsolete
+#define __NR_statfs		 99
+#define __NR_fstatfs		100
+// #define __NR_ioperm		/* 101 */ not supported
+#define __NR_socketcall		102
+#define __NR_syslog		103
+#define __NR_setitimer		104
+#define __NR_getitimer		105
+#define __NR_stat		106
+#define __NR_lstat		107
+#define __NR_fstat		108
+// #define __NR_olduname		/* 109 */ obsolete
+// #define __NR_iopl		/* 110 */ not supported
+#define __NR_vhangup		111
+// #define __NR_idle		/* 112 */ Obsolete
+// #define __NR_vm86old		/* 113 */ not supported
+#define __NR_wait4		114
+#define __NR_swapoff		115
+#define __NR_sysinfo		116
+#define __NR_ipc		117
+#define __NR_fsync		118
+#define __NR_sigreturn		119
+#define __NR_clone		120
+#define __NR_setdomainname	121
+#define __NR_uname		122
+// #define __NR_modify_ldt	/* 123 */ not supported
+#define __NR_cacheflush		123
+#define __NR_adjtimex		124
+#define __NR_mprotect		125
+#define __NR_sigprocmask	126
+#define __NR_create_module	127
+#define __NR_init_module	128
+#define __NR_delete_module	129
+#define __NR_get_kernel_syms	130
+#define __NR_quotactl		131
+#define __NR_getpgid		132
+#define __NR_fchdir		133
+#define __NR_bdflush		134
+#define __NR_sysfs		135
+#define __NR_personality	136
+#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
+#define __NR_setfsuid		138
+#define __NR_setfsgid		139
+#define __NR__llseek		140
+#define __NR_getdents		141
+#define __NR__newselect		142
+#define __NR_flock		143
+#define __NR_msync		144
+#define __NR_readv		145
+#define __NR_writev		146
+#define __NR_getsid		147
+#define __NR_fdatasync		148
+#define __NR__sysctl		149
+#define __NR_mlock		150
+#define __NR_munlock		151
+#define __NR_mlockall		152
+#define __NR_munlockall		153
+#define __NR_sched_setparam		154
+#define __NR_sched_getparam		155
+#define __NR_sched_setscheduler		156
+#define __NR_sched_getscheduler		157
+#define __NR_sched_yield		158
+#define __NR_sched_get_priority_max	159
+#define __NR_sched_get_priority_min	160
+#define __NR_sched_rr_get_interval	161
+#define __NR_nanosleep		162
+#define __NR_mremap		163
+#define __NR_setresuid		164
+#define __NR_getresuid		165
+// #define __NR_vm86		/* 166 */ not supported
+#define __NR_query_module	167
+#define __NR_poll		168
+#define __NR_nfsservctl		169
+#define __NR_setresgid		170
+#define __NR_getresgid		171
+#define __NR_prctl		172
+#define __NR_rt_sigreturn	173
+#define __NR_rt_sigaction	174
+#define __NR_rt_sigprocmask	175
+#define __NR_rt_sigpending	176
+#define __NR_rt_sigtimedwait	177
+#define __NR_rt_sigqueueinfo	178
+#define __NR_rt_sigsuspend	179
+#define __NR_pread		180
+#define __NR_pwrite		181
+#define __NR_chown		182
+#define __NR_getcwd		183
+#define __NR_capget		184
+#define __NR_capset		185
+#define __NR_sigaltstack	186
+#define __NR_sendfile		187
+#define __NR_getpmsg		188	/* some people actually want streams */
+#define __NR_putpmsg		189	/* some people actually want streams */
+#define __NR_vfork		190
+#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
+#define __NR_mmap2		192
+#define __NR_truncate64		193
+#define __NR_ftruncate64	194
+#define __NR_stat64		195
+#define __NR_lstat64		196
+#define __NR_fstat64		197
+#define __NR_lchown32		198
+#define __NR_getuid32		199
+#define __NR_getgid32		200
+#define __NR_geteuid32		201
+#define __NR_getegid32		202
+#define __NR_setreuid32		203
+#define __NR_setregid32		204
+#define __NR_getgroups32	205
+#define __NR_setgroups32	206
+#define __NR_fchown32		207
+#define __NR_setresuid32	208
+#define __NR_getresuid32	209
+#define __NR_setresgid32	210
+#define __NR_getresgid32	211
+#define __NR_chown32		212
+#define __NR_setuid32		213
+#define __NR_setgid32		214
+#define __NR_setfsuid32		215
+#define __NR_setfsgid32		216
+#define __NR_pivot_root		217
+#define __NR_mincore		218
+#define __NR_madvise		219
+
+#define __NR_getdents64		220
+#define __NR_fcntl64		221
+#define __NR_security		223	/* syscall for security modules */
+#define __NR_gettid		224
+#define __NR_readahead		225
+#define __NR_setxattr		226
+#define __NR_lsetxattr		227
+#define __NR_fsetxattr		228
+#define __NR_getxattr		229
+#define __NR_lgetxattr		230
+#define __NR_fgetxattr		231
+#define __NR_listxattr		232
+#define __NR_llistxattr		233
+#define __NR_flistxattr		234
+#define __NR_removexattr	235
+#define __NR_lremovexattr	236
+#define __NR_fremovexattr	237
+#define __NR_tkill		238
+#define __NR_sendfile64		239
+#define __NR_futex		240
+#define __NR_sched_setaffinity	241
+#define __NR_sched_getaffinity	242
+#define __NR_set_thread_area	243
+#define __NR_get_thread_area	244
+#define __NR_io_setup		245
+#define __NR_io_destroy		246
+#define __NR_io_getevents	247
+#define __NR_io_submit		248
+#define __NR_io_cancel		249
+#define __NR_fadvise64		250
+
+#define __NR_exit_group		252
+#define __NR_lookup_dcookie	253
+#define __NR_epoll_create	254
+#define __NR_epoll_ctl		255
+#define __NR_epoll_wait		256
+#define __NR_remap_file_pages	257
+#define __NR_set_tid_address	258
+#define __NR_timer_create	259
+#define __NR_timer_settime	(__NR_timer_create+1)
+#define __NR_timer_gettime	(__NR_timer_create+2)
+#define __NR_timer_getoverrun	(__NR_timer_create+3)
+#define __NR_timer_delete	(__NR_timer_create+4)
+#define __NR_clock_settime	(__NR_timer_create+5)
+#define __NR_clock_gettime	(__NR_timer_create+6)
+#define __NR_clock_getres	(__NR_timer_create+7)
+#define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_statfs64		268
+#define __NR_fstatfs64		269
+#define __NR_tgkill		270
+#define __NR_utimes		271
+#define __NR_fadvise64_64	272
+#define __NR_vserver		273
+#define __NR_mbind		274
+#define __NR_get_mempolicy	275
+#define __NR_set_mempolicy	276
+#define __NR_mq_open 		277
+#define __NR_mq_unlink		(__NR_mq_open+1)
+#define __NR_mq_timedsend	(__NR_mq_open+2)
+#define __NR_mq_timedreceive	(__NR_mq_open+3)
+#define __NR_mq_notify		(__NR_mq_open+4)
+#define __NR_mq_getsetattr	(__NR_mq_open+5)
+#define __NR_sys_kexec_load	283
+
+#define NR_syscalls 284
+
+/*
+ * process the return value of a syscall, consigning it to one of two possible fates
+ * - user-visible error numbers are in the range -1 - -4095: see <asm-frv/errno.h>
+ */
+#undef __syscall_return
+#define __syscall_return(type, res)					\
+do {									\
+        unsigned long __sr2 = (res);					\
+	if (__builtin_expect(__sr2 >= (unsigned long)(-4095), 0)) {	\
+		errno = (-__sr2);					\
+		__sr2 = ULONG_MAX;					\
+	}								\
+	return (type) __sr2;						\
+} while (0)
+
+/* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
+
+#undef _syscall0
+#define _syscall0(type,name)						\
+type name(void)								\
+{									\
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);	\
+	register unsigned long __sc0 __asm__ ("gr8");			\
+	__asm__ __volatile__ ("tira gr0,#0"				\
+			      : "=r" (__sc0)				\
+			      : "r" (__scnum));				\
+	__syscall_return(type, __sc0);					\
+}
+
+#undef _syscall1
+#define _syscall1(type,name,type1,arg1)						\
+type name(type1 arg1)								\
+{										\
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);		\
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) arg1;	\
+	__asm__ __volatile__ ("tira gr0,#0"					\
+			      : "+r" (__sc0)					\
+			      : "r" (__scnum));					\
+	__syscall_return(type, __sc0);						\
+}
+
+#undef _syscall2
+#define _syscall2(type,name,type1,arg1,type2,arg2)				\
+type name(type1 arg1,type2 arg2)						\
+{										\
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);		\
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) arg1;	\
+	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) arg2;	\
+	__asm__ __volatile__ ("tira gr0,#0"					\
+			      : "+r" (__sc0)					\
+			      : "r" (__scnum), "r" (__sc1));			\
+	__syscall_return(type, __sc0);						\
+}
+
+#undef _syscall3
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)			\
+type name(type1 arg1,type2 arg2,type3 arg3)					\
+{										\
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);		\
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) arg1;	\
+	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) arg2;	\
+	register unsigned long __sc2 __asm__ ("gr10") = (unsigned long) arg3;	\
+	__asm__ __volatile__ ("tira gr0,#0"					\
+			      : "+r" (__sc0)					\
+			      : "r" (__scnum), "r" (__sc1), "r" (__sc2));	\
+	__syscall_return(type, __sc0);						\
+}
+
+#undef _syscall4
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)		\
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4)				\
+{											\
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);			\
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) arg1;		\
+	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) arg2;		\
+	register unsigned long __sc2 __asm__ ("gr10") = (unsigned long) arg3;		\
+	register unsigned long __sc3 __asm__ ("gr11") = (unsigned long) arg4;		\
+	__asm__ __volatile__ ("tira gr0,#0"						\
+			      : "+r" (__sc0)						\
+			      : "r" (__scnum), "r" (__sc1), "r" (__sc2), "r" (__sc3));	\
+	__syscall_return(type, __sc0);							\
+}
+
+#undef _syscall5
+#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5)	\
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)			\
+{											\
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);			\
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) arg1;		\
+	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) arg2;		\
+	register unsigned long __sc2 __asm__ ("gr10") = (unsigned long) arg3;		\
+	register unsigned long __sc3 __asm__ ("gr11") = (unsigned long) arg4;		\
+	register unsigned long __sc4 __asm__ ("gr12") = (unsigned long) arg5;		\
+	__asm__ __volatile__ ("tira gr0,#0"						\
+			      : "+r" (__sc0)						\
+			      : "r" (__scnum), "r" (__sc1), "r" (__sc2),		\
+			      "r" (__sc3), "r" (__sc4));				\
+	__syscall_return(type, __sc0);							\
+}
+
+#undef _syscall6
+#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5, type6, arg6) \
+type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6)		 \
+{												 \
+	register unsigned long __scnum __asm__ ("gr7") = (__NR_##name);				 \
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) arg1;			 \
+	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) arg2;			 \
+	register unsigned long __sc2 __asm__ ("gr10") = (unsigned long) arg3;			 \
+	register unsigned long __sc3 __asm__ ("gr11") = (unsigned long) arg4;			 \
+	register unsigned long __sc4 __asm__ ("gr12") = (unsigned long) arg5;			 \
+	register unsigned long __sc5 __asm__ ("gr13") = (unsigned long) arg6;			 \
+	__asm__ __volatile__ ("tira gr0,#0"							 \
+			      : "+r" (__sc0)							 \
+			      : "r" (__scnum), "r" (__sc1), "r" (__sc2),			 \
+			      "r" (__sc3), "r" (__sc4), "r" (__sc5));				 \
+	__syscall_return(type, __sc0);								 \
+}
+		
+
+#ifdef __KERNEL_SYSCALLS__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+
+/*
+ * we need this inline - forking from kernel space will result
+ * in NO COPY ON WRITE (!!!), until an execve is executed. This
+ * is no problem, but for the stack. This is handled by not letting
+ * main() use the stack at all after fork(). Thus, no function
+ * calls - which means inline code for fork too, as otherwise we
+ * would use the stack upon exit from 'fork()'.
+ *
+ * Actually only pause and fork are needed inline, so that there
+ * won't be any messing with the stack from main(), but we define
+ * some others too.
+ */
+#define __NR__exit __NR_exit
+static inline _syscall0(int,pause)
+static inline _syscall0(int,sync)
+static inline _syscall0(pid_t,setsid)
+static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
+static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
+static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
+static inline _syscall1(int,dup,int,fd)
+static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
+static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
+static inline _syscall1(int,close,int,fd)
+static inline _syscall1(int,_exit,int,exitcode)
+static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
+static inline _syscall1(int,delete_module,const char *,name)
+
+static inline pid_t wait(int * wait_stat)
+{
+	return waitpid(-1,wait_stat,0);
+}
+
+#endif
+
+#ifdef __KERNEL__
+#define __ARCH_WANT_IPC_PARSE_VERSION
+/* #define __ARCH_WANT_OLD_READDIR */
+#define __ARCH_WANT_OLD_STAT
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_ALARM
+/* #define __ARCH_WANT_SYS_GETHOSTNAME */
+#define __ARCH_WANT_SYS_PAUSE
+/* #define __ARCH_WANT_SYS_SGETMASK */
+/* #define __ARCH_WANT_SYS_SIGNAL */
+#define __ARCH_WANT_SYS_TIME
+#define __ARCH_WANT_SYS_UTIME
+#define __ARCH_WANT_SYS_WAITPID
+#define __ARCH_WANT_SYS_SOCKETCALL
+#define __ARCH_WANT_SYS_FADVISE64
+#define __ARCH_WANT_SYS_GETPGRP
+#define __ARCH_WANT_SYS_LLSEEK
+#define __ARCH_WANT_SYS_NICE
+/* #define __ARCH_WANT_SYS_OLD_GETRLIMIT */
+#define __ARCH_WANT_SYS_OLDUMOUNT
+/* #define __ARCH_WANT_SYS_SIGPENDING */
+#define __ARCH_WANT_SYS_SIGPROCMASK
+#define __ARCH_WANT_SYS_RT_SIGACTION
+#endif
+
+/*
+ * "Conditional" syscalls
+ *
+ * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
+ * but it doesn't work on all toolchains, so we just do it by hand
+ */
+#ifndef cond_syscall
+#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
+#endif
+
+#endif /* _ASM_UNISTD_H_ */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/user.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/user.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/user.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/user.h	2004-11-05 14:13:04.320460555 +0000
@@ -0,0 +1,80 @@
+/* user.h: FR-V core file format stuff
+ *
+ * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_USER_H
+#define _ASM_USER_H
+
+#include <asm/page.h>
+#include <asm/registers.h>
+
+/* Core file format: The core file is written in such a way that gdb
+ * can understand it and provide useful information to the user (under
+ * linux we use the 'trad-core' bfd).  There are quite a number of
+ * obstacles to being able to view the contents of the floating point
+ * registers, and until these are solved you will not be able to view
+ * the contents of them.  Actually, you can read in the core file and
+ * look at the contents of the user struct to find out what the
+ * floating point registers contain.
+ * 
+ * The actual file contents are as follows:
+ * UPAGE:
+ *   1 page consisting of a user struct that tells gdb what is present
+ *   in the file.  Directly after this is a copy of the task_struct,
+ *   which is currently not used by gdb, but it may come in useful at
+ *   some point.  All of the registers are stored as part of the
+ *   upage.  The upage should always be only one page.
+ *
+ * DATA:
+ *   The data area is stored.  We use current->end_text to
+ *   current->brk to pick up all of the user variables, plus any
+ *   memory that may have been malloced.  No attempt is made to
+ *   determine if a page is demand-zero or if a page is totally
+ *   unused, we just cover the entire range.  All of the addresses are
+ *   rounded in such a way that an integral number of pages is
+ *   written.
+ *
+ * STACK:
+ *   We need the stack information in order to get a meaningful
+ *   backtrace.  We need to write the data from (esp) to
+ *   current->start_stack, so we round each of these off in order to
+ *   be able to write an integer number of pages.  The minimum core
+ *   file size is 3 pages, or 12288 bytes.
+ */
+	
+/* When the kernel dumps core, it starts by dumping the user struct -
+ * this will be used by gdb to figure out where the data and stack segments
+ *  are within the file, and what virtual addresses to use.
+ */
+struct user {
+	/* We start with the registers, to mimic the way that "memory" is returned
+	 * from the ptrace(3,...) function.  */
+	struct user_context	regs;
+
+	/* The rest of this junk is to help gdb figure out what goes where */
+	unsigned long		u_tsize;	/* Text segment size (pages). */
+	unsigned long		u_dsize;	/* Data segment size (pages). */
+	unsigned long		u_ssize;	/* Stack segment size (pages). */
+	unsigned long		start_code;     /* Starting virtual address of text. */
+	unsigned long		start_stack;	/* Starting virtual address of stack area.
+						 * This is actually the bottom of the stack,
+						 * the top of the stack is always found in the
+						 * esp register.  */
+	long int		signal;		/* Signal that caused the core dump. */
+
+	unsigned long		magic;		/* To uniquely identify a core file */
+	char			u_comm[32];	/* User command that was responsible */
+};
+
+#define NBPG			PAGE_SIZE
+#define UPAGES			1
+#define HOST_TEXT_START_ADDR	(u.start_code)
+#define HOST_STACK_END_ADDR	(u.start_stack + u.u_ssize * NBPG)
+
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/virtconvert.h linux-2.6.10-rc1-mm3-frv/include/asm-frv/virtconvert.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-frv/virtconvert.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-frv/virtconvert.h	2004-11-05 14:13:04.323460301 +0000
@@ -0,0 +1,42 @@
+/* virtconvert.h: virtual/physical/page address convertion
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _ASM_VIRTCONVERT_H
+#define _ASM_VIRTCONVERT_H
+
+/*
+ * Macros used for converting between virtual and physical mappings.
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <asm/setup.h>
+
+#ifdef CONFIG_MMU
+
+#define phys_to_virt(vaddr)	((void *) ((unsigned long)(vaddr) + PAGE_OFFSET))
+#define virt_to_phys(vaddr)	((unsigned long) (vaddr) - PAGE_OFFSET)
+
+#else
+
+#define phys_to_virt(vaddr)	((void *) (vaddr))
+#define virt_to_phys(vaddr)	((unsigned long) (vaddr))
+
+#endif
+
+#define virt_to_bus virt_to_phys
+#define bus_to_virt phys_to_virt
+
+#define __page_address(page)	(PAGE_OFFSET + (((page) - mem_map) << PAGE_SHIFT))
+#define page_to_phys(page)	virt_to_phys((void *)__page_address(page))
+
+#endif
+#endif
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/elf.h linux-2.6.10-rc1-mm3-frv/include/linux/elf.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/elf.h	2004-10-19 10:42:16.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/elf.h	2004-11-05 14:13:04.388454812 +0000
@@ -36,8 +36,9 @@ typedef __s64	Elf64_Sxword;
 #define PT_NOTE    4
 #define PT_SHLIB   5
 #define PT_PHDR    6
-#define PT_LOOS	   0x60000000
-#define PT_HIOS	   0x6fffffff
+#define PT_TLS     7               /* Thread local storage segment */
+#define PT_LOOS    0x60000000      /* OS-specific */
+#define PT_HIOS    0x6fffffff      /* OS-specific */
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
@@ -109,6 +110,8 @@ typedef __s64	Elf64_Sxword;
  */
 #define EM_S390_OLD     0xA390
 
+#define EM_FRV		0x5441		/* Fujitsu FR-V */
+
 /* This is the info that is needed to parse the dynamic section of the file */
 #define DT_NULL		0
 #define DT_NEEDED	1
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/suspend.h linux-2.6.10-rc1-mm3-frv/include/linux/suspend.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/suspend.h	2004-10-19 10:42:17.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/suspend.h	2004-11-05 14:13:04.442450251 +0000
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#ifdef CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_FRV)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
