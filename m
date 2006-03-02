Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCBXJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCBXJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCBXJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:09:35 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:38325 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751188AbWCBXJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:29 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 3/9] cs4236: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:27 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.27528.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/sound/isa/cs423x/cs4236.c
===================================================================
--- work-mm4.orig/sound/isa/cs423x/cs4236.c	2006-02-22 09:55:41.000000000 -0700
+++ work-mm4/sound/isa/cs423x/cs4236.c	2006-02-22 10:05:14.000000000 -0700
@@ -133,6 +133,7 @@
 static int pnp_registered;
 #endif
 #endif /* CONFIG_PNP */
+static unsigned int snd_cs423x_devices;
 
 struct snd_card_cs4236 {
 	struct snd_cs4231 *chip;
@@ -564,7 +565,7 @@
 		snd_card_free(card);
 		return err;
 	}
-	
+
 	platform_set_drvdata(pdev, card);
 	return 0;
 }
@@ -650,6 +651,7 @@
 	}
 	pnp_set_drvdata(pdev, card);
 	dev++;
+	snd_cs423x_devices++;
 	return 0;
 }
 
@@ -713,6 +715,7 @@
 	}
 	pnp_set_card_drvdata(pcard, card);
 	dev++;
+	snd_cs423x_devices++;
 	return 0;
 }
 
@@ -721,7 +724,7 @@
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
 }
-                        
+
 #ifdef CONFIG_PM
 static int snd_cs423x_pnpc_suspend(struct pnp_card_link *pcard, pm_message_t state)
 {
@@ -766,7 +769,7 @@
 
 static int __init alsa_card_cs423x_init(void)
 {
-	int i, err, cards = 0;
+	int i, err;
 
 	if ((err = platform_driver_register(&cs423x_nonpnp_driver)) < 0)
 		return err;
@@ -782,24 +785,20 @@
 			goto errout;
 		}
 		platform_devices[i] = device;
-		cards++;
+		snd_cs423x_devices++;
 	}
 #ifdef CONFIG_PNP
 #ifdef CS4232
-	i = pnp_register_driver(&cs4232_pnp_driver);
-	if (i >= 0) {
+	err = pnp_register_driver(&cs4232_pnp_driver);
+	if (!err)
 		pnp_registered = 1;
-		cards += i;
-	}
 #endif
-	i = pnp_register_card_driver(&cs423x_pnpc_driver);
-	if (i >= 0) {
+	err = pnp_register_card_driver(&cs423x_pnpc_driver);
+	if (!err)
 		pnpc_registered = 1;
-		cards += i;
-	}
 #endif /* CONFIG_PNP */
 
-	if (!cards) {
+	if (!snd_cs423x_devices) {
 #ifdef MODULE
 		printk(KERN_ERR IDENT " soundcard not found or device busy\n");
 #endif
