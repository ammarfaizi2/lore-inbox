Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262221AbULQW5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbULQW5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbULQW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:56:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:20181 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262226AbULQWyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:54:13 -0500
Date: Fri, 17 Dec 2004 14:53:49 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
Message-ID: <20041217225349.GA23442@kroah.com>
References: <87k6rhc4uk.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6rhc4uk.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 10:38:27AM -0500, Ed L Cashin wrote:
> I've implemented the second round of changes suggested here for the
> AoE driver.  Here's a list of changes since December 13 when the
> revised 2.6.9 patch was submitted.
> 
> Greg KH suggestions:
>   * remove stat char device and put status info into sysfs
>   * split ctl char device into discover and interfaces
>   * use MODULE_VERSION
>   * remove unused macros from aoe.h
>   * make struct tags lowercase
> 
> Jens Axboe suggestions:
>   * use GFP_NOIO in make_request_fn on mempool alloc
> 
> 
> Provide support for ATA over Ethernet devices

Looks good.  I've added this to my driver bk tree and it will show up
in the next -mm release, and I'll forward it on to Linus after 2.6.10 is
out.

Oh, I applied the following patch on top of yours, to get rid of the
sparse warnings, and get rid of a kmalloc that could have been
potentially pretty nasty in your write() function.  It saved a bit of
code too :)

thanks,

greg k-h

----------

AOE: fix up sparse warnings and get rid of a kmalloc in the aoe driver.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2004-12-17 14:48:49 -08:00
+++ b/drivers/block/aoe/aoe.h	2004-12-17 14:48:49 -08:00
@@ -158,6 +158,6 @@
 void aoenet_exit(void);
 void aoenet_xmit(struct sk_buff *);
 int is_aoe_netif(struct net_device *ifp);
-int set_aoe_iflist(char *str);
+int set_aoe_iflist(const char __user *str, size_t size);
 
 u64 mac_addr(char addr[6]);
diff -Nru a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
--- a/drivers/block/aoe/aoeblk.c	2004-12-17 14:48:49 -08:00
+++ b/drivers/block/aoe/aoeblk.c	2004-12-17 14:48:49 -08:00
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
--- a/drivers/block/aoe/aoechr.c	2004-12-17 14:48:49 -08:00
+++ b/drivers/block/aoe/aoechr.c	2004-12-17 14:48:49 -08:00
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
--- a/drivers/block/aoe/aoenet.c	2004-12-17 14:48:49 -08:00
+++ b/drivers/block/aoe/aoenet.c	2004-12-17 14:48:49 -08:00
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
 
