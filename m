Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWDJS1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWDJS1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWDJS1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:27:45 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:23966 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932082AbWDJS1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:27:44 -0400
Message-ID: <443AA39E.6010700@blom.org>
Date: Mon, 10 Apr 2006 20:27:42 +0200
From: Martin Blom <martin@blom.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow subpartitions inside logical DOS partitions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch makes the subpartition scan in fs/partitions/msdos.c
scan all partitions, not only the primary ones.

Useful for the AROS/Amithlon subpartition patch (see separate mail).

Comments?



diff -ru linux-2.6.16/fs/partitions/check.h
logical-subpartitions/fs/partitions/check.h
--- linux-2.6.16/fs/partitions/check.h	2006-04-10 14:05:43.000000000 +0200
+++ logical-subpartitions/fs/partitions/check.h	2006-04-10
14:09:11.000000000 +0200
@@ -13,6 +13,7 @@
  		sector_t from;
  		sector_t size;
  		int flags;
+		int id;
  	} parts[MAX_PART];
  	int next;
  	int limit;
diff -ru linux-2.6.16/fs/partitions/msdos.c
logical-subpartitions/fs/partitions/msdos.c
--- linux-2.6.16/fs/partitions/msdos.c	2006-04-10 14:05:43.000000000 +0200
+++ logical-subpartitions/fs/partitions/msdos.c	2006-04-10
14:09:11.000000000 +0200
@@ -132,6 +132,7 @@
  			}

  			put_partition(state, state->next, next, size);
+			state->parts[state->next].id = SYS_IND(p);
  			if (SYS_IND(p) == LINUX_RAID_PARTITION)
  				state->parts[state->next].flags = 1;
  			loopct = 0;
@@ -384,7 +385,7 @@
  	Sector sect;
  	unsigned char *data;
  	struct partition *p;
-	int slot;
+	int slot, max_slot;

  	data = read_dev_sector(bdev, 0, &sect);
  	if (!data)
@@ -442,6 +443,7 @@
  			continue;
  		}
  		put_partition(state, slot, start, size);
+		state->parts[slot].id = SYS_IND(p);
  		if (SYS_IND(p) == LINUX_RAID_PARTITION)
  			state->parts[slot].flags = 1;
  		if (SYS_IND(p) == DM6_PARTITION)
@@ -453,12 +455,13 @@
  	printk("\n");

  	/* second pass - output for each on a separate line */
-	p = (struct partition *) (0x1be + data);
-	for (slot = 1 ; slot <= 4 ; slot++, p++) {
-		unsigned char id = SYS_IND(p);
+	for (slot = 1, max_slot = state->next ; slot < max_slot ; slot++) {
+		unsigned char id = (unsigned char) state->parts[slot].id;
+		u32 start = state->parts[slot].from;
+		u32 size = state->parts[slot].size;
  		int n;

-		if (!NR_SECTS(p))
+		if (!size)
  			continue;

  		for (n = 0; subtypes[n].parse && id != subtypes[n].id; n++)
@@ -466,8 +469,7 @@

  		if (!subtypes[n].parse)
  			continue;
-		subtypes[n].parse(state, bdev, START_SECT(p)*sector_size,
-						NR_SECTS(p)*sector_size, slot);
+		subtypes[n].parse(state, bdev, start, size, slot);
  	}
  	put_dev_sector(sect);
  	return 1;


-- 
---- Martin Blom --------------------------- martin@blom.org ----
Eccl 1:18                                 http://martin.blom.org/

