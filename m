Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWGHOej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWGHOej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWGHOej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:34:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:42999 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964858AbWGHOei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:34:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s4nGEM5aiZOv8V/iSc7oqvdrmXdaK/eFaR46r/JY0ETq2XP4111Dn+Pd88xO/9AN06wnixaXylvzcedyQYuORVkS+PF+SYX7/lgWDHrgbyVN2OVaaGjfeemirmqeQJh484ssMH/Z0nzc+HjF46uoOlL9+Jfrl4BG8weYAH12V6k=
Message-ID: <44AFC282.2060304@gmail.com>
Date: Sat, 08 Jul 2006 08:34:42 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patchset 3/3 -2.6.18-rc1]  pc8736x_gpio:  fix re-modprobe errors
 - fix/finish cdev-init
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org> <44AFBCB5.4040409@gmail.com>
In-Reply-To: <44AFBCB5.4040409@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3 - pc-init-fix-chrdev-region-rollup

- Switch from register_chrdev() to   (register|alloc)_chrdev_region().

- use a cdev.   This was intended for original patchset, but was 
overlooked.
We use a single cdev for all pins (minor device-numbers), as gleaned 
from cs5535_gpio,
and in contrast to whats currently done in scx200_gpio (which I'll fix 
soon)

Signed-off-by:  Jim Cromie  <jim.cromie@gmail.com>


$ diffstat pc-init-fix-chrdev-region-rollup
 pc8736x_gpio.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

---

diff -ruNp -X dontdiff -X exclude-diffs x4k-2/drivers/char/pc8736x_gpio.c x4k-3/drivers/char/pc8736x_gpio.c
--- x4k-2/drivers/char/pc8736x_gpio.c	2006-07-07 20:09:38.000000000 -0600
+++ x4k-3/drivers/char/pc8736x_gpio.c	2006-07-07 20:12:05.000000000 -0600
@@ -260,6 +260,7 @@ static struct cdev pc8736x_gpio_cdev;
 static int __init pc8736x_gpio_init(void)
 {
 	int rc = 0;
+	dev_t devid;
 
 	pdev = platform_device_alloc(DEVNAME, 0);
 	if (!pdev)
@@ -307,7 +308,14 @@ static int __init pc8736x_gpio_init(void
 	}
 	dev_info(&pdev->dev, "GPIO ioport %x reserved\n", pc8736x_gpio_base);
 
-	rc = register_chrdev(major, DEVNAME, &pc8736x_gpio_fops);
+	if (major) {
+		devid = MKDEV(major, 0);
+		rc = register_chrdev_region(devid, PC8736X_GPIO_CT, DEVNAME);
+	} else {
+		rc = alloc_chrdev_region(&devid, 0, PC8736X_GPIO_CT, DEVNAME);
+		major = MAJOR(devid);
+	}
+
 	if (rc < 0) {
 		dev_err(&pdev->dev, "register-chrdev failed: %d\n", rc);
 		goto undo_request_region;
@@ -318,6 +326,11 @@ static int __init pc8736x_gpio_init(void
 	}
 
 	pc8736x_init_shadow();
+
+	/* ignore minor errs, and succeed */
+	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fops);
+	cdev_add(&pc8736x_gpio_cdev, devid, PC8736X_GPIO_CT);
+
 	return 0;
 
 undo_request_region:


