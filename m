Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWCVWN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWCVWN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWCVWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:13:11 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:57004 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932101AbWCVWMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:52 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  7/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:47 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, Massimo Piccioni <dafastidio@libero.it>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.47642.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.  And fix some __init/__devinit issues.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm6/sound/isa/sb/es968.c
===================================================================
--- work-mm6.orig/sound/isa/sb/es968.c	2006-03-22 11:24:41.000000000 -0700
+++ work-mm6/sound/isa/sb/es968.c	2006-03-22 12:09:31.000000000 -0700
@@ -124,7 +124,7 @@
 	return 0;
 }
 
-static int __init snd_card_es968_probe(int dev,
+static int __devinit snd_card_es968_probe(int dev,
 					struct pnp_card_link *pcard,
 					const struct pnp_card_device_id *pid)
 {
@@ -182,6 +182,8 @@
 	return 0;
 }
 
+static unsigned int __devinitdata es968_devices;
+
 static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
                                           const struct pnp_card_device_id *id)
 {
@@ -195,6 +197,7 @@
 		if (res < 0)
 			return res;
 		dev++;
+		es968_devices++;
 		return 0;
 	}
 	return -ENODEV;
@@ -246,8 +249,11 @@
 
 static int __init alsa_card_es968_init(void)
 {
-	int cards = pnp_register_card_driver(&es968_pnpc_driver);
-	if (cards <= 0) {
+	int err = pnp_register_card_driver(&es968_pnpc_driver);
+	if (err)
+		return err;
+
+	if (!es968_devices) {
 		pnp_unregister_card_driver(&es968_pnpc_driver);
 #ifdef MODULE
 		snd_printk(KERN_ERR "no ES968 based soundcards found\n");
