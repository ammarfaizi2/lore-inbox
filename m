Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbREFFZd>; Sun, 6 May 2001 01:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbREFFZX>; Sun, 6 May 2001 01:25:23 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:26099 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132886AbREFFZN>; Sun, 6 May 2001 01:25:13 -0400
Date: Sun, 6 May 2001 01:25:08 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for ymfpci in 2.4.4
Message-ID: <20010506012508.A13865@devserv.devel.redhat.com>
In-Reply-To: <20010504144039.A30563@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504144039.A30563@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, May 04, 2001 at 02:40:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a pilot error, my ymfpci update would not compile
(forgot to submit .h change). Here is the missing part:

--- linux-2.4.4/drivers/sound/ymfpci.h	Fri Jan 26 23:31:16 2001
+++ linux-2.4.4-niph/drivers/sound/ymfpci.h	Fri May  4 11:07:17 2001
@@ -135,6 +135,8 @@
 #define PCIR_LEGCTRL			0x40
 #define PCIR_ELEGCTRL			0x42
 #define PCIR_DSXGCTRL			0x48
+#define PCIR_DSXPWRCTRL1		0x4a
+#define PCIR_DSXPWRCTRL2		0x4e
 #define PCIR_OPLADR			0x60
 #define PCIR_SBADR			0x62
 #define PCIR_MPUADR			0x64

Original part:

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

Sorry,
-- Pete
