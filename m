Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423284AbWF1Lws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423284AbWF1Lws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423289AbWF1Lws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:52:48 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:25275 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1423284AbWF1Lwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:52:47 -0400
To: adilger@clusterfs.com, johann.lombardi@bull.net, cmm@us.ibm.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
Message-Id: <20060628205238sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 28 Jun 2006 20:52:38 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johann, Andreas

On Jun 05, 2006  15:13 +0200, Johann Lombardi wrote:
> On Fri, May 26, 2006 at 06:00:32AM -0600, Andreas Dilger wrote:
> > On May 25, 2006  21:49 +0900, sho@tnes.nec.co.jp wrote:
> > > @@ -1463,11 +1463,17 @@ static int ext3_fill_super (struct super
> > > +	if (blocksize > PAGE_SIZE) {
> > > +		printk(KERN_ERR "EXT3-fs: cannot mount filesystem with "
> > > +		       "blocksize %u larger than PAGE_SIZE %u on %s\n",
> > > +		       blocksize, PAGE_SIZE, sb->s_id);
> > > +		goto failed_mount;
> > > +	}
> > > +
> > >  	if (blocksize < EXT3_MIN_BLOCK_SIZE ||
> > > -	    blocksize > EXT3_MAX_BLOCK_SIZE) {
> > > +	    blocksize > EXT3_EXTENDED_MAX_BLOCK_SIZE) {
> >
> > We may as well just change EXT3_MAX_BLOCK_SIZE to be 65536, because no other
> > code uses this value.  It is already 65536 in the e2fsprogs.
> 
> AFAICS, ext3_dir_entry_2->rec_len will overflow with a 64kB blocksize.
Agree.


ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
with 64KB blocksize.  This patch prevent from overflow by limiting
rec_len to 65532.

This patch applies on top of Mingming's patches which were posted at:
  http://marc.theaimsgroup.com/?l=ext2-devel&m=114981607414944&w=2

I couldn't test with this patch because OS wouldn't boot with or
without it when CONFIG_IA64_PAGE_SIZE_64KB was enabled.

Patch-set consists of the following 2 patches.

  [1/2]  ext3: enlarge blocksize and fix rec_len overflow
          - Allow blocksize up to 64KB.
          - prevent rec_len from overflow with 64KB blocksize

  [2/2]  ext2: fix rec_len overflow
          - prevent rec_len from overflow with 64KB blocksize


Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc6/Documentation/dontdiff linux-2.6.17-rc6/fs/ext3/namei.c linux-2.6.17-rc6.tmp/fs/ext3/namei.c
--- linux-2.6.17-rc6/fs/ext3/namei.c	2006-06-27 09:05:11.000000000 +0900
+++ linux-2.6.17-rc6.tmp/fs/ext3/namei.c	2006-06-27 09:07:15.000000000 +0900
@@ -1154,8 +1154,13 @@ static struct ext3_dir_entry_2 *do_split
 	/* Fancy dance to stay within two buffers */
 	de2 = dx_move_dirents(data1, data2, map + split, count - split);
 	de = dx_pack_dirents(data1,blocksize);
-	de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
-	de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	if (blocksize < EXT3_RECLEN_MAX) {
+		de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
+		de2->rec_len = cpu_to_le16(data2 + blocksize - (char *) de2);
+	} else {
+		de->rec_len = cpu_to_le16(data1 + EXT3_RECLEN_MAX - (char *) de);
+		de2->rec_len = cpu_to_le16(data2 + EXT3_RECLEN_MAX - (char *) de2);
+	}
 	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data1, blocksize, 1));
 	dxtrace(dx_show_leaf (hinfo, (struct ext3_dir_entry_2 *) data2, blocksize, 1));
 
@@ -1206,7 +1211,10 @@ static int add_dirent_to_buf(handle_t *h
 	reclen = EXT3_DIR_REC_LEN(namelen);
 	if (!de) {
 		de = (struct ext3_dir_entry_2 *)bh->b_data;
-		top = bh->b_data + dir->i_sb->s_blocksize - reclen;
+		if (dir->i_sb->s_blocksize < EXT3_RECLEN_MAX)
+			top = bh->b_data + dir->i_sb->s_blocksize - reclen;
+		else
+			top = bh->b_data + EXT3_RECLEN_MAX - reclen;
 		while ((char *) de <= top) {
 			if (!ext3_check_dir_entry("ext3_add_entry", dir, de,
 						  bh, offset)) {
@@ -1417,7 +1425,10 @@ static int ext3_add_entry (handle_t *han
 		return retval;
 	de = (struct ext3_dir_entry_2 *) bh->b_data;
 	de->inode = 0;
-	de->rec_len = cpu_to_le16(rlen = blocksize);
+	if (blocksize < EXT3_RECLEN_MAX)
+		de->rec_len = cpu_to_le16(rlen = blocksize);
+	else
+		de->rec_len = cpu_to_le16(rlen = EXT3_RECLEN_MAX);
 	nlen = 0;
 	return add_dirent_to_buf(handle, dentry, inode, de, bh);
 }
@@ -1482,7 +1493,10 @@ static int ext3_dx_add_entry(handle_t *h
 			goto cleanup;
 		node2 = (struct dx_node *)(bh2->b_data);
 		entries2 = node2->entries;
-		node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		if (sb->s_blocksize < EXT3_RECLEN_MAX)
+			node2->fake.rec_len = cpu_to_le16(sb->s_blocksize);
+		else
+			node2->fake.rec_len = cpu_to_le16(EXT3_RECLEN_MAX);
 		node2->fake.inode = 0;
 		BUFFER_TRACE(frame->bh, "get_write_access");
 		err = ext3_journal_get_write_access(handle, frame->bh);
diff -upNr -X linux-2.6.17-rc6/Documentation/dontdiff linux-2.6.17-rc6/include/linux/ext3_fs.h linux-2.6.17-rc6.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc6/include/linux/ext3_fs.h	2006-06-27 09:05:15.000000000 +0900
+++ linux-2.6.17-rc6.tmp/include/linux/ext3_fs.h	2006-06-27 08:51:08.000000000 +0900
@@ -82,11 +82,16 @@ struct statfs;
 #define EXT3_LINK_MAX		32000
 
 /*
+ * Maximal size of directory entry record length
+ */
+#define EXT3_RECLEN_MAX                 65532
+
+/*
  * Macro-instructions used to manage several block sizes
  */
 #define EXT3_MIN_BLOCK_SIZE		1024
-#define	EXT3_MAX_BLOCK_SIZE		4096
-#define EXT3_MIN_BLOCK_LOG_SIZE		  10
+#define	EXT3_MAX_BLOCK_SIZE		65536
+#define EXT3_MIN_BLOCK_LOG_SIZE		10
 #ifdef __KERNEL__
 # define EXT3_BLOCK_SIZE(s)		((s)->s_blocksize)
 #else


Cheers, sho


