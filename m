Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbULRA0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbULRA0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbULRA0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:26:38 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:61584 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262257AbULRAZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:25:41 -0500
From: James Nelson <james4765@verizon.net>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041218002600.19176.34205.85406@localhost.localdomain>
Subject: [PATCH] generic_serial: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 18:25:38 -0600
Date: Fri, 17 Dec 2004 18:25:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an attempt to make the generic_serial driver SMP-correct.

This is used in both the sx and rio drivers.

Compile tested.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/generic_serial.c linux-2.6.10-rc3-mm1/drivers/char/generic_serial.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/generic_serial.c	2004-12-16 19:16:55.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/generic_serial.c	2004-12-17 19:13:01.458849723 -0500
@@ -32,6 +32,8 @@
 
 #define DEBUG 
 
+static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
+
 static char *                  tmp_buf; 
 static DECLARE_MUTEX(tmp_buf_sem);
 
@@ -52,8 +54,8 @@
 #define RELEASEIT up (&port->port_write_sem);
 #else
 #define DECL      unsigned long flags;
-#define LOCKIT    save_flags (flags);cli ()
-#define RELEASEIT restore_flags (flags)
+#define LOCKIT    spin_lock_irqsave(&driver_lock, flags)
+#define RELEASEIT spin_unlock_irqrestore(&driver_lock, flags)
 #endif
 
 #define RS_EVENT_WRITE_WAKEUP	1
@@ -208,9 +210,8 @@
 	if (!port || !port->xmit_buf || !tmp_buf)
 		return -EIO;
 
-	save_flags(flags);
+	spin_lock_irqsave(&driver_lock, flags);
 	while (1) {
-		cli();
 		c = count;
 
 		/* This is safe because we "OWN" the "head". Noone else can 
@@ -227,18 +228,17 @@
 
 		/* Can't copy more? break out! */
 		if (c <= 0) {
-			restore_flags(flags);
 			break;
 		}
 		memcpy(port->xmit_buf + port->xmit_head, buf, c);
 		port->xmit_head = ((port->xmit_head + c) &
 		                   (SERIAL_XMIT_SIZE-1));
 		port->xmit_cnt += c;
-		restore_flags(flags);
 		buf += c;
 		count -= c;
 		total += c;
 	}
+	spin_unlock_irqrestore(&driver_lock, flags);
 
 	if (port->xmit_cnt && 
 	    !tty->stopped && 
@@ -380,9 +380,9 @@
 	if (!port) return;
 
 	/* XXX Would the write semaphore do? */
-	save_flags(flags); cli();
+	spin_lock_irqsave(&driver_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&driver_lock, flags);
 
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
@@ -468,8 +468,7 @@
 	if (!(port->flags & ASYNC_INITIALIZED))
 		return;
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&driver_lock, flags);
 
 	if (port->xmit_buf) {
 		free_page((unsigned long) port->xmit_buf);
@@ -482,7 +481,7 @@
 	port->rd->shutdown_port (port);
 
 	port->flags &= ~ASYNC_INITIALIZED;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&driver_lock, flags);
 
 	func_exit();
 }
@@ -570,10 +569,10 @@
 	add_wait_queue(&port->open_wait, &wait);
 
 	gs_dprintk (GS_DEBUG_BTR, "after add waitq.\n"); 
-	cli();
+	spin_lock_irq(&driver_lock);
 	if (!tty_hung_up_p(filp))
 		port->count--;
-	sti();
+	spin_unlock_irq(&driver_lock);
 	port->blocked_open++;
 	while (1) {
 		CD = port->rd->get_CD (port);
@@ -633,13 +632,12 @@
 		port->tty = tty;
 	}
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&driver_lock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
 		port->rd->hungup (port);
 		func_exit ();
-		return;
+		goto gs_close_exit;
 	}
 
 	if ((tty->count == 1) && (port->count != 1)) {
@@ -653,9 +651,8 @@
 	}
 	if (port->count) {
 		gs_dprintk(GS_DEBUG_CLOSE, "gs_close: count: %d\n", port->count);
-		restore_flags(flags);
 		func_exit ();
-		return;
+		goto gs_close_exit;
 	}
 	port->flags |= ASYNC_CLOSING;
 
@@ -702,7 +699,8 @@
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING | ASYNC_INITIALIZED);
 	wake_up_interruptible(&port->close_wait);
 
-	restore_flags(flags);
+gs_close_exit:
+	spin_unlock_irqrestore(&driver_lock, flags);
 	func_exit ();
 }
 
@@ -836,16 +834,15 @@
 	unsigned long flags;
 	unsigned long page;
 
-	save_flags (flags);
 	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
 
-		cli (); /* Don't expect this to make a difference. */ 
+		spin_lock_irqsave(&driver_lock, flags); /* Don't expect this to make a difference. */ 
 		if (tmp_buf)
 			free_page(page);
 		else
 			tmp_buf = (unsigned char *) page;
-		restore_flags (flags);
+		spin_unlock_irqrestore(&driver_lock, flags);
 
 		if (!tmp_buf) {
 			return -ENOMEM;
@@ -862,18 +859,18 @@
 		tmp = get_zeroed_page(GFP_KERNEL);
 
 		/* Spinlock? */
-		cli ();
+		spin_lock_irqsave(&driver_lock, flags);
 		if (port->xmit_buf) 
 			free_page (tmp);
 		else
 			port->xmit_buf = (unsigned char *) tmp;
-		restore_flags (flags);
+		spin_unlock_irqrestore(&driver_lock, flags);
 
 		if (!port->xmit_buf)
 			return -ENOMEM;
 	}
 
-	cli();
+	spin_lock_irqsave(&driver_lock, flags);
 
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
@@ -885,7 +882,7 @@
 	port->flags |= ASYNC_INITIALIZED;
 	port->flags &= ~GS_TX_INTEN;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&driver_lock, flags);
 	return 0;
 }
 
