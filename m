Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSLLSHU>; Thu, 12 Dec 2002 13:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSLLSHU>; Thu, 12 Dec 2002 13:07:20 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:25570 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264839AbSLLSHI> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (2/8): nanosleep restarting.
Date: Thu, 12 Dec 2002 19:06:46 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121906.46570.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_restart_syscall for nanosleep restarting.

diffstat:
 arch/s390/kernel/entry.S        |   32 ++++++++++++++++++++++++--------
 arch/s390/kernel/signal.c       |    9 +++++++++
 arch/s390x/kernel/entry.S       |   27 +++++++++++++++++++++------
 arch/s390x/kernel/signal.c      |    9 +++++++++
 include/asm-s390/current.h      |    2 +-
 include/asm-s390/thread_info.h  |   14 ++++++++++----
 include/asm-s390/unistd.h       |    1 +
 include/asm-s390x/current.h     |    2 +-
 include/asm-s390x/thread_info.h |   14 ++++++++++----
 include/asm-s390x/unistd.h      |    1 +
 10 files changed, 87 insertions(+), 24 deletions(-)

diff -urN linux-2.5.51/arch/s390/kernel/entry.S linux-2.5.51-s390/arch/s390/kernel/entry.S
--- linux-2.5.51/arch/s390/kernel/entry.S	Tue Dec 10 03:45:45 2002
+++ linux-2.5.51-s390/arch/s390/kernel/entry.S	Thu Dec 12 18:27:00 2002
@@ -47,7 +47,8 @@
 SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
 SP_SIZE      =  (SP_TRAP+4)
 
-_TIF_WORK_MASK = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
+_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
 /*
  * Base Address of this Module --- saved in __LC_ENTRY_BASE
@@ -181,6 +182,7 @@
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	sll	%r7,2
         stosm   24(%r15),0x03     # reenable interrupts
+sysc_do_restart:
         l       %r8,sys_call_table-entry_base(%r7,%r13) # get system call addr.
 	tm	__TI_flags+3(%r9),_TIF_SYSCALL_TRACE
         bo      BASED(sysc_tracesys)
@@ -191,7 +193,7 @@
 
 sysc_return:
 	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
-	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
 sysc_leave:
         RESTORE_ALL 1
@@ -202,7 +204,7 @@
 sysc_work_loop:
 	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
-	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bz	BASED(sysc_leave)      # there is no work to do
 #
 # One of the work bits is on. Find out which one.
@@ -213,6 +215,8 @@
 	bo	BASED(sysc_reschedule)
 	tm	__TI_flags+3(%r9),_TIF_SIGPENDING
 	bo	BASED(sysc_sigpending)
+	tm	__TI_flags+3(%r9),_TIF_RESTART_SVC
+	bo	BASED(sysc_restart)
 	b	BASED(sysc_leave)
 
 #
@@ -237,14 +241,26 @@
 	b	BASED(sysc_leave)      # out of here, do NOT recheck
 
 #
+# _TIF_RESTART_SVC is set, set up registers and restart svc
+#
+sysc_restart:
+	ni	__TI_flags+3(%r9),255-_TIF_RESTART_SVC # clear TIF_RESTART_SVC
+	stosm	24(%r15),0x03          # reenable interrupts
+	l	%r7,SP_R2(%r15)        # load new svc number
+	sll	%r7,2
+	mvc	SP_R2(4,%r15),SP_ORIG_R2(%r15) # restore first argument
+	lm	%r2,%r6,SP_R2(%r15)    # load svc arguments
+	b	BASED(sysc_do_restart) # restart svc
+
+#
 # call trace before and after sys_call
 #
 sysc_tracesys:
         l       %r1,BASED(.Ltrace)
 	srl	%r7,2
-	st	%r7,SP_R2(4,%r15)
+	st	%r7,SP_R2(%r15)
 	basr	%r14,%r1
-	l	%r7,SP_R2(4,%r15)      # strace might have changed the 
+	l	%r7,SP_R2(%r15)        # strace might have changed the 
 	n	%r7,BASED(.Lc256)      #  system call
 	sll	%r7,2
 	l	%r8,sys_call_table-entry_base(%r7,%r13)
@@ -354,7 +370,7 @@
         .long  sys_write
         .long  sys_open                  /* 5 */
         .long  sys_close
-        .long  sys_ni_syscall           /* old waitpid syscall holder */
+        .long  sys_restart_syscall
         .long  sys_creat
         .long  sys_link
         .long  sys_unlink                /* 10 */
@@ -752,7 +768,7 @@
 #else
         bno     BASED(io_leave)        # no-> skip resched & signal
 #endif
-	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bnz	BASED(io_work)         # there is work to do (signals etc.)
 io_leave:
         RESTORE_ALL 0
@@ -788,7 +804,7 @@
 io_work_loop:
         stnsm   24(%r15),0xfc          # disable I/O and ext. interrupts
         GET_THREAD_INFO                # load pointer to task_struct to R9
-	tm	__TI_flags+3(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+3(%r9),_TIF_WORK_INT
 	bz	BASED(io_leave)        # there is no work to do
 #
 # One of the work bits is on. Find out which one.
diff -urN linux-2.5.51/arch/s390/kernel/signal.c linux-2.5.51-s390/arch/s390/kernel/signal.c
--- linux-2.5.51/arch/s390/kernel/signal.c	Tue Dec 10 03:46:15 2002
+++ linux-2.5.51-s390/arch/s390/kernel/signal.c	Thu Dec 12 18:27:00 2002
@@ -397,6 +397,10 @@
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
 		switch (regs->gprs[2]) {
+			case -ERESTART_RESTARTBLOCK:
+				current_thread_info()->restart_block.fn =
+					do_no_restart_syscall;
+				clear_thread_flag(TIF_RESTART_SVC);
 			case -ERESTARTNOHAND:
 				regs->gprs[2] = -EINTR;
 				break;
@@ -473,6 +477,11 @@
 			regs->gprs[2] = regs->orig_gpr2;
 			regs->psw.addr -= 2;
 		}
+		/* Restart the system call with a new system call number */
+		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
+			regs->gprs[2] = __NR_restart_syscall;
+			set_thread_flag(TIF_RESTART_SVC);
+		}
 	}
 	return 0;
 }
diff -urN linux-2.5.51/arch/s390x/kernel/entry.S linux-2.5.51-s390/arch/s390x/kernel/entry.S
--- linux-2.5.51/arch/s390x/kernel/entry.S	Tue Dec 10 03:45:51 2002
+++ linux-2.5.51-s390/arch/s390x/kernel/entry.S	Thu Dec 12 18:27:00 2002
@@ -47,7 +47,8 @@
 SP_TRAP      =  (SP_ORIG_R2+GPR_SIZE)
 SP_SIZE      =  (SP_TRAP+4)
 
-_TIF_WORK_MASK = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
+_TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_RESTART_SVC)
+_TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NEED_RESCHED)
 
 /*
  * Register usage in interrupt handlers:
@@ -161,6 +162,7 @@
 	llgh    %r7,__LC_SVC_INT_CODE # get svc number from lowcore
         GET_THREAD_INFO           # load pointer to task_struct to R9
 	stosm   48(%r15),0x03     # reenable interrupts
+sysc_do_restart:
 	larl    %r10,sys_call_table
         sll     %r7,3
         tm      SP_PSW+3(%r15),0x01  # are we running in 31 bit mode ?
@@ -177,7 +179,7 @@
 
 sysc_return:
 	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
-	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work         # there is work to do (signals etc.)
 sysc_leave:
         RESTORE_ALL 1
@@ -188,7 +190,7 @@
 sysc_work_loop:
 	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
         GET_THREAD_INFO           # load pointer to task_struct to R9
-	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jz	sysc_leave        # there is no work to do
 #
 # One of the work bits is on. Find out which one.
@@ -199,6 +201,8 @@
 	jo	sysc_reschedule
 	tm	__TI_flags+7(%r9),_TIF_SIGPENDING
 	jo	sysc_sigpending
+	tm	__TI_flags+7(%r9),_TIF_RESTART_SVC
+	jo	sysc_restart
 	j	sysc_leave
 
 #
@@ -221,6 +225,17 @@
 	j	sysc_leave        # out of here, do NOT recheck
 
 #
+# _TIF_RESTART_SVC is set, set up registers and restart svc
+#
+sysc_restart:
+	ni	__TI_flags+3(%r9),255-_TIF_RESTART_SVC # clear TIF_RESTART_SVC
+	stosm	48(%r15),0x03          # reenable interrupts
+	lg	%r7,SP_R2(%r15)        # load new svc number
+	mvc	SP_R2(8,%r15),SP_ORIG_R2(%r15) # restore first argument
+	lmg	%r2,%r6,SP_R2(%r15)    # load svc arguments
+	j	sysc_do_restart        # restart svc
+
+#
 # call syscall_trace before and after system call
 # special linkage: %r12 contains the return address for trace_svc
 #
@@ -383,7 +398,7 @@
         .long  SYSCALL(sys_write,sys32_write_wrapper)
         .long  SYSCALL(sys_open,sys32_open_wrapper)             /* 5 */
         .long  SYSCALL(sys_close,sys32_close_wrapper)
-        .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old waitpid syscall */
+        .long  SYSCALL(sys_restart_syscall,sys_ni_syscall)
         .long  SYSCALL(sys_creat,sys32_creat_wrapper)
         .long  SYSCALL(sys_link,sys32_link_wrapper)
         .long  SYSCALL(sys_unlink,sys32_unlink_wrapper)         /* 10 */
@@ -777,7 +792,7 @@
 #else
         jno     io_leave               # no-> skip resched & signal
 #endif
-	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jnz	io_work                # there is work to do (signals etc.)
 io_leave:
         RESTORE_ALL 0
@@ -813,7 +828,7 @@
 io_work_loop:
         stnsm   48(%r15),0xfc          # disable I/O and ext. interrupts
         GET_THREAD_INFO                # load pointer to task_struct to R9
-	tm	__TI_flags+7(%r9),_TIF_WORK_MASK
+	tm	__TI_flags+7(%r9),_TIF_WORK_INT
 	jz	io_leave               # there is no work to do
 #
 # One of the work bits is on. Find out which one.
diff -urN linux-2.5.51/arch/s390x/kernel/signal.c linux-2.5.51-s390/arch/s390x/kernel/signal.c
--- linux-2.5.51/arch/s390x/kernel/signal.c	Tue Dec 10 03:46:11 2002
+++ linux-2.5.51-s390/arch/s390x/kernel/signal.c	Thu Dec 12 18:27:08 2002
@@ -391,6 +391,10 @@
 	if (regs->trap == __LC_SVC_OLD_PSW) {
 		/* If so, check system call restarting.. */
 		switch (regs->gprs[2]) {
+			case -ERESTART_RESTARTBLOCK:
+				current_thread_info()->restart_block.fn =
+					do_no_restart_syscall;
+				clear_thread_flag(TIF_RESTART_SVC);
 			case -ERESTARTNOHAND:
 				regs->gprs[2] = -EINTR;
 				break;
@@ -473,6 +477,11 @@
 			regs->gprs[2] = regs->orig_gpr2;
 			regs->psw.addr -= 2;
 		}
+		/* Restart the system call with a new system call number */
+		if (regs->gprs[2] == -ERESTART_RESTARTBLOCK) {
+			regs->gprs[2] = __NR_restart_syscall;
+			set_thread_flag(TIF_RESTART_SVC);
+		}
 	}
 	return 0;
 }
diff -urN linux-2.5.51/include/asm-s390/current.h linux-2.5.51-s390/include/asm-s390/current.h
--- linux-2.5.51/include/asm-s390/current.h	Tue Dec 10 03:46:24 2002
+++ linux-2.5.51-s390/include/asm-s390/current.h	Thu Dec 12 18:27:00 2002
@@ -13,7 +13,7 @@
 
 #ifdef __KERNEL__
 
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 
 struct task_struct;
 
diff -urN linux-2.5.51/include/asm-s390/thread_info.h linux-2.5.51-s390/include/asm-s390/thread_info.h
--- linux-2.5.51/include/asm-s390/thread_info.h	Tue Dec 10 03:46:13 2002
+++ linux-2.5.51-s390/include/asm-s390/thread_info.h	Thu Dec 12 18:27:00 2002
@@ -26,6 +26,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned int		cpu;		/* current CPU */
 	unsigned int		preempt_count; /* 0 => preemptable */
+	struct restart_block	restart_block;
 };
 
 /*
@@ -33,10 +34,13 @@
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	task:		&tsk,			\
-	exec_domain:	&default_exec_domain,	\
-	flags:		0,			\
-	cpu:		0,			\
+	.task		= &tsk,			\
+	.exec_domain	= &default_exec_domain,	\
+	.flags		= 0,			\
+	.cpu		= 0,			\
+	.restart_block	= {			\
+		.fn = do_no_restart_syscall,	\
+	},					\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
@@ -69,6 +73,7 @@
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_RESTART_SVC		4	/* restart svc with new svc number */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
@@ -77,6 +82,7 @@
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
diff -urN linux-2.5.51/include/asm-s390/unistd.h linux-2.5.51-s390/include/asm-s390/unistd.h
--- linux-2.5.51/include/asm-s390/unistd.h	Tue Dec 10 03:46:28 2002
+++ linux-2.5.51-s390/include/asm-s390/unistd.h	Thu Dec 12 18:27:00 2002
@@ -19,6 +19,7 @@
 #define __NR_write                4
 #define __NR_open                 5
 #define __NR_close                6
+#define __NR_restart_syscall	  7
 #define __NR_creat                8
 #define __NR_link                 9
 #define __NR_unlink              10
diff -urN linux-2.5.51/include/asm-s390x/current.h linux-2.5.51-s390/include/asm-s390x/current.h
--- linux-2.5.51/include/asm-s390x/current.h	Tue Dec 10 03:46:26 2002
+++ linux-2.5.51-s390/include/asm-s390x/current.h	Thu Dec 12 18:27:00 2002
@@ -13,7 +13,7 @@
 
 #ifdef __KERNEL__
 
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 
 struct task_struct;
 
diff -urN linux-2.5.51/include/asm-s390x/thread_info.h linux-2.5.51-s390/include/asm-s390x/thread_info.h
--- linux-2.5.51/include/asm-s390x/thread_info.h	Tue Dec 10 03:46:13 2002
+++ linux-2.5.51-s390/include/asm-s390x/thread_info.h	Thu Dec 12 18:27:00 2002
@@ -26,6 +26,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned int		cpu;		/* current CPU */
 	unsigned int		preempt_count;  /* 0 => preemptable */
+	struct restart_block	restart_block;
 };
 
 /*
@@ -33,10 +34,13 @@
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	task:		&tsk,			\
-	exec_domain:	&default_exec_domain,	\
-	flags:		0,			\
-	cpu:		0,			\
+	.task		= &tsk,			\
+	.exec_domain	= &default_exec_domain,	\
+	.flags		= 0,			\
+	.cpu		= 0,			\
+	.restart_block	= {			\
+		.fn = do_no_restart_syscall,	\
+	},					\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
@@ -69,6 +73,7 @@
 #define TIF_NOTIFY_RESUME	1	/* resumption notification requested */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_RESTART_SVC		4	/* restart svc with new svc number */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
@@ -77,6 +82,7 @@
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
diff -urN linux-2.5.51/include/asm-s390x/unistd.h linux-2.5.51-s390/include/asm-s390x/unistd.h
--- linux-2.5.51/include/asm-s390x/unistd.h	Tue Dec 10 03:46:13 2002
+++ linux-2.5.51-s390/include/asm-s390x/unistd.h	Thu Dec 12 18:27:00 2002
@@ -19,6 +19,7 @@
 #define __NR_write                4
 #define __NR_open                 5
 #define __NR_close                6
+#define __NR_restart_syscall	  7
 #define __NR_creat                8
 #define __NR_link                 9
 #define __NR_unlink              10

