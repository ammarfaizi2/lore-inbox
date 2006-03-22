Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWCVWQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWCVWQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWCVWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:16:22 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:37805 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932113AbWCVWNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:13:06 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 10/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:13:02 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, Paul Laufer <paul@laufernet.com>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221513.02330.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/oss/sb_card.c
===================================================================
--- work-mm6.orig/sound/oss/sb_card.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/oss/sb_card.c	2006-03-22 12:18:20.000000000 -0700
@@ -52,6 +52,7 @@
 static struct sb_card_config *legacy = NULL;
 
 #ifdef CONFIG_PNP
+static int pnp_registered;
 static int __initdata pnp       = 1;
 /*
 static int __initdata uart401	= 0;
@@ -133,7 +134,7 @@
 }
 
 /* Register legacy card with OSS subsystem */
-static int sb_init_legacy(void)
+static int __init sb_init_legacy(void)
 {
 	struct sb_module_options sbmo = {0};
 
@@ -234,6 +235,8 @@
 	}
 }
 
+static unsigned int sb_pnp_devices;
+
 /* Probe callback function for the PnP API */
 static int sb_pnp_probe(struct pnp_card_link *card, const struct pnp_card_device_id *card_id)
 {
@@ -264,6 +267,7 @@
 	       scc->conf.dma, scc->conf.dma2);
 
 	pnp_set_card_drvdata(card, scc);
+	sb_pnp_devices++;
 
 	return sb_register_oss(scc, &sbmo);
 }
@@ -289,6 +293,14 @@
 MODULE_DEVICE_TABLE(pnp_card, sb_pnp_card_table);
 #endif /* CONFIG_PNP */
 
+static void __init_or_module sb_unregister_all(void)
+{
+#ifdef CONFIG_PNP
+	if (pnp_registered)
+		pnp_unregister_card_driver(&sb_pnp_driver);
+#endif
+}
+
 static int __init sb_init(void)
 {
 	int lres = 0;
@@ -307,17 +319,18 @@
 
 #ifdef CONFIG_PNP
 	if(pnp) {
-		pres = pnp_register_card_driver(&sb_pnp_driver);
+		int err = pnp_register_card_driver(&sb_pnp_driver);
+		if (!err)
+			pnp_registered = 1;
+		pres = sb_pnp_devices;
 	}
 #endif
 	printk(KERN_INFO "sb: Init: Done\n");
 
 	/* If either PnP or Legacy registered a card then return
 	 * success */
-	if (pres <= 0 && lres <= 0) {
-#ifdef CONFIG_PNP
-		pnp_unregister_card_driver(&sb_pnp_driver);
-#endif
+	if (pres == 0 && lres <= 0) {
+		sb_unregister_all();
 		return -ENODEV;
 	}
 	return 0;
@@ -333,9 +346,7 @@
 		sb_unload(legacy);
 	}
 
-#ifdef CONFIG_PNP
-	pnp_unregister_card_driver(&sb_pnp_driver);
-#endif
+	sb_unregister_all();
 
 	vfree(smw_free);
 	smw_free = NULL;
