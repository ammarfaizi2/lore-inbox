Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276517AbRI2Oz5>; Sat, 29 Sep 2001 10:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276519AbRI2Ozr>; Sat, 29 Sep 2001 10:55:47 -0400
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:3488 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S276517AbRI2Oze>; Sat, 29 Sep 2001 10:55:34 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] multi-floppy rd loading fix
Date: Sat, 29 Sep 2001 16:55:40 +0200
Message-Id: <20010929145540.8691@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Linus, Alan !

The enclosed patch was written by some users to fix a problem with
multiple-floppy ramdisk load on some PowerMac machines. I'm not
familiar enough with some of that code so I may have missed some
issues there and would like your feedback on this patch.

Basically, the problem we have is that the floppy controller won't
let you eject the disk (remember, we have electric ejection mecanism
on Mac) if it's "enabled", that is if the floppy driver is opened.

The purpose of this patch is to close the floppy blkdev and re-open
it when switching from one disk to the next one.

If it sounds ok, then please include it in your next kernel,

Regards,
Ben.



diff -ur linux-2.4.9-ben0/drivers/block/rd.c linux-2.4.6/drivers/block/rd.c
--- linux-2.4.9-ben0-o/drivers/block/rd.c	Sun Aug 19 20:59:29 2001
+++ linux-2.4.9-ben0-t/drivers/block/rd.c	Mon Aug 27 21:46:38 2001
@@ -40,6 +40,9 @@
  *
  * Make block size and block size shift for RAM disks a global macro
  * and set blk_size for -ENOSPC,     Werner Fink <werner@suse.de>, Apr '99
+ *
+ * Add support for compressed fs images split across >1 disk, eject floppy
+ * after loading each disk,     Leigh Brown <leigh@solinno.co.uk>, Aug '01
  */
 
 #include <linux/config.h>
@@ -85,7 +88,7 @@
 #define BUILD_CRAMDISK
 
 void rd_load(void);
-static int crd_load(struct file *fp, struct file *outfp);
+static int crd_load(struct file *fp, struct file *outfp, kdev_t device,
struct inode *inode);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static int initrd_users;
@@ -466,7 +469,7 @@
  *	romfs
  * 	gzip
  */
-static int __init 
+int __init 
 identify_ramdisk_image(kdev_t device, struct file *fp, int start_block)
 {
 	const int size = 512;
@@ -570,9 +573,8 @@
 	char *buf;
 	unsigned short rotate = 0;
 	unsigned short devblocks = 0;
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
+
 	ram_device = MKDEV(MAJOR_NR, unit);
 
 	if ((inode = get_empty_inode()) == NULL)
@@ -609,7 +611,7 @@
 
 	if (nblocks == 0) {
 #ifdef BUILD_CRAMDISK
-		if (crd_load(&infile, &outfile) == 0)
+		if (crd_load(&infile, &outfile, device, inode) == 0)
 			goto successful_load;
 #else
 		printk(KERN_NOTICE
@@ -660,20 +662,29 @@
 			printk("done disk #%d.\n", i/devblocks);
 			rotate = 0;
 			invalidate_buffers(device);
+			if (infile.f_op->fsync)
+				infile.f_op->fsync(&infile, infile.f_dentry, 0);
+			else
+				printk("RAMDISK: can't sync\n");
+			if (infile.f_op->ioctl)
+				infile.f_op->ioctl(inode, &infile, FDEJECT, 0);
 			if (infile.f_op->release)
 				infile.f_op->release(inode, &infile);
-			printk("Please insert disk #%d and press ENTER\n", i/devblocks+1);
+
+			printk(KERN_NOTICE "Please insert disk #%d "
+			       "and press ENTER\n", i/devblocks+1);
 			wait_for_keypress();
 			if (blkdev_open(inode, &infile) != 0)  {
 				printk("Error opening disk.\n");
 				goto done;
 			}
 			infile.f_pos = 0;
-			printk("Loading disk #%d... ", i/devblocks+1);
+			printk(KERN_NOTICE "Loading disk #%d ... ",
+			       i/devblocks+1);
 		}
 		infile.f_op->read(&infile, buf, BLOCK_SIZE, &infile.f_pos);
 		outfile.f_op->write(&outfile, buf, BLOCK_SIZE, &outfile.f_pos);
-#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+#if !defined(CONFIG_ARCH_S390)
 		if (!(i % 16)) {
 			printk("%c\b", rotator[rotate & 0x3]);
 			rotate++;
@@ -787,6 +798,15 @@
 static int exit_code;
 static long bytes_out;
 static struct file *crd_infp, *crd_outfp;
+static kdev_t crd_device;
+static struct inode *crd_inode;
+static unsigned short disk_count __initdata = 1;
+
+#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+static char rotator[4] __initdata = { '|' , '/' , '-' , '\\' };
+static unsigned short block_count __initdata = 0;
+static unsigned short rotate __initdata = 0;
+#endif
 
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 		
@@ -839,10 +859,45 @@
 	
 	insize = crd_infp->f_op->read(crd_infp, inbuf, INBUFSIZ,
 				      &crd_infp->f_pos);
-	if (insize == 0) return -1;
+	if (insize == 0) {
+		printk("done disk #%d.\n", disk_count);
+		disk_count++;
+
+		invalidate_buffers(crd_device);
+		if (crd_infp->f_op->fsync)
+			crd_infp->f_op->fsync(crd_infp, crd_infp->f_dentry, 0);
+		else
+			printk("RAMDISK: can't sync\n");
+		if (crd_infp->f_op->ioctl)
+			crd_infp->f_op->ioctl(crd_inode, crd_infp, FDEJECT, 0);
+		if (crd_infp->f_op->release)
+			crd_infp->f_op->release(crd_inode, crd_infp);
 
-	inptr = 1;
+		printk(KERN_NOTICE
+		       "Please insert disk #%d and press ENTER\n", disk_count);
+		wait_for_keypress();
+		if (blkdev_open(crd_inode, crd_infp) != 0) {
+			printk(KERN_ERR "Error opening disk.\n");
+			return -1;
+		}
+		crd_infp->f_pos = 0;
+		printk(KERN_NOTICE "Loading disk #%d ... ", disk_count);
+		insize = crd_infp->f_op->read(crd_infp, inbuf, INBUFSIZ,
+					      &crd_infp->f_pos);
+		if (insize == 0) {
+			printk(KERN_ERR "Error reading from disk.\n");
+			return -1;
+		}
+	}
+#if !defined(CONFIG_ARCH_S390) && !defined(CONFIG_PPC_ISERIES)
+	if (!(block_count % 9)) {
+		printk("%c\b", rotator[rotate & 0x3]);
+		rotate++;
+	}
+	block_count++;
+#endif
 
+	inptr = 1;
 	return inbuf[0];
 }
 
@@ -874,7 +929,7 @@
 }
 
 static int __init 
-crd_load(struct file * fp, struct file *outfp)
+crd_load(struct file * fp, struct file *outfp, kdev_t device, struct
inode *inode)
 {
 	int result;
 
@@ -887,6 +942,8 @@
 
 	crd_infp = fp;
 	crd_outfp = outfp;
+	crd_device = device;
+	crd_inode = inode;
 	inbuf = kmalloc(INBUFSIZ, GFP_KERNEL);
 	if (inbuf == 0) {
 		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip buffer\n");
@@ -898,8 +955,13 @@
 		kfree(inbuf);
 		return -1;
 	}
+
+	printk(KERN_NOTICE "RAMDISK: Loading compressed image into ram disk... ");
 	makecrc();
 	result = gunzip();
+	if (!result)
+		printk("done disk #%d.\n", disk_count);
+
 	kfree(inbuf);
 	kfree(window);
 	return result;
diff -ur linux-2.4.9-ben0/drivers/block/swim3.c linux-2.4.6/drivers/
block/swim3.c
--- linux-2.4.9-ben0-o/drivers/block/swim3.c	Sun Aug 19 20:59:30 2001
+++ linux-2.4.9-ben0-t/drivers/block/swim3.c	Mon Aug 27 21:01:40 2001
@@ -36,7 +36,7 @@
 #include <linux/devfs_fs_kernel.h>
 
 static int floppy_blocksizes[2] = {512,512};
-static int floppy_sizes[2] = {2880,2880};
+static int floppy_sizes[2] = {1440,1440};
 
 #define MAX_FLOPPIES	2
 

--==_Boundary-1_==
Content-Type: application/x-gzip; name="ANS-floppy-ramdisk.patch.gz";
 x-mac-type="477A6970"; x-mac-creator="477A6970"
Content-Disposition: attachment
Content-Transfer-Encoding: base64

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
8fAiv2+7OP5LPxtfXl1hJVSa2PMf+30GTiQWAAA=
--==_Boundary-1_==--

