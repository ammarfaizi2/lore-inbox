Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRFOCcN>; Thu, 14 Jun 2001 22:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbRFOCcD>; Thu, 14 Jun 2001 22:32:03 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:38919 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S261969AbRFOCbx>; Thu, 14 Jun 2001 22:31:53 -0400
Date: Thu, 14 Jun 2001 20:31:49 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Sound on Nautilus Alpha (UP1000, UP1100)
Message-ID: <20010614203149.A12949@mail.harddata.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Somehow a code which does Nautilus specific magic to a Trident card
was forgotten for cases when a "generic" Alpha kernel is in use.
After a transfer of these few lines from 2.2.19 my sound card started
to play again.  Nautilus specific kernel should work but this is
not always in use.

Header comments in trident.c indicate that "#define DRIVER_VERSION"
was simply forgotten so I updated that as well.

This patch was done with 2.4.5-ac13 but it should fit all trident.c
from 2.4 kernels possibly with some small line offsets.  Alan, will
you push that to Linus?

   Michal

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trident.patch"

--- linux-2.4.5ac/drivers/sound/trident.c.orig	Tue Jun 12 16:31:13 2001
+++ linux-2.4.5ac/drivers/sound/trident.c	Thu Jun 14 18:33:34 2001
@@ -136,11 +136,15 @@
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
 
+#if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
+#include <asm/hwrpb.h>
+#endif
+
 #include "trident.h"
 
 #include <linux/pm.h>
 
-#define DRIVER_VERSION "0.14.6"
+#define DRIVER_VERSION "0.14.7a"
 
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -3607,10 +3611,17 @@
 
 	if (card->pci_id == PCI_DEVICE_ID_ALI_5451) {
 		/* edited by HMSEO for GT sound */
-#ifdef CONFIG_ALPHA_NAUTILUS
+#if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
 		u16 ac97_data;
-		ac97_data = ali_ac97_get (card->ac97_codec[0], AC97_POWER_CONTROL);
-		ali_ac97_set (card->ac97_codec[0], AC97_POWER_CONTROL, ac97_data | ALI_EAPD_POWER_DOWN);
+		extern struct hwrpb_struct *hwrpb;
+		
+		if ((hwrpb->sys_type) == 201) {
+			printk(KERN_INFO "trident: Running on Alpha system type Nautilus\n");
+			ac97_data = ali_ac97_get (card->ac97_codec[0],
+						  AC97_POWER_CONTROL);
+			ali_ac97_set (card->ac97_codec[0], AC97_POWER_CONTROL,
+				      ac97_data | ALI_EAPD_POWER_DOWN);
+		}
 #endif
 		/* edited by HMSEO for GT sound*/
 	}

--jI8keyz6grp/JLjh--
