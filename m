Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSANIqW>; Mon, 14 Jan 2002 03:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSANIqN>; Mon, 14 Jan 2002 03:46:13 -0500
Received: from [203.117.131.12] ([203.117.131.12]:34713 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S288058AbSANIqH>; Mon, 14 Jan 2002 03:46:07 -0500
Message-ID: <3C429AC6.4080209@metaparadigm.com>
Date: Mon, 14 Jan 2002 16:45:58 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020105
MIME-Version: 1.0
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] radeonfb: probe BIOS scratch registers for flat panel info
Content-Type: multipart/mixed;
 boundary="------------040408060807090203010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408060807090203010806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ani,

I tried the latest 2.4.18-pre1 radeonfb driver with the posted compile
fixes (*) on my Radeon LY(M6) based laptop with Samsumg Flat Panel and
it still doesn't correctly detect my flat panel.

So I had a look at the code and noticed EDID DFP detection is only used
on PPC through open firmware info and DFP info is not probed on other archs.

I rememeber having the same problem with XFree 4.1.99 radeon code a couple
months back but a fix was added to get the DFP info from the BIOS scratch
registers. Here's a patch that adds probing of BIOS scratch registers (if
available) for DFP info - same logic as in radeon XFree driver.

The patch applies on top of 2.4.18-pre2 with the radeon compile fix
referenced here:

   (*) http://marc.theaimsgroup.com/?l=linux-kernel&m=101046020806692&w=2

radeonfb now correctly comes up on my laptop in 1400x1050 mode.

radeonfb: ref_clk=2700, ref_div=60, xclk=16600 from BIOS
radeonfb: Failed to detect DFP panel size using EDID
radeonfb: panel ID string: Samsung LTN150P1-L02
radeonfb: detected DFP panel size from BIOS: 1400x1050
Console: switching to colour frame buffer device 175x65
radeonfb: ATI Radeon M6 LY  DDR SGRAM 16 MB
radeonfb: DVI port DFP monitor connected
radeonfb: CRT port no monitor connected

The only remaining problem I have is when switching from X back to the
console I loose my cursor. Other virtual consoles seem to have cursors of
varying colors - any ideas?

~mc

--------------040408060807090203010806
Content-Type: text/plain;
 name="radeon-bios-dfpinfo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon-bios-dfpinfo.patch"

--- linux-2.4.18-pre2-radeonfix-orig/drivers/video/radeonfb.c	Mon Jan 14 11:53:49 2002
+++ linux-2.4.18-pre2-radeonfix/drivers/video/radeonfb.c	Mon Jan 14 14:55:19 2002
@@ -645,6 +645,7 @@
 static char *radeon_find_rom(struct radeonfb_info *rinfo);
 static void radeon_get_pllinfo(struct radeonfb_info *rinfo, char *bios_seg);
 static void radeon_get_moninfo (struct radeonfb_info *rinfo);
+static int radeon_get_bios_dfpinfo (struct radeonfb_info *rinfo);
 static int radeon_get_dfpinfo (struct radeonfb_info *rinfo);
 static void radeon_get_EDID(struct radeonfb_info *rinfo);
 static int radeon_dfp_parse_EDID(struct radeonfb_info *rinfo);
@@ -933,7 +936,8 @@
 
 	if ((rinfo->dviDisp_type == MT_DFP) || (rinfo->dviDisp_type == MT_LCD) ||
 	    (rinfo->crtDisp_type == MT_DFP)) {
-		if (!radeon_get_dfpinfo(rinfo)) {
+		if (!radeon_get_dfpinfo(rinfo) &&
+		    !radeon_get_bios_dfpinfo(rinfo)) {
 			iounmap ((void*)rinfo->mmio_base);
 			release_mem_region (rinfo->mmio_base_phys,
 					    pci_resource_len(pdev, 2));
@@ -1365,6 +1369,48 @@
 
 
 
+static int radeon_get_bios_dfpinfo (struct radeonfb_info *rinfo)
+{
+	char *biosstart, *fpbiosstart;
+	char *tmp, *tmp0;
+	int i;
+	char stmp[30];
+
+	if(!(biosstart = radeon_find_rom(rinfo))) goto out;
+	if(!(fpbiosstart = biosstart + readw(biosstart + 0x48))) goto out;
+	if(!(tmp = biosstart + readw(fpbiosstart + 0x40))) goto out;
+
+	for(i=0; i<24; i++) stmp[i] = readb(tmp+i+1);
+	stmp[24] = 0; 
+	printk("radeonfb: panel ID string: %s\n", stmp);
+	rinfo->panel_xres = readw(tmp + 25);
+	rinfo->panel_yres = readw(tmp + 27);
+	printk("radeonfb: detected DFP panel size from BIOS: %dx%d\n",
+	       rinfo->panel_xres, rinfo->panel_yres);
+	for(i=0; i<20; i++) {
+		tmp0 = biosstart + readw(tmp+64+i*2);
+		if(tmp0 == 0) break;
+		if((readw(tmp0) == rinfo->panel_xres) &&
+		   (readw(tmp0+2) == rinfo->panel_yres)) {
+			rinfo->hblank = (readw(tmp0+17) - readw(tmp0+19)) * 8;
+			rinfo->hOver_plus = (readw(tmp0+21) - readw(tmp0+19) - 1) * 8;
+			rinfo->hSync_width = readb(tmp0+23) * 8;
+			rinfo->vblank = readw(tmp0+24) - readw(tmp0+26);
+			rinfo->vOver_plus = (readw(tmp0+28) & 0x7ff) - readw(tmp0+26);
+			rinfo->vSync_width = (readw(tmp0+28) & 0xf800) >> 11;
+			rinfo->clock = readw(tmp0+9);
+			radeon_update_default_var(rinfo);
+			radeonfb_default_var.bits_per_pixel = 32;
+			return 1;
+		}
+	}
+ out:
+	printk("radeonfb: Failed to detect DFP panel size using BIOS\n");
+	return 0;
+}
+
+
+
 static int radeon_get_dfpinfo (struct radeonfb_info *rinfo)
 {
 	unsigned int tmp;
@@ -1406,7 +1452,7 @@
 			rinfo->panel_xres = 1600;
 			break;
 		default:
-			printk("radeonfb: Failed to detect DFP panel size\n");
+			printk("radeonfb: Failed to detect DFP panel size using EDID\n");
 			return 0;
 	}
 

--------------040408060807090203010806--

