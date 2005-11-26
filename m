Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbVKZG0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbVKZG0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 01:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbVKZG0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 01:26:50 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:9343 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422644AbVKZG0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 01:26:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=L/d5MNstQ0TNUXcOEJEBnLrn4IuR/wrx7EWZrCqNu/xktEGvnyIvP6ubxyx6+ytFpnSvEVGW0T+Ksq7B/tjA4BwN8mVhdiM777hMhEIHpsD/30tR2LiOaG0wYTe8slpuS6dDtXtWYocdvECaocYX3UC0BqaPgjA1q/pOULoOvm0=
Message-ID: <4387FFFD.2000109@gmail.com>
Date: Sat, 26 Nov 2005 14:26:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: "Calin A. Culianu" <calin@ajvar.org>
CC: ajoshi@shell.unixbox.com, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org, linux-nvidia@lists.surfsouth.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] nvidiafb support for 6600 and 6200
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu>
In-Reply-To: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calin A. Culianu wrote:
> Hi,
> 
> This patch can be applied against 2.6.15-rc1 to add support to the
> nvidiafb driver for a few obscure (yet on-the-market) nvidia
> boards/chipsets, including various versions of the Geforce 6600 and 6200.
> 
> This patch has been tested and allows the above-mentioned boards to get
> framebuffer console support.
> 

Is this a pci-e card?  With a pci-e card, the actual chipset type is located
in one of the registers (instead of deriving it from the pci device id) and
will resolve into one of the supported architectures, usually an NV_ARCH_40.

Can you try this patch instead? And send me your dmesg whether it works or
not.

Thanks.

Tony

diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index b989358..7d51e3a 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -925,6 +925,7 @@ void NVCalcStateExt(struct nvidia_par *p
 
 void NVLoadStateExt(struct nvidia_par *par, RIVA_HW_STATE * state)
 {
+	u32 tmp;
 	int i;
 
 	NV_WR32(par->PMC, 0x0140, 0x00000000);
@@ -938,15 +939,25 @@ void NVLoadStateExt(struct nvidia_par *p
 
 	if (par->Architecture == NV_ARCH_04) {
 		NV_WR32(par->PFB, 0x0200, state->config);
-	} else if ((par->Chipset & 0xfff0) == 0x0090) {
-		for (i = 0; i < 15; i++) {
-			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
-			NV_WR32(par->PFB, 0x0604 + (i * 0x10), par->FbMapSize - 1);
-		}
-	} else {
+	} else if((par->Architecture < NV_ARCH_40) ||
+		  ((par->Chipset & 0xfff0) == 0x0040))  {
 		for (i = 0; i < 8; i++) {
 			NV_WR32(par->PFB, 0x0240 + (i * 0x10), 0);
-			NV_WR32(par->PFB, 0x0244 + (i * 0x10), par->FbMapSize - 1);
+			NV_WR32(par->PFB, 0x0244 + (i * 0x10),
+				par->FbMapSize - 1);
+		}
+	} else {
+		int regions = 12;
+
+		if(((par->Chipset & 0xfff0) == 0x0090) ||
+		   ((par->Chipset & 0xfff0) == 0x01D0) ||
+		   ((par->Chipset & 0xfff0) == 0x0290))
+			regions = 15;
+		
+		for(i = 0; i < regions; i++) {
+			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
+			NV_WR32(par->PFB, 0x0604 + (i * 0x10),
+				par->FbMapSize - 1);
 		}
 	}
 
@@ -1187,6 +1198,10 @@ void NVLoadStateExt(struct nvidia_par *p
 				NV_WR32(par->PGRAPH, 0x0090, 0x00008000);
 				NV_WR32(par->PGRAPH, 0x0610, 0x00be3c5f);
 
+				tmp = NV_RD32(par->REGS, 0x1540) & 0xff;
+				for(i = 0; tmp && !(tmp & 1); tmp >>= 1, i++);
+				NV_WR32(par->PGRAPH, 0x5000, i);
+    
 				if ((par->Chipset & 0xfff0) == 0x0040) {
 					NV_WR32(par->PGRAPH, 0x09b0,
 						0x83280fff);
@@ -1211,6 +1226,7 @@ void NVLoadStateExt(struct nvidia_par *p
 						0xffff7fff);
 					break;
 				case 0x00C0:
+				case 0x0120:
 					NV_WR32(par->PGRAPH, 0x0828,
 						0x007596ff);
 					NV_WR32(par->PGRAPH, 0x082C,
@@ -1245,6 +1261,7 @@ void NVLoadStateExt(struct nvidia_par *p
 						0x00100000);
 					break;
 				case 0x0090:
+				case 0x0290:
 					NV_WR32(par->PRAMDAC, 0x0608,
 						NV_RD32(par->PRAMDAC, 0x0608) |
 						0x00100000);
@@ -1310,14 +1327,42 @@ void NVLoadStateExt(struct nvidia_par *p
 				}
 			}
 
-			if ((par->Chipset & 0xfff0) == 0x0090) {
-				for (i = 0; i < 60; i++)
-					NV_WR32(par->PGRAPH, 0x0D00 + i,
-						NV_RD32(par->PFB, 0x0600 + i));
-			} else {
-				for (i = 0; i < 32; i++)
+			if ((par->Architecture < NV_ARCH_40) ||
+			    ((par->Chipset & 0xfff0) == 0x0040)) {
+				for(i = 0; i < 32; i++) {
 					NV_WR32(par->PGRAPH, 0x0900 + i,
 						NV_RD32(par->PFB, 0x0240 + i));
+					NV_WR32(par->PGRAPH, 0x6900 + i,
+						NV_RD32(par->PFB, 0x0240 + i));
+				}
+			} else {
+				if (((par->Chipset & 0xfff0) == 0x0090) ||
+				    ((par->Chipset & 0xfff0) == 0x01D0) ||
+				    ((par->Chipset & 0xfff0) == 0x0290)) {
+					for(i = 0; i < 60; i++) {
+						NV_WR32(par->PGRAPH, 0x0D00+i,
+							NV_RD32(par->PFB, 
+								0x0600 + i));
+						NV_WR32(par->PGRAPH, 0x6900+i,
+							NV_RD32(par->PFB, 
+								0x0600 + i));
+					}
+				} else {
+					for(i = 0; i < 48; i++) {
+						NV_WR32(par->PGRAPH, 0x0900+i,
+							NV_RD32(par->PFB,
+								0x0600 + i));
+						if (((par->Chipset & 0xfff0) !=
+						     0x0160) &&
+						    ((par->Chipset & 0xfff0) !=
+						     0x0220)) {
+							NV_WR32(par->PGRAPH,
+							0x6900 + i,
+							NV_RD32(par->PFB,
+								0x0600 + i));
+						}
+					}
+				}
 			}
 
 			if (par->Architecture >= NV_ARCH_40) {
@@ -1338,11 +1383,15 @@ void NVLoadStateExt(struct nvidia_par *p
 					NV_WR32(par->PGRAPH, 0x0868,
 						par->FbMapSize - 1);
 				} else {
-					if((par->Chipset & 0xfff0) == 0x0090) {
+					if (((par->Chipset & 0xfff0)==0x0090)||
+					    ((par->Chipset & 0xfff0)==0x01D0)||
+					    ((par->Chipset & 0xfff0)==0x0290)){
 						NV_WR32(par->PGRAPH, 0x0DF0,
-							NV_RD32(par->PFB, 0x0200));
+							NV_RD32(par->PFB,
+								0x0200));
 						NV_WR32(par->PGRAPH, 0x0DF4,
-							NV_RD32(par->PFB, 0x0204));
+							NV_RD32(par->PFB,
+								0x0204));
 					} else {
 						NV_WR32(par->PGRAPH, 0x09F0,
 							NV_RD32(par->PFB, 0x0200));
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index 1f06a9f..1330021 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -277,6 +277,9 @@ static void nv10GetConfig(struct nvidia_
 		    (NV_RD32(par->PFB, 0x020C) & 0xFFF00000) >> 10;
 	}
 
+	if (par->RamAmountKBytes > 256*1024)
+		par->RamAmountKBytes = 256*1024;
+
 	par->CrystalFreqKHz = (NV_RD32(par->PEXTDEV, 0x0000) & (1 << 6)) ?
 	    14318 : 13500;
 
@@ -285,7 +288,6 @@ static void nv10GetConfig(struct nvidia_
 			par->CrystalFreqKHz = 27000;
 	}
 
-	par->CursorStart = (par->RamAmountKBytes - 96) * 1024;
 	par->CURSOR = NULL;	/* can't set this here */
 	par->MinVClockFreqKHz = 12000;
 	par->MaxVClockFreqKHz = par->twoStagePLL ? 400000 : 350000;
@@ -382,6 +384,8 @@ void NVCommonSetup(struct fb_info *info)
 	case 0x0146:
 	case 0x0147:
 	case 0x0148:
+        case 0x0098:
+	case 0x0099:
 		mobile = 1;
 		break;
 	default:
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 961007d..2d9152d 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1448,11 +1448,34 @@ static int __devinit nvidia_set_fbinfo(s
 	return nvidiafb_check_var(&info->var, info);
 }
 
-static u32 __devinit nvidia_get_arch(struct pci_dev *pd)
+static u32 __devinit nvidia_get_chipset(struct fb_info *info)
 {
+	struct nvidia_par *par = info->par;
+	u32 id = (par->pci_dev->vendor << 16) | par->pci_dev->device;
+
+	printk("nvidiafb: PCI id - %x\n", id);
+	if ((id & 0xfff0) == 0x00f0) {
+		/* pci-e */
+		printk("nvidiafb: PCI-E card\n");
+		id = NV_RD32(par->REGS, 0x1800);
+
+		if ((id & 0x0000ffff) == 0x000010DE) 
+			id = 0x10DE0000 | (id >> 16);
+		else if ((id & 0xffff0000) == 0xDE100000) /* wrong endian */
+			id = 0x10DE0000 | ((id << 8) & 0x0000ff00) |
+                            ((id >> 8) & 0x000000ff);
+	}
+
+	printk("nvidiafb: Actual id - %x\n", id);
+	return id;
+}
+
+static u32 __devinit nvidia_get_arch(struct fb_info *info)
+{
+	struct nvidia_par *par = info->par;
 	u32 arch = 0;
 
-	switch (pd->device & 0x0ff0) {
+	switch (par->Chipset & 0x0ff0) {
 	case 0x0100:		/* GeForce 256 */
 	case 0x0110:		/* GeForce2 MX */
 	case 0x0150:		/* GeForce2 */
@@ -1485,6 +1508,8 @@ static u32 __devinit nvidia_get_arch(str
 	case 0x0210:
 	case 0x0220:
 	case 0x0230:
+        case 0x0290:
+        case 0x0390:
 		arch = NV_ARCH_40;
 		break;
 	case 0x0020:		/* TNT, TNT2 */
@@ -1533,9 +1558,6 @@ static int __devinit nvidiafb_probe(stru
 		goto err_out_request;
 	}
 
-	par->Architecture = nvidia_get_arch(pd);
-
-	par->Chipset = (pd->vendor << 16) | pd->device;
 	printk(KERN_INFO PFX "nVidia device/chipset %X\n", par->Chipset);
 
 	if (par->Architecture == 0) {
@@ -1570,6 +1592,8 @@ static int __devinit nvidiafb_probe(stru
 		goto err_out_free_base0;
 	}
 
+	par->Chipset = nvidia_get_chipset(info);
+	par->Architecture = nvidia_get_arch(info);
 	NVCommonSetup(info);
 
 	par->FbAddress = nvidiafb_fix.smem_start;
@@ -1581,10 +1605,15 @@ static int __devinit nvidiafb_probe(stru
 	if (par->FbMapSize > 64 * 1024 * 1024)
 		par->FbMapSize = 64 * 1024 * 1024;
 
-	par->FbUsableSize = par->FbMapSize - (128 * 1024);
+	if(par->Architecture >= NV_ARCH_40)
+		par->FbUsableSize = par->FbMapSize - (560 * 1024);
+	else
+		par->FbUsableSize = par->FbMapSize - (128 * 1024);
+
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
 	    16 * 1024;
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
+	par->CursorStart = par->FbUsableSize + (32 * 1024);
 	info->screen_base = ioremap(nvidiafb_fix.smem_start, par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
