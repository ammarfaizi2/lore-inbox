Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVAHGki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVAHGki (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVAHGjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:39:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:23686 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261935AbVAHFsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:50 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632643519@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <11051632644078@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.11, 2004/12/15 16:01:23-08:00, eolson@MIT.EDU

[PATCH] usb-serial: add tty_hangup on disconnect

When a USB serial device is disconnected, user applications performing a
read() now receive an error code, rather than waiting indefinitely. The
included patch is originally from Al Borchers, massaged to apply to
2.6.9 and 2.6.10-rc2. I've tested it on 2.6.9, but not on 2.6.10-rc2.

Al Borcher's original post:
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg27475.html

Signed-off-by: Edwin Olson (eolson@mit.edu)
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/usb-serial.c |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2005-01-07 15:50:08 -08:00
+++ b/drivers/usb/serial/usb-serial.c	2005-01-07 15:50:08 -08:00
@@ -1238,13 +1238,20 @@
 
 void usb_serial_disconnect(struct usb_interface *interface)
 {
+	int i;
 	struct usb_serial *serial = usb_get_intfdata (interface);
 	struct device *dev = &interface->dev;
+	struct usb_serial_port *port;
 
 	dbg ("%s", __FUNCTION__);
 
 	usb_set_intfdata (interface, NULL);
 	if (serial) {
+		for (i = 0; i < serial->num_ports; ++i) {
+			port = serial->port[i];
+			if (port && port->tty)
+				tty_hangup(port->tty);
+		}
 		/* let the last holder of this object 
 		 * cause it to be cleaned up */
 		kref_put(&serial->kref, destroy_serial);

