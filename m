Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVAPN5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVAPN5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVAPN5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:57:16 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:55781 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S262503AbVAPNwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:52:40 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135237.30109.97414.36993@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 2/13] esp: remove cli()/sti() in drivers/char/esp.c
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:52:37 -0600
Date: Sun, 16 Jan 2005 07:52:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/esp.c linux-2.6.11-rc1-mm1/drivers/char/esp.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/esp.c	2005-01-16 07:17:19.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/esp.c	2005-01-16 07:32:19.292557341 -0500
@@ -212,14 +212,14 @@
 	if (serial_paranoia_check(info, tty->name, "rs_stop"))
 		return;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_start(struct tty_struct *tty)
@@ -230,13 +230,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_start"))
 		return;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (info->xmit_cnt && info->xmit_buf && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -298,6 +298,7 @@
 	struct esp_pio_buffer *pio_buf;
 	struct esp_pio_buffer *err_buf;
 	unsigned char status_mask;
+	unsigned long flags;
 
 	pio_buf = get_pio_buffer();
 
@@ -311,7 +312,7 @@
 		return;
 	}
 
-	sti();
+	local_save_flags(flags); local_irq_enable();
 	
 	status_mask = (info->read_status_mask >> 2) & 0x07;
 		
@@ -329,7 +330,7 @@
 			(serial_in(info, UART_ESI_RWS) >> 3) & status_mask;
 	}
 
-	cli();
+	local_irq_restore(flags);
 
 	/* make sure everything is still ok since interrupts were enabled */
 	tty = info->tty;
@@ -455,6 +456,7 @@
 {
 	int i;
 	struct esp_pio_buffer *pio_buf;
+	unsigned long flags;
 
 	pio_buf = get_pio_buffer();
 
@@ -478,7 +480,7 @@
 		info->xmit_tail = (info->xmit_tail + space_avail) &
 			(ESP_XMIT_SIZE - 1);
 
-		sti();
+		local_save_flags(flags); local_irq_enable();
 
 		for (i = 0; i < space_avail - 1; i += 2) {
 			outw(*((unsigned short *)(pio_buf->data + i)),
@@ -489,7 +491,7 @@
 			serial_out(info, UART_ESI_TX,
 				   pio_buf->data[space_avail - 1]);
 
-		cli();
+		local_irq_restore(flags);
 
 		if (info->xmit_cnt) {
 			serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
@@ -654,7 +656,7 @@
 	err_status = 0;
 	scratch = serial_in(info, UART_ESI_SID);
 
-	cli();
+	local_irq_disable();
 	
 	if (!info->tty) {
 		sti();
@@ -740,7 +742,7 @@
 #ifdef SERIAL_DEBUG_INTR
 	printk("end.\n");
 #endif
-	sti();
+	local_irq_enable();
 	return IRQ_HANDLED;
 }
 
@@ -859,7 +861,7 @@
 	int	retval=0;
         unsigned int num_chars;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (info->flags & ASYNC_INITIALIZED)
 		goto out;
@@ -973,7 +975,7 @@
 
 	info->flags |= ASYNC_INITIALIZED;
 	retval = 0;
-out:	restore_flags(flags);
+out:	local_irq_restore(flags);
 	return retval;
 }
 
@@ -993,7 +995,7 @@
 	       info->irq);
 #endif
 	
-	save_flags(flags); cli(); /* Disable interrupts */
+	local_irq_save(flags); /* Disable interrupts */
 
 	/*
 	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
@@ -1058,7 +1060,7 @@
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
 	
 	info->flags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -1172,7 +1174,7 @@
 	if (I_IXOFF(info->tty))
 		flow1 |= 0x81;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	/* set baud */
 	serial_out(info, UART_ESI_CMD1, ESI_SET_BAUD);
 	serial_out(info, UART_ESI_CMD2, quot >> 8);
@@ -1219,7 +1221,7 @@
 	serial_out(info, UART_ESI_CMD2, info->config.flow_on >> 8);
 	serial_out(info, UART_ESI_CMD2, info->config.flow_on);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_put_char(struct tty_struct *tty, unsigned char ch)
@@ -1233,16 +1235,14 @@
 	if (!tty || !info->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
-	if (info->xmit_cnt >= ESP_XMIT_SIZE - 1) {
-		restore_flags(flags);
-		return;
-	}
+	local_irq_save(flags);
+	if (info->xmit_cnt >= ESP_XMIT_SIZE - 1) 
+		goto out;
 
 	info->xmit_buf[info->xmit_head++] = ch;
 	info->xmit_head &= ESP_XMIT_SIZE-1;
 	info->xmit_cnt++;
-	restore_flags(flags);
+out:	local_irq_restore(flags);
 }
 
 static void rs_flush_chars(struct tty_struct *tty)
@@ -1256,13 +1256,13 @@
 	if (info->xmit_cnt <= 0 || tty->stopped || !info->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (!(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int rs_write(struct tty_struct * tty,
@@ -1305,7 +1305,7 @@
 		ret += c;
 	}
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (info->xmit_cnt && !tty->stopped && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
@@ -1313,7 +1313,7 @@
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return ret;
 }
 
@@ -1345,9 +1345,9 @@
 				
 	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
 		return;
-	cli();
+	local_irq_disable();
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	sti();
+	local_irq_enable();
 	tty_wakeup(tty);
 }
 
@@ -1372,13 +1372,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
 		return;
 	
-	cli();
+	local_irq_disable();
 	info->IER &= ~UART_IER_RDI;
 	serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 	serial_out(info, UART_ESI_CMD2, info->IER);
 	serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 	serial_out(info, UART_ESI_CMD2, 0x00);
-	sti();
+	local_irq_enable();
 }
 
 static void rs_unthrottle(struct tty_struct * tty)
@@ -1394,13 +1394,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
 		return;
 	
-	cli();
+	local_irq_disable();
 	info->IER |= UART_IER_RDI;
 	serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 	serial_out(info, UART_ESI_CMD2, info->IER);
 	serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 	serial_out(info, UART_ESI_CMD2, info->config.rx_timeout);
-	sti();
+	local_irq_enable();
 }
 
 /*
@@ -1654,13 +1654,13 @@
 
 		info->config.flow_off = new_config.flow_off;
 		info->config.flow_on = new_config.flow_on;
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_FLOW_LVL);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_off >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_off);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_on >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_on);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	if ((new_config.rx_trigger != info->config.rx_trigger) ||
@@ -1669,7 +1669,7 @@
 
 		info->config.rx_trigger = new_config.rx_trigger;
 		info->config.tx_trigger = new_config.tx_trigger;
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_TRIGGER);
 		serial_out(info, UART_ESI_CMD2,
 			   new_config.rx_trigger >> 8);
@@ -1677,14 +1677,14 @@
 		serial_out(info, UART_ESI_CMD2,
 			   new_config.tx_trigger >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.tx_trigger);
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	if (new_config.rx_timeout != info->config.rx_timeout) {
 		unsigned long flags;
 
 		info->config.rx_timeout = new_config.rx_timeout;
-		save_flags(flags); cli();
+		local_irq_save(flags);
 
 		if (info->IER & UART_IER_RDI) {
 			serial_out(info, UART_ESI_CMD1,
@@ -1693,7 +1693,7 @@
 				   new_config.rx_timeout);
 		}
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 	}
 
 	if (!(info->flags & ASYNC_INITIALIZED))
@@ -1717,10 +1717,10 @@
 	unsigned char status;
 	unsigned int result;
 
-	cli();
+	local_irq_disable();
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT1);
-	sti();
+	local_irq_enable();
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
 	return put_user(result,value);
 }
@@ -1737,10 +1737,10 @@
 		return -EIO;
 
 	control = info->MCR;
-	cli();
+	local_irq_disable();
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT2);
-	sti();
+	local_irq_enable();
 	return    ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
 		| ((control & UART_MCR_DTR) ? TIOCM_DTR : 0)
 		| ((status  & UART_MSR_DCD) ? TIOCM_CAR : 0)
@@ -1759,7 +1759,7 @@
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
 
-	cli();
+	local_irq_disable();
 
 	if (set & TIOCM_RTS)
 		info->MCR |= UART_MCR_RTS;
@@ -1774,7 +1774,7 @@
 	serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 	serial_out(info, UART_ESI_CMD2, UART_MCR);
 	serial_out(info, UART_ESI_CMD2, info->MCR);
-	sti();
+	local_irq_enable();
 	return 0;
 }
 
@@ -1789,7 +1789,7 @@
 	if (serial_paranoia_check(info, tty->name, "esp_break"))
 		return;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (break_state == -1) {
 		serial_out(info, UART_ESI_CMD1, ESI_ISSUE_BREAK);
 		serial_out(info, UART_ESI_CMD2, 0x01);
@@ -1799,7 +1799,7 @@
 		serial_out(info, UART_ESI_CMD1, ESI_ISSUE_BREAK);
 		serial_out(info, UART_ESI_CMD2, 0x00);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static int rs_ioctl(struct tty_struct *tty, struct file * file,
@@ -1849,17 +1849,17 @@
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
 		 case TIOCMIWAIT:
-			cli();
+			local_irq_disable();
 			cprev = info->icount;	/* note the counters on entry */
-			sti();
+			local_irq_enable();
 			while (1) {
 				interruptible_sleep_on(&info->delta_msr_wait);
 				/* see if a signal did it */
 				if (signal_pending(current))
 					return -ERESTARTSYS;
-				cli();
+				local_irq_disable();
 				cnow = info->icount;	/* atomic copy */
-				sti();
+				local_irq_enable();
 				if (cnow.rng == cprev.rng &&
 				    cnow.dsr == cprev.dsr && 
 				    cnow.dcd == cprev.dcd &&
@@ -1886,9 +1886,9 @@
 		 *     RI where only 0->1 is counted.
 		 */
 		case TIOCGICOUNT:
-			cli();
+			local_irq_disable();
 			cnow = info->icount;
-			sti();
+			local_irq_enable();
 			p_cuser = argp;
 			if (put_user(cnow.cts, &p_cuser->cts) ||
 			    put_user(cnow.dsr, &p_cuser->dsr) ||
@@ -1923,22 +1923,22 @@
 	if ((old_termios->c_cflag & CBAUD) &&
 		!(tty->termios->c_cflag & CBAUD)) {
 		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
-		cli();
+		local_irq_disable();
 		serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 		serial_out(info, UART_ESI_CMD2, UART_MCR);
 		serial_out(info, UART_ESI_CMD2, info->MCR);
-		sti();
+		local_irq_enable();
 	}
 
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) &&
 		(tty->termios->c_cflag & CBAUD)) {
 		info->MCR |= (UART_MCR_DTR | UART_MCR_RTS);
-		cli();
+		local_irq_disable();
 		serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 		serial_out(info, UART_ESI_CMD2, UART_MCR);
 		serial_out(info, UART_ESI_CMD2, info->MCR);
-		sti();
+		local_irq_enable();
 	}
 
 	/* Handle turning of CRTSCTS */
@@ -1978,7 +1978,7 @@
 	if (!info || serial_paranoia_check(info, tty->name, "rs_close"))
 		return;
 	
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
@@ -2058,7 +2058,7 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -2076,7 +2076,7 @@
 	if (!char_time)
 		char_time = 1;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
 
@@ -2094,7 +2094,7 @@
 		serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
 	}
 	
-	restore_flags(flags);
+	local_irq_restore(flags);
 	set_current_state(TASK_RUNNING);
 }
 
@@ -2174,15 +2174,13 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       info->line, info->count);
 #endif
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (!tty_hung_up_p(filp)) 
 		info->count--;
-	restore_flags(flags);
+	local_irq_restore(flags);
 	info->blocked_open++;
 	while (1) {
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		if ((tty->termios->c_cflag & CBAUD)) {
 			unsigned int scratch;
 
@@ -2194,7 +2192,7 @@
 			serial_out(info, UART_ESI_CMD2,
 				scratch | UART_MCR_DTR | UART_MCR_RTS);
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ASYNC_INITIALIZED)) {
@@ -2335,7 +2333,7 @@
 	if (!request_region(info->port, REGION_SIZE, "esp serial"))
 		return -EIO;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	
 	/*
 	 * Check for ESP card
@@ -2372,7 +2370,7 @@
 	if (!port_detected)
 		release_region(info->port, REGION_SIZE);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return (port_detected);
 }
 
@@ -2569,12 +2567,11 @@
 	struct esp_pio_buffer *pio_buf;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if ((e1 = tty_unregister_driver(esp_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n",
 		       e1);
-	restore_flags(flags);
+	local_irq_restore(flags);
 	put_tty_driver(esp_driver);
 
 	while (ports) {
