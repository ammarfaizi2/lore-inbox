Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbTCZPNn>; Wed, 26 Mar 2003 10:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCZPNf>; Wed, 26 Mar 2003 10:13:35 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:8176 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261711AbTCZPIw> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:08:52 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update (2/9): syscall numbers > 255.
Date: Wed, 26 Mar 2003 16:06:27 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303261606.27135.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for system calls with numbers > 255.

diffstat:
 arch/s390/kernel/entry.S   |   36 ++++--
 arch/s390x/kernel/entry.S  |   45 +++++---
 include/asm-s390/unistd.h  |  252 ++++++++++++++++++++++++++-------------------
 include/asm-s390x/unistd.h |  252 ++++++++++++++++++++++++++-------------------
 4 files changed, 351 insertions(+), 234 deletions(-)

diff -urN linux-2.5.66/arch/s390/kernel/entry.S linux-2.5.66-s390/arch/s390/kernel/entry.S
--- linux-2.5.66/arch/s390/kernel/entry.S	Wed Mar 26 15:45:11 2003
+++ linux-2.5.66-s390/arch/s390/kernel/entry.S	Wed Mar 26 15:45:11 2003
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
@@ -617,9 +623,15 @@
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
@@ -923,6 +935,12 @@
 .Lc_pactive:   .long  PREEMPT_ACTIVE
 .Lc0xff:       .long  0xff
 .Lc256:        .long  256
+.Lnr_syscalls: .long  NR_syscalls
+.L0x018:       .long  0x018
+.L0x020:       .long  0x020
+.L0x028:       .long  0x028
+.L0x030:       .long  0x030
+.L0x038:       .long  0x038
 
 /*
  * Symbol constants
diff -urN linux-2.5.66/arch/s390x/kernel/entry.S linux-2.5.66-s390/arch/s390x/kernel/entry.S
--- linux-2.5.66/arch/s390x/kernel/entry.S	Wed Mar 26 15:45:11 2003
+++ linux-2.5.66-s390/arch/s390x/kernel/entry.S	Wed Mar 26 15:45:11 2003
@@ -18,6 +18,7 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/offsets.h>
+#include <asm/unistd.h>
 
 /*
  * Stack layout for the system_call stack entry.
@@ -60,8 +61,9 @@
 
         .macro  SAVE_ALL psworg,sync     # system entry macro
         stmg    %r14,%r15,__LC_SAVE_AREA
-        tm      \psworg+1,0x01           # test problem state bit
 	stam    %a2,%a4,__LC_SAVE_AREA+16
+	larl	%r14,.Lconst
+        tm      \psworg+1,0x01           # test problem state bit
 	.if	\sync
         jz      1f                       # skip stack setup save
 	.else
@@ -69,23 +71,22 @@
 	lg	%r14,__LC_ASYNC_STACK	 # are we already on the async. stack ?
 	slgr	%r14,%r15
 	srag	%r14,%r14,14
+	larl	%r14,.Lconst
 	jz	1f
 	lg	%r15,__LC_ASYNC_STACK	 # load async. stack
 	j	1f
 	.endif
 0:	lg      %r15,__LC_KERNEL_STACK   # problem state -> load ksp
-	larl	%r14,.Lc_ac
-	lam	%a2,%a4,0(%r14)
+	lam	%a2,%a4,.Lc_ac-.Lconst(%r14)
 1:      aghi    %r15,-SP_SIZE            # make room for registers & psw
         nill    %r15,0xfff8              # align stack pointer to 8
-        stmg    %r0,%r14,SP_R0(%r15)     # store gprs 0-14 to kernel stack
+        stmg    %r0,%r13,SP_R0(%r15)     # store gprs 0-13 to kernel stack
         stg     %r2,SP_ORIG_R2(%r15)     # store original content of gpr 2
-        mvc     SP_R14(16,%r15),__LC_SAVE_AREA # move R15 to stack
+        mvc     SP_R14(16,%r15),__LC_SAVE_AREA # move r14 and r15 to stack
         stam    %a0,%a15,SP_AREGS(%r15)  # store access registers to kst.
         mvc     SP_AREGS+8(12,%r15),__LC_SAVE_AREA+16 # store ac. regs
         mvc     SP_PSW(16,%r15),\psworg  # move user PSW to stack
-        lhi     %r0,\psworg              # store trap indication
-        st      %r0,SP_TRAP(%r15)
+	mvc	SP_TRAP(4,%r15),.L\psworg-.Lconst(%r14) # store trap ind.
         xc      0(8,%r15),0(%r15)        # clear back chain
         .endm
 
@@ -160,11 +161,16 @@
 system_call:
         SAVE_ALL __LC_SVC_OLD_PSW,1
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
-        GET_THREAD_INFO           # load pointer to task_struct to R9
 	stosm   48(%r15),0x03     # reenable interrupts
+        GET_THREAD_INFO           # load pointer to task_struct to R9
+        slag    %r7,%r7,3         # *8 and test for svc 0
+	jnz	sysc_do_restart
+	# svc 0: system call number in %r1
+	clg	%r1,.Lnr_syscalls-.Lconst(%r14)
+	jnl	sysc_do_restart
+	slag    %r7,%r1,3         # svc 0: system call number in %r1
 sysc_do_restart:
 	larl    %r10,sys_call_table
-        sll     %r7,3
         tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
         jo      sysc_noemu
 	la      %r10,4(%r10)      # use 31 bit emulation system calls
@@ -231,6 +237,7 @@
 	ni	__TI_flags+3(%r9),255-_TIF_RESTART_SVC # clear TIF_RESTART_SVC
 	stosm	48(%r15),0x03          # reenable interrupts
 	lg	%r7,SP_R2(%r15)        # load new svc number
+        slag    %r7,%r7,3              # *8
 	mvc	SP_R2(8,%r15),SP_ORIG_R2(%r15) # restore first argument
 	lmg	%r2,%r6,SP_R2(%r15)    # load svc arguments
 	j	sysc_do_restart        # restart svc
@@ -651,9 +658,15 @@
 	.long  SYSCALL(sys_epoll_wait,sys_ni_syscall)
 	.long  SYSCALL(sys_set_tid_address,sys32_set_tid_address_wrapper)
 	.long  SYSCALL(sys_fadvise64,sys_ni_syscall)
-        .rept  255-253
-	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
-	.endr
+	.long  SYSCALL(sys_timer_create,sys_ni_syscall)
+	.long  SYSCALL(sys_timer_settime,sys_ni_syscall)     /* 255 */
+	.long  SYSCALL(sys_timer_gettime,sys_ni_syscall)
+	.long  SYSCALL(sys_timer_getoverrun,sys_ni_syscall)
+	.long  SYSCALL(sys_timer_delete,sys_ni_syscall)
+	.long  SYSCALL(sys_clock_settime,sys_ni_syscall)
+	.long  SYSCALL(sys_clock_gettime,sys_ni_syscall)
+	.long  SYSCALL(sys_clock_getres,sys_ni_syscall)
+	.long  SYSCALL(sys_clock_nanosleep,sys_ni_syscall)
 
 /*
  * Program check handler routine
@@ -936,6 +949,12 @@
  * Integer constants
  */
                .align 4
+.Lconst:
 .Lc_ac:        .long  0,0,1
 .Lc_pactive:   .long  PREEMPT_ACTIVE
-.Lc256:        .quad  256
+.L0x0130:      .long  0x0130
+.L0x0140:      .long  0x0140
+.L0x0150:      .long  0x0150
+.L0x0160:      .long  0x0160
+.L0x0170:      .long  0x0170
+.Lnr_syscalls: .long  NR_syscalls
diff -urN linux-2.5.66/include/asm-s390/unistd.h linux-2.5.66-s390/include/asm-s390/unistd.h
--- linux-2.5.66/include/asm-s390/unistd.h	Mon Mar 24 23:01:53 2003
+++ linux-2.5.66-s390/include/asm-s390/unistd.h	Wed Mar 26 15:45:11 2003
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
diff -urN linux-2.5.66/include/asm-s390x/unistd.h linux-2.5.66-s390/include/asm-s390x/unistd.h
--- linux-2.5.66/include/asm-s390x/unistd.h	Mon Mar 24 23:01:11 2003
+++ linux-2.5.66-s390/include/asm-s390x/unistd.h	Wed Mar 26 15:45:11 2003
@@ -216,130 +216,170 @@
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
+		"    lghi %%r1,%b1\n"			     \
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
+		"    lghi %%r1,%b1\n"			     \
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
+		"    lghi %%r1,%b1\n"			     \
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
+		"    lghi %%r1,%b1\n"			     \
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
+		"    lghi %%r1,%b1\n"			     \
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
+		"    lghi %%r1,%b1\n"			     \
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

