Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273110AbTG3Ro2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 13:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273111AbTG3Ro2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 13:44:28 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:3872 "EHLO
	mars.elipse.com.br") by vger.kernel.org with ESMTP id S273110AbTG3RoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 13:44:09 -0400
Message-ID: <3F2804CC.90602@terra.com.br>
Date: Wed, 30 Jul 2003 14:47:56 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org, alan@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/riscom8.c: cli/sti removal
Content-Type: multipart/mixed;
 boundary="------------060401010702000409090405"
X-OriginalArrivalTime: 30 Jul 2003 17:49:54.0765 (UTC) FILETIME=[FBFA87D0:01C356C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060401010702000409090405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi,

	Since Dmitry Gorodchanin doesn't have a valid email, I'm sending this 
directly here.

	This patch, against 2.6-test2, replaces {save|restore}_flags and cli 
with lock spinlocks on the RISCom/8 multiport serial driver.

	Please consider applying.

	Thanks,

Felipe

--------------060401010702000409090405
Content-Type: text/plain;
 name="riscom8-cli_sti_removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="riscom8-cli_sti_removal.patch"

--- linux-2.6.0-test2/drivers/char/riscom8.c.orig	Wed Jul 30 14:39:11 2003
+++ linux-2.6.0-test2/drivers/char/riscom8.c	Wed Jul 30 14:42:44 2003
@@ -29,6 +29,9 @@
  *	ChangeLog:
  *	Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 27-Jun-2001
  *	- get rid of check_region and several cleanups
+ *
+ *	Felipe Damasio <felipewd@terra.com.br> - 30-Jul-2003
+ *	- Fixed SMP support by removing {save|restore}_flags, cli/sti
  */
 
 #include <linux/module.h>
@@ -45,6 +48,7 @@
 #include <linux/fcntl.h>
 #include <linux/major.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 
 #include <asm/uaccess.h>
 
@@ -88,6 +92,8 @@
 static unsigned char * tmp_buf;
 static DECLARE_MUTEX(tmp_buf_sem);
 
+static spinlock_t rc_lock = SPIN_LOCK_UNLOCKED;
+
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
 	9600, 19200, 38400, 57600, 76800, 0, 
@@ -237,13 +243,13 @@
 {
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	rc_out(bp, RC_CTOUT, 0);     	           /* Clear timeout             */
 	rc_wait_CCR(bp);			   /* Wait for CCR ready        */
 	rc_out(bp, CD180_CCR, CCR_HARDRESET);      /* Reset CD180 chip          */
-	sti();
+	spin_unlock_irqsave(&rc_lock, flags);
 	rc_long_delay(HZ/20);                      /* Delay 0.05 sec            */
-	cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	rc_out(bp, CD180_GIVR, RC_ID);             /* Set ID for this chip      */
 	rc_out(bp, CD180_GICR, 0);                 /* Clear all bits            */
 	rc_out(bp, CD180_PILR1, RC_ACK_MINT);      /* Prio for modem intr       */
@@ -253,8 +259,8 @@
 	/* Setting up prescaler. We need 4 ticks per 1 ms */
 	rc_out(bp, CD180_PPRH, (RC_OSCFREQ/(1000000/RISCOM_TPS)) >> 8);
 	rc_out(bp, CD180_PPRL, (RC_OSCFREQ/(1000000/RISCOM_TPS)) & 0xff);
-	
-	restore_flags(flags);
+
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 /* Main probing routine, also sets irq. */
@@ -875,7 +881,7 @@
 		port->xmit_buf = (unsigned char *) tmp;
 	}
 		
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 		
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
@@ -886,8 +892,8 @@
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
 	rc_change_speed(bp, port);
 	port->flags |= ASYNC_INITIALIZED;
-		
-	restore_flags(flags);
+
+	spin_unlock_irqsave(&rc_lock, flags);
 	return 0;
 }
 
@@ -998,19 +1004,19 @@
 	 */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	cli();
+	spin_lock(&rc_lock);
 	if (!tty_hung_up_p(filp))
 		port->count--;
-	sti();
+	spin_unlock(&rc_lock);
 	port->blocked_open++;
 	while (1) {
-		cli();
+		spin_lock(&rc_lock);
 		rc_out(bp, CD180_CAR, port_No(port));
 		CD = rc_in(bp, CD180_MSVR) & MSVR_CD;
 		rc_out(bp, CD180_MSVR, MSVR_RTS);
 		bp->DTR &= ~(1u << port_No(port));
 		rc_out(bp, RC_DTR, bp->DTR);
-		sti();
+		spin_unlock(&rc_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(port->flags & ASYNC_INITIALIZED)) {
@@ -1084,7 +1090,7 @@
 	if (!port || rc_paranoia_check(port, tty->name, "close"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	if (tty_hung_up_p(filp))
 		goto out;
 	
@@ -1153,7 +1159,7 @@
 	}
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
-out:	restore_flags(flags);
+out:	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static int rc_write(struct tty_struct * tty, int from_user, 
@@ -1172,30 +1178,31 @@
 	if (!tty || !port->xmit_buf || !tmp_buf)
 		return 0;
 
-	save_flags(flags);
 	if (from_user) {
 		down(&tmp_buf_sem);
 		while (1) {
-			cli();		
+			spin_lock_irqsave(&rc_lock, flags);
 			c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					   SERIAL_XMIT_SIZE - port->xmit_head));
-			if (c <= 0)
+			if (c <= 0){
+				spin_unlock_irqsave(&rc_lock, flags);
 				break;
+			}
 
 			c -= copy_from_user(tmp_buf, buf, c);
 			if (!c) {
 				if (!total)
 					total = -EFAULT;
+				spin_unlock_irqsave(&rc_lock, flags);
 				break;
 			}
 
-			cli();
 			c = MIN(c, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 				       SERIAL_XMIT_SIZE - port->xmit_head));
 			memcpy(port->xmit_buf + port->xmit_head, tmp_buf, c);
 			port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 			port->xmit_cnt += c;
-			restore_flags(flags);
+			spin_unlock_irqsave(&rc_lock, flags);
 
 			buf += c;
 			count -= c;
@@ -1204,18 +1211,18 @@
 		up(&tmp_buf_sem);
 	} else {
 		while (1) {
-			cli();		
+			spin_lock_irqsave(&rc_lock, flags);
 			c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					   SERIAL_XMIT_SIZE - port->xmit_head));
 			if (c <= 0) {
-				restore_flags(flags);
+				spin_unlock_irqsave(&rc_lock, flags);
 				break;
 			}
 
 			memcpy(port->xmit_buf + port->xmit_head, buf, c);
 			port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 			port->xmit_cnt += c;
-			restore_flags(flags);
+			spin_unlock_irqsave(&rc_lock, flags);
 
 			buf += c;
 			count -= c;
@@ -1223,14 +1230,14 @@
 		}
 	}
 
-	cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped &&
 	    !(port->IER & IER_TXRDY)) {
 		port->IER |= IER_TXRDY;
 		rc_out(bp, CD180_CAR, port_No(port));
 		rc_out(bp, CD180_IER, port->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 
 	return total;
 }
@@ -1246,7 +1253,7 @@
 	if (!tty || !port->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	
 	if (port->xmit_cnt >= SERIAL_XMIT_SIZE - 1)
 		goto out;
@@ -1254,7 +1261,7 @@
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	port->xmit_cnt++;
-out:	restore_flags(flags);
+out:	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static void rc_flush_chars(struct tty_struct * tty)
@@ -1269,11 +1276,11 @@
 	    !port->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	port->IER |= IER_TXRDY;
 	rc_out(port_Board(port), CD180_CAR, port_No(port));
 	rc_out(port_Board(port), CD180_IER, port->IER);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static int rc_write_room(struct tty_struct * tty)
@@ -1308,9 +1315,9 @@
 	if (rc_paranoia_check(port, tty->name, "rc_flush_buffer"))
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 	
 	wake_up_interruptible(&tty->write_wait);
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
@@ -1326,11 +1333,11 @@
 	unsigned long flags;
 
 	bp = port_Board(port);
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	rc_out(bp, CD180_CAR, port_No(port));
 	status = rc_in(bp, CD180_MSVR);
 	result = rc_in(bp, RC_RI) & (1u << port_No(port)) ? 0 : TIOCM_RNG;
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 	result |= ((status & MSVR_RTS) ? TIOCM_RTS : 0)
 		| ((status & MSVR_DTR) ? TIOCM_DTR : 0)
 		| ((status & MSVR_CD)  ? TIOCM_CAR : 0)
@@ -1370,11 +1377,11 @@
 	 default:
 		return -EINVAL;
 	}
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_MSVR, port->MSVR);
 	rc_out(bp, RC_DTR, bp->DTR);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 	return 0;
 }
 
@@ -1383,7 +1390,7 @@
 	struct riscom_board *bp = port_Board(port);
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	port->break_length = RISCOM_TPS / HZ * length;
 	port->COR2 |= COR2_ETC;
 	port->IER  |= IER_TXRDY;
@@ -1393,7 +1400,7 @@
 	rc_wait_CCR(bp);
 	rc_out(bp, CD180_CCR, CCR_CORCHG2);
 	rc_wait_CCR(bp);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static inline int rc_set_serial_info(struct riscom_port * port,
@@ -1436,9 +1443,9 @@
 		port->closing_wait = tmp.closing_wait;
 	}
 	if (change_speed)  {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&rc_lock, flags);
 		rc_change_speed(bp, port);
-		restore_flags(flags);
+		spin_unlock_irqsave(&rc_lock, flags);
 	}
 	return 0;
 }
@@ -1524,7 +1531,7 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	port->MSVR &= ~MSVR_RTS;
 	rc_out(bp, CD180_CAR, port_No(port));
 	if (I_IXOFF(tty))  {
@@ -1533,7 +1540,7 @@
 		rc_wait_CCR(bp);
 	}
 	rc_out(bp, CD180_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static void rc_unthrottle(struct tty_struct * tty)
@@ -1547,7 +1554,7 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	port->MSVR |= MSVR_RTS;
 	rc_out(bp, CD180_CAR, port_No(port));
 	if (I_IXOFF(tty))  {
@@ -1556,7 +1563,7 @@
 		rc_wait_CCR(bp);
 	}
 	rc_out(bp, CD180_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static void rc_stop(struct tty_struct * tty)
@@ -1570,11 +1577,11 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	port->IER &= ~IER_TXRDY;
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_IER, port->IER);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 static void rc_start(struct tty_struct * tty)
@@ -1588,13 +1595,13 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	if (port->xmit_cnt && port->xmit_buf && !(port->IER & IER_TXRDY))  {
 		port->IER |= IER_TXRDY;
 		rc_out(bp, CD180_CAR, port_No(port));
 		rc_out(bp, CD180_IER, port->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 /*
@@ -1646,9 +1653,9 @@
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	rc_change_speed(port_Board(port), port);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {
@@ -1751,13 +1758,12 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&rc_lock, flags);
 	remove_bh(RISCOM8_BH);
 	free_page((unsigned long)tmp_buf);
 	tty_unregister_driver(riscom_driver);
 	put_tty_driver(riscom_driver);
-	restore_flags(flags);
+	spin_unlock_irqsave(&rc_lock, flags);
 }
 
 #ifndef MODULE

--------------060401010702000409090405--

