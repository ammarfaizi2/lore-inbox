Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVHDB1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVHDB1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVHDB1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 21:27:23 -0400
Received: from serv01.siteground.net ([70.85.91.68]:8337 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261722AbVHDB1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 21:27:20 -0400
Date: Wed, 3 Aug 2005 18:26:57 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: christoph@lameter.com, shai@scalex86.org, linux-kernel@vger.kernel.org,
       ak@suse.de, linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [patch] ide: fix kmalloc_node breakage in ide driver
Message-ID: <20050804012657.GA3542@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machines with ide-interfaces which do not have pci devices are crashing on boot
at pcibus_to_node in the ide drivers.  We noticed this on a x445 running
2.6.13-rc4.  Similar issue was discussed earlier, but the crash was due 
to hwif being NULL.
http://marc.theaimsgroup.com/?t=112075352000003&r=1&w=2
Andi and Christoph had patches, but neither went in.  Here's one of those
patches with an added BUG_ON(hwif == NULL).  Please include.

Thanks,
Kiran


Patch fixes oops caused by ide interfaces not on pci. pcibus_to_node causes
the kernel to crash otherwise.  Patch also adds a BUG_ON to check if hwif is 
NULL. 

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>


Index: linux-2.6.13-rc1/drivers/ide/ide-probe.c
===================================================================
--- linux-2.6.13-rc1.orig/drivers/ide/ide-probe.c	2005-06-29 20:06:53.000000000 -0400
+++ linux-2.6.13-rc1/drivers/ide/ide-probe.c	2005-08-02 10:09:20.930965408 -0400
@@ -960,6 +960,15 @@
 }
 #endif /* MAX_HWIFS > 1 */
 
+static inline int hwif_to_node(ide_hwif_t *hwif)
+{
+	if (hwif->pci_dev)
+		return pcibus_to_node(hwif->pci_dev->bus);
+	else
+		/* Add ways to determine the node of other busses here */
+		return -1;
+}
+
 /*
  * init request queue
  */
@@ -978,8 +987,7 @@
 	 *	do not.
 	 */
 
-	q = blk_init_queue_node(do_ide_request, &ide_lock,
-				pcibus_to_node(drive->hwif->pci_dev->bus));
+	q = blk_init_queue_node(do_ide_request, &ide_lock, hwif_to_node(hwif));
 	if (!q)
 		return 1;
 
@@ -1048,6 +1056,8 @@
 
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());	
+	BUG_ON(hwif == NULL);
+	
 	down(&ide_cfg_sem);
 	hwif->hwgroup = NULL;
 #if MAX_HWIFS > 1
@@ -1097,7 +1107,7 @@
 		spin_unlock_irq(&ide_lock);
 	} else {
 		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
-			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
+					hwif_to_node(hwif->drives[0].hwif));
 		if (!hwgroup)
 	       		goto out_up;
 
