Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUGIHNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUGIHNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 03:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGIHNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 03:13:52 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:53963 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264367AbUGIHNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 03:13:47 -0400
Date: Fri, 09 Jul 2004 16:15:05 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/4][Diskdump]Update patches
To: linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com, hch@infradead.org
Message-id: <19C465847542EBindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I improved the patches which I posted on 7th Jul.

- Improve sysfs interface code
- Bug fix related to eh_timeout of scsi_cmd

Source code can be downloaded from
 http://sourceforge.net/projects/lkdump


On Mon, 21 Jun 2004 10:01:29 +0200, Arjan van de Ven wrote:

>On Mon, Jun 21, 2004 at 04:59:52PM +0900, Takao Indoh wrote:
>> Hi,
>> 
>> Now I am fixing diskdump according to comments by you and Christoph.
>> 
>> On Fri, 11 Jun 2004 13:50:45 +0200, Arjan van de Ven wrote:
>> 
>> >> +#ifdef CONFIG_PROC_FS
>> >> +static int proc_ioctl(struct inode *inode, struct file *file, unsigned 
>> >> int cmd, unsigned long param)
>> >
>> >
>> >ehhh this looks evil
>> 
>> Do you mean I should use not ioctl but the following style?
>> 
>> echo "add /dev/hda1" > /proc/diskdump
>> echo "delete /dev/hda1" > /proc/diskdump
>
>well no since /dev/hda is pointless; major/minor pairs maybe.
>But why in /proc???? it sounds like a sysfs job to me, where you probably
>want to represent a dump relationship with a symlink, and use "rm" to remove
>an entry..

As I wrote in the previous mail, I replaced proc interface with
sysfs.

If you want to add a new dump device /dev/sda3,

  # echo 3 > /sys/block/sda/device/dump

If you want to remove the dump device /dev/sda3,

  # echo -3 > /sys/block/sda/device/dump


I added a new attribute "dump" to the /sys/block/sdX/device.

diff -Nur linux-2.6.7.org/drivers/scsi/scsi_sysfs.c linux-2.6.7/drivers/scsi/scsi_sysfs.c
--- linux-2.6.7.org/drivers/scsi/scsi_sysfs.c	2004-06-22 10:27:50.000000000 +0900
+++ linux-2.6.7/drivers/scsi/scsi_sysfs.c	2004-07-09 11:36:41.451983216 +0900
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/device.h>
+#include <linux/diskdump.h>
 
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
@@ -375,6 +376,7 @@
 
 DEVICE_ATTR(state, S_IRUGO | S_IWUSR, show_state_field, store_state_field);
 
+DEVICE_ATTR(dump, S_IRUGO | S_IWUSR, diskdump_sysfs_show, diskdump_sysfs_store);
 
 /* Default template for device attributes.  May NOT be modified */
 static struct device_attribute *scsi_sysfs_sdev_attrs[] = {
@@ -389,6 +391,7 @@
 	&dev_attr_delete,
 	&dev_attr_state,
 	&dev_attr_timeout,
+	&dev_attr_dump,
 	NULL
 };
 

diskdump_sysfs_show/store is the sysfs handler of diskdump. These
functions passes struct device to the diskdump module.
Diskdump changes "struct device" to "struct scsi_device" like this:

+static void *scsi_dump_probe(struct device *dev)
+{
+	struct scsi_device *sdev;
+
+	if ((dev->bus == NULL) || (dev->bus->name == NULL) ||
+	    strncmp(dev->bus->name, "scsi", 4))
+		return NULL;
+
+	sdev =  to_scsi_device(dev);
+	if (!sdev->host->hostt->dump_poll)
+		return NULL;
+
+	return sdev;
+}

I used device->bus->name to confirm device is scsi device or not.

Please comment.

Best Regards,
Takao Indoh
