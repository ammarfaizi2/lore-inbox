Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136482AbREDSlI>; Fri, 4 May 2001 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136487AbREDSk6>; Fri, 4 May 2001 14:40:58 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:25206 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136482AbREDSkt>; Fri, 4 May 2001 14:40:49 -0400
Date: Fri, 4 May 2001 14:40:39 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Patch for ymfpci in 2.4.4
Message-ID: <20010504144039.A30563@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

Here are updates from ALSA. The interrupt acknowledge has a
potential bug report for it in RH bugzilla. Power-up fix I include
"just because", Alan bounced it to me from sound-hackers;
Also Jeff Garzik asked for it. I wanted to include it with
full PM support, but perhaps not.

-- Pete

--- linux-2.4.4/drivers/sound/ymfpci.c	Thu Apr 26 22:17:27 2001
+++ linux-2.4.4-niph/drivers/sound/ymfpci.c	Fri May  4 11:02:56 2001
@@ -989,11 +989,6 @@
 
 	status = ymfpci_readl(codec, YDSXGR_STATUS);
 	if (status & 0x80000000) {
-		spin_lock(&codec->reg_lock);
-		ymfpci_writel(codec, YDSXGR_STATUS, 0x80000000);
-		mode = ymfpci_readl(codec, YDSXGR_MODE) | 2;
-		ymfpci_writel(codec, YDSXGR_MODE, mode);
-		spin_unlock(&codec->reg_lock);
 		codec->active_bank = ymfpci_readl(codec, YDSXGR_CTRLSELECT) & 1;
 		spin_lock(&codec->voice_lock);
 		for (nvoice = 0; nvoice < 64; nvoice++) {
@@ -1007,6 +1002,11 @@
 				ymf_cap_interrupt(codec, cap);
 		}
 		spin_unlock(&codec->voice_lock);
+		spin_lock(&codec->reg_lock);
+		ymfpci_writel(codec, YDSXGR_STATUS, 0x80000000);
+		mode = ymfpci_readl(codec, YDSXGR_MODE) | 2;
+		ymfpci_writel(codec, YDSXGR_MODE, mode);
+		spin_unlock(&codec->reg_lock);
 	}
 
 	status = ymfpci_readl(codec, YDSXGR_INTFLAG);
@@ -2106,6 +2106,8 @@
 		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd | 0x03);
 		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
 	}
+	pci_write_config_word(pci, PCIR_DSXPWRCTRL1, 0);
+	pci_write_config_word(pci, PCIR_DSXPWRCTRL2, 0);
 }
 
 static void ymfpci_enable_dsp(ymfpci_t *codec)
