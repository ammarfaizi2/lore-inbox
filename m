Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSHJJmu>; Sat, 10 Aug 2002 05:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHJJmu>; Sat, 10 Aug 2002 05:42:50 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:43150 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316750AbSHJJms> convert rfc822-to-8bit; Sat, 10 Aug 2002 05:42:48 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Neukum <oliver@neukum.name>
To: viro@math.psu.edu (Alexander Viro)
Subject: hfs cleanup #2 - use page cache for read&write
Date: Sat, 10 Aug 2002 11:45:52 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208101145.52948.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this switches to generic_file_read/generic_file_write.
It survived light testing up to now.
Many thanks to the people who wrote address operations
for hfs already.

Any objections?

	Regards
		Oliver


diff -Nru a/fs/hfs/file.c b/fs/hfs/file.c
--- a/fs/hfs/file.c	Sat Aug 10 11:42:24 2002
+++ b/fs/hfs/file.c	Sat Aug 10 11:42:24 2002
@@ -25,18 +25,14 @@
 
 /*================ Forward declarations ================*/
 
-static hfs_rwret_t hfs_file_read(struct file *, char *, hfs_rwarg_t,
-				 loff_t *);
-static hfs_rwret_t hfs_file_write(struct file *, const char *, hfs_rwarg_t,
-				  loff_t *);
 static void hfs_file_truncate(struct inode *);
 
 /*================ Global variables ================*/
 
 struct file_operations hfs_file_operations = {
 	llseek:		generic_file_llseek,
-	read:		hfs_file_read,
-	write:		hfs_file_write,
+	read:		generic_file_read,
+	write:		generic_file_write,
 	mmap:		generic_file_mmap,
 	fsync:		file_fsync,
 };
@@ -128,91 +124,6 @@
 	return -ENOSPC;
 }
 
-
-/*
- * hfs_file_read()
- *
- * This is the read field in the inode_operations structure for
- * "regular" (non-header) files.  The purpose is to transfer up to
- * 'count' bytes from the file corresponding to 'inode', beginning at
- * 'filp->offset' bytes into the file.	The data is transferred to
- * user-space at the address 'buf'.  Returns the number of bytes
- * successfully transferred.  This function checks the arguments, does
- * some setup and then calls hfs_do_read() to do the actual transfer.  */
-static hfs_rwret_t hfs_file_read(struct file * filp, char * buf, 
-				 hfs_rwarg_t count, loff_t *ppos)
-{
-        struct inode *inode = filp->f_dentry->d_inode;
-	hfs_s32 read, left, pos, size;
-
-	if (!S_ISREG(inode->i_mode)) {
-		hfs_warn("hfs_file_read: mode = %07o\n",inode->i_mode);
-		return -EINVAL;
-	}
-	pos = *ppos;
-	if (pos >= HFS_FORK_MAX) {
-		return 0;
-	}
-	size = inode->i_size;
-	if (pos > size) {
-		left = 0;
-	} else {
-		left = size - pos;
-	}
-	if (left > count) {
-		left = count;
-	}
-	if (left <= 0) {
-		return 0;
-	}
-	if ((read = hfs_do_read(inode, HFS_I(inode)->fork, pos, buf, left)) > 0) {
-	        *ppos += read;
-	}
-
-	return read;
-}
-
-/*
- * hfs_file_write()
- *
- * This is the write() entry in the file_operations structure for
- * "regular" files.  The purpose is to transfer up to 'count' bytes
- * to the file corresponding to 'inode' beginning at offset
- * 'file->f_pos' from user-space at the address 'buf'.  The return
- * value is the number of bytes actually transferred.
- */
-static hfs_rwret_t hfs_file_write(struct file * filp, const char * buf,
-				  hfs_rwarg_t count, loff_t *ppos)
-{
-        struct inode    *inode = filp->f_dentry->d_inode;
-	struct hfs_fork *fork = HFS_I(inode)->fork;
-	hfs_s32 written, pos;
-
-	if (!S_ISREG(inode->i_mode)) {
-		hfs_warn("hfs_file_write: mode = %07o\n", inode->i_mode);
-		return -EINVAL;
-	}
-
-	pos = (filp->f_flags & O_APPEND) ? inode->i_size : *ppos;
-
-	if (pos >= HFS_FORK_MAX) {
-		return 0;
-	}
-	if (count > HFS_FORK_MAX) {
-		count = HFS_FORK_MAX;
-	}
-	if ((written = hfs_do_write(inode, fork, pos, buf, count)) > 0)
-	        pos += written;
-
-	*ppos = pos;
-	if (*ppos > inode->i_size) {
-	        inode->i_size = *ppos;
-		mark_inode_dirty(inode);
-	}
-
-	return written;
-}
-
 /*
  * hfs_file_truncate()
  *
@@ -237,40 +148,6 @@
 	unlock_kernel();
 }
 
-/*
- * xlate_to_user()
- *
- * Like copy_to_user() while translating CR->NL.
- */
-static inline void xlate_to_user(char *buf, const char *data, int count)
-{
-	char ch;
-
-	while (count--) {
-		ch = *(data++);
-		put_user((ch == '\r') ? '\n' : ch, buf++);
-	}
-}
-
-/*
- * xlate_from_user()
- *
- * Like copy_from_user() while translating NL->CR;
- */
-static inline int xlate_from_user(char *data, const char *buf, int count)
-{
-	int i;
-
-	i = copy_from_user(data, buf, count);
-	count -= i;
-	while (count--) {
-		if (*data == '\n') {
-			*data = '\r';
-		}
-		++data;
-	}
-	return i;
-}
 
 /*================ Global functions ================*/
 
@@ -286,7 +163,7 @@
  * no corresponding place in the HFS file.  'count' tells how many
  * bytes to transfer.  'buf' gives an address in user-space to transfer
  * the data to.
- * 
+ *
  * This is based on Linus's minix_file_read().
  * It has been changed to take into account that HFS files have no holes.
  */
@@ -316,7 +193,7 @@
 	   request as many blocks as we can, then we wait for the
 	   first one to complete, and then we try and wrap up as many
 	   as are actually done.
-	   
+
 	   This routine is optimized to make maximum use of the
 	   various buffers and caches. */
 
@@ -385,17 +262,14 @@
 				chars = HFS_SECTOR_SIZE - offset;
 			}
 			p = (*bhe)->b_data + offset;
-			if (convert) {
-				xlate_to_user(buf, p, chars);
-			} else {
-				chars -= copy_to_user(buf, p, chars);
-				if (!chars) {
-					brelse(*bhe);
-					count = 0;
-					if (!read)
-						read = -EFAULT;
-					break;
-				}
+
+			chars -= copy_to_user(buf, p, chars);
+			if (!chars) {
+				brelse(*bhe);
+				count = 0;
+				if (!read)
+					read = -EFAULT;
+				break;
 			}
 			brelse(*bhe);
 			count -= chars;
@@ -420,21 +294,12 @@
 	}
 	return read;
 }
- 
+
 /*
  * hfs_do_write()
- *
- * This function transfers actual data from user-space memory to disk,
- * returning the number of bytes successfully transferred.  'fork' tells
- * which file on the disk to write to.  'pos' gives the offset into
- * the Linux file at which to begin the transfer.  Note that this will
- * differ from 'filp->offset' in the case of an AppleDouble header file
- * due to the block of metadata at the beginning of the file, which has
- * no corresponding place in the HFS file.  'count' tells how many
- * bytes to transfer.  'buf' gives an address in user-space to transfer
- * the data from.
- * 
- * This is just a minor edit of Linus's minix_file_write().
+ 
+ XXX: Retained for the sake of the fork representations before
+      they are converted
  */
 hfs_s32 hfs_do_write(struct inode *inode, struct hfs_fork * fork, hfs_u32 pos,
 		     const char * buf, hfs_u32 count)
@@ -469,8 +334,7 @@
 			}
 		}
 		p = (pos % HFS_SECTOR_SIZE) + bh->b_data;
-		c -= convert ? xlate_from_user(p, buf, c) :
-			copy_from_user(p, buf, c);
+		c -= copy_from_user(p, buf, c);
 		if (!c) {
 			brelse(bh);
 			if (!written)
@@ -518,7 +382,7 @@
 			if (de[i]) {
 			        struct inode *inode = de[i]->d_inode;
 				inode->i_mode |= S_IWUGO;
-				inode->i_mode &= 
+				inode->i_mode &=
 				  ~HFS_SB(inode->i_sb)->s_umask;
 			}
 		}

