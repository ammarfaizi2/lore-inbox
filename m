Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVAMRjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVAMRjC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVAMRhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:37:07 -0500
Received: from main.gmane.org ([80.91.229.2]:10708 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261331AbVAMRfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:35:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: [PATCH] Re: [BUG] ATA over Ethernet __init calling __exit
Date: Thu, 13 Jan 2005 12:35:05 -0500
Message-ID: <871xcp9qra.fsf@coraid.com>
References: <20050113000949.A7449@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Complaints-To: usenet@sea.gmane.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>
X-Gmane-NNTP-Posting-Host: adsl-214-28-36.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:4Drp1rMy6sL8FD2VtXL7pKLvEqU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> static void __exit
> aoe_exit(void)
> {
> ...
> }
>
> static int __init
> aoe_init(void)
> {
> ...
>                         aoe_exit();
> ...
> }

Thanks for catching that.  I cleaned up the error handling, too.

> In addition, please shoot the author in the other foot for:
>
> config ATA_OVER_ETH
>         tristate "ATA over Ethernet support"
>         depends on NET
>         default m               <==== this line.
>
> That's not nice for embedded guys who do a "make xxx_defconfig" and
> unsuspectingly end up with ATA over Ethernet built in for their
> platform.

OK, thanks.  The patch below gets rid of that Kconfig line and
fixes the bug where __init code calls __exit code.

It depends on the recently-submitted patch that elimimates sleeping
with interrupts off, so it applies cleanly to Greg KH's usb tree.


Don't call __exit functions from __init functions.
Default to not configuring AoE support in kernel.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>


--=-=-=
Content-Disposition: inline; filename=diff-exit-usb

diff -urpN usb-2.6-export-a/drivers/block/Kconfig usb-2.6-export-b/drivers/block/Kconfig
--- usb-2.6-export-a/drivers/block/Kconfig	2005-01-13 09:44:25.000000000 -0500
+++ usb-2.6-export-b/drivers/block/Kconfig	2005-01-13 12:07:56.000000000 -0500
@@ -449,7 +449,6 @@ source "drivers/block/Kconfig.iosched"
 config ATA_OVER_ETH
 	tristate "ATA over Ethernet support"
 	depends on NET
-	default m
 	help
 	This driver provides Support for ATA over Ethernet block
 	devices like the Coraid EtherDrive (R) Storage Blade.
diff -urpN usb-2.6-export-a/drivers/block/aoe/aoechr.c usb-2.6-export-b/drivers/block/aoe/aoechr.c
--- usb-2.6-export-a/drivers/block/aoe/aoechr.c	2005-01-13 09:47:33.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoechr.c	2005-01-13 10:59:23.000000000 -0500
@@ -266,7 +266,7 @@ aoechr_init(void)
 	return 0;
 }
 
-void __exit
+void
 aoechr_exit(void)
 {
 	int i;
diff -urpN usb-2.6-export-a/drivers/block/aoe/aoedev.c usb-2.6-export-b/drivers/block/aoe/aoedev.c
--- usb-2.6-export-a/drivers/block/aoe/aoedev.c	2005-01-13 09:44:00.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoedev.c	2005-01-13 10:59:23.000000000 -0500
@@ -159,7 +159,7 @@ aoedev_freedev(struct aoedev *d)
 	kfree(d);
 }
 
-void __exit
+void
 aoedev_exit(void)
 {
 	struct aoedev *d;
diff -urpN usb-2.6-export-a/drivers/block/aoe/aoemain.c usb-2.6-export-b/drivers/block/aoe/aoemain.c
--- usb-2.6-export-a/drivers/block/aoe/aoemain.c	2005-01-13 09:46:44.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoemain.c	2005-01-13 10:59:23.000000000 -0500
@@ -53,7 +53,7 @@ discover_timer(ulong vp)
 	}
 }
 
-static void __exit
+static void
 aoe_exit(void)
 {
 	discover_timer(TKILL);
@@ -67,25 +67,43 @@ aoe_exit(void)
 static int __init
 aoe_init(void)
 {
-	int n, (**p)(void);
-	int (*fns[])(void) = {
-		aoedev_init, aoechr_init, aoeblk_init, aoenet_init, NULL
-	};
-
-	for (p=fns; *p != NULL; p++) {
-		n = (*p)();
-		if (n) {
-			aoe_exit();
-			printk(KERN_INFO "aoe: aoe_init: initialisation failure.\n");
-			return n;
-		}
+	int ret;
+
+	ret = aoedev_init();
+	if (ret)
+		return ret;
+	ret = aoechr_init();
+	if (ret)
+		goto chr_fail;
+	ret = aoeblk_init();
+	if (ret)
+		goto blk_fail;
+	ret = aoenet_init();
+	if (ret)
+		goto net_fail;
+	ret = register_blkdev(AOE_MAJOR, DEVICE_NAME);
+	if (ret < 0) {
+		printk(KERN_ERR "aoe: aoeblk_init: can't register major\n");
+		goto blkreg_fail;
 	}
+
 	printk(KERN_INFO
 	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
 	       VERSION);
-
 	discover_timer(TINIT);
 	return 0;
+
+ blkreg_fail:
+	aoenet_exit();
+ net_fail:
+	aoeblk_exit();
+ blk_fail:
+	aoechr_exit();
+ chr_fail:
+	aoedev_exit();
+	
+	printk(KERN_INFO "aoe: aoe_init: initialisation failure.\n");
+	return ret;
 }
 
 module_init(aoe_init);
diff -urpN usb-2.6-export-a/drivers/block/aoe/aoenet.c usb-2.6-export-b/drivers/block/aoe/aoenet.c
--- usb-2.6-export-a/drivers/block/aoe/aoenet.c	2005-01-13 09:45:02.000000000 -0500
+++ usb-2.6-export-b/drivers/block/aoe/aoenet.c	2005-01-13 10:59:23.000000000 -0500
@@ -167,7 +167,7 @@ aoenet_init(void)
 	return 0;
 }
 
-void __exit
+void
 aoenet_exit(void)
 {
 	dev_remove_pack(&aoe_pt);

--=-=-=



-- 
  Ed L Cashin <ecashin@coraid.com>

--=-=-=--

