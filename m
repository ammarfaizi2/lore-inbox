Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVDVEJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVDVEJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 00:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDVEJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 00:09:53 -0400
Received: from mail03.powweb.com ([66.152.97.36]:28164 "EHLO mail03.powweb.com")
	by vger.kernel.org with ESMTP id S261942AbVDVEJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 00:09:38 -0400
From: Richard Drummond <evilrich@rcdrummond.net>
Organization: Private
To: linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] Clean-up and bug fix for tdfxfb framebuffer size detection
Date: Thu, 21 Apr 2005 23:09:12 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200504212309.12407.evilrich@rcdrummond.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ojHaCRt0WEIEsxf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ojHaCRt0WEIEsxf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against 2.6.11.7 which tidies up the tdfxfb framebuffer 
size detection code a little and fixes the broken support for Voodoo4/5 cards. 
(I haven't tested this on a Voodoo5, however, because I don't have the 
hardware).

Signed-off-by: Richard Drummond <evilrich@rcdrummond.net>

--Boundary-00=_ojHaCRt0WEIEsxf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tdfxfb_mem_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="tdfxfb_mem_fix.diff"

--- drivers/video/tdfxfb.c_orig	2005-04-20 15:04:23.000000000 -0500
+++ drivers/video/tdfxfb.c	2005-04-21 22:20:32.000000000 -0500
@@ -414,36 +414,35 @@
 
 static unsigned long do_lfb_size(struct tdfx_par *par, unsigned short dev_id) 
 {
-	u32 draminit0 = 0;
-	u32 draminit1 = 0;
-	u32 miscinit1 = 0;
-	u32 lfbsize   = 0;
-	int sgram_p   = 0;
+	u32 draminit0;
+	u32 draminit1;
+	u32 miscinit1;
+
+	int num_chips;
+	int chip_size; /* in MB */
+	u32 lfbsize;
+	int has_sgram;
 
 	draminit0 = tdfx_inl(par, DRAMINIT0);  
 	draminit1 = tdfx_inl(par, DRAMINIT1);
+   
+	num_chips = (draminit0 & DRAMINIT0_SGRAM_NUM) ? 8 : 4;        
  
-	if ((dev_id == PCI_DEVICE_ID_3DFX_BANSHEE) ||
-	    (dev_id == PCI_DEVICE_ID_3DFX_VOODOO3)) {             	 
-		sgram_p = (draminit1 & DRAMINIT1_MEM_SDRAM) ? 0 : 1;
-  
-	lfbsize = sgram_p ?
-		(((draminit0 & DRAMINIT0_SGRAM_NUM)  ? 2 : 1) * 
-		((draminit0 & DRAMINIT0_SGRAM_TYPE) ? 8 : 4) * 1024 * 1024) :
-		16 * 1024 * 1024;
+	if (dev_id < PCI_DEVICE_ID_3DFX_VOODOO5) {
+		/* Banshee/Voodoo3 */
+		has_sgram = draminit1 & DRAMINIT1_MEM_SDRAM;	   
+		chip_size = has_sgram ? ((draminit0 & DRAMINIT0_SGRAM_TYPE) ? 2 : 1)
+				      : 2;
 	} else {
 		/* Voodoo4/5 */
-		u32 chips, psize, banks;
+		has_sgram = 0;
+		chip_size = 1 << ((draminit0 & DRAMINIT0_SGRAM_TYPE_MASK) >> DRAMINIT0_SGRAM_TYPE_SHIFT);
+	}
+	lfbsize = num_chips * chip_size * 1024 * 1024;
 
-		chips = ((draminit0 & (1 << 26)) == 0) ? 4 : 8;
-		psize = 1 << ((draminit0 & 0x38000000) >> 28);
-		banks = ((draminit0 & (1 << 30)) == 0) ? 2 : 4;
-		lfbsize = chips * psize * banks;
-		lfbsize <<= 20;
-	}                 
-	/* disable block writes for SDRAM (why?) */
+	/* disable block writes for SDRAM */
 	miscinit1 = tdfx_inl(par, MISCINIT1);
-	miscinit1 |= sgram_p ? 0 : MISCINIT1_2DBLOCK_DIS;
+	miscinit1 |= has_sgram ? 0 : MISCINIT1_2DBLOCK_DIS;
 	miscinit1 |= MISCINIT1_CLUT_INV;
 
 	banshee_make_room(par, 1); 
--- include/video/tdfx.h_orig	2005-04-21 21:16:56.000000000 -0500
+++ include/video/tdfx.h	2005-04-21 09:39:42.000000000 -0500
@@ -99,6 +99,8 @@
 #define MISCINIT1_2DBLOCK_DIS           BIT(15)
 #define DRAMINIT0_SGRAM_NUM             BIT(26)
 #define DRAMINIT0_SGRAM_TYPE            BIT(27)
+#define DRAMINIT0_SGRAM_TYPE_MASK       (BIT(27)|BIT(28)|BIT(29))
+#define DRAMINIT0_SGRAM_TYPE_SHIFT      27
 #define DRAMINIT1_MEM_SDRAM             BIT(30)
 #define VGAINIT0_VGA_DISABLE            BIT(0)
 #define VGAINIT0_EXT_TIMING             BIT(1)

--Boundary-00=_ojHaCRt0WEIEsxf--
