Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263215AbUKULkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUKULkv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKULji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:39:38 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:30 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261773AbUKULih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:38:37 -0500
Date: Sun, 21 Nov 2004 12:38:35 +0100
Message-Id: <200411211138.iALBcZcV032371@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 532] M68k HP Lance Ethernet: Fix leaks on probe/removal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP Lance Ethernet: There's tons of leaks in the hplcance probing code, and it
doesn't release the memory region on removal either (from Christoph Hellwig)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/drivers/net/hplance.c	2004-11-09 21:12:05.000000000 +0100
+++ linux-m68k-2.6.10-rc2/drivers/net/hplance.c	2004-11-21 10:51:37.000000000 +0100
@@ -76,25 +76,31 @@
 				const struct dio_device_id *ent)
 {
 	struct net_device *dev;
-	int err;
+	int err = -ENOMEM;
 
 	dev = alloc_etherdev(sizeof(struct hplance_private));
 	if (!dev)
-		return -ENOMEM;
+		goto out;
 
-	if (!request_mem_region(d->resource.start, d->resource.end-d->resource.start, d->name))
-		return -EBUSY;
+	err = -EBUSY;
+	if (!request_mem_region(dio_resource_start(d),
+				dio_resource_len(d), d->name))
+		goto out_free_netdev;
 
-	SET_MODULE_OWNER(dev);
-        
 	hplance_init(dev, d);
 	err = register_netdev(dev);
-	if (err) {
-		free_netdev(dev);
-		return err;
-	}
+	if (err)
+		goto out_release_mem_region;
+
 	dio_set_drvdata(d, dev);
 	return 0;
+
+ out_release_mem_region:
+	release_mem_region(dio_resource_start(d), dio_resource_len(d));
+ out_free_netdev:
+	free_netdev(dev);
+ out:
+	return err;
 }
 
 static void __devexit hplance_remove_one(struct dio_dev *d)
@@ -102,6 +108,7 @@
 	struct net_device *dev = dio_get_drvdata(d);
 
 	unregister_netdev(dev);
+	release_mem_region(dio_resource_start(d), dio_resource_len(d));
 	free_netdev(dev);
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
