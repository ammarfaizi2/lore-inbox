Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWFBTOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWFBTOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFBTOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:14:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:23513 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932354AbWFBTOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:14:33 -0400
Date: Fri, 2 Jun 2006 21:14:30 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060602191430.GA9357@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org> <20060601201050.GA32221@suse.de> <20060601142400.1352f903.akpm@osdl.org> <20060601214158.GA438@suse.de> <20060601145747.274df976.akpm@osdl.org> <20060602084327.GA3964@suse.de> <20060602021115.e42ad5dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060602021115.e42ad5dd.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jun 02, Andrew Morton wrote:

> I'd suggest you run SetPagePrivate() and SetPageChecked() on the locked
> page and implement a_ops.releasepage(), which will fail if PageChecked(),
> and will succeed otherwise:
> 
> /*
>  * cramfs_releasepage() will fail if cramfs_read() set PG_checked.  This
>  * is so that invalidate_inode_pages() cannot zap the page while
>  * cramfs_read() is trying to get at its contents.
>  */
> cramfs_releasepage(...)
> {
> 	if (PageChecked(page))
> 		return 0;
> 	return 1;
> }

This function is not triggered in my testing.

> cramfs_read(...)
> {
> 	lock_page(page);
> 	SetPagePrivate(page);
> 	SetPageChecked(page);
> 	read_mapping_page(...);
> 	lock_page(page);
> 	if (page->mapping == NULL) {
> 		/* truncate got there first */
> 		unlock_page(page);
> 		bale();
> 	}
> 	memcpy();
> 	ClearPageChecked(page);
> 	ClearPagePrivate(page);
> 	unlock_page(page);
> }

recursive recursion? Where is page supposed to come from? Did you mean
to call all this with a page returned from read_mapping_page(), and
call read_mapping_page() twice?

My version seems to leak memory somehow, Inactive and slab buffer_head
keeps growing. I guess something is missing in the picture.

Doesnt read_cache_page lock the page already?
read_cache_page
  __read_cache_page
    add_to_page_cache_lru
      add_to_page_cache
        SetPageLocked

--- /tmp/meminfo-1149269715     2006-06-02 13:35:15.439683381 -0400
+++ x   2006-06-02 13:53:20.379683381 -0400
@@ -1,23 +1,23 @@
 MemTotal:      3952952 kB
-MemFree:       3395708 kB
+MemFree:       2966276 kB
 Buffers:             0 kB
-Cached:         328960 kB
+Cached:         326904 kB
 SwapCached:          0 kB
-Active:         366884 kB
-Inactive:       111496 kB
+Active:         381720 kB
+Inactive:       518188 kB
 HighTotal:           0 kB
 HighFree:            0 kB
 LowTotal:      3952952 kB
-LowFree:       3395708 kB
+LowFree:       2966276 kB
 SwapTotal:           0 kB
 SwapFree:            0 kB
 Dirty:               0 kB
 Writeback:           0 kB
-Mapped:          56320 kB
-Slab:            60608 kB
+Mapped:          60440 kB
+Slab:            68704 kB
 CommitLimit:   1976476 kB
-Committed_AS:   155304 kB
-PageTables:       1216 kB
+Committed_AS:   158780 kB
+PageTables:       1112 kB
 VmallocTotal: 8589934592 kB
 VmallocUsed:      2452 kB
 VmallocChunk: 8589932068 kB


diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 9efcc3a..1266b8e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -141,6 +141,35 @@ static unsigned buffer_blocknr[READ_BUFF
 static struct super_block * buffer_dev[READ_BUFFERS];
 static int next_buffer;
 
+static void cramfs_read_putpage(struct page *page)
+{
+	ClearPageChecked(page);
+	ClearPagePrivate(page);
+	unlock_page(page);
+	page_cache_release(page);
+}
+
+/* return a page in PageUptodate state, BLKFLSBUF may have flushed the page */
+static struct page *cramfs_read_getpage(struct address_space *m, unsigned int n)
+{
+	struct page *page;
+	int readagain = 5;
+retry:
+	page = read_cache_page(m, n, (filler_t *)m->a_ops->readpage, NULL);
+	if (IS_ERR(page))
+		return NULL;
+	lock_page(page);
+	SetPagePrivate(page);
+	SetPageChecked(page);
+	if (PageUptodate(page))
+		return page;
+	cramfs_read_putpage(page);
+	printk("cramfs_read_getpage %d %p\n", 5 - readagain + 1, page);
+	if (readagain--)
+		goto retry;
+	return NULL;
+}
+
 /*
  * Returns a pointer to a buffer containing at least LEN bytes of
  * filesystem starting at byte offset OFFSET into the filesystem.
@@ -148,8 +177,8 @@ static int next_buffer;
 static void *cramfs_read(struct super_block *sb, unsigned int offset, unsigned int len)
 {
 	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
-	struct page *pages[BLKS_PER_BUF];
-	unsigned i, blocknr, buffer, unread;
+	struct page *page;
+	unsigned i, blocknr, buffer;
 	unsigned long devsize;
 	char *data;
 
@@ -175,48 +204,22 @@ static void *cramfs_read(struct super_bl
 
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
+			page = cramfs_read_getpage(mapping, blocknr + i);
+			if (page) {
+				memcpy(data, kmap_atomic(page, KM_USER0), PAGE_CACHE_SIZE);
+				kunmap_atomic(page, KM_USER0);
+				cramfs_read_putpage(page);
+			} else
+				memset(data, 0, PAGE_CACHE_SIZE);
+		}
 		data += PAGE_CACHE_SIZE;
 	}
 	return read_buffers[buffer] + offset;
@@ -501,8 +504,19 @@ static int cramfs_readpage(struct file *
 	return 0;
 }
 
+static int cramfs_releasepage(struct page *page, gfp_t mask)
+{
+	int ret = -ENOENT;
+	if (page)
+		ret = !PageChecked(page);
+	printk("cramfs_releasepage called for page %p checked %d\n", page, ret);
+	WARN_ON(1);
+	return ret;
+}
+
 static struct address_space_operations cramfs_aops = {
-	.readpage = cramfs_readpage
+	.readpage = cramfs_readpage,
+	.releasepage = cramfs_releasepage,
 };
 
 /*
