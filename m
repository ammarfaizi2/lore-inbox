Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbULIB4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbULIB4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbULIByU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:54:20 -0500
Received: from palrel12.hp.com ([156.153.255.237]:35532 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261435AbULIBxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:53:12 -0500
Date: Wed, 8 Dec 2004 17:53:05 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Use kill_urb() in irda-usb
Message-ID: <20041209015305.GD2298@bougret.hpl.hp.com>
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

ir260_irda-usb-kill-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
Updates for irda-usb.
        * change comment about Sigmatel now that there is a driver
        * convert to new module_param
        * places where urb is unlinked synchronously, use usb_kill_urb
          because that is now a runtime warning.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -u -p linux/drivers/net/irda/irda-usb.d2.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.d2.c	Wed Dec  8 17:13:29 2004
+++ linux/drivers/net/irda/irda-usb.c	Wed Dec  8 17:20:20 2004
@@ -52,7 +52,7 @@
 /*------------------------------------------------------------------*/
 
 #include <linux/module.h>
-
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -88,10 +88,10 @@ static struct usb_device_id dongles[] = 
 
 /*
  * Important note :
- * Devices based on the SigmaTel chipset (0x66f, 0x4200) are not compliant
- * with the USB-IrDA specification (and actually very very different), and
- * there is no way this driver can support those devices, apart from
- * a complete rewrite...
+ * Devices based on the SigmaTel chipset (0x66f, 0x4200) are not designed
+ * using the "USB-IrDA specification" (yes, there exist such a thing), and
+ * therefore not supported by this driver (don't add them above).
+ * There is a Linux driver, stir4200, that support those USB devices.
  * Jean II
  */
 
@@ -1007,9 +1007,9 @@ static int irda_usb_net_close(struct net
 	}
 	/* Cancel Tx and speed URB - need to be synchronous to avoid races */
 	self->tx_urb->transfer_flags &= ~URB_ASYNC_UNLINK;
-	usb_unlink_urb(self->tx_urb);
+	usb_kill_urb(self->tx_urb);
 	self->speed_urb->transfer_flags &= ~URB_ASYNC_UNLINK;
-	usb_unlink_urb(self->speed_urb);
+	usb_kill_urb(self->speed_urb);
 
 	/* Stop and remove instance of IrLAP */
 	if (self->irlap)
@@ -1520,9 +1520,9 @@ static void irda_usb_disconnect(struct u
 		/* Cancel Tx and speed URB.
 		 * Toggle flags to make sure it's synchronous. */
 		self->tx_urb->transfer_flags &= ~URB_ASYNC_UNLINK;
-		usb_unlink_urb(self->tx_urb);
+		usb_kill_urb(self->tx_urb);
 		self->speed_urb->transfer_flags &= ~URB_ASYNC_UNLINK;
-		usb_unlink_urb(self->speed_urb);
+		usb_kill_urb(self->speed_urb);
 	}
 
 	/* Cleanup the device stuff */
@@ -1593,7 +1593,7 @@ module_exit(usb_irda_cleanup);
 /*
  * Module parameters
  */
-MODULE_PARM(qos_mtt_bits, "i");
+module_param(qos_mtt_bits, int, 0);
 MODULE_PARM_DESC(qos_mtt_bits, "Minimum Turn Time");
 MODULE_AUTHOR("Roman Weissgaerber <weissg@vienna.at>, Dag Brattli <dag@brattli.net> and Jean Tourrilhes <jt@hpl.hp.com>");
 MODULE_DESCRIPTION("IrDA-USB Dongle Driver"); 
