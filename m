Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUIMWqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUIMWqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIMWqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:46:20 -0400
Received: from itapoa.terra.com.br ([200.154.55.227]:38021 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP id S269020AbUIMWj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:39:28 -0400
Date: Mon, 13 Sep 2004 18:43:39 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] - missing check in usb/serial/usb-serial.c.
Message-Id: <20040913184339.7afb744c.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Greg,

 This patch add a missing check in the call to bus_register() and
not initialise `result' (which is not necessary).


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)


diff -X /home/capitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-08-26 12:31:41.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-12 18:12:30.000000000 -0300
@@ -1229,7 +1229,7 @@ struct tty_driver *usb_serial_tty_driver
 static int __init usb_serial_init(void)
 {
 	int i;
-	int result = 0;
+	int result;
 
 	usb_serial_tty_driver = alloc_tty_driver(SERIAL_TTY_MINORS);
 	if (!usb_serial_tty_driver)
@@ -1240,13 +1240,17 @@ static int __init usb_serial_init(void)
 		serial_table[i] = NULL;
 	}
 
-	bus_register(&usb_serial_bus_type);
+	result = bus_register(&usb_serial_bus_type);
+	if (result) {
+		err("%s - registering bus driver failed", __FUNCTION__);
+		goto exit_bus;
+	}
 
 	/* register the generic driver, if we should */
 	result = usb_serial_generic_register(debug);
 	if (result < 0) {
 		err("%s - registering generic driver failed", __FUNCTION__);
-		goto exit;
+		goto exit_generic;
 	}
 
 	usb_serial_tty_driver->owner = THIS_MODULE;
@@ -1264,7 +1268,7 @@ static int __init usb_serial_init(void)
 	result = tty_register_driver(usb_serial_tty_driver);
 	if (result) {
 		err("%s - tty_register_driver failed", __FUNCTION__);
-		goto exit_generic;
+		goto exit_reg_driver;
 	}
 
 	/* register the USB driver */
@@ -1281,10 +1285,13 @@ static int __init usb_serial_init(void)
 exit_tty:
 	tty_unregister_driver(usb_serial_tty_driver);
 
-exit_generic:
+exit_reg_driver:
 	usb_serial_generic_deregister();
 
-exit:
+exit_generic:
+	bus_unregister(&usb_serial_bus_type);
+
+exit_bus:
 	err ("%s - returning with error %d", __FUNCTION__, result);
 	put_tty_driver(usb_serial_tty_driver);
 	return result;
