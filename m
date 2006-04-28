Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWD1ASk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWD1ASk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWD1ASS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:18:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14549 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751756AbWD1ASP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:18:15 -0400
Date: Thu, 27 Apr 2006 17:16:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Thayumanavar Sachithanantham <thayumk@gmail.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/24] cs5535_gpio.c: call cdev_del() during module_exit to unmap kobject references and other cleanups
Message-ID: <20060428001639.GC18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cs5535_gpio.c-call-cdev_del-during-module_exit-to-unmap-kobject-references-and-other-cleanups.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Thayumanavar Sachithanantham <thayumk@gmail.com>

[PATCH] cs5535_gpio.c: call cdev_del() during module_exit to unmap kobject references and other cleanups

During module unloading, cdev_del() must be called to unmap cdev related
kobject references and other cleanups(such as inode->i_cdev being set to
NULL) which prevents the OOPS upon subsequent loading, usage and unloading
of modules(as seen in the mail thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=114533640609018&w=2).

Also, remove unneeded test of gpio_base.

Signed-off-by: Thayumanavar Sachithanantham <thayumk@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/cs5535_gpio.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16.11.orig/drivers/char/cs5535_gpio.c
+++ linux-2.6.16.11/drivers/char/cs5535_gpio.c
@@ -241,9 +241,10 @@ static int __init cs5535_gpio_init(void)
 static void __exit cs5535_gpio_cleanup(void)
 {
 	dev_t dev_id = MKDEV(major, 0);
+
+	cdev_del(&cs5535_gpio_cdev);
 	unregister_chrdev_region(dev_id, CS5535_GPIO_COUNT);
-	if (gpio_base != 0)
-		release_region(gpio_base, CS5535_GPIO_SIZE);
+	release_region(gpio_base, CS5535_GPIO_SIZE);
 }
 
 module_init(cs5535_gpio_init);

--
