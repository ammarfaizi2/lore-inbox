Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWBJBfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWBJBfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 20:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWBJBfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 20:35:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:53657 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750951AbWBJBfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 20:35:14 -0500
Message-ID: <43EBEDD0.60608@us.ibm.com>
Date: Thu, 09 Feb 2006 17:35:12 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Support HDIO_GETGEO on device-mapper volumes
Content-Type: multipart/mixed;
 boundary="------------040208000100020706020004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040208000100020706020004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

I'm trying to install grub on a device-mapper RAID1 array that I set up 
via dmraid (in other words, a bootable software fakeraid).  Since dm 
doesn't implement the HDIO_GETGEO ioctl, grub assumes that the CHS 
geometry is 620/128/63, which makes it impossible to configure it to 
boot a filesystem that lives beyond the 2GB mark, even if the system 
BIOS supports that.

The attached patch implements a simple ioctl handler that supplies a 
compatible geometry when HDIO_GETGEO is called against a device-mapper 
device.  Its behavior is somewhat similar to what sd_mod does if the 
scsi controller doesn't provide its own geometry.  Granted, the notion 
of cylinders, heads and sectors is silly on a RAID array, but with this 
patch, interested programs can obtain CHS data that's somewhat close to 
correct; this seems to be a better option than having each program make 
up its own potentially different geometry, or making an arbitrary guess. 
  Assuming that all of the programs that need to know CHS geometry will 
query the kernel via HDIO_GETGEO, this patch makes it so that all of 
those programs end up using the same geometry.

The patch applies cleanly against 2.6.15.3; if there aren't any 
objections then I'm submitting this for upstream.  However, I'm all ears 
for suggestions.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--Darrick

--------------040208000100020706020004
Content-Type: text/x-patch;
 name="dm-getgeo_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-getgeo_1.patch"

diff -Naurp a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	2006-01-14 22:16:02.000000000 -0800
+++ b/drivers/md/dm.c	2006-02-09 14:05:18.000000000 -0800
@@ -17,6 +17,7 @@
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/hdreg.h>
 
 static const char *_name = DM_NAME;
 
@@ -223,6 +224,47 @@ static int dm_blk_close(struct inode *in
 	return 0;
 }
 
+static int dm_blk_ioctl(struct inode * inode, struct file * filp,
+			unsigned int cmd, unsigned long arg)
+{
+	struct block_device *bdev = inode->i_bdev;
+	struct hd_geometry __user *loc = (void __user *)arg;
+	struct mapped_device *md;
+	int diskinfo[4];
+
+	if (cmd == HDIO_GETGEO) {
+		if (!arg)
+			return -EINVAL;
+
+		/* Make up some fake geometry. */
+		md = bdev->bd_disk->private_data;
+		diskinfo[0] = 0x40;	/* 1 << 6 */
+		diskinfo[1] = 0x20;	/* 1 << 5 */
+		diskinfo[2] = md->disk->capacity >> 11;
+		diskinfo[3] = 0;
+
+		/* cylinder count too big? */
+		if (diskinfo[2] > 65536) {
+			diskinfo[0] = 255;
+			diskinfo[1] = 63;
+			diskinfo[2] = md->disk->capacity / 16065; /* 255*63 */
+		}
+
+		if (put_user(diskinfo[0], &loc->heads))
+			return -EFAULT;
+		if (put_user(diskinfo[1], &loc->sectors))
+			return -EFAULT;
+		if (put_user(diskinfo[2], &loc->cylinders))
+			return -EFAULT;
+		if (put_user(diskinfo[3], &loc->start))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	return -ENOTTY;
+}
+
 static inline struct dm_io *alloc_io(struct mapped_device *md)
 {
 	return mempool_alloc(md->io_pool, GFP_NOIO);
@@ -1179,6 +1221,7 @@ int dm_suspended(struct mapped_device *m
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
+	.ioctl = dm_blk_ioctl,
 	.owner = THIS_MODULE
 };
 

--------------040208000100020706020004--
