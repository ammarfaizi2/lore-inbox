Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264866AbUDWQst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbUDWQst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbUDWQst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:48:49 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:14543 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S264866AbUDWQsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:48:43 -0400
Date: Fri, 23 Apr 2004 12:46:43 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH] cramfs use pagecache
Cc: linux-kernel@vger.kernel.org
Message-id: <40894873.1060401@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------090302040000090709020804
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090302040000090709020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(sending again cause I messed up the lkml addr)
i
Hi Al,

We recently hit a problem when we wanted to have both cramfs and minix
support built-in.  If we tried to mount a minix filesystem from ramdisk,
depending on link order, cramfs would be tried first, and it would
invalidate the pagecache in an attempt to set_blocksize.

I saw you fixed this in 2.6, and I backported the fix to 2.4.  If this
looks good, could this get applied to the 2.4 tree?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQFAiUhydQs4kOxk3/MRAtATAJ0T98a+DpYiTDAPLsX2j4EmEOESCQCWP1Vr
ElkL7Hz6vX2BYRxlCcOrrQ==
=yKtF
-----END PGP SIGNATURE-----

--------------090302040000090709020804
Content-Type: text/x-patch;
 name="p_cramfs_use_pagecache.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p_cramfs_use_pagecache.diff"

--- linux-2.4.24/fs/cramfs/inode.c	2002-08-02 17:39:45.000000000 -0700
+++ linux-2.4.24-cramfs/fs/cramfs/inode.c	2004-04-16 05:48:42.000000000 -0700
@@ -111,8 +111,8 @@ static int next_buffer;
  */
 static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
 {
-	struct buffer_head * bh_array[BLKS_PER_BUF];
-	struct buffer_head * read_array[BLKS_PER_BUF];
+	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct page *pages[BLKS_PER_BUF];
 	unsigned i, blocknr, buffer, unread;
 	unsigned long devsize;
 	int major, minor;
@@ -139,7 +139,7 @@ static void *cramfs_read(struct super_bl
 		return read_buffers[i] + blk_offset;
 	}
 
-	devsize = ~0UL;
+	devsize = mapping->host->i_size >> PAGE_CACHE_SHIFT;
 	major = MAJOR(sb->s_dev);
 	minor = MINOR(sb->s_dev);
 
@@ -149,26 +149,31 @@ static void *cramfs_read(struct super_bl
 	/* Ok, read in BLKS_PER_BUF pages completely first. */
 	unread = 0;
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct buffer_head *bh;
+		struct page *page = NULL;
 
-		bh = NULL;
 		if (blocknr + i < devsize) {
-			bh = sb_getblk(sb, blocknr + i);
-			if (!buffer_uptodate(bh))
-				read_array[unread++] = bh;
+			page = read_cache_page(mapping, blocknr + i,
+				(filler_t *)mapping->a_ops->readpage,
+				NULL);
+			/* synchronous error? */
+			if (IS_ERR(page))
+				page = NULL;
 		}
-		bh_array[i] = bh;
+		pages[i] = page;
 	}
 
-	if (unread) {
-		ll_rw_block(READ, unread, read_array);
-		do {
-			unread--;
-			wait_on_buffer(read_array[unread]);
-		} while (unread);
+	for (i = 0; i < BLKS_PER_BUF; i++) {
+		struct page *page = pages[i];
+		if (page) {
+			wait_on_page(page);
+			if (!Page_Uptodate(page)) {
+				/* asynchronous error */
+				page_cache_release(page);
+				pages[i] = NULL;
+			}
+		}
 	}
-
-	/* Ok, copy them to the staging area without sleeping. */
+		
 	buffer = next_buffer;
 	next_buffer = NEXT_BUFFER(buffer);
 	buffer_blocknr[buffer] = blocknr;
@@ -176,10 +181,11 @@ static void *cramfs_read(struct super_bl
 
 	data = read_buffers[buffer];
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct buffer_head * bh = bh_array[i];
-		if (bh) {
-			memcpy(data, bh->b_data, PAGE_CACHE_SIZE);
-			brelse(bh);
+		struct page *page = pages[i];
+		if (page) {
+			memcpy(data, kmap(page), PAGE_CACHE_SIZE);
+			kunmap(page);
+			page_cache_release(page);
 		} else
 			memset(data, 0, PAGE_CACHE_SIZE);
 		data += PAGE_CACHE_SIZE;
@@ -195,10 +201,6 @@ static struct super_block * cramfs_read_
 	unsigned long root_offset;
 	struct super_block * retval = NULL;
 
-	set_blocksize(sb->s_dev, PAGE_CACHE_SIZE);
-	sb->s_blocksize = PAGE_CACHE_SIZE;
-	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-
 	/* Invalidate the read buffers on mount: think disk change.. */
 	for (i = 0; i < READ_BUFFERS; i++)
 		buffer_blocknr[i] = -1;


--------------090302040000090709020804--
