Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRIOWXg>; Sat, 15 Sep 2001 18:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273109AbRIOWX1>; Sat, 15 Sep 2001 18:23:27 -0400
Received: from [194.213.32.137] ([194.213.32.137]:49668 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273108AbRIOWXM>;
	Sat, 15 Sep 2001 18:23:12 -0400
Message-ID: <20010916001943.A984@bug.ucw.cz>
Date: Sun, 16 Sep 2001 00:19:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Weinehall <tao@acc.umu.se>, Kristian <kristian@korseby.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
In-Reply-To: <3BA3156C.9050704@korseby.net> <20010915144236.V26627@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010915144236.V26627@khan.acc.umu.se>; from David Weinehall on Sat, Sep 15, 2001 at 02:42:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hello.
> > 
> > For about 3 weeks I sent a report that I've got very strange kernel
> > error messages.
> > 
> > I changed my harddrive to IBM 75 GB because someone said that IBM's 40 GB 
> > harddisks are not very stable.
> 
> Just to get it out of the way, can you open your computer and check
> what country the disk is manufactured in? There has been some complaints
> on this list about IBM-disks fabricated in Hungary.

Install crc loop device, and if disk does silent errors, you'll know.
								Pavel

--- clean/drivers/block/loop.c	Sun Jul  8 23:26:37 2001
+++ linux/drivers/block/loop.c	Sun Jul  8 23:08:02 2001
@@ -69,6 +69,7 @@
 #include <linux/slab.h>
 
 #include <asm/uaccess.h>
+#include <asm/checksum.h>
 
 #include <linux/loop.h>		
 
@@ -107,7 +108,6 @@
 		in = loop_buf;
 		out = raw_buf;
 	}
-
 	key = lo->lo_encrypt_key;
 	keysize = lo->lo_encrypt_key_size;
 	for (i = 0; i < size; i++)
@@ -115,11 +115,106 @@
 	return 0;
 }
 
-static int none_status(struct loop_device *lo, struct loop_info *info)
+#define ID printk(KERN_ERR "crc: info about (%s, %d, %d) ", kdevname(lo->lo_device), real_block, blksize);
+
+
+static int transfer_crc(struct loop_device *lo, int cmd, char *raw_buf,
+		  char *loop_buf, int size, int real_block)
 {
+	struct buffer_head *bh;
+	int blksize = 1024, nsect;	/* Size of block on auxilary media */
+	int cksum;
+	u32 *data;
+	nsect = blksize / 4;
+
+	if (!lo->second_device) {
+		ID; printk( "reading from not-yet-setup crc device can result in armagedon. Dont try again.\n" );
+		return -1;
+	}
+	bh = getblk(lo->second_device, 1+real_block/nsect, blksize);
+	if (!bh) {
+		ID; printk( "getblk returned NULL.\n" );
+		return -1;
+	}
+	if (!buffer_uptodate(bh)) {
+		ll_rw_block(READ, 1, &bh);
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh)) {
+			ID; printk(  "could not read block with CRC\n" );
+			goto error;
+		}
+	}
+
+	data = (u32 *) bh->b_data;
+	if (cmd == READ)
+		cksum = csum_partial_copy_nocheck(raw_buf, loop_buf, size, 0);
+	else
+		cksum = csum_partial_copy_nocheck(loop_buf, raw_buf, size, 0);
+
+	if (cmd == READ) {
+		if (le32_to_cpu(data[real_block%nsect]) != cksum) {
+			if (lo->lo_encrypt_key_size == 0) {	/* Normal mode */
+				ID; printk( "wrong checksum reading, is %x, should be %x\n", cksum, 0x1234 );
+				goto error;
+			} else { 
+				ID; printk( "wrong checksum repairing, setting to %x\n", cksum );
+				goto repair;
+			}
+		}
+	} else {
+	repair:
+		data[real_block%nsect] = cpu_to_le32(cksum);
+		mark_buffer_uptodate(bh, 1);
+		mark_buffer_dirty(bh);
+	}
+
+	brelse(bh);
 	return 0;
+error:
+	brelse(bh);
+	return -1;
+
 }
 
+static int ioctl_crc(struct loop_device *lo, int cmd, unsigned long arg)
+{
+	struct file	*file;
+	struct inode	*inode;
+	int error;
+
+	printk( "Entering ioctl_crc\n" );
+	if (cmd != LOOP_CRC_SET_FD)
+		return -EINVAL;
+
+	error = -EBADF;
+	file = fget(arg);
+	if (!file)
+		return -EINVAL;
+
+	error = -EINVAL;
+	inode = file->f_dentry->d_inode;
+	if (!inode) {
+		printk(KERN_ERR "ioctl_crc: NULL inode?!?\n");
+		goto out;
+	}
+
+	if (S_ISBLK(inode->i_mode)) {
+		error = blkdev_open(inode, file);
+		lo->second_device = inode->i_rdev;
+		printk( "loop_crc: Registered device %x\n", lo->second_device );
+		return error;
+	} else {
+	out:
+		fput(file);
+		return -EINVAL;
+	}
+}
+
+static int none_status(struct loop_device *lo, struct loop_info *info)
+{
+	return 0;
+} 
+
 static int xor_status(struct loop_device *lo, struct loop_info *info)
 {
 	if (info->lo_encrypt_key_size <= 0)
@@ -139,10 +234,19 @@
 	init: xor_status
 }; 	
 
+struct loop_func_table crc_funcs = { 
+	number: LO_CRYPT_CRC,
+	transfer: transfer_crc,
+	init: none_status,
+	ioctl: ioctl_crc
+}; 	
+
 /* xfer_funcs[0] is special - its release function is never called */ 
 struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
 	&none_funcs,
-	&xor_funcs  
+	&xor_funcs,
+	NULL, NULL, NULL, NULL, NULL,
+	&crc_funcs,
 };
 
 #define MAX_DISK_SIZE 1024*1024*1024
@@ -728,6 +832,7 @@
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
 	lo->lo_device = 0;
+	lo->second_device = 0;
 	lo->lo_encrypt_type = 0;
 	lo->lo_offset = 0;
 	lo->lo_encrypt_key_size = 0;
--- clean/include/linux/loop.h	Wed Aug 29 01:23:55 2001
+++ linux/include/linux/loop.h	Sun Aug 26 18:27:56 2001
@@ -28,6 +28,7 @@
 	int		lo_number;
 	int		lo_refcnt;
 	kdev_t		lo_device;
+	kdev_t		second_device;
 	int		lo_offset;
 	int		lo_encrypt_type;
 	int		lo_encrypt_key_size;
@@ -119,6 +120,7 @@
 #define LO_CRYPT_BLOW     4
 #define LO_CRYPT_CAST128  5
 #define LO_CRYPT_IDEA     6
+#define LO_CRYPT_CRC	  7
 #define LO_CRYPT_DUMMY    9
 #define LO_CRYPT_SKIPJACK 10
 #define MAX_LO_CRYPT	20
@@ -150,5 +152,6 @@
 #define LOOP_CLR_FD	0x4C01
 #define LOOP_SET_STATUS	0x4C02
 #define LOOP_GET_STATUS	0x4C03
+#define LOOP_CRC_SET_FD 0x4C04
 
 #endif


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
