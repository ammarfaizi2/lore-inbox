Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTDXXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTDXXfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25577 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264492AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280533913@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280533526@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.18, 2003/04/23 17:49:06-07:00, greg@kroah.com

[PATCH] USB: whiteheat: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/whiteheat.c |   92 ++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 54 deletions(-)


diff -Nru a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
--- a/drivers/usb/serial/whiteheat.c	Thu Apr 24 16:20:13 2003
+++ b/drivers/usb/serial/whiteheat.c	Thu Apr 24 16:20:13 2003
@@ -146,6 +146,8 @@
 static int  whiteheat_write_room	(struct usb_serial_port *port);
 static int  whiteheat_ioctl		(struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg);
 static void whiteheat_set_termios	(struct usb_serial_port *port, struct termios * old);
+static int  whiteheat_tiocmget		(struct usb_serial_port *port, struct file *file);
+static int  whiteheat_tiocmset		(struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear);
 static void whiteheat_break_ctl		(struct usb_serial_port *port, int break_state);
 static int  whiteheat_chars_in_buffer	(struct usb_serial_port *port);
 static void whiteheat_throttle		(struct usb_serial_port *port);
@@ -184,6 +186,8 @@
 	.ioctl =		whiteheat_ioctl,
 	.set_termios =		whiteheat_set_termios,
 	.break_ctl =		whiteheat_break_ctl,
+	.tiocmget =		whiteheat_tiocmget,
+	.tiocmset =		whiteheat_tiocmset,
 	.chars_in_buffer =	whiteheat_chars_in_buffer,
 	.throttle =		whiteheat_throttle,
 	.unthrottle =		whiteheat_unthrottle,
@@ -767,73 +771,53 @@
 }
 
 
-static int whiteheat_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+static int whiteheat_tiocmget (struct usb_serial_port *port, struct file *file)
 {
 	struct whiteheat_private *info = usb_get_serial_port_data(port);
 	unsigned int modem_signals = 0;
-	struct serial_struct serstruct;
-
-	dbg("%s - port %d, cmd 0x%.4x", __FUNCTION__, port->number, cmd);
 
-	switch (cmd) {
-		case TIOCMGET:
-			firm_get_dtr_rts(port);
-			if (info->mcr & UART_MCR_DTR)
-				modem_signals |= TIOCM_DTR;
-			if (info->mcr & UART_MCR_RTS)
-				modem_signals |= TIOCM_RTS;
-			
-			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)))
-				return -EFAULT;
-
-			break;
-
-		case TIOCMSET:
-			if (copy_from_user(&modem_signals, (unsigned int *)arg, sizeof(unsigned int)))
-				return -EFAULT;
-
-			if (modem_signals & TIOCM_DTR)
-				info->mcr |= UART_MCR_DTR;
-			else
-				info->mcr &= ~UART_MCR_DTR;
-			if (modem_signals & TIOCM_RTS)
-				info->mcr |= UART_MCR_RTS;
-			else
-				info->mcr &= ~UART_MCR_RTS;
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
-			firm_set_dtr(port, info->mcr & UART_MCR_DTR);
-			firm_set_rts(port, info->mcr & UART_MCR_RTS);
+	firm_get_dtr_rts(port);
+	if (info->mcr & UART_MCR_DTR)
+		modem_signals |= TIOCM_DTR;
+	if (info->mcr & UART_MCR_RTS)
+		modem_signals |= TIOCM_RTS;
 
-			break;
+	return modem_signals;
+}
 
-		case TIOCMBIS:
-			if (copy_from_user(&modem_signals, (unsigned int *)arg, sizeof(unsigned int)))
-				return -EFAULT;
 
-			if (modem_signals & TIOCM_DTR)
-				info->mcr |= UART_MCR_DTR;
-			if (modem_signals & TIOCM_RTS)
-				info->mcr |= UART_MCR_RTS;
+static int whiteheat_tiocmset (struct usb_serial_port *port, struct file *file,
+			       unsigned int set, unsigned int clear)
+{
+	struct whiteheat_private *info = usb_get_serial_port_data(port);
 
-			firm_set_dtr(port, info->mcr & UART_MCR_DTR);
-			firm_set_rts(port, info->mcr & UART_MCR_RTS);
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
-			break;
+	if (set & TIOCM_RTS)
+		info->mcr |= UART_MCR_RTS;
+	if (set & TIOCM_DTR)
+		info->mcr |= UART_MCR_DTR;
+
+	if (clear & TIOCM_RTS)
+		info->mcr &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR)
+		info->mcr &= ~UART_MCR_DTR;
 
-		case TIOCMBIC:
-			if (copy_from_user(&modem_signals, (unsigned int *)arg, sizeof(unsigned int)))
-				return -EFAULT;
+	firm_set_dtr(port, info->mcr & UART_MCR_DTR);
+	firm_set_rts(port, info->mcr & UART_MCR_RTS);
+	return 0;
+}
 
-			if (modem_signals & TIOCM_DTR)
-				info->mcr &= ~UART_MCR_DTR;
-			if (modem_signals & TIOCM_RTS)
-				info->mcr &= ~UART_MCR_RTS;
 
-			firm_set_dtr(port, info->mcr & UART_MCR_DTR);
-			firm_set_rts(port, info->mcr & UART_MCR_RTS);
+static int whiteheat_ioctl (struct usb_serial_port *port, struct file * file, unsigned int cmd, unsigned long arg)
+{
+	struct serial_struct serstruct;
 
-			break;
+	dbg("%s - port %d, cmd 0x%.4x", __FUNCTION__, port->number, cmd);
 
+	switch (cmd) {
 		case TIOCGSERIAL:
 			memset(&serstruct, 0, sizeof(serstruct));
 			serstruct.type = PORT_16654;
@@ -864,10 +848,10 @@
 			break;
 
 		default:
-			return -ENOIOCTLCMD;
+			break;
 	}
 
-	return 0;
+	return -ENOIOCTLCMD;
 }
 
 

