Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUA2R2H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 12:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUA2R2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 12:28:07 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:40595 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S266215AbUA2R1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 12:27:52 -0500
Date: Thu, 29 Jan 2004 18:25:11 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.2-rc2, rivafb]: GeForce4 440 Go 64M overflows fb_fix_screeninfo.id
Message-ID: <20040129172511.GA959@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
fb_fix_screeninfo has space for 15 characters but riva/fbdev.c tries to
copy more into it in case of the above card (and therefore corrupts
memory). The result looks like:
rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4-4\224, 32MB @ 0x94000000)
                                                               ^^^^^
Possible fix attached. This also overwrites the initial "nVidia" in
rivafb_fix.id making the output the same as in 2.4 (and using strlcpy
makes sure we don't overflow again). With this patch:

rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (GeForce4-440-GO-M64, 32MB @ 0x94000000)

Can this go in?
 -- Guido

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rivafb-fix-ident.diff"

--- ../benh-rsync-2.6-clean/include/linux/fb.h	2003-12-24 11:31:18.000000000 +0100
+++ include/linux/fb.h	2004-01-28 20:35:24.000000000 +0100
@@ -114,7 +114,7 @@
 
 
 struct fb_fix_screeninfo {
-	char id[16];			/* identification string eg "TT Builtin" */
+	char id[32];			/* identification string eg "TT Builtin" */
 	unsigned long smem_start;	/* Start of frame buffer mem */
 					/* (physical address) */
 	__u32 smem_len;			/* Length of frame buffer mem */
--- ../benh-rsync-2.6-clean/drivers/video/riva/fbdev.c	2003-12-24 08:30:11.000000000 +0100
+++ drivers/video/riva/fbdev.c	2004-01-28 21:04:29.000000000 +0100
@@ -1867,7 +1867,7 @@
 		goto err_out_kfree1;
 	memset(info->pixmap.addr, 0, 64 * 1024);
 
-	strcat(rivafb_fix.id, rci->name);
+	strlcpy(rivafb_fix.id, rci->name, sizeof(rivafb_fix.id));
 	default_par->riva.Architecture = rci->arch_rev;
 
 	default_par->Chipset = (pd->vendor << 16) | pd->device;

--XsQoSWH+UP9D9v3l--
