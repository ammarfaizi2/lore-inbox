Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265047AbUEUXCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265047AbUEUXCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUEUW7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:59:55 -0400
Received: from havoc.gtf.org ([216.162.42.101]:11233 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264550AbUEUWyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:54:35 -0400
Date: Fri, 21 May 2004 18:54:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] 2.6.x i810 audio driver update
Message-ID: <20040521225430.GA15222@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/i810-audio-2.6

This will update the following files:

 include/linux/pci_ids.h |    6 +++
 sound/oss/i810_audio.c  |   96 ++++++++++++++++--------------------------------
 2 files changed, 39 insertions(+), 63 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (04/05/15 1.1612.1.117)
   [sound/oss i810] pci id cleanups
   
   The driver defined its own PCI id constants.  Kill the majority,
   which were redundant, and move the rest to include/linux/pci_ids.h.
   
   Also, move open-coded tests for "new ICH" audio chips to a single
   helper function.  These tests were being patched with each new
   ICH motherboard from Intel, resulting in each new PCI id being added
   to several places in the driver.
   
   Note that, even though this should be a harmless patch, there
   exists the remote possibility that I mis-matched some of the
   PCI ids, as I only tested ICH5.

diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-05-21 16:55:59 -04:00
+++ b/include/linux/pci_ids.h	2004-05-21 16:55:59 -04:00
@@ -481,6 +481,7 @@
 #	define PCI_DEVICE_ID_AMD_VIPER_7441	PCI_DEVICE_ID_AMD_OPUS_7441
 #define PCI_DEVICE_ID_AMD_OPUS_7443	0x7443
 #	define PCI_DEVICE_ID_AMD_VIPER_7443	PCI_DEVICE_ID_AMD_OPUS_7443
+#define PCI_DEVICE_ID_AMD_OPUS_7445	0x7445
 #define PCI_DEVICE_ID_AMD_OPUS_7448	0x7448
 # define	PCI_DEVICE_ID_AMD_VIPER_7448	PCI_DEVICE_ID_AMD_OPUS_7448
 #define PCI_DEVICE_ID_AMD_OPUS_7449	0x7449
@@ -637,6 +638,7 @@
 #define PCI_DEVICE_ID_SI_6306		0x6306
 #define PCI_DEVICE_ID_SI_6326		0x6326
 #define PCI_DEVICE_ID_SI_7001		0x7001
+#define PCI_DEVICE_ID_SI_7012		0x7012
 #define PCI_DEVICE_ID_SI_7016		0x7016
 
 #define PCI_VENDOR_ID_HP		0x103c
@@ -1056,10 +1058,12 @@
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
+#define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO		0x006a
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
+#define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO		0x00da
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S  		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
@@ -1089,6 +1093,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL	0x017C
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE		0x01a4
+#define PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO		0x01b1
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2		0x01e0
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
@@ -2134,6 +2139,7 @@
 #define PCI_DEVICE_ID_INTEL_82443BX_0	0x7190
 #define PCI_DEVICE_ID_INTEL_82443BX_1	0x7191
 #define PCI_DEVICE_ID_INTEL_82443BX_2	0x7192
+#define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #define PCI_DEVICE_ID_INTEL_82443MX_0	0x7198
 #define PCI_DEVICE_ID_INTEL_82443MX_1	0x7199
 #define PCI_DEVICE_ID_INTEL_82443MX_2	0x719a
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	2004-05-21 16:55:59 -04:00
+++ b/sound/oss/i810_audio.c	2004-05-21 16:55:59 -04:00
@@ -103,53 +103,7 @@
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 
-#define DRIVER_VERSION "1.00"
-
-#ifndef PCI_DEVICE_ID_INTEL_82801
-#define PCI_DEVICE_ID_INTEL_82801	0x2415
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_82901
-#define PCI_DEVICE_ID_INTEL_82901	0x2425
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH2
-#define PCI_DEVICE_ID_INTEL_ICH2	0x2445
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH3
-#define PCI_DEVICE_ID_INTEL_ICH3	0x2485
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH4
-#define PCI_DEVICE_ID_INTEL_ICH4	0x24c5
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH5
-#define PCI_DEVICE_ID_INTEL_ICH5	0x24d5
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_ICH6_18
-#define PCI_DEVICE_ID_INTEL_ICH6_18	0x266e
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_440MX
-#define PCI_DEVICE_ID_INTEL_440MX	0x7195
-#endif
-#ifndef PCI_DEVICE_ID_INTEL_ESB_5
-#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
-#endif
-#ifndef PCI_DEVICE_ID_SI_7012
-#define PCI_DEVICE_ID_SI_7012		0x7012
-#endif
-#ifndef PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO
-#define PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO	0x01b1
-#endif
-#ifndef PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO
-#define PCI_DEVICE_ID_NVIDIA_MCP2_AUDIO	0x006a
-#endif
-#ifndef PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO
-#define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO	0x00da
-#endif
-#ifndef PCI_DEVICE_ID_AMD_768_AUDIO
-#define PCI_DEVICE_ID_AMD_768_AUDIO	0x7445
-#endif
-#ifndef PCI_DEVICE_ID_AMD_8111_AC97
-#define PCI_DEVICE_ID_AMD_8111_AC97	0x746d
-#endif
+#define DRIVER_VERSION "1.01"
 
 #define MODULOP2(a, b) ((a) & ((b) - 1))
 #define MASKP2(a, b) ((a) & ~((b) - 1))
@@ -328,19 +282,19 @@
 };
 
 static struct pci_device_id i810_pci_tbl [] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ICH82801AA},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82901,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, ICH82901AB},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_440MX,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTEL440MX},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH2,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_4,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH2},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH3,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH4,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH5,
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH5},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
@@ -350,9 +304,9 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, NVIDIA_NFORCE},
-	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_768_AUDIO,
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7445,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768},
-	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_AC97,
+	{PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_AUDIO,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_5,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
@@ -1956,8 +1910,8 @@
 		}
 
 		/* ICH and ICH0 only support 2 channels */
-		if ( state->card->pci_id == PCI_DEVICE_ID_INTEL_82801 
-		     || state->card->pci_id == PCI_DEVICE_ID_INTEL_82901) 
+		if ( state->card->pci_id == PCI_DEVICE_ID_INTEL_82801AA_5
+		     || state->card->pci_id == PCI_DEVICE_ID_INTEL_82801AB_5) 
 			return put_user(2, (int *)arg);
 	
 		/* Multi-channel support was added with ICH2. Bits in */
@@ -2772,6 +2726,26 @@
 	return i;
 }
 
+static int is_new_ich(u16 pci_id)
+{
+	switch (pci_id) {
+	case PCI_DEVICE_ID_INTEL_82801DB_5:
+	case PCI_DEVICE_ID_INTEL_82801EB_5:
+	case PCI_DEVICE_ID_INTEL_ESB_5:
+	case PCI_DEVICE_ID_INTEL_ICH6_18:
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static inline int ich_use_mmio(struct i810_card *card)
+{
+	return is_new_ich(card->pci_id) && card->use_mmio;
+}
+
 /**
  *	i810_ac97_power_up_bus	-	bring up AC97 link
  *	@card : ICH audio device to power up
@@ -2821,9 +2795,7 @@
 	 */	
 	/* see i810_ac97_init for the next 7 lines (jsaw) */
 	inw(card->ac97base);
-	if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH5 ||
-	     card->pci_id == PCI_DEVICE_ID_INTEL_ESB_5 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH6_18)
-	    && (card->use_mmio)) {
+	if (ich_use_mmio(card)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
 		       primary_codec_id);
@@ -2892,9 +2864,7 @@
 		   possible IO channels. Bit 0:1 of SDM then holds the 
 		   last codec ID spoken to. 
 		*/
-		if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH5 ||
-		     card->pci_id == PCI_DEVICE_ID_INTEL_ESB_5 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH6_18)
-		    && (card->use_mmio)) {
+		if (ich_use_mmio(card)) {
 			ac97_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",
 			       num_ac97, ac97_id);
