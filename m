Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWFAUKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWFAUKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWFAUKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:10:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:8582 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030273AbWFAUKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:10:54 -0400
Date: Thu, 1 Jun 2006 22:10:50 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060601201050.GA32221@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060601121200.457c0335.akpm@osdl.org>
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
@@ -140,6 +140,25 @@ static unsigned buffer_blocknr[READ_BUFF
 static struct super_block * buffer_dev[READ_BUFFERS];
 static int next_buffer;
 
+/* return a page in PageUptodate state, BLKFLSBUF may have flushed the page */
+static struct page *cramfs_read_cache_page(struct address_space *m, unsigned int n)
+{
+	struct page *page;
+	int readagain = 5;
+retry:
+	page = read_cache_page(m, n, (filler_t *)m->a_ops->readpage, NULL);
+	if (IS_ERR(page))
+		return NULL;
+	lock_page(page);
+	if (PageUptodate(page))
+		return page;
+	unlock_page(page);
+	page_cache_release(page);
+	if (readagain--)
+		goto retry;
+	return NULL;
+}
+
 /*
  * Returns a pointer to a buffer containing at least LEN bytes of
  * filesystem starting at byte offset OFFSET into the filesystem.
@@ -147,8 +166,8 @@ static int next_buffer;
 static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
 {
 	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
-	struct page *pages[BLKS_PER_BUF];
-	unsigned i, blocknr, buffer, unread;
+	struct page *page;
+	unsigned i, blocknr, buffer;
 	unsigned long devsize;
 	char *data;
 
@@ -174,48 +193,23 @@ static void *cramfs_read(struct super_bl
 
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
+			page = cramfs_read_cache_page(mapping, blocknr + i);
+			if (page) {
+				memcpy(data, kmap_atomic(page, KM_USER0), PAGE_CACHE_SIZE);
+				kunmap(page);
+				unlock_page(page);
+				page_cache_release(page);
+			} else
+				memset(data, 0, PAGE_CACHE_SIZE);
+		}
 		data += PAGE_CACHE_SIZE;
 	}
 	return read_buffers[buffer] + offset;
