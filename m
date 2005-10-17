Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVJQHZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVJQHZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVJQHZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:25:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:63683 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932101AbVJQHZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:25:17 -0400
Subject: Re: Fw: Re: 2.6.14-rc4-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, WU Fengguang <wfg@mail.ustc.edu.cn>
In-Reply-To: <20051017001321.2358f341.akpm@osdl.org>
References: <20051017001321.2358f341.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 17:23:27 +1000
Message-Id: <1129533808.7620.70.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 00:13 -0700, Andrew Morton wrote:
> Wanna send fix please?
> 
> Begin forwarded message:
> 
> Date: Mon, 17 Oct 2005 15:07:15 +0800
> From: WU Fengguang <wfg@mail.ustc.edu.cn>
> To: Andrew Morton <akpm@osdl.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.14-rc4-mm1

Does that updated patch fixes it ?

Index: linux-work/drivers/video/Kconfig
===================================================================
--- linux-work.orig/drivers/video/Kconfig	2005-10-13 13:46:13.000000000 +1000
+++ linux-work/drivers/video/Kconfig	2005-10-17 17:20:51.000000000 +1000
@@ -662,7 +662,7 @@
 
 config FB_NVIDIA_I2C
        bool "Enable DDC Support"
-       depends on FB_NVIDIA && !PPC_OF
+       depends on FB_NVIDIA
        help
 	  This enables I2C support for nVidia Chipsets.  This is used
 	  only for getting EDID information from the attached display
Index: linux-work/drivers/video/nvidia/nv_of.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nv_of.c	2005-10-13 13:46:13.000000000 +1000
+++ linux-work/drivers/video/nvidia/nv_of.c	2005-10-17 17:23:15.000000000 +1000
@@ -27,34 +27,60 @@
 #include "nv_local.h"
 #include "nv_proto.h"
 
-void nvidia_create_i2c_busses(struct nvidia_par *par) {}
-void nvidia_delete_i2c_busses(struct nvidia_par *par) {}
+#include "../edid.h"
 
-int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
+int nvidia_probe_of_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
 	struct nvidia_par *par = info->par;
-	struct device_node *dp;
+	struct device_node *parent, *dp;
 	unsigned char *pedid = NULL;
-	unsigned char *disptype = NULL;
 	static char *propnames[] = {
-		"DFP,EDID", "LCD,EDID", "EDID", "EDID1", "EDID,B", "EDID,A", NULL };
+		"DFP,EDID", "LCD,EDID", "EDID", "EDID1",
+		"EDID,B", "EDID,A", NULL };
 	int i;
 
-	dp = pci_device_to_OF_node(par->pci_dev);
-	for (; dp != NULL; dp = dp->child) {
-		disptype = (unsigned char *)get_property(dp, "display-type", NULL);
-		if (disptype == NULL)
-			continue;
-		if (strncmp(disptype, "LCD", 3) != 0)
-			continue;
+	parent = pci_device_to_OF_node(par->pci_dev);
+	if (parent == NULL)
+		return -1;
+	if (par->twoHeads) {
+		char *pname;
+		int len;
+
+		for (dp = NULL;
+		     (dp = of_get_next_child(parent, dp)) != NULL;) {
+			pname = (char *)get_property(dp, "name", NULL);
+			if (!pname)
+				continue;
+			len = strlen(pname);
+			if ((pname[len-1] == 'A' && conn == 1) ||
+			    (pname[len-1] == 'B' && conn == 2)) {
+				for (i = 0; propnames[i] != NULL; ++i) {
+					pedid = (unsigned char *)
+						get_property(dp, propnames[i],
+							     NULL);
+					if (pedid != NULL)
+						break;
+				}
+				of_node_put(dp);
+				break;
+			}
+		}
+	}
+	if (pedid == NULL) {
 		for (i = 0; propnames[i] != NULL; ++i) {
 			pedid = (unsigned char *)
-				get_property(dp, propnames[i], NULL);
-			if (pedid != NULL) {
-				*out_edid = pedid;
-				return 0;
-			}
+				get_property(parent, propnames[i], NULL);
+			if (pedid != NULL)
+				break;
 		}
 	}
-	return 1;
+	if (pedid) {
+		*out_edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+		if (*out_edid == NULL)
+			return -1;
+		memcpy(*out_edid, pedid, EDID_LENGTH);
+		printk(KERN_DEBUG "nvidiafb: Found OF EDID for head %d\n", conn);
+		return 0;
+	}
+	return -1;
 }
Index: linux-work/drivers/video/nvidia/nv_proto.h
===================================================================
--- linux-work.orig/drivers/video/nvidia/nv_proto.h	2005-10-13 13:46:13.000000000 +1000
+++ linux-work/drivers/video/nvidia/nv_proto.h	2005-10-17 17:22:28.000000000 +1000
@@ -31,7 +31,7 @@
 void NVLockUnlock(struct nvidia_par *par, int);
 
 /* in nvidia-i2c.c */
-#if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
+#ifdef CONFIG_FB_NVIDIA_I2C
 void nvidia_create_i2c_busses(struct nvidia_par *par);
 void nvidia_delete_i2c_busses(struct nvidia_par *par);
 int nvidia_probe_i2c_connector(struct fb_info *info, int conn,
@@ -39,10 +39,14 @@
 #else
 #define nvidia_create_i2c_busses(...)
 #define nvidia_delete_i2c_busses(...)
-#define nvidia_probe_i2c_connector(p, c, edid) \
-do {                                           \
-	*(edid) = NULL;                        \
-} while(0)
+#define nvidia_probe_i2c_connector(p, c, edid) (-1)
+#endif
+
+#ifdef CONFIG_FB_OF
+int nvidia_probe_of_connector(struct fb_info *info, int conn,
+			      u8 ** out_edid);
+#else
+#define nvidia_probe_of_connector(p, c, edid)  (-1)
 #endif
 
 /* in nv_accel.c */
Index: linux-work/drivers/video/nvidia/nv_setup.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nv_setup.c	2005-10-13 13:46:13.000000000 +1000
+++ linux-work/drivers/video/nvidia/nv_setup.c	2005-10-17 17:20:51.000000000 +1000
@@ -190,9 +190,9 @@
 	present = (NV_RD32(PRAMDAC, 0x0608) & (1 << 28)) ? 1 : 0;
 
 	if (present)
-		printk("nvidiafb: CRTC%i found\n", output);
+		printk("nvidiafb: CRTC%i analog found\n", output);
 	else
-		printk("nvidiafb: CRTC%i not found\n", output);
+		printk("nvidiafb: CRTC%i analog not found\n", output);
 
 	NV_WR32(par->PRAMDAC0, 0x0608, NV_RD32(par->PRAMDAC0, 0x0608) &
 		0x0000EFFF);
@@ -305,6 +305,9 @@
 	int FlatPanel = -1;	/* really means the CRTC is slaved */
 	int Television = 0;
 
+	memset(&monitorA, 0, sizeof(struct fb_monspecs));
+	memset(&monitorB, 0, sizeof(struct fb_monspecs));
+
 	par->PRAMIN = par->REGS + (0x00710000 / 4);
 	par->PCRTC0 = par->REGS + (0x00600000 / 4);
 	par->PRAMDAC0 = par->REGS + (0x00680000 / 4);
@@ -401,7 +404,8 @@
 	nvidia_create_i2c_busses(par);
 	if (!par->twoHeads) {
 		par->CRTCnumber = 0;
-		nvidia_probe_i2c_connector(info, 1, &edidA);
+		if (nvidia_probe_i2c_connector(info, 1, &edidA))
+			nvidia_probe_of_connector(info, 1, &edidA);
 		if (edidA && !fb_parse_edid(edidA, &var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
 			monA = &monitorA;
@@ -488,14 +492,16 @@
 		oldhead = NV_RD32(par->PCRTC0, 0x00000860);
 		NV_WR32(par->PCRTC0, 0x00000860, oldhead | 0x00000010);
 
-		nvidia_probe_i2c_connector(info, 1, &edidA);
+		if (nvidia_probe_i2c_connector(info, 1, &edidA))
+			nvidia_probe_of_connector(info, 1, &edidA);
 		if (edidA && !fb_parse_edid(edidA, &var)) {
 			printk("nvidiafb: EDID found from BUS1\n");
 			monA = &monitorA;
 			fb_edid_to_monspecs(edidA, monA);
 		}
 
-		nvidia_probe_i2c_connector(info, 2, &edidB);
+		if (nvidia_probe_i2c_connector(info, 2, &edidB))
+			nvidia_probe_of_connector(info, 2, &edidB);
 		if (edidB && !fb_parse_edid(edidB, &var)) {
 			printk("nvidiafb: EDID found from BUS2\n");
 			monB = &monitorB;
Index: linux-work/drivers/video/nvidia/nvidia.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nvidia.c	2005-10-13 13:46:13.000000000 +1000
+++ linux-work/drivers/video/nvidia/nvidia.c	2005-10-17 17:20:51.000000000 +1000
@@ -619,41 +619,85 @@
 	NVTRACE_LEAVE();
 }
 
+#undef DUMP_REG
+
 static void nvidia_write_regs(struct nvidia_par *par)
 {
 	struct _riva_hw_state *state = &par->ModeReg;
 	int i;
 
 	NVTRACE_ENTER();
-	NVWriteCrtc(par, 0x11, 0x00);
-
-	NVLockUnlock(par, 0);
 
 	NVLoadStateExt(par, state);
 
 	NVWriteMiscOut(par, state->misc_output);
 
+	for (i = 1; i < NUM_SEQ_REGS; i++) {
+#ifdef DUMP_REG
+		printk(" SEQ[%02x] = %08x\n", i, state->seq[i]);
+#endif
+		NVWriteSeq(par, i, state->seq[i]);
+	}
+
+	/* Ensure CRTC registers 0-7 are unlocked by clearing bit 7 of CRTC[17] */
+	NVWriteCrtc(par, 0x11, state->crtc[0x11] & ~0x80);
+
 	for (i = 0; i < NUM_CRT_REGS; i++) {
 		switch (i) {
 		case 0x19:
 		case 0x20 ... 0x40:
 			break;
 		default:
+#ifdef DUMP_REG
+			printk("CRTC[%02x] = %08x\n", i, state->crtc[i]);
+#endif
 			NVWriteCrtc(par, i, state->crtc[i]);
 		}
 	}
 
-	for (i = 0; i < NUM_ATC_REGS; i++)
-		NVWriteAttr(par, i, state->attr[i]);
-
-	for (i = 0; i < NUM_GRC_REGS; i++)
+	for (i = 0; i < NUM_GRC_REGS; i++) {
+#ifdef DUMP_REG
+		printk(" GRA[%02x] = %08x\n", i, state->gra[i]);
+#endif
 		NVWriteGr(par, i, state->gra[i]);
+	}
+
+	for (i = 0; i < NUM_ATC_REGS; i++) {
+#ifdef DUMP_REG
+		printk("ATTR[%02x] = %08x\n", i, state->attr[i]);
+#endif
+		NVWriteAttr(par, i, state->attr[i]);
+	}
 
-	for (i = 0; i < NUM_SEQ_REGS; i++)
-		NVWriteSeq(par, i, state->seq[i]);
 	NVTRACE_LEAVE();
 }
 
+static void nvidia_vga_protect(struct nvidia_par *par, int on)
+{
+	unsigned char tmp;
+
+	if (on) {
+		/*
+		 * Turn off screen and disable sequencer.
+		 */
+		tmp = NVReadSeq(par, 0x01);
+
+		NVWriteSeq(par, 0x00, 0x01);		/* Synchronous Reset */
+		NVWriteSeq(par, 0x01, tmp | 0x20);	/* disable the display */
+	} else {
+		/*
+		 * Reenable sequencer, then turn on screen.
+		 */
+
+		tmp = NVReadSeq(par, 0x01);
+
+		NVWriteSeq(par, 0x01, tmp & ~0x20);	/* reenable display */
+		NVWriteSeq(par, 0x00, 0x03);		/* End Reset */
+	}
+}
+
+
+
 static int nvidia_calc_regs(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
@@ -860,7 +904,7 @@
 	for (i = 0; i < 0x10; i++)
 		state->attr[i] = i;
 	state->attr[0x10] = 0x41;
-	state->attr[0x11] = 0x01;
+	state->attr[0x11] = 0xff;
 	state->attr[0x12] = 0x0f;
 	state->attr[0x13] = 0x00;
 	state->attr[0x14] = 0x00;
@@ -983,7 +1027,6 @@
 
 	nvidia_init_vga(info);
 	nvidia_calc_regs(info);
-	nvidia_write_regs(par);
 
 	NVLockUnlock(par, 0);
 	if (par->twoHeads) {
@@ -992,7 +1035,22 @@
 		NVLockUnlock(par, 0);
 	}
 
-	NVWriteCrtc(par, 0x11, 0x00);
+	nvidia_vga_protect(par, 1);
+
+	nvidia_write_regs(par);
+
+#if defined (__BIG_ENDIAN)
+	/* turn on LFB swapping */
+	{
+		unsigned char tmp;
+
+		VGA_WR08(par->PCIO, 0x3d4, 0x46);
+		tmp = VGA_RD08(par->PCIO, 0x3d5);
+		tmp |= (1 << 7);
+		VGA_WR08(par->PCIO, 0x3d5, tmp);
+    }
+#endif
+
 	info->fix.line_length = (info->var.xres_virtual *
 				 info->var.bits_per_pixel) >> 3;
 	if (info->var.accel_flags) {
@@ -1014,7 +1072,7 @@
 
 	par->cursor_reset = 1;
 
-	NVWriteCrtc(par, 0x11, 0xff);
+	nvidia_vga_protect(par, 0);
 
 	NVTRACE_LEAVE();
 	return 0;


