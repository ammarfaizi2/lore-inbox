Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUHAHnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUHAHnC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUHAHnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:43:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51191 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265487AbUHAHlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:41:20 -0400
Date: Sun, 1 Aug 2004 13:20:52 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mpage writepages range limit fix
Message-ID: <20040801075052.GC7327@in.ibm.com>
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

[3] fix-writepages-range.patch

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

---------------------------------------------------------------

Safeguard to make sure we break out of pagevec_lookup_tag loop if we
are beyond the specified range.

Signed-off-by: Suparna Bhattacharya <suparna@in.ibm.com>

 linux-2.6.8-rc2-suparna/fs/mpage.c      |    3 ++-
 linux-2.6.8-rc2-suparna/fs/mpage.c.orig |    3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN fs/mpage.c~fix-writepages-range fs/mpage.c
--- linux-2.6.8-rc2/fs/mpage.c~fix-writepages-range	2004-08-01 12:33:10.000000000 +0530
+++ linux-2.6.8-rc2-suparna/fs/mpage.c	2004-08-01 12:33:10.000000000 +0530
@@ -649,7 +649,8 @@ mpage_writepages(struct address_space *m
 		scanned = 1;
 	}
 retry:
-	while (!done && (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+	while (!done && (index <= end) &&
+			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_DIRTY,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;
diff -puN fs/mpage.c.orig~fix-writepages-range fs/mpage.c.orig
--- linux-2.6.8-rc2/fs/mpage.c.orig~fix-writepages-range	2004-08-01 12:33:10.000000000 +0530
+++ linux-2.6.8-rc2-suparna/fs/mpage.c.orig	2004-08-01 12:32:43.000000000 +0530
@@ -649,8 +649,7 @@ mpage_writepages(struct address_space *m
 		scanned = 1;
 	}
 retry:
-	while (!done && (index <= end) && 
-			(nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+	while (!done && (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
 			PAGECACHE_TAG_DIRTY,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1))) {
 		unsigned i;

_
