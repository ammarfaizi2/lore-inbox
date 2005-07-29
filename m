Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVG2K6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVG2K6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVG2K4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:56:31 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:47372 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262589AbVG2KzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:55:14 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] fuse: don't update file times
Message-Id: <E1DySW2-0004pl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Jul 2005 12:54:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't change mtime/ctime/atime to local time on read/write.  Rather
invalidate file attributes, so next stat() will force a GETATTR call.
Bug reported by Ben Grimm.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.13-rc3-mm3/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.13-rc3-mm3/fs/fuse/dir.c	2005-07-29 10:56:57.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-07-29 10:36:59.000000000 +0200
@@ -552,6 +552,7 @@ static int fuse_readdir(struct file *fil
 				    filldir);
 
 	__free_page(page);
+	fuse_invalidate_attr(inode); /* atime changed */
 	return err;
 }
 
@@ -585,6 +586,7 @@ static char *read_link(struct dentry *de
 		link[req->out.args[0].size] = '\0';
  out:
 	fuse_put_request(fc, req);
+	fuse_invalidate_attr(inode); /* atime changed */
 	return link;
 }
 
diff -rup linux-2.6.13-rc3-mm3/fs/fuse/file.c linux-fuse/fs/fuse/file.c
--- linux-2.6.13-rc3-mm3/fs/fuse/file.c	2005-07-29 10:56:57.000000000 +0200
+++ linux-fuse/fs/fuse/file.c	2005-07-29 10:36:59.000000000 +0200
@@ -240,6 +240,7 @@ static int fuse_readpage(struct file *fi
 	fuse_put_request(fc, req);
 	if (!err)
 		SetPageUptodate(page);
+	fuse_invalidate_attr(inode); /* atime changed */
  out:
 	unlock_page(page);
 	return err;
@@ -308,6 +309,7 @@ static int fuse_readpages(struct file *f
 	if (!err && data.req->num_pages)
 		err = fuse_send_readpages(data.req, file, inode);
 	fuse_put_request(fc, data.req);
+	fuse_invalidate_attr(inode); /* atime changed */
 	return err;
 }
 
@@ -376,8 +378,8 @@ static int fuse_commit_write(struct file
 			clear_page_dirty(page);
 			SetPageUptodate(page);
 		}
-	} else if (err == -EINTR || err == -EIO)
-		fuse_invalidate_attr(inode);
+	}
+	fuse_invalidate_attr(inode);
 	return err;
 }
 
@@ -469,8 +471,8 @@ static ssize_t fuse_direct_io(struct fil
 		if (write && pos > i_size_read(inode))
 			i_size_write(inode, pos);
 		*ppos = pos;
-	} else if (write && (res == -EINTR || res == -EIO))
-		fuse_invalidate_attr(inode);
+	}
+	fuse_invalidate_attr(inode);
 
 	return res;
 }
diff -rup linux-2.6.13-rc3-mm3/fs/fuse/inode.c linux-fuse/fs/fuse/inode.c
--- linux-2.6.13-rc3-mm3/fs/fuse/inode.c	2005-07-29 11:01:10.000000000 +0200
+++ linux-fuse/fs/fuse/inode.c	2005-07-29 10:36:59.000000000 +0200
@@ -169,6 +173,7 @@ struct inode *fuse_iget(struct super_blo
 		return NULL;
 
 	if ((inode->i_state & I_NEW)) {
+		inode->i_flags |= S_NOATIME|S_NOCMTIME;
 		inode->i_generation = generation;
 		inode->i_data.backing_dev_info = &fc->bdi;
 		fuse_init_inode(inode, attr);
