Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVHEOsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVHEOsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVHEOsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:48:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1234 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262292AbVHEOrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:47:42 -0400
Date: Fri, 5 Aug 2005 16:49:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, karim@opersys.com,
       prasadav@us.ibm.com
Subject: Re: [-mm patch] relayfs: add read() support
Message-ID: <20050805144926.GS5561@suse.de>
References: <17138.53203.430849.147593@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17138.53203.430849.147593@tut.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04 2005, Tom Zanussi wrote:
> At the kernel summit, there was some discussion of relayfs and the
> consensus was that it didn't make sense for relayfs to not implement
> read().  So here's a read implementation...

It needs a few fixes to actually compile without errors. This works for
me, just tested with the block tracing stuff, works a charm!


diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc4-mm1/fs/relayfs/inode.c linux-2.6.13-rc4-mm1/fs/relayfs/inode.c
--- /opt/kernel/linux-2.6.13-rc4-mm1/fs/relayfs/inode.c	2005-08-05 16:47:57.000000000 +0200
+++ linux-2.6.13-rc4-mm1/fs/relayfs/inode.c	2005-08-05 16:45:38.000000000 +0200
@@ -33,6 +33,8 @@ static struct backing_dev_info		relayfs_
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
+struct file_operations relayfs_file_operations;
+
 static struct inode *relayfs_get_inode(struct super_block *sb, int mode,
 				       struct rchan *chan)
 {
@@ -370,7 +372,7 @@ static inline unsigned int relayfs_read_
  *	
  */
 static inline unsigned int relayfs_read_avail(struct rchan_buf *buf,
-					      unsigned int *start_subbuf)
+					      size_t *start_subbuf)
 {
 	unsigned int avail, complete_subbufs, cur_subbuf, buf_offset;
 	unsigned int subbuf_size = buf->chan->subbuf_size;
@@ -378,12 +380,12 @@ static inline unsigned int relayfs_read_
 
 	buf_offset = buf->offset > subbuf_size ? subbuf_size : buf->offset;
 	
-	if (buf->subbufs_produced >= n_subbufs) {
+	if (atomic_read(&buf->subbufs_produced) >= n_subbufs) {
 		complete_subbufs = n_subbufs - 1;
 		cur_subbuf = (buf->data - buf->start) / subbuf_size;
 		*start_subbuf = (cur_subbuf + 1) % n_subbufs;
 	} else {
-		complete_subbufs = buf->subbufs_produced;
+		complete_subbufs = atomic_read(&buf->subbufs_produced);
 		*start_subbuf = 0;
 	}
 	
@@ -416,8 +418,8 @@ static ssize_t relayfs_read(struct file 
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
-	unsigned int read_start, read_end, avail, start_subbuf;
-	unsigned int buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
+	size_t read_start, read_end, avail, start_subbuf;
+	size_t buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
 	void *from;
 
 	avail = relayfs_read_avail(buf, &start_subbuf);
diff -urp -X /home/axboe/cdrom/exclude /opt/kernel/linux-2.6.13-rc4-mm1/include/linux/relayfs_fs.h linux-2.6.13-rc4-mm1/include/linux/relayfs_fs.h
--- /opt/kernel/linux-2.6.13-rc4-mm1/include/linux/relayfs_fs.h	2005-08-05 16:47:44.000000000 +0200
+++ linux-2.6.13-rc4-mm1/include/linux/relayfs_fs.h	2005-08-05 16:45:47.000000000 +0200
@@ -253,15 +253,5 @@ static inline void *relay_reserve(struct
 	return reserved;
 }
 
-/*
- * exported relayfs file operations, fs/relayfs/inode.c
- */
-
-extern struct file_operations relayfs_file_operations;
-extern int relayfs_open(struct inode *inode, struct file *filp);
-extern unsigned int relayfs_poll(struct file *filp, poll_table *wait);
-extern int relayfs_mmap(struct file *filp, struct vm_area_struct *vma);
-extern int relayfs_release(struct inode *inode, struct file *filp);
-
 #endif /* _LINUX_RELAYFS_FS_H */
 


-- 
Jens Axboe

