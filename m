Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbUBEAeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUBEAZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:25:30 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:35858 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S265102AbUBEAOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:14:24 -0500
Date: Wed, 4 Feb 2004 18:18:45 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [9 of 11]
Message-ID: <Pine.LNX.4.58.0402041817280.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 9 of 11. Please apply in order.
This patch changes the way we fill out the /proc files we create. It now has
human readable volume sizes, RAID levels, etc. Also removes some fields that
were orginally for debug purposes.
This is in the 2.4 tree.
--------------------------------------------------------------------------------------
diff -burN lx261-p008/drivers/block/cciss.c lx261/drivers/block/cciss.c
--- lx261-p008/drivers/block/cciss.c	2004-01-23 13:16:48.000000000 -0600
+++ lx261/drivers/block/cciss.c	2004-01-23 15:37:47.000000000 -0600
@@ -156,6 +156,11 @@
 /*
  * Report information about this controller.
  */
+#define ENG_GIG 1048576000
+#define ENG_GIG_FACTOR (ENG_GIG/512)
+#define RAID_UNKNOWN 6
+static const char *raid_label[] = {"0","4","1(0+1)","5","5+1","ADG",
+	                                   "UNKNOWN"};
 #ifdef CONFIG_PROC_FS

 static struct proc_dir_entry *proc_cciss;
@@ -168,28 +173,40 @@
         int size, i, ctlr;
         ctlr_info_t *h = (ctlr_info_t*)data;
         drive_info_struct *drv;
+	unsigned long flags;
+	unsigned int vol_sz, vol_sz_frac;

         ctlr = h->ctlr;
-        size = sprintf(buffer, "%s:  Compaq %s Controller\n"
-                "       Board ID: 0x%08lx\n"
-		"       Firmware Version: %c%c%c%c\n"
-                "       Memory Address: 0x%08lx\n"
-                "       IRQ: %d\n"
-                "       Logical drives: %d\n"
-		"       Highest Logical Volume ID: %d\n"
-                "       Current Q depth: %d\n"
-                "       Max Q depth since init: %d\n"
-		"       Max # commands on controller since init: %d\n"
-		"       Max SG entries since init: %d\n\n",
+
+	/* prevent displaying bogus info during configuration
+	 * or deconfiguration of a logical volume
+	 */
+	spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
+	if (h->busy_configuring) {
+		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
+	return -EBUSY;
+	}
+	h->busy_configuring = 1;
+	spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
+
+        size = sprintf(buffer, "%s: HP %s Controller\n"
+		"Board ID: 0x%08lx\n"
+		"Firmware Version: %c%c%c%c\n"
+		"IRQ: %d\n"
+		"Logical drives: %d\n"
+		"Current Q depth: %d\n"
+		"Current # commands on controller: %d\n"
+		"Max Q depth since init: %d\n"
+		"Max # commands on controller since init: %d\n"
+		"Max SG entries since init: %d\n\n",
                 h->devname,
                 h->product_name,
                 (unsigned long)h->board_id,
 		h->firm_ver[0], h->firm_ver[1], h->firm_ver[2], h->firm_ver[3],
-                (unsigned long)h->vaddr,
                 (unsigned int)h->intr,
                 h->num_luns,
-                h->highest_lun,
-                h->Qdepth, h->maxQsinceinit, h->max_outstanding, h->maxSG);
+		h->Qdepth, h->commands_outstanding,
+		h->maxQsinceinit, h->max_outstanding, h->maxSG);

         pos += size; len += size;
 	cciss_proc_tape_report(ctlr, buffer, &pos, &len);
@@ -197,20 +214,23 @@
                 drv = &h->drv[i];
 		if (drv->block_size == 0)
 			continue;
-                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%llu\n",
-                                ctlr, i, drv->block_size, (unsigned long long)drv->nr_blocks);
+		vol_sz = drv->nr_blocks/ENG_GIG_FACTOR;
+		vol_sz_frac = (drv->nr_blocks%ENG_GIG_FACTOR)*100/ENG_GIG_FACTOR;
+		if (drv->raid_level > 5)
+			drv->raid_level = RAID_UNKNOWN;
+		size = sprintf(buffer+len, "cciss/c%dd%d:"
+				"\t%4d.%02dGB\tRAID %s\n",
+				ctlr, i, vol_sz,vol_sz_frac,
+				raid_label[drv->raid_level]);
                 pos += size; len += size;
         }

-	size = sprintf(buffer+len, "nr_allocs = %d\nnr_frees = %d\n",
-                        h->nr_allocs, h->nr_frees);
-        pos += size; len += size;
-
         *eof = 1;
         *start = buffer+offset;
         len -= offset;
         if (len>length)
                 len = length;
+	h->busy_configuring = 0;
         return len;
 }

@@ -2158,10 +2178,10 @@
 	for(i=0; i<DEVICE_COUNT_RESOURCE; i++)
 	{
 		/* is this an IO range */
-		if( pdev_resource_flags(pdev, i) & 0x01 ) {
-			c->io_mem_addr = pdev_resource_start(pdev, i);
-			c->io_mem_length = pdev_resource_end(pdev, i) -
-				pdev_resource_start(pdev, i) +1;
+		if( pci_resource_flags(pdev, i) & 0x01 ) {
+			c->io_mem_addr = pci_resource_start(pdev, i);
+			c->io_mem_length = pci_resource_end(pdev, i) -
+				pci_resource_start(pdev, i) +1;
 #ifdef CCISS_DEBUG
 			printk("IO value found base_addr[%d] %lx %lx\n", i,
 				c->io_mem_addr, c->io_mem_length);
diff -burN lx261-p008/drivers/block/cciss.h lx261/drivers/block/cciss.h
--- lx261-p008/drivers/block/cciss.h	2004-01-21 16:59:34.000000000 -0600
+++ lx261/drivers/block/cciss.h	2004-01-23 14:47:19.000000000 -0600
@@ -32,6 +32,7 @@
 	int 	heads;
 	int	sectors;
 	int 	cylinders;
+	int	raid_level;
 } drive_info_struct;

 struct ctlr_info
@@ -78,6 +79,7 @@
         unsigned long  		*cmd_pool_bits;
 	int			nr_allocs;
 	int			nr_frees;
+	int			busy_configuring;

 	// Disk structures we need to pass back
 	struct gendisk   *gendisk[NWD];

Thanks,
mikem
mike.miller@hp.com

