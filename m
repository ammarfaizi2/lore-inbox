Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWC2LKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWC2LKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 06:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWC2LKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 06:10:37 -0500
Received: from [80.71.248.82] ([80.71.248.82]:41690 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1751149AbWC2LKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 06:10:36 -0500
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, alex@clusterfs.com
Subject: [RFC] support for large I/O requests
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Wed, 29 Mar 2006 15:13:56 +0400
Message-ID: <m31wwljyff.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On some system (DDN, for example), we've observed noticable
performance improvement using large I/O requests (1,2,4 MBs).
please, review the patch for inclusion.

thanks, Alex


Signed-off-by: Johann Lombardi <johann.lombardi@bull.net>

Index: linux-2.6.16/include/linux/blkdev.h
===================================================================
--- linux-2.6.16.orig/include/linux/blkdev.h	2006-02-07 14:27:53.000000000 +0100
+++ linux-2.6.16/include/linux/blkdev.h	2006-02-07 15:21:48.000000000 +0100
@@ -667,10 +667,29 @@ extern long blk_congestion_wait(int rw, 
 extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
 extern int blkdev_issue_flush(struct block_device *, sector_t *);
 
-#define MAX_PHYS_SEGMENTS 128
-#define MAX_HW_SEGMENTS 128
 #define SAFE_MAX_SECTORS 255
 #define BLK_DEF_MAX_SECTORS 1024
+#ifdef CONFIG_LARGE_IO_SIZE_512K
+#define MAX_PHYS_SEGMENTS (1 << (19 - PAGE_CACHE_SHIFT))
+#define MAX_HW_SEGMENTS (1 << (19 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_1M
+#define MAX_PHYS_SEGMENTS (1 << (20 - PAGE_CACHE_SHIFT))
+#define MAX_HW_SEGMENTS (1 << (20 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_2M
+#define MAX_PHYS_SEGMENTS (1 << (21 - PAGE_CACHE_SHIFT))
+#define MAX_HW_SEGMENTS (1 << (21 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_4M
+#define MAX_PHYS_SEGMENTS (1 << (22 - PAGE_CACHE_SHIFT))
+#define MAX_HW_SEGMENTS (1 << (22 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_8M
+#define MAX_PHYS_SEGMENTS (1 << (23 - PAGE_CACHE_SHIFT))
+#define MAX_HW_SEGMENTS (1 << (23 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_16M
+#define MAX_PHYS_SEGMENTS (1 << (24 - PAGE_CACHE_SHIFT))
+#define MAX_HW_SEGMENTS (1 << (24 - PAGE_CACHE_SHIFT))
+#else
+#error "unknown size, check .config"
+#endif

 #define MAX_SEGMENT_SIZE	65536

Index: linux-2.6.16/include/linux/bio.h
===================================================================
--- linux-2.6.16.orig/include/linux/bio.h	2006-02-07 14:27:53.000000000 +0100
+++ linux-2.6.16/include/linux/bio.h	2006-02-07 15:22:35.000000000 +0100
@@ -46,7 +46,22 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_PAGES		(256)
+#ifdef CONFIG_LARGE_IO_SIZE_512K
+#define BIO_MAX_PAGES		(1 << (19 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_1M
+#define BIO_MAX_PAGES		(1 << (20 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_2M
+#define BIO_MAX_PAGES		(1 << (21 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_4M
+#define BIO_MAX_PAGES		(1 << (22 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_8M
+#define BIO_MAX_PAGES		(1 << (23 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_16M
+#define BIO_MAX_PAGES		(1 << (24 - PAGE_CACHE_SHIFT))
+#else
+#error "unknown size, check .config"
+#endif
+
 #define BIO_MAX_SIZE		(BIO_MAX_PAGES << PAGE_CACHE_SHIFT)
 #define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> 9)
 
Index: linux-2.6.16/include/scsi/scsi_host.h
===================================================================
--- linux-2.6.16.orig/include/scsi/scsi_host.h	2006-02-07 14:27:53.000000000 +0100
+++ linux-2.6.16/include/scsi/scsi_host.h	2006-02-07 15:20:30.000000000 +0100
@@ -25,7 +25,21 @@ struct scsi_transport_template;
  *	 used in one scatter-gather request.
  */
 #define SG_NONE 0
-#define SG_ALL 0xff
+#ifdef CONFIG_LARGE_IO_SIZE_512K
+#define SG_ALL (1 << (19 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_1M
+#define SG_ALL (1 << (20 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_2M
+#define SG_ALL (1 << (21 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_4M
+#define SG_ALL (1 << (22 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_8M
+#define SG_ALL (1 << (23 - PAGE_CACHE_SHIFT))
+#elif CONFIG_LARGE_IO_SIZE_16M
+#define SG_ALL (1 << (24 - PAGE_CACHE_SHIFT))
+#else
+#error "unknown size, check .config"
+#endif
 
 
 #define DISABLE_CLUSTERING 0
Index: linux-2.6.16/drivers/block/Kconfig
===================================================================
--- linux-2.6.16.orig/drivers/block/Kconfig	2006-02-07 14:28:10.000000000 +0100
+++ linux-2.6.16/drivers/block/Kconfig	2006-02-07 15:28:41.000000000 +0100
@@ -461,6 +461,30 @@ config LBD
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
+choice
+	prompt "Support for Large I/O Requests"
+	default LARGE_IO_SIZE_512K
+
+config LARGE_IO_SIZE_512K
+	bool "512K"
+
+config LARGE_IO_SIZE_1M
+	bool "1M"
+
+config LARGE_IO_SIZE_2M
+	bool "2M"
+
+config LARGE_IO_SIZE_4M
+	bool "4M"
+
+config LARGE_IO_SIZE_8M
+	bool "8M"
+
+config LARGE_IO_SIZE_16M
+	bool "16M"
+
+endchoice
+
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
 	depends on !UML
Index: linux-2.6.16/drivers/scsi/scsi_lib.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/scsi_lib.c	2006-02-07 14:27:53.000000000 +0100
+++ linux-2.6.16/drivers/scsi/scsi_lib.c	2006-02-07 17:24:17.000000000 +0100
@@ -55,11 +55,23 @@ struct scsi_host_sg_pool scsi_sg_pools[]
 #if (SCSI_MAX_PHYS_SEGMENTS > 128)
 	SP(256),
 #if (SCSI_MAX_PHYS_SEGMENTS > 256)
+	SP(512),
+#if (SCSI_MAX_PHYS_SEGMENTS > 512)
+	SP(1024),
+#if (SCSI_MAX_PHYS_SEGMENTS > 1024)
+	SP(2048),
+#if (SCSI_MAX_PHYS_SEGMENTS > 2048)
+	SP(4096),
+#if (SCSI_MAX_PHYS_SEGMENTS > 4096)
 #error SCSI_MAX_PHYS_SEGMENTS is too large
 #endif
 #endif
 #endif
 #endif
+#endif
+#endif
+#endif
+#endif
 }; 	
 #undef SP
 
