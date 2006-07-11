Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWGKHRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWGKHRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWGKHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:17:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17822 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965236AbWGKHRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:17:44 -0400
Date: Tue, 11 Jul 2006 17:17:22 +1000
From: Nathan Scott <nathans@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ramdisk blocksize Kconfig entry
Message-ID: <20060711171722.E1710004@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the ramdisk blocksize configurable at kernel
compilation time rather than only at boot or module load time,
like a couple of the other ramdisk options.  I found this handy
awhile back but thought little of it, until recently asked by a
few of the testing folks here to be able to do the same thing
for their automated test setups.

The Kconfig comment is largely lifted from comments in rd.c,
and hopefully this will increase the chances of making folks
aware that the default value often isn't a great choice here
(for increasing values of PAGE_SIZE, even moreso).

Signed-off-by: Nathan Scott <nathans@sgi.com>


Index: ramdisk-2.6/drivers/block/Kconfig
===================================================================
--- ramdisk-2.6.orig/drivers/block/Kconfig	2006-07-11 16:56:03.594339750 +1000
+++ ramdisk-2.6/drivers/block/Kconfig	2006-07-11 16:57:34.984051250 +1000
@@ -400,6 +400,16 @@ config BLK_DEV_RAM_SIZE
 	  what are you doing. If you are using IBM S/390, then set this to
 	  8192.
 
+config BLK_DEV_RAM_BLOCKSIZE
+	int "Default RAM disk block size (bytes)"
+	depends on BLK_DEV_RAM
+	default "1024"
+	help
+	  The default value is 1024 kilobytes.  PAGE_SIZE is a much more
+	  efficient choice however.  The default is kept to ensure initrd
+	  setups function - apparently needed by the rd_load_image routine
+	  that supposes the filesystem in the image uses a 1024 blocksize.
+
 config BLK_DEV_INITRD
 	bool "Initial RAM filesystem and RAM disk (initramfs/initrd) support"
 	depends on BROKEN || !FRV
Index: ramdisk-2.6/drivers/block/rd.c
===================================================================
--- ramdisk-2.6.orig/drivers/block/rd.c	2006-07-11 16:56:06.822541500 +1000
+++ ramdisk-2.6/drivers/block/rd.c	2006-07-11 16:56:47.065056500 +1000
@@ -84,7 +84,7 @@ int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		
  * behaviour. The default is still BLOCK_SIZE (needed by rd_load_image that
  * supposes the filesystem in the image uses a BLOCK_SIZE blocksize).
  */
-static int rd_blocksize = BLOCK_SIZE;		/* blocksize of the RAM disks */
+static int rd_blocksize = CONFIG_BLK_DEV_RAM_BLOCKSIZE;
 
 /*
  * Copyright (C) 2000 Linus Torvalds.
