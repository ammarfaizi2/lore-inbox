Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbULQXUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbULQXUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbULQXUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:20:04 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:48781 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262227AbULQXSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:18:55 -0500
From: James Nelson <james4765@verizon.net>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041217231915.14919.49991.15433@localhost.localdomain>
Subject: [PATCH] esp: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 17:18:52 -0600
Date: Fri, 17 Dec 2004 17:18:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to make the esp driver SMP-correct.

Compile tested.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/esp.c linux-2.6.10-rc3-mm1/drivers/char/esp.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/esp.c	2004-12-03 16:52:13.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/esp.c	2004-12-17 18:11:31.275037730 -0500
@@ -84,6 +84,8 @@
 static unsigned int rx_timeout = ESP_RX_TMOUT;
 static unsigned int pio_threshold = ESP_PIO_THRESHOLD;
 
+static spinlock_t esp_lock = SPIN_LOCK_UNLOCKED;
+
 MODULE_LICENSE("GPL");
 
 module_param_array(irq, int, NULL, 0);
@@ -212,14 +214,14 @@
 	if (serial_paranoia_check(info, tty->name, "rs_stop"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if (info->IER & UART_IER_THRI) {
 		info->IER &= ~UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 static void rs_start(struct tty_struct *tty)
@@ -230,13 +232,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_start"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if (info->xmit_cnt && info->xmit_buf && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 /*
@@ -311,7 +313,7 @@
 		return;
 	}
 
-	sti();
+	spin_unlock_irq(&esp_lock);
 	
 	status_mask = (info->read_status_mask >> 2) & 0x07;
 		
@@ -329,7 +331,7 @@
 			(serial_in(info, UART_ESI_RWS) >> 3) & status_mask;
 	}
 
-	cli();
+	spin_lock_irq(&esp_lock);
 
 	/* make sure everything is still ok since interrupts were enabled */
 	tty = info->tty;
@@ -478,7 +480,7 @@
 		info->xmit_tail = (info->xmit_tail + space_avail) &
 			(ESP_XMIT_SIZE - 1);
 
-		sti();
+		spin_unlock_irq(&esp_lock);
 
 		for (i = 0; i < space_avail - 1; i += 2) {
 			outw(*((unsigned short *)(pio_buf->data + i)),
@@ -489,7 +491,7 @@
 			serial_out(info, UART_ESI_TX,
 				   pio_buf->data[space_avail - 1]);
 
-		cli();
+		spin_lock_irq(&esp_lock);
 
 		if (info->xmit_cnt) {
 			serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
@@ -654,10 +656,10 @@
 	err_status = 0;
 	scratch = serial_in(info, UART_ESI_SID);
 
-	cli();
+	spin_lock_irq(&esp_lock);
 	
 	if (!info->tty) {
-		sti();
+		spin_unlock_irq(&esp_lock);
 		return IRQ_NONE;
 	}
 
@@ -740,7 +742,7 @@
 #ifdef SERIAL_DEBUG_INTR
 	printk("end.\n");
 #endif
-	sti();
+	spin_unlock_irq(&esp_lock);
 	return IRQ_HANDLED;
 }
 
@@ -859,7 +861,7 @@
 	int	retval=0;
         unsigned int num_chars;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 
 	if (info->flags & ASYNC_INITIALIZED)
 		goto out;
@@ -973,7 +975,7 @@
 
 	info->flags |= ASYNC_INITIALIZED;
 	retval = 0;
-out:	restore_flags(flags);
+out:	spin_unlock_irqrestore(&esp_lock, flags);
 	return retval;
 }
 
@@ -993,7 +995,7 @@
 	       info->irq);
 #endif
 	
-	save_flags(flags); cli(); /* Disable interrupts */
+	spin_lock_irqsave(&esp_lock, flags); /* Disable interrupts */
 
 	/*
 	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
@@ -1058,7 +1060,7 @@
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
 	
 	info->flags &= ~ASYNC_INITIALIZED;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 /*
@@ -1172,7 +1174,7 @@
 	if (I_IXOFF(info->tty))
 		flow1 |= 0x81;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	/* set baud */
 	serial_out(info, UART_ESI_CMD1, ESI_SET_BAUD);
 	serial_out(info, UART_ESI_CMD2, quot >> 8);
@@ -1219,7 +1221,7 @@
 	serial_out(info, UART_ESI_CMD2, info->config.flow_on >> 8);
 	serial_out(info, UART_ESI_CMD2, info->config.flow_on);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 static void rs_put_char(struct tty_struct *tty, unsigned char ch)
@@ -1233,7 +1235,7 @@
 	if (!tty || !info->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if (info->xmit_cnt >= ESP_XMIT_SIZE - 1) {
 		restore_flags(flags);
 		return;
@@ -1242,7 +1244,7 @@
 	info->xmit_buf[info->xmit_head++] = ch;
 	info->xmit_head &= ESP_XMIT_SIZE-1;
 	info->xmit_cnt++;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 static void rs_flush_chars(struct tty_struct *tty)
@@ -1256,13 +1258,13 @@
 	if (info->xmit_cnt <= 0 || tty->stopped || !info->xmit_buf)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if (!(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 static int rs_write(struct tty_struct * tty,
@@ -1305,7 +1307,7 @@
 		ret += c;
 	}
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 
 	if (info->xmit_cnt && !tty->stopped && !(info->IER & UART_IER_THRI)) {
 		info->IER |= UART_IER_THRI;
@@ -1313,7 +1315,7 @@
 		serial_out(info, UART_ESI_CMD2, info->IER);
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 	return ret;
 }
 
@@ -1345,9 +1347,9 @@
 				
 	if (serial_paranoia_check(info, tty->name, "rs_flush_buffer"))
 		return;
-	cli();
+	spin_lock_irq(&esp_lock);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	sti();
+	spin_unlock_irq(&esp_lock);
 	tty_wakeup(tty);
 }
 
@@ -1372,13 +1374,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_throttle"))
 		return;
 	
-	cli();
+	spin_lock_irq(&esp_lock);
 	info->IER &= ~UART_IER_RDI;
 	serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 	serial_out(info, UART_ESI_CMD2, info->IER);
 	serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 	serial_out(info, UART_ESI_CMD2, 0x00);
-	sti();
+	spin_unlock_irq(&esp_lock);
 }
 
 static void rs_unthrottle(struct tty_struct * tty)
@@ -1394,13 +1396,13 @@
 	if (serial_paranoia_check(info, tty->name, "rs_unthrottle"))
 		return;
 	
-	cli();
+	spin_lock_irq(&esp_lock);
 	info->IER |= UART_IER_RDI;
 	serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
 	serial_out(info, UART_ESI_CMD2, info->IER);
 	serial_out(info, UART_ESI_CMD1, ESI_SET_RX_TIMEOUT);
 	serial_out(info, UART_ESI_CMD2, info->config.rx_timeout);
-	sti();
+	spin_unlock_irq(&esp_lock);
 }
 
 /*
@@ -1654,13 +1656,13 @@
 
 		info->config.flow_off = new_config.flow_off;
 		info->config.flow_on = new_config.flow_on;
-		save_flags(flags); cli();
+		spin_lock_irqsave(&esp_lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_FLOW_LVL);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_off >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_off);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_on >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.flow_on);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&esp_lock, flags);
 	}
 
 	if ((new_config.rx_trigger != info->config.rx_trigger) ||
@@ -1669,7 +1671,7 @@
 
 		info->config.rx_trigger = new_config.rx_trigger;
 		info->config.tx_trigger = new_config.tx_trigger;
-		save_flags(flags); cli();
+		spin_lock_irqsave(&esp_lock, flags);
 		serial_out(info, UART_ESI_CMD1, ESI_SET_TRIGGER);
 		serial_out(info, UART_ESI_CMD2,
 			   new_config.rx_trigger >> 8);
@@ -1677,14 +1679,14 @@
 		serial_out(info, UART_ESI_CMD2,
 			   new_config.tx_trigger >> 8);
 		serial_out(info, UART_ESI_CMD2, new_config.tx_trigger);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&esp_lock, flags);
 	}
 
 	if (new_config.rx_timeout != info->config.rx_timeout) {
 		unsigned long flags;
 
 		info->config.rx_timeout = new_config.rx_timeout;
-		save_flags(flags); cli();
+		spin_lock_irqsave(&esp_lock, flags);
 
 		if (info->IER & UART_IER_RDI) {
 			serial_out(info, UART_ESI_CMD1,
@@ -1693,7 +1695,7 @@
 				   new_config.rx_timeout);
 		}
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&esp_lock, flags);
 	}
 
 	if (!(info->flags & ASYNC_INITIALIZED))
@@ -1717,10 +1719,10 @@
 	unsigned char status;
 	unsigned int result;
 
-	cli();
+	spin_lock_irq(&esp_lock);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT1);
-	sti();
+	spin_unlock_irq(&esp_lock);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
 	return put_user(result,value);
 }
@@ -1737,10 +1739,10 @@
 		return -EIO;
 
 	control = info->MCR;
-	cli();
+	spin_lock_irq(&esp_lock);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT2);
-	sti();
+	spin_unlock_irq(&esp_lock);
 	return    ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
 		| ((control & UART_MCR_DTR) ? TIOCM_DTR : 0)
 		| ((status  & UART_MSR_DCD) ? TIOCM_CAR : 0)
@@ -1759,7 +1761,7 @@
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
 
-	cli();
+	spin_lock_irq(&esp_lock);
 
 	if (set & TIOCM_RTS)
 		info->MCR |= UART_MCR_RTS;
@@ -1774,7 +1776,7 @@
 	serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 	serial_out(info, UART_ESI_CMD2, UART_MCR);
 	serial_out(info, UART_ESI_CMD2, info->MCR);
-	sti();
+	spin_unlock_irq(&esp_lock);
 	return 0;
 }
 
@@ -1789,7 +1791,7 @@
 	if (serial_paranoia_check(info, tty->name, "esp_break"))
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if (break_state == -1) {
 		serial_out(info, UART_ESI_CMD1, ESI_ISSUE_BREAK);
 		serial_out(info, UART_ESI_CMD2, 0x01);
@@ -1799,7 +1801,7 @@
 		serial_out(info, UART_ESI_CMD1, ESI_ISSUE_BREAK);
 		serial_out(info, UART_ESI_CMD2, 0x00);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 static int rs_ioctl(struct tty_struct *tty, struct file * file,
@@ -1849,17 +1851,17 @@
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
 		 case TIOCMIWAIT:
-			cli();
+			spin_lock_irq(&esp_lock);
 			cprev = info->icount;	/* note the counters on entry */
-			sti();
+			spin_unlock_irq(&esp_lock);
 			while (1) {
 				interruptible_sleep_on(&info->delta_msr_wait);
 				/* see if a signal did it */
 				if (signal_pending(current))
 					return -ERESTARTSYS;
-				cli();
+				spin_lock_irq(&esp_lock);
 				cnow = info->icount;	/* atomic copy */
-				sti();
+				spin_unlock_irq(&esp_lock);
 				if (cnow.rng == cprev.rng &&
 				    cnow.dsr == cprev.dsr && 
 				    cnow.dcd == cprev.dcd &&
@@ -1886,9 +1888,9 @@
 		 *     RI where only 0->1 is counted.
 		 */
 		case TIOCGICOUNT:
-			cli();
+			spin_lock_irq(&esp_lock);
 			cnow = info->icount;
-			sti();
+			spin_unlock_irq(&esp_lock);
 			p_cuser = argp;
 			if (put_user(cnow.cts, &p_cuser->cts) ||
 			    put_user(cnow.dsr, &p_cuser->dsr) ||
@@ -1923,22 +1925,22 @@
 	if ((old_termios->c_cflag & CBAUD) &&
 		!(tty->termios->c_cflag & CBAUD)) {
 		info->MCR &= ~(UART_MCR_DTR|UART_MCR_RTS);
-		cli();
+		spin_lock_irq(&esp_lock);
 		serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 		serial_out(info, UART_ESI_CMD2, UART_MCR);
 		serial_out(info, UART_ESI_CMD2, info->MCR);
-		sti();
+		spin_unlock_irq(&esp_lock);
 	}
 
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) &&
 		(tty->termios->c_cflag & CBAUD)) {
 		info->MCR |= (UART_MCR_DTR | UART_MCR_RTS);
-		cli();
+		spin_lock_irq(&esp_lock);
 		serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 		serial_out(info, UART_ESI_CMD2, UART_MCR);
 		serial_out(info, UART_ESI_CMD2, info->MCR);
-		sti();
+		spin_unlock_irq(&esp_lock);
 	}
 
 	/* Handle turning of CRTSCTS */
@@ -1978,7 +1980,7 @@
 	if (!info || serial_paranoia_check(info, tty->name, "rs_close"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
@@ -2058,7 +2060,7 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
 out:
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 }
 
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -2076,7 +2078,7 @@
 	if (!char_time)
 		char_time = 1;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	serial_out(info, UART_ESI_CMD1, ESI_NO_COMMAND);
 	serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
 
@@ -2094,7 +2096,7 @@
 		serial_out(info, UART_ESI_CMD1, ESI_GET_TX_AVAIL);
 	}
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 	set_current_state(TASK_RUNNING);
 }
 
@@ -2174,15 +2176,13 @@
 	printk("block_til_ready before block: ttys%d, count = %d\n",
 	       info->line, info->count);
 #endif
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if (!tty_hung_up_p(filp)) 
 		info->count--;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 	info->blocked_open++;
 	while (1) {
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&esp_lock, flags);
 		if ((tty->termios->c_cflag & CBAUD)) {
 			unsigned int scratch;
 
@@ -2194,7 +2194,7 @@
 			serial_out(info, UART_ESI_CMD2,
 				scratch | UART_MCR_DTR | UART_MCR_RTS);
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&esp_lock, flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ASYNC_INITIALIZED)) {
@@ -2335,7 +2335,7 @@
 	if (!request_region(info->port, REGION_SIZE, "esp serial"))
 		return -EIO;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	
 	/*
 	 * Check for ESP card
@@ -2372,7 +2372,7 @@
 	if (!port_detected)
 		release_region(info->port, REGION_SIZE);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 	return (port_detected);
 }
 
@@ -2569,12 +2569,11 @@
 	struct esp_pio_buffer *pio_buf;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&esp_lock, flags);
 	if ((e1 = tty_unregister_driver(esp_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n",
 		       e1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&esp_lock, flags);
 	put_tty_driver(esp_driver);
 
 	while (ports) {
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/Kconfig linux-2.6.10-rc3-mm1/drivers/char/Kconfig
--- linux-2.6.10-rc3-mm1-original/drivers/char/Kconfig	2004-12-03 16:52:14.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/Kconfig	2004-12-17 17:43:44.872008096 -0500
@@ -170,7 +170,7 @@
 
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
-	depends on SERIAL_NONSTANDARD && ISA && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && ISA
 	help
 	  This is a driver which supports Hayes ESP serial ports.  Both single
 	  port cards and multiport cards are supported.  Make sure to read
