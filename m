Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270271AbUJTBUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbUJTBUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269536AbUJTBPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:15:11 -0400
Received: from palrel11.hp.com ([156.153.255.246]:8366 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S270259AbUJTBIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:08:24 -0400
Date: Tue, 19 Oct 2004 18:08:19 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Stir driver suspend fix
Message-ID: <20041020010819.GK12932@bougret.hpl.hp.com>
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

irXXX_stir_suspend.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] stir4200: don't need suspend/resume if !CONFIG_PM
The suspend/resume code only needs to be compiled in if power management
is enabled.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>


diff -Nru a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
--- a/drivers/net/irda/stir4200.c	2004-10-08 14:01:57 -07:00
+++ b/drivers/net/irda/stir4200.c	2004-10-08 14:01:57 -07:00
@@ -761,8 +761,9 @@
 	       && netif_device_present(dev)
 	       && !signal_pending(current))
 	{
+#ifdef CONFIG_PM
 		/* if suspending, then power off and wait */
-		if (current->flags & PF_FREEZE) {
+		if (unlikely(current->flags & PF_FREEZE)) {
 			if (stir->receiving)
 				receive_stop(stir);
 			else
@@ -775,6 +776,7 @@
 			if (change_speed(stir, stir->speed))
 				break;
 		}
+#endif
 
 		/* if something to send? */
 		skb = xchg(&stir->tx_pending, NULL);
@@ -1125,7 +1127,7 @@
 	usb_set_intfdata(intf, NULL);
 }
 
-
+#ifdef CONFIG_PM
 /* Power management suspend, so power off the transmitter/receiver */
 static int stir_suspend(struct usb_interface *intf, u32 state)
 {
@@ -1145,6 +1147,7 @@
 	/* receiver restarted when send thread wakes up */
 	return 0;
 }
+#endif
 
 /*
  * USB device callbacks
@@ -1155,8 +1158,10 @@
 	.probe		= stir_probe,
 	.disconnect	= stir_disconnect,
 	.id_table	= dongles,
+#ifdef CONFIG_PM
 	.suspend	= stir_suspend,
 	.resume		= stir_resume,
+#endif
 };
 
 /*


