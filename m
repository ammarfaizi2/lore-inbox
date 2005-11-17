Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVKQTc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVKQTc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVKQTc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:32:26 -0500
Received: from hera.kernel.org ([140.211.167.34]:60844 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964797AbVKQTcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:32:25 -0500
Date: Thu, 17 Nov 2005 12:14:32 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] skip initramfs check
Message-ID: <20051117141432.GD9753@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The initramfs check at populate_rootfs() can consume significant time
(several seconds) on slow/embedded platforms, since it has to decompress
the image.

Add an option to skip it under CONFIG_EMBEDDED.

Is there a nicer way to achieve the same result?

diff --git a/init/Kconfig b/init/Kconfig
index ea097e0..a9d709e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -398,6 +398,16 @@ config CC_ALIGN_JUMPS
 	  no dummy operations need be executed.
 	  Zero means use compiler's default.
 
+config INITRAMFS_SKIP
+	bool "Skip initramfs verification of initrd" if EMBEDDED
+	default n
+	help
+	  By default the initialization code uncompresses the initrd image to 
+	  verify if it is a initramfs image. 
+
+	  Say Y here if you are sure not to be using initramfs and want to
+	  skip that test.
+
 endmenu		# General setup
 
 config TINY_SHMEM
diff --git a/init/initramfs.c b/init/initramfs.c
index 0c5d9a3..92628b0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -486,6 +486,7 @@ void __init populate_rootfs(void)
 	if (initrd_start) {
 		int fd;
 		printk(KERN_INFO "checking if image is initramfs...");
+#ifndef CONFIG_INITRAMFS_SKIP
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start, 1);
 		if (!err) {
@@ -495,6 +496,7 @@ void __init populate_rootfs(void)
 			free_initrd();
 			return;
 		}
+#endif
 		printk("it isn't (%s); looks like an initrd\n", err);
 		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 700);
 		if (fd >= 0) {
