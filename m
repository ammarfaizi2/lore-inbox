Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTDXXlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTDXXg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:36:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35458 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264488AbTDXXeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280521833@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <1051228052721@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.9, 2003/04/23 17:35:42-07:00, greg@kroah.com

[PATCH] USB: usb-serial core: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/usb-serial.c |   47 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.h |    2 +
 2 files changed, 49 insertions(+)


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Thu Apr 24 16:24:17 2003
+++ b/drivers/usb/serial/usb-serial.c	Thu Apr 24 16:24:17 2003
@@ -785,6 +785,51 @@
 	return ((count < begin+length-off) ? count : begin+length-off);
 }
 
+static int serial_tiocmget (struct tty_struct *tty, struct file *file)
+{
+	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
+	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+
+	if (!serial)
+		goto exit;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	if (!port->open_count) {
+		dbg("%s - port not open", __FUNCTION__);
+		goto exit;
+	}
+
+	if (serial->type->tiocmget)
+		return serial->type->tiocmget(port, file);
+
+exit:
+	return -EINVAL;
+}
+
+static int serial_tiocmset (struct tty_struct *tty, struct file *file,
+			    unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
+	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+
+	if (!serial)
+		goto exit;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	if (!port->open_count) {
+		dbg("%s - port not open", __FUNCTION__);
+		goto exit;
+	}
+
+	if (serial->type->tiocmset)
+		return serial->type->tiocmset(port, file, set, clear);
+
+exit:
+	return -EINVAL;
+}
+
 void usb_serial_port_softint(void *private)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *)private;
@@ -1286,6 +1331,8 @@
 	.break_ctl =		serial_break,
 	.chars_in_buffer =	serial_chars_in_buffer,
 	.read_proc =		serial_read_proc,
+	.tiocmget =		serial_tiocmget,
+	.tiocmset =		serial_tiocmset,
 };
 
 
diff -Nru a/drivers/usb/serial/usb-serial.h b/drivers/usb/serial/usb-serial.h
--- a/drivers/usb/serial/usb-serial.h	Thu Apr 24 16:24:17 2003
+++ b/drivers/usb/serial/usb-serial.h	Thu Apr 24 16:24:17 2003
@@ -251,6 +251,8 @@
 	int  (*chars_in_buffer)	(struct usb_serial_port *port);
 	void (*throttle)	(struct usb_serial_port *port);
 	void (*unthrottle)	(struct usb_serial_port *port);
+	int  (*tiocmget)	(struct usb_serial_port *port, struct file *file);
+	int  (*tiocmset)	(struct usb_serial_port *port, struct file *file, unsigned int set, unsigned int clear);
 
 	void (*read_int_callback)(struct urb *urb, struct pt_regs *regs);
 	void (*read_bulk_callback)(struct urb *urb, struct pt_regs *regs);

