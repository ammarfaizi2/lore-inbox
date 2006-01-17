Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWAQRxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWAQRxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWAQRxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:53:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:42404 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932255AbWAQRxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:53:37 -0500
Subject: PATCH: SBC EPX does not check/claim I/O ports it uses
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: calin@ajvar.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 17:52:31 +0000
Message-Id: <1137520351.14135.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

Can't test this as I lack the hardware, can you check it seems right
Calin.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c linux-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c
--- linux.vanilla-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c	2006-01-17 15:52:53.000000000 +0000
+++ linux-2.6.16-rc1/drivers/char/watchdog/sbc_epx_c3.c	2006-01-17 15:58:47.000000000 +0000
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -180,6 +181,9 @@
 static int __init watchdog_init(void)
 {
 	int ret;
+	
+	if (!request_region(EPXC3_WATCHDOG_CTL_REG, 2, "epxc3_watchdog"))
+		return -EBUSY;
 
 	ret = register_reboot_notifier(&epx_c3_notifier);
 	if (ret) {
@@ -205,6 +209,7 @@
 {
 	misc_deregister(&epx_c3_miscdev);
 	unregister_reboot_notifier(&epx_c3_notifier);
+	release_region(EPXC3_WATCHDOG_CTL_REG, 2);
 }
 
 module_init(watchdog_init);

