Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261913AbREQPA1>; Thu, 17 May 2001 11:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261918AbREQPAH>; Thu, 17 May 2001 11:00:07 -0400
Received: from smtpde03.sap-ag.de ([194.39.131.54]:959 "EHLO
	smtpde03.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261913AbREQPAF>; Thu, 17 May 2001 11:00:05 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] ramfs accounting in -ac broken
Organisation: SAP LinuxLab
Date: 17 May 2001 16:54:03 +0200
Message-ID: <m3ofsst4ac.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

The ramfs accounting is broken for shared mmaps. It simply does not
recognize the pages allocated by writing into a shared mapping but
takes them into account when freed.

The attached patch should fix that.

Greetings
		Christoph

--- 4-ac9/fs/ramfs/inode.c	Thu May 17 16:51:57 2001
+++ u4ac9/fs/ramfs/inode.c	Thu May 17 14:47:48 2001
@@ -163,9 +163,6 @@
 	struct ramfs_sb_info *rsb = RAMFS_SB(inode->i_sb);
 	int ret = 1;
 
-	if (PageDirty(page)) /* It's already been allocated */
-		return 1;
-
 	lock_rsb(rsb);
 		
 	if ( (rsb->free_pages > 0) &&
@@ -185,8 +182,7 @@
 {
 	struct ramfs_sb_info *rsb = RAMFS_SB(inode->i_sb);
 
-	if (! PageDirty(page)) /* The page was never allocated 
-				  this can happen if it was only read */
+	if (! Page_Uptodate(page))
 		return;
 
 	lock_rsb(rsb);
@@ -241,6 +237,8 @@
 static int ramfs_readpage(struct file *file, struct page * page)
 {
 	if (!Page_Uptodate(page)) {
+		if (!ramfs_alloc_page(file->f_dentry->d_inode, page))
+			return -ENOSPC;
 		memset(kmap(page), 0, PAGE_CACHE_SIZE);
 		kunmap(page);
 		flush_dcache_page(page);
@@ -266,11 +264,12 @@
 	struct inode *inode = (struct inode *)page->mapping->host;
 	void *addr;
 	
-	if (! ramfs_alloc_page(inode, page))
-		return -ENOSPC;
-
 	addr = (void *) kmap(page);
 	if (!Page_Uptodate(page)) {
+		if (! ramfs_alloc_page(inode, page)) {
+			kunmap(page);
+			return -ENOSPC;
+		}
 		memset(addr, 0, PAGE_CACHE_SIZE);
 		flush_dcache_page(page);
 		SetPageUptodate(page);

