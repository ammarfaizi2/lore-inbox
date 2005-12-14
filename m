Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVLNFui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVLNFui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVLNFui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:50:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:48838 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751381AbVLNFui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:50:38 -0500
Date: Tue, 13 Dec 2005 21:50:19 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-ID: <20051214055019.GA23036@kroah.com>
References: <20051212134904.225dcc5d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212134904.225dcc5d.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 01:49:04PM -0800, Pete Zaitcev wrote:
> Hi, Greg,
> 
> When I plug a USB card reader with multiply LUNs, the following happens:
> 
> [zaitcev@niphredil ~]$ ls -l /sys/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2:1.0
> total 0
> -r--r--r-- 1 root root 4096 Dec 12 12:47 bAlternateSetting
> -r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceClass
> -r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceNumber
> -r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceProtocol
> -r--r--r-- 1 root root 4096 Dec 12 12:46 bInterfaceSubClass
> lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
> lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
> lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
> lrwxrwxrwx 1 root root    0 Dec 12 12:47 block -> ../../../../../../block/ubd
> -r--r--r-- 1 root root 4096 Dec 12 12:46 bNumEndpoints
> lrwxrwxrwx 1 root root    0 Dec 12 12:46 bus -> ../../../../../../bus/usb
> -r--r--r-- 1 root root 4096 Dec 12 12:47 diag
> lrwxrwxrwx 1 root root    0 Dec 12 12:46 driver -> ../../../../../../bus/usb/drivers/ub
> -r--r--r-- 1 root root 4096 Dec 12 12:46 modalias
> drwxr-xr-x 2 root root    0 Dec 12 12:46 power

> Do you have a suggestion about the fastest way to accomplish the same
> effect with ub?

Ick, you are right, sorry about this.  We changed the class code to add
the class device name to the symlink, because of this very problem.  I
forgot to convert the block code to do the same thing.  Now, with the
patch below my system looks like:

$ ls -l /sys/block/uba/device/
total 0
-r--r--r--  1 root root 4096 Dec 13 21:31 bAlternateSetting
-r--r--r--  1 root root 4096 Dec 13 21:31 bInterfaceClass
-r--r--r--  1 root root 4096 Dec 13 21:31 bInterfaceNumber
-r--r--r--  1 root root 4096 Dec 13 21:31 bInterfaceProtocol
-r--r--r--  1 root root 4096 Dec 13 21:31 bInterfaceSubClass
-r--r--r--  1 root root 4096 Dec 13 21:31 bNumEndpoints
lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:uba -> ../../../../../../block/uba
lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubb -> ../../../../../../block/ubb
lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubc -> ../../../../../../block/ubc
lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubd -> ../../../../../../block/ubd
lrwxrwxrwx  1 root root    0 Dec 13 13:28 bus -> ../../../../../../bus/usb
-r--r--r--  1 root root 4096 Dec 13 21:31 diag
lrwxrwxrwx  1 root root    0 Dec 13 21:31 driver -> ../../../../../../bus/usb/drivers/ub
drwxr-xr-x  2 root root    0 Dec 13 21:31 ep_02
drwxr-xr-x  2 root root    0 Dec 13 21:31 ep_82
-r--r--r--  1 root root 4096 Dec 13 21:31 modalias
drwxr-xr-x  2 root root    0 Dec 13 21:28 power
--w-------  1 root root 4096 Dec 13 21:28 uevent

This will also fix the problem for floppy devices, like Russell pointed
out.  Look good to you?

thanks,

greg k-h
-----------------

>From foo@baz.org Tue Dec 13 15:20:15 2005
Date: Tue, 13 Dec 2005 15:17:34 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver core: Make block devices create the proper symlink name

Block devices need to add the block device name to the symlink they put
in the device directory, otherwise multiple symlinks of the same name
can be created.  This matches the class system, which works the same
way, we just forgot to convert block at the same time.


Cc: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/partitions/check.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/fs/partitions/check.c
+++ gregkh-2.6/fs/partitions/check.c
@@ -325,12 +325,31 @@ void add_partition(struct gendisk *disk,
 	disk->part[part-1] = p;
 }
 
+static char *make_block_name(struct gendisk *disk)
+{
+	char *name;
+	static char *block_str = "block:";
+	int size;
+
+	size = strlen(block_str) + strlen(disk->disk_name) + 1;
+	name = kmalloc(size, GFP_KERNEL);
+	if (!name)
+		return NULL;
+	strcpy(name, block_str);
+	strcat(name, disk->disk_name);
+	return name;
+}
+
 static void disk_sysfs_symlinks(struct gendisk *disk)
 {
 	struct device *target = get_device(disk->driverfs_dev);
 	if (target) {
+		char *disk_name = make_block_name(disk);
 		sysfs_create_link(&disk->kobj,&target->kobj,"device");
-		sysfs_create_link(&target->kobj,&disk->kobj,"block");
+		if (disk_name) {
+			sysfs_create_link(&target->kobj,&disk->kobj,disk_name);
+			kfree(disk_name);
+		}
 	}
 }
 
@@ -444,8 +463,12 @@ void del_gendisk(struct gendisk *disk)
 	disk->stamp = 0;
 
 	if (disk->driverfs_dev) {
+		char *disk_name = make_block_name(disk);
 		sysfs_remove_link(&disk->kobj, "device");
-		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");
+		if (disk_name) {
+			sysfs_remove_link(&disk->driverfs_dev->kobj, disk_name);
+			kfree(disk_name);
+		}
 		put_device(disk->driverfs_dev);
 	}
 	ndevfs_remove(kobject_name(&disk->kobj));
