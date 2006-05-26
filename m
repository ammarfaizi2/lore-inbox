Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWEZOYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWEZOYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEZOWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34249 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750789AbWEZOWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:22:02 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 7/10] Remove extraneous read of inode size from header
Message-Id: <E1FjdCG-00033d-N5@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig pointed out that the inode is not live at this point
in ecryptfs_open(), and so this entire function is pointless.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/file.c |   47 +----------------------------------------------
 1 files changed, 1 insertions(+), 46 deletions(-)

35776954e1116224272c4e191aed9a85b63914f7
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 0284e16..b8fcd0a 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -189,49 +189,6 @@ retry:
 	return rc;
 }
 
-/**
- * read_inode_size_from_header
- * @lower_file: The lower file struct
- * @lower_inode: The lower inode
- * @inode: The ecryptfs inode
- *
- * Returns zero on success; non-zero otherwise
- */
-static int
-read_inode_size_from_header(struct file *lower_file,
-			    struct inode *lower_inode, struct inode *inode)
-{
-	int rc;
-	struct page *header_page;
-	unsigned char *header_virt;
-	u64 data_size;
-
-	header_page = grab_cache_page(lower_inode->i_mapping, 0);
-	if (!header_page) {
-		rc = -EINVAL;
-		ecryptfs_printk(KERN_ERR, "grab_cache_page for header page "
-				"failed\n");
-		goto out;
-	}
-	header_virt = kmap(header_page);
-	rc = lower_inode->i_mapping->a_ops->readpage(lower_file, header_page);
-	if (rc) {
-		ecryptfs_printk(KERN_ERR, "Error reading header page\n");
-		goto out_unmap;
-	}
-	memcpy(&data_size, header_virt, sizeof(data_size));
-	data_size = be64_to_cpu(data_size);
-	i_size_write(inode, (loff_t)data_size);
-	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = [0x%.16x] "
-			"size: [0x%.16x]\n", inode, inode->i_ino,
-			i_size_read(inode));
-out_unmap:
-	kunmap(header_page);
-	page_cache_release(header_page);
-out:
-	return rc;
-}
-
 struct kmem_cache *ecryptfs_file_info_cache;
 
 /**
@@ -320,9 +277,7 @@ static int ecryptfs_open(struct inode *i
 			 * going to default to -EIO. */
 			rc = -EIO;
 			goto out_puts;
-		} else
-			read_inode_size_from_header(lower_file, lower_inode,
-						    inode);
+		}
 	}
 	ecryptfs_printk(KERN_DEBUG, "inode w/ addr = [0x%p], i_ino = [0x%.16x] "
 			"size: [0x%.16x]\n", inode, inode->i_ino,
-- 
1.3.3

