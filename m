Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVAQVu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVAQVu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVAQVu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:50:59 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:52883 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261458AbVAQVtP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:15 -0500
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: fix __init calling __exit
In-Reply-To: <11059983001178@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:45:00 -0800
Message-Id: <1105998300627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2333, 2005/01/14 12:09:10-08:00, ecashin@coraid.com

[PATCH] aoe: fix __init calling __exit

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

Don't call __exit functions from __init functions.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/aoe/aoechr.c  |    2 +-
 drivers/block/aoe/aoedev.c  |    2 +-
 drivers/block/aoe/aoemain.c |   44 +++++++++++++++++++++++++++++++-------------
 drivers/block/aoe/aoenet.c  |    2 +-
 4 files changed, 34 insertions(+), 16 deletions(-)


diff -Nru a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
--- a/drivers/block/aoe/aoechr.c	2005-01-17 13:34:56 -08:00
+++ b/drivers/block/aoe/aoechr.c	2005-01-17 13:34:56 -08:00
@@ -266,7 +266,7 @@
 	return 0;
 }
 
-void __exit
+void
 aoechr_exit(void)
 {
 	int i;
diff -Nru a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
--- a/drivers/block/aoe/aoedev.c	2005-01-17 13:34:56 -08:00
+++ b/drivers/block/aoe/aoedev.c	2005-01-17 13:34:56 -08:00
@@ -151,7 +151,7 @@
 	kfree(d);
 }
 
-void __exit
+void
 aoedev_exit(void)
 {
 	struct aoedev *d;
diff -Nru a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
--- a/drivers/block/aoe/aoemain.c	2005-01-17 13:34:56 -08:00
+++ b/drivers/block/aoe/aoemain.c	2005-01-17 13:34:56 -08:00
@@ -53,7 +53,7 @@
 	}
 }
 
-static void __exit
+static void
 aoe_exit(void)
 {
 	discover_timer(TKILL);
@@ -68,25 +68,43 @@
 static int __init
 aoe_init(void)
 {
-	int n, (**p)(void);
-	int (*fns[])(void) = {
-		aoedev_init, aoechr_init, aoeblk_init, aoenet_init, NULL
-	};
+	int ret;
 
-	for (p=fns; *p != NULL; p++) {
-		n = (*p)();
-		if (n) {
-			aoe_exit();
-			printk(KERN_INFO "aoe: aoe_init: initialisation failure.\n");
-			return n;
-		}
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
diff -Nru a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
--- a/drivers/block/aoe/aoenet.c	2005-01-17 13:34:56 -08:00
+++ b/drivers/block/aoe/aoenet.c	2005-01-17 13:34:56 -08:00
@@ -164,7 +164,7 @@
 	return 0;
 }
 
-void __exit
+void
 aoenet_exit(void)
 {
 	dev_remove_pack(&aoe_pt);

