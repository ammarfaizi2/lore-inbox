Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVASLWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVASLWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVASLWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:22:16 -0500
Received: from verein.lst.de ([213.95.11.210]:6100 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261692AbVASLWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:22:12 -0500
Date: Wed, 19 Jan 2005 12:21:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add page_offset to mm.h
Message-ID: <20050119112157.GA10585@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To convert page->index to a byte index you need to cast it to loff_t
first so it's a 64bit value.  There have been quite a few places that
got it wrong in the kernel.  To make it easier a nice little helper
would be nice, and in fact the NFS code already has it.  Let's move it
to pagemap.h so everyone can use it.


--- 1.92/include/linux/nfs_fs.h	2005-01-04 01:00:00 +01:00
+++ edited/include/linux/nfs_fs.h	2005-01-19 11:40:42 +01:00
@@ -254,12 +254,6 @@
 	return NFS_FLAGS(inode) & NFS_INO_ADVISE_RDPLUS;
 }
 
-static inline
-loff_t page_offset(struct page *page)
-{
-	return ((loff_t)page->index) << PAGE_CACHE_SHIFT;
-}
-
 /**
  * nfs_save_change_attribute - Returns the inode attribute change cookie
  * @inode - pointer to inode
--- 1.44/include/linux/pagemap.h	2004-08-27 08:31:38 +02:00
+++ edited/include/linux/pagemap.h	2005-01-19 11:42:59 +01:00
@@ -143,6 +143,14 @@
 	return ret;
 }
 
+/*
+ * Return byte-offset into filesystem object for page.
+ */
+static inline loff_t page_offset(struct page *page)
+{
+	return ((loff_t)page->index) << PAGE_CACHE_SHIFT;
+}
+
 static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
