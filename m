Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUJDWzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUJDWzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUJDWzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:55:53 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:1433 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S268633AbUJDWyg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 18:54:36 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Tue, 5 Oct 2004 00:54:30 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, sebastien.hinderer@libertysurf.fr
Subject: [Patch] new serial flow control
Message-ID: <20041004225430.GF2593@bouh.is-a-geek.org>
Mail-Followup-To: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
	sebastien.hinderer@libertysurf.fr
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Some Visiobraille braille terminals (TVB) need a peculiar serial flow
control:
- There is no flow control for the PC -> device way (yes, oddly enough)
- For the device -> PC way,
  * RTS must be kept low, the device keeps CTS low as well.
  * when the device wants to send data, it raises CTS. RTS must
    be raised as well. Data can then pass, CTS and RTS are lowered.

We tried to implement that in user space, with ioctl(TIOCMBIS) & al, but
the responsiveness is too low: RTS is not raised soon enough, and the
device aborts transmission.

Here is a patch for 2.4, a 2.6 patch is coming in another mail. It
defines a CTVB flag the same way CRTSCTS is defined, letting user
space choose whether to use it or not (better ideas for the name
are welcome). This makes the device work perfectly (even better than
shipped drivers for DOS).

Applying it to vanilla kernel would be a real good thing for people
having such costly and useful hardware.

Regards,
Samuel Thibault

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tvbpatch-2.4"

diff -urp linux-2.4.26-orig/drivers/char/serial.c linux-2.4.26-tvb/drivers/char/serial.c
--- linux-2.4.26-orig/drivers/char/serial.c	2004-02-18 14:59:55.000000000 +0100
+++ linux-2.4.26-tvb/drivers/char/serial.c	2004-08-18 00:48:39.000000000 +0200
@@ -789,6 +789,26 @@ static _INLINE_ void check_modem_status(
 				serial_out(info, UART_IER, info->IER);
 			}
 		}
+	} else if (info->flags & ASYNC_TVB_FLOW) {
+		if (status & UART_MSR_CTS) {
+			if (!(info->MCR & UART_MCR_RTS)) {
+				/* start of TVB frame, raise RTS to greet data */
+				info->MCR |= UART_MCR_RTS;
+				serial_out(info, UART_MCR, info->MCR);
+#if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
+				printk("TVB frame start...");
+#endif
+			}
+		} else {
+			if (info->MCR & UART_MCR_RTS) {
+				/* CTS went down, lower RTS as well */
+				info->MCR &= ~UART_MCR_RTS;
+				serial_out(info, UART_MCR, info->MCR);
+#if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
+				printk("TVB frame started...");
+#endif
+			}
+		}
 	}
 }
 
@@ -1393,7 +1413,8 @@ static int startup(struct async_struct *
 
 	info->MCR = 0;
 	if (info->tty->termios->c_cflag & CBAUD)
-		info->MCR = UART_MCR_DTR | UART_MCR_RTS;
+		info->MCR = UART_MCR_DTR |
+			(info->flags & ASYNC_TVB_FLOW ? 0 : UART_MCR_RTS);
 #ifdef CONFIG_SERIAL_MANY_PORTS
 	if (info->flags & ASYNC_FOURPORT) {
 		if (state->irq == 0)
@@ -1752,8 +1773,12 @@ static void change_speed(struct async_st
 	if (cflag & CRTSCTS) {
 		info->flags |= ASYNC_CTS_FLOW;
 		info->IER |= UART_IER_MSI;
-	} else
-		info->flags &= ~ASYNC_CTS_FLOW;
+	} else if (cflag & CTVB) {
+		info->flags |= ASYNC_TVB_FLOW;
+		info->IER |= UART_IER_MSI;
+	} else {
+		info->flags &= ~(ASYNC_CTS_FLOW|ASYNC_TVB_FLOW);
+	}
 	if (cflag & CLOCAL)
 		info->flags &= ~ASYNC_CHECK_CD;
 	else {
@@ -3057,7 +3082,8 @@ static int block_til_ready(struct tty_st
 		    (tty->termios->c_cflag & CBAUD))
 			serial_out(info, UART_MCR,
 				   serial_inp(info, UART_MCR) |
-				   (UART_MCR_DTR | UART_MCR_RTS));
+				   (UART_MCR_DTR | 
+				    (tty->termios->c_cflag & CTVB ? 0 : UART_MCR_RTS)));
 		restore_flags(flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
diff -urp linux-2.4.26-orig/include/asm-alpha/termbits.h linux-2.4.26-tvb/include/asm-alpha/termbits.h
--- linux-2.4.26-orig/include/asm-alpha/termbits.h	1999-01-08 20:11:45.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-alpha/termbits.h	2004-08-18 00:10:30.000000000 +0200
@@ -150,6 +150,7 @@ struct termios {
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff -urp linux-2.4.26-orig/include/asm-arm/termbits.h linux-2.4.26-tvb/include/asm-arm/termbits.h
--- linux-2.4.26-orig/include/asm-arm/termbits.h	2000-08-13 18:54:15.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-arm/termbits.h	2004-08-18 00:10:52.000000000 +0200
@@ -131,6 +131,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-cris/termbits.h linux-2.4.26-tvb/include/asm-cris/termbits.h
--- linux-2.4.26-orig/include/asm-cris/termbits.h	2003-08-27 20:53:15.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-cris/termbits.h	2004-08-18 00:10:56.000000000 +0200
@@ -126,6 +126,7 @@ struct termios {
 #define  B1843200 0010006
 #define  B6250000 0010007
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity, PARODD => mark parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-i386/termbits.h linux-2.4.26-tvb/include/asm-i386/termbits.h
--- linux-2.4.26-orig/include/asm-i386/termbits.h	2000-01-21 01:05:26.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-i386/termbits.h	2004-08-18 00:11:00.000000000 +0200
@@ -133,6 +133,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-ia64/termbits.h linux-2.4.26-tvb/include/asm-ia64/termbits.h
--- linux-2.4.26-orig/include/asm-ia64/termbits.h	2004-07-18 11:55:30.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-ia64/termbits.h	2004-08-18 00:11:02.000000000 +0200
@@ -142,6 +142,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-m68k/termbits.h linux-2.4.26-tvb/include/asm-m68k/termbits.h
--- linux-2.4.26-orig/include/asm-m68k/termbits.h	1999-01-08 20:11:45.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-m68k/termbits.h	2004-08-18 00:11:06.000000000 +0200
@@ -134,6 +134,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-mips/termbits.h linux-2.4.26-tvb/include/asm-mips/termbits.h
--- linux-2.4.26-orig/include/asm-mips/termbits.h	2001-09-09 19:43:01.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-mips/termbits.h	2004-08-18 00:11:09.000000000 +0200
@@ -161,6 +161,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000	/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-mips64/termbits.h linux-2.4.26-tvb/include/asm-mips64/termbits.h
--- linux-2.4.26-orig/include/asm-mips64/termbits.h	2001-09-09 19:43:02.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-mips64/termbits.h	2004-08-18 00:11:12.000000000 +0200
@@ -163,6 +163,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000	/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-parisc/termbits.h linux-2.4.26-tvb/include/asm-parisc/termbits.h
--- linux-2.4.26-orig/include/asm-parisc/termbits.h	2000-12-05 21:29:39.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-parisc/termbits.h	2004-08-18 00:12:01.000000000 +0200
@@ -134,6 +134,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD    002003600000  /* input baud rate (not used) */
+#define CTVB      004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000          /* mark or space (stick) parity */
 #define CRTSCTS   020000000000          /* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-ppc/termbits.h linux-2.4.26-tvb/include/asm-ppc/termbits.h
--- linux-2.4.26-orig/include/asm-ppc/termbits.h	2003-06-14 02:30:26.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-ppc/termbits.h	2004-08-18 00:11:20.000000000 +0200
@@ -146,6 +146,7 @@ struct termios {
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff -urp linux-2.4.26-orig/include/asm-ppc64/termbits.h linux-2.4.26-tvb/include/asm-ppc64/termbits.h
--- linux-2.4.26-orig/include/asm-ppc64/termbits.h	2002-08-03 23:05:34.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-ppc64/termbits.h	2004-08-18 00:11:22.000000000 +0200
@@ -154,6 +154,7 @@ struct termios {
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff -urp linux-2.4.26-orig/include/asm-s390/termbits.h linux-2.4.26-tvb/include/asm-s390/termbits.h
--- linux-2.4.26-orig/include/asm-s390/termbits.h	2000-05-12 20:41:44.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-s390/termbits.h	2004-08-18 00:11:25.000000000 +0200
@@ -141,6 +141,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-s390x/termbits.h linux-2.4.26-tvb/include/asm-s390x/termbits.h
--- linux-2.4.26-orig/include/asm-s390x/termbits.h	2001-02-13 23:13:44.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-s390x/termbits.h	2004-08-18 00:11:28.000000000 +0200
@@ -141,6 +141,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-sh/termbits.h linux-2.4.26-tvb/include/asm-sh/termbits.h
--- linux-2.4.26-orig/include/asm-sh/termbits.h	1999-10-18 20:16:13.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-sh/termbits.h	2004-08-18 00:11:30.000000000 +0200
@@ -133,6 +133,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-sh64/termbits.h linux-2.4.26-tvb/include/asm-sh64/termbits.h
--- linux-2.4.26-orig/include/asm-sh64/termbits.h	2003-08-27 20:53:26.000000000 +0200
+++ linux-2.4.26-tvb/include/asm-sh64/termbits.h	2004-08-18 00:11:32.000000000 +0200
@@ -144,6 +144,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-sparc/termbits.h linux-2.4.26-tvb/include/asm-sparc/termbits.h
--- linux-2.4.26-orig/include/asm-sparc/termbits.h	2002-11-29 13:24:06.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-sparc/termbits.h	2004-08-18 00:12:23.000000000 +0200
@@ -173,6 +173,7 @@ struct termios {
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
 #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
+#define CTVB	  0x20000000  /* VisioBraille Terminal flow control */
 #define CMSPAR	  0x40000000  /* mark or space (stick) parity */
 #define CRTSCTS	  0x80000000  /* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-sparc64/termbits.h linux-2.4.26-tvb/include/asm-sparc64/termbits.h
--- linux-2.4.26-orig/include/asm-sparc64/termbits.h	2002-11-29 13:24:06.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-sparc64/termbits.h	2004-08-18 00:12:36.000000000 +0200
@@ -174,6 +174,7 @@ struct termios {
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
 #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
+#define CTVB	  0x20000000  /* VisioBraille Terminal flow control */
 #define CMSPAR    0x40000000  /* mark or space (stick) parity */
 #define CRTSCTS	  0x80000000  /* flow control */
 
diff -urp linux-2.4.26-orig/include/asm-x86_64/termbits.h linux-2.4.26-tvb/include/asm-x86_64/termbits.h
--- linux-2.4.26-orig/include/asm-x86_64/termbits.h	2002-11-29 13:24:06.000000000 +0100
+++ linux-2.4.26-tvb/include/asm-x86_64/termbits.h	2004-08-18 00:13:11.000000000 +0200
@@ -133,6 +133,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -urp linux-2.4.26-orig/include/linux/serial.h linux-2.4.26-tvb/include/linux/serial.h
--- linux-2.4.26-orig/include/linux/serial.h	2004-07-18 12:05:46.000000000 +0200
+++ linux-2.4.26-tvb/include/linux/serial.h	2004-08-18 00:34:20.000000000 +0200
@@ -141,7 +141,8 @@ struct serial_uart_config {
 #define ASYNC_CONS_FLOW		0x00800000 /* flow control for console  */
 
 #define ASYNC_BOOT_ONLYMCA	0x00400000 /* Probe only if MCA bus */
-#define ASYNC_INTERNAL_FLAGS	0xFFC00000 /* Internal flags */
+#define ASYNC_TVB_FLOW		0x00200000 /* Do VisioBraille flow control */
+#define ASYNC_INTERNAL_FLAGS	0xFFE00000 /* Internal flags */
 
 /*
  * Multiport serial configuration structure --- external structure
diff -urp linux-2.4.26-orig/include/linux/tty.h linux-2.4.26-tvb/include/linux/tty.h
--- linux-2.4.26-orig/include/linux/tty.h	2004-07-18 12:05:17.000000000 +0200
+++ linux-2.4.26-tvb/include/linux/tty.h	2004-08-18 00:23:37.000000000 +0200
@@ -224,6 +224,7 @@ struct tty_flip_buffer {
 #define C_HUPCL(tty)	_C_FLAG((tty),HUPCL)
 #define C_CLOCAL(tty)	_C_FLAG((tty),CLOCAL)
 #define C_CIBAUD(tty)	_C_FLAG((tty),CIBAUD)
+#define C_CTVB(tty)	_C_FLAG((tty),CTVB)
 #define C_CRTSCTS(tty)	_C_FLAG((tty),CRTSCTS)
 
 #define L_ISIG(tty)	_L_FLAG((tty),ISIG)

--dDRMvlgZJXvWKvBx--
