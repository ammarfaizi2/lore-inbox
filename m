Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWJMLhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWJMLhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWJMLhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:37:12 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:20374 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751368AbWJMLhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:37:10 -0400
Subject: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti() removal
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 17:10:28 +0530
Message-Id: <1160739628.19143.376.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed save_flags()/cli()/sti() and used (light weight) spin locks

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
--- linux-2.6.19-rc1-orig/drivers/char/riscom8.c	2006-10-05 14:00:43.000000000 +0530
+++ linux-2.6.19-rc1/drivers/char/riscom8.c	2006-10-13 17:06:44.000000000 +0530
@@ -81,6 +81,7 @@
 
 static struct riscom_board * IRQ_to_board[16];
 static struct tty_driver *riscom_driver;
+spinlock_t riscom_lock = SPIN_LOCK_UNLOCKED;
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
@@ -231,13 +232,13 @@ static void __init rc_init_CD180(struct 
 {
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	rc_out(bp, RC_CTOUT, 0);     	           /* Clear timeout             */
 	rc_wait_CCR(bp);			   /* Wait for CCR ready        */
 	rc_out(bp, CD180_CCR, CCR_HARDRESET);      /* Reset CD180 chip          */
-	sti();
+	spin_unlock_irq(&riscom_lock);
 	rc_long_delay(HZ/20);                      /* Delay 0.05 sec            */
-	cli();
+	spin_lock_irq(&riscom_lock);
 	rc_out(bp, CD180_GIVR, RC_ID);             /* Set ID for this chip      */
 	rc_out(bp, CD180_GICR, 0);                 /* Clear all bits            */
 	rc_out(bp, CD180_PILR1, RC_ACK_MINT);      /* Prio for modem intr       */
@@ -248,7 +249,7 @@ static void __init rc_init_CD180(struct 
 	rc_out(bp, CD180_PPRH, (RC_OSCFREQ/(1000000/RISCOM_TPS)) >> 8);
 	rc_out(bp, CD180_PPRL, (RC_OSCFREQ/(1000000/RISCOM_TPS)) & 0xff);
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 /* Main probing routine, also sets irq. */
@@ -832,7 +833,7 @@ static int rc_setup_port(struct riscom_b
 		port->xmit_buf = (unsigned char *) tmp;
 	}
 		
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 		
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
@@ -844,7 +845,7 @@ static int rc_setup_port(struct riscom_b
 	rc_change_speed(bp, port);
 	port->flags |= ASYNC_INITIALIZED;
 		
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 	return 0;
 }
 
@@ -955,19 +956,19 @@ static int block_til_ready(struct tty_st
 	 */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	cli();
+	spin_lock_irq(&riscom_lock);
 	if (!tty_hung_up_p(filp))
 		port->count--;
-	sti();
+	spin_unlock_irq(&riscom_lock);
 	port->blocked_open++;
 	while (1) {
-		cli();
+		spin_lock_irq(&riscom_lock);
 		rc_out(bp, CD180_CAR, port_No(port));
 		CD = rc_in(bp, CD180_MSVR) & MSVR_CD;
 		rc_out(bp, CD180_MSVR, MSVR_RTS);
 		bp->DTR &= ~(1u << port_No(port));
 		rc_out(bp, RC_DTR, bp->DTR);
-		sti();
+		spin_unlock_irq(&riscom_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(port->flags & ASYNC_INITIALIZED)) {
@@ -1040,7 +1041,7 @@ static void rc_close(struct tty_struct *
 	if (!port || rc_paranoia_check(port, tty->name, "close"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	if (tty_hung_up_p(filp))
 		goto out;
 	
@@ -1107,7 +1108,8 @@ static void rc_close(struct tty_struct *
 	}
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
-out:	restore_flags(flags);
+out:	
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static int rc_write(struct tty_struct * tty, 
@@ -1126,34 +1128,34 @@ static int rc_write(struct tty_struct * 
 	if (!tty || !port->xmit_buf)
 		return 0;
 
-	save_flags(flags);
+	local_save_flags(flags);
 	while (1) {
-		cli();		
+		spin_lock_irq(&riscom_lock);
 		c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					  SERIAL_XMIT_SIZE - port->xmit_head));
 		if (c <= 0) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&riscom_lock, flags);
 			break;
 		}
 
 		memcpy(port->xmit_buf + port->xmit_head, buf, c);
 		port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 		port->xmit_cnt += c;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&riscom_lock, flags);
 
 		buf += c;
 		count -= c;
 		total += c;
 	}
 
-	cli();
+	spin_lock_irq(&riscom_lock);
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped &&
 	    !(port->IER & IER_TXRDY)) {
 		port->IER |= IER_TXRDY;
 		rc_out(bp, CD180_CAR, port_No(port));
 		rc_out(bp, CD180_IER, port->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 
 	return total;
 }
@@ -1169,7 +1171,7 @@ static void rc_put_char(struct tty_struc
 	if (!tty || !port->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	
 	if (port->xmit_cnt >= SERIAL_XMIT_SIZE - 1)
 		goto out;
@@ -1177,7 +1179,8 @@ static void rc_put_char(struct tty_struc
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	port->xmit_cnt++;
-out:	restore_flags(flags);
+out:	
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static void rc_flush_chars(struct tty_struct * tty)
@@ -1192,11 +1195,11 @@ static void rc_flush_chars(struct tty_st
 	    !port->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->IER |= IER_TXRDY;
 	rc_out(port_Board(port), CD180_CAR, port_No(port));
 	rc_out(port_Board(port), CD180_IER, port->IER);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static int rc_write_room(struct tty_struct * tty)
@@ -1231,9 +1234,9 @@ static void rc_flush_buffer(struct tty_s
 	if (rc_paranoia_check(port, tty->name, "rc_flush_buffer"))
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 	
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
@@ -1251,11 +1254,11 @@ static int rc_tiocmget(struct tty_struct
 		return -ENODEV;
 
 	bp = port_Board(port);
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	rc_out(bp, CD180_CAR, port_No(port));
 	status = rc_in(bp, CD180_MSVR);
 	result = rc_in(bp, RC_RI) & (1u << port_No(port)) ? 0 : TIOCM_RNG;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 	result |= ((status & MSVR_RTS) ? TIOCM_RTS : 0)
 		| ((status & MSVR_DTR) ? TIOCM_DTR : 0)
 		| ((status & MSVR_CD)  ? TIOCM_CAR : 0)
@@ -1276,7 +1279,7 @@ static int rc_tiocmset(struct tty_struct
 
 	bp = port_Board(port);
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	if (set & TIOCM_RTS)
 		port->MSVR |= MSVR_RTS;
 	if (set & TIOCM_DTR)
@@ -1290,7 +1293,7 @@ static int rc_tiocmset(struct tty_struct
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_MSVR, port->MSVR);
 	rc_out(bp, RC_DTR, bp->DTR);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 	return 0;
 }
 
@@ -1299,7 +1302,7 @@ static inline void rc_send_break(struct 
 	struct riscom_board *bp = port_Board(port);
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->break_length = RISCOM_TPS / HZ * length;
 	port->COR2 |= COR2_ETC;
 	port->IER  |= IER_TXRDY;
@@ -1309,7 +1312,7 @@ static inline void rc_send_break(struct 
 	rc_wait_CCR(bp);
 	rc_out(bp, CD180_CCR, CCR_CORCHG2);
 	rc_wait_CCR(bp);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static inline int rc_set_serial_info(struct riscom_port * port,
@@ -1352,9 +1355,9 @@ static inline int rc_set_serial_info(str
 		port->closing_wait = tmp.closing_wait;
 	}
 	if (change_speed)  {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&riscom_lock, flags);
 		rc_change_speed(bp, port);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&riscom_lock, flags);
 	}
 	return 0;
 }
@@ -1435,7 +1438,7 @@ static void rc_throttle(struct tty_struc
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->MSVR &= ~MSVR_RTS;
 	rc_out(bp, CD180_CAR, port_No(port));
 	if (I_IXOFF(tty))  {
@@ -1444,7 +1447,7 @@ static void rc_throttle(struct tty_struc
 		rc_wait_CCR(bp);
 	}
 	rc_out(bp, CD180_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static void rc_unthrottle(struct tty_struct * tty)
@@ -1458,7 +1461,7 @@ static void rc_unthrottle(struct tty_str
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->MSVR |= MSVR_RTS;
 	rc_out(bp, CD180_CAR, port_No(port));
 	if (I_IXOFF(tty))  {
@@ -1467,7 +1470,7 @@ static void rc_unthrottle(struct tty_str
 		rc_wait_CCR(bp);
 	}
 	rc_out(bp, CD180_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static void rc_stop(struct tty_struct * tty)
@@ -1481,11 +1484,11 @@ static void rc_stop(struct tty_struct * 
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	port->IER &= ~IER_TXRDY;
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_IER, port->IER);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 static void rc_start(struct tty_struct * tty)
@@ -1499,13 +1502,13 @@ static void rc_start(struct tty_struct *
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	if (port->xmit_cnt && port->xmit_buf && !(port->IER & IER_TXRDY))  {
 		port->IER |= IER_TXRDY;
 		rc_out(bp, CD180_CAR, port_No(port));
 		rc_out(bp, CD180_IER, port->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 /*
@@ -1557,9 +1560,9 @@ static void rc_set_termios(struct tty_st
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	rc_change_speed(port_Board(port), port);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {
@@ -1648,11 +1651,10 @@ static void rc_release_drivers(void)
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&riscom_lock, flags);
 	tty_unregister_driver(riscom_driver);
 	put_tty_driver(riscom_driver);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&riscom_lock, flags);
 }
 
 #ifndef MODULE


