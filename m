Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUAMSKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUAMSKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:10:41 -0500
Received: from palrel11.hp.com ([156.153.255.246]:56475 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264498AbUAMSKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:10:36 -0500
Date: Tue, 13 Jan 2004 10:10:34 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Re: [PROBLEM] ircomm ioctls
Message-ID: <20040113181034.GA9960@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote :
> 
> On Tue, Jan 13, 2004 at 12:00:15PM +0100, Jozef Vesely wrote:
> > I am gettig this error (while connecting to my mobile phone):
> > ------
> > # gsmctl -d /dev/ircomm0  ALL
> > gsmctl[ERROR]: clearing DTR failed (errno: 22/Invalid argument)
> > ------
> 
> ircomm needs updating to use the tiocmset/tiocmget driver calls.  Could
> you see if the following patch solves your problem please?

	Good catch. Is there any other API changes worth looking into ?

	By the way, I would rather keep the function
ircomm_tty_tiocmget() and ircomm_tty_tiocmset() in ircomm_tty_ioctl.c,
because ircomm_tty.c is already big and messy.
	Check the patch below (quickly tested).

	Thanks !

	Jean

---------------------------------------------------------------------

diff -u -p linux/include/net/irda/ircomm_tty.d5.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda/ircomm_tty.d5.h	Tue Jan 13 09:51:52 2004
+++ linux/include/net/irda/ircomm_tty.h	Tue Jan 13 10:01:11 2004
@@ -122,6 +122,9 @@ void ircomm_tty_stop(struct tty_struct *
 void ircomm_tty_check_modem_status(struct ircomm_tty_cb *self);
 
 extern void ircomm_tty_change_speed(struct ircomm_tty_cb *self);
+extern int ircomm_tty_tiocmget(struct tty_struct *tty, struct file *file);
+extern int ircomm_tty_tiocmset(struct tty_struct *tty, struct file *file,
+			       unsigned int set, unsigned int clear);
 extern int ircomm_tty_ioctl(struct tty_struct *tty, struct file *file, 
 			    unsigned int cmd, unsigned long arg);
 extern void ircomm_tty_set_termios(struct tty_struct *tty, 
diff -u -p linux/net/irda/ircomm/ircomm_tty.d5.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d5.c	Tue Jan 13 09:55:04 2004
+++ linux/net/irda/ircomm/ircomm_tty.c	Tue Jan 13 10:02:52 2004
@@ -86,7 +86,9 @@ static struct tty_operations ops = {
 	.write_room      = ircomm_tty_write_room,
 	.chars_in_buffer = ircomm_tty_chars_in_buffer,
 	.flush_buffer    = ircomm_tty_flush_buffer,
-	.ioctl           = ircomm_tty_ioctl,
+	.ioctl           = ircomm_tty_ioctl,	/* ircomm_tty_ioctl.c */
+	.tiocmget        = ircomm_tty_tiocmget,	/* ircomm_tty_ioctl.c */
+	.tiocmset        = ircomm_tty_tiocmset,	/* ircomm_tty_ioctl.c */
 	.throttle        = ircomm_tty_throttle,
 	.unthrottle      = ircomm_tty_unthrottle,
 	.send_xchar      = ircomm_tty_send_xchar,
diff -u -p linux/net/irda/ircomm/ircomm_tty_ioctl.d5.c linux/net/irda/ircomm/ircomm_tty_ioctl.c
--- linux/net/irda/ircomm/ircomm_tty_ioctl.d5.c	Tue Jan 13 09:54:53 2004
+++ linux/net/irda/ircomm/ircomm_tty_ioctl.c	Tue Jan 13 10:00:52 2004
@@ -190,14 +190,14 @@ void ircomm_tty_set_termios(struct tty_s
 }
 
 /*
- * Function ircomm_tty_get_modem_info (self, value)
+ * Function ircomm_tty_tiocmget (tty, file)
  *
  *    
  *
  */
-static int ircomm_tty_get_modem_info(struct ircomm_tty_cb *self, 
-				     unsigned int *value)
+int ircomm_tty_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 	unsigned int result;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
@@ -209,62 +209,38 @@ static int ircomm_tty_get_modem_info(str
 		| ((self->settings.dce & IRCOMM_DSR) ? TIOCM_DSR : 0)
 		| ((self->settings.dce & IRCOMM_CTS) ? TIOCM_CTS : 0);
 
-	return put_user(result, value);
+	return result;
 }
 
 /*
- * Function set_modem_info (driver, cmd, value)
+ * Function ircomm_tty_tiocmset (tty, file, set, clear)
  *
  *    
  *
  */
-static int ircomm_tty_set_modem_info(struct ircomm_tty_cb *self, 
-				     unsigned int cmd, unsigned int *value)
+int ircomm_tty_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear)
 { 
-	unsigned int arg;
-	__u8 old_rts, old_dtr;
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
-	if (get_user(arg, value))
-		return -EFAULT;
-
-	old_rts = self->settings.dte & IRCOMM_RTS;
-	old_dtr = self->settings.dte & IRCOMM_DTR;
+	if (set & TIOCM_RTS)
+		self->settings.dte |= IRCOMM_RTS;
+	if (set & TIOCM_DTR)
+		self->settings.dte |= IRCOMM_DTR;
+
+	if (clear & TIOCM_RTS)
+		self->settings.dte &= ~IRCOMM_RTS;
+	if (clear & TIOCM_DTR)
+		self->settings.dte &= ~IRCOMM_DTR;
 
-	switch (cmd) {
-	case TIOCMBIS: 
-		if (arg & TIOCM_RTS) 
-			self->settings.dte |= IRCOMM_RTS;
-		if (arg & TIOCM_DTR)
-			self->settings.dte |= IRCOMM_DTR;
-		break;
-		
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			self->settings.dte &= ~IRCOMM_RTS;
-		if (arg & TIOCM_DTR)
- 			self->settings.dte &= ~IRCOMM_DTR;
- 		break;
-		
-	case TIOCMSET:
- 		self->settings.dte = 
-			((self->settings.dte & ~(IRCOMM_RTS | IRCOMM_DTR))
-			 | ((arg & TIOCM_RTS) ? IRCOMM_RTS : 0)
-			 | ((arg & TIOCM_DTR) ? IRCOMM_DTR : 0));
-		break;
-		
-	default:
-		return -EINVAL;
-	}
-	
-	if ((self->settings.dte & IRCOMM_RTS) != old_rts)
+	if ((set|clear) & TIOCM_RTS)
 		self->settings.dte |= IRCOMM_DELTA_RTS;
-
-	if ((self->settings.dte & IRCOMM_DTR) != old_dtr)
+	if ((set|clear) & TIOCM_DTR)
 		self->settings.dte |= IRCOMM_DELTA_DTR;
 
 	ircomm_param_request(self, IRCOMM_DTE, TRUE);
@@ -406,14 +382,6 @@ int ircomm_tty_ioctl(struct tty_struct *
 	}
 
 	switch (cmd) {
-	case TIOCMGET:
-		ret = ircomm_tty_get_modem_info(self, (unsigned int *) arg);
-		break;
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		ret = ircomm_tty_set_modem_info(self, cmd, (unsigned int *) arg);
-		break;
 	case TIOCGSERIAL:
 		ret = ircomm_tty_get_serial_info(self, (struct serial_struct *) arg);
 		break;

