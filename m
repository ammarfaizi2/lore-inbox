Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVAPOJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVAPOJL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 09:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVAPOHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 09:07:01 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:21458 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262513AbVAPNxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:53:41 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135338.30109.11810.59816@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 11/13] riscom8: remove cli()/sti() in drivers/char/riscom8.c
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:53:38 -0600
Date: Sun, 16 Jan 2005 07:53:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/riscom8.c linux-2.6.11-rc1-mm1/drivers/char/riscom8.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/riscom8.c	2004-12-24 16:34:44.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/riscom8.c	2005-01-16 07:32:19.510528165 -0500
@@ -232,13 +232,13 @@
 {
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	rc_out(bp, RC_CTOUT, 0);     	           /* Clear timeout             */
 	rc_wait_CCR(bp);			   /* Wait for CCR ready        */
 	rc_out(bp, CD180_CCR, CCR_HARDRESET);      /* Reset CD180 chip          */
-	sti();
+	local_irq_enable();
 	rc_long_delay(HZ/20);                      /* Delay 0.05 sec            */
-	cli();
+	local_irq_disable();
 	rc_out(bp, CD180_GIVR, RC_ID);             /* Set ID for this chip      */
 	rc_out(bp, CD180_GICR, 0);                 /* Clear all bits            */
 	rc_out(bp, CD180_PILR1, RC_ACK_MINT);      /* Prio for modem intr       */
@@ -249,7 +249,7 @@
 	rc_out(bp, CD180_PPRH, (RC_OSCFREQ/(1000000/RISCOM_TPS)) >> 8);
 	rc_out(bp, CD180_PPRL, (RC_OSCFREQ/(1000000/RISCOM_TPS)) & 0xff);
 	
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /* Main probing routine, also sets irq. */
@@ -861,7 +861,7 @@
 		port->xmit_buf = (unsigned char *) tmp;
 	}
 		
-	save_flags(flags); cli();
+	local_irq_save(flags);
 		
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
@@ -873,7 +873,7 @@
 	rc_change_speed(bp, port);
 	port->flags |= ASYNC_INITIALIZED;
 		
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -984,19 +984,19 @@
 	 */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	cli();
+	local_irq_disable();
 	if (!tty_hung_up_p(filp))
 		port->count--;
-	sti();
+	local_irq_enable();
 	port->blocked_open++;
 	while (1) {
-		cli();
+		local_irq_disable();
 		rc_out(bp, CD180_CAR, port_No(port));
 		CD = rc_in(bp, CD180_MSVR) & MSVR_CD;
 		rc_out(bp, CD180_MSVR, MSVR_RTS);
 		bp->DTR &= ~(1u << port_No(port));
 		rc_out(bp, RC_DTR, bp->DTR);
-		sti();
+		local_irq_enable();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(port->flags & ASYNC_INITIALIZED)) {
@@ -1069,7 +1069,7 @@
 	if (!port || rc_paranoia_check(port, tty->name, "close"))
 		return;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (tty_hung_up_p(filp))
 		goto out;
 	
@@ -1136,7 +1136,7 @@
 	}
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
-out:	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 static int rc_write(struct tty_struct * tty, 
@@ -1155,34 +1155,34 @@
 	if (!tty || !port->xmit_buf || !tmp_buf)
 		return 0;
 
-	save_flags(flags);
+	local_save_flags(flags);
 	while (1) {
-		cli();		
+		local_irq_disable();		
 		c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					  SERIAL_XMIT_SIZE - port->xmit_head));
 		if (c <= 0) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			break;
 		}
 
 		memcpy(port->xmit_buf + port->xmit_head, buf, c);
 		port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 		port->xmit_cnt += c;
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 		buf += c;
 		count -= c;
 		total += c;
 	}
 
-	cli();
+	local_irq_disable();
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped &&
 	    !(port->IER & IER_TXRDY)) {
 		port->IER |= IER_TXRDY;
 		rc_out(bp, CD180_CAR, port_No(port));
 		rc_out(bp, CD180_IER, port->IER);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return total;
 }
@@ -1198,7 +1198,7 @@
 	if (!tty || !port->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	
 	if (port->xmit_cnt >= SERIAL_XMIT_SIZE - 1)
 		goto out;
@@ -1206,7 +1206,7 @@
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	port->xmit_cnt++;
-out:	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 static void rc_flush_chars(struct tty_struct * tty)
@@ -1221,11 +1221,11 @@
 	    !port->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	port->IER |= IER_TXRDY;
 	rc_out(port_Board(port), CD180_CAR, port_No(port));
 	rc_out(port_Board(port), CD180_IER, port->IER);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int rc_write_room(struct tty_struct * tty)
@@ -1260,9 +1260,9 @@
 	if (rc_paranoia_check(port, tty->name, "rc_flush_buffer"))
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
@@ -1280,11 +1280,11 @@
 		return -ENODEV;
 
 	bp = port_Board(port);
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	rc_out(bp, CD180_CAR, port_No(port));
 	status = rc_in(bp, CD180_MSVR);
 	result = rc_in(bp, RC_RI) & (1u << port_No(port)) ? 0 : TIOCM_RNG;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	result |= ((status & MSVR_RTS) ? TIOCM_RTS : 0)
 		| ((status & MSVR_DTR) ? TIOCM_DTR : 0)
 		| ((status & MSVR_CD)  ? TIOCM_CAR : 0)
@@ -1305,7 +1305,7 @@
 
 	bp = port_Board(port);
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (set & TIOCM_RTS)
 		port->MSVR |= MSVR_RTS;
 	if (set & TIOCM_DTR)
@@ -1319,7 +1319,7 @@
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_MSVR, port->MSVR);
 	rc_out(bp, RC_DTR, bp->DTR);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -1328,7 +1328,7 @@
 	struct riscom_board *bp = port_Board(port);
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	port->break_length = RISCOM_TPS / HZ * length;
 	port->COR2 |= COR2_ETC;
 	port->IER  |= IER_TXRDY;
@@ -1338,7 +1338,7 @@
 	rc_wait_CCR(bp);
 	rc_out(bp, CD180_CCR, CCR_CORCHG2);
 	rc_wait_CCR(bp);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static inline int rc_set_serial_info(struct riscom_port * port,
@@ -1381,9 +1381,9 @@
 		port->closing_wait = tmp.closing_wait;
 	}
 	if (change_speed)  {
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		rc_change_speed(bp, port);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 	return 0;
 }
@@ -1464,7 +1464,7 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	port->MSVR &= ~MSVR_RTS;
 	rc_out(bp, CD180_CAR, port_No(port));
 	if (I_IXOFF(tty))  {
@@ -1473,7 +1473,7 @@
 		rc_wait_CCR(bp);
 	}
 	rc_out(bp, CD180_MSVR, port->MSVR);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rc_unthrottle(struct tty_struct * tty)
@@ -1487,7 +1487,7 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	port->MSVR |= MSVR_RTS;
 	rc_out(bp, CD180_CAR, port_No(port));
 	if (I_IXOFF(tty))  {
@@ -1496,7 +1496,7 @@
 		rc_wait_CCR(bp);
 	}
 	rc_out(bp, CD180_MSVR, port->MSVR);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rc_stop(struct tty_struct * tty)
@@ -1510,11 +1510,11 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	port->IER &= ~IER_TXRDY;
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_IER, port->IER);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rc_start(struct tty_struct * tty)
@@ -1528,13 +1528,13 @@
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (port->xmit_cnt && port->xmit_buf && !(port->IER & IER_TXRDY))  {
 		port->IER |= IER_TXRDY;
 		rc_out(bp, CD180_CAR, port_No(port));
 		rc_out(bp, CD180_IER, port->IER);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1586,9 +1586,9 @@
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	rc_change_speed(port_Board(port), port);
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {
@@ -1684,12 +1684,11 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	free_page((unsigned long)tmp_buf);
 	tty_unregister_driver(riscom_driver);
 	put_tty_driver(riscom_driver);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 #ifndef MODULE
