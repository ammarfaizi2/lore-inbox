Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWCVWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWCVWMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWCVWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:12:36 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:31125 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932098AbWCVWM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:28 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  3/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:21 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.21428.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/sound/isa/azt2320.c
===================================================================
--- work-mm5.orig/sound/isa/azt2320.c	2006-03-22 10:40:46.000000000 -0700
+++ work-mm5/sound/isa/azt2320.c	2006-03-22 10:41:03.000000000 -0700
@@ -310,6 +310,8 @@
 	return 0;
 }
 
+static unsigned int __devinitdata azt2320_devices;
+
 static int __devinit snd_azt2320_pnp_detect(struct pnp_card_link *card,
 					    const struct pnp_card_device_id *id)
 {
@@ -323,6 +325,7 @@
 		if (res < 0)
 			return res;
 		dev++;
+		azt2320_devices++;
 		return 0;
 	}
         return -ENODEV;
@@ -372,10 +375,13 @@
 
 static int __init alsa_card_azt2320_init(void)
 {
-	int cards;
+	int err;
+
+	err = pnp_register_card_driver(&azt2320_pnpc_driver);
+	if (err)
+		return err;
 
-	cards = pnp_register_card_driver(&azt2320_pnpc_driver);
-	if (cards <= 0) {
+	if (!azt2320_devices) {
 		pnp_unregister_card_driver(&azt2320_pnpc_driver);
 #ifdef MODULE
 		snd_printk(KERN_ERR "no AZT2320 based soundcards found\n");
