Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTDMPxB (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 11:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTDMPxB (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 11:53:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263479AbTDMPw4 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 11:52:56 -0400
Date: Sun, 13 Apr 2003 17:04:39 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030413170439.B855@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk> <20030408174443.GA23935@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030408174443.GA23935@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Apr 08, 2003 at 10:44:43AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

How about this patch - this also moves the ioctl parsing to the tty
layer.  I'm intending all drivers should provide tiocmget and tiocmset
methods if they implement modem control lines, and not parse the
corresponding ioctl command numbers in their ioctl method.

Note - this patch has only been compile-tested except for the last file,
and may apply with an offset(s).  The irtty-sir patch is actually yours;
I just edited your patch for that file since it was a straight forward
change.

--- ref/include/linux/tty_driver.h	Fri Jan 17 10:24:15 2003
+++ linux/include/linux/tty_driver.h	Sun Apr 13 14:03:11 2003
@@ -172,6 +172,9 @@
 			  int count, int *eof, void *data);
 	int (*write_proc)(struct file *file, const char *buffer,
 			  unsigned long count, void *data);
+	int (*tiocmget)(struct tty_struct *tty, struct file *file);
+	int (*tiocmset)(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear);
 	struct list_head tty_drivers;
 };
 
--- ref/drivers/char/tty_io.c	Sat Apr 12 15:02:35 2003
+++ linux/drivers/char/tty_io.c	Sun Apr 13 14:51:34 2003
@@ -1704,6 +1704,55 @@
 	return 0;
 }
 
+static int
+tty_tiocmget(struct tty_struct *tty, struct file *file, unsigned long arg)
+{
+	int retval = -ENOIOCTLCMD;
+
+	if (tty->driver.tiocmget) {
+		retval = tty->driver.tiocmget(tty, file);
+
+		if (retval >= 0)
+			retval = put_user(retval, (int *)arg);
+	}
+	return retval;
+}
+
+static int
+tty_tiocmset(struct tty_struct *tty, struct file *file, unsigned int cmd,
+	     unsigned long arg)
+{
+	int retval = -ENOIOCTLCMD;
+
+	if (tty->driver.tiocmset) {
+		unsigned int set, clear, val;
+
+		retval = get_user(val, (unsigned int *)arg);
+		if (retval)
+			return retval;
+
+		set = clear = 0;
+		switch (cmd) {
+		case TIOCMBIS:
+			set = val;
+			break;
+		case TIOCMBIC:
+			clear = val;
+			break;
+		case TIOCMSET:
+			set = val;
+			clear = ~val;
+			break;
+		}
+
+		set &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2;
+		clear &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2;
+
+		retval = tty->driver.tiocmset(tty, file, set, clear);
+	}
+	return retval;
+}
+
 /*
  * Split this up, as gcc can choke on it otherwise..
  */
@@ -1829,6 +1878,20 @@
 			return 0;
 		case TCSBRKP:	/* support for POSIX tcsendbreak() */	
 			return send_break(tty, arg ? arg*(HZ/10) : HZ/4);
+
+		case TIOCMGET:
+			retval = tty_tiocmget(tty, file, arg);
+			if (retval != -ENOIOCTLCMD)
+				return retval;
+			break;
+
+		case TIOCMSET:
+		case TIOCMBIC:
+		case TIOCMBIS:
+			retval = tty_tiocmset(tty, file, cmd, arg);
+			if (retval != -ENOIOCTLCMD)
+				return retval;
+			break;
 	}
 	if (tty->driver.ioctl) {
 		int retval = (tty->driver.ioctl)(tty, file, cmd, arg);
--- ref/drivers/serial/core.c	Tue Mar 18 00:27:13 2003
+++ linux/drivers/serial/core.c	Sun Apr 13 14:41:49 2003
@@ -874,45 +874,38 @@
 	return put_user(result, value);
 }
 
-static int uart_get_modem_info(struct uart_port *port, unsigned int *value)
+static int uart_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	unsigned int result = port->mctrl;
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	int result = -EIO;
 
-	result |= port->ops->get_mctrl(port);
+	down(&state->sem);
+	if ((!file || !tty_hung_up_p(file)) &&
+	    !(tty->flags & (1 << TTY_IO_ERROR))) {
+		result = port->mctrl;
+		result |= port->ops->get_mctrl(port);
+	}
+	up(&state->sem);
 
-	return put_user(result, value);
+	return result;
 }
 
 static int
-uart_set_modem_info(struct uart_port *port, unsigned int cmd,
-		    unsigned int *value)
+uart_tiocmset(struct tty_struct *tty, struct file *file,
+	      unsigned int set, unsigned int clear)
 {
-	unsigned int arg, set, clear;
-	int ret = 0;
-
-	if (get_user(arg, value))
-		return -EFAULT;
-
-	arg &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2;
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->port;
+	int ret = -EIO;
 
-	set = clear = 0;
-	switch (cmd) {
-	case TIOCMBIS:
-		set = arg;
-		break;
-	case TIOCMBIC:
-		clear = arg;
-		break;
-	case TIOCMSET:
-		set = arg;
-		clear = ~arg;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	if (ret == 0)
+	down(&state->sem);
+	if ((!file || !tty_hung_up_p(file)) &&
+	    !(tty->flags & (1 << TTY_IO_ERROR))) {
 		uart_update_mctrl(port, set, clear);
+		ret = 0;
+	}
+	up(&state->sem);
 	return ret;
 }
 
@@ -923,8 +916,12 @@
 
 	BUG_ON(!kernel_locked());
 
+	down(&state->sem);
+
 	if (port->type != PORT_UNKNOWN)
 		port->ops->break_ctl(port, break_state);
+
+	up(&state->sem);
 }
 
 static int uart_do_autoconfig(struct uart_state *state)
@@ -1131,17 +1128,6 @@
 	 * protected against the tty being hung up.
 	 */
 	switch (cmd) {
-	case TIOCMGET:
-		ret = uart_get_modem_info(state->port, (unsigned int *)arg);
-		break;
-
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		ret = uart_set_modem_info(state->port, cmd,
-					  (unsigned int *)arg);
-		break;
-
 	case TIOCSERGETLSR: /* Get line status register */
 		ret = uart_get_lsr_info(state, (unsigned int *)arg);
 		break;
@@ -2163,6 +2149,8 @@
 #ifdef CONFIG_PROC_FS
 	normal->read_proc	= uart_read_proc;
 #endif
+	normal->tiocmget	= uart_tiocmget;
+	normal->tiocmset	= uart_tiocmset;
 
 	/*
 	 * Initialise the UART state(s).
--- ref/drivers/net/irda/irtty-sir.c	Tue Apr  8 09:46:54 2003
+++ linux/drivers/net/irda/irtty-sir.c	Tue Apr  8 10:34:53 2003
@@ -180,32 +180,29 @@ static int irtty_change_speed(struct sir
 static int irtty_set_dtr_rts(struct sir_dev *dev, int dtr, int rts)
 {
 	struct sirtty_cb *priv = dev->priv;
-	int arg = 0;
+	int set = 0;
+	int clear = 0;
 
 	ASSERT(priv != NULL, return -1;);
 	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
 
-#ifdef TIOCM_OUT2 /* Not defined for ARM */
-	arg = TIOCM_OUT2;
-#endif
 	if (rts)
-		arg |= TIOCM_RTS;
+		set |= TIOCM_RTS;
+	else
+		clear |= TIOCM_RTS;
 	if (dtr)
-		arg |= TIOCM_DTR;
+		set |= TIOCM_DTR;
+	else
+		clear |= TIOCM_DTR;
 
 	/*
-	 * The ioctl() function, or actually set_modem_info() in serial.c
-	 * expects a pointer to the argument in user space. This is working
-	 * here because we are always called from the kIrDAd thread which
-	 * has set_fs(KERNEL_DS) permanently set. Therefore copy_from_user()
-	 * is happy with our arg-parameter being local here in kernel space.
+	 * We can't use ioctl() because it expects a non-null file structure,
+	 * and we don't have that here.
+	 * This function is not yet defined for all tty driver, so
+	 * let's be careful... Jean II
 	 */
-
-	lock_kernel();
-	if (priv->tty->driver.ioctl(priv->tty, NULL, TIOCMSET, (unsigned long) &arg)) { 
-		IRDA_DEBUG(2, "%s(), error doing ioctl!\n", __FUNCTION__);
-	}
-	unlock_kernel();
+	ASSERT(priv->tty->driver.tiocmset != NULL, return -1;);
+	priv->tty->driver.tiocmset(priv->tty, NULL, set, clear);
 
 	return 0;
 }


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
