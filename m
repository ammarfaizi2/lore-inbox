Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUCDHFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUCDHFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:05:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:26038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261524AbUCDHEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:04:50 -0500
Date: Wed, 3 Mar 2004 23:04:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: linux-kernel@vger.kernel.org, lbd@gelato.unsw.edu.au,
       neilb@cse.unsw.edu.au
Subject: Re: [PATCH] LBD fix for 2.6.3
Message-Id: <20040303230452.6854c830.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0403040001460.24142-100000@stout.americas.sgi.com>
References: <Pine.LNX.4.44.0403040001460.24142-100000@stout.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen <sandeen@sgi.com> wrote:
>
> -	unsigned long block;
>  -	unsigned long last_block;
>  +	sector_t block;
>  +	sector_t last_block;

egads.  That bug has been there from day one.  CONFIG_LBD cannot possibly
work correctly due to this error.

Thanks.

Actually, there more instances of this bug in buffer.c.  This should fix them
up, and also let's be clearer about discriminating between block numbers,
pagecache indices and offsets-within-pages.


diff -puN fs/buffer.c~writepage-lbd-fix fs/buffer.c
--- 25/fs/buffer.c~writepage-lbd-fix	2004-03-03 22:53:48.000000000 -0800
+++ 25-akpm/fs/buffer.c	2004-03-03 23:02:39.000000000 -0800
@@ -404,7 +404,7 @@ __find_get_block_slow(struct block_devic
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
 	struct buffer_head *ret = NULL;
-	unsigned long index;
+	pgoff_t index;
 	struct buffer_head *bh;
 	struct buffer_head *head;
 	struct page *page;
@@ -1125,8 +1125,8 @@ init_page_buffers(struct page *page, str
  * This is user purely for blockdev mappings.
  */
 static struct page *
-grow_dev_page(struct block_device *bdev, unsigned long block,
-			unsigned long index, int size)
+grow_dev_page(struct block_device *bdev, sector_t block,
+		pgoff_t index, int size)
 {
 	struct inode *inode = bdev->bd_inode;
 	struct page *page;
@@ -1182,10 +1182,10 @@ failed:
  * grow_dev_page() will go BUG() if this happens.
  */
 static inline int
-grow_buffers(struct block_device *bdev, unsigned long block, int size)
+grow_buffers(struct block_device *bdev, sector_t block, int size)
 {
 	struct page *page;
-	unsigned long index;
+	pgoff_t index;
 	int sizebits;
 
 	/* Size must be multiple of hard sectorsize */
@@ -1742,8 +1742,8 @@ static int __block_write_full_page(struc
 			get_block_t *get_block, struct writeback_control *wbc)
 {
 	int err;
-	unsigned long block;
-	unsigned long last_block;
+	sector_t block;
+	sector_t last_block;
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
 
@@ -2211,7 +2211,7 @@ int cont_prepare_write(struct page *page
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
 	struct page *new_page;
-	unsigned long pgpos;
+	pgoff_t pgpos;
 	long status;
 	unsigned zerofrom;
 	unsigned blocksize = 1 << inode->i_blkbits;
@@ -2516,9 +2516,11 @@ EXPORT_SYMBOL(nobh_truncate_page);
 int block_truncate_page(struct address_space *mapping,
 			loff_t from, get_block_t *get_block)
 {
-	unsigned long index = from >> PAGE_CACHE_SHIFT;
+	pgoff_t index = from >> PAGE_CACHE_SHIFT;
 	unsigned offset = from & (PAGE_CACHE_SIZE-1);
-	unsigned blocksize, iblock, length, pos;
+	unsigned blocksize;
+	pgoff_t iblock;
+	unsigned length, pos;
 	struct inode *inode = mapping->host;
 	struct page *page;
 	struct buffer_head *bh;
@@ -2598,7 +2600,7 @@ int block_write_full_page(struct page *p
 {
 	struct inode * const inode = page->mapping->host;
 	loff_t i_size = i_size_read(inode);
-	const unsigned long end_index = i_size >> PAGE_CACHE_SHIFT;
+	const pgoff_t end_index = i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
 	void *kaddr;
 

_

