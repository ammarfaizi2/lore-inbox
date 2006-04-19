Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWDSGwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDSGwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDSGwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:52:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:33243 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWDSGwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:52:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d9zJlUycf6Fzyk8+32cV2tD0vO+am/b94oLgjJ4+/tsFiBvHZCjKPu9/JMzle1J1tgReglIJiVeU/1Z2TUOpUh+V0DfMA0j68WbcazdrWSdfUyRLkMya1zqGr0gVR7pBK7D8ilg6N3a+rcn6fH2k89HHoUhe1o1HEt4EDYpE/HA=
Message-ID: <3b8510d80604182352v11fea186lde1b9987447a3318@mail.gmail.com>
Date: Wed, 19 Apr 2006 12:22:03 +0530
From: "Thayumanavar Sachithanantham" <thayumk@gmail.com>
To: akpm@osdl.org, info-linux@geode.amd.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: [PATCH]drivers/char/cs5535_gpio.c:call cdev_del during module_exit to unmap kobject references and other cleanups.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During module unloading, cdev_del be called to unmap cdev related
kobject references and other cleanups(such as inode->i_cdev being set
to NULL) which prevents the OOPS upon subsequent loading ,usage and
unloading of modules(as
seen in the mail thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=114533640609018&w=2).
Patch against 2.6.17-rc1

Signed-off-by: Thayumanavar Sachithanantham <thayumk@gmail.com>

--- linux-2.6/drivers/char/cs5535_gpio.c.orig   2006-04-17
21:37:25.000000000 -0700
+++ linux-2.6/drivers/char/cs5535_gpio.c        2006-04-17
21:38:24.000000000 -0700
@@ -241,6 +241,7 @@ static int __init cs5535_gpio_init(void)
 static void __exit cs5535_gpio_cleanup(void)
 {
        dev_t dev_id = MKDEV(major, 0);
+        cdev_del(&cs5535_gpio_cdev);
        unregister_chrdev_region(dev_id, CS5535_GPIO_COUNT);
        if (gpio_base != 0)
                release_region(gpio_base, CS5535_GPIO_SIZE);
