Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbUEBNIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUEBNIW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEBNIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:08:22 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:16396 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263033AbUEBNIQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:08:16 -0400
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: Fix nfsv2 support (1/4)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 02 May 2004 22:08:08 +0900
Message-ID: <8765bft1s7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ->dentry_to_fh() can use the 20 bytes in the case of NFSv2, but
fat_dentry_to_fh() requires 24 bytes by my patch.

So nfsd reply the EOPNOTSUPP to nfs client, then nfs client convert
the unknown error to -EIO.

This patch fixes the problem by pushing the handle data into 20 bytes. 

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



 fs/fat/inode.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff -puN fs/fat/inode.c~fat_nfsv2-fix fs/fat/inode.c
--- linux-2.6.6-rc3/fs/fat/inode.c~fat_nfsv2-fix	2004-05-02 19:15:34.000000000 +0900
+++ linux-2.6.6-rc3-hirofumi/fs/fat/inode.c	2004-05-02 19:15:34.000000000 +0900
@@ -557,11 +557,13 @@ static int fat_read_root(struct inode *i
  *  0/  i_ino - for fast, reliable lookup if still in the cache
  *  1/  i_generation - to see if i_ino is still valid
  *          bit 0 == 0 iff directory
- *  2/  i_pos - if ino has changed, but still in cache (hi)
- *  3/  i_pos - if ino has changed, but still in cache (low)
- *  4/  i_logstart - to semi-verify inode found at i_location
- *  5/  parent->i_logstart - maybe used to hunt for the file on disc
+ *  2/  i_pos(8-39) - if ino has changed, but still in cache
+ *  3/  i_pos(4-7)|i_logstart - to semi-verify inode found at i_pos
+ *  4/  i_pos(0-3)|parent->i_logstart - maybe used to hunt for the file on disc
  *
+ * Hack for NFSv2: Maximum FAT entry number is 28bits and maximum
+ * i_pos is 40bits (blocknr(32) + dir offset(8)), so two 4bits
+ * of i_logstart is used to store the directory entry offset.
  */
 
 struct dentry *fat_decode_fh(struct super_block *sb, __u32 *fh,
@@ -572,7 +574,7 @@ struct dentry *fat_decode_fh(struct supe
 
 	if (fhtype != 3)
 		return ERR_PTR(-ESTALE);
-	if (len < 6)
+	if (len < 5)
 		return ERR_PTR(-ESTALE);
 
 	return sb->s_export_op->find_exported_dentry(sb, fh, NULL, acceptable, context);
@@ -585,13 +587,17 @@ struct dentry *fat_get_dentry(struct sup
 	__u32 *fh = inump;
 
 	inode = iget(sb, fh[0]);
-	if (!inode || is_bad_inode(inode) ||
-	    inode->i_generation != fh[1]) {
-		if (inode) iput(inode);
+	if (!inode || is_bad_inode(inode) || inode->i_generation != fh[1]) {
+		if (inode)
+			iput(inode);
 		inode = NULL;
 	}
 	if (!inode) {
-		loff_t i_pos = ((loff_t)fh[2] << 32) | fh[3];
+		loff_t i_pos;
+		int i_logstart = fh[3] & 0x0fffffff;
+
+		i_pos = (loff_t)fh[2] << 8;
+		i_pos |= ((fh[3] >> 24) & 0xf0) | (fh[4] >> 28);
 
 		/* try 2 - see if i_pos is in F-d-c
 		 * require i_logstart to be the same
@@ -599,7 +605,7 @@ struct dentry *fat_get_dentry(struct sup
 		 */
 
 		inode = fat_iget(sb, i_pos);
-		if (inode && MSDOS_I(inode)->i_logstart != fh[4]) {
+		if (inode && MSDOS_I(inode)->i_logstart != i_logstart) {
 			iput(inode);
 			inode = NULL;
 		}
@@ -638,17 +644,21 @@ int fat_encode_fh(struct dentry *de, __u
 {
 	int len = *lenp;
 	struct inode *inode =  de->d_inode;
+	u32 ipos_h, ipos_m, ipos_l;
 	
-	if (len < 6)
+	if (len < 5)
 		return 255; /* no room */
-	*lenp = 6;
+
+	ipos_h = MSDOS_I(inode)->i_pos >> 8;
+	ipos_m = (MSDOS_I(inode)->i_pos & 0xf0) << 24;
+	ipos_l = (MSDOS_I(inode)->i_pos & 0x0f) << 28;
+	*lenp = 5;
 	fh[0] = inode->i_ino;
 	fh[1] = inode->i_generation;
-	fh[2] = (__u32)(MSDOS_I(inode)->i_pos >> 32);
-	fh[3] = (__u32)MSDOS_I(inode)->i_pos;
-	fh[4] = MSDOS_I(inode)->i_logstart;
+	fh[2] = ipos_h;
+	fh[3] = ipos_m | MSDOS_I(inode)->i_logstart;
 	spin_lock(&de->d_lock);
-	fh[5] = MSDOS_I(de->d_parent->d_inode)->i_logstart;
+	fh[4] = ipos_l | MSDOS_I(de->d_parent->d_inode)->i_logstart;
 	spin_unlock(&de->d_lock);
 	return 3;
 }

_
