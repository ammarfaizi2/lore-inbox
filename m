Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTJ3Pwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJ3Pwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:52:49 -0500
Received: from mail03.powweb.com ([63.251.216.36]:33553 "EHLO
	mail03.powweb.com") by vger.kernel.org with ESMTP id S262352AbTJ3Pwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:52:46 -0500
MIME-Version: 1.0
From: "Richard Drummond" <evilrich@rcdrummond.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Date: Thu, 30 Oct 2003 15:52:45 -0000
Subject: [PATCH] Multi-head fix for tdfxfb driver (again)
X-Mailer: PowWeb Hosting Webmail version 3.0
Content-Type: multipart/mixed; boundary="----------=_1067529165-62329-0"
Message-Id: <20031030155250.A550415D1F@mail03.powweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1067529165-62329-0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Bloody web mail. I'll try that again . . .

Hi All

This patch (against 2.6.0-test9) corrects a bug in the tdfxfb driver with
regard to multi-head set-ups. The driver was stomping all over its default
fb_fix_screeninfo struct (the global, tdfx_fix) when initializing a card -
which could potentially causes problems when the time comes to set up the
next card. This fix makes it copy tdfx_fix first and modify only that copy.

Cheers,
Rich

------------=_1067529165-62329-0
Content-Type: text/plain; name="tdfxfb2.6.0test920031030.diff"
Content-Disposition: inline; filename="tdfxfb2.6.0test920031030.diff"
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test9/drivers/video/tdfxfb.c.orig	2003-10-30 08:32:22.000000000 -0500
+++ linux-2.6.0-test9/drivers/video/tdfxfb.c	2003-10-30 09:43:39.000000000 -0500
@@ -1152,6 +1152,8 @@
 {
 	struct tdfx_par *default_par;
 	struct fb_info *info;
+	struct fb_fix_screeninfo *fix;
+
 	int size, err;
 
 	if ((err = pci_enable_device(pdev))) {
@@ -1168,28 +1170,30 @@
 	memset(info, 0, size);
     
 	default_par = (struct tdfx_par *) (info + 1);
+	info->fix = tdfx_fix;
+	fix = &info->fix;
  
 	/* Configure the default fb_fix_screeninfo first */
 	switch (pdev->device) {
 		case PCI_DEVICE_ID_3DFX_BANSHEE:	
-			strcat(tdfx_fix.id, " Banshee");
+			strcat(fix->id, " Banshee");
 			default_par->max_pixclock = BANSHEE_MAX_PIXCLOCK;
 			break;
 		case PCI_DEVICE_ID_3DFX_VOODOO3:
-			strcat(tdfx_fix.id, " Voodoo3");
+			strcat(fix->id, " Voodoo3");
 			default_par->max_pixclock = VOODOO3_MAX_PIXCLOCK;
 			break;
 		case PCI_DEVICE_ID_3DFX_VOODOO5:
-			strcat(tdfx_fix.id, " Voodoo5");
+			strcat(fix->id, " Voodoo5");
 			default_par->max_pixclock = VOODOO5_MAX_PIXCLOCK;
 			break;
 	}
 
-	tdfx_fix.mmio_start = pci_resource_start(pdev, 0);
-	tdfx_fix.mmio_len = pci_resource_len(pdev, 0);
-	default_par->regbase_virt = ioremap_nocache(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
+	fix->mmio_start = pci_resource_start(pdev, 0);
+	fix->mmio_len = pci_resource_len(pdev, 0);
+	default_par->regbase_virt = ioremap_nocache(fix->mmio_start, fix->mmio_len);
 	if (!default_par->regbase_virt) {
-		printk("fb: Can't remap %s register area.\n", tdfx_fix.id);
+		printk("fb: Can't remap %s register area.\n", fix->id);
 		goto out_err;
 	}
     
@@ -1199,9 +1203,9 @@
 		goto out_err;
 	} 
 
-	tdfx_fix.smem_start = pci_resource_start(pdev, 1);
-	if (!(tdfx_fix.smem_len = do_lfb_size(default_par, pdev->device))) {
-		printk("fb: Can't count %s memory.\n", tdfx_fix.id);
+	fix->smem_start = pci_resource_start(pdev, 1);
+	if (!(fix->smem_len = do_lfb_size(default_par, pdev->device))) {
+		printk("fb: Can't count %s memory.\n", fix->id);
 		release_mem_region(pci_resource_start(pdev, 0),
 				   pci_resource_len(pdev, 0));
 		goto out_err;	
@@ -1215,10 +1219,10 @@
 		goto out_err;
 	}
 
-	info->screen_base = ioremap_nocache(tdfx_fix.smem_start, 
-					    tdfx_fix.smem_len);
+	info->screen_base = ioremap_nocache(fix->smem_start, 
+					    fix->smem_len);
 	if (!info->screen_base) {
-		printk("fb: Can't remap %s framebuffer.\n", tdfx_fix.id);
+		printk("fb: Can't remap %s framebuffer.\n", fix->id);
 		release_mem_region(pci_resource_start(pdev, 1),
 				   pci_resource_len(pdev, 1));
 		release_mem_region(pci_resource_start(pdev, 0),
@@ -1238,13 +1242,13 @@
 		goto out_err;
 	}
 
-	printk("fb: %s memory = %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
+	printk("fb: %s memory = %dK\n", fix->id, fix->smem_len >> 10);
 
-	tdfx_fix.ypanstep	= nopan ? 0 : 1;
-	tdfx_fix.ywrapstep	= nowrap ? 0 : 1;
+	fix->ypanstep	= nopan ? 0 : 1;
+	fix->ywrapstep	= nowrap ? 0 : 1;
    
 	info->fbops		= &tdfxfb_ops;
-	info->fix		= tdfx_fix; 	
+/*	info->fix		= tdfx_fix; */
 	info->par		= default_par;
 	info->pseudo_palette	= (void *)(default_par + 1); 
 	info->flags		= FBINFO_FLAG_DEFAULT;

------------=_1067529165-62329-0--

