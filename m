Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbTCGNaR>; Fri, 7 Mar 2003 08:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbTCGNaR>; Fri, 7 Mar 2003 08:30:17 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:25543 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261578AbTCGN3y> convert rfc822-to-8bit; Fri, 7 Mar 2003 08:29:54 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/7): s390 arch fixes.
Date: Fri, 7 Mar 2003 13:35:51 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303071335.51162.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Initialize timing related variables first and then enable the timer interrupt.
* Normalize nano seconds to micro seconds in do_gettimeofday for s390x.
* Add types for __kernel_timer_t and __kernel_clockid_t.
* Fix ugly bug in switch_to: set prev to the return value of resume, otherwise
  prev still contains the previous process at the time resume was called and
  not the previous process at the time resume returned. They differ...
* Add missing include to get the kernel compiled.
* Get a closer match with the i386 termios.h file.
* Cope with INITIAL_JIFFIES.
* Define cpu_relax to do a cpu yield on VM and LPAR.

diffstat:
 arch/s390/kernel/time.c         |   16 +++++++++-------
 arch/s390x/kernel/time.c        |   20 +++++++++++---------
 include/asm-s390/posix_types.h  |    2 ++
 include/asm-s390/processor.h    |    5 ++++-
 include/asm-s390/signal.h       |    1 +
 include/asm-s390/system.h       |    2 +-
 include/asm-s390/termios.h      |   25 ++++++++++++-------------
 include/asm-s390x/posix_types.h |    2 ++
 include/asm-s390x/processor.h   |    6 +++++-
 include/asm-s390x/signal.h      |    1 +
 include/asm-s390x/system.h      |    2 +-
 include/asm-s390x/termios.h     |   27 +++++++++++++--------------
 12 files changed, 62 insertions(+), 47 deletions(-)

diff -urN linux-2.5.64/arch/s390/kernel/time.c linux-2.5.64-s390/arch/s390/kernel/time.c
--- linux-2.5.64/arch/s390/kernel/time.c	Wed Mar  5 04:28:53 2003
+++ linux-2.5.64-s390/arch/s390/kernel/time.c	Fri Mar  7 11:40:12 2003
@@ -49,8 +49,9 @@
 u64 jiffies_64 = INITIAL_JIFFIES;
 
 static ext_int_info_t ext_int_info_timer;
-static uint64_t xtime_cc;
-static uint64_t init_timer_cc;
+static u64 init_timer_cc;
+static u64 jiffies_timer_cc;
+static u64 xtime_cc;
 
 extern unsigned long wall_jiffies;
 
@@ -70,7 +71,7 @@
 	__u64 now;
 
 	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
-        now = (now - init_timer_cc) >> 12;
+        now = (now - jiffies_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
 	return (unsigned long) now;
@@ -202,14 +203,14 @@
 	unsigned long cr0;
 	__u64 timer;
 
+	timer = jiffies_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
+	S390_lowcore.jiffy_timer = timer;
+	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (timer));
         /* allow clock comparator timer interrupt */
         asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
         cr0 |= 0x800;
         asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
-	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer = timer;
-	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
-	asm volatile ("SCKC %0" : : "m" (timer));
 }
 
 /*
@@ -239,6 +240,7 @@
                 printk("time_init: TOD clock stopped/non-operational\n");
                 break;
         }
+	jiffies_timer_cc = init_timer_cc - jiffies_64 * CLK_TICKS_PER_JIFFY;
 
 	/* set xtime */
 	xtime_cc = init_timer_cc;
diff -urN linux-2.5.64/arch/s390x/kernel/time.c linux-2.5.64-s390/arch/s390x/kernel/time.c
--- linux-2.5.64/arch/s390x/kernel/time.c	Wed Mar  5 04:29:33 2003
+++ linux-2.5.64-s390/arch/s390x/kernel/time.c	Fri Mar  7 11:40:12 2003
@@ -48,8 +48,9 @@
 u64 jiffies_64 = INITIAL_JIFFIES;
 
 static ext_int_info_t ext_int_info_timer;
-static uint64_t xtime_cc;
-static uint64_t init_timer_cc;
+static u64 init_timer_cc;
+static u64 jiffies_timer_cc;
+static u64 xtime_cc;
 
 extern unsigned long wall_jiffies;
 
@@ -65,7 +66,7 @@
 	__u64 now;
 
 	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
-        now = (now - init_timer_cc) >> 12;
+        now = (now - jiffies_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
 	return (unsigned long) now;
@@ -83,7 +84,7 @@
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec + do_gettimeoffset();
+		usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 	while (usec >= 1000000) {
@@ -99,7 +100,7 @@
 {
 
 	write_seqlock_irq(&xtime_lock);
-	/* This is revolting. We need to set the xtime.tv_usec
+	/* This is revolting. We need to set the xtime.tv_nsec
 	 * correctly. However, the value in this location is
 	 * is value at the last tick.
 	 * Discover what correction gettimeofday
@@ -187,14 +188,14 @@
 	unsigned long cr0;
 	__u64 timer;
 
+	timer = jiffies_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
+	S390_lowcore.jiffy_timer = timer;
+	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
+	asm volatile ("SCKC %0" : : "m" (timer));
         /* allow clock comparator timer interrupt */
         asm volatile ("STCTG 0,0,%0" : "=m" (cr0) : : "memory");
         cr0 |= 0x800;
         asm volatile ("LCTLG 0,0,%0" : : "m" (cr0) : "memory");
-	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
-	S390_lowcore.jiffy_timer = timer;
-	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
-	asm volatile ("SCKC %0" : : "m" (timer));
 }
 
 /*
@@ -224,6 +225,7 @@
                 printk("time_init: TOD clock stopped/non-operational\n");
                 break;
         }
+	jiffies_timer_cc = init_timer_cc - jiffies_64 * CLK_TICKS_PER_JIFFY;
 
 	/* set xtime */
 	xtime_cc = init_timer_cc;
diff -urN linux-2.5.64/include/asm-s390/posix_types.h linux-2.5.64-s390/include/asm-s390/posix_types.h
--- linux-2.5.64/include/asm-s390/posix_types.h	Wed Mar  5 04:28:53 2003
+++ linux-2.5.64-s390/include/asm-s390/posix_types.h	Fri Mar  7 11:40:12 2003
@@ -30,6 +30,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -urN linux-2.5.64/include/asm-s390/processor.h linux-2.5.64-s390/include/asm-s390/processor.h
--- linux-2.5.64/include/asm-s390/processor.h	Wed Mar  5 04:29:18 2003
+++ linux-2.5.64-s390/include/asm-s390/processor.h	Fri Mar  7 11:40:12 2003
@@ -130,7 +130,10 @@
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
-#define cpu_relax()	barrier()
+/*
+ * Give up the time slice of the virtual PU.
+ */
+#define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
 
 /*
  * Set PSW mask to specified value, while leaving the
diff -urN linux-2.5.64/include/asm-s390/signal.h linux-2.5.64-s390/include/asm-s390/signal.h
--- linux-2.5.64/include/asm-s390/signal.h	Wed Mar  5 04:29:32 2003
+++ linux-2.5.64-s390/include/asm-s390/signal.h	Fri Mar  7 11:40:12 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.64/include/asm-s390/system.h linux-2.5.64-s390/include/asm-s390/system.h
--- linux-2.5.64/include/asm-s390/system.h	Wed Mar  5 04:29:54 2003
+++ linux-2.5.64-s390/include/asm-s390/system.h	Fri Mar  7 11:40:12 2003
@@ -82,7 +82,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.64/include/asm-s390/termios.h linux-2.5.64-s390/include/asm-s390/termios.h
--- linux-2.5.64/include/asm-s390/termios.h	Wed Mar  5 04:29:04 2003
+++ linux-2.5.64-s390/include/asm-s390/termios.h	Fri Mar  7 11:40:12 2003
@@ -12,7 +12,6 @@
 #include <asm/termbits.h>
 #include <asm/ioctls.h>
 
-
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
@@ -44,7 +43,7 @@
 #define TIOCM_RI	TIOCM_RNG
 #define TIOCM_OUT1	0x2000
 #define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP      0x8000
+#define TIOCM_LOOP	0x8000
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
@@ -62,7 +61,8 @@
 #define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
 #define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
 #define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC         13	/* synchronous HDLC */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14	/* synchronous PPP */
 #define N_HCI		15  /* Bluetooth HCI UART */
 
 #ifdef __KERNEL__
@@ -78,19 +78,18 @@
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
+#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
+	unsigned short __tmp; \
+	get_user(__tmp,&(termio)->x); \
+	(termios)->x = (0xffff0000 & ((termios)->x)) | __tmp; \
+}
 
 #define user_termio_to_kernel_termios(termios, termio) \
 ({ \
-        unsigned short tmp; \
-        get_user(tmp, &(termio)->c_iflag); \
-        (termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-        get_user(tmp, &(termio)->c_oflag); \
-        (termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-        get_user(tmp, &(termio)->c_cflag); \
-        (termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-        get_user(tmp, &(termio)->c_lflag); \
-        (termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-        get_user((termios)->c_line, &(termio)->c_line); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
 	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
 })
 
diff -urN linux-2.5.64/include/asm-s390x/posix_types.h linux-2.5.64-s390/include/asm-s390x/posix_types.h
--- linux-2.5.64/include/asm-s390x/posix_types.h	Wed Mar  5 04:29:54 2003
+++ linux-2.5.64-s390/include/asm-s390x/posix_types.h	Fri Mar  7 11:40:12 2003
@@ -31,6 +31,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned long   __kernel_sigset_t;      /* at least 32 bits */
diff -urN linux-2.5.64/include/asm-s390x/processor.h linux-2.5.64-s390/include/asm-s390x/processor.h
--- linux-2.5.64/include/asm-s390x/processor.h	Wed Mar  5 04:29:33 2003
+++ linux-2.5.64-s390/include/asm-s390x/processor.h	Fri Mar  7 11:40:12 2003
@@ -145,7 +145,11 @@
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
-#define cpu_relax()	barrier()
+/*
+ * Give up the time slice of the virtual PU.
+ */
+#define cpu_relax() \
+	asm volatile ("ex 0,%0" : : "i" (__LC_DIAG44_OPCODE) : "memory")
 
 /*
  * Set PSW mask to specified value, while leaving the
diff -urN linux-2.5.64/include/asm-s390x/signal.h linux-2.5.64-s390/include/asm-s390x/signal.h
--- linux-2.5.64/include/asm-s390x/signal.h	Wed Mar  5 04:29:24 2003
+++ linux-2.5.64-s390/include/asm-s390x/signal.h	Fri Mar  7 11:40:12 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.64/include/asm-s390x/system.h linux-2.5.64-s390/include/asm-s390x/system.h
--- linux-2.5.64/include/asm-s390x/system.h	Wed Mar  5 04:29:51 2003
+++ linux-2.5.64-s390/include/asm-s390x/system.h	Fri Mar  7 11:40:12 2003
@@ -74,7 +74,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.64/include/asm-s390x/termios.h linux-2.5.64-s390/include/asm-s390x/termios.h
--- linux-2.5.64/include/asm-s390x/termios.h	Wed Mar  5 04:29:33 2003
+++ linux-2.5.64-s390/include/asm-s390x/termios.h	Fri Mar  7 11:40:12 2003
@@ -12,7 +12,6 @@
 #include <asm/termbits.h>
 #include <asm/ioctls.h>
 
-
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
@@ -44,7 +43,7 @@
 #define TIOCM_RI	TIOCM_RNG
 #define TIOCM_OUT1	0x2000
 #define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP      0x8000
+#define TIOCM_LOOP	0x8000
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 
@@ -62,8 +61,9 @@
 #define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
 #define N_IRDA		11	/* Linux IR - http://irda.sourceforge.net/ */
 #define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC         13	/* synchronous HDLC */
-#define N_HCI		15	/* Bluetooth HCI UART */
+#define N_HDLC		13	/* synchronous HDLC */
+#define N_SYNC_PPP	14	/* synchronous PPP */
+#define N_HCI		15  /* Bluetooth HCI UART */
 
 #ifdef __KERNEL__
 
@@ -78,19 +78,18 @@
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
+#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
+	unsigned short __tmp; \
+	get_user(__tmp,&(termio)->x); \
+	(termios)->x = (0xffff0000 & ((termios)->x)) | __tmp; \
+}
 
 #define user_termio_to_kernel_termios(termios, termio) \
 ({ \
-        unsigned short tmp; \
-        get_user(tmp, &(termio)->c_iflag); \
-        (termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-        get_user(tmp, &(termio)->c_oflag); \
-        (termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-        get_user(tmp, &(termio)->c_cflag); \
-        (termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-        get_user(tmp, &(termio)->c_lflag); \
-        (termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-        get_user((termios)->c_line, &(termio)->c_line); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
+	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
 	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
 })
 

