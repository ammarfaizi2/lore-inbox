Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTDHQER (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTDHQEQ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:04:16 -0400
Received: from [203.145.184.221] ([203.145.184.221]:46093 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261871AbTDHQEG convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:04:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] - 2.5.67 - proc interface to ramdisk driver.
Date: Tue, 8 Apr 2003 21:41:46 +0530
User-Agent: KMail/1.4.1
Cc: page0588@sundance.sjsu.edu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304082141.46820.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch will provide a 
proc interface to the ramdisk driver. 

Using this interface the size of the 
ramdisk can be changed at runtime.

Without the patch changing this size 
requires a recompilation of the kernel
or rebooting to enter as boot parameter.

Patch specification: -
Interface location : /proc/ramdisk_size
Operations possible:
1. read  
   eg: cat /proc/ramdisk_size
   will give the current ramdisk size.
2. write
   eg: echo "8000" > /proc/ramdisk_size
   will change the ramdisk size to 8000.

Regards and Thanks
KK


The patch was created using command: "diff  -urN"

--- drivers/block/rd.c.orig	Tue Apr  8 19:46:44 2003
+++ drivers/block/rd.c	Tue Apr  8 21:26:03 2003
@@ -56,6 +56,10 @@
 #include <linux/blkpg.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif
+
 /* The RAM disk size is now a parameter */
 #define NUM_RAMDISKS 16		/* This cannot be overridden (yet) */ 
 
@@ -356,6 +360,70 @@
 	.ioctl =	rd_ioctl,
 };
 
+
+#ifdef CONFIG_PROC_FS
+/* The Call back functions for the proc interface  */
+
+static struct proc_dir_entry *rd_sz;
+
+static int rd_proc_read(char *page, char **start, off_t off,
+			int count, int *eof, void *data)
+{
+
+	int len;
+	len = sprintf(page, "%d\n", rd_size);
+       	return len;
+}
+
+#define MAX_RDSTR_LEN 5
+static char rd_buf[MAX_RDSTR_LEN+1];
+
+static int rd_proc_write(struct file *file, const char *buf,
+			 unsigned long count, void *data)
+
+{
+	int len = 0, i = 0;
+	int temp = 0;
+	
+	for (i = 0; i < NUM_RAMDISKS; i++) {
+		struct block_device *bdev = rd_bdev[i];
+		if (bdev != NULL ) {
+			down (&bdev->bd_sem);
+			if ( bdev->bd_openers > 1 ){
+				up (&bdev->bd_sem);
+				return -EBUSY;
+			}
+			up (&bdev->bd_sem);
+		}
+	}	
+	if (len>MAX_RDSTR_LEN)
+		len = MAX_RDSTR_LEN;
+	else 
+		len = count;
+	
+	if (copy_from_user(rd_buf, buf, len)){
+		return -EFAULT;
+	}
+	temp = simple_strtol(rd_buf,NULL,0);
+	/* If the size is negative dont do anything */
+	if (temp < 0 ) return len;
+
+	rd_size = temp;	
+	/* Update the ramdisk capacity */
+	for (i = 0; i < NUM_RAMDISKS; i++) {
+		struct gendisk *disk = rd_disks[i];
+		struct block_device *bdev = rd_bdev[i];
+		set_capacity(disk, rd_size * 2);
+		if (bdev != NULL ) {
+			down (&bdev->bd_sem);
+			bdev->bd_inode->i_size = get_capacity(rd_disks[i])<<9;
+			up (&bdev->bd_sem);
+		}
+	}	
+	return len;
+}
+#endif
+
 /* Before freeing the module, invalidate all of the protected buffers! */
 static void __exit rd_cleanup (void)
 {
@@ -451,6 +519,17 @@
 	       "%d RAM disks of %dK size %d blocksize\n",
 	       NUM_RAMDISKS, rd_size, rd_blocksize);
 
+	
+#ifdef CONFIG_PROC_FS
+/* The entry would be created at /proc/ramdisk_size */	
+	rd_sz = create_proc_entry("ramdisk_size", 0644, NULL); 
+	if (rd_sz != NULL) {
+		rd_sz->read_proc  = rd_proc_read;
+		rd_sz->write_proc = rd_proc_write;
+	} else {
+		printk("RAMDISK: proc entry could not be created\n");
+	}	
+#endif
 	return 0;
 out:
 	while (i--)



