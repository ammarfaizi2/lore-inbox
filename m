Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753201AbWKFOVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbWKFOVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbWKFOVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:21:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753201AbWKFOVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:21:45 -0500
Date: Mon, 6 Nov 2006 15:21:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Larry.Finger@lwfinger.net, st3@riseup.net
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] bcm43xx_sprom_write(): add error checks
Message-ID: <20061106142146.GN5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that these "if (err)"'s couldn't ever be 
true.

It seems the intention was to check the return values of the 
bcm43xx_pci_write_config32()'s?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/bcm43xx/bcm43xx_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c.old	2006-11-06 14:45:47.000000000 +0100
+++ linux-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-11-06 14:46:53.000000000 +0100
@@ -737,47 +737,47 @@ int bcm43xx_sprom_write(struct bcm43xx_p
 	crc = bcm43xx_sprom_crc(sprom);
 	expected_crc = (sprom[BCM43xx_SPROM_VERSION] & 0xFF00) >> 8;
 	if (crc != expected_crc) {
 		printk(KERN_ERR PFX "SPROM input data: Invalid CRC\n");
 		return -EINVAL;
 	}
 
 	printk(KERN_INFO PFX "Writing SPROM. Do NOT turn off the power! Please stand by...\n");
 	err = bcm43xx_pci_read_config32(bcm, BCM43xx_PCICFG_SPROMCTL, &spromctl);
 	if (err)
 		goto err_ctlreg;
 	spromctl |= 0x10; /* SPROM WRITE enable. */
-	bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
+	err = bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
 	if (err)
 		goto err_ctlreg;
 	/* We must burn lots of CPU cycles here, but that does not
 	 * really matter as one does not write the SPROM every other minute...
 	 */
 	printk(KERN_INFO PFX "[ 0%%");
 	mdelay(500);
 	for (i = 0; i < BCM43xx_SPROM_SIZE; i++) {
 		if (i == 16)
 			printk("25%%");
 		else if (i == 32)
 			printk("50%%");
 		else if (i == 48)
 			printk("75%%");
 		else if (i % 2)
 			printk(".");
 		bcm43xx_write16(bcm, BCM43xx_SPROM_BASE + (i * 2), sprom[i]);
 		mmiowb();
 		mdelay(20);
 	}
 	spromctl &= ~0x10; /* SPROM WRITE enable. */
-	bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
+	err = bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
 	if (err)
 		goto err_ctlreg;
 	mdelay(500);
 	printk("100%% ]\n");
 	printk(KERN_INFO PFX "SPROM written.\n");
 	bcm43xx_controller_restart(bcm, "SPROM update");
 
 	return 0;
 err_ctlreg:
 	printk(KERN_ERR PFX "Could not access SPROM control register.\n");
 	return -ENODEV;
 }

