Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUHAHns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUHAHns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUHAHni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:43:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37279 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265544AbUHAHmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:42:49 -0400
Date: Sun, 1 Aug 2004 13:22:19 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] filemap_fdatawrite range interface
Message-ID: <20040801075219.GD7327@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040801074518.GA7310@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801074518.GA7310@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 01:15:18PM +0530, Suparna Bhattacharya wrote:
> 
> The attached patches (generated against 2.6.8-rc2) enable concurrent 
> O_SYNC writers to different parts of the same file by avoiding 
> serialising on i_sem across the wait for IO completion.
> 
> This is mostly your work, ported to the tagged radix tree VFS changes
> and a few fixes. I have been carrying these patches for sometime now; 
> they can be the merged upstream. Please apply.
> 

[4] fdatawrite-range.patch

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

--------------------------------------------------------

Range based equivalent of filemap_fdatawrite for O_SYNC writers (to go
with writepages range support added to mpage_writepages).
If both <start> and <end> are zero, then it defaults to writing
back all of the mapping's dirty pages.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 linux-2.6.8-rc2-suparna/mm/filemap.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff -puN mm/filemap.c~fdatawrite-range mm/filemap.c
--- linux-2.6.8-rc2/mm/filemap.c~fdatawrite-range	2004-08-01 12:34:34.000000000 +0530
+++ linux-2.6.8-rc2-suparna/mm/filemap.c	2004-08-01 12:34:34.000000000 +0530
@@ -142,20 +142,26 @@ static inline int sync_page(struct page 
 }
 
 /**
- * filemap_fdatawrite - start writeback against all of a mapping's dirty pages
+ * filemap_fdatawrite_range - start writeback against all of a mapping's
+ * dirty pages that lie within the byte offsets <start, end>
  * @mapping: address space structure to write
+ * @start: offset in bytes where the range starts
+ * @end : offset in bytes where the range ends
  *
  * If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
  * opposed to a regular memory * cleansing writeback.  The difference between
  * these two operations is that if a dirty page/buffer is encountered, it must
  * be waited upon, and not just skipped over.
  */
-static int __filemap_fdatawrite(struct address_space *mapping, int sync_mode)
+static int __filemap_fdatawrite_range(struct address_space *mapping,
+	loff_t start, loff_t end, int sync_mode)
 {
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
+		.start = start,
+		.end = end,
 	};
 
 	if (mapping->backing_dev_info->memory_backed)
@@ -165,12 +171,25 @@ static int __filemap_fdatawrite(struct a
 	return ret;
 }
 
+static inline int __filemap_fdatawrite(struct address_space *mapping,
+	int sync_mode)
+{
+	return __filemap_fdatawrite_range(mapping, 0, 0, sync_mode);
+}
+
 int filemap_fdatawrite(struct address_space *mapping)
 {
 	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite);
 
+int filemap_fdatawrite_range(struct address_space *mapping,
+	loff_t start, loff_t end)
+{
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
+}
+EXPORT_SYMBOL(filemap_fdatawrite_range);
+
 /*
  * This is a mostly non-blocking flush.  Not suitable for data-integrity
  * purposes - I/O may not be started against all dirty pages.

_
