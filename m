Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbUEGOyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUEGOyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263616AbUEGOyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:54:40 -0400
Received: from port-212-202-104-142.reverse.qsc.de ([212.202.104.142]:28691
	"EHLO imail.microdata-pos.de") by vger.kernel.org with ESMTP
	id S263623AbUEGOyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:54:15 -0400
Date: Fri, 7 May 2004 16:54:13 +0200
From: Michael Westermann <mw@microdata-pos.de>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: [RFC] handshake variable with DTR DSR DCD ...
Message-ID: <20040507165413.D16132@microdata-pos.de>
Mail-Followup-To: Michael Westermann <mw@microdata-pos.de>,
	"Theodore Y. Ts'o" <tytso@MIT.EDU>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a patch to allow arbitrary serial status lines to be
used for hardware handshake. It's mainly useful for DTR/DSR
handshake.


diff -Nurp linux-2.4.26.old/drivers/char/serial.c linux-2.4.26/drivers/char/serial.c
--- linux-2.4.26.old/drivers/char/serial.c	2004-02-18 14:36:31.000000000 +0100
+++ linux-2.4.26/drivers/char/serial.c	2004-05-07 16:42:19.000000000 +0200
@@ -769,9 +769,12 @@ static _INLINE_ void check_modem_status(
 	}
 	if (info->flags & ASYNC_CTS_FLOW) {
 		if (info->tty->hw_stopped) {
-			if (status & UART_MSR_CTS) {
+			if (status & info->status_flow) {
 #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
-				printk("CTS tx start...");
+				if (info->status_flow & UART_MSR_CTS)
+					printk("CTS tx start...");
+				else 
+				    	printk("HW %x tx start...", info->status_flow);
 #endif
 				info->tty->hw_stopped = 0;
 				info->IER |= UART_IER_THRI;
@@ -780,9 +783,12 @@ static _INLINE_ void check_modem_status(
 				return;
 			}
 		} else {
-			if (!(status & UART_MSR_CTS)) {
+			if (!(status & info->status_flow)) {
 #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
-				printk("CTS tx stop...");
+				if (info->status_flow & UART_MSR_CTS)
+				    	printk("CTS tx stop...");
+				else
+				    	printk("HW %x tx stop...", info->status_flow);
 #endif
 				info->tty->hw_stopped = 1;
 				info->IER &= ~UART_IER_THRI;
@@ -1749,9 +1755,13 @@ static void change_speed(struct async_st
 	info->IER &= ~UART_IER_MSI;
 	if (info->flags & ASYNC_HARDPPS_CD)
 		info->IER |= UART_IER_MSI;
-	if (cflag & CRTSCTS) {
+	if (cflag & (CRTSCTS|CHWFLOW)) {
 		info->flags |= ASYNC_CTS_FLOW;
 		info->IER |= UART_IER_MSI;
+		if (!(cflag & CHWFLOW)) {
+			info->status_flow = UART_MSR_CTS;
+			info->modem_flow  = UART_MCR_RTS;
+		}
 	} else
 		info->flags &= ~ASYNC_CTS_FLOW;
 	if (cflag & CLOCAL)
@@ -2018,8 +2028,8 @@ static void rs_throttle(struct tty_struc
 	if (I_IXOFF(tty))
 		rs_send_xchar(tty, STOP_CHAR(tty));
 
-	if (tty->termios->c_cflag & CRTSCTS)
-		info->MCR &= ~UART_MCR_RTS;
+	if (tty->termios->c_cflag & (CRTSCTS|CHWFLOW))
+		info->MCR &= ~info->modem_flow;
 
 	save_flags(flags); cli();
 	serial_out(info, UART_MCR, info->MCR);
@@ -2046,8 +2056,8 @@ static void rs_unthrottle(struct tty_str
 		else
 			rs_send_xchar(tty, START_CHAR(tty));
 	}
-	if (tty->termios->c_cflag & CRTSCTS)
-		info->MCR |= UART_MCR_RTS;
+	if (tty->termios->c_cflag & (CRTSCTS|CHWFLOW))
+		info->MCR |= info->modem_flow;
 	save_flags(flags); cli();
 	serial_out(info, UART_MCR, info->MCR);
 	restore_flags(flags);
@@ -2352,6 +2362,46 @@ static int set_modem_info(struct async_s
 			     | ((arg & TIOCM_LOOP) ? UART_MCR_LOOP : 0)
 			     | ((arg & TIOCM_DTR) ? UART_MCR_DTR : 0));
 		break;
+	case TIOHWFLOWBIS: 
+		if (arg & TIOCM_RTS)
+			info->modem_flow |= UART_MCR_RTS;
+		if (arg & TIOCM_DTR)
+			info->modem_flow |= UART_MCR_DTR;
+#ifdef TIOCM_OUT1
+		if (arg & TIOCM_OUT1)
+			info->modem_flow |= UART_MCR_OUT1;
+		if (arg & TIOCM_OUT2)
+			info->modem_flow |= UART_MCR_OUT2;
+#endif
+		if (arg & TIOCM_CTS) 
+			info->status_flow |= UART_MSR_CTS;
+		if (arg & TIOCM_DSR) 
+			info->status_flow |= UART_MSR_DSR;
+		if (arg & TIOCM_RI)
+			info->status_flow |= UART_MSR_RI;
+		if (arg & TIOCM_CD)
+			info->status_flow |= UART_MSR_DCD;
+		break;
+	case TIOHWFLOWBIC:
+		if (arg & TIOCM_RTS)
+			info->modem_flow &= ~UART_MCR_RTS;
+		if (arg & TIOCM_DTR)
+			info->modem_flow &= ~UART_MCR_DTR;
+#ifdef TIOCM_OUT1
+		if (arg & TIOCM_OUT1)
+			info->modem_flow &= ~UART_MCR_OUT1;
+		if (arg & TIOCM_OUT2)
+			info->modem_flow &= ~UART_MCR_OUT2;
+#endif
+		if (arg & TIOCM_CTS) 
+			info->status_flow &= ~UART_MSR_CTS;
+		if (arg & TIOCM_DSR) 
+			info->status_flow &= ~UART_MSR_DSR;
+		if (arg & TIOCM_RI)
+			info->status_flow &= ~UART_MSR_RI;
+		if (arg & TIOCM_CD)
+			info->status_flow &= ~UART_MSR_DCD;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2605,6 +2655,8 @@ static int rs_ioctl(struct tty_struct *t
 #endif
 		case TIOCMGET:
 			return get_modem_info(info, (unsigned int *) arg);
+	        case TIOHWFLOWBIS: 
+	        case TIOHWFLOWBIC: 
 		case TIOCMBIS:
 		case TIOCMBIC:
 		case TIOCMSET:
@@ -2734,9 +2786,9 @@ static void rs_set_termios(struct tty_st
 	if (!(old_termios->c_cflag & CBAUD) &&
 	    (cflag & CBAUD)) {
 		info->MCR |= UART_MCR_DTR;
-		if (!(tty->termios->c_cflag & CRTSCTS) || 
+		if (!(tty->termios->c_cflag & (CRTSCTS|CHWFLOW)) || 
 		    !test_bit(TTY_THROTTLED, &tty->flags)) {
-			info->MCR |= UART_MCR_RTS;
+			info->MCR |= info->status_flow;
 		}
 		save_flags(flags); cli();
 		serial_out(info, UART_MCR, info->MCR);
@@ -2744,8 +2796,8 @@ static void rs_set_termios(struct tty_st
 	}
 	
 	/* Handle turning off CRTSCTS */
-	if ((old_termios->c_cflag & CRTSCTS) &&
-	    !(tty->termios->c_cflag & CRTSCTS)) {
+	if ((old_termios->c_cflag & (CRTSCTS|CHWFLOW)) &&
+	    !(tty->termios->c_cflag & (CRTSCTS|CHWFLOW))) {
 		tty->hw_stopped = 0;
 		rs_start(tty);
 	}
diff -Nurp linux-2.4.26.old/include/asm-i386/ioctls.h linux-2.4.26/include/asm-i386/ioctls.h
--- linux-2.4.26.old/include/asm-i386/ioctls.h	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.26/include/asm-i386/ioctls.h	2004-05-07 13:48:28.000000000 +0200
@@ -68,6 +68,8 @@
 #define TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
 #define FIOQSIZE	0x5460
+#define TIOHWFLOWBIS	0x5461	/* Set  hardware flow Control  */
+#define TIOHWFLOWBIC	0x5462  /* Clear  hardware flow Control  */
 
 /* Used for packet mode */
 #define TIOCPKT_DATA		 0
diff -Nurp linux-2.4.26.old/include/asm-i386/termbits.h linux-2.4.26/include/asm-i386/termbits.h
--- linux-2.4.26.old/include/asm-i386/termbits.h	2000-01-21 01:05:26.000000000 +0100
+++ linux-2.4.26/include/asm-i386/termbits.h	2004-05-07 16:43:39.000000000 +0200
@@ -132,6 +132,7 @@ struct termios {
 #define  B3000000 0010015
 #define  B3500000 0010016
 #define  B4000000 0010017
+#define CHWFLOW   001000000000	/* flexible hw flow_ctrl */
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
diff -Nurp linux-2.4.26.old/include/linux/serialP.h linux-2.4.26/include/linux/serialP.h
--- linux-2.4.26.old/include/linux/serialP.h	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.26/include/linux/serialP.h	2004-05-07 14:06:30.000000000 +0200
@@ -68,6 +68,8 @@ struct async_struct {
 	int			timeout;
 	int			quot;
 	int			x_char;	/* xon/xoff character */
+	int			status_flow;	/* status mask hw-flowcontrol */
+	int			modem_flow;	/* modem  mask hw-flowcontrol */
 	int			close_delay;
 	unsigned short		closing_wait;
 	unsigned short		closing_wait2;

It's only i386 yet, but please comment on it!


