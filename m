Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWCJMha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWCJMha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWCJMha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:37:30 -0500
Received: from smtp.nextra.cz ([195.70.130.5]:34572 "EHLO smtp.nextra.cz")
	by vger.kernel.org with ESMTP id S1750843AbWCJMh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:37:29 -0500
Message-ID: <441172EF.1010004@nextra.cz>
Date: Fri, 10 Mar 2006 13:37:03 +0100
From: Zdenek Pavlas <pavlas@nextra.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BLK_DEV_INITRD: do not require BLK_DEV_RAM=y
Content-Type: multipart/mixed;
 boundary="------------060700040707030409050001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060700040707030409050001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Initramfs initrd images do not need a ramdisk device, so remove this restriction 
in Kconfig.  BLK_DEV_RAM=n saves about 13k on i386.  Also without ramdisk device 
there's no need for "dry run", so initramfs unpacks much faster.

People using cramfs, squashfs, or gzipped ext2/minix initrd images are probably 
smart enough not to turn off ramdisk support by accident.

-- 
Zdenek Pavlas

--------------060700040707030409050001
Content-Type: text/plain;
 name="initrd-without-ramdisk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initrd-without-ramdisk.patch"

--- linux-2.6.15.6/drivers/block/Kconfig	2006-03-05 20:07:54.000000000 +0100
+++ linux/drivers/block/Kconfig	2006-03-10 11:47:35.666970832 +0100
@@ -400,7 +400,6 @@
 
 config BLK_DEV_INITRD
 	bool "Initial RAM disk (initrd) support"
-	depends on BLK_DEV_RAM=y
 	help
 	  The initial RAM disk is a RAM disk that is loaded by the boot loader
 	  (loadlin or lilo) and that is mounted as root before the normal boot
--- linux-2.6.15.6/init/initramfs.c	2006-03-05 20:07:54.000000000 +0100
+++ linux/init/initramfs.c	2006-03-10 11:59:50.000000000 +0100
@@ -484,6 +484,7 @@
 		panic(err);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
+#ifdef CONFIG_BLK_DEV_RAM
 		int fd;
 		printk(KERN_INFO "checking if image is initramfs...");
 		err = unpack_to_rootfs((char *)initrd_start,
@@ -503,6 +504,15 @@
 			sys_close(fd);
 			free_initrd();
 		}
+#else
+		printk(KERN_INFO "Unpacking initramfs...");
+		err = unpack_to_rootfs((char *)initrd_start,
+			initrd_end - initrd_start, 0);
+		if (err)
+			panic(err);
+		printk(" done\n");
+		free_initrd();
+#endif
 	}
 #endif
 }

--------------060700040707030409050001--
