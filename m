Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULHNh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULHNh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbULHNhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:37:37 -0500
Received: from users.linvision.com ([62.58.92.114]:63974 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261212AbULHN3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:29:41 -0500
Date: Wed, 8 Dec 2004 14:29:38 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: [PATCH] generic-serial
Message-ID: <20041208132938.GB19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Patrick van de Lageweg <patrick@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch converts all save_flags/restore_flags to the new 
spin_lick_irqsave/spin_unlock_irqrestore calls, as well as some
other 2.6.X cleanups. This prepares the way for the "io8+",
"sx" and "rio" drivers to become SMP safe. Patches for those
drivers follow. 

Signed-off-by: Patrick vd Lageweg <patrick@bitwizard.nl>
Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl>

	Patrick

--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-08122004-2.6.10-rc3-generic-serial"

diff -u -r linux-2.6.10-rc3-clean/drivers/char/generic_serial.c linux-2.6.10-rc3-generix-serial/drivers/char/generic_serial.c
--- linux-2.6.10-rc3-clean/drivers/char/generic_serial.c	Fri Dec  3 15:13:32 2004
+++ linux-2.6.10-rc3-generix-serial/drivers/char/generic_serial.c	Fri Dec  3 15:23:37 2004
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/generic_serial.h>
 #include <linux/interrupt.h>
+#include <linux/tty_flip.h>
 #include <linux/delay.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -45,8 +46,8 @@
 
 #define func_enter() gs_dprintk (GS_DEBUG_FLOW, "gs: enter %s\n", __FUNCTION__)
 #define func_exit()  gs_dprintk (GS_DEBUG_FLOW, "gs: exit  %s\n", __FUNCTION__)
-
-#ifdef NEW_WRITE_LOCKING
+#define NEW_WRITE_LOCKING 1
+#if NEW_WRITE_LOCKING
 #define DECL      /* Nothing */
 #define LOCKIT    down (& port->port_write_sem);
 #define RELEASEIT up (&port->port_write_sem);
@@ -208,7 +209,7 @@
 	if (!port || !port->xmit_buf || !tmp_buf)
 		return -EIO;
 
-	save_flags(flags);
+	local_save_flags(flags);
 	while (1) {
 		cli();
 		c = count;
@@ -227,14 +228,14 @@
 
 		/* Can't copy more? break out! */
 		if (c <= 0) {
-			restore_flags(flags);
+			local_restore_flags(flags);
 			break;
 		}
 		memcpy(port->xmit_buf + port->xmit_head, buf, c);
 		port->xmit_head = ((port->xmit_head + c) &
 		                   (SERIAL_XMIT_SIZE-1));
 		port->xmit_cnt += c;
-		restore_flags(flags);
+		local_restore_flags(flags);
 		buf += c;
 		count -= c;
 		total += c;
@@ -380,9 +381,9 @@
 	if (!port) return;
 
 	/* XXX Would the write semaphore do? */
-	save_flags(flags); cli();
+	spin_lock_irqsave (&port->driver_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore (&port->driver_lock, flags);
 
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
@@ -468,8 +469,7 @@
 	if (!(port->flags & ASYNC_INITIALIZED))
 		return;
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&port->driver_lock, flags);
 
 	if (port->xmit_buf) {
 		free_page((unsigned long) port->xmit_buf);
@@ -482,7 +482,7 @@
 	port->rd->shutdown_port (port);
 
 	port->flags &= ~ASYNC_INITIALIZED;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&port->driver_lock, flags);
 
 	func_exit();
 }
@@ -540,6 +540,7 @@
 	int    do_clocal = 0;
 	int    CD;
 	struct tty_struct *tty;
+	unsigned long flags;
 
 	func_enter ();
 
@@ -591,10 +592,11 @@
 	add_wait_queue(&port->open_wait, &wait);
 
 	gs_dprintk (GS_DEBUG_BTR, "after add waitq.\n"); 
-	cli();
-	if (!tty_hung_up_p(filp))
+	spin_lock_irqsave(&port->driver_lock, flags);
+	if (!tty_hung_up_p(filp)) {
 		port->count--;
-	sti();
+	}
+	spin_unlock_irqrestore(&port->driver_lock, flags);
 	port->blocked_open++;
 	while (1) {
 		CD = port->rd->get_CD (port);
@@ -623,8 +625,9 @@
 		    port->blocked_open);
 	set_current_state (TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
-	if (!tty_hung_up_p(filp))
+	if (!tty_hung_up_p(filp)) {
 		port->count++;
+	}
 	port->blocked_open--;
 	if (retval)
 		return retval;
@@ -654,27 +657,29 @@
 		port->tty = tty;
 	}
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&port->driver_lock, flags);
 
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
-		port->rd->hungup (port);
+		spin_unlock_irqrestore(&port->driver_lock, flags);
+		if (port->rd->hungup) 
+			port->rd->hungup (port);
 		func_exit ();
 		return;
 	}
 
 	if ((tty->count == 1) && (port->count != 1)) {
-		printk(KERN_ERR "gs: gs_close: bad port count;"
-		       " tty->count is 1, port count is %d\n", port->count);
+		printk(KERN_ERR "gs: gs_close port %p: bad port count;"
+		       " tty->count is 1, port count is %d\n", port, port->count);
 		port->count = 1;
 	}
 	if (--port->count < 0) {
-		printk(KERN_ERR "gs: gs_close: bad port count: %d\n", port->count);
+		printk(KERN_ERR "gs: gs_close port %p: bad port count: %d\n", port, port->count);
 		port->count = 0;
 	}
+
 	if (port->count) {
-		gs_dprintk(GS_DEBUG_CLOSE, "gs_close: count: %d\n", port->count);
-		restore_flags(flags);
+		gs_dprintk(GS_DEBUG_CLOSE, "gs_close port %p: count: %d\n", port, port->count);
+		spin_unlock_irqrestore(&port->driver_lock, flags);
 		func_exit ();
 		return;
 	}
@@ -696,16 +701,17 @@
 	 */
 
 	port->rd->disable_rx_interrupts (port);
+	spin_unlock_irqrestore(&port->driver_lock, flags);
 
 	/* close has no way of returning "EINTR", so discard return value */
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		gs_wait_tx_flushed (port, port->closing_wait); 
+		gs_wait_tx_flushed (port, port->closing_wait);
 
 	port->flags &= ~GS_ACTIVE;
 
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
-		
+
 	tty_ldisc_flush(tty);
 	tty->closing = 0;
 
@@ -716,14 +722,15 @@
 
 	if (port->blocked_open) {
 		if (port->close_delay) {
+			spin_unlock_irqrestore(&port->driver_lock, flags);
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
+			spin_lock_irqsave(&port->driver_lock, flags);
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING | ASYNC_INITIALIZED);
 	wake_up_interruptible(&port->close_wait);
 
-	restore_flags(flags);
 	func_exit ();
 }
 
@@ -748,6 +755,12 @@
 	port = tty->driver_data;
 
 	if (!port) return;
+	if (!port->tty) {
+		/* This seems to happen when this is called after gs_close. */
+		gs_dprintk (GS_DEBUG_TERMIOS, "gs: Odd: port->tty is NULL\n");
+		port->tty = tty;
+	}
+	
 
 	tiosp = tty->termios;
 
@@ -842,7 +855,7 @@
 
 	if (!(old_termios->c_cflag & CLOCAL) &&
 	    (tty->termios->c_cflag & CLOCAL))
-		wake_up_interruptible(&info->open_wait);
+		wake_up_interruptible(&port->gs.open_wait);
 #endif
 
 	func_exit();
@@ -857,56 +870,56 @@
 	unsigned long flags;
 	unsigned long page;
 
-	save_flags (flags);
-	if (!tmp_buf) {
-		page = get_zeroed_page(GFP_KERNEL);
+	func_enter ();
 
-		cli (); /* Don't expect this to make a difference. */ 
+        if (!tmp_buf) {
+		page = get_zeroed_page(GFP_KERNEL);
+		spin_lock_irqsave (&port->driver_lock, flags); /* Don't expect this to make a difference. */ 
 		if (tmp_buf)
 			free_page(page);
 		else
 			tmp_buf = (unsigned char *) page;
-		restore_flags (flags);
-
+		spin_unlock_irqrestore (&port->driver_lock, flags);
 		if (!tmp_buf) {
+			func_exit ();
 			return -ENOMEM;
 		}
 	}
 
-	if (port->flags & ASYNC_INITIALIZED)
+	if (port->flags & ASYNC_INITIALIZED) {
+		func_exit ();
 		return 0;
-
+	}
 	if (!port->xmit_buf) {
 		/* We may sleep in get_zeroed_page() */
 		unsigned long tmp;
 
 		tmp = get_zeroed_page(GFP_KERNEL);
-
-		/* Spinlock? */
-		cli ();
+		spin_lock_irqsave (&port->driver_lock, flags);
 		if (port->xmit_buf) 
 			free_page (tmp);
 		else
 			port->xmit_buf = (unsigned char *) tmp;
-		restore_flags (flags);
-
-		if (!port->xmit_buf)
+		spin_unlock_irqrestore(&port->driver_lock, flags);
+		if (!port->xmit_buf) {
+			func_exit ();
 			return -ENOMEM;
+		}
 	}
 
-	cli();
-
+	spin_lock_irqsave (&port->driver_lock, flags);
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
-
+	init_MUTEX(&port->port_write_sem);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-
+	spin_unlock_irqrestore(&port->driver_lock, flags);
 	gs_set_termios(port->tty, NULL);
-
+	spin_lock_irqsave (&port->driver_lock, flags);
 	port->flags |= ASYNC_INITIALIZED;
 	port->flags &= ~GS_TX_INTEN;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&port->driver_lock, flags);
+	func_exit ();
 	return 0;
 }
 
@@ -977,13 +990,15 @@
 
 void gs_got_break(struct gs_port *port)
 {
+	func_enter ();
+
+	tty_insert_flip_char(port->tty, 0, TTY_BREAK);
+	tty_schedule_flip(port->tty);
 	if (port->flags & ASYNC_SAK) {
 		do_SAK (port->tty);
 	}
-	*(port->tty->flip.flag_buf_ptr) = TTY_BREAK;
-	port->tty->flip.flag_buf_ptr++;
-	port->tty->flip.char_buf_ptr++;
-	port->tty->flip.count++;
+
+	func_exit ();
 }
 
 
diff -u -r linux-2.6.10-rc3-clean/include/linux/generic_serial.h linux-2.6.10-rc3-generix-serial/include/linux/generic_serial.h
--- linux-2.6.10-rc3-clean/include/linux/generic_serial.h	Fri Dec  3 15:14:23 2004
+++ linux-2.6.10-rc3-generix-serial/include/linux/generic_serial.h	Fri Dec  3 15:23:37 2004
@@ -34,7 +34,7 @@
   int                     xmit_head;
   int                     xmit_tail;
   int                     xmit_cnt;
-  /*  struct semaphore        port_write_sem; */
+  struct semaphore        port_write_sem;
   int                     flags;
   wait_queue_head_t       open_wait;
   wait_queue_head_t       close_wait;
@@ -49,6 +49,7 @@
   int                     baud_base;
   int                     baud;
   int                     custom_divisor;
+  spinlock_t              driver_lock;
 };
 
 
@@ -70,6 +71,7 @@
 #define GS_DEBUG_STUFF   0x00000008
 #define GS_DEBUG_CLOSE   0x00000010
 #define GS_DEBUG_FLOW    0x00000020
+#define GS_DEBUG_WRITE   0x00000040
 
 
 void gs_put_char(struct tty_struct *tty, unsigned char ch);

--MW5yreqqjyrRcusr--
