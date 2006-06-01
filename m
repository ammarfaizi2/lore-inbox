Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWFAStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWFAStk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWFAStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:49:40 -0400
Received: from ns1.suse.de ([195.135.220.2]:9190 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965226AbWFAStk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:49:40 -0400
Date: Thu, 1 Jun 2006 20:49:38 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060601184938.GA31376@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060530182453.GA8701@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This script will cause cramfs decompression errors, on SMP at least:

#!/bin/bash                                                                                                                                                          
while :;do blockdev --flushbufs /dev/loop0;done </dev/null &>/dev/null&
while :;do ps faxs  </dev/null &>/dev/null&done </dev/null &>/dev/null&
while :;do dmesg    </dev/null &>/dev/null&done </dev/null &>/dev/null&
while :;do find /mounts/instsys -type f -print0|xargs -0 cat &>/dev/null;done

(The used executables come from the symlinked /mounts/instsys directory)

...
Error -3 while decompressing!
c0000000009592a2(2649)->c0000000edf87000(4096)
Error -3 while decompressing!
c000000000959298(2520)->c0000000edbc7000(4096)
Error -3 while decompressing!
c000000000959c70(2489)->c0000000f1482000(4096) 
Error -3 while decompressing!
c00000000095a629(2355)->c0000000edaff000(4096)
Error -3 while decompressing!
...

Its a long standing bug, introduced in 2.6.2.

cramfs_read() clears parts of the src buffer because the page is not uptodate.
invalidate_bdev() called from block_ioctl(BLKFLSBUF) will set ClearPageUptodate()
after cramfs_read() got the page from read_cache_page()
If PageUptodate() fails, read the page again before using it.
There is still a small window were the page may not be uptodate before copying
its contents away.

evms_access does the BLKFLSBUF ioctl (lots of them) on the loop device. This will
corrupt the SuSE installation image on SMP kernels, leading to random segfaults.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/cramfs/inode.c |   70 ++++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

Index: linux-2.6.16.16-1.6/fs/cramfs/inode.c
===================================================================
--- linux-2.6.16.16-1.6.orig/fs/cramfs/inode.c
+++ linux-2.6.16.16-1.6/fs/cramfs/inode.c
@@ -147,8 +147,8 @@ static int next_buffer;
 static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
 {
 	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
-	struct page *pages[BLKS_PER_BUF];
-	unsigned i, blocknr, buffer, unread;
+	struct page *page;
+	unsigned i, blocknr, buffer, readagain;
 	unsigned long devsize;
 	char *data;
 
@@ -174,48 +174,42 @@ static void *cramfs_read(struct super_bl
 
 	devsize = mapping->host->i_size >> PAGE_CACHE_SHIFT;
 
-	/* Ok, read in BLKS_PER_BUF pages completely first. */
-	unread = 0;
-	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = NULL;
-
-		if (blocknr + i < devsize) {
-			page = read_cache_page(mapping, blocknr + i,
-				(filler_t *)mapping->a_ops->readpage,
-				NULL);
-			/* synchronous error? */
-			if (IS_ERR(page))
-				page = NULL;
-		}
-		pages[i] = page;
-	}
-
-	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = pages[i];
-		if (page) {
-			wait_on_page_locked(page);
-			if (!PageUptodate(page)) {
-				/* asynchronous error */
-				page_cache_release(page);
-				pages[i] = NULL;
-			}
-		}
-	}
-
 	buffer = next_buffer;
 	next_buffer = NEXT_BUFFER(buffer);
 	buffer_blocknr[buffer] = blocknr;
 	buffer_dev[buffer] = sb;
-
 	data = read_buffers[buffer];
+
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-		struct page *page = pages[i];
-		if (page) {
-			memcpy(data, kmap(page), PAGE_CACHE_SIZE);
-			kunmap(page);
-			page_cache_release(page);
-		} else
-			memset(data, 0, PAGE_CACHE_SIZE);
+		if (blocknr + i < devsize) {
+			page = NULL;
+			for (readagain = 0; readagain < 5; readagain++) {
+				page = read_cache_page(mapping, blocknr + i,
+					(filler_t *)mapping->a_ops->readpage,
+					NULL);
+				/* synchronous error? */
+				if (IS_ERR(page)) {
+					page = NULL;
+					break;
+				}
+				wait_on_page_locked(page);
+				if (PageUptodate(page))
+					break;
+				/* asynchronous error */
+				/* maybe BLKFLSBUF flushed the page */
+				page_cache_release(page);
+				page = NULL;
+			}
+			if (page) {
+				memcpy(data, kmap(page), PAGE_CACHE_SIZE);
+				kunmap(page);
+				page_cache_release(page);
+			} else
+				memset(data, 0, PAGE_CACHE_SIZE);
+			if (readagain)
+				printk(KERN_DEBUG "cramfs_read got %s Uptodate page after %d attempt(s)\n",
+						page ? "an" : "no", readagain);
+		}
 		data += PAGE_CACHE_SIZE;
 	}
 	return read_buffers[buffer] + offset;
