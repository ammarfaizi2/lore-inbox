Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267249AbSKPIyU>; Sat, 16 Nov 2002 03:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267250AbSKPIyT>; Sat, 16 Nov 2002 03:54:19 -0500
Received: from mailout.mbnet.fi ([194.100.161.24]:33544 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id <S267249AbSKPIyP> convert rfc822-to-8bit;
	Sat, 16 Nov 2002 03:54:15 -0500
Message-ID: <001b01c28d51$fd9a2400$5ca464c2@windows>
From: "Matti Annala" <gval@mbnet.fi>
To: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
       "Dave Jones" <davej@suse.de>
Subject: [PATCH] ide.h cleanup, 2.5.47
Date: Sat, 16 Nov 2002 11:24:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-OriginalArrivalTime: 16 Nov 2002 09:00:05.0418 (UTC) FILETIME=[8E4D20A0:01C28D4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below performs minor cleanups on the include/linux/ide.h header. It
simplifies the use of endianness #ifdefs and removes a chunk of duplicated
code.

Comments?

--------------------------------------------------------------------------------

diff -ur linux-2.5.47/include/linux/ide.h difflinux/include/linux/ide.h
--- linux-2.5.47/include/linux/ide.h 2002-11-10 20:07:26.000000000 +0200
+++ difflinux/include/linux/ide.h 2002-11-11 22:41:54.000000000 +0200
@@ -24,6 +24,10 @@
 #include <asm/hdreg.h>
 #include <asm/io.h>
 
+#if !defined(__LITTLE_ENDIAN_BITFIELD) && !defined(__BIG_ENDIAN_BITFIELD)
+#error "Please fix <asm/byteorder.h>"
+#endif
+
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
  * It supports up to four IDE interfaces, on one or more IRQs (usually 14 & 15).
@@ -217,25 +221,6 @@
  * so the two PRD tables (ide0 & ide1) will each get half of that,
  * allowing each to have about 256 entries (8 bytes each) from this.
  */
-#define PRD_BYTES       8
-#define PRD_ENTRIES     (PAGE_SIZE / (2 * PRD_BYTES))
-
-/*
- * Our Physical Region Descriptor (PRD) table should be large enough
- * to handle the biggest I/O request we are likely to see.  Since requests
- * can have no more than 256 sectors, and since the typical blocksize is
- * two or more sectors, we could get by with a limit of 128 entries here for
- * the usual worst case.  Most requests seem to include some contiguous blocks,
- * further reducing the number of table entries required.
- *
- * The driver reverts to PIO mode for individual requests that exceed
- * this limit (possible with 512 byte blocksizes, eg. MSDOS f/s), so handling
- * 100% of all crazy scenarios here is not necessary.
- *
- * As it turns out though, we must allocate a full 4KB page for this,
- * so the two PRD tables (ide0 & ide1) will each get half of that,
- * allowing each to have about 256 entries (8 bytes each) from this.
- */
 #define PRD_BYTES 8
 #define PRD_ENTRIES (PAGE_SIZE / (2 * PRD_BYTES))
 
@@ -395,15 +380,13 @@
   unsigned set_tune : 1;
   unsigned serviced : 1;
   unsigned reserved : 3;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned reserved : 3;
   unsigned serviced : 1;
   unsigned set_tune : 1;
   unsigned set_multmode : 1;
   unsigned recalibrate : 1;
   unsigned set_geometry : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } special_t;
@@ -420,11 +403,9 @@
 #if defined(__LITTLE_ENDIAN_BITFIELD)
   unsigned low  :8; /* LSB */
   unsigned high  :8; /* MSB */
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned high  :8; /* MSB */
   unsigned low  :8; /* LSB */
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } ata_nsector_t, ata_data_t, atapi_bcount_t, ata_index_t;
@@ -453,7 +434,7 @@
   unsigned mce  :1;
   unsigned ecc  :1;
   unsigned bdd  :1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned bdd  :1;
   unsigned ecc  :1;
   unsigned mce  :1;
@@ -462,8 +443,6 @@
   unsigned abrt  :1;
   unsigned tzero  :1;
   unsigned mark  :1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } ata_error_t;
@@ -486,15 +465,13 @@
   unsigned bit5  : 1;
   unsigned lba  : 1;
   unsigned bit7  : 1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned bit7  : 1;
   unsigned lba  : 1;
   unsigned bit5  : 1;
   unsigned unit  : 1;
   unsigned head  : 4;
 #else
-#error "Please fix <asm/byteorder.h>"
-#endif
  } b;
 } select_t, ata_select_t;
 
@@ -527,7 +504,7 @@
   unsigned df  :1;
   unsigned drdy  :1;
   unsigned bsy  :1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned bsy  :1;
   unsigned drdy  :1;
   unsigned df  :1;
@@ -536,8 +513,6 @@
   unsigned corr           :1;
   unsigned idx  :1;
   unsigned check  :1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } ata_status_t, atapi_status_t;
@@ -562,15 +537,13 @@
   unsigned bit3  : 1;
   unsigned reserved456 : 3;
   unsigned HOB  : 1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned HOB  : 1;
   unsigned reserved456 : 3;
   unsigned bit3  : 1;
   unsigned SRST  : 1;
   unsigned nIEN  : 1;
   unsigned bit0  : 1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } ata_control_t;
@@ -591,13 +564,11 @@
   unsigned reserved321 :3;
   unsigned reserved654 :3;
   unsigned reserved7 :1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned reserved7 :1;
   unsigned reserved654 :3;
   unsigned reserved321 :3;
   unsigned dma  :1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } atapi_feature_t;
@@ -616,12 +587,10 @@
   unsigned cod  :1;
   unsigned io  :1;
   unsigned reserved :6;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned reserved :6;
   unsigned io  :1;
   unsigned cod  :1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } atapi_ireason_t;
@@ -644,14 +613,12 @@
   unsigned abrt  :1;
   unsigned mcr  :1;
   unsigned sense_key :4;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned sense_key :4;
   unsigned mcr  :1;
   unsigned abrt  :1;
   unsigned eom  :1;
   unsigned ili  :1;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } atapi_error_t;
@@ -676,15 +643,13 @@
   unsigned one5  :1;
   unsigned reserved6 :1;
   unsigned one7  :1;
-#elif defined(__BIG_ENDIAN_BITFIELD)
+#else
   unsigned one7  :1;
   unsigned reserved6 :1;
   unsigned one5  :1;
   unsigned drv  :1;
   unsigned reserved3 :1;
   unsigned sam_lun :3;
-#else
-#error "Please fix <asm/byteorder.h>"
 #endif
  } b;
 } atapi_select_t;


