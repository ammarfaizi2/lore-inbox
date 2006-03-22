Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWCVWMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWCVWMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWCVWMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:12:14 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:38314 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S932089AbWCVWMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:12:13 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH  1/12] PNP: adjust pnp_register_card_driver() signature
Date: Wed, 22 Mar 2006 15:12:06 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Thorsten Knabe <linux@thorsten-knabe.de>, Uwe Bugla <uwe.bugla@gmx.de>,
       Takashi Iwai <tiwai@suse.de>
References: <200603221455.26230.bjorn.helgaas@hp.com>
In-Reply-To: <200603221455.26230.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221512.06536.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_card_driver() returns the
number of devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm5/sound/isa/ad1816a/ad1816a.c
===================================================================
--- work-mm5.orig/sound/isa/ad1816a/ad1816a.c	2006-03-22 09:57:34.000000000 -0700
+++ work-mm5/sound/isa/ad1816a/ad1816a.c	2006-03-22 10:10:34.000000000 -0700
@@ -262,6 +262,8 @@
 	return 0;
 }
 
+static unsigned int __devinitdata ad1816a_devices;
+
 static int __devinit snd_ad1816a_pnp_detect(struct pnp_card_link *card,
 					    const struct pnp_card_device_id *id)
 {
@@ -275,6 +277,7 @@
 		if (res < 0)
 			return res;
 		dev++;
+		ad1816a_devices++;
 		return 0;
 	}
         return -ENODEV;
@@ -297,10 +300,13 @@
 
 static int __init alsa_card_ad1816a_init(void)
 {
-	int cards;
+	int err;
+
+	err = pnp_register_card_driver(&ad1816a_pnpc_driver);
+	if (err)
+		return err;
 
-	cards = pnp_register_card_driver(&ad1816a_pnpc_driver);
-	if (cards <= 0) {
+	if (!ad1816a_devices) {
 		pnp_unregister_card_driver(&ad1816a_pnpc_driver);
 #ifdef MODULE
 		printk(KERN_ERR "no AD1816A based soundcards found.\n");
