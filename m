Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265763AbSKAVds>; Fri, 1 Nov 2002 16:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbSKAVds>; Fri, 1 Nov 2002 16:33:48 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:9708 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265763AbSKAVdq>; Fri, 1 Nov 2002 16:33:46 -0500
Date: Fri, 1 Nov 2002 14:38:56 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: thornber@sistina.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Pseudo-patch/RFC move io_restrictions to blkdev.h in 2.5.45
Message-ID: <20021101143856.A24651@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	<linux/device-mapper.h> duplicates a list of fields in struct
request_queue.  I've wanted to get those fields into a separate
structure to make it easier for drivers to manipulate them as a group
without having to be modified as often when those fields change.
I imagine that most block device drivers would simply declare a
struct io_restrictions that they would copy in its entirety into
the struct request_queue's that they initialize.

	This change will also eventually make it easier to lift the
mergability tests out of the block layer and apply it to
gather-scatter DMA in general, although that will probabably entail
some minor changes to struct io_restrictions, like counting entirely
in bytes instead of sectors.  (However you don't have to buy into this
larger vision to be in favor of this patch.)

	Here are the header file changes (haven't even tried to
compile it), a net deletion of four lines.  If this change seems
reasonable, I'll edit the rest of the C files, make it compile and run
and submit a real patch that should compile to the same object code as
before.  Please let me know if this is OK.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="blkdev.diff"

--- linux-2.5.45/include/linux/blkdev.h	2002-10-30 16:42:20.000000000 -0800
+++ linux/include/linux/blkdev.h	2002-11-01 14:10:18.000000000 -0800
@@ -16,6 +16,15 @@
 struct elevator_s;
 typedef struct elevator_s elevator_t;
 
+struct io_restrictions {
+	unsigned short		max_sectors;
+	unsigned short		max_phys_segments;
+	unsigned short		max_hw_segments;
+	unsigned short		hardsect_size;
+	unsigned int		max_segment_size;
+	unsigned long		seg_boundary_mask;
+};
+
 struct request_list {
 	unsigned int count;
 	struct list_head free;
@@ -216,13 +225,7 @@
 	/*
 	 * queue settings
 	 */
-	unsigned short		max_sectors;
-	unsigned short		max_phys_segments;
-	unsigned short		max_hw_segments;
-	unsigned short		hardsect_size;
-	unsigned int		max_segment_size;
-
-	unsigned long		seg_boundary_mask;
+	struct io_restrictions	limits;
 	unsigned int		dma_alignment;
 
 	wait_queue_head_t	queue_wait;
--- linux-2.5.45/include/linux/device-mapper.h	2002-10-30 16:43:07.000000000 -0800
+++ linux/include/linux/device-mapper.h	2002-11-01 14:09:15.000000000 -0800
@@ -7,6 +7,8 @@
 #ifndef _LINUX_DEVICE_MAPPER_H
 #define _LINUX_DEVICE_MAPPER_H
 
+#include <linux/blkdev.h>
+
 #define DM_DIR "mapper"	/* Slashes not supported */
 #define DM_MAX_TYPE_NAME 16
 #define DM_NAME_LEN 128
@@ -65,15 +67,6 @@
 	dm_status_fn status;
 };
 
-struct io_restrictions {
-	unsigned short		max_sectors;
-	unsigned short		max_phys_segments;
-	unsigned short		max_hw_segments;
-	unsigned short		hardsect_size;
-	unsigned int		max_segment_size;
-	unsigned long		seg_boundary_mask;
-};
-
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;

--IJpNTDwzlM2Ie8A6--
