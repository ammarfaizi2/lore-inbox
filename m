Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUHAHkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUHAHkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUHAHkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:40:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62686 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265429AbUHAHkB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:40:01 -0400
Date: Sun, 1 Aug 2004 13:19:35 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Fix writeback page range to use exact limits
Message-ID: <20040801074935.GB7327@in.ibm.com>
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

[2] fix-writeback-range.patch

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

---------------------------------------------------------------


wait_on_page_writeback_range shouldn't wait for pages beyond the
specified range. Ideally, the radix-tree-lookup could accept an
end_index parameter so that it doesn't return the extra pages
in the first place, but for now we just add a few extra checks
to skip such pages.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 linux-2.6.8-rc2-suparna/mm/filemap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN mm/filemap.c~fix-writeback-range mm/filemap.c
--- linux-2.6.8-rc2/mm/filemap.c~fix-writeback-range	2004-08-01 12:32:04.000000000 +0530
+++ linux-2.6.8-rc2-suparna/mm/filemap.c	2004-08-01 12:32:04.000000000 +0530
@@ -198,7 +198,8 @@ static int wait_on_page_writeback_range(
 
 	pagevec_init(&pvec, 0);
 	index = start;
-	while ((nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+	while ((index <= end) &&
+			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_WRITEBACK,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1)) != 0) {
 		unsigned i;
@@ -206,6 +207,10 @@ static int wait_on_page_writeback_range(
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
+			/* until radix tree lookup accepts end_index */
+			if (page->index > end) {
+				continue;
+			}
 			wait_on_page_writeback(page);
 			if (PageError(page))
 				ret = -EIO;

_
