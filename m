Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276955AbRJHPqG>; Mon, 8 Oct 2001 11:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276958AbRJHPp6>; Mon, 8 Oct 2001 11:45:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27820 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276955AbRJHPpt>; Mon, 8 Oct 2001 11:45:49 -0400
Date: Mon, 08 Oct 2001 10:46:15 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Provide system call to get task id
Message-ID: <71000000.1002555975@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the current thread group implementation getpid() returns the
thread group leader.  There is currently no way for a task in a
thread group to find its true pid.

This patch provides a new system call gettid() (get task id), which
returns the true pid of the task.  This is needed in some multi-threaded
apps and libraries.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

==========

--- linux-2.4.10/arch/i386/kernel/entry.S	Sat Sep  8 14:02:32 2001
+++ linux-2.4.10-gettid/arch/i386/kernel/entry.S	Mon Oct  8 09:57:39 2001
@@ -619,6 +619,7 @@
 	.long SYMBOL_NAME(sys_madvise)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
+	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */

 	.rept NR_syscalls-(.-sys_call_table)/4
--- linux-2.4.10/arch/alpha/kernel/entry.S	Wed Jul 25 19:11:05 2001
+++ linux-2.4.10-gettid/arch/alpha/kernel/entry.S	Mon Oct  8 09:58:43 2001
@@ -10,7 +10,7 @@

 #define SIGCHLD 20

-#define NR_SYSCALLS 378
+#define NR_SYSCALLS 379

 /*
  * These offsets must match with alpha_mv in <asm/machvec.h>.
@@ -1145,3 +1145,4 @@
 	.quad sys_mincore			/* 375 */
 	.quad sys_pciconfig_iobase
 	.quad sys_getdents64
+	.quad sys_gettid
--- linux-2.4.10/arch/sparc/kernel/systbls.S	Sun Aug 13 14:01:54 2000
+++ linux-2.4.10-gettid/arch/sparc/kernel/systbls.S	Mon Oct  8 09:58:43 2001
@@ -165,5 +165,6 @@
 	.long sunos_nosys, sunos_nosys
 /*250*/	.long sunos_nosys, sunos_nosys, sunos_nosys
 	.long sunos_nosys, sunos_nosys, sunos_nosys
+	.long sys_gettid

 #endif
--- linux-2.4.10/arch/mips/kernel/syscalls.h	Mon Jul  2 15:56:40 2001
+++ linux-2.4.10-gettid/arch/mips/kernel/syscalls.h	Mon Oct  8 09:58:43 2001
@@ -235,3 +235,4 @@
 SYS(sys_madvise, 3)
 SYS(sys_getdents64, 3)
 SYS(sys_fcntl64, 3)				/* 4220 */
+SYS(sys_gettid, 0)
--- linux-2.4.10/arch/ppc/kernel/misc.S	Tue Aug 28 08:58:33 2001
+++ linux-2.4.10-gettid/arch/ppc/kernel/misc.S	Mon Oct  8 09:58:43 2001
@@ -1120,6 +1120,7 @@
 	.long sys_fcntl64		/* 204 */
 	.long sys_madvise		/* 205 */
 	.long sys_mincore		/* 206 */
+	.long sys_gettid		/* 207 */
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
 	.endr
--- linux-2.4.10/arch/m68k/kernel/entry.S	Tue Feb 13 16:13:43 2001
+++ linux-2.4.10-gettid/arch/m68k/kernel/entry.S	Mon Oct  8 09:58:43 2001
@@ -646,6 +646,7 @@
 	.long SYMBOL_NAME(sys_ni_syscall)
 	.long SYMBOL_NAME(sys_ni_syscall)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
+	.long SYMBOL_NAME(sys_gettid)

 	.rept NR_syscalls-(.-SYMBOL_NAME(sys_call_table))/4
 		.long SYMBOL_NAME(sys_ni_syscall)
--- linux-2.4.10/arch/sparc64/kernel/systbls.S	Wed Aug 23 11:30:13 2000
+++ linux-2.4.10-gettid/arch/sparc64/kernel/systbls.S	Mon Oct  8 09:58:43 
2001
@@ -225,5 +225,6 @@
 	.word sunos_nosys, sunos_nosys
 /*250*/	.word sunos_nosys, sunos_nosys, sunos_nosys
 	.word sunos_nosys, sunos_nosys, sys_aplib
+	.word sys_gettid

 #endif
--- linux-2.4.10/arch/arm/kernel/calls.S	Wed Jun 27 16:12:04 2001
+++ linux-2.4.10-gettid/arch/arm/kernel/calls.S	Mon Oct  8 09:58:43 2001
@@ -236,6 +236,7 @@
 		.long	SYMBOL_NAME(sys_mincore)
 /* 220 */	.long	SYMBOL_NAME(sys_madvise)
 		.long	SYMBOL_NAME(sys_fcntl64)
+		.long	SYMBOL_NAME(sys_gettid)
 __syscall_end:

 		.rept	NR_syscalls - (__syscall_end - __syscall_start) / 4
--- linux-2.4.10/arch/sh/kernel/entry.S	Sat Sep  8 14:29:09 2001
+++ linux-2.4.10-gettid/arch/sh/kernel/entry.S	Mon Oct  8 09:58:43 2001
@@ -1298,6 +1298,7 @@
 	.long SYMBOL_NAME(sys_madvise)
 	.long SYMBOL_NAME(sys_getdents64)	/* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
+	.long SYMBOL_NAME(sys_gettid)

 	/*
 	 * NOTE!! This doesn't have to be exact - we just have
@@ -1305,7 +1306,7 @@
 	 * entries. Don't panic if you notice that this hasn't
 	 * been shrunk every time we add a new system call.
 	 */
-	.rept NR_syscalls-221
+	.rept NR_syscalls-222
 		.long SYMBOL_NAME(sys_ni_syscall)
 	.endr

--- linux-2.4.10/arch/mips64/kernel/scall_64.S	Sun Sep  9 12:43:01 2001
+++ linux-2.4.10-gettid/arch/mips64/kernel/scall_64.S	Mon Oct  8 09:58:43 
2001
@@ -347,3 +347,4 @@
 	PTR	sys_mincore
 	PTR	sys_madvise
 	PTR	sys_getdents64
+	PTR	sys_gettid
--- linux-2.4.10/arch/mips64/kernel/scall_o32.S	Sun Sep  9 12:43:01 2001
+++ linux-2.4.10-gettid/arch/mips64/kernel/scall_o32.S	Mon Oct  8 09:58:43 
2001
@@ -454,6 +454,7 @@
 	sys	sys_madvise	3
 	sys	sys_getdents64	3
 	sys	sys32_fcntl64	3			/* 4220 */
+	sys	sys_gettid	0
 	.endm

 	.macro	sys function, nargs
--- linux-2.4.10/arch/s390/kernel/entry.S	Sun Aug 12 12:38:47 2001
+++ linux-2.4.10-gettid/arch/s390/kernel/entry.S	Mon Oct  8 09:58:43 2001
@@ -559,7 +559,8 @@
         .long  sys_madvise
 	.long  sys_getdents64		 /* 220 */
         .long  sys_fcntl64
-	.rept  255-221
+        .long  sys_gettid
+	.rept  255-222
 	.long  sys_ni_syscall
 	.endr

--- linux-2.4.10/arch/parisc/kernel/syscall.S	Tue Dec  5 14:29:39 2000
+++ linux-2.4.10-gettid/arch/parisc/kernel/syscall.S	Mon Oct  8 09:58:43 
2001
@@ -552,6 +552,7 @@
 	ENTRY_UHOH(shmctl)		/* 195 */
 	ENTRY_SAME(ni_syscall)		/* streams1 */
 	ENTRY_SAME(ni_syscall)		/* streams2 */
+	ENTRY_SAME(gettid)

 .end

--- linux-2.4.10/arch/cris/kernel/entry.S	Thu Jul 26 17:10:06 2001
+++ linux-2.4.10-gettid/arch/cris/kernel/entry.S	Mon Oct  8 09:58:43 2001
@@ -966,6 +966,7 @@
 	.long SYMBOL_NAME(sys_madvise)
 	.long SYMBOL_NAME(sys_getdents64)       /* 220 */
 	.long SYMBOL_NAME(sys_fcntl64)
+	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for TUX */

         /*
@@ -975,7 +976,7 @@
          * been shrunk every time we add a new system call.
          */

-	.rept NR_syscalls-222
+	.rept NR_syscalls-223
 		.long SYMBOL_NAME(sys_ni_syscall)
 	.endr
 	
--- linux-2.4.10/arch/s390x/kernel/entry.S	Sun Aug 12 12:38:48 2001
+++ linux-2.4.10-gettid/arch/s390x/kernel/entry.S	Mon Oct  8 09:58:43 2001
@@ -594,7 +594,8 @@
         .long  SYSCALL(sys_madvise,sys32_madvise_wrapper)
 	.long  SYSCALL(sys_getdents64,sys32_getdents64_wrapper)/* 220 */
 	.long  SYSCALL(sys_ni_syscall,sys32_fcntl64_wrapper)
-        .rept  255-221
+	.long  SYSCALL(sys_gettid,sys_gettid)
+        .rept  255-222
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.endr

--- linux-2.4.10/include/asm-i386/unistd.h	Fri Aug 11 16:39:23 2000
+++ linux-2.4.10-gettid/include/asm-i386/unistd.h	Mon Oct  8 09:58:43 2001
@@ -227,6 +227,7 @@
 #define __NR_madvise1		219	/* delete when C lib stub is removed */
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+#define __NR_gettid		222

 /* user-visible error numbers are in the range -1 - -124: see 
<asm-i386/errno.h> */

--- linux-2.4.10/include/asm-mips/unistd.h	Mon Jul  2 15:56:40 2001
+++ linux-2.4.10-gettid/include/asm-mips/unistd.h	Mon Oct  8 09:58:43 2001
@@ -233,11 +233,12 @@
 #define __NR_madvise			(__NR_Linux + 218)
 #define __NR_getdents64			(__NR_Linux + 219)
 #define __NR_fcntl64			(__NR_Linux + 220)
+#define __NR_gettid			(__NR_Linux + 221)

 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		220
+#define __NR_Linux_syscalls		221

 #ifndef _LANGUAGE_ASSEMBLY

--- linux-2.4.10/include/asm-alpha/unistd.h	Wed Jan 24 17:16:23 2001
+++ linux-2.4.10-gettid/include/asm-alpha/unistd.h	Mon Oct  8 09:58:43 2001
@@ -315,6 +315,7 @@
 #define __NR_mincore			375
 #define __NR_pciconfig_iobase		376
 #define __NR_getdents64			377
+#define __NR_gettid			378

 #if defined(__GNUC__)

--- linux-2.4.10/include/asm-m68k/unistd.h	Mon Nov 27 19:11:26 2000
+++ linux-2.4.10-gettid/include/asm-m68k/unistd.h	Mon Oct  8 09:58:43 2001
@@ -222,6 +222,7 @@
 #define __NR_setfsuid32		215
 #define __NR_setfsgid32		216
 #define __NR_getdents64		220
+#define __NR_gettid		221

 /* user-visible error numbers are in the range -1 - -122: see
    <asm-m68k/errno.h> */
--- linux-2.4.10/include/asm-sparc/unistd.h	Mon Aug 14 15:09:07 2000
+++ linux-2.4.10-gettid/include/asm-sparc/unistd.h	Mon Oct  8 09:58:43 2001
@@ -271,6 +271,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_gettid             256

 #define _syscall0(type,name) \
 type name(void) \
--- linux-2.4.10/include/asm-ppc/unistd.h	Mon May 21 17:02:06 2001
+++ linux-2.4.10-gettid/include/asm-ppc/unistd.h	Mon Oct  8 09:58:43 2001
@@ -213,6 +213,7 @@
 #define __NR_fcntl64		204
 #define __NR_madvise		205
 #define __NR_mincore		206
+#define __NR_gettid		207

 #define __NR(n)	#n

--- linux-2.4.10/include/asm-sparc64/unistd.h	Mon Aug 14 15:09:08 2000
+++ linux-2.4.10-gettid/include/asm-sparc64/unistd.h	Mon Oct  8 09:58:43 
2001
@@ -273,6 +273,7 @@
 #define __NR_fdatasync          253
 #define __NR_nfsservctl         254
 #define __NR_aplib              255
+#define __NR_gettid             256

 #define _syscall0(type,name) \
 type name(void) \
--- linux-2.4.10/include/asm-arm/unistd.h	Sun Aug 12 13:14:00 2001
+++ linux-2.4.10-gettid/include/asm-arm/unistd.h	Mon Oct  8 09:58:43 2001
@@ -240,6 +240,7 @@
 #define __NR_mincore			(__NR_SYSCALL_BASE+219)
 #define __NR_madvise			(__NR_SYSCALL_BASE+220)
 #define __NR_fcntl64			(__NR_SYSCALL_BASE+221)
+#define __NR_gettid			(__NR_SYSCALL_BASE+222)

 /*
  * The following SWIs are ARM private.
--- linux-2.4.10/include/asm-sh/unistd.h	Mon Oct  2 13:57:34 2000
+++ linux-2.4.10-gettid/include/asm-sh/unistd.h	Mon Oct  8 09:58:43 2001
@@ -231,6 +231,7 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+#define __NR_gettid		222

 /* user-visible error numbers are in the range -1 - -125: see 
<asm-sh/errno.h> */

--- linux-2.4.10/include/asm-ia64/unistd.h	Tue Jul 31 12:30:09 2001
+++ linux-2.4.10-gettid/include/asm-ia64/unistd.h	Mon Oct  8 09:58:43 2001
@@ -205,6 +205,7 @@
 #define __NR_clone2			1213
 #define __NR_getdents64			1214
 #define __NR_getunwind			1215
+#define __NR_gettid			1216

 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)

--- linux-2.4.10/include/asm-mips64/unistd.h	Tue Nov 28 23:42:04 2000
+++ linux-2.4.10-gettid/include/asm-mips64/unistd.h	Mon Oct  8 09:58:43 2001
@@ -461,11 +461,12 @@
 #define __NR_mincore			(__NR_Linux + 211)
 #define __NR_madvise			(__NR_Linux + 212)
 #define __NR_getdents64			(__NR_Linux + 213)
+#define __NR_gettid			(__NR_Linux + 214)

 /*
  * Offset of the last Linux flavoured syscall
  */
-#define __NR_Linux_syscalls		213
+#define __NR_Linux_syscalls		214

 #ifndef _LANGUAGE_ASSEMBLY

--- linux-2.4.10/include/asm-s390/unistd.h	Tue Feb 13 16:13:44 2001
+++ linux-2.4.10-gettid/include/asm-s390/unistd.h	Mon Oct  8 09:58:43 2001
@@ -209,6 +209,7 @@
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64		220
+#define __NR_gettid		221


 /* user-visible error numbers are in the range -1 - -122: see 
<asm-s390/errno.h> */
--- linux-2.4.10/include/asm-parisc/unistd.h	Tue Dec  5 14:29:39 2000
+++ linux-2.4.10-gettid/include/asm-parisc/unistd.h	Mon Oct  8 09:58:43 2001
@@ -689,8 +689,9 @@

 #define __NR_getpmsg            (__NR_Linux + 196)      /* some people 
actually want streams */
 #define __NR_putpmsg            (__NR_Linux + 197)      /* some people 
actually want streams */
+#define __NR_gettid             (__NR_Linux + 198)

-#define __NR_Linux_syscalls     197
+#define __NR_Linux_syscalls     198

 #define HPUX_GATEWAY_ADDR       0xC0000004
 #define LINUX_GATEWAY_ADDR      0x100
--- linux-2.4.10/include/asm-cris/unistd.h	Tue May  1 18:05:00 2001
+++ linux-2.4.10-gettid/include/asm-cris/unistd.h	Mon Oct  8 09:58:43 2001
@@ -227,6 +227,7 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+#define __NR_gettid		222

 /* XXX - _foo needs to be __foo, while __NR_bar could be _NR_bar. */
 #define _syscall0(type,name) \
--- linux-2.4.10/include/asm-s390x/unistd.h	Wed Jul 25 16:12:03 2001
+++ linux-2.4.10-gettid/include/asm-s390x/unistd.h	Mon Oct  8 09:58:43 2001
@@ -179,6 +179,7 @@
 #define __NR_mincore            218
 #define __NR_madvise            219
 #define __NR_getdents64         220
+#define __NR_gettid             222


 /* user-visible error numbers are in the range -1 - -122: see 
<asm-s390/errno.h> */
--- linux-2.4.10/kernel/timer.c	Tue Jun 12 18:40:11 2001
+++ linux-2.4.10-gettid/kernel/timer.c	Mon Oct  8 09:58:43 2001
@@ -794,6 +794,11 @@

 #endif

+asmlinkage long sys_gettid(void)
+{
+	return	current->pid;
+}
+
 asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
 {
 	struct timespec t;

