Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319168AbSHTN4P>; Tue, 20 Aug 2002 09:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319169AbSHTN4P>; Tue, 20 Aug 2002 09:56:15 -0400
Received: from verein.lst.de ([212.34.181.86]:45324 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S319168AbSHTN4N>;
	Tue, 20 Aug 2002 09:56:13 -0400
Date: Tue, 20 Aug 2002 15:59:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: [bkpatch-2.5.7] Detect get_block() errors in block_read_full_page()
Message-ID: <20020820155949.A18507@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

any chance you could review the below patch for -pre5?


From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: [bkpatch-2.5.7] Detect get_block() errors in block_read_full_page()
Date: Sat, 23 Mar 2002 14:36:44 +0000 (GMT)

Linus,

Below patch causes errors from get_block() in block_read_full_page() to be
detected and handled properly (by setting page error flag). Without the
patch the page (or parts of the page) will contain random data on
get_block() failing without any form of error being signalled which
can be catastrophic for filesystems using block_read_full_page() for
accessing their metadata. And for normal data it would mean the user would
see random data instead of what they expected.

The patch works for me and the changes have been blessed by Andrea
Arcangeli.

Please apply.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

---------snip----------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.537   -> 1.538  
#	         fs/buffer.c	1.69    -> 1.70   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/23	aia21@cam.ac.uk	1.538
# Detect get_block() error return in fs/buffer.c::block_read_full_page() and
# set page error and don't set page uptodate.
# --------------------------------------------
#
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Sat Mar 23 14:23:26 2002
+++ b/fs/buffer.c	Sat Mar 23 14:23:26 2002
@@ -795,8 +795,11 @@
 	unlock_buffer(bh);
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
-		if (buffer_async(tmp) && buffer_locked(tmp))
-			goto still_busy;
+		if (buffer_locked(tmp)) {
+			if (buffer_async(tmp))
+				goto still_busy;
+		} else if (!buffer_uptodate(tmp))
+			SetPageError(page);
 		tmp = tmp->b_this_page;
 	}
 
@@ -1716,7 +1719,7 @@
 		if (!buffer_mapped(bh)) {
 			if (iblock < lblock) {
 				if (get_block(inode, iblock, bh, 0))
-					continue;
+					SetPageError(page);
 			}
 			if (!buffer_mapped(bh)) {
 				memset(kmap(page) + i*blocksize, 0, blocksize);
@@ -1736,10 +1739,11 @@
 
 	if (!nr) {
 		/*
-		 * all buffers are uptodate - we can set the page
-		 * uptodate as well.
+		 * All buffers are uptodate - we can set the page uptodate
+		 * as well. But not if get_block() returned an error.
 		 */
-		SetPageUptodate(page);
+		if (!PageError(page))
+			SetPageUptodate(page);
 		UnlockPage(page);
 		return 0;
 	}

