Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273144AbRI0Oxg>; Thu, 27 Sep 2001 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273131AbRI0Ox1>; Thu, 27 Sep 2001 10:53:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56583 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S273144AbRI0OxV>;
	Thu, 27 Sep 2001 10:53:21 -0400
Date: Thu, 27 Sep 2001 15:53:47 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: rd.c -- still buggy in 2.4.10?
Message-ID: <20010927155347.C16096@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't tried the rd.c from 2.4.10 on a PA machine yet, but it seems
to me it's still buggy.  Because we have such a huge dcache on PA, we're
perhaps more vulnerable to the problem than anyone else.  We needed the
following patch in our tree (originally by John Marvin, rewritten by me):

--- linux-249/drivers/block/rd.c        Mon Jul 23 04:37:30 2001
+++ linux-pa/drivers/block/rd.c Wed Sep 26 16:28:59 2001
@@ -227,8 +227,10 @@
 	*/
        bdata = bh_kmap(sbh);
        if (rw == READ) {
-               if (sbh != rbh)
+               if (sbh != rbh) {
                        memcpy(bdata, rbh->b_data, rbh->b_size);
+                       flush_dcache_page(sbh->b_page);
+               }
        } else
                if (sbh != rbh)
                        memcpy(rbh->b_data, bdata, rbh->b_size);

The equivalent bit in the 2.4.10 driver would seem to be in
rd_blkdev_pagecache_IO, and there's no flush_dcache_page after the memcpy.
There is one _earlier_, where page is memset, which seems spurious to me.

How about a patch along these lines?

--- linux-2410/drivers/block/rd.c	Thu Sep 27 08:32:39 2001
+++ linux-2410-rd/drivers/block/rd.c	Thu Sep 27 08:35:34 2001
@@ -276,7 +276,6 @@ static int rd_blkdev_pagecache_IO(int rw
 			if (!Page_Uptodate(page)) {
 				memset(kmap(page), 0, PAGE_CACHE_SIZE);
 				kunmap(page);
-				flush_dcache_page(page);
 				SetPageUptodate(page);
 			}
 
@@ -301,8 +300,11 @@ static int rd_blkdev_pagecache_IO(int rw
 		kunmap(page);
 		bh_kunmap(sbh);
 
-		if (rw != READ)
+		if (rw == READ) {
+			flush_dcache_page(page);
+		} else {
 			SetPageDirty(page);
+		}
 		if (unlock)
 			UnlockPage(page);
 		__free_page(page);


By the way, Documentation/cachetlb.txt does not mention how kunmap and
flush_dcache_page should be ordered.  In rd.c, pages are kunmapped before
they are flushed.  This seems unwise for any architecture where you need
the virtual address which was written to for the flush to work.  If we
implemented kmap/kunmap on parisc, we'd have this problem.  Fortunately,
HP managed to release 64-bit processors before shipping any machines
which could be fitted with more than 3GB of RAM.  Is this a merely
theoretical issue, or does any architecture have problems with this?

-- 
Revolutions do not require corporate support.
