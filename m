Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272240AbRH3O07>; Thu, 30 Aug 2001 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272234AbRH3O0m>; Thu, 30 Aug 2001 10:26:42 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:64266 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272235AbRH3O0V>; Thu, 30 Aug 2001 10:26:21 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19668.144702.95001@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:25:24 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: C-old-format.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    this patch fixes bugs in the support for old reiserfs format <3.5:
    file-systems of this format are now mountable and convertible.

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/super.c linux.patched/fs/reiserfs/super.c
--- linux/fs/reiserfs/super.c	Wed Aug  1 21:12:55 2001
+++ linux.patched/fs/reiserfs/super.c	Wed Aug  1 21:18:00 2001
@@ -29,19 +29,11 @@
 
 #endif
 
-#define SUPPORT_OLD_FORMAT
 
 #define REISERFS_OLD_BLOCKSIZE 4096
 #define REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ 20
 
 
-#if 0
-// this one is not used currently
-inline void reiserfs_mark_buffer_dirty (struct buffer_head * bh, int flag)
-{
-  mark_buffer_dirty (bh, flag);
-}
-#endif
 
 //
 // a portion of this function, particularly the VFS interface portion,
@@ -367,98 +359,34 @@ void check_bitmap (struct super_block * 
 		      free, SB_FREE_BLOCKS (s));
 }
 
-#ifdef SUPPORT_OLD_FORMAT 
-
-/* support old disk layout */
-static int read_old_super_block (struct super_block * s, int size)
-{
-    struct buffer_head * bh;
-    struct reiserfs_super_block * rs;
-
-    printk("read_old_super_block: try to find super block in old location\n");
-    /* there are only 4k-sized blocks in v3.5.10 */
-    if (size != REISERFS_OLD_BLOCKSIZE)
-	set_blocksize(s->s_dev, REISERFS_OLD_BLOCKSIZE);
-    bh = bread (s->s_dev, 
-		REISERFS_OLD_DISK_OFFSET_IN_BYTES / REISERFS_OLD_BLOCKSIZE, 
-		REISERFS_OLD_BLOCKSIZE);
-    if (!bh) {
-	printk("read_old_super_block: unable to read superblock on dev %s\n", kdevname(s->s_dev));
-	return 1;
-    }
-
-    rs = (struct reiserfs_super_block *)bh->b_data;
-    if (strncmp (rs->s_magic,  REISERFS_SUPER_MAGIC_STRING, strlen ( REISERFS_SUPER_MAGIC_STRING))) {
-	/* pre-journaling version check */
-	if(!strncmp((char*)rs + REISERFS_SUPER_MAGIC_STRING_OFFSET_NJ,
-		    REISERFS_SUPER_MAGIC_STRING, strlen(REISERFS_SUPER_MAGIC_STRING))) {
-	    printk("read_old_super_blockr: a pre-journaling reiserfs filesystem isn't suitable there.\n");
-	    brelse(bh);
-	    return 1;
-	}
-	  
-	brelse (bh);
-	printk ("read_old_super_block: can't find a reiserfs filesystem on dev %s.\n", kdevname(s->s_dev));
-	return 1;
-    }
-
-    if(REISERFS_OLD_BLOCKSIZE != le16_to_cpu (rs->s_blocksize)) {
-	printk("read_old_super_block: blocksize mismatch, super block corrupted\n");
-	brelse(bh);
-	return 1;
-    }	
-
-    s->s_blocksize = REISERFS_OLD_BLOCKSIZE;
-    s->s_blocksize_bits = 0;
-    while ((1 << s->s_blocksize_bits) != s->s_blocksize)
-	s->s_blocksize_bits ++;
 
-    SB_BUFFER_WITH_SB (s) = bh;
-    SB_DISK_SUPER_BLOCK (s) = rs;
-    s->s_op = &reiserfs_sops;
-    return 0;
-}
-#endif
 
-//
-// FIXME: mounting old filesystems we _must_ change magic string to
-// make then unmountable by reiserfs of 3.5.x
-//
-static int read_super_block (struct super_block * s, int size)
+static int read_super_block (struct super_block * s, int size, int offset)
 {
     struct buffer_head * bh;
     struct reiserfs_super_block * rs;
 
-    bh = bread (s->s_dev, REISERFS_DISK_OFFSET_IN_BYTES / size, size);
+
+    bh = bread (s->s_dev, offset / size, size);
     if (!bh) {
-	printk("read_super_block: unable to read superblock on dev %s\n", kdevname(s->s_dev));
+	printk ("read_super_block: "
+		"bread failed (dev %s, block %d, size %d)\n", 
+		kdevname (s->s_dev), offset / size, size);
 	return 1;
     }
 
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (!is_reiserfs_magic_string (rs)) {
-	printk ("read_super_block: can't find a reiserfs filesystem on dev %s\n",
-		kdevname(s->s_dev));
+	printk ("read_super_block: "
+		"can't find a reiserfs filesystem on (dev %s, block %lu, size %d)\n",
+		kdevname(s->s_dev), bh->b_blocknr, size);
 	brelse (bh);
 	return 1;
     }
 
     //
-    // ok, reiserfs signature (old or new) found in 64-th 1k block of
-    // the device
+    // ok, reiserfs signature (old or new) found in at the given offset
     //
-
-#ifndef SUPPORT_OLD_FORMAT 
-    // with SUPPORT_OLD_FORMAT undefined - detect old format by
-    // checking super block version
-    if (le16_to_cpu (rs->s_version) != REISERFS_VERSION_2) { 
-	brelse (bh);
-	printk ("read_super_block: unsupported version (%d) of reiserfs found on dev %s\n",
-		le16_to_cpu (rs->s_version), kdevname(s->s_dev));
-	return 1;
-    }
-#endif
-    
     s->s_blocksize = le16_to_cpu (rs->s_blocksize);
     s->s_blocksize_bits = 0;
     while ((1 << s->s_blocksize_bits) != s->s_blocksize)
@@ -468,17 +396,22 @@ static int read_super_block (struct supe
     
     if (s->s_blocksize != size)
 	set_blocksize (s->s_dev, s->s_blocksize);
-    bh = reiserfs_bread (s->s_dev, REISERFS_DISK_OFFSET_IN_BYTES / s->s_blocksize, s->s_blocksize);
+
+    bh = bread (s->s_dev, offset / s->s_blocksize, s->s_blocksize);
     if (!bh) {
-	printk("read_super_block: unable to read superblock on dev %s\n", kdevname(s->s_dev));
+	printk ("read_super_block: "
+		"bread failed (dev %s, block %d, size %d)\n", 
+		kdevname (s->s_dev), offset / size, size);
 	return 1;
     }
     
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (!is_reiserfs_magic_string (rs) ||
 	le16_to_cpu (rs->s_blocksize) != s->s_blocksize) {
+	printk ("read_super_block: "
+		"can't find a reiserfs filesystem on (dev %s, block %lu, size %d)\n",
+		kdevname(s->s_dev), bh->b_blocknr, size);
 	brelse (bh);
-	printk ("read_super_block: can't find a reiserfs filesystem on dev %s.\n", kdevname(s->s_dev));
 	return 1;
     }
     /* must check to be sure we haven't pulled an old format super out
@@ -489,7 +422,8 @@ static int read_super_block (struct supe
     if (bh->b_blocknr >= le32_to_cpu(rs->s_journal_block) && 
 	bh->b_blocknr < (le32_to_cpu(rs->s_journal_block) + JOURNAL_BLOCK_COUNT)) {
 	brelse(bh) ;
-	printk("super-459: read_super_block: super found at block %lu is within its own log. "
+	printk("super-459: read_super_block: "
+	       "super found at block %lu is within its own log. "
 	       "It must not be of this format type.\n", bh->b_blocknr) ;
 	return 1 ;
     }
@@ -504,6 +438,8 @@ static int read_super_block (struct supe
     return 0;
 }
 
+
+
 /* after journal replay, reread all bitmap and super blocks */
 static int reread_meta_blocks(struct super_block *s) {
   int i ;
@@ -712,15 +648,12 @@ struct super_block * reiserfs_read_super
     }
 
     /* read block (64-th 1k block), which can contain reiserfs super block */
-    if (read_super_block (s, size)) {
-#ifdef SUPPORT_OLD_FORMAT
+    if (read_super_block (s, size, REISERFS_DISK_OFFSET_IN_BYTES)) {
 	// try old format (undistributed bitmap, super block in 8-th 1k block of a device)
-	if(read_old_super_block(s,size)) 
+	if (read_super_block (s, size, REISERFS_OLD_DISK_OFFSET_IN_BYTES)) 
 	    goto error;
 	else
 	    old_format = 1;
-#endif
-	goto error ;
     }
 
     s->u.reiserfs_sb.s_mount_state = le16_to_cpu (SB_DISK_SUPER_BLOCK (s)->s_state); /* journal victim */
