Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281939AbRKUSSr>; Wed, 21 Nov 2001 13:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281937AbRKUSSi>; Wed, 21 Nov 2001 13:18:38 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:50939 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281395AbRKUSS1>;
	Wed, 21 Nov 2001 13:18:27 -0500
Date: Wed, 21 Nov 2001 11:18:11 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Eric M <ground12@jippii.fi>
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
Message-ID: <20011121111811.P1308@lynx.no>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
	Eric M <ground12@jippii.fi>
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi>; from ground12@jippii.fi on Wed, Nov 21, 2001 at 09:55:18AM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 21, 2001  09:55 +0200, Eric M wrote:
> Machine booted ok and everything seemed to be ok, but i noticed a few
> weird messages in boot messages right before mounting the root-partition:
> FAT: bogus logical sector size 0
> FAT: bogus logical sector size 0

When the kernel is booting, it doesn't know the filesystem type of the
root fs, so it tries to mount the root device using all of the compiled-in
fs drivers, in the order they are listed in fs/Makefile.in.

It appears that the fat driver doesn't even check for a magic when it
starts trying to mount the filesystem, so it proceeds directly to
spewing errors.  You get two such messages because it is trying both
msdos and vfat (which both use the fat driver underneath).  You don't
see this with ext2 because it tries to mount before vfat/msdos.

This is a minor bug in the fat read_super() method, because when the
kernel is trying to mount the root fs, it passes the "silent" flag
to the filesystem, so it should not print any messages if it is not a
fat filesystem.  If this wasn't the case, then you would get spew from
every filesystem it tried.

Note that reiserfs is guilty of this as well, since it prints out:

can't find a reiserfs filesystem on (dev 08:03, block 64, size 4096)

So a patch for that is attached (against 2.4.13, but I didn't see any
changes which would affect it).

This message is never normally seen, because currently reiserfs is
at the end of the search list for filesystems.  I will also propose a
patch to move reiserfs earlier in the probe sequence, since it has
a well-defined magic, and is more commonly used than most others.  I
only put it where it is to avoid context issues with my tree (which
has ext3 and jbd (an experimental filesystem interface for journal
devices) at the top.

Please feel free to re-submit these to Linus, I will not do so.

Cheers, Andreas
====================== reiserfs-2.4.13-silent.diff =======================
--- linux.orig/fs/reiserfs/super.c	Thu Oct 25 03:05:11 2001
+++ linux/fs/reiserfs/super.c	Wed Nov 21 11:01:57 2001
@@ -346,7 +356,8 @@
 		      free, SB_FREE_BLOCKS (s));
 }
 
-static int read_super_block (struct super_block * s, int size, int offset)
+static int read_super_block (struct super_block * s, int size, int offset,
+			     int silent)
 {
     struct buffer_head * bh;
     struct reiserfs_super_block * rs;
@@ -362,9 +373,10 @@
  
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (!is_reiserfs_magic_string (rs)) {
-      printk ("read_super_block: "
-              "can't find a reiserfs filesystem on (dev %s, block %lu, size %d)\n",
-              kdevname(s->s_dev), bh->b_blocknr, size);
+      if (!silent)
+        printk("read_super_block: can't find a reiserfs filesystem on "
+	       "(dev %s, block %lu, size %d)\n",
+	       kdevname(s->s_dev), bh->b_blocknr, size);
       brelse (bh);
       return 1;
     }
@@ -393,11 +405,11 @@
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (!is_reiserfs_magic_string (rs) ||
 	sb_blocksize(rs) != s->s_blocksize) {
-	printk ("read_super_block: "
-		"can't find a reiserfs filesystem on (dev %s, block %lu, size %d)\n",
-		kdevname(s->s_dev), bh->b_blocknr, size);
+	if (!silent)
+	  printk("read_super_block: can't find a reiserfs filesystem on "
+		 "(dev %s, block %lu, size %d)\n",
+		 kdevname(s->s_dev), bh->b_blocknr, size);
 	brelse (bh);
-	printk ("read_super_block: can't find a reiserfs filesystem on dev %s.\n", kdevname(s->s_dev));
 	return 1;
     }
     /* must check to be sure we haven't pulled an old format super out
@@ -621,7 +633,7 @@
     }
 
     if (blocks) {
-  	printk("reserfs: resize option for remount only\n");
+	printk("reiserfs: resize option for remount only\n");
 	return NULL;
     }	
 
@@ -634,9 +646,9 @@
     }
 
     /* read block (64-th 1k block), which can contain reiserfs super block */
-    if (read_super_block (s, size, REISERFS_DISK_OFFSET_IN_BYTES)) {
+    if (read_super_block (s, size, REISERFS_DISK_OFFSET_IN_BYTES, silent)) {
 	// try old format (undistributed bitmap, super block in 8-th 1k block of a device)
-	if (read_super_block (s, size, REISERFS_OLD_DISK_OFFSET_IN_BYTES)) 
+	if (read_super_block(s, size, REISERFS_OLD_DISK_OFFSET_IN_BYTES,silent))
 	    goto error;
 	else
 	    old_format = 1;
====================== reiserfs-2.4.13-order.diff =======================
--- linux.orig/fs/Makefile	Thu Oct 25 02:02:41 2001
+++ linux/fs/Makefile	Wed Nov 21 10:51:11 2001
@@ -26,7 +26,10 @@
 subdir-$(CONFIG_EXT2_FS)	+= ext2
 subdir-$(CONFIG_CRAMFS)		+= cramfs
 subdir-$(CONFIG_RAMFS)		+= ramfs
+subdir-$(CONFIG_REISERFS_FS)	+= reiserfs
 subdir-$(CONFIG_CODA_FS)	+= coda
 subdir-$(CONFIG_MINIX_FS)	+= minix
 subdir-$(CONFIG_FAT_FS)	+= fat
@@ -60,7 +63,6 @@
 subdir-$(CONFIG_AUTOFS_FS)	+= autofs
 subdir-$(CONFIG_AUTOFS4_FS)	+= autofs4
 subdir-$(CONFIG_ADFS_FS)	+= adfs
-subdir-$(CONFIG_REISERFS_FS)	+= reiserfs
 subdir-$(CONFIG_DEVPTS_FS)	+= devpts
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
 
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

