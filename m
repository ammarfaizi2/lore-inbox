Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWHXHlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWHXHlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWHXHla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:41:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:37332 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWHXHlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:41:12 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:41:13 +1000
Message-Id: <1060824074113.19159@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 4] md: new sysfs interface for setting bits in the write-intent-bitmap
References: <20060824173647.19026.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Clements <paul.clements@steeleye.com>


This patch (tested against 2.6.18-rc1-mm1) adds a new sysfs interface 
that allows the bitmap of an array to be dirtied. The interface is 
write-only, and is used as follows:

echo "1000" > /sys/block/md2/md/bitmap

(dirty the bit for chunk 1000 [offset 0] in the in-memory and on-disk 
bitmaps of array md2)

echo "1000-2000" > /sys/block/md1/md/bitmap

(dirty the bits for chunks 1000-2000 in md1's bitmap)

This is useful, for example, in cluster environments where you may need 
to combine two disjoint bitmaps into one (following a server failure, 
after a secondary server has taken over the array). By combining the 
bitmaps on the two servers, a full resync can be avoided (This was 
discussed on the list back on March 18, 2005, "[PATCH 1/2] md bitmap bug 
fixes" thread).
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/md.txt        |    9 +++++++++
 ./drivers/md/bitmap.c         |   14 ++++++++++++++
 ./drivers/md/md.c             |   31 +++++++++++++++++++++++++++++++
 ./include/linux/raid/bitmap.h |    2 ++
 4 files changed, 56 insertions(+)

diff .prev/Documentation/md.txt ./Documentation/md.txt
--- .prev/Documentation/md.txt	2006-08-24 17:23:45.000000000 +1000
+++ ./Documentation/md.txt	2006-08-24 17:24:05.000000000 +1000
@@ -410,6 +410,15 @@ also have
       than sectors, this my be larger than the number of actual errors
       by a factor of the number of sectors in a page.
 
+   bitmap_set_bits
+      If the array has a write-intent bitmap, then writing to this
+      attribute can set bits in the bitmap, indicating that a resync
+      would need to check the corresponding blocks. Either individual
+      numbers or start-end pairs can be written.  Multiple numbers
+      can be separated by a space.
+      Note that the numbers are 'bit' numbers, not 'block' numbers.
+      They should be scaled by the bitmap_chunksize.
+
 Each active md device may also have attributes specific to the
 personality module that manages it.
 These are specific to the implementation of the module and could

diff .prev/drivers/md/bitmap.c ./drivers/md/bitmap.c
--- .prev/drivers/md/bitmap.c	2006-08-24 17:23:45.000000000 +1000
+++ ./drivers/md/bitmap.c	2006-08-24 17:24:05.000000000 +1000
@@ -613,6 +613,7 @@ static inline unsigned long file_page_of
 static inline struct page *filemap_get_page(struct bitmap *bitmap,
 					unsigned long chunk)
 {
+	if (file_page_index(chunk) >= bitmap->file_pages) return NULL;
 	return bitmap->filemap[file_page_index(chunk) - file_page_index(0)];
 }
 
@@ -739,6 +740,7 @@ static void bitmap_file_set_bit(struct b
 	}
 
 	page = filemap_get_page(bitmap, chunk);
+	if (!page) return;
 	bit = file_page_offset(chunk);
 
  	/* set the bit */
@@ -1322,6 +1324,18 @@ static void bitmap_set_memory_bits(struc
 
 }
 
+/* dirty the memory and file bits for bitmap chunks "s" to "e" */
+void bitmap_dirty_bits(struct bitmap *bitmap, unsigned long s, unsigned long e)
+{
+	unsigned long chunk;
+
+	for (chunk = s; chunk <= e; chunk++) {
+		sector_t sec = chunk << CHUNK_BLOCK_SHIFT(bitmap);
+		bitmap_set_memory_bits(bitmap, sec, 1);
+		bitmap_file_set_bit(bitmap, sec);
+	}
+}
+
 /*
  * flush out any pending updates
  */

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-08-24 17:23:45.000000000 +1000
+++ ./drivers/md/md.c	2006-08-24 17:24:05.000000000 +1000
@@ -2524,6 +2524,36 @@ static struct md_sysfs_entry md_new_devi
 __ATTR(new_dev, S_IWUSR, null_show, new_dev_store);
 
 static ssize_t
+bitmap_store(mddev_t *mddev, const char *buf, size_t len)
+{
+	char *end;
+	unsigned long chunk, end_chunk;
+
+	if (!mddev->bitmap)
+		goto out;
+	/* buf should be <chunk> <chunk> ... or <chunk>-<chunk> ... (range) */
+	while (*buf) {
+		chunk = end_chunk = simple_strtoul(buf, &end, 0);
+		if (buf == end) break;
+		if (*end == '-') { /* range */
+			buf = end + 1;
+			end_chunk = simple_strtoul(buf, &end, 0);
+			if (buf == end) break;
+		}
+		if (*end && !isspace(*end)) break;
+		bitmap_dirty_bits(mddev->bitmap, chunk, end_chunk);
+		buf = end;
+		while (isspace(*buf)) buf++;
+	}
+	bitmap_unplug(mddev->bitmap); /* flush the bits to disk */
+out:
+	return len;
+}
+
+static struct md_sysfs_entry md_bitmap =
+__ATTR(bitmap_set_bits, S_IWUSR, null_show, bitmap_store);
+
+static ssize_t
 size_show(mddev_t *mddev, char *page)
 {
 	return sprintf(page, "%llu\n", (unsigned long long)mddev->size);
@@ -2843,6 +2873,7 @@ static struct attribute *md_redundancy_a
 	&md_sync_completed.attr,
 	&md_suspend_lo.attr,
 	&md_suspend_hi.attr,
+	&md_bitmap.attr,
 	NULL,
 };
 static struct attribute_group md_redundancy_group = {

diff .prev/include/linux/raid/bitmap.h ./include/linux/raid/bitmap.h
--- .prev/include/linux/raid/bitmap.h	2006-08-24 17:23:45.000000000 +1000
+++ ./include/linux/raid/bitmap.h	2006-08-24 17:24:05.000000000 +1000
@@ -265,6 +265,8 @@ int bitmap_update_sb(struct bitmap *bitm
 int  bitmap_setallbits(struct bitmap *bitmap);
 void bitmap_write_all(struct bitmap *bitmap);
 
+void bitmap_dirty_bits(struct bitmap *bitmap, unsigned long s, unsigned long e);
+
 /* these are exported */
 int bitmap_startwrite(struct bitmap *bitmap, sector_t offset,
 			unsigned long sectors, int behind);
