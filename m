Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUAMLhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUAMLhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:37:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22800 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261660AbUAMLg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:36:56 -0500
Date: Tue, 13 Jan 2004 11:36:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jozef Vesely <vesely@gjh.sk>
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] ircomm ioctls
Message-ID: <20040113113650.A2975@flint.arm.linux.org.uk>
Mail-Followup-To: Jozef Vesely <vesely@gjh.sk>,
	irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>; from vesely@gjh.sk on Tue, Jan 13, 2004 at 12:00:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 12:00:15PM +0100, Jozef Vesely wrote:
> I am gettig this error (while connecting to my mobile phone):
> ------
> # gsmctl -d /dev/ircomm0  ALL
> gsmctl[ERROR]: clearing DTR failed (errno: 22/Invalid argument)
> ------

ircomm needs updating to use the tiocmset/tiocmget driver calls.  Could
you see if the following patch solves your problem please?

===== ircomm/ircomm_tty.c 1.31 vs edited =====
--- 1.31/net/irda/ircomm/ircomm_tty.c	Fri Jan  9 10:10:13 2004
+++ edited/ircomm/ircomm_tty.c	Tue Jan 13 11:33:58 2004
@@ -75,6 +75,9 @@
 static int ircomm_tty_read_proc(char *buf, char **start, off_t offset, int len,
 				int *eof, void *unused);
 #endif /* CONFIG_PROC_FS */
+static int ircomm_tty_tiocmget(struct tty_struct *tty, struct file *file);
+static int ircomm_tty_tiocmset(struct tty_struct *tty, struct file *file,
+			       unsigned int set, unsigned int clear);
 static struct tty_driver *driver;
 
 hashbin_t *ircomm_tty = NULL;
@@ -98,6 +101,8 @@
 #ifdef CONFIG_PROC_FS
 	.read_proc       = ircomm_tty_read_proc,
 #endif /* CONFIG_PROC_FS */
+	.tiocmget        = ircomm_tty_tiocmget,
+	.tiocmset        = ircomm_tty_tiocmset,
 };
 
 /*
@@ -1408,6 +1413,62 @@
         return ((len < begin+count-offset) ? len : begin+count-offset);
 }
 #endif /* CONFIG_PROC_FS */
+
+/*
+ * Function ircomm_tty_tiocmget (tty, file)
+ *
+ *    
+ *
+ */
+static int ircomm_tty_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
+
+	return    ((self->settings.dte & IRCOMM_RTS) ? TIOCM_RTS : 0)
+		| ((self->settings.dte & IRCOMM_DTR) ? TIOCM_DTR : 0)
+		| ((self->settings.dce & IRCOMM_CD)  ? TIOCM_CAR : 0)
+		| ((self->settings.dce & IRCOMM_RI)  ? TIOCM_RNG : 0)
+		| ((self->settings.dce & IRCOMM_DSR) ? TIOCM_DSR : 0)
+		| ((self->settings.dce & IRCOMM_CTS) ? TIOCM_CTS : 0);
+}
+
+/*
+ * Function ircomm_tty_tiocmset (driver, cmd, value)
+ *
+ *    
+ *
+ */
+static int ircomm_tty_tiocmset(struct tty_struct *tty, struct file *file,
+			       unsigned int set, unsigned int clear)
+{ 
+	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
+
+	ASSERT(self != NULL, return -1;);
+	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
+
+	if (set & TIOCM_RTS)
+		self->settings.dte |= IRCOMM_RTS;
+	if (set & TIOCM_DTR)
+		self->settings.dte |= IRCOMM_DTR;
+
+	if (clear & TIOCM_RTS)
+		self->settings.dte &= ~IRCOMM_RTS;
+	if (clear & TIOCM_DTR)
+		self->settings.dte &= ~IRCOMM_DTR;
+
+	if ((set|clear) & TIOCM_RTS)
+		self->settings.dte |= IRCOMM_DELTA_RTS;
+	if ((set|clear) & TIOCM_DTR)
+		self->settings.dte |= IRCOMM_DELTA_DTR;
+
+	ircomm_param_request(self, IRCOMM_DTE, TRUE);
+	
+	return 0;
+}
 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("IrCOMM serial TTY driver");
===== ircomm/ircomm_tty_ioctl.c 1.6 vs edited =====
--- 1.6/net/irda/ircomm/ircomm_tty_ioctl.c	Tue Sep 24 00:34:20 2002
+++ edited/ircomm/ircomm_tty_ioctl.c	Tue Jan 13 11:34:03 2004
@@ -190,89 +190,6 @@
 }
 
 /*
- * Function ircomm_tty_get_modem_info (self, value)
- *
- *    
- *
- */
-static int ircomm_tty_get_modem_info(struct ircomm_tty_cb *self, 
-				     unsigned int *value)
-{
-	unsigned int result;
-
-	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
-
-	result =  ((self->settings.dte & IRCOMM_RTS) ? TIOCM_RTS : 0)
-		| ((self->settings.dte & IRCOMM_DTR) ? TIOCM_DTR : 0)
-		| ((self->settings.dce & IRCOMM_CD)  ? TIOCM_CAR : 0)
-		| ((self->settings.dce & IRCOMM_RI)  ? TIOCM_RNG : 0)
-		| ((self->settings.dce & IRCOMM_DSR) ? TIOCM_DSR : 0)
-		| ((self->settings.dce & IRCOMM_CTS) ? TIOCM_CTS : 0);
-
-	return put_user(result, value);
-}
-
-/*
- * Function set_modem_info (driver, cmd, value)
- *
- *    
- *
- */
-static int ircomm_tty_set_modem_info(struct ircomm_tty_cb *self, 
-				     unsigned int cmd, unsigned int *value)
-{ 
-	unsigned int arg;
-	__u8 old_rts, old_dtr;
-
-	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
-
-	ASSERT(self != NULL, return -1;);
-	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
-
-	if (get_user(arg, value))
-		return -EFAULT;
-
-	old_rts = self->settings.dte & IRCOMM_RTS;
-	old_dtr = self->settings.dte & IRCOMM_DTR;
-
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
-		self->settings.dte |= IRCOMM_DELTA_RTS;
-
-	if ((self->settings.dte & IRCOMM_DTR) != old_dtr)
-		self->settings.dte |= IRCOMM_DELTA_DTR;
-
-	ircomm_param_request(self, IRCOMM_DTE, TRUE);
-	
-	return 0;
-}
-
-/*
  * Function get_serial_info (driver, retinfo)
  *
  *    
@@ -406,14 +323,6 @@
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


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
