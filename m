Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTAIOsA>; Thu, 9 Jan 2003 09:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbTAIOsA>; Thu, 9 Jan 2003 09:48:00 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14023 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266777AbTAIOr4>; Thu, 9 Jan 2003 09:47:56 -0500
Date: Thu, 9 Jan 2003 15:56:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: bjornw@axis.com, dev-etrax@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanups for arch/cris/drivers/serial.c
Message-ID: <20030109145633.GW6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the following changes to 
arch/cris/drivers/serial.c:
- remove #if'd kernel 2.0 and 2.2 compatibility code
- remove an unused #define MIN

cu
Adrian


--- linux-2.5.55/arch/cris/drivers/serial.c.old	2003-01-09 15:42:43.000000000 +0100
+++ linux-2.5.55/arch/cris/drivers/serial.c	2003-01-09 15:53:52.000000000 +0100
@@ -301,12 +301,8 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#if (LINUX_VERSION_CODE >= 131343)
 #include <linux/init.h>
-#endif
-#if (LINUX_VERSION_CODE >= 131336)
 #include <asm/uaccess.h>
-#endif
 #include <linux/kernel.h>
 
 #include <asm/io.h>
@@ -323,14 +319,6 @@
 /* while we keep our own stuff (struct e100_serial) in a local .h file */
 #include "serial.h"
 
-/*
- * All of the compatibilty code so we can compile serial.c against
- * older kernels is hidden in serial_compat.h
- */
-#if defined(LOCAL_HEADERS) || (LINUX_VERSION_CODE < 0x020317) /* 2.3.23 */
-#include "serial_compat.h"
-#endif
-
 #define _INLINE_ inline
 
 static DECLARE_TASK_QUEUE(tq_serial);
@@ -639,10 +627,6 @@
 #define E100_DSR_GET(info) ((*e100_modem_pins[(info)->line].port) & (1 << e100_modem_pins[(info)->line].dsr_bit))
 
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the memcpy_fromfs blocks while swapping in a page,
@@ -1648,12 +1632,8 @@
 
 	restore_flags(flags);
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,66)
 	/* this includes a check for low-latency */
 	tty_flip_buffer_push(tty);
-#else
-	queue_task_irq_off(&tty->flip.tqueue, &tq_timer);
-#endif
 
 	/* unthrottle if we have throttled */
 	if (E100_RTS_GET(info) &&
@@ -2600,9 +2580,7 @@
 	info->type = new_serial.type;
 	info->close_delay = new_serial.close_delay;
 	info->closing_wait = new_serial.closing_wait;
-#if (LINUX_VERSION_CODE > 0x20100)
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-#endif
 
  check_and_exit:
 	if (info->flags & ASYNC_INITIALIZED) {
@@ -2775,41 +2753,6 @@
 /*
  * This routine sends a break character out the serial port.
  */
-#if (LINUX_VERSION_CODE < 131394) /* Linux 2.1.66 */
-static void 
-send_break(struct e100_serial * info, int duration)
-{
-	unsigned long flags;	
-
-	if (!info->port)
-		return;
-
-	current->state = TASK_INTERRUPTIBLE;
-	current->timeout = jiffies + duration;
-
-	save_flags(flags);
-	cli();
-
-	/* Go to manual mode and set the txd pin to 0 */
-
-	info->tx_ctrl &= 0x3F; /* Clear bit 7 (txd) and 6 (tr_enable) */
-	info->port[REG_TR_CTRL] = info->tx_ctrl;
-
-	/* wait for "duration" jiffies */
-
-	schedule();
-
-	info->tx_ctrl |= (0x80 | 0x40); /* Set bit 7 (txd) and 6 (tr_enable) */
-	info->port[REG_TR_CTRL] = info->tx_ctrl;
-
-	/* the DMA gets awfully confused if we toggle the tranceiver like this 
-	 * so we need to reset it 
-	 */
-	*info->ocmdadr = 4;
-
-	restore_flags(flags);
-}
-#else
 static void 
 rs_break(struct tty_struct *tty, int break_state)
 {
@@ -2830,19 +2773,15 @@
 	info->port[REG_TR_CTRL] = info->tx_ctrl;
 	restore_flags(flags);
 }
-#endif
 
 static int 
 rs_ioctl(struct tty_struct *tty, struct file * file,
 	 unsigned int cmd, unsigned long arg)
 {
 	struct e100_serial * info = (struct e100_serial *)tty->driver_data;
-#if defined(CONFIG_ETRAX_RS485) || (LINUX_VERSION_CODE < 131394) /* Linux 2.1.66 */
+#if defined(CONFIG_ETRAX_RS485)
 	int error;
 #endif
-#if (LINUX_VERSION_CODE < 131394) /* Linux 2.1.66 */
-	int retval;
-#endif
 	
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGWILD)  &&
@@ -2852,45 +2791,6 @@
 	}
 	
 	switch (cmd) {
-#if (LINUX_VERSION_CODE < 131394) /* Linux 2.1.66 */
-	        case TCSBRK:	/* SVID version: non-zero arg --> no break */
-			retval = tty_check_change(tty);
-			if (retval)
-				return retval;
-			tty_wait_until_sent(tty, 0);
-			if (signal_pending(current))
-				return -EINTR;
-			if (!arg) {
-				send_break(info, HZ/4);	/* 1/4 second */
-				if (signal_pending(current))
-					return -EINTR;
-			}
-			return 0;
-		case TCSBRKP:	/* support for POSIX tcsendbreak() */
-			retval = tty_check_change(tty);
-			if (retval)
-				return retval;
-			tty_wait_until_sent(tty, 0);
-			if (signal_pending(current))
-				return -EINTR;
-			send_break(info, arg ? arg*(HZ/10) : HZ/4);
-			if (signal_pending(current))
-				return -EINTR;
-			return 0;
-		case TIOCGSOFTCAR:
-			error = verify_area(VERIFY_WRITE, (void *) arg,sizeof(long));
-			if (error)
-				return error;
-			put_fs_long(C_CLOCAL(tty) ? 1 : 0,
-				    (unsigned long *) arg);
-			return 0;
-		case TIOCSSOFTCAR:
-			arg = get_fs_long((unsigned long *) arg);
-			tty->termios->c_cflag =
-				((tty->termios->c_cflag & ~CLOCAL) |
-				 (arg ? CLOCAL : 0));
-			return 0;
-#endif
 		case TIOCMGET:
 			return get_modem_info(info, (unsigned int *) arg);
 		case TIOCMBIS:
@@ -3311,9 +3211,7 @@
 	tty->driver_data = info;
 	info->tty = tty;
 
-#if (LINUX_VERSION_CODE > 0x20100)
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
-#endif
 
 	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
@@ -3497,9 +3395,7 @@
   
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
-#if (LINUX_VERSION_CODE > 0x20100)
 	serial_driver.driver_name = "serial";
-#endif
 	serial_driver.name = "ttyS";
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
@@ -3530,14 +3426,10 @@
 	serial_driver.stop = rs_stop;
 	serial_driver.start = rs_start;
 	serial_driver.hangup = rs_hangup;
-#if (LINUX_VERSION_CODE >= 131394) /* Linux 2.1.66 */
 	serial_driver.break_ctl = rs_break;
-#endif
-#if (LINUX_VERSION_CODE >= 131343)
 	serial_driver.send_xchar = rs_send_xchar;
 	serial_driver.wait_until_sent = rs_wait_until_sent;
 	serial_driver.read_proc = rs_read_proc;
-#endif
 	  
 	/*
 	 * The callout device is just like normal device except for
@@ -3547,10 +3439,8 @@
 	callout_driver.name = "cua";
 	callout_driver.major = TTYAUX_MAJOR;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
-#if (LINUX_VERSION_CODE >= 131343)
 	callout_driver.read_proc = 0;
 	callout_driver.proc_entry = 0;
-#endif
   
 	if (tty_register_driver(&serial_driver))
 		panic("Couldn't register serial driver\n");
