Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVAHJTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVAHJTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbVAHJTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:19:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:40325 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261854AbVAHFsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:13 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163259475@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <1105163260958@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.10, 2004/12/17 14:50:58-08:00, greg@kroah.com

[PATCH] AOE: fix up sparse warnings and get rid of a kmalloc in the aoe driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/aoe/aoe.h    |    2 +-
 drivers/block/aoe/aoeblk.c |    4 ++--
 drivers/block/aoe/aoechr.c |   28 ++++++----------------------
 drivers/block/aoe/aoenet.c |   12 +++++++-----
 4 files changed, 16 insertions(+), 30 deletions(-)


diff -Nru a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-01-07 15:45:38 -08:00
+++ b/drivers/block/aoe/aoe.h	2005-01-07 15:45:38 -08:00
@@ -158,6 +158,6 @@
 void aoenet_exit(void);
 void aoenet_xmit(struct sk_buff *);
 int is_aoe_netif(struct net_device *ifp);
-int set_aoe_iflist(char *str);
+int set_aoe_iflist(const char __user *str, size_t size);
 
 u64 mac_addr(char addr[6]);
diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2005-01-07 15:45:38 -08:00
+++ b/drivers/block/aoe/aoeblk.c	2005-01-07 15:45:38 -08:00
@@ -170,7 +170,7 @@
 
 	if (cmd == HDIO_GETGEO) {
 		d->geo.start = get_start_sect(inode->i_bdev);
-		if (!copy_to_user((void *) arg, &d->geo, sizeof d->geo))
+		if (!copy_to_user((void __user *) arg, &d->geo, sizeof d->geo))
 			return 0;
 		return -EFAULT;
 	}
@@ -227,7 +227,7 @@
 	
 	printk(KERN_INFO "aoe: %012llx e%lu.%lu v%04x has %llu "
 		"sectors\n", mac_addr(d->addr), d->aoemajor, d->aoeminor,
-		d->fw_ver, d->ssize);
+		d->fw_ver, (long long)d->ssize);
 }
 
 void __exit
diff -Nru a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
--- a/drivers/block/aoe/aoechr.c	2005-01-07 15:45:38 -08:00
+++ b/drivers/block/aoe/aoechr.c	2005-01-07 15:45:38 -08:00
@@ -51,9 +51,9 @@
 }
 
 static int
-interfaces(char *str)
+interfaces(const char __user *str, size_t size)
 {
-	if (set_aoe_iflist(str)) {
+	if (set_aoe_iflist(str, size)) {
 		printk(KERN_CRIT
 		       "%s: could not set interface list: %s\n",
 		       __FUNCTION__, "too many interfaces");
@@ -135,24 +135,10 @@
 }
 
 static ssize_t
-aoechr_write(struct file *filp, const char *buf, size_t cnt, loff_t *offp)
+aoechr_write(struct file *filp, const char __user *buf, size_t cnt, loff_t *offp)
 {
-	char *str = kcalloc(1, cnt+1, GFP_KERNEL);
-	int ret;
+	int ret = -EINVAL;
 
-	if (!str) {
-		printk(KERN_CRIT "aoe: aoechr_write: cannot allocate memory\n");
-		return -ENOMEM;
-	}
-
-	ret = -EFAULT;
-	if (copy_from_user(str, buf, cnt)) {
-		printk(KERN_INFO "aoe: aoechr_write: copy from user failed\n");
-		goto out;
-	}
-
-	str[cnt] = '\0';
-	ret = -EINVAL;
 	switch ((unsigned long) filp->private_data) {
 	default:
 		printk(KERN_INFO "aoe: aoechr_write: can't write to that file.\n");
@@ -161,13 +147,11 @@
 		ret = discover();
 		break;
 	case MINOR_INTERFACES:
-		ret = interfaces(str);
+		ret = interfaces(buf, cnt);
 		break;
 	}
 	if (ret == 0)
 		ret = cnt;
- out:
-	kfree(str);
 	return ret;
 }
 
@@ -192,7 +176,7 @@
 }
 
 static ssize_t
-aoechr_read(struct file *filp, char *buf, size_t cnt, loff_t *off)
+aoechr_read(struct file *filp, char __user *buf, size_t cnt, loff_t *off)
 {
 	int n;
 	char *mp;
diff -Nru a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
--- a/drivers/block/aoe/aoenet.c	2005-01-07 15:45:38 -08:00
+++ b/drivers/block/aoe/aoenet.c	2005-01-07 15:45:38 -08:00
@@ -53,14 +53,16 @@
 }
 
 int
-set_aoe_iflist(char *str)
+set_aoe_iflist(const char __user *user_str, size_t size)
 {
-	int len = strlen(str);
-
-	if (len >= IFLISTSZ)
+	if (size >= IFLISTSZ)
 		return -EINVAL;
 
-	strcpy(aoe_iflist, str);
+	if (copy_from_user(aoe_iflist, user_str, size)) {
+		printk(KERN_INFO "aoe: %s: copy from user failed\n", __FUNCTION__);
+		return -EFAULT;
+	}
+	aoe_iflist[size] = 0x00;
 	return 0;
 }
 

