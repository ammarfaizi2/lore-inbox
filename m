Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbULVUiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbULVUiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 15:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbULVUiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 15:38:24 -0500
Received: from [217.111.56.2] ([217.111.56.2]:47231 "EHLO farside.sncag.com")
	by vger.kernel.org with ESMTP id S262035AbULVUiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 15:38:05 -0500
To: linux-kernel@vger.kernel.org
Subject: write support for MTD partitions w/ multiple erase sizes
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Wed, 22 Dec 2004 21:38:04 +0100
Message-ID: <874qiekr0z.fsf@farside.sncag.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MTD partition setup code in drivers/mtd/mtdpart.c doesn't
copy erase region info from master to slave devices, but instead
(wrongfully) prints a message that MTD partitions spanning multiple
erase regions cannot be written to and forces them to be read-only.
The following patch adds a function that does copy this information,
which enables writing to such MTD partitions as long as they begin
and end on an erase block boundary. The patch is against 2.4.28, but
can be used with 2.6.9, too. It hasn't been tested with anything more
esoteric than a MTD partition starting in one erase region and
ending in the next (is this even possible?)

--- linux-2.4.28/drivers/mtd/mtdpart.c	2004-12-19 16:02:48.000000000 +0100
+++ linux-eli/drivers/mtd/mtdpart.c	2004-12-19 20:47:15.000000000 +0100
@@ -272,6 +272,7 @@
 			__list_del(prev, node->next);
 			if(slave->registered)
 				del_mtd_device(&slave->mtd);
+			kfree(slave->mtd.eraseregions);
 			kfree(slave);
 			node = prev;
 		}
@@ -281,12 +282,98 @@
 }
 
 /*
- * This function, given a master MTD object and a partition table, creates
+ * These functions, given a master MTD object and a partition table, creates
  * and registers slave MTD objects which are bound to the master according to
  * the partition definitions.
  * (Q: should we register the master MTD object as well?)
  */
 
+static void setup_erase_regions(struct mtd_info const *master,
+				struct mtd_info *slave, u_int32_t slave_offset)
+/*
+  Setup erase region info for slave devices.
+*/
+{
+#define region_end(region) (region.offset + region.erasesize * region.numblocks)
+	
+	struct mtd_erase_region_info *master_regions, *slave_regions;
+	unsigned first, last, ofs, n, remain;
+
+	slave->numeraseregions = 0;
+	if (master->numeraseregions == 1) {
+		slave->erasesize = master->erasesize;
+		return;
+	}
+	
+	master_regions = master->eraseregions;
+	slave->erasesize = 0;
+
+	first = 0;
+	while (region_end(master_regions[first]) <= slave_offset) ++first;
+	slave->erasesize = master_regions[first].erasesize;
+
+	last = first;
+	n = slave_offset + slave->size;
+	while (region_end(master_regions[last]) < n) {
+		++last;
+		
+		if (master_regions[last].erasesize > slave->erasesize)
+			slave->erasesize = master_regions[last].erasesize;
+	}
+
+	if (slave_offset % master_regions[first].erasesize) {
+	    printk("partition \"%s\" does not start on an erase"
+		   " block boundary -- forcing read-only\n", slave->name);
+	    goto force_read_only;
+	}
+	
+	slave_regions = kmalloc(sizeof(*slave_regions) * (last - first + 1),
+				GFP_KERNEL);
+	if (!slave_regions) {
+		printk("partition \"%s\": could not allocate memory for erase"
+		       " region information\n", slave->name);
+		printk("forcing read-only\n");
+		goto force_read_only;
+	}
+	
+	ofs = n = 0;
+	slave_regions[n].offset = ofs;
+	slave_regions[n].erasesize = master_regions[first].erasesize;
+	slave_regions[n].numblocks = master_regions[first].numblocks;
+	slave_regions[n].numblocks -=
+		(slave_offset - master_regions[first].offset)
+		/ slave_regions[n].erasesize;
+	ofs += slave_regions[n].numblocks * slave_regions[n].erasesize;
+
+	while (first + ++n < last) {
+		slave_regions[n].offset = ofs;
+		slave_regions[n].erasesize = master_regions[first + n].erasesize;
+		slave_regions[n].numblocks = master_regions[first + n].numblocks;
+		ofs += slave_regions[n].numblocks * slave_regions[n].erasesize;
+	}
+	
+	remain = slave->size - ofs;
+	
+	if (remain % master_regions[last].erasesize) {
+		printk("partition \"%s\" does not end on an erase block boundary\n"
+		       " -- forcing read-only\n", slave->name);
+		kfree(slave_regions);
+		goto force_read_only;
+	}
+		
+	slave_regions[n].offset = ofs;
+	slave_regions[n].erasesize = master_regions[last].erasesize;
+	slave_regions[n].numblocks = remain / master_regions[last].erasesize;
+
+	slave->eraseregions = slave_regions;
+	slave->numeraseregions = last - first + 1;
+	return;
+
+ force_read_only:
+	slave->flags &= ~(MTD_WRITEABLE | MTD_ERASEABLE);
+#undef region_end
+}
+
 int add_mtd_partitions(struct mtd_info *master, 
 		       struct mtd_partition *parts,
 		       int nbparts)
@@ -399,39 +486,8 @@
 			printk ("mtd: partition \"%s\" extends beyond the end of device \"%s\" -- size truncated to %#x\n",
 				parts[i].name, master->name, slave->mtd.size);
 		}
-		if (master->numeraseregions>1) {
-			/* Deal with variable erase size stuff */
-			int i;
-			struct mtd_erase_region_info *regions = master->eraseregions;
-			
-			/* Find the first erase regions which is part of this partition. */
-			for (i=0; i < master->numeraseregions && slave->offset >= regions[i].offset; i++)
-				;
-
-			for (i--; i < master->numeraseregions && slave->offset + slave->mtd.size > regions[i].offset; i++) {
-				if (slave->mtd.erasesize < regions[i].erasesize) {
-					slave->mtd.erasesize = regions[i].erasesize;
-				}
-			}
-		} else {
-			/* Single erase size */
-			slave->mtd.erasesize = master->erasesize;
-		}
-
-		if ((slave->mtd.flags & MTD_WRITEABLE) && 
-		    (slave->offset % slave->mtd.erasesize)) {
-			/* Doesn't start on a boundary of major erase size */
-			/* FIXME: Let it be writable if it is on a boundary of _minor_ erase size though */
-			slave->mtd.flags &= ~MTD_WRITEABLE;
-			printk ("mtd: partition \"%s\" doesn't start on an erase block boundary -- force read-only\n",
-				parts[i].name);
-		}
-		if ((slave->mtd.flags & MTD_WRITEABLE) && 
-		    (slave->mtd.size % slave->mtd.erasesize)) {
-			slave->mtd.flags &= ~MTD_WRITEABLE;
-			printk ("mtd: partition \"%s\" doesn't end on an erase block -- force read-only\n",
-				parts[i].name);
-		}
+		
+		setup_erase_regions(master, &slave->mtd, slave->offset);
 
 		if(parts[i].mtdp)
 		{	/* store the object pointer (caller may or may not register it */
