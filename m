Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDSHvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDSHvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWDSHvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:51:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:60940 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750730AbWDSHvw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:51:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NZbL8U7ETkSbCHorOrA+75KUJRgLYgipGQzev/sXeDMXeKQ6g7NeX+s9M3UAJb/J5Lp+mFmb+Eu9YJPDaYyLd9wFOjL3r00eIUV4wdsTKa7eYW6rDUNUtjMtuK8WJc380sUJ6vHbiK6rxMUUg3iP5ejcZvj4uAxvYNVUMN76k4k=
Message-ID: <3b8510d80604190051v78c8757fibd30a5abf3efa24f@mail.gmail.com>
Date: Wed, 19 Apr 2006 13:21:51 +0530
From: "Thayumanavar Sachithanantham" <thayumk@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH]drivers/char/cs5535_gpio.c:call cdev_del during module_exit to unmap kobject references and other cleanups.
Cc: info-linux@geode.amd.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
In-Reply-To: <20060419001547.320684bf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3b8510d80604182352v11fea186lde1b9987447a3318@mail.gmail.com>
	 <20060419001547.320684bf.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During module unloading, cdev_del be called to unmap cdev related
kobject references and other cleanups(such as inode->i_cdev being set
to NULL) which prevents the OOPS upon subsequent loading ,usage and
unloading of modules(as seen in the mail thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114533640609018&w=2).

Removed test of gpio_base as it is unneeded and will not be zero at
module unload time.

Signed-off-by: Thayumanavar Sachithanantham <thayumk@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

--- linux-2.6/drivers/char/cs5535_gpio.c.orig	2006-04-17
21:37:25.000000000 -0700
+++ linux-2.6/drivers/char/cs5535_gpio.c	2006-04-17 23:05:49.000000000 -0700
@@ -241,9 +241,9 @@ static int __init cs5535_gpio_init(void)
 static void __exit cs5535_gpio_cleanup(void)
 {
 	dev_t dev_id = MKDEV(major, 0);
+        cdev_del(&cs5535_gpio_cdev);
 	unregister_chrdev_region(dev_id, CS5535_GPIO_COUNT);
-	if (gpio_base != 0)
-		release_region(gpio_base, CS5535_GPIO_SIZE);
+	release_region(gpio_base, CS5535_GPIO_SIZE);
 }

 module_init(cs5535_gpio_init);
