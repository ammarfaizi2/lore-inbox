Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbUDSIEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUDSIEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:04:48 -0400
Received: from b099166.adsl.hansenet.de ([62.109.99.166]:9109 "EHLO
	aj.andaco.de") by vger.kernel.org with ESMTP id S263945AbUDSIEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:04:42 -0400
Date: Mon, 19 Apr 2004 10:04:39 +0200
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
Message-ID: <20040419080439.GB11586@andaco.de>
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040418180811.0b2e2567.davem@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Andreas Jochens <aj@andaco.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Apr-18 18:08, David S. Miller wrote:
> However, that in no way means that Jeff and myself have to split
> the firmware out of the driver either.  In fact, I do not want to
> as I like keeping all of the network drivers I write in single
> foo.c and foo.h files.

Would the patch be acceptable if the firmware parts were kept in tg3.c
as they are now but #ifdef'd out when CONFIG_TIGON3_FIRMWARE is not set?

At least this would make it clear that the driver is usable even without 
the firmware. Or is there perhaps any technical problem which might 
occur when firmware loading is optionally disabled as indicated below?

Thank you for your attention.

Andreas Jochens

diff -urN linux-2.6.5.orig/drivers/net/Kconfig linux-2.6.5/drivers/net/Kconfig
--- linux-2.6.5.orig/drivers/net/Kconfig	2004-04-03 21:38:10.000000000 -0600
+++ linux-2.6.5/drivers/net/Kconfig	2004-04-19 01:16:17.726738720 -0500
@@ -2060,6 +2060,14 @@
 	  To compile this driver as a module, choose M here: the module
 	  will be called tg3.  This is recommended.
 
+config TIGON3_FIRMWARE
+	bool "Include firmware (for TSO support and for 5701_a0)" 
+	depends on TIGON3
+	default y
+	help
+	  This includes binary-only firmware for TSO support and a 
+          binary-only firmware fix for the 5701_a0 chipset. If unsure, say Y.
+
 endmenu
 
 #
diff -urN linux-2.6.5.orig/drivers/net/tg3.c linux-2.6.5/drivers/net/tg3.c
--- linux-2.6.5.orig/drivers/net/tg3.c	2004-04-03 21:37:23.000000000 -0600
+++ linux-2.6.5/drivers/net/tg3.c	2004-04-19 01:24:48.284122200 -0500
@@ -46,6 +46,10 @@
 #define TG3_VLAN_TAG_USED 0
 #endif
 
+#ifndef CONFIG_TIGON3_FIRMWARE
+#undef NETIF_F_TSO
+#endif
+
 #ifdef NETIF_F_TSO
 #define TG3_TSO_SUPPORT	1
 #else
@@ -3541,6 +3545,8 @@
 	return 0;
 }
 
+#ifdef CONFIG_TIGON3_FIRMWARE
+
 #define TG3_FW_RELEASE_MAJOR	0x0
 #define TG3_FW_RELASE_MINOR	0x0
 #define TG3_FW_RELEASE_FIX	0x0
@@ -4411,6 +4417,8 @@
 
 #endif /* TG3_TSO_SUPPORT != 0 */
 
+#endif /* CONFIG_TIGON3_FIRMWARE */
+
 /* tp->lock is held. */
 static void __tg3_set_mac_addr(struct tg3 *tp)
 {
@@ -4947,9 +4955,17 @@
 	tw32(SNDBDS_MODE, SNDBDS_MODE_ENABLE | SNDBDS_MODE_ATTN_ENABLE);
 
 	if (tp->pci_chip_rev_id == CHIPREV_ID_5701_A0) {
+#ifdef CONFIG_TIGON3_FIRMWARE
 		err = tg3_load_5701_a0_firmware_fix(tp);
 		if (err)
 			return err;
+#else
+		printk(KERN_ERR PFX "%s: tg3_reset_hardware - "
+			"5701_a0 firmware fix not loaded\n",
+			tp->dev->name );
+		return -ENODEV;
+#endif
+
 	}
 
 #if TG3_TSO_SUPPORT != 0
