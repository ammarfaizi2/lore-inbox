Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbULZVDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbULZVDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 16:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULZVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 16:03:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:28058 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261166AbULZVC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 16:02:59 -0500
Date: Sun, 26 Dec 2004 22:13:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-mtd <linux-mtd@lists.infradead.org>
Cc: David Woodhouse <dwmw2@redhat.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wh.fh-wedel.de>,
       Greg Ungerer <gerg@snapgear.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] remove unnessesary casts from drivers/mtd/maps/nettel.c and
 kill two warnings
Message-ID: <Pine.LNX.4.61.0412262202510.3552@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I took a look at the cause for these warnings in the 2.6.10 kernel,

drivers/mtd/maps/nettel.c:361: warning: assignment makes pointer from integer without a cast
drivers/mtd/maps/nettel.c:395: warning: assignment makes pointer from integer without a cast

and as far as I can see the casts in there (to unsigned long and back to 
void*) are completely unnessesary ('virt' in 'struct map_info' is a void 
__iomem *), and getting rid of those casts buys us a warning free build.

Are there any reasons not to apply the patch below?
Unfortunately I don't have hardware to test this patch, so it has been 
compile tested only.

Please keep me on CC since I'm not subscribed to linux-mtd.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/drivers/mtd/maps/nettel.c linux-2.6.10/drivers/mtd/maps/nettel.c
--- linux-2.6.10-orig/drivers/mtd/maps/nettel.c	2004-12-24 22:34:27.000000000 +0100
+++ linux-2.6.10/drivers/mtd/maps/nettel.c	2004-12-26 22:00:07.000000000 +0100
@@ -332,8 +332,8 @@ int __init nettel_init(void)
 
 		/* Destroy useless AMD MTD mapping */
 		amd_mtd = NULL;
-		iounmap((void *) nettel_amd_map.virt);
-		nettel_amd_map.virt = (unsigned long) NULL;
+		iounmap(nettel_amd_map.virt);
+		nettel_amd_map.virt = NULL;
 #else
 		/* Only AMD flash supported */
 		return(-ENXIO);
@@ -357,8 +357,7 @@ int __init nettel_init(void)
 	/* Probe for the the size of the first Intel flash */
 	nettel_intel_map.size = maxsize;
 	nettel_intel_map.phys = intel0addr;
-	nettel_intel_map.virt = (unsigned long)
-		ioremap_nocache(intel0addr, maxsize);
+	nettel_intel_map.virt = ioremap_nocache(intel0addr, maxsize);
 	if (!nettel_intel_map.virt) {
 		printk("SNAPGEAR: failed to ioremap() ROMCS1\n");
 		return(-EIO);
@@ -366,8 +365,8 @@ int __init nettel_init(void)
 	simple_map_init(&nettel_intel_map);
 
 	intel_mtd = do_map_probe("cfi_probe", &nettel_intel_map);
-	if (! intel_mtd) {
-		iounmap((void *) nettel_intel_map.virt);
+	if (!intel_mtd) {
+		iounmap(nettel_intel_map.virt);
 		return(-ENXIO);
 	}
 
@@ -388,11 +387,10 @@ int __init nettel_init(void)
 	/* Delete the old map and probe again to do both chips */
 	map_destroy(intel_mtd);
 	intel_mtd = NULL;
-	iounmap((void *) nettel_intel_map.virt);
+	iounmap(nettel_intel_map.virt);
 
 	nettel_intel_map.size = maxsize;
-	nettel_intel_map.virt = (unsigned long)
-		ioremap_nocache(intel0addr, maxsize);
+	nettel_intel_map.virt = ioremap_nocache(intel0addr, maxsize);
 	if (!nettel_intel_map.virt) {
 		printk("SNAPGEAR: failed to ioremap() ROMCS1/2\n");
 		return(-EIO);
@@ -480,7 +478,7 @@ void __exit nettel_cleanup(void)
 		map_destroy(intel_mtd);
 	}
 	if (nettel_intel_map.virt) {
-		iounmap((void *)nettel_intel_map.virt);
+		iounmap(nettel_intel_map.virt);
 		nettel_intel_map.virt = 0;
 	}
 #endif



