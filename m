Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbTDHRdR (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDHRdR (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:33:17 -0400
Received: from palrel13.hp.com ([156.153.255.238]:44756 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261952AbTDHRdL (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:33:11 -0400
Date: Tue, 8 Apr 2003 10:44:43 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030408174443.GA23935@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404102535.A29313@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 10:25:35AM +0100, Russell King wrote:
> On Thu, Apr 03, 2003 at 05:34:05PM -0800, Jean Tourrilhes wrote:
> > 	Unfortunately, the irtty-sir driver, which is a TTY line
> > discipline and a network driver, need to be able to change the RTS and
> > DTR line from a kernel thread.
> 
> I'd prefer if we added an tty API to allow line disciplines to read/set
> the modem control lines to the tty later, rather than having line
> disciplines play games with IOCTLs.

	So, the patch has to look like what is below.
	I've decided to use the internal set/clear API, because it
allow to ignore the default state of control line (all the troubles
with TIOCM_OUT2/TIOCM_OUT1 on various platforms), so it's definitely a
win.
	I'm not too sure about locking. I guess the spinlock in
uart_update_mctrl() is probably good enough.
	I was tempted to create the same API for setting the speed
(baud rate), but that may need to wait for another time.

	As you can't use IrDA SIR with 2.5.X, would you mind giving a
look at the issue ? Feel free to forward as needed to get comments
from all the interested parties. Thanks in advance...

	Have fun...

	Jean

---------------------------------------------------------------

diff -u -p linux/include/linux/tty_driver.d0.h linux/include/linux/tty_driver.h
--- linux/include/linux/tty_driver.d0.h	Tue Apr  8 09:56:21 2003
+++ linux/include/linux/tty_driver.h	Tue Apr  8 10:09:09 2003
@@ -157,6 +157,8 @@ struct tty_driver {
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
+	int  (*modem_ctrl)(struct tty_struct *tty,
+			   unsigned int set, unsigned int clear);
 	void (*set_termios)(struct tty_struct *tty, struct termios * old);
 	void (*throttle)(struct tty_struct * tty);
 	void (*unthrottle)(struct tty_struct * tty);
diff -u -p linux/drivers/serial/core.d0.c linux/drivers/serial/core.c
--- linux/drivers/serial/core.d0.c	Tue Apr  8 09:51:00 2003
+++ linux/drivers/serial/core.c	Tue Apr  8 10:15:29 2003
@@ -1158,6 +1158,26 @@ uart_ioctl(struct tty_struct *tty, struc
 	return ret;
 }
 
+/*
+ * Called by line disciplines to change the various modem control bits...
+ * Line disciplines are implemented within the kernel, and therefore
+ * we don't want them to use the ioctl function above.
+ * Jean II
+ */
+static int
+uart_modem_ctrl(struct tty_struct *tty, unsigned int set, unsigned int clear)
+{
+	struct uart_state *state = tty->driver_data;
+
+	/* Set new values, if any */
+	/* Locking will be done in there */
+	uart_update_mctrl(state->port, set, clear);
+
+	/* Return new value */
+	return state->port->ops->get_mctrl(state->port);
+}
+
+
 static void uart_set_termios(struct tty_struct *tty, struct termios *old_termios)
 {
 	struct uart_state *state = tty->driver_data;
@@ -2150,6 +2170,7 @@ int uart_register_driver(struct uart_dri
 	normal->chars_in_buffer	= uart_chars_in_buffer;
 	normal->flush_buffer	= uart_flush_buffer;
 	normal->ioctl		= uart_ioctl;
+	normal->modem_ctrl	= uart_modem_ctrl;
 	normal->throttle	= uart_throttle;
 	normal->unthrottle	= uart_unthrottle;
 	normal->send_xchar	= uart_send_xchar;
diff -u -p linux/drivers/net/irda/irtty-sir.d0.c linux/drivers/net/irda/irtty-sir.c
--- linux/drivers/net/irda/irtty-sir.d0.c	Tue Apr  8 09:46:54 2003
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
+	ASSERT(priv->tty->driver.modem_ctrl != NULL, return -1;);
+	priv->tty->driver.modem_ctrl(priv->tty, set, clear);
 
 	return 0;
 }
diff -u -p linux/drivers/net/irda/sir_kthread.d0.c linux/drivers/net/irda/sir_kthread.c
--- linux/drivers/net/irda/sir_kthread.d0.c	Mon Apr  7 18:56:28 2003
+++ linux/drivers/net/irda/sir_kthread.c	Mon Apr  7 18:59:31 2003
@@ -151,6 +151,13 @@ static int irda_thread(void *startup)
 
 	while (irda_rq_queue.thread != NULL) {
 
+		/* We use TASK_INTERRUPTIBLE, rather than
+		 * TASK_UNINTERRUPTIBLE.  Andrew Morton made this
+		 * change ; he told me that it is safe, because "signal
+		 * blocking is now handled in daemonize()", he added
+		 * that the problem is that "uninterruptible sleep
+		 * contributes to load average", making user worry.
+		 * Jean II */
 		set_task_state(current, TASK_INTERRUPTIBLE);
 		add_wait_queue(&irda_rq_queue.kick, &wait);
 		if (list_empty(&irda_rq_queue.request_list))
