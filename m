Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbTCWBdt>; Sat, 22 Mar 2003 20:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbTCWBdt>; Sat, 22 Mar 2003 20:33:49 -0500
Received: from dp.samba.org ([66.70.73.150]:37335 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262199AbTCWBdj>;
	Sat, 22 Mar 2003 20:33:39 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15997.3541.58276.851568@nanango.paulus.ozlabs.org>
Date: Sun, 23 Mar 2003 12:28:53 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] SMP-safe macserial driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the uses of save_flags/restore_flags/cli
etc. from the macserial driver and replaces them with a spinlock.
Please apply.

Paul.

diff -urN linux-2.5/drivers/macintosh/macserial.c linuxppc-2.5/drivers/macintosh/macserial.c
--- linux-2.5/drivers/macintosh/macserial.c	2003-03-08 14:25:45.000000000 +1100
+++ linuxppc-2.5/drivers/macintosh/macserial.c	2003-03-17 10:21:50.000000000 +1100
@@ -441,12 +441,8 @@
 
 static void transmit_chars(struct mac_serial *info)
 {
-	unsigned long flags;
-
-	save_flags(flags);
-	cli();
 	if ((read_zsreg(info->zs_channel, 0) & Tx_BUF_EMP) == 0)
-		goto out;
+		return;
 	info->tx_active = 0;
 
 	if (info->x_char && !info->power_wait) {
@@ -454,13 +450,13 @@
 		write_zsdata(info->zs_channel, info->x_char);
 		info->x_char = 0;
 		info->tx_active = 1;
-		goto out;
+		return;
 	}
 
 	if ((info->xmit_cnt <= 0) || info->tty->stopped || info->tx_stopped
 	    || info->power_wait) {
 		write_zsreg(info->zs_channel, 0, RES_Tx_P);
-		goto out;
+		return;
 	}
 
 	/* Send char */
@@ -471,17 +467,17 @@
 
 	if (info->xmit_cnt < WAKEUP_CHARS)
 		rs_sched_event(info, RS_EVENT_WRITE_WAKEUP);
-
- out:
-	restore_flags(flags);
 }
 
 static void powerup_done(unsigned long data)
 {
 	struct mac_serial *info = (struct mac_serial *) data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&info->lock, flags);
 	info->power_wait = 0;
 	transmit_chars(info);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static _INLINE_ void status_handle(struct mac_serial *info)
@@ -567,6 +563,7 @@
 	struct mac_serial *info = (struct mac_serial *) dev_id;
 	unsigned char zs_intreg;
 	int shift;
+	unsigned long flags;
 
 	if (!(info->flags & ZILOG_INITIALIZED)) {
 		printk(KERN_WARNING "rs_interrupt: irq %d, port not "
@@ -588,6 +585,7 @@
 	else
 		shift = 0;	/* Channel B */
 
+	spin_lock_irqsave(&info->lock, flags);
 	for (;;) {
 		zs_intreg = read_zsreg(info->zs_chan_a, 3) >> shift;
 #ifdef SERIAL_DEBUG_INTR
@@ -611,6 +609,7 @@
 		if (zs_intreg & CHBEXT)
 			status_handle(info);
 	}
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 /* Transmit DMA interrupt - not used at present */
@@ -672,13 +671,13 @@
 		return;
 
 #if 0
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	if (info->curregs[5] & TxENAB) {
 		info->curregs[5] &= ~TxENAB;
 		info->pendregs[5] &= ~TxENAB;
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 #endif
 }
 
@@ -695,7 +694,7 @@
 	if (serial_paranoia_check(info, tty->device, "rs_start"))
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 #if 0
 	if (info->xmit_cnt && info->xmit_buf && !(info->curregs[5] & TxENAB)) {
 		info->curregs[5] |= TxENAB;
@@ -707,7 +706,7 @@
 		transmit_chars(info);
 	}
 #endif
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void do_softint(void *private_)
@@ -754,12 +753,11 @@
 		unsigned long flags;
 
 		/* delay is in ms */
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&info->lock, flags);
 		info->power_wait = 1;
 		mod_timer(&info->powerup_timer,
 			  jiffies + (delay * HZ + 999) / 1000);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	OPNDBG("enabling IRQ on ttyS%d (irq %d)...\n", info->line, info->irq);
@@ -1019,7 +1017,7 @@
 
 	OPNDBG("setting up ttyS%d SCC...\n", info->line);
 
-	save_flags(flags); cli(); /* Disable interrupts */
+	spin_lock_irqsave(&info->lock, flags);
 
 	/* Nice buggy HW ... */
 	fix_zero_bug_scc(info);
@@ -1091,6 +1089,8 @@
 		clear_bit(TTY_IO_ERROR, &info->tty->flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
+	spin_unlock_irqrestore(&info->lock, flags);
+
 	/*
 	 * Set the speed of the serial port
 	 */
@@ -1099,8 +1099,6 @@
 	/* Save the current value of RR0 */
 	info->read_reg_zero = read_zsreg(info->zs_channel, 0);
 
-	restore_flags(flags);
-
 	if (info->dma_initted) {
 		spin_lock_irqsave(&info->rx_dma_lock, flags);
 		rxdma_start(info, 0);
@@ -1214,10 +1212,7 @@
 
 static void irda_rts_pulses(struct mac_serial *info, int w)
 {
-	unsigned long flags;
-
 	udelay(w);
-	save_flags(flags); cli();
 	write_zsreg(info->zs_channel, 5, Tx8 | TxENAB);
 	udelay(2);
 	write_zsreg(info->zs_channel, 5, Tx8 | TxENAB | RTS);
@@ -1225,7 +1220,6 @@
 	write_zsreg(info->zs_channel, 5, Tx8 | TxENAB);
 	udelay(4);
 	write_zsreg(info->zs_channel, 5, Tx8 | TxENAB | RTS);
-	restore_flags(flags);
 }
 
 /*
@@ -1234,7 +1228,6 @@
 static void irda_setup(struct mac_serial *info)
 {
 	int code, speed, t;
-	unsigned long flags;
 
 	speed = info->tty->termios->c_cflag & CBAUD;
 	if (speed < B2400 || speed > B115200)
@@ -1268,10 +1261,8 @@
 
 	/* set TxD low for ~104us and pulse RTS */
 	udelay(1000);
-	save_flags(flags); cli();
 	write_zsdata(info->zs_channel, 0xfe);
 	irda_rts_pulses(info, 150);
-	restore_flags(flags);
 	irda_rts_pulses(info, 180);
 	irda_rts_pulses(info, 50);
 	udelay(100);
@@ -1351,7 +1342,7 @@
 	else if (baud == 0)
 		baud = 38400;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	info->zs_baud = baud;
 	info->clk_divisor = 16;
 
@@ -1460,22 +1451,23 @@
 	/* Load up the new values */
 	load_zsregs(info->zs_channel, info->curregs);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static void rs_flush_chars(struct tty_struct *tty)
 {
 	struct mac_serial *info = (struct mac_serial *)tty->driver_data;
+	unsigned long flags;
 
 	if (serial_paranoia_check(info, tty->device, "rs_flush_chars"))
 		return;
 
-	if (info->xmit_cnt <= 0 || tty->stopped || info->tx_stopped ||
-	    !info->xmit_buf)
-		return;
-
-	/* Enable transmitter */
-	transmit_chars(info);
+	spin_lock_irqsave(&info->lock, flags);
+	if (!(info->xmit_cnt <= 0 || tty->stopped || info->tx_stopped ||
+	      !info->xmit_buf))
+		/* Enable transmitter */
+		transmit_chars(info);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static int rs_write(struct tty_struct * tty, int from_user,
@@ -1506,15 +1498,14 @@
 					ret = -EFAULT;
 				break;
 			}
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&info->lock, flags);
 			c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				       SERIAL_XMIT_SIZE - info->xmit_head));
 			memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 			info->xmit_head = ((info->xmit_head + c) &
 					   (SERIAL_XMIT_SIZE-1));
 			info->xmit_cnt += c;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&info->lock, flags);
 			buf += c;
 			count -= c;
 			ret += c;
@@ -1522,28 +1513,29 @@
 		up(&tmp_buf_sem);
 	} else {
 		while (1) {
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&info->lock, flags);
 			c = MIN(count,
 				MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				    SERIAL_XMIT_SIZE - info->xmit_head));
 			if (c <= 0) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&info->lock, flags);
 				break;
 			}
 			memcpy(info->xmit_buf + info->xmit_head, buf, c);
 			info->xmit_head = ((info->xmit_head + c) &
 					   (SERIAL_XMIT_SIZE-1));
 			info->xmit_cnt += c;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&info->lock, flags);
 			buf += c;
 			count -= c;
 			ret += c;
 		}
 	}
+	spin_lock_irqsave(&info->lock, flags);
 	if (info->xmit_cnt && !tty->stopped && !info->tx_stopped
 	    && !info->tx_active)
 		transmit_chars(info);
+	spin_unlock_irqrestore(&info->lock, flags);
 	return ret;
 }
 
@@ -1576,9 +1568,9 @@
 
 	if (serial_paranoia_check(info, tty->device, "rs_flush_buffer"))
 		return;
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	wake_up_interruptible(&tty->write_wait);
 	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
 	    tty->ldisc.write_wakeup)
@@ -1605,11 +1597,11 @@
 		return;
 
 	if (I_IXOFF(tty)) {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 		info->x_char = STOP_CHAR(tty);
 		if (!info->tx_active)
 			transmit_chars(info);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	if (C_CRTSCTS(tty)) {
@@ -1627,21 +1619,21 @@
 		 * drop RTS.
 		 */
 		if (info->is_internal_modem) {
-			save_flags(flags); cli();
+			spin_lock_irqsave(&info->lock, flags);
 			info->curregs[5] &= ~RTS;
 			info->pendregs[5] &= ~RTS;
 			write_zsreg(info->zs_channel, 5, info->curregs[5]);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&info->lock, flags);
 		}
 	}
 	
 #ifdef CDTRCTS
 	if (tty->termios->c_cflag & CDTRCTS) {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 		info->curregs[5] &= ~DTR;
 		info->pendregs[5] &= ~DTR;
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 #endif /* CDTRCTS */
 }
@@ -1659,7 +1651,7 @@
 		return;
 
 	if (I_IXOFF(tty)) {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 		if (info->x_char)
 			info->x_char = 0;
 		else {
@@ -1667,26 +1659,26 @@
 			if (!info->tx_active)
 				transmit_chars(info);
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 	if (C_CRTSCTS(tty) && info->is_internal_modem) {
 		/* Assert RTS line */
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 		info->curregs[5] |= RTS;
 		info->pendregs[5] |= RTS;
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 
 #ifdef CDTRCTS
 	if (tty->termios->c_cflag & CDTRCTS) {
 		/* Assert DTR line */
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 		info->curregs[5] |= DTR;
 		info->pendregs[5] |= DTR;
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 	}
 #endif
 }
@@ -1779,9 +1771,9 @@
 	unsigned char status;
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	status = read_zsreg(info->zs_channel, 0);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	status = (status & Tx_BUF_EMP)? TIOCSER_TEMT: 0;
 	return put_user(status,value);
 }
@@ -1792,10 +1784,10 @@
 	unsigned int result;
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	control = info->curregs[5];
 	status = read_zsreg(info->zs_channel, 0);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	result =  ((control & RTS) ? TIOCM_RTS: 0)
 		| ((control & DTR) ? TIOCM_DTR: 0)
 		| ((status  & DCD) ? TIOCM_CAR: 0)
@@ -1812,7 +1804,7 @@
 	if (get_user(arg, value))
 		return -EFAULT;
 	bits = (arg & TIOCM_RTS? RTS: 0) + (arg & TIOCM_DTR? DTR: 0);
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	switch (cmd) {
 	case TIOCMBIS:
 		info->curregs[5] |= bits;
@@ -1824,12 +1816,12 @@
 		info->curregs[5] = (info->curregs[5] & ~(DTR | RTS)) | bits;
 		break;
 	default:
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 		return -EINVAL;
 	}
 	info->pendregs[5] = info->curregs[5];
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	return 0;
 }
 
@@ -1844,13 +1836,13 @@
 	if (serial_paranoia_check(info, tty->device, "rs_break"))
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	if (break_state == -1)
 		info->curregs[5] |= SND_BRK;
 	else
 		info->curregs[5] &= ~SND_BRK;
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 }
 
 static int rs_ioctl(struct tty_struct *tty, struct file * file,
@@ -1932,11 +1924,11 @@
 	if (!info || serial_paranoia_check(info, tty->device, "rs_close"))
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 
 	if (tty_hung_up_p(filp)) {
 		MOD_DEC_USE_COUNT;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 		return;
 	}
 
@@ -1960,7 +1952,7 @@
 	}
 	if (info->count) {
 		MOD_DEC_USE_COUNT;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 		return;
 	}
 	info->flags |= ZILOG_CLOSING;
@@ -1979,9 +1971,9 @@
 	OPNDBG("waiting end of Tx... (timeout:%d)\n", info->closing_wait);
 	tty->closing = 1;
 	if (info->closing_wait != ZILOG_CLOSING_WAIT_NONE) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 		tty_wait_until_sent(tty, info->closing_wait);
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 	}
 
 	/*
@@ -2001,15 +1993,15 @@
 		 * has completely drained.
 		 */
 		OPNDBG("waiting end of Rx...\n");
-		restore_flags(flags);
+		spin_unlock_irqrestore(&info->lock, flags);
 		rs_wait_until_sent(tty, info->timeout);
-		save_flags(flags); cli();
+		spin_lock_irqsave(&info->lock, flags);
 	}
 
 	shutdown(info);
 	/* restore flags now since shutdown() will have disabled this port's
 	   specific irqs */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 
 	if (tty->driver.flush_buffer)
 		tty->driver.flush_buffer(tty);
@@ -2174,18 +2166,18 @@
 	add_wait_queue(&info->open_wait, &wait);
 	OPNDBG("block_til_ready before block: ttyS%d, count = %d\n",
 	       info->line, info->count);
-	cli();
+	spin_lock_irq(&info->lock);
 	if (!tty_hung_up_p(filp)) 
 		info->count--;
-	sti();
+	spin_unlock_irq(&info->lock);
 	info->blocked_open++;
 	while (1) {
-		cli();
+		spin_lock_irq(&info->lock);
 		if (!(info->flags & ZILOG_CALLOUT_ACTIVE) &&
 		    (tty->termios->c_cflag & CBAUD) &&
 		    !info->is_irda)
 			zs_rtsdtr(info, 1);
-		sti();
+		spin_unlock_irq(&info->lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(info->flags & ZILOG_INITIALIZED)) {
@@ -2553,7 +2545,6 @@
 int macserial_init(void)
 {
 	int channel, i;
-	unsigned long flags;
 	struct mac_serial *info;
 
 	/* Find out how many Z8530 SCCs we have */
@@ -2570,7 +2561,6 @@
 	 * We also request the OF resources here as probe_sccs()
 	 * might be called too early for that
 	 */
-	save_flags(flags); cli();
 	for (i = 0; i < zs_channels_found; ++i) {
 		struct device_node* ch = zs_soft[i].dev_node;
 		if (!request_OF_resource(ch, 0, NULL)) {
@@ -2607,7 +2597,6 @@
 			       zs_soft[i].irq);
 		disable_irq(zs_soft[i].irq);
 	}
-	restore_flags(flags);
 
 	show_serial_version();
 
@@ -2723,6 +2712,7 @@
 		info->count = 0;
 		info->blocked_open = 0;
 		INIT_WORK(&info->tqueue, do_softint, info);
+		spin_lock_init(&info->lock);
 		info->callout_termios = callout_driver.init_termios;
 		info->normal_termios = serial_driver.init_termios;
 		init_waitqueue_head(&info->open_wait);
@@ -2753,7 +2743,7 @@
 
 	for (info = zs_chain, i = 0; info; info = info->zs_next, i++)
 		set_scc_power(info, 0);
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
 	for (i = 0; i < zs_channels_found; ++i) {
 		free_irq(zs_soft[i].irq, &zs_soft[i]);
 		if (zs_soft[i].has_dma) {
@@ -2767,7 +2757,7 @@
 			release_OF_resource(ch, ch->n_addrs - 1);
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 	tty_unregister_driver(&callout_driver);
 	tty_unregister_driver(&serial_driver);
 
@@ -2944,7 +2934,7 @@
 	}
 	co->cflag = cflag;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&info->lock, flags);
         memset(info->curregs, 0, sizeof(info->curregs));
 
 	info->zs_baud = baud;
@@ -3026,7 +3016,7 @@
 	/* Load up the new values */
 	load_zsregs(info->zs_channel, info->curregs);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&info->lock, flags);
 
 	return 0;
 }
diff -urN linux-2.5/drivers/macintosh/macserial.h linuxppc-2.5/drivers/macintosh/macserial.h
--- linux-2.5/drivers/macintosh/macserial.h	2002-10-02 15:24:47.000000000 +1000
+++ linuxppc-2.5/drivers/macintosh/macserial.h	2003-03-17 10:21:50.000000000 +1100
@@ -9,6 +9,8 @@
 #ifndef _MACSERIAL_H
 #define _MACSERIAL_H
 
+#include <linux/spinlock.h>
+
 #define NUM_ZSREGS    16
 
 struct serial_struct {
@@ -105,6 +107,7 @@
 	struct mac_zschannel *zs_chan_a;	/* A side registers */
 	unsigned char read_reg_zero;
 	struct device_node* dev_node;
+	spinlock_t lock;
 
 	char soft_carrier;  /* Use soft carrier on this channel */
 	char break_abort;   /* Is serial console in, so process brk/abrt */
