Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWDDS4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDDS4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDDS4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:56:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750717AbWDDS4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:56:23 -0400
Date: Tue, 4 Apr 2006 20:56:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin Langer <martin-langer@gmx.de>, Stefano Brivio <st3@riseup.net>,
       Michael Buesch <mbuesch@freenet.de>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Andreas Jaggi <andreas.jaggi@waterwave.ch>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
Subject: [2.6 patch] bcm43xx_phy.c: fix a memory leak
Message-ID: <20060404185622.GX6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/bcm43xx/bcm43xx_phy.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17-rc1-mm1-full/drivers/net/wireless/bcm43xx/bcm43xx_phy.c.old	2006-04-04 19:43:04.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/net/wireless/bcm43xx/bcm43xx_phy.c	2006-04-04 19:43:38.000000000 +0200
@@ -2143,22 +2143,23 @@ int bcm43xx_phy_init_tssi2dbm_table(stru
 		dyn_tssi2dbm = kmalloc(64, GFP_KERNEL);
 		if (dyn_tssi2dbm == NULL) {
 			printk(KERN_ERR PFX "Could not allocate memory"
 					    "for tssi2dbm table\n");
 			return -ENOMEM;
 		}
 		for (idx = 0; idx < 64; idx++)
 			if (bcm43xx_tssi2dbm_entry(dyn_tssi2dbm, idx, pab0, pab1, pab2)) {
 				phy->tssi2dbm = NULL;
 				printk(KERN_ERR PFX "Could not generate "
 						    "tssi2dBm table\n");
+				kfree(dyn_tssi2dbm);
 				return -ENODEV;
 			}
 		phy->tssi2dbm = dyn_tssi2dbm;
 		phy->dyn_tssi_tbl = 1;
 	} else {
 		/* pabX values not set in SPROM. */
 		switch (phy->type) {
 		case BCM43xx_PHYTYPE_A:
 			/* APHY needs a generated table. */
 			phy->tssi2dbm = NULL;
 			printk(KERN_ERR PFX "Could not generate tssi2dBm "

