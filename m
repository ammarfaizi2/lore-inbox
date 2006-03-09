Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751902AbWCINn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWCINn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCINn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:43:26 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49635 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751902AbWCINnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:43:25 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix messages in fs/minix
Date: Thu, 9 Mar 2006 15:42:27 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DDDEEIn+dnp0BxC"
Message-Id: <200603091542.27713.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DDDEEIn+dnp0BxC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Believe it or not, but in fs/minix/*, the oldest filesystem
in the kernel, something still can be fixed:

	printk("new_inode: bit already set");

"\n" is missing!

While at it, I also removed periods from the end of error messages
and made capitalization uniform. Also s/i-node/inode/,
s/printk (/printk(/

Please apply.

Signed-ff-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_DDDEEIn+dnp0BxC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="minix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="minix.patch"

diff -urpN linux-2.6.15.org/fs/minix/bitmap.c linux-2.6.15.minix/fs/minix/bitmap.c
--- linux-2.6.15.org/fs/minix/bitmap.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15.minix/fs/minix/bitmap.c	Wed Mar  8 15:10:54 2006
@@ -56,7 +56,7 @@ void minix_free_block(struct inode * ino
 	unsigned int bit,zone;
 
 	if (block < sbi->s_firstdatazone || block >= sbi->s_nzones) {
-		printk("trying to free block not in datazone\n");
+		printk("Trying to free block not in datazone\n");
 		return;
 	}
 	zone = block - sbi->s_firstdatazone + 1;
@@ -124,7 +124,7 @@ minix_V1_raw_inode(struct super_block *s
 		 ino / MINIX_INODES_PER_BLOCK;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
-		printk("unable to read i-node block\n");
+		printk("Unable to read inode block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
@@ -149,7 +149,7 @@ minix_V2_raw_inode(struct super_block *s
 		 ino / MINIX2_INODES_PER_BLOCK;
 	*bh = sb_bread(sb, block);
 	if (!*bh) {
-		printk("unable to read i-node block\n");
+		printk("Unable to read inode block\n");
 		return NULL;
 	}
 	p = (void *)(*bh)->b_data;
@@ -204,7 +204,7 @@ void minix_free_inode(struct inode * ino
 	bh = sbi->s_imap[ino >> 13];
 	lock_kernel();
 	if (!minix_test_and_clear_bit(ino & 8191, bh->b_data))
-		printk("minix_free_inode: bit %lu already cleared.\n", ino);
+		printk("minix_free_inode: bit %lu already cleared\n", ino);
 	unlock_kernel();
 	mark_buffer_dirty(bh);
  out:
@@ -238,7 +238,7 @@ struct inode * minix_new_inode(const str
 		return NULL;
 	}
 	if (minix_test_and_set_bit(j,bh->b_data)) {	/* shouldn't happen */
-		printk("new_inode: bit already set");
+		printk("new_inode: bit already set\n");
 		unlock_kernel();
 		iput(inode);
 		return NULL;
diff -urpN linux-2.6.15.org/fs/minix/inode.c linux-2.6.15.minix/fs/minix/inode.c
--- linux-2.6.15.org/fs/minix/inode.c	Fri Dec 30 14:11:32 2005
+++ linux-2.6.15.minix/fs/minix/inode.c	Wed Mar  8 15:15:26 2006
@@ -126,11 +126,11 @@ static int minix_remount (struct super_b
 		mark_buffer_dirty(sbi->s_sbh);
 
 		if (!(sbi->s_mount_state & MINIX_VALID_FS))
-			printk ("MINIX-fs warning: remounting unchecked fs, "
-				"running fsck is recommended.\n");
+			printk("MINIX-fs warning: remounting unchecked fs, "
+				"running fsck is recommended\n");
 		else if ((sbi->s_mount_state & MINIX_ERROR_FS))
-			printk ("MINIX-fs warning: remounting fs with errors, "
-				"running fsck is recommended.\n");
+			printk("MINIX-fs warning: remounting fs with errors, "
+				"running fsck is recommended\n");
 	}
 	return 0;
 }
@@ -244,11 +244,11 @@ static int minix_fill_super(struct super
 		mark_buffer_dirty(bh);
 	}
 	if (!(sbi->s_mount_state & MINIX_VALID_FS))
-		printk ("MINIX-fs: mounting unchecked file system, "
-			"running fsck is recommended.\n");
+		printk("MINIX-fs: mounting unchecked file system, "
+			"running fsck is recommended\n");
  	else if (sbi->s_mount_state & MINIX_ERROR_FS)
-		printk ("MINIX-fs: mounting file system with errors, "
-			"running fsck is recommended.\n");
+		printk("MINIX-fs: mounting file system with errors, "
+			"running fsck is recommended\n");
 	return 0;
 
 out_iput:
@@ -272,19 +272,19 @@ out_no_bitmap:
 
 out_no_map:
 	if (!silent)
-		printk ("MINIX-fs: can't allocate map\n");
+		printk("MINIX-fs: can't allocate map\n");
 	goto out_release;
 
 out_no_fs:
 	if (!silent)
-		printk("VFS: Can't find a Minix or Minix V2 filesystem on device "
-		       "%s.\n", s->s_id);
+		printk("VFS: Can't find a Minix or Minix V2 filesystem "
+			"on device %s\n", s->s_id);
     out_release:
 	brelse(bh);
 	goto out;
 
 out_bad_hblock:
-	printk("MINIX-fs: blocksize too small for device.\n");
+	printk("MINIX-fs: blocksize too small for device\n");
 	goto out;
 
 out_bad_sb:
@@ -523,7 +523,7 @@ int minix_sync_inode(struct inode * inod
 		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh))
 		{
-			printk ("IO error syncing minix inode [%s:%08lx]\n",
+			printk("IO error syncing minix inode [%s:%08lx]\n",
 				inode->i_sb->s_id, inode->i_ino);
 			err = -1;
 		}
diff -urpN linux-2.6.15.org/fs/minix/itree_v1.c linux-2.6.15.minix/fs/minix/itree_v1.c
--- linux-2.6.15.org/fs/minix/itree_v1.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15.minix/fs/minix/itree_v1.c	Wed Mar  8 15:10:59 2006
@@ -25,9 +25,9 @@ static int block_to_path(struct inode * 
 	int n = 0;
 
 	if (block < 0) {
-		printk("minix_bmap: block<0");
+		printk("minix_bmap: block<0\n");
 	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
-		printk("minix_bmap: block>big");
+		printk("minix_bmap: block>big\n");
 	} else if (block < 7) {
 		offsets[n++] = block;
 	} else if ((block -= 7) < 512) {
diff -urpN linux-2.6.15.org/fs/minix/itree_v2.c linux-2.6.15.minix/fs/minix/itree_v2.c
--- linux-2.6.15.org/fs/minix/itree_v2.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.15.minix/fs/minix/itree_v2.c	Wed Mar  8 15:11:06 2006
@@ -25,9 +25,9 @@ static int block_to_path(struct inode * 
 	int n = 0;
 
 	if (block < 0) {
-		printk("minix_bmap: block<0");
+		printk("minix_bmap: block<0\n");
 	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
-		printk("minix_bmap: block>big");
+		printk("minix_bmap: block>big\n");
 	} else if (block < 7) {
 		offsets[n++] = block;
 	} else if ((block -= 7) < 256) {

--Boundary-00=_DDDEEIn+dnp0BxC--
