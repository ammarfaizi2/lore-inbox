Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUDEErG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 00:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUDEErG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 00:47:06 -0400
Received: from mail.inter-page.com ([12.5.23.93]:11014 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261602AbUDEErC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 00:47:02 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] (linux 2.4.25) hangup on disconnect for usbserial module 
Date: Sun, 4 Apr 2004 21:46:52 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAt769YH9BUkiZQFHMD2kn9AEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is "reasonably well tested" on the x86 platform.


This patch fixes a problem where the usbserial code would not notify
connected programs that the serial port was going away.


--- linux-2.4.25-orig/drivers/usb/serial/usbserial.c 2003-11-28
10:26:20.000000000 -0800
+++ linux-2.4.25/drivers/usb/serial/usbserial.c 2004-04-04
21:26:34.000000000 -0700
@@ -14,6 +14,10 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this
driver
  *
+ * (04/04/2004) rwhite@casabyte.com
+ *      usb_serial_disconnect() now calls tty_hangup() so that programs
+ *      using the device can/will notice that the device is going away.
+ *
  * (10/10/2001) gkh
  *     usb_serial_disconnect() now sets the serial->dev pointer is to NULL
to
  *     help prevent child drivers from accessing the device since it is now
@@ -1404,9 +1408,11 @@ static void usb_serial_disconnect(struct
                for (i = 0; i < serial->num_ports; ++i) {
                        port = &serial->port[i];
                        down (&port->sem);
-                       if (port->tty != NULL)
+                       if (port->tty != NULL) {
+                               tty_hangup(port->tty);
                                while (port->open_count > 0)
                                        __serial_close(port, NULL);
+                       }
                        up (&port->sem);
                }



