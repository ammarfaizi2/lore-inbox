Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbTCCSRk>; Mon, 3 Mar 2003 13:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268753AbTCCSRk>; Mon, 3 Mar 2003 13:17:40 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:59582 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S268691AbTCCSRe> convert rfc822-to-8bit; Mon, 3 Mar 2003 13:17:34 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/5): s390 arch fixes.
Date: Mon, 3 Mar 2003 19:21:10 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303031921.10825.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Initialize timing related variables first and then enable the timer interrupt.
* Normalize nano seconds to micro seconds in do_gettimeofday.
* Add types for __kernel_timer_t and __kernel_clockid_t.
* Fix ugly bug in switch_to: set prev to the return value of resume, otherwise
  prev still contains the previous process at the time resume was called and
  not the previous process at the time resume returned. They differ...
* Add missing include to get the kernel compiled.
* Get a closer match with the i386 termios.h file.

diff -urN linux-2.5.63/arch/s390/kernel/time.c linux-2.5.63-s390/arch/s390/kernel/time.c
--- linux-2.5.63/arch/s390/kernel/time.c	Mon Feb 24 20:05:05 2003
+++ linux-2.5.63-s390/arch/s390/kernel/time.c	Mon Mar  3 18:26:11 2003
@@ -202,14 +202,14 @@
 	unsigned long cr0;
 	__u64 timer;
 
-        /* allow clock comparator timer interrupt */
-        asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
-        cr0 |= 0x800;
-        asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
 	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
 	S390_lowcore.jiffy_timer = timer;
 	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
 	asm volatile ("SCKC %0" : : "m" (timer));
+        /* allow clock comparator timer interrupt */
+        asm volatile ("STCTL 0,0,%0" : "=m" (cr0) : : "memory");
+        cr0 |= 0x800;
+        asm volatile ("LCTL 0,0,%0" : : "m" (cr0) : "memory");
 }
 
 /*
diff -urN linux-2.5.63/arch/s390x/kernel/time.c linux-2.5.63-s390/arch/s390x/kernel/time.c
--- linux-2.5.63/arch/s390x/kernel/time.c	Mon Feb 24 20:05:40 2003
+++ linux-2.5.63-s390/arch/s390x/kernel/time.c	Mon Mar  3 18:26:11 2003
@@ -83,7 +83,7 @@
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec + do_gettimeoffset();
+		usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 	while (usec >= 1000000) {
@@ -187,14 +187,14 @@
 	unsigned long cr0;
 	__u64 timer;
 
-        /* allow clock comparator timer interrupt */
-        asm volatile ("STCTG 0,0,%0" : "=m" (cr0) : : "memory");
-        cr0 |= 0x800;
-        asm volatile ("LCTLG 0,0,%0" : : "m" (cr0) : "memory");
 	timer = init_timer_cc + jiffies_64 * CLK_TICKS_PER_JIFFY;
 	S390_lowcore.jiffy_timer = timer;
 	timer += CLK_TICKS_PER_JIFFY + CPU_DEVIATION;
 	asm volatile ("SCKC %0" : : "m" (timer));
+        /* allow clock comparator timer interrupt */
+        asm volatile ("STCTG 0,0,%0" : "=m" (cr0) : : "memory");
+        cr0 |= 0x800;
+        asm volatile ("LCTLG 0,0,%0" : : "m" (cr0) : "memory");
 }
 
 /*
diff -urN linux-2.5.63/include/asm-s390/posix_types.h linux-2.5.63-s390/include/asm-s390/posix_types.h
--- linux-2.5.63/include/asm-s390/posix_types.h	Mon Feb 24 20:05:04 2003
+++ linux-2.5.63-s390/include/asm-s390/posix_types.h	Mon Mar  3 18:26:11 2003
@@ -30,6 +30,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
diff -urN linux-2.5.63/include/asm-s390/signal.h linux-2.5.63-s390/include/asm-s390/signal.h
--- linux-2.5.63/include/asm-s390/signal.h	Mon Feb 24 20:05:38 2003
+++ linux-2.5.63-s390/include/asm-s390/signal.h	Mon Mar  3 18:26:11 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.63/include/asm-s390/system.h linux-2.5.63-s390/include/asm-s390/system.h
--- linux-2.5.63/include/asm-s390/system.h	Mon Feb 24 20:06:02 2003
+++ linux-2.5.63-s390/include/asm-s390/system.h	Mon Mar  3 18:26:11 2003
@@ -82,7 +82,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.63/include/asm-s390/termios.h linux-2.5.63-s390/include/asm-s390/termios.h
--- linux-2.5.63/include/asm-s390/termios.h	Mon Feb 24 20:05:14 2003
+++ linux-2.5.63-s390/include/asm-s390/termios.h	Mon Mar  3 18:26:11 2003
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
 
diff -urN linux-2.5.63/include/asm-s390x/posix_types.h linux-2.5.63-s390/include/asm-s390x/posix_types.h
--- linux-2.5.63/include/asm-s390x/posix_types.h	Mon Feb 24 20:06:01 2003
+++ linux-2.5.63-s390/include/asm-s390x/posix_types.h	Mon Mar  3 18:26:11 2003
@@ -31,6 +31,8 @@
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
 typedef int             __kernel_daddr_t;
 typedef char *          __kernel_caddr_t;
 typedef unsigned long   __kernel_sigset_t;      /* at least 32 bits */
diff -urN linux-2.5.63/include/asm-s390x/signal.h linux-2.5.63-s390/include/asm-s390x/signal.h
--- linux-2.5.63/include/asm-s390x/signal.h	Mon Feb 24 20:05:34 2003
+++ linux-2.5.63-s390/include/asm-s390x/signal.h	Mon Mar  3 18:26:11 2003
@@ -10,6 +10,7 @@
 #define _ASMS390_SIGNAL_H
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
diff -urN linux-2.5.63/include/asm-s390x/system.h linux-2.5.63-s390/include/asm-s390x/system.h
--- linux-2.5.63/include/asm-s390x/system.h	Mon Feb 24 20:05:45 2003
+++ linux-2.5.63-s390/include/asm-s390x/system.h	Mon Mar  3 18:26:11 2003
@@ -74,7 +74,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	resume(prev,next);						     \
+	prev = resume(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.5.63/include/asm-s390x/termios.h linux-2.5.63-s390/include/asm-s390x/termios.h
--- linux-2.5.63/include/asm-s390x/termios.h	Mon Feb 24 20:05:40 2003
+++ linux-2.5.63-s390/include/asm-s390x/termios.h	Mon Mar  3 18:26:11 2003
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
 

