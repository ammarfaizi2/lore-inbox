Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVFUH1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVFUH1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVFUHYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:24:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:52451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261989AbVFUGay convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:54 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the miscdevice devfs_name field as it's no longer needed
In-Reply-To: <11193354432042@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <1119335443465@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the miscdevice devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 897ce8a75250fc3d857a017d85b927e4bb57bcb5
tree d9cabfb3e6e171cffb096fc6fe7677d323421d3d
parent 8e645603e0aec2d8f73367861b43f740e313d28d
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:36 -0700

 arch/i386/kernel/microcode.c        |    1 -
 arch/sh/kernel/cpu/sh4/sq.c         |    1 -
 drivers/block/pktcdvd.c             |    1 -
 drivers/char/misc.c                 |    4 ----
 drivers/char/mmtimer.c              |    1 -
 drivers/md/dm-ioctl.c               |    1 -
 drivers/media/radio/miropcm20-rds.c |    1 -
 drivers/net/tun.c                   |    1 -
 drivers/s390/char/monreader.c       |    1 -
 drivers/s390/crypto/z90main.c       |    1 -
 include/linux/miscdevice.h          |    1 -
 11 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/i386/kernel/microcode.c b/arch/i386/kernel/microcode.c
--- a/arch/i386/kernel/microcode.c
+++ b/arch/i386/kernel/microcode.c
@@ -480,7 +480,6 @@ static struct file_operations microcode_
 static struct miscdevice microcode_dev = {
 	.minor		= MICROCODE_MINOR,
 	.name		= "microcode",
-	.devfs_name	= "cpu/microcode",
 	.fops		= &microcode_fops,
 };
 
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -417,7 +417,6 @@ static struct file_operations sq_fops = 
 static struct miscdevice sq_dev = {
 	.minor		= STORE_QUEUE_MINOR,
 	.name		= "sq",
-	.devfs_name	= "cpu/sq",
 	.fops		= &sq_fops,
 };
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2633,7 +2633,6 @@ static struct file_operations pkt_ctl_fo
 static struct miscdevice pkt_misc = {
 	.minor 		= MISC_DYNAMIC_MINOR,
 	.name  		= "pktcdvd",
-	.devfs_name 	= "pktcdvd/control",
 	.fops  		= &pkt_ctl_fops
 };
 
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -231,10 +231,6 @@ int misc_register(struct miscdevice * mi
 
 	if (misc->minor < DYNAMIC_MINORS)
 		misc_minors[misc->minor >> 3] |= 1 << (misc->minor & 7);
-	if (misc->devfs_name[0] == '\0') {
-		snprintf(misc->devfs_name, sizeof(misc->devfs_name),
-				"misc/%s", misc->name);
-	}
 	dev = MKDEV(MISC_MAJOR, misc->minor);
 
 	misc->class = class_device_create(misc_class, dev, misc->dev,
diff --git a/drivers/char/mmtimer.c b/drivers/char/mmtimer.c
--- a/drivers/char/mmtimer.c
+++ b/drivers/char/mmtimer.c
@@ -704,7 +704,6 @@ static int __init mmtimer_init(void)
 		return -1;
 	}
 
-	strcpy(mmtimer_miscdev.devfs_name, MMTIMER_NAME);
 	if (misc_register(&mmtimer_miscdev)) {
 		printk(KERN_ERR "%s: failed to register device\n",
 		       MMTIMER_NAME);
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1350,7 +1350,6 @@ static struct file_operations _ctl_fops 
 static struct miscdevice _dm_misc = {
 	.minor 		= MISC_DYNAMIC_MINOR,
 	.name  		= DM_NAME,
-	.devfs_name 	= "mapper/control",
 	.fops  		= &_ctl_fops
 };
 
diff --git a/drivers/media/radio/miropcm20-rds.c b/drivers/media/radio/miropcm20-rds.c
--- a/drivers/media/radio/miropcm20-rds.c
+++ b/drivers/media/radio/miropcm20-rds.c
@@ -114,7 +114,6 @@ static struct file_operations rds_fops =
 static struct miscdevice rds_miscdev = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "radiotext",
-	.devfs_name	= "v4l/rds/radiotext",
 	.fops		= &rds_fops,
 };
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -759,7 +759,6 @@ static struct miscdevice tun_miscdev = {
 	.minor = TUN_MINOR,
 	.name = "tun",
 	.fops = &tun_fops,
-	.devfs_name = "net/tun",
 };
 
 /* ethtool interface */
diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -588,7 +588,6 @@ static struct file_operations mon_fops =
 
 static struct miscdevice mon_dev = {
 	.name       = "monreader",
-	.devfs_name = "monreader",
 	.fops       = &mon_fops,
 	.minor      = MISC_DYNAMIC_MINOR,
 };
diff --git a/drivers/s390/crypto/z90main.c b/drivers/s390/crypto/z90main.c
--- a/drivers/s390/crypto/z90main.c
+++ b/drivers/s390/crypto/z90main.c
@@ -449,7 +449,6 @@ static struct miscdevice z90crypt_misc_d
 	.minor	    = Z90CRYPT_MINOR,
 	.name	    = DEV_NAME,
 	.fops	    = &z90crypt_fops,
-	.devfs_name = DEV_NAME
 };
 #endif
 
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -40,7 +40,6 @@ struct miscdevice  {
 	struct list_head list;
 	struct device *dev;
 	struct class_device *class;
-	char devfs_name[64];
 };
 
 extern int misc_register(struct miscdevice * misc);

