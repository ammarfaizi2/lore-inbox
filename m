Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUAMAfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUAMAfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:35:50 -0500
Received: from magic-mail.adaptec.com ([216.52.22.10]:17887 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263695AbUAMAf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:35:26 -0500
Message-ID: <40033D02.8000207@adaptec.com>
Date: Mon, 12 Jan 2004 17:34:10 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Proposed enhancements to MD
Content-Type: multipart/mixed;
 boundary="------------080105000606050407080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105000606050407080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All,

Adaptec has been looking at the MD driver for a foundation for their
Open-Source software RAID stack.  This will help us provide full
and open support for current and future Adaptec RAID products (as
opposed to the limited support through closed drivers that we have now).

While MD is fairly functional and clean, there are a number of 
enhancements to it that we have been working on for a while and would
like to push out to the community for review and integration.  These
include:

- partition support for md devices:  MD does not support the concept of
   fdisk partitions; the only way to approximate this right now is by
   creating multiple arrays on the same media.  Fixing this is required
   for not only feature-completeness, but to allow our BIOS to recognise
   the partitions on an array and properly boot them as it would boot a
   normal disk.

- generic device arrival notification mechanism:  This is needed to
   support device hot-plug, and allow arrays to be automatically
   configured regardless of when the md module is loaded or initialized.
   RedHat EL3 has a scaled down version of this already, but it is
   specific to MD and only works if MD is statically compiled into the
   kernel.  A general mechanism will benefit MD as well as any other
   storage system that wants hot-arrival notices.

- RAID-0 fixes:  The MD RAID-0 personality is unable to perform I/O
   that spans a chunk boundary.  Modifications are needed so that it can
   take a request and break it up into 1 or more per-disk requests.

- Metadata abstraction:  We intend to support multiple on-disk metadata
   formats, along with the 'native MD' format.  To do this, specific
   knowledge of MD on-disk structures must be abstracted out of the core
   and personalities modules.

- DDF Metadata support: Future products will use the 'DDF' on-disk
   metadata scheme.  These products will be bootable by the BIOS, but
   must have DDF support in the OS.  This will plug into the abstraction
   mentioned above.

I'm going to push these changes out in phases in order to keep the risk
and churn to a minimum.  The attached patch is for the partition
support.  It was originally from Ingo Molnar, but has changed quite a
bit due to the radical changes in the disk/block layer in 2.6.  The 2.4
version works quite well, while the 2.6 version is fairly fresh.  One
problem that I have with it is that the created partitions show up in
/proc/partitions after running fdisk, but not after a reboot.

Scott

--------------080105000606050407080902
Content-Type: text/plain;
 name="md_partition.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md_partition.diff"

--- linux-2.6.1/drivers/md/md.c	2004-01-08 23:59:19.000000000 -0700
+++ md/linux-2.6.1/drivers/md/md.c	2004-01-12 14:46:33.818544376 -0700
@@ -1446,6 +1446,9 @@
 	return 1;
 }
 
+/* MD Partition definitions */
+#define MDP_MINOR_COUNT		16
+#define MDP_MINOR_SHIFT		4
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
@@ -1453,6 +1456,7 @@
 	int unit = *part;
 	mddev_t *mddev = mddev_find(unit);
 	struct gendisk *disk;
+	int index;
 
 	if (!mddev)
 		return NULL;
@@ -1463,15 +1467,22 @@
 		mddev_put(mddev);
 		return NULL;
 	}
-	disk = alloc_disk(1);
+	disk = alloc_disk(MDP_MINOR_COUNT);
 	if (!disk) {
 		up(&disks_sem);
 		mddev_put(mddev);
 		return NULL;
 	}
+	index = mdidx(mddev);
 	disk->major = MD_MAJOR;
-	disk->first_minor = mdidx(mddev);
-	sprintf(disk->disk_name, "md%d", mdidx(mddev));
+	disk->first_minor = index << MDP_MINOR_SHIFT;
+	disk->minors = MDP_MINOR_COUNT;
+	if (index >= 26) {
+		sprintf(disk->disk_name, "md%c%c",
+			'a' + index/26-1,'a' + index % 26);
+	} else {
+		sprintf(disk->disk_name, "md%c", 'a' + index % 26);
+	}
 	disk->fops = &md_fops;
 	disk->private_data = mddev;
 	disk->queue = mddev->queue;
@@ -2512,18 +2523,21 @@
 	 * 4 sectors (with a BIG number of cylinders...). This drives
 	 * dosfs just mad... ;-)
 	 */
+#define MD_HEADS	254
+#define MD_SECTORS	60
 		case HDIO_GETGEO:
 			if (!loc) {
 				err = -EINVAL;
 				goto abort_unlock;
 			}
-			err = put_user (2, (char *) &loc->heads);
+			err = put_user (MD_HEADS, (char *) &loc->heads);
 			if (err)
 				goto abort_unlock;
-			err = put_user (4, (char *) &loc->sectors);
+			err = put_user (MD_SECTORS, (char *) &loc->sectors);
 			if (err)
 				goto abort_unlock;
-			err = put_user(get_capacity(disks[mdidx(mddev)])/8,
+			err = put_user(get_capacity(disks[mdidx(mddev)]) /
+						(MD_HEADS * MD_SECTORS),
 						(short *) &loc->cylinders);
 			if (err)
 				goto abort_unlock;

--------------080105000606050407080902--

