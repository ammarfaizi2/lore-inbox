Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135252AbRDRSuV>; Wed, 18 Apr 2001 14:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135253AbRDRSuM>; Wed, 18 Apr 2001 14:50:12 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20161 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135252AbRDRSuF>;
	Wed, 18 Apr 2001 14:50:05 -0400
Message-ID: <3ADDC2C7.7FF5C3F1@evision-ventures.com>
Date: Wed, 18 Apr 2001 18:37:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: PATCH tinny confusion cleanup in 2.4.3
Content-Type: multipart/mixed;
 boundary="------------33D134576246BEC0E29010E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------33D134576246BEC0E29010E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!

The attached patch remove the get_hardblock_size() function entierly
from the kernel. This is due to the fact that this function is
compleatly
unneccessary due to the existance of get_hardsect_size(), which got
introduced to properly encapsulate acesses to the hardsec_size[].
As a side effect this is reducing the number of module call-entrypoints
by one, which is a Good Thing TM.

Plase just apply it...
--------------33D134576246BEC0E29010E0
Content-Type: text/plain; charset=us-ascii;
 name="get_hardblock_size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get_hardblock_size.diff"

diff -urN linux/fs/buffer.c linux-new/fs/buffer.c
--- linux/fs/buffer.c	Wed Apr 18 20:41:16 2001
+++ linux-new/fs/buffer.c	Wed Apr 18 18:28:52 2001
@@ -555,25 +555,6 @@
 	return bh;
 }
 
-unsigned int get_hardblocksize(kdev_t dev)
-{
-	/*
-	 * Get the hard sector size for the given device.  If we don't know
-	 * what it is, return 0.
-	 */
-	if (hardsect_size[MAJOR(dev)] != NULL) {
-		int blksize = hardsect_size[MAJOR(dev)][MINOR(dev)];
-		if (blksize != 0)
-			return blksize;
-	}
-
-	/*
-	 * We don't know what the hardware sector size for this device is.
-	 * Return 0 indicating that we don't know.
-	 */
-	return 0;
-}
-
 void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
 {
 	spin_lock(&lru_list_lock);
diff -urN linux/fs/ext2/super.c linux-new/fs/ext2/super.c
--- linux/fs/ext2/super.c	Fri Dec 29 23:36:44 2000
+++ linux-new/fs/ext2/super.c	Wed Apr 18 19:19:44 2001
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/locks.h>
+#include <linux/blkdev.h>
 #include <asm/uaccess.h>
 
 
@@ -404,11 +405,9 @@
 	 * This is important for devices that have a hardware
 	 * sectorsize that is larger than the default.
 	 */
-	blocksize = get_hardblocksize(dev);
-	if( blocksize == 0 || blocksize < BLOCK_SIZE )
-	  {
+	blocksize = get_hardsect_size(dev);
+	if(blocksize < BLOCK_SIZE )
 	    blocksize = BLOCK_SIZE;
-	  }
 
 	sb->u.ext2_sb.s_mount_opt = 0;
 	if (!parse_options ((char *) data, &sb_block, &resuid, &resgid,
@@ -482,11 +481,9 @@
 		 * Make sure the blocksize for the filesystem is larger
 		 * than the hardware sectorsize for the machine.
 		 */
-		hblock = get_hardblocksize(dev);
-		if(    (hblock != 0)
-		    && (sb->s_blocksize < hblock) )
-		{
-			printk("EXT2-fs: blocksize too small for device.\n");
+		hblock = get_hardsect_size(dev);
+		if (sb->s_blocksize < hblock) {
+			printk(KERN_ERR "EXT2-fs: blocksize too small for device.\n");
 			goto failed_mount;
 		}
 
diff -urN linux/fs/isofs/inode.c linux-new/fs/isofs/inode.c
--- linux/fs/isofs/inode.c	Wed Apr 18 20:41:16 2001
+++ linux-new/fs/isofs/inode.c	Wed Apr 18 20:23:40 2001
@@ -27,6 +27,7 @@
 #include <linux/nls.h>
 #include <linux/ctype.h>
 #include <linux/smp_lock.h>
+#include <linux/blkdev.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -493,21 +494,21 @@
 	printk("iocharset = %s\n", opt.iocharset);
 #endif
 
- 	/*
- 	 * First of all, get the hardware blocksize for this device.
- 	 * If we don't know what it is, or the hardware blocksize is
- 	 * larger than the blocksize the user specified, then use
- 	 * that value.
- 	 */
- 	blocksize = get_hardblocksize(dev);
- 	if(blocksize > opt.blocksize) {
- 	    /*
- 	     * Force the blocksize we are going to use to be the
- 	     * hardware blocksize.
- 	     */
- 	    opt.blocksize = blocksize;
+	/*
+	 * First of all, get the hardware blocksize for this device.
+	 * If we don't know what it is, or the hardware blocksize is
+	 * larger than the blocksize the user specified, then use
+	 * that value.
+	 */
+	blocksize = get_hardsect_size(dev);
+	if(blocksize > opt.blocksize) {
+	    /*
+	     * Force the blocksize we are going to use to be the
+	     * hardware blocksize.
+	     */
+	    opt.blocksize = blocksize;
 	}
- 
+
 	blocksize_bits = 0;
 	{
 	  int i = opt.blocksize;
diff -urN linux/fs/minix/inode.c linux-new/fs/minix/inode.c
--- linux/fs/minix/inode.c	Wed Apr 18 20:41:16 2001
+++ linux-new/fs/minix/inode.c	Wed Apr 18 20:27:54 2001
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
+#include <linux/blkdev.h>
 
 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -179,7 +180,7 @@
 	const char * errmsg;
 	struct inode *root_inode;
 	unsigned int hblock;
-	
+
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */
 	if (32 != sizeof (struct minix_inode))
@@ -187,8 +188,8 @@
 	if (64 != sizeof(struct minix2_inode))
 		panic("bad V2 i-node size");
 
-	hblock = get_hardblocksize(dev);
-	if (hblock && hblock > BLOCK_SIZE)
+	hblock = get_hardsect_size(dev);
+	if (hblock > BLOCK_SIZE)
 		goto out_bad_hblock;
 
 	set_blocksize(dev, BLOCK_SIZE);
diff -urN linux/fs/udf/super.c linux-new/fs/udf/super.c
--- linux/fs/udf/super.c	Wed Apr 18 20:41:17 2001
+++ linux-new/fs/udf/super.c	Wed Apr 18 18:27:42 2001
@@ -344,8 +344,7 @@
 udf_set_blocksize(struct super_block *sb, int bsize)
 {
 	/* Use specified block size if specified */
-	if (!(sb->s_blocksize = get_hardblocksize(sb->s_dev)))
-		sb->s_blocksize = 2048;
+	sb->s_blocksize = get_hardsect_size(sb->s_dev);
 	if (bsize > sb->s_blocksize)
 		sb->s_blocksize = bsize;
 
diff -urN linux/include/linux/fs.h linux-new/include/linux/fs.h
--- linux/include/linux/fs.h	Wed Apr 18 20:41:18 2001
+++ linux-new/include/linux/fs.h	Wed Apr 18 18:33:59 2001
@@ -1249,7 +1249,6 @@
 		__bforget(buf);
 }
 extern void set_blocksize(kdev_t, int);
-extern unsigned int get_hardblocksize(kdev_t);
 extern struct buffer_head * bread(kdev_t, int, int);
 extern void wakeup_bdflush(int wait);
 
diff -urN linux/kernel/ksyms.c linux-new/kernel/ksyms.c
--- linux/kernel/ksyms.c	Wed Apr 18 20:41:19 2001
+++ linux-new/kernel/ksyms.c	Wed Apr 18 18:29:48 2001
@@ -182,7 +182,6 @@
 EXPORT_SYMBOL(inode_change_ok);
 EXPORT_SYMBOL(write_inode_now);
 EXPORT_SYMBOL(notify_change);
-EXPORT_SYMBOL(get_hardblocksize);
 EXPORT_SYMBOL(set_blocksize);
 EXPORT_SYMBOL(getblk);
 EXPORT_SYMBOL(bdget);

--------------33D134576246BEC0E29010E0--

