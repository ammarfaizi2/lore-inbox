Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSKFE1d>; Tue, 5 Nov 2002 23:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265115AbSKFE1d>; Tue, 5 Nov 2002 23:27:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:45228 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265588AbSKFE0w>;
	Tue, 5 Nov 2002 23:26:52 -0500
Message-ID: <3DC89B93.3CBED2E1@digeo.com>
Date: Tue, 05 Nov 2002 20:33:23 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan Breeding <jordan.breeding@attbi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: buffer layer error at fs/buffer.c:1166
References: <3DC891E2.3020006@attbi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 04:33:23.0400 (UTC) FILETIME=[A4397480:01C2854D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> 
> Hello,
> 
>    I get these errors while using 2.5.46-bk:
> 
> VFS: brelse: Trying to free free buffer
> buffer layer error at fs/buffer.c:1166
> Pass this trace through ksymoops for reporting
> Call Trace:
>   [<c01585b6>] __brelse+0x36/0x40
>   [<c01587d7>] bh_lru_install+0xc7/0x100
>   [<c0158875>] __find_get_block+0x65/0x70
>   [<c0158443>] __getblk_slow+0x23/0x110
>   [<c01588db>] __getblk+0x5b/0x70
>   [<c01943a8>] ext3_getblk+0xa8/0x300
>   [<c0194633>] ext3_bread+0x33/0xb0
>   [<c0197c5f>] dx_probe+0x4f/0x310
>   [<c0194633>] ext3_bread+0x33/0xb0
>   [<c01980fd>] ext3_htree_fill_tree+0x9d/0x1d0

There is a refcounting problem somewhere in htree.  Chris came uo
with the below patch.  Does it fix it for you?


 fs/ext3/namei.c |   50 ++++++++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 22 deletions(-)

--- 25/fs/ext3/namei.c~htree-fix	Tue Nov  5 18:48:52 2002
+++ 25-akpm/fs/ext3/namei.c	Tue Nov  5 18:48:52 2002
@@ -880,18 +880,18 @@ static struct buffer_head * ext3_dx_find
 		top = (struct ext3_dir_entry_2 *) ((char *) de + sb->s_blocksize -
 				       EXT3_DIR_REC_LEN(0));
 		for (; de < top; de = ext3_next_entry(de))
-		if (ext3_match (namelen, name, de)) {
-			if (!ext3_check_dir_entry("ext3_find_entry",
-						  dir, de, bh,
-				  (block<<EXT3_BLOCK_SIZE_BITS(sb))
-					  +((char *)de - bh->b_data))) {
-				brelse (bh);
-				goto errout;
+			if (ext3_match (namelen, name, de)) {
+				if (!ext3_check_dir_entry("ext3_find_entry",
+							  dir, de, bh,
+					  (block<<EXT3_BLOCK_SIZE_BITS(sb))
+						  +((char *)de - bh->b_data))) {
+					brelse (bh);
+					goto errout;
+				}
+				*res_dir = de;
+				dx_release (frames);
+				return bh;
 			}
-			*res_dir = de;
-			dx_release (frames);
-			return bh;
-		}
 		brelse (bh);
 		/* Check to see if we should continue to search */
 		retval = ext3_htree_next_block(dir, hash, frame,
@@ -1129,7 +1129,7 @@ errout:
  */
 static int add_dirent_to_buf(handle_t *handle, struct dentry *dentry,
 			     struct inode *inode, struct ext3_dir_entry_2 *de,
-			     struct buffer_head * bh)
+			     struct buffer_head * bh, int *buffull)
 {
 	struct inode	*dir = dentry->d_parent->d_inode;
 	const char	*name = dentry->d_name.name;
@@ -1160,8 +1160,11 @@ static int add_dirent_to_buf(handle_t *h
 			de = (struct ext3_dir_entry_2 *)((char *)de + rlen);
 			offset += rlen;
 		}
-		if ((char *) de > top)
+		if ((char *) de > top) {
+			assert(buffull);
+			*buffull = 1;
 			return -ENOSPC;
+		}
 	}
 	BUFFER_TRACE(bh, "get_write_access");
 	err = ext3_journal_get_write_access(handle, bh);
@@ -1286,7 +1289,7 @@ static int make_indexed_dir(handle_t *ha
 	if (!(de))
 		return retval;
 
-	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+	return add_dirent_to_buf(handle, dentry, inode, de, bh, NULL);
 }
 #endif
 
@@ -1308,7 +1311,7 @@ static int ext3_add_entry (handle_t *han
 	struct buffer_head * bh;
 	struct ext3_dir_entry_2 *de;
 	struct super_block * sb;
-	int	retval;
+	int	retval,buffull;
 #ifdef CONFIG_EXT3_INDEX
 	int	dx_fallback=0;
 #endif
@@ -1335,8 +1338,10 @@ static int ext3_add_entry (handle_t *han
 		bh = ext3_bread(handle, dir, block, 0, &retval);
 		if(!bh)
 			return retval;
-		retval = add_dirent_to_buf(handle, dentry, inode, 0, bh);
-		if (retval != -ENOSPC)
+		buffull = 0;
+		retval = add_dirent_to_buf(handle, dentry, inode, 0, bh,
+					   &buffull);
+		if (!buffull)
 			return retval;
 
 #ifdef CONFIG_EXT3_INDEX
@@ -1353,7 +1358,7 @@ static int ext3_add_entry (handle_t *han
 	de->inode = 0;
 	de->rec_len = cpu_to_le16(rlen = blocksize);
 	nlen = 0;
-	return add_dirent_to_buf(handle, dentry, inode, de, bh);
+	return add_dirent_to_buf(handle, dentry, inode, de, bh, NULL);
 }
 
 #ifdef CONFIG_EXT3_INDEX
@@ -1370,7 +1375,7 @@ static int ext3_dx_add_entry(handle_t *h
 	struct inode *dir = dentry->d_parent->d_inode;
 	struct super_block * sb = dir->i_sb;
 	struct ext3_dir_entry_2 *de;
-	int err;
+	int err,buffull;
 
 	frame = dx_probe(dentry, 0, &hinfo, frames, &err);
 	if (!frame)
@@ -1386,8 +1391,9 @@ static int ext3_dx_add_entry(handle_t *h
 	if (err)
 		goto journal_error;
 
-	err = add_dirent_to_buf(handle, dentry, inode, 0, bh);
-	if (err != -ENOSPC) {
+	buffull = 0;
+	err = add_dirent_to_buf(handle, dentry, inode, 0, bh, &buffull);
+	if (!buffull) {
 		bh = 0;
 		goto cleanup;
 	}
@@ -1479,7 +1485,7 @@ static int ext3_dx_add_entry(handle_t *h
 	de = do_split(handle, dir, &bh, frame, &hinfo, &err);
 	if (!de)
 		goto cleanup;
-	err = add_dirent_to_buf(handle, dentry, inode, de, bh);
+	err = add_dirent_to_buf(handle, dentry, inode, de, bh, NULL);
 	bh = 0;
 	goto cleanup;
 	

_
