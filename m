Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWGLRWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWGLRWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGLRWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:22:12 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:6605 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932147AbWGLRWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:22:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=YllHntoP95CUzVVAibZHBZi8Mm3MqOJbTFFgV2OMmgIthhAxW1z9aMvFD+XaisNLwcGSlo3oKEm9wF+80BLIKLvUY0jQCv27w6q0bmcWgtjWQGyFqIGWPWydjLoIgisE/CQSicjMW/gXq35LsquyNYbifg/dKxoK5FlCJkEmqYE=
Message-ID: <44B52FC7.7090900@gmail.com>
Date: Wed, 12 Jul 2006 11:22:15 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ patch -mm1 03/03 ] gpio: rename exported vtables to better match
 purpose
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3 - rename EXPORTed  gpio vtables  from {scx200,pc8736x}_access to  
_gpio_ops
new name is much closer to the vtable-name struct nsc_gpio_ops, should 
be clearer.
Also rename the _fops vtable var to _fileops to better disambiguate it 
from the gpio vtable.

Signed-off-by  Jim Cromie  <jim.cromie@gmail.com>

---

$ diffstat diff.rename-exports
 pc8736x_gpio.c |   13 ++++++-------
 scx200_gpio.c  |   12 ++++++------
 2 files changed, 12 insertions(+), 13 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs a0-1-cosmetic/drivers/char/pc8736x_gpio.c a0-2-renames/drivers/char/pc8736x_gpio.c
--- a0-1-cosmetic/drivers/char/pc8736x_gpio.c	2006-07-12 09:21:58.000000000 -0600
+++ a0-2-renames/drivers/char/pc8736x_gpio.c	2006-07-12 10:32:59.000000000 -0600
@@ -212,7 +212,7 @@ static void pc8736x_gpio_change(unsigned
 	pc8736x_gpio_set(index, !pc8736x_gpio_current(index));
 }
 
-static struct nsc_gpio_ops pc8736x_access = {
+static struct nsc_gpio_ops pc8736x_gpio_ops = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= pc8736x_gpio_configure,
 	.gpio_dump	= nsc_gpio_dump,
@@ -221,11 +221,12 @@ static struct nsc_gpio_ops pc8736x_acces
 	.gpio_change	= pc8736x_gpio_change,
 	.gpio_current	= pc8736x_gpio_current
 };
+EXPORT_SYMBOL(pc8736x_gpio_ops);
 
 static int pc8736x_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
-	file->private_data = &pc8736x_access;
+	file->private_data = &pc8736x_gpio_ops;
 
 	dev_dbg(&pdev->dev, "open %d\n", m);
 
@@ -234,7 +235,7 @@ static int pc8736x_gpio_open(struct inod
 	return nonseekable_open(inode, file);
 }
 
-static const struct file_operations pc8736x_gpio_fops = {
+static const struct file_operations pc8736x_gpio_fileops = {
 	.owner	= THIS_MODULE,
 	.open	= pc8736x_gpio_open,
 	.write	= nsc_gpio_write,
@@ -276,7 +277,7 @@ static int __init pc8736x_gpio_init(void
 		dev_err(&pdev->dev, "no device found\n");
 		goto undo_platform_dev_add;
 	}
-	pc8736x_access.dev = &pdev->dev;
+	pc8736x_gpio_ops.dev = &pdev->dev;
 
 	/* Verify that chip and it's GPIO unit are both enabled.
 	   My BIOS does this, so I take minimum action here
@@ -326,7 +327,7 @@ static int __init pc8736x_gpio_init(void
 	pc8736x_init_shadow();
 
 	/* ignore minor errs, and succeed */
-	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fops);
+	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fileops);
 	cdev_add(&pc8736x_gpio_cdev, devid, PC8736X_GPIO_CT);
 
 	return 0;
@@ -353,7 +354,5 @@ static void __exit pc8736x_gpio_cleanup(
 	platform_device_put(pdev);
 }
 
-EXPORT_SYMBOL(pc8736x_access);
-
 module_init(pc8736x_gpio_init);
 module_exit(pc8736x_gpio_cleanup);
diff -ruNp -X dontdiff -X exclude-diffs a0-1-cosmetic/drivers/char/scx200_gpio.c a0-2-renames/drivers/char/scx200_gpio.c
--- a0-1-cosmetic/drivers/char/scx200_gpio.c	2006-07-12 09:20:55.000000000 -0600
+++ a0-2-renames/drivers/char/scx200_gpio.c	2006-07-12 10:34:26.000000000 -0600
@@ -35,7 +35,7 @@ MODULE_PARM_DESC(major, "Major device nu
 
 #define MAX_PINS 32		/* 64 later, when known ok */
 
-struct nsc_gpio_ops scx200_access = {
+struct nsc_gpio_ops scx200_gpio_ops = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= scx200_gpio_configure,
 	.gpio_dump	= nsc_gpio_dump,
@@ -44,12 +44,12 @@ struct nsc_gpio_ops scx200_access = {
 	.gpio_change	= scx200_gpio_change,
 	.gpio_current	= scx200_gpio_current
 };
-EXPORT_SYMBOL(scx200_access);
+EXPORT_SYMBOL(scx200_gpio_ops);
 
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
-	file->private_data = &scx200_access;
+	file->private_data = &scx200_gpio_ops;
 
 	if (m >= MAX_PINS)
 		return -EINVAL;
@@ -61,7 +61,7 @@ static int scx200_gpio_release(struct in
 	return 0;
 }
 
-static const struct file_operations scx200_gpio_fops = {
+static const struct file_operations scx200_gpio_fileops = {
 	.owner   = THIS_MODULE,
 	.write   = nsc_gpio_write,
 	.read    = nsc_gpio_read,
@@ -91,7 +91,7 @@ static int __init scx200_gpio_init(void)
 		goto undo_malloc;
 
 	/* nsc_gpio uses dev_dbg(), so needs this */
-	scx200_access.dev = &pdev->dev;
+	scx200_gpio_ops.dev = &pdev->dev;
 
 	if (major) {
 		devid = MKDEV(major, 0);
@@ -105,7 +105,7 @@ static int __init scx200_gpio_init(void)
 		goto undo_platform_device_add;
 	}
 
-	cdev_init(&scx200_gpio_cdev, &scx200_gpio_fops);
+	cdev_init(&scx200_gpio_cdev, &scx200_gpio_fileops);
 	cdev_add(&scx200_gpio_cdev, devid, MAX_PINS);
 
 	return 0; /* succeed */


