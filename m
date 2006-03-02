Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWCBXJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWCBXJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCBXJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:09:38 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:23471 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751195AbWCBXJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:34 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 4/9] opl3sa2: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:32 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-sound@vger.kernel.org
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.32770.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/sound/isa/opl3sa2.c
===================================================================
--- work-mm4.orig/sound/isa/opl3sa2.c	2006-02-01 16:24:54.000000000 -0700
+++ work-mm4/sound/isa/opl3sa2.c	2006-02-15 10:11:17.000000000 -0700
@@ -95,6 +95,7 @@
 static int pnp_registered;
 static int pnpc_registered;
 #endif
+static unsigned int snd_opl3sa2_devices;
 
 /* control ports */
 #define OPL3SA2_PM_CTRL		0x01
@@ -760,6 +761,7 @@
 	}
 	pnp_set_drvdata(pdev, card);
 	dev++;
+	snd_opl3sa2_devices++;
 	return 0;
 }
 
@@ -826,6 +828,7 @@
 	}
 	pnp_set_card_drvdata(pcard, card);
 	dev++;
+	snd_opl3sa2_devices++;
 	return 0;
 }
 
@@ -944,7 +947,7 @@
 
 static int __init alsa_card_opl3sa2_init(void)
 {
-	int i, err, cards = 0;
+	int i, err;
 
 	if ((err = platform_driver_register(&snd_opl3sa2_nonpnp_driver)) < 0)
 		return err;
@@ -962,23 +965,19 @@
 			goto errout;
 		}
 		platform_devices[i] = device;
-		cards++;
+		snd_opl3sa2_devices++;
 	}
 
 #ifdef CONFIG_PNP
 	err = pnp_register_driver(&opl3sa2_pnp_driver);
-	if (err >= 0) {
+	if (!err)
 		pnp_registered = 1;
-		cards += err;
-	}
 	err = pnp_register_card_driver(&opl3sa2_pnpc_driver);
-	if (err >= 0) {
+	if (!err)
 		pnpc_registered = 1;
-		cards += err;
-	}
 #endif
 
-	if (!cards) {
+	if (!snd_opl3sa2_devices) {
 #ifdef MODULE
 		snd_printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
