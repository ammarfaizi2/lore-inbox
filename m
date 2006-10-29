Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWJ2U7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWJ2U7q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWJ2U7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:59:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:40457 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030240AbWJ2U7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:59:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=S+n2/yRdJOIYou6peJxtMUqbO7ISPTHhHjdH+/Qv7i38XWZo/tPDWE/wCSM1ropKoLRiwITZgXzIyUky0dMVR76ods7yc/bapqkMYAGug0Occ/AyDwHx/sC2rReF9xugNleIu0CIiAu2USSU4SoUvqiFbPM4zfz+ETzcaSGRkH4=
Date: Sun, 29 Oct 2006 22:58:03 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Eric Sesterhenn <snakebyte@gmx.de>
Subject: [PATCH] drivers/video/*: use kmemdup()
Message-ID: <20061029195803.GC4900@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/video/aty/radeon_monitor.c  |    3 +--
 drivers/video/i810/i810-i2c.c       |    4 +---
 drivers/video/intelfb/intelfbdrv.c  |    3 +--
 drivers/video/nvidia/nv_i2c.c       |    7 ++-----
 drivers/video/nvidia/nv_of.c        |    3 +--
 drivers/video/savage/savagefb-i2c.c |    7 ++-----
 6 files changed, 8 insertions(+), 19 deletions(-)

--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -104,10 +104,9 @@ static int __devinit radeon_parse_montyp
 	if (pedid == NULL)
 		return mt;
 
-	tmp = (u8 *)kmalloc(EDID_LENGTH, GFP_KERNEL);
+	tmp = (u8 *)kmemdup(pedid, EDID_LENGTH, GFP_KERNEL);
 	if (!tmp)
 		return mt;
-	memcpy(tmp, pedid, EDID_LENGTH);
 	*out_EDID = tmp;
 	return mt;
 }
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -162,9 +162,7 @@ int i810_probe_i2c_connector(struct fb_i
 
 		if (e != NULL) {
 			DPRINTK("i810-i2c: Getting EDID from BIOS\n");
-			edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
-			if (edid)
-				memcpy(edid, e, EDID_LENGTH);
+			edid = kmemdup(e, EDID_LENGTH, GFP_KERNEL);
 		}
 	}
 
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1058,10 +1058,9 @@ intelfb_init_var(struct intelfb_info *di
 		u8 *edid_d = NULL;
 
 		if (edid_s) {
-			edid_d = kmalloc(EDID_LENGTH, GFP_KERNEL);
+			edid_d = kmemdup(edid_s, EDID_LENGTH, GFP_KERNEL);
 
 			if (edid_d) {
-				memcpy(edid_d, edid_s, EDID_LENGTH);
 				fb_edid_to_monspecs(edid_d,
 						    &dinfo->info->monspecs);
 				kfree(edid_d);
--- a/drivers/video/nvidia/nv_i2c.c
+++ b/drivers/video/nvidia/nv_i2c.c
@@ -210,11 +210,8 @@ int nvidia_probe_i2c_connector(struct fb
 		/* try to get from firmware */
 		const u8 *e = fb_firmware_edid(info->device);
 
-		if (e != NULL) {
-			edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
-			if (edid)
-				memcpy(edid, e, EDID_LENGTH);
-		}
+		if (e != NULL)
+			edid = kmemdup(e, EDID_LENGTH, GFP_KERNEL);
 	}
 
 	*out_edid = edid;
--- a/drivers/video/nvidia/nv_of.c
+++ b/drivers/video/nvidia/nv_of.c
@@ -72,10 +72,9 @@ int nvidia_probe_of_connector(struct fb_
 		}
 	}
 	if (pedid) {
-		*out_edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+		*out_edid = kmemdup(pedid, EDID_LENGTH, GFP_KERNEL);
 		if (*out_edid == NULL)
 			return -1;
-		memcpy(*out_edid, pedid, EDID_LENGTH);
 		printk(KERN_DEBUG "nvidiafb: Found OF EDID for head %d\n", conn);
 		return 0;
 	}
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -227,11 +227,8 @@ int savagefb_probe_i2c_connector(struct 
 		/* try to get from firmware */
 		const u8 *e = fb_firmware_edid(info->device);
 
-		if (e) {
-			edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
-			if (edid)
-				memcpy(edid, e, EDID_LENGTH);
-		}
+		if (e)
+			edid = kmemdup(e, EDID_LENGTH, GFP_KERNEL);
 	}
 
 	*out_edid = edid;

