Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbULQXqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbULQXqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbULQXqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:46:23 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:20149 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262229AbULQXpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:45:31 -0500
From: James Nelson <james4765@verizon.net>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041217234552.17962.94170.94852@localhost.localdomain>
Subject: [PATCH] isi: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 17:45:30 -0600
Date: Fri, 17 Dec 2004 17:45:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to make the isicom driver SMP-correct.

Compile tested.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/isicom.c linux-2.6.10-rc3-mm1/drivers/char/isicom.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/isicom.c	2004-12-03 16:52:14.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/isicom.c	2004-12-17 18:33:30.092992591 -0500
@@ -59,6 +59,8 @@
 
 #include <linux/isicom.h>
 
+static spinlock_t isicom_lock = SPIN_LOCK_UNLOCKED;
+
 static struct pci_device_id isicom_pci_tbl[] = {
 	{ VENDOR_ID, 0x2028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ VENDOR_ID, 0x2051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -389,7 +391,7 @@
 			continue;
 		
 		tty = port->tty;
-		save_flags(flags); cli();
+		spin_lock_irqsave(&isicom_lock, flags);
 		txcount = min_t(short, TX_SIZE, port->xmit_cnt);
 		if ((txcount <= 0) || tty->stopped || tty->hw_stopped) {
 			restore_flags(flags);
@@ -398,7 +400,7 @@
 		wait = 200;	
 		while(((inw(base+0x0e) & 0x01) == 0) && (wait-- > 0));
 		if (wait <= 0) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&isicom_lock, flags);
 #ifdef ISICOM_DEBUG
 			printk(KERN_DEBUG "ISICOM: isicom_tx:Card(0x%x) found busy.\n",
 				card);
@@ -406,7 +408,7 @@
 			continue;
 		}
 		if (!(inw(base + 0x02) & (1 << port->channel))) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&isicom_lock, flags);
 #ifdef ISICOM_DEBUG					
 			printk(KERN_DEBUG "ISICOM: isicom_tx: cannot tx to 0x%x:%d.\n",
 					base, port->channel + 1);
@@ -459,7 +461,7 @@
 			port->status &= ~ISI_TXOK;
 		if (port->xmit_cnt <= WAKEUP_CHARS)
 			schedule_work(&port->bh_tqueue);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&isicom_lock, flags);
 	}	
 
 		/*	schedule another tx for hopefully in about 10ms	*/	
@@ -814,9 +816,9 @@
 	printk(KERN_DEBUG "ISICOM: setup_board: drop_dtr_rts start, port_count %d...\n", bp->port_count);
 #endif
 	for(channel = 0; channel < bp->port_count; channel++, port++) {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&isicom_lock, flags);
 		drop_dtr_rts(port);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&isicom_lock, flags);
 	}
 #ifdef ISICOM_DEBUG		
 	printk(KERN_DEBUG "ISICOM: setup_board: drop_dtr_rts stop...\n");	
@@ -845,7 +847,7 @@
 		}
 		port->xmit_buf = (unsigned char *) page;	
 	}	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	if (port->tty)
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
 	if (port->count == 1)
@@ -859,7 +861,7 @@
 	isicom_config_port(port);
 	port->flags |= ASYNC_INITIALIZED;
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 	
 	return 0;		
 } 
@@ -903,18 +905,18 @@
 						callout dev is busy */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	cli();
+	spin_lock_irq(&isicom_lock);
 		if (!tty_hung_up_p(filp))
 			port->count--;
-	sti();
+	spin_unlock_irq(&isicom_lock);
 	port->blocked_open++;
 #ifdef ISICOM_DEBUG	
 	printk(KERN_DEBUG "ISICOM: block_til_ready: waiting for DCD...\n");
 #endif	
 	while (1) {
-		cli();
+		spin_lock_irq(&isicom_lock);
 		raise_dtr_rts(port);
-		sti();
+		spin_unlock_irq(&isicom_lock);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) { 	
 			if (port->flags & ASYNC_HUP_NOTIFY)
@@ -1082,10 +1084,9 @@
 	printk(KERN_DEBUG "ISICOM: Close start!!!.\n");
 #endif	
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
-		return;
+		goto isicom_close_end;
 	}
 	
 	if ((tty->count == 1) && (port->count != 1)) {
@@ -1102,8 +1103,7 @@
 	}
 	
 	if (port->count) {
-		restore_flags(flags);
-		return;
+		goto isicom_close_end;
 	} 	
 	port->flags |= ASYNC_CLOSING;
 	tty->closing = 1;
@@ -1133,10 +1133,12 @@
 	}	
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
-	restore_flags(flags);
 #ifdef ISICOM_DEBUG	
 	printk(KERN_DEBUG "ISICOM: Close end!!!.\n");
 #endif	
+isicom_close_end:
+	spin_unlock_irqrestore(&isicom_lock, flags);;
+	return;
 }
 
 /* write et all */
@@ -1156,9 +1158,8 @@
 	if (!tty || !port->xmit_buf || !tmp_buf)
 		return 0;
 		
-	save_flags(flags);
+	spin_lock_irqsave(&isicom_lock, flags);
 	while(1) {	
-		cli();
 		cnt = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					    SERIAL_XMIT_SIZE - port->xmit_head));
 		if (cnt <= 0) 
@@ -1167,14 +1168,13 @@
 		memcpy(port->xmit_buf + port->xmit_head, buf, cnt);
 		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE - 1);
 		port->xmit_cnt += cnt;
-		restore_flags(flags);
 		buf += cnt;
 		count -= cnt;
 		total += cnt;
 	}		
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped)
 		port->status |= ISI_TXOK;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 #ifdef ISICOM_DEBUG
 	printk(KERN_DEBUG "ISICOM: isicom_write %d bytes written.\n", total);
 #endif		
@@ -1196,7 +1196,7 @@
 	printk(KERN_DEBUG "ISICOM: put_char, port %d, char %c.\n", port->channel+1, ch);
 #endif			
 		
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	
 	if (port->xmit_cnt >= (SERIAL_XMIT_SIZE - 1)) {
 		restore_flags(flags);
@@ -1206,7 +1206,7 @@
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= (SERIAL_XMIT_SIZE - 1);
 	port->xmit_cnt++;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 }
 
 /* flush_chars et all */
@@ -1257,7 +1257,7 @@
 	unsigned short base = card->base;	
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	while (((inw(base + 0x0e) & 0x0001) == 0) && (wait-- > 0));	
 	if (!wait) {
 		printk(KERN_DEBUG "ISICOM: Card found busy in isicom_send_break.\n");
@@ -1267,7 +1267,7 @@
 	outw((length & 0xff) << 8 | 0x00, base);
 	outw((length & 0xff00), base);
 	InterruptTheCard(base);
-out:	restore_flags(flags);
+out:	spin_unlock_irqrestore(&isicom_lock, flags);
 }
 
 static int isicom_tiocmget(struct tty_struct *tty, struct file *file)
@@ -1296,7 +1296,7 @@
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	if (set & TIOCM_RTS)
 		raise_rts(port);
 	if (set & TIOCM_DTR)
@@ -1307,7 +1307,7 @@
 	if (clear & TIOCM_DTR)
 		drop_dtr(port);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 	return 0;
 }			
 
@@ -1340,9 +1340,9 @@
 				(newinfo.flags & ASYNC_FLAGS));
 	}
 	if (reconfig_port) {
-		save_flags(flags); cli();
+		spin_lock_irqsave(&isicom_lock, flags);
 		isicom_config_port(port);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&isicom_lock, flags);
 	}
 	return 0;		 
 }		
@@ -1430,9 +1430,9 @@
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 		
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	isicom_config_port(port);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 	
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {	
@@ -1452,10 +1452,10 @@
 		return;
 	
 	/* tell the card that this port cannot handle any more data for now */
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	card->port_status &= ~(1 << port->channel);
 	outw(card->port_status, card->base + 0x02);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 }
 
 /* unthrottle et all */
@@ -1469,10 +1469,10 @@
 		return;
 	
 	/* tell the card that this port is ready to accept more data */
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	card->port_status |= (1 << port->channel);
 	outw(card->port_status, card->base + 0x02);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 }
 
 /* stop et all */
@@ -1535,9 +1535,9 @@
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_buffer"))
 		return;
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&isicom_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&isicom_lock, flags);
 	
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/Kconfig linux-2.6.10-rc3-mm1/drivers/char/Kconfig
--- linux-2.6.10-rc3-mm1-original/drivers/char/Kconfig	2004-12-03 16:52:14.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/Kconfig	2004-12-17 18:23:12.588357924 -0500
@@ -203,7 +203,7 @@
 
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
-	depends on SERIAL_NONSTANDARD && PCI && EXPERIMENTAL && BROKEN_ON_SMP && m
+	depends on SERIAL_NONSTANDARD && PCI && EXPERIMENTAL && m
 	help
 	  This is a driver for the Multi-Tech cards which provide several
 	  serial ports.  The driver is experimental and can currently only be
