Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTDNRqr (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbTDNRqU (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:46:20 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:63902 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S263591AbTDNRp2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:28 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (2/16): syscall numbers > 255.
Date: Mon, 14 Apr 2003 19:47:50 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141947.50729.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for system calls with numbers > 255.

diffstat:
 arch/s390/kernel/entry.S  |   70 ++++++++----
 include/asm-s390/unistd.h |  252 ++++++++++++++++++++++++++--------------------
 2 files changed, 194 insertions(+), 128 deletions(-)

diff -urN linux-2.5.67/arch/s390/kernel/entry.S linux-2.5.67-s390/arch/s390/kernel/entry.S
--- linux-2.5.67/arch/s390/kernel/entry.S	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/arch/s390/kernel/entry.S	Mon Apr 14 19:11:49 2003
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/offsets.h>
+#include <asm/unistd.h>
 
 /*
  * Stack layout for the system_call stack entry.
@@ -97,8 +98,7 @@
         stam    %a0,%a15,SP_AREGS(%r15)   # store access registers to kst.
         mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+12 # store ac. regs
         mvc     SP_PSW(8,%r15),\psworg    # move user PSW to stack
-        la      %r0,\psworg               # store trap indication
-        st      %r0,SP_TRAP(%r15)
+	mvc	SP_TRAP(4,%r15),BASED(.L\psworg) # store trap indication
         xc      0(4,%r15),0(%r15)         # clear back chain
         .endm
 
@@ -179,12 +179,18 @@
 	SAVE_ALL_BASE
         SAVE_ALL __LC_SVC_OLD_PSW,1
 	lh	%r7,0x8a	  # get svc number from lowcore
-        GET_THREAD_INFO           # load pointer to task_struct to R9
-	sll	%r7,2
         stosm   24(%r15),0x03     # reenable interrupts
+        GET_THREAD_INFO           # load pointer to task_struct to R9
+	sla	%r7,2             # *4 and test for svc 0
+	bnz	BASED(sysc_do_restart)  # svc number > 0
+	# svc 0: system call number in %r1
+	cl	%r1,BASED(.Lnr_syscalls)
+	bnl	BASED(sysc_do_restart)
+	lr	%r7,%r1           # copy svc number to %r7
+	sla	%r7,2             # *4
 sysc_do_restart:
-        l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
+        l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
         bo      BASED(sysc_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
@@ -247,7 +253,7 @@
 	ni	__TI_flags+3(%r9),255-_TIF_RESTART_SVC # clear TIF_RESTART_SVC
 	stosm	24(%r15),0x03          # reenable interrupts
 	l	%r7,SP_R2(%r15)        # load new svc number
-	sll	%r7,2
+	sla	%r2,2
 	mvc	SP_R2(4,%r15),SP_ORIG_R2(%r15) # restore first argument
 	lm	%r2,%r6,SP_R2(%r15)    # load svc arguments
 	b	BASED(sysc_do_restart) # restart svc
@@ -260,9 +266,10 @@
 	srl	%r7,2
 	st	%r7,SP_R2(%r15)
 	basr	%r14,%r1
+	clc	SP_R2(4,%r15),BASED(.Lnr_syscalls)
+	bl	BASED(sysc_tracego)
 	l	%r7,SP_R2(%r15)        # strace might have changed the 
-	n	%r7,BASED(.Lc256)      #  system call
-	sll	%r7,2
+	sll	%r7,2                  #  system call
 	l	%r8,sys_call_table-entry_base(%r7,%r13)
 sysc_tracego:
 	lm	%r3,%r6,SP_R3(%r15)
@@ -617,9 +624,15 @@
 	.long  sys_epoll_wait
 	.long  sys_set_tid_address
 	.long  sys_fadvise64
-	.rept  255-253
-	.long  sys_ni_syscall
-	.endr
+	.long  sys_timer_create
+	.long  sys_timer_settime	 /* 255 */
+	.long  sys_timer_gettime
+	.long  sys_timer_getoverrun
+	.long  sys_timer_delete
+	.long  sys_clock_settime
+	.long  sys_clock_gettime
+	.long  sys_clock_getres
+	.long  sys_clock_nanosleep
 
 /*
  * Program check handler routine
@@ -694,12 +707,19 @@
 #
 pgm_svcper:
 	SAVE_ALL __LC_SVC_OLD_PSW,1
-        GET_THREAD_INFO           # load pointer to task_struct to R9
+	lh	%r7,0x8a	  # get svc number from lowcore
         stosm   24(%r15),0x03     # reenable interrupts
-	lh	%r8,0x8a	  # get svc number from lowcore
-        sll     %r8,2
-        l       %r8,sys_call_table-entry_base(%r8,%r13) # get system call addr.
+        GET_THREAD_INFO           # load pointer to task_struct to R9
+        sla     %r7,2             # *4 and test for svc 0
+	bnz	BASED(pgm_svcstd) # svc number > 0 ?
+	# svc 0: system call number in %r1
+	cl	%r1,BASED(.Lnr_syscalls)
+	bnl	BASED(pgm_svcstd)
+	lr	%r7,%r1           # copy svc number to %r7
+	sla	%r7,2             # *4
+pgm_svcstd:
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
+        l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
         bo      BASED(pgm_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
@@ -725,13 +745,14 @@
 #
 pgm_tracesys:
         l       %r1,BASED(.Ltrace)
-	mvc	SP_R2(%r15),BASED(.Lc_ENOSYS)
+	srl	%r7,2
+	st	%r7,SP_R2(%r15)
         basr    %r14,%r1
-	clc	SP_R2(4,%r15),BASED(.Lc256)
-	bnl	BASED(pgm_svc_go)
-	l	%r8,SP_R2(%r15)   # strace changed the syscall
-	sll     %r8,2
-	l	%r8,sys_call_table-entry_base(%r8,%r13)
+	clc	SP_R2(4,%r15),BASED(.Lnr_syscalls)
+	bl	BASED(pgm_svc_go)
+	l	%r7,SP_R2(%r15)   # strace changed the syscall
+	sll     %r7,2
+	l	%r8,sys_call_table-entry_base(%r7,%r13)
 pgm_svc_go:
 	lm      %r3,%r6,SP_R3(%r15)
 	l       %r2,SP_ORIG_R2(%r15)
@@ -922,7 +943,12 @@
 .Lc_ENOSYS:    .long  -ENOSYS
 .Lc_pactive:   .long  PREEMPT_ACTIVE
 .Lc0xff:       .long  0xff
-.Lc256:        .long  256
+.Lnr_syscalls: .long  NR_syscalls
+.L0x018:       .long  0x018
+.L0x020:       .long  0x020
+.L0x028:       .long  0x028
+.L0x030:       .long  0x030
+.L0x038:       .long  0x038
 
 /*
  * Symbol constants
diff -urN linux-2.5.67/include/asm-s390/unistd.h linux-2.5.67-s390/include/asm-s390/unistd.h
--- linux-2.5.67/include/asm-s390/unistd.h	Mon Apr  7 19:33:03 2003
+++ linux-2.5.67-s390/include/asm-s390/unistd.h	Mon Apr 14 19:11:49 2003
@@ -249,130 +249,170 @@
 #define __NR_epoll_wait		251
 #define __NR_set_tid_address	252
 #define __NR_fadvise64		253
+#define __NR_timer_create	254
+#define __NR_timer_settime	(__NR_timer_create+1)
+#define __NR_timer_gettime	(__NR_timer_create+2)
+#define __NR_timer_getoverrun	(__NR_timer_create+3)
+#define __NR_timer_delete	(__NR_timer_create+4)
+#define __NR_clock_settime	(__NR_timer_create+5)
+#define __NR_clock_gettime	(__NR_timer_create+6)
+#define __NR_clock_getres	(__NR_timer_create+7)
+#define __NR_clock_nanosleep	(__NR_timer_create+8)
 
+#define NR_syscalls 263
 
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
 
-#define __syscall_return(type, res)                          \
-do {                                                         \
-        if ((unsigned long)(res) >= (unsigned long)(-125)) { \
-                errno = -(res);                              \
-                res = -1;                                    \
-        }                                                    \
-        return (type) (res);                                 \
+#define __syscall_return(type, res)			     \
+do {							     \
+	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+		errno = -(res);				     \
+		res = -1;				     \
+	}						     \
+	return (type) (res);				     \
 } while (0)
 
-#define _svc_clobber "cc", "memory"
+#define _svc_clobber "1", "cc", "memory"
 
-#define _syscall0(type,name)                                 \
-type name(void) {                                            \
-        register long __svcres asm("2");                     \
-        long __res;                                          \
-        __asm__ __volatile__ (                               \
-                "    svc %b1\n"                              \
-                : "=d" (__svcres)                            \
-                : "i" (__NR_##name)                          \
-                : _svc_clobber );                            \
-	__res = __svcres;                                    \
-        __syscall_return(type,__res);                        \
-}
-
-#define _syscall1(type,name,type1,arg1)                      \
-type name(type1 arg1) {                                      \
-        register type1 __arg1 asm("2") = arg1;               \
-        register long __svcres asm("2");                     \
-        long __res;                                          \
-        __asm__ __volatile__ (                               \
-                "    svc %b1\n"                              \
-                : "=d" (__svcres)                            \
-                : "i" (__NR_##name),                         \
-                  "0" (__arg1)                               \
-                : _svc_clobber );                            \
-	__res = __svcres;                                    \
-        __syscall_return(type,__res);                        \
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2)           \
-type name(type1 arg1, type2 arg2) {                          \
-        register type1 __arg1 asm("2") = arg1;               \
-        register type2 __arg2 asm("3") = arg2;               \
-        register long __svcres asm("2");                     \
-        long __res;                                          \
-        __asm__ __volatile__ (                               \
-                "    svc %b1\n"                              \
-                : "=d" (__svcres)                            \
-                : "i" (__NR_##name),                         \
-                  "0" (__arg1),                              \
-                  "d" (__arg2)                               \
-                : _svc_clobber );                            \
-	__res = __svcres;                                    \
-        __syscall_return(type,__res);                        \
+#define _syscall0(type,name)				     \
+type name(void) {					     \
+	register long __svcres asm("2");		     \
+	long __res;					     \
+	__asm__ __volatile__ (				     \
+		"    .if %b1 < 256\n"			     \
+		"    svc %b1\n"				     \
+		"    .else\n"				     \
+		"    lhi %%r1,%b1\n"			     \
+		"    svc 0\n"				     \
+		"    .endif"				     \
+		: "=d" (__svcres)			     \
+		: "i" (__NR_##name)			     \
+		: _svc_clobber );			     \
+	__res = __svcres;				     \
+	__syscall_return(type,__res);			     \
+}
+
+#define _syscall1(type,name,type1,arg1)			     \
+type name(type1 arg1) {					     \
+	register type1 __arg1 asm("2") = arg1;		     \
+	register long __svcres asm("2");		     \
+	long __res;					     \
+	__asm__ __volatile__ (				     \
+		"    .if %b1 < 256\n"			     \
+		"    svc %b1\n"				     \
+		"    .else\n"				     \
+		"    lhi %%r1,%b1\n"			     \
+		"    svc 0\n"				     \
+		"    .endif"				     \
+		: "=d" (__svcres)			     \
+		: "i" (__NR_##name),			     \
+		  "0" (__arg1)				     \
+		: _svc_clobber );			     \
+	__res = __svcres;				     \
+	__syscall_return(type,__res);			     \
+}
+
+#define _syscall2(type,name,type1,arg1,type2,arg2)	     \
+type name(type1 arg1, type2 arg2) {			     \
+	register type1 __arg1 asm("2") = arg1;		     \
+	register type2 __arg2 asm("3") = arg2;		     \
+	register long __svcres asm("2");		     \
+	long __res;					     \
+	__asm__ __volatile__ (				     \
+		"    .if %b1 < 256\n"			     \
+		"    svc %b1\n"				     \
+		"    .else\n"				     \
+		"    lhi %%r1,%b1\n"			     \
+		"    svc 0\n"				     \
+		"    .endif"				     \
+		: "=d" (__svcres)			     \
+		: "i" (__NR_##name),			     \
+		  "0" (__arg1),				     \
+		  "d" (__arg2)				     \
+		: _svc_clobber );			     \
+	__res = __svcres;				     \
+	__syscall_return(type,__res);			     \
 }
 
 #define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)\
-type name(type1 arg1, type2 arg2, type3 arg3) {              \
-        register type1 __arg1 asm("2") = arg1;               \
-        register type2 __arg2 asm("3") = arg2;               \
-        register type3 __arg3 asm("4") = arg3;               \
-        register long __svcres asm("2");                     \
-        long __res;                                          \
-        __asm__ __volatile__ (                               \
-                "    svc %b1\n"                              \
-                : "=d" (__svcres)                            \
-                : "i" (__NR_##name),                         \
-                  "0" (__arg1),                              \
-                  "d" (__arg2),                              \
-                  "d" (__arg3)                               \
-                : _svc_clobber );                            \
-	__res = __svcres;                                    \
-        __syscall_return(type,__res);                        \
+type name(type1 arg1, type2 arg2, type3 arg3) {		     \
+	register type1 __arg1 asm("2") = arg1;		     \
+	register type2 __arg2 asm("3") = arg2;		     \
+	register type3 __arg3 asm("4") = arg3;		     \
+	register long __svcres asm("2");		     \
+	long __res;					     \
+	__asm__ __volatile__ (				     \
+		"    .if %b1 < 256\n"			     \
+		"    svc %b1\n"				     \
+		"    .else\n"				     \
+		"    lhi %%r1,%b1\n"			     \
+		"    svc 0\n"				     \
+		"    .endif"				     \
+		: "=d" (__svcres)			     \
+		: "i" (__NR_##name),			     \
+		  "0" (__arg1),				     \
+		  "d" (__arg2),				     \
+		  "d" (__arg3)				     \
+		: _svc_clobber );			     \
+	__res = __svcres;				     \
+	__syscall_return(type,__res);			     \
 }
 
 #define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,\
-                  type4,name4)                               \
+		  type4,name4)				     \
 type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) {  \
-        register type1 __arg1 asm("2") = arg1;               \
-        register type2 __arg2 asm("3") = arg2;               \
-        register type3 __arg3 asm("4") = arg3;               \
-        register type4 __arg4 asm("5") = arg4;               \
-        register long __svcres asm("2");                     \
-        long __res;                                          \
-        __asm__ __volatile__ (                               \
-                "    svc %b1\n"                              \
-                : "=d" (__svcres)                            \
-                : "i" (__NR_##name),                         \
-                  "0" (__arg1),                              \
-                  "d" (__arg2),                              \
-                  "d" (__arg3),                              \
-                  "d" (__arg4)                               \
-                : _svc_clobber );                            \
-	__res = __svcres;                                    \
-        __syscall_return(type,__res);                        \
+	register type1 __arg1 asm("2") = arg1;		     \
+	register type2 __arg2 asm("3") = arg2;		     \
+	register type3 __arg3 asm("4") = arg3;		     \
+	register type4 __arg4 asm("5") = arg4;		     \
+	register long __svcres asm("2");		     \
+	long __res;					     \
+	__asm__ __volatile__ (				     \
+		"    .if %b1 < 256\n"			     \
+		"    svc %b1\n"				     \
+		"    .else\n"				     \
+		"    lhi %%r1,%b1\n"			     \
+		"    svc 0\n"				     \
+		"    .endif"				     \
+		: "=d" (__svcres)			     \
+		: "i" (__NR_##name),			     \
+		  "0" (__arg1),				     \
+		  "d" (__arg2),				     \
+		  "d" (__arg3),				     \
+		  "d" (__arg4)				     \
+		: _svc_clobber );			     \
+	__res = __svcres;				     \
+	__syscall_return(type,__res);			     \
 }
 
 #define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,\
-                  type4,name4,type5,name5)                   \
+		  type4,name4,type5,name5)		     \
 type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4,    \
-          type5 arg5) {                                      \
-        register type1 __arg1 asm("2") = arg1;               \
-        register type2 __arg2 asm("3") = arg2;               \
-        register type3 __arg3 asm("4") = arg3;               \
-        register type4 __arg4 asm("5") = arg4;               \
-        register type5 __arg5 asm("6") = arg5;               \
-        register long __svcres asm("2");                     \
-        long __res;                                          \
-        __asm__ __volatile__ (                               \
-                "    svc %b1\n"                              \
-                : "=d" (__svcres)                            \
-                : "i" (__NR_##name),                         \
-                  "0" (__arg1),                              \
-                  "d" (__arg2),                              \
-                  "d" (__arg3),                              \
-                  "d" (__arg4),                              \
-                  "d" (__arg5)                               \
-                : _svc_clobber );                            \
-	__res = __svcres;                                    \
-        __syscall_return(type,__res);                        \
+	  type5 arg5) {					     \
+	register type1 __arg1 asm("2") = arg1;		     \
+	register type2 __arg2 asm("3") = arg2;		     \
+	register type3 __arg3 asm("4") = arg3;		     \
+	register type4 __arg4 asm("5") = arg4;		     \
+	register type5 __arg5 asm("6") = arg5;		     \
+	register long __svcres asm("2");		     \
+	long __res;					     \
+	__asm__ __volatile__ (				     \
+		"    .if %b1 < 256\n"			     \
+		"    svc %b1\n"				     \
+		"    .else\n"				     \
+		"    lhi %%r1,%b1\n"			     \
+		"    svc 0\n"				     \
+		"    .endif"				     \
+		: "=d" (__svcres)			     \
+		: "i" (__NR_##name),			     \
+		  "0" (__arg1),				     \
+		  "d" (__arg2),				     \
+		  "d" (__arg3),				     \
+		  "d" (__arg4),				     \
+		  "d" (__arg5)				     \
+		: _svc_clobber );			     \
+	__res = __svcres;				     \
+	__syscall_return(type,__res);			     \
 }
 
 #ifdef __KERNEL_SYSCALLS__

