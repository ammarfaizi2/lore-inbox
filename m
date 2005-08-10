Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVHJC7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVHJC7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 22:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVHJC7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 22:59:24 -0400
Received: from graphe.net ([209.204.138.32]:16316 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S964898AbVHJC7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 22:59:23 -0400
Date: Tue, 9 Aug 2005 19:59:21 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org, kiran@scalex86.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: [PATCH] ide-disk oopses on boot
In-Reply-To: <42F92A1F.9040901@vc.cvut.cz>
Message-ID: <Pine.LNX.4.62.0508091953270.30717@graphe.net>
References: <20050809132725.GA20397@vana.vc.cvut.cz>
 <Pine.LNX.4.62.0508090926150.12719@graphe.net> <42F92A1F.9040901@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Petr Vandrovec wrote:

> > Yes that was discussed extensively by Andi and me and finally fixed by
> > Kiran's patch in 2.6.13-rc6.
> 
> By which patch?  I hit it with post-2.6.13-rc6, exactly 2.6.13-rc6 with
> checkin hash "commit 00dd1e433967872f3997a45d5adf35056fdf2f56".  So if it is
> supposed to be fixed in 2.6.13-rc6, it is not.

Yes you are right there is one additional place where pcibus_to_node is 
used with the hwif that we did not cover. This better go into 2.6.13.

---
Fix ide-disk.c oops caused by hwif == NULL

1. Move hwif_to_node to ide.h

2. Use hwif_to_node in ide-disk.c

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/drivers/ide/ide-disk.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-disk.c	2005-07-27 18:29:17.000000000 -0700
+++ linux-2.6/drivers/ide/ide-disk.c	2005-08-09 19:55:03.000000000 -0700
@@ -1220,7 +1220,7 @@
 		goto failed;
 
 	g = alloc_disk_node(1 << PARTN_BITS,
-			pcibus_to_node(drive->hwif->pci_dev->bus));
+			hwif_to_node(drive->hwif));
 	if (!g)
 		goto out_free_idkp;
 
Index: linux-2.6/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-probe.c	2005-08-04 15:47:15.000000000 -0700
+++ linux-2.6/drivers/ide/ide-probe.c	2005-08-09 19:46:50.000000000 -0700
@@ -960,15 +960,6 @@
 }
 #endif /* MAX_HWIFS > 1 */
 
-static inline int hwif_to_node(ide_hwif_t *hwif)
-{
-	if (hwif->pci_dev)
-		return pcibus_to_node(hwif->pci_dev->bus);
-	else
-		/* Add ways to determine the node of other busses here */
-		return -1;
-}
-
 /*
  * init request queue
  */
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h	2005-07-27 18:29:23.000000000 -0700
+++ linux-2.6/include/linux/ide.h	2005-08-09 19:47:14.000000000 -0700
@@ -1501,4 +1501,13 @@
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
 
+static inline int hwif_to_node(ide_hwif_t *hwif)
+{
+	if (hwif->pci_dev)
+		return pcibus_to_node(hwif->pci_dev->bus);
+	else
+		/* Add ways to determine the node of other busses here */
+		return -1;
+}
+
 #endif /* _IDE_H */
