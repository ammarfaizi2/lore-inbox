Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbTCLPKE>; Wed, 12 Mar 2003 10:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbTCLPKE>; Wed, 12 Mar 2003 10:10:04 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23266 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261732AbTCLPJD>; Wed, 12 Mar 2003 10:09:03 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 12 Mar 2003 16:22:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Michael Hunold <m.hunold@gmx.de>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: create include/media
Message-ID: <20030312152241.GB13235@bytesex.org>
References: <20030310200852.GA6397@bytesex.org> <20030310220233.A13923@infradead.org> <20030311181240.GB7186@bytesex.org> <20030312151934.GA13235@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312151934.GA13235@bytesex.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, here we go.  This is patch #1 which just removes the private
> MIN/MAX macos.

... and here is patch #2 which actually moves the header files
(including the fixed audiochip.h file without MIN/MAX).  Must be
applied on top of the other patch.

  Gerd

==============================[ cut here ]==============================
This patch creates a new include directory include/media, populates
it with a few files header files and fixups the affected drivers to
compile with the new directory layout.

The directory is intented to be used for (kernel-internal) header files
of the media drivers (which are sitting below drivers/media).  For now
the video-buf.h (mm helper), tuner.h (tv/radio tuner) and audiochip.h
(tv sound decoder drivers) header files are moved.  Some more header
files from the dvb folks will likely follow.

--- linux-2.5.64drivers/media/video/audiochip.h	2003-03-12 15:04:47.000000000 +0100
+++ linuxdrivers/media/video/audiochip.h	2003-03-12 15:09:25.000000000 +0100
@@ -1,24 +0,0 @@
-#ifndef AUDIOCHIP_H
-#define AUDIOCHIP_H
-
-/* ---------------------------------------------------------------------- */
-
-/* v4l device was opened in Radio mode */
-#define AUDC_SET_RADIO        _IO('m',2)
-/* select from TV,radio,extern,MUTE */
-#define AUDC_SET_INPUT        _IOW('m',17,int)
-
-/* audio inputs */
-#define AUDIO_TUNER        0x00
-#define AUDIO_RADIO        0x01
-#define AUDIO_EXTERN       0x02
-#define AUDIO_INTERN       0x03
-#define AUDIO_OFF          0x04 
-#define AUDIO_ON           0x05
-#define AUDIO_MUTE         0x80
-#define AUDIO_UNMUTE       0x81
-
-/* misc stuff to pass around config info to i2c chips */
-#define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
-
-#endif /* AUDIOCHIP_H */
--- linux-2.5.64drivers/media/video/bttv-cards.c	2003-03-12 14:42:42.000000000 +0100
+++ linuxdrivers/media/video/bttv-cards.c	2003-03-12 15:07:06.000000000 +0100
@@ -36,7 +36,6 @@
 #include <asm/io.h>
 
 #include "bttvp.h"
-#include "tuner.h"
 #include "bt832.h"
 
 /* fwd decl */
--- linux-2.5.64drivers/media/video/bttv-driver.c	2003-03-12 14:43:09.000000000 +0100
+++ linuxdrivers/media/video/bttv-driver.c	2003-03-12 15:07:06.000000000 +0100
@@ -37,7 +37,6 @@
 #include <asm/io.h>
 
 #include "bttvp.h"
-#include "tuner.h"
 
 int bttv_num;			/* number of Bt848s in use */
 struct bttv bttvs[BTTV_MAX];
--- linux-2.5.64drivers/media/video/bttv-if.c	2003-03-12 14:42:10.000000000 +0100
+++ linuxdrivers/media/video/bttv-if.c	2003-03-12 15:07:06.000000000 +0100
@@ -34,7 +34,6 @@
 #include <asm/io.h>
 
 #include "bttvp.h"
-#include "tuner.h"
 
 static struct i2c_algo_bit_data bttv_i2c_algo_template;
 static struct i2c_adapter bttv_i2c_adap_template;
--- linux-2.5.64drivers/media/video/bttvp.h	2003-03-12 14:42:27.000000000 +0100
+++ linuxdrivers/media/video/bttvp.h	2003-03-12 15:07:06.000000000 +0100
@@ -34,10 +34,12 @@
 #include <linux/pci.h>
 #include <asm/scatterlist.h>
 
+#include <media/video-buf.h>
+#include <media/audiochip.h>
+#include <media/tuner.h>
+
 #include "bt848.h"
 #include "bttv.h"
-#include "video-buf.h"
-#include "audiochip.h"
 
 #ifdef __KERNEL__
 
--- linux-2.5.64drivers/media/video/id.h	2003-03-12 14:42:43.000000000 +0100
+++ linuxdrivers/media/video/id.h	2003-03-12 15:09:34.000000000 +0100
@@ -1,35 +0,0 @@
-/* FIXME: this temporarely, until these are included in linux/i2c-id.h */
-
-/* drivers */
-#ifndef  I2C_DRIVERID_TVMIXER
-# define I2C_DRIVERID_TVMIXER I2C_DRIVERID_EXP0
-#endif
-#ifndef  I2C_DRIVERID_TVAUDIO
-# define I2C_DRIVERID_TVAUDIO I2C_DRIVERID_EXP1
-#endif
-
-/* chips */
-#ifndef  I2C_DRIVERID_DPL3518
-# define I2C_DRIVERID_DPL3518 I2C_DRIVERID_EXP2
-#endif
-#ifndef  I2C_DRIVERID_TDA9873
-# define I2C_DRIVERID_TDA9873 I2C_DRIVERID_EXP3
-#endif
-#ifndef  I2C_DRIVERID_TDA9875
-# define I2C_DRIVERID_TDA9875 I2C_DRIVERID_EXP0+4
-#endif
-#ifndef  I2C_DRIVERID_PIC16C54_PV951
-# define I2C_DRIVERID_PIC16C54_PV951 I2C_DRIVERID_EXP0+5
-#endif
-#ifndef  I2C_DRIVERID_TDA7432
-# define I2C_DRIVERID_TDA7432 I2C_DRIVERID_EXP0+6
-#endif
-#ifndef  I2C_DRIVERID_TDA9874
-# define I2C_DRIVERID_TDA9874 I2C_DRIVERID_EXP0+7
-#endif
-
-/* algorithms */
-#ifndef I2C_ALGO_SAA7134
-# define I2C_ALGO_SAA7134 0x090000
-#endif
-
--- linux-2.5.64drivers/media/video/msp3400.c	2003-03-12 15:03:51.000000000 +0100
+++ linuxdrivers/media/video/msp3400.c	2003-03-12 15:07:06.000000000 +0100
@@ -56,7 +56,7 @@
 #define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 
-#include "audiochip.h"
+#include <media/audiochip.h>
 #include "msp3400.h"
 
 /* Addresses to scan */
--- linux-2.5.64drivers/media/video/saa7134/saa7134-cards.c	2003-03-12 14:43:16.000000000 +0100
+++ linuxdrivers/media/video/saa7134/saa7134-cards.c	2003-03-12 15:07:06.000000000 +0100
@@ -24,7 +24,6 @@
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
-#include "tuner.h"
 
 /* commly used strings */
 static char name_mute[]    = "mute";
--- linux-2.5.64drivers/media/video/saa7134/saa7134-core.c	2003-03-12 14:42:22.000000000 +0100
+++ linuxdrivers/media/video/saa7134/saa7134-core.c	2003-03-12 15:07:06.000000000 +0100
@@ -30,7 +30,6 @@
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
-#include "tuner.h"
 
 MODULE_DESCRIPTION("v4l2 driver module for saa7130/34 based TV cards");
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
--- linux-2.5.64drivers/media/video/saa7134/saa7134-i2c.c	2003-03-12 14:42:11.000000000 +0100
+++ linuxdrivers/media/video/saa7134/saa7134-i2c.c	2003-03-12 15:07:06.000000000 +0100
@@ -30,8 +30,6 @@
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
-#include "tuner.h"
-#include "id.h"
 
 /* ----------------------------------------------------------- */
 
--- linux-2.5.64drivers/media/video/saa7134/saa7134-video.c	2003-03-12 14:42:11.000000000 +0100
+++ linuxdrivers/media/video/saa7134/saa7134-video.c	2003-03-12 15:07:06.000000000 +0100
@@ -29,8 +29,6 @@
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
-#include "tuner.h"
-#include "audiochip.h"
 
 /* ------------------------------------------------------------------ */
 
--- linux-2.5.64drivers/media/video/saa7134/saa7134.h	2003-03-12 14:43:07.000000000 +0100
+++ linuxdrivers/media/video/saa7134/saa7134.h	2003-03-12 15:07:06.000000000 +0100
@@ -22,7 +22,11 @@
 #include <linux/i2c.h>
 #include <linux/videodev.h>
 #include <linux/kdev_t.h>
-#include "video-buf.h"
+
+#include <media/video-buf.h>
+#include <media/tuner.h>
+#include <media/audiochip.h>
+#include <media/id.h>
 
 #define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,2)
 
--- linux-2.5.64drivers/media/video/tda7432.c	2003-03-12 14:42:57.000000000 +0100
+++ linuxdrivers/media/video/tda7432.c	2003-03-12 15:07:06.000000000 +0100
@@ -49,8 +49,8 @@
 #include <linux/i2c-algo-bit.h>
 
 #include "bttv.h"
-#include "audiochip.h"
-#include "id.h"
+#include <media/audiochip.h>
+#include <media/id.h>
 
 #ifndef VIDEO_AUDIO_BALANCE
 # define VIDEO_AUDIO_BALANCE 32
--- linux-2.5.64drivers/media/video/tda9875.c	2003-03-12 15:03:51.000000000 +0100
+++ linuxdrivers/media/video/tda9875.c	2003-03-12 15:07:06.000000000 +0100
@@ -31,8 +31,8 @@
 #include <linux/init.h>
 
 #include "bttv.h"
-#include "audiochip.h"
-#include "id.h"
+#include <media/audiochip.h>
+#include <media/id.h>
 
 MODULE_PARM(debug,"i");
 MODULE_LICENSE("GPL");
--- linux-2.5.64drivers/media/video/tda9887.c	2003-03-12 14:41:55.000000000 +0100
+++ linuxdrivers/media/video/tda9887.c	2003-03-12 15:07:06.000000000 +0100
@@ -7,8 +7,8 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
-#include "id.h"
-#include "audiochip.h"
+#include <media/audiochip.h>
+#include <media/id.h>
 
 /* Chips:
    TDA9885 (PAL, NTSC)
--- linux-2.5.64drivers/media/video/tuner-3036.c	2003-03-12 14:42:39.000000000 +0100
+++ linuxdrivers/media/video/tuner-3036.c	2003-03-12 15:07:06.000000000 +0100
@@ -27,7 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/videodev.h>
 
-#include "tuner.h"
+#include <media/tuner.h>
 
 static int debug;	/* insmod parameter */
 static int this_adap;
--- linux-2.5.64drivers/media/video/tuner.c	2003-03-12 14:43:12.000000000 +0100
+++ linuxdrivers/media/video/tuner.c	2003-03-12 15:07:06.000000000 +0100
@@ -12,8 +12,8 @@
 #include <linux/videodev.h>
 #include <linux/init.h>
 
-#include "tuner.h"
-#include "audiochip.h"
+#include <media/tuner.h>
+#include <media/audiochip.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
--- linux-2.5.64drivers/media/video/tuner.h	2003-03-12 14:42:57.000000000 +0100
+++ linuxdrivers/media/video/tuner.h	2003-03-12 15:09:46.000000000 +0100
@@ -1,94 +0,0 @@
-/* 
-    tuner.h - definition for different tuners
-
-    Copyright (C) 1997 Markus Schroeder (schroedm@uni-duesseldorf.de)
-    minor modifications by Ralph Metzler (rjkm@thp.uni-koeln.de)
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#ifndef _TUNER_H
-#define _TUNER_H
-
-#include "id.h"
-
-#define TUNER_TEMIC_PAL     0        /* 4002 FH5 (3X 7756, 9483) */
-#define TUNER_PHILIPS_PAL_I 1
-#define TUNER_PHILIPS_NTSC  2
-#define TUNER_PHILIPS_SECAM 3		/* you must actively select B/G, L, L` */
-#define TUNER_ABSENT        4
-#define TUNER_PHILIPS_PAL   5
-#define TUNER_TEMIC_NTSC    6        /* 4032 FY5 (3X 7004, 9498, 9789)  */
-#define TUNER_TEMIC_PAL_I   7        /* 4062 FY5 (3X 8501, 9957)        */
-#define TUNER_TEMIC_4036FY5_NTSC 8   /* 4036 FY5 (3X 1223, 1981, 7686)  */
-#define TUNER_ALPS_TSBH1_NTSC 	 9
-#define TUNER_ALPS_TSBE1_PAL 	10
-#define TUNER_ALPS_TSBB5_PAL_I 	11
-#define TUNER_ALPS_TSBE5_PAL 	12
-#define TUNER_ALPS_TSBC5_PAL 	13
-#define TUNER_TEMIC_4006FH5_PAL	14   /* 4006 FH5 (3X 9500, 9501, 7291)     */
-#define TUNER_ALPS_TSHC6_NTSC 	15
-#define TUNER_TEMIC_PAL_DK	16   /* 4016 FY5 (3X 1392, 1393)     */
-#define TUNER_PHILIPS_NTSC_M	17
-#define TUNER_TEMIC_4066FY5_PAL_I       18  /* 4066 FY5 (3X 7032, 7035) */
-#define TUNER_TEMIC_4006FN5_MULTI_PAL   19  /* B/G, I and D/K autodetected (3X 7595, 7606, 7657)*/
-#define TUNER_TEMIC_4009FR5_PAL         20  /* incl. FM radio (3X 7607, 7488, 7711)*/
-#define TUNER_TEMIC_4039FR5_NTSC        21  /* incl. FM radio (3X 7246, 7578, 7732)*/
-#define TUNER_TEMIC_4046FM5             22  /* you must actively select B/G, D/K, I, L, L` !  (3X 7804, 7806, 8103, 8104)*/
-#define TUNER_PHILIPS_PAL_DK		23
-#define TUNER_PHILIPS_FQ1216ME		24  /* you must actively select B/G/D/K, I, L, L` */
-#define TUNER_LG_PAL_I_FM	25
-#define TUNER_LG_PAL_I		26
-#define TUNER_LG_NTSC_FM	27
-#define TUNER_LG_PAL_FM		28
-#define TUNER_LG_PAL		29
-#define TUNER_TEMIC_4009FN5_MULTI_PAL_FM	30  /* B/G, I and D/K autodetected (3X 8155, 8160, 8163)*/
-#define TUNER_SHARP_2U5JF5540_NTSC  31
-#define TUNER_Samsung_PAL_TCPM9091PD27 32
-#define TUNER_MT2032 33
-#define TUNER_TEMIC_4106FH5 	34	/* 4106 FH5 (3X 7808, 7865)*/
-#define TUNER_TEMIC_4012FY5	35	/* 4012 FY5 (3X 0971, 1099)*/
-#define TUNER_TEMIC_4136FY5	36	/* 4136 FY5 (3X 7708, 7746)*/
-#define TUNER_LG_PAL_NEW_TAPC   37
-#define TUNER_PHILIPS_FM1216ME_MK3  38
-#define TUNER_LG_NTSC_NEW_TAPC   39
-
-
-
-
-#define NOTUNER 0
-#define PAL     1	/* PAL_BG */
-#define PAL_I   2
-#define NTSC    3
-#define SECAM   4
-
-#define NoTuner 0
-#define Philips 1
-#define TEMIC   2
-#define Sony    3
-#define Alps    4
-#define LGINNOTEK 5
-#define SHARP   6
-#define Samsung 7
-#define Microtune 8
-
-#define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
-#define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
-#if 0 /* obsolete */
-# define TUNER_SET_RADIOFREQ         _IOW('t',3,int)    /* set radio freq */
-# define TUNER_SET_MODE              _IOW('t',4,int)    /* set tuner mode */
-#endif
-
-#endif
--- linux-2.5.64drivers/media/video/tvaudio.c	2003-03-12 15:03:51.000000000 +0100
+++ linuxdrivers/media/video/tvaudio.c	2003-03-12 15:07:06.000000000 +0100
@@ -29,9 +29,10 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 
-#include "audiochip.h"
+#include <media/audiochip.h>
+#include <media/id.h>
+
 #include "tvaudio.h"
-#include "id.h"
 
 
 /* ---------------------------------------------------------------------- */
--- linux-2.5.64drivers/media/video/video-buf.c	2003-03-12 14:42:43.000000000 +0100
+++ linuxdrivers/media/video/video-buf.c	2003-03-12 15:07:06.000000000 +0100
@@ -31,7 +31,7 @@
 # define TryLockPage TestSetPageLocked
 #endif
 
-#include "video-buf.h"
+#include <media/video-buf.h>
 
 static int debug = 0;
 
--- linux-2.5.64drivers/media/video/video-buf.h	2003-03-12 14:42:47.000000000 +0100
+++ linuxdrivers/media/video/video-buf.h	2003-03-12 15:10:03.000000000 +0100
@@ -1,234 +0,0 @@
-/*
- * generic helper functions for video4linux capture buffers, to handle
- * memory management and PCI DMA.  Right now bttv + saa7134 use it.
- *
- * The functions expect the hardware being able to scatter gatter
- * (i.e. the buffers are not linear in physical memory, but fragmented
- * into PAGE_SIZE chunks).  They also assume the driver does not need
- * to touch the video data (thus it is probably not useful for USB as
- * data often must be uncompressed by the drivers).
- * 
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/videodev.h>
-
-/* --------------------------------------------------------------------- */
-
-/*
- * Return a scatterlist for some page-aligned vmalloc()'ed memory
- * block (NULL on errors).  Memory for the scatterlist is allocated
- * using kmalloc.  The caller must free the memory.
- */
-struct scatterlist* videobuf_vmalloc_to_sg(unsigned char *virt, int nr_pages);
-
-/*
- * Return a scatterlist for a an array of userpages (NULL on errors).
- * Memory for the scatterlist is allocated using kmalloc.  The caller
- * must free the memory.
- */
-struct scatterlist* videobuf_pages_to_sg(struct page **pages, int nr_pages,
-					 int offset);
-int videobuf_lock(struct page **pages, int nr_pages);
-int videobuf_unlock(struct page **pages, int nr_pages);
-
-/* --------------------------------------------------------------------- */
-
-/*
- * A small set of helper functions to manage buffers (both userland
- * and kernel) for DMA.
- *
- * videobuf_init_*_dmabuf()
- *	creates a buffer.  The userland version takes a userspace
- *	pointer + length.  The kernel version just wants the size and
- *	does memory allocation too using vmalloc_32().
- *
- * videobuf_pci_*_dmabuf()
- *	see Documentation/DMA-mapping.txt, these functions to
- *	basically the same.  The map function does also build a
- *	scatterlist for the buffer (and unmap frees it ...)
- *
- * videobuf_free_dmabuf()
- *	no comment ...
- *
- */
-
-struct videobuf_dmabuf {
-	/* for userland buffer */
-	int                 offset;
-	struct page         **pages;
-
-	/* for kernel buffers */
-	void                *vmalloc;
-
-	/* common */
-	struct scatterlist  *sglist;
-	int                 sglen;
-	int                 nr_pages;
-	int                 direction;
-};
-
-int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
-			   unsigned long data, unsigned long size);
-int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
-			     int nr_pages);
-int videobuf_dma_pci_map(struct pci_dev *dev, struct videobuf_dmabuf *dma);
-int videobuf_dma_pci_sync(struct pci_dev *dev,
-			  struct videobuf_dmabuf *dma);
-int videobuf_dma_pci_unmap(struct pci_dev *dev, struct videobuf_dmabuf *dma);
-int videobuf_dma_free(struct videobuf_dmabuf *dma);
-
-/* --------------------------------------------------------------------- */
-
-/*
- * A small set of helper functions to manage video4linux buffers.
- *
- * struct videobuf_buffer holds the data structures used by the helper
- * functions, additionally some commonly used fields for v4l buffers
- * (width, height, lists, waitqueue) are in there.  That struct should
- * be used as first element in the drivers buffer struct.
- * 
- * about the mmap helpers (videobuf_mmap_*):
- *
- * The mmaper function allows to map any subset of contingous buffers.
- * This includes one mmap() call for all buffers (which the original
- * video4linux API uses) as well as one mmap() for every single buffer
- * (which v4l2 uses).
- *
- * If there is a valid mapping for a buffer, buffer->baddr/bsize holds
- * userspace address + size which can be feeded into the
- * videobuf_dma_init_user function listed above.
- *
- */
-
-struct videobuf_buffer;
-struct videobuf_queue;
-
-struct videobuf_mapping {
-	unsigned int count;
-	int highmem_ok;
-	unsigned long start;
-	unsigned long end;
-	struct videobuf_queue *q;
-};
-
-enum videobuf_state {
-	STATE_NEEDS_INIT = 0,
-	STATE_PREPARED   = 1,
-	STATE_QUEUED     = 2,
-	STATE_ACTIVE     = 3,
-	STATE_DONE       = 4,
-	STATE_ERROR      = 5,
-	STATE_IDLE       = 6,
-};
-
-struct videobuf_buffer {
-	unsigned int            i;
-
-	/* info about the buffer */
-	unsigned int            width;
-	unsigned int            height;
-	unsigned long           size;
-	enum v4l2_field         field;
-	enum videobuf_state     state;
-	struct videobuf_dmabuf  dma;
-	struct list_head        stream;  /* QBUF/DQBUF list */
-
-	/* for mmap'ed buffers */
-	size_t                  boff;    /* buffer offset (mmap) */
-	size_t                  bsize;   /* buffer size */
-	unsigned long           baddr;   /* buffer addr (userland ptr!) */
-	struct videobuf_mapping *map;
-
-	/* touched by irq handler */
-	struct list_head        queue;
-	wait_queue_head_t       done;
-	unsigned int            field_count;
-	struct timeval          ts;
-};
-
-struct videobuf_queue_ops {
-	int (*buf_setup)(struct file *file,
-			 unsigned int *count, unsigned int *size);
-	int (*buf_prepare)(struct file *file,struct videobuf_buffer *vb,
-			   enum v4l2_field field);
-	void (*buf_queue)(struct file *file,struct videobuf_buffer *vb);
-	void (*buf_release)(struct file *file,struct videobuf_buffer *vb);
-};
-
-struct videobuf_queue {
-        struct semaphore           lock;
-	spinlock_t                 *irqlock;
-	struct pci_dev             *pci;
-
-	enum v4l2_buf_type         type;
-	unsigned int               msize;
-	enum v4l2_field            field;
-	enum v4l2_field            last; /* for field=V4L2_FIELD_ALTERNATE */
-	struct videobuf_buffer     *bufs[VIDEO_MAX_FRAME];
-	struct videobuf_queue_ops  *ops;
-
-	/* capture via mmap() + ioctl(QBUF/DQBUF) */
-	unsigned int               streaming;
-	struct list_head           stream;
-
-	/* capture via read() */
-	unsigned int               reading;
-	unsigned int               read_off;
-	struct videobuf_buffer     *read_buf;
-};
-
-void* videobuf_alloc(unsigned int size);
-int videobuf_waiton(struct videobuf_buffer *vb, int non_blocking, int intr);
-int videobuf_iolock(struct pci_dev *pci, struct videobuf_buffer *vb);
-
-void videobuf_queue_init(struct videobuf_queue *q,
-			 struct videobuf_queue_ops *ops,
-			 struct pci_dev *pci, spinlock_t *irqlock,
-			 enum v4l2_buf_type type,
-			 enum v4l2_field field,
-			 unsigned int msize);
-int  videobuf_queue_is_busy(struct videobuf_queue *q);
-void videobuf_queue_cancel(struct file *file, struct videobuf_queue *q);
-
-void videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
-		     enum v4l2_buf_type type);
-int videobuf_reqbufs(struct file *file, struct videobuf_queue *q,
-		     struct v4l2_requestbuffers *req);
-int videobuf_querybuf(struct videobuf_queue *q, struct v4l2_buffer *b);
-int videobuf_qbuf(struct file *file, struct videobuf_queue *q,
-		  struct v4l2_buffer *b);
-int videobuf_dqbuf(struct file *file, struct videobuf_queue *q,
-		   struct v4l2_buffer *b);
-int videobuf_streamon(struct file *file, struct videobuf_queue *q);
-int videobuf_streamoff(struct file *file, struct videobuf_queue *q);
-
-int videobuf_read_start(struct file *file, struct videobuf_queue *q);
-void videobuf_read_stop(struct file *file, struct videobuf_queue *q);
-ssize_t videobuf_read_stream(struct file *file, struct videobuf_queue *q,
-			     char *data, size_t count, loff_t *ppos,
-			     int vbihack);
-ssize_t videobuf_read_one(struct file *file, struct videobuf_queue *q,
-			  char *data, size_t count, loff_t *ppos);
-unsigned int videobuf_poll_stream(struct file *file,
-				  struct videobuf_queue *q,
-				  poll_table *wait);
-
-int videobuf_mmap_setup(struct file *file, struct videobuf_queue *q,
-			unsigned int bcount, unsigned int bsize);
-int videobuf_mmap_free(struct file *file, struct videobuf_queue *q);
-int videobuf_mmap_mapper(struct vm_area_struct *vma,
-			 struct videobuf_queue *q);
-
-/* --------------------------------------------------------------------- */
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
--- linux-2.5.64include/media/audiochip.h	2003-03-12 15:07:06.000000000 +0100
+++ linuxinclude/media/audiochip.h	2003-03-12 15:07:06.000000000 +0100
@@ -0,0 +1,24 @@
+#ifndef AUDIOCHIP_H
+#define AUDIOCHIP_H
+
+/* ---------------------------------------------------------------------- */
+
+/* v4l device was opened in Radio mode */
+#define AUDC_SET_RADIO        _IO('m',2)
+/* select from TV,radio,extern,MUTE */
+#define AUDC_SET_INPUT        _IOW('m',17,int)
+
+/* audio inputs */
+#define AUDIO_TUNER        0x00
+#define AUDIO_RADIO        0x01
+#define AUDIO_EXTERN       0x02
+#define AUDIO_INTERN       0x03
+#define AUDIO_OFF          0x04 
+#define AUDIO_ON           0x05
+#define AUDIO_MUTE         0x80
+#define AUDIO_UNMUTE       0x81
+
+/* misc stuff to pass around config info to i2c chips */
+#define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
+
+#endif /* AUDIOCHIP_H */
--- linux-2.5.64include/media/id.h	2003-03-12 15:07:06.000000000 +0100
+++ linuxinclude/media/id.h	2003-03-12 15:07:06.000000000 +0100
@@ -0,0 +1,35 @@
+/* FIXME: this temporarely, until these are included in linux/i2c-id.h */
+
+/* drivers */
+#ifndef  I2C_DRIVERID_TVMIXER
+# define I2C_DRIVERID_TVMIXER I2C_DRIVERID_EXP0
+#endif
+#ifndef  I2C_DRIVERID_TVAUDIO
+# define I2C_DRIVERID_TVAUDIO I2C_DRIVERID_EXP1
+#endif
+
+/* chips */
+#ifndef  I2C_DRIVERID_DPL3518
+# define I2C_DRIVERID_DPL3518 I2C_DRIVERID_EXP2
+#endif
+#ifndef  I2C_DRIVERID_TDA9873
+# define I2C_DRIVERID_TDA9873 I2C_DRIVERID_EXP3
+#endif
+#ifndef  I2C_DRIVERID_TDA9875
+# define I2C_DRIVERID_TDA9875 I2C_DRIVERID_EXP0+4
+#endif
+#ifndef  I2C_DRIVERID_PIC16C54_PV951
+# define I2C_DRIVERID_PIC16C54_PV951 I2C_DRIVERID_EXP0+5
+#endif
+#ifndef  I2C_DRIVERID_TDA7432
+# define I2C_DRIVERID_TDA7432 I2C_DRIVERID_EXP0+6
+#endif
+#ifndef  I2C_DRIVERID_TDA9874
+# define I2C_DRIVERID_TDA9874 I2C_DRIVERID_EXP0+7
+#endif
+
+/* algorithms */
+#ifndef I2C_ALGO_SAA7134
+# define I2C_ALGO_SAA7134 0x090000
+#endif
+
--- linux-2.5.64include/media/tuner.h	2003-03-12 15:07:06.000000000 +0100
+++ linuxinclude/media/tuner.h	2003-03-12 15:07:06.000000000 +0100
@@ -0,0 +1,94 @@
+/* 
+    tuner.h - definition for different tuners
+
+    Copyright (C) 1997 Markus Schroeder (schroedm@uni-duesseldorf.de)
+    minor modifications by Ralph Metzler (rjkm@thp.uni-koeln.de)
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef _TUNER_H
+#define _TUNER_H
+
+#include "id.h"
+
+#define TUNER_TEMIC_PAL     0        /* 4002 FH5 (3X 7756, 9483) */
+#define TUNER_PHILIPS_PAL_I 1
+#define TUNER_PHILIPS_NTSC  2
+#define TUNER_PHILIPS_SECAM 3		/* you must actively select B/G, L, L` */
+#define TUNER_ABSENT        4
+#define TUNER_PHILIPS_PAL   5
+#define TUNER_TEMIC_NTSC    6        /* 4032 FY5 (3X 7004, 9498, 9789)  */
+#define TUNER_TEMIC_PAL_I   7        /* 4062 FY5 (3X 8501, 9957)        */
+#define TUNER_TEMIC_4036FY5_NTSC 8   /* 4036 FY5 (3X 1223, 1981, 7686)  */
+#define TUNER_ALPS_TSBH1_NTSC 	 9
+#define TUNER_ALPS_TSBE1_PAL 	10
+#define TUNER_ALPS_TSBB5_PAL_I 	11
+#define TUNER_ALPS_TSBE5_PAL 	12
+#define TUNER_ALPS_TSBC5_PAL 	13
+#define TUNER_TEMIC_4006FH5_PAL	14   /* 4006 FH5 (3X 9500, 9501, 7291)     */
+#define TUNER_ALPS_TSHC6_NTSC 	15
+#define TUNER_TEMIC_PAL_DK	16   /* 4016 FY5 (3X 1392, 1393)     */
+#define TUNER_PHILIPS_NTSC_M	17
+#define TUNER_TEMIC_4066FY5_PAL_I       18  /* 4066 FY5 (3X 7032, 7035) */
+#define TUNER_TEMIC_4006FN5_MULTI_PAL   19  /* B/G, I and D/K autodetected (3X 7595, 7606, 7657)*/
+#define TUNER_TEMIC_4009FR5_PAL         20  /* incl. FM radio (3X 7607, 7488, 7711)*/
+#define TUNER_TEMIC_4039FR5_NTSC        21  /* incl. FM radio (3X 7246, 7578, 7732)*/
+#define TUNER_TEMIC_4046FM5             22  /* you must actively select B/G, D/K, I, L, L` !  (3X 7804, 7806, 8103, 8104)*/
+#define TUNER_PHILIPS_PAL_DK		23
+#define TUNER_PHILIPS_FQ1216ME		24  /* you must actively select B/G/D/K, I, L, L` */
+#define TUNER_LG_PAL_I_FM	25
+#define TUNER_LG_PAL_I		26
+#define TUNER_LG_NTSC_FM	27
+#define TUNER_LG_PAL_FM		28
+#define TUNER_LG_PAL		29
+#define TUNER_TEMIC_4009FN5_MULTI_PAL_FM	30  /* B/G, I and D/K autodetected (3X 8155, 8160, 8163)*/
+#define TUNER_SHARP_2U5JF5540_NTSC  31
+#define TUNER_Samsung_PAL_TCPM9091PD27 32
+#define TUNER_MT2032 33
+#define TUNER_TEMIC_4106FH5 	34	/* 4106 FH5 (3X 7808, 7865)*/
+#define TUNER_TEMIC_4012FY5	35	/* 4012 FY5 (3X 0971, 1099)*/
+#define TUNER_TEMIC_4136FY5	36	/* 4136 FY5 (3X 7708, 7746)*/
+#define TUNER_LG_PAL_NEW_TAPC   37
+#define TUNER_PHILIPS_FM1216ME_MK3  38
+#define TUNER_LG_NTSC_NEW_TAPC   39
+
+
+
+
+#define NOTUNER 0
+#define PAL     1	/* PAL_BG */
+#define PAL_I   2
+#define NTSC    3
+#define SECAM   4
+
+#define NoTuner 0
+#define Philips 1
+#define TEMIC   2
+#define Sony    3
+#define Alps    4
+#define LGINNOTEK 5
+#define SHARP   6
+#define Samsung 7
+#define Microtune 8
+
+#define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
+#define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
+#if 0 /* obsolete */
+# define TUNER_SET_RADIOFREQ         _IOW('t',3,int)    /* set radio freq */
+# define TUNER_SET_MODE              _IOW('t',4,int)    /* set tuner mode */
+#endif
+
+#endif
--- linux-2.5.64include/media/video-buf.h	2003-03-12 15:07:06.000000000 +0100
+++ linuxinclude/media/video-buf.h	2003-03-12 15:07:06.000000000 +0100
@@ -0,0 +1,234 @@
+/*
+ * generic helper functions for video4linux capture buffers, to handle
+ * memory management and PCI DMA.  Right now bttv + saa7134 use it.
+ *
+ * The functions expect the hardware being able to scatter gatter
+ * (i.e. the buffers are not linear in physical memory, but fragmented
+ * into PAGE_SIZE chunks).  They also assume the driver does not need
+ * to touch the video data (thus it is probably not useful for USB as
+ * data often must be uncompressed by the drivers).
+ * 
+ * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/videodev.h>
+
+/* --------------------------------------------------------------------- */
+
+/*
+ * Return a scatterlist for some page-aligned vmalloc()'ed memory
+ * block (NULL on errors).  Memory for the scatterlist is allocated
+ * using kmalloc.  The caller must free the memory.
+ */
+struct scatterlist* videobuf_vmalloc_to_sg(unsigned char *virt, int nr_pages);
+
+/*
+ * Return a scatterlist for a an array of userpages (NULL on errors).
+ * Memory for the scatterlist is allocated using kmalloc.  The caller
+ * must free the memory.
+ */
+struct scatterlist* videobuf_pages_to_sg(struct page **pages, int nr_pages,
+					 int offset);
+int videobuf_lock(struct page **pages, int nr_pages);
+int videobuf_unlock(struct page **pages, int nr_pages);
+
+/* --------------------------------------------------------------------- */
+
+/*
+ * A small set of helper functions to manage buffers (both userland
+ * and kernel) for DMA.
+ *
+ * videobuf_init_*_dmabuf()
+ *	creates a buffer.  The userland version takes a userspace
+ *	pointer + length.  The kernel version just wants the size and
+ *	does memory allocation too using vmalloc_32().
+ *
+ * videobuf_pci_*_dmabuf()
+ *	see Documentation/DMA-mapping.txt, these functions to
+ *	basically the same.  The map function does also build a
+ *	scatterlist for the buffer (and unmap frees it ...)
+ *
+ * videobuf_free_dmabuf()
+ *	no comment ...
+ *
+ */
+
+struct videobuf_dmabuf {
+	/* for userland buffer */
+	int                 offset;
+	struct page         **pages;
+
+	/* for kernel buffers */
+	void                *vmalloc;
+
+	/* common */
+	struct scatterlist  *sglist;
+	int                 sglen;
+	int                 nr_pages;
+	int                 direction;
+};
+
+int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
+			   unsigned long data, unsigned long size);
+int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
+			     int nr_pages);
+int videobuf_dma_pci_map(struct pci_dev *dev, struct videobuf_dmabuf *dma);
+int videobuf_dma_pci_sync(struct pci_dev *dev,
+			  struct videobuf_dmabuf *dma);
+int videobuf_dma_pci_unmap(struct pci_dev *dev, struct videobuf_dmabuf *dma);
+int videobuf_dma_free(struct videobuf_dmabuf *dma);
+
+/* --------------------------------------------------------------------- */
+
+/*
+ * A small set of helper functions to manage video4linux buffers.
+ *
+ * struct videobuf_buffer holds the data structures used by the helper
+ * functions, additionally some commonly used fields for v4l buffers
+ * (width, height, lists, waitqueue) are in there.  That struct should
+ * be used as first element in the drivers buffer struct.
+ * 
+ * about the mmap helpers (videobuf_mmap_*):
+ *
+ * The mmaper function allows to map any subset of contingous buffers.
+ * This includes one mmap() call for all buffers (which the original
+ * video4linux API uses) as well as one mmap() for every single buffer
+ * (which v4l2 uses).
+ *
+ * If there is a valid mapping for a buffer, buffer->baddr/bsize holds
+ * userspace address + size which can be feeded into the
+ * videobuf_dma_init_user function listed above.
+ *
+ */
+
+struct videobuf_buffer;
+struct videobuf_queue;
+
+struct videobuf_mapping {
+	unsigned int count;
+	int highmem_ok;
+	unsigned long start;
+	unsigned long end;
+	struct videobuf_queue *q;
+};
+
+enum videobuf_state {
+	STATE_NEEDS_INIT = 0,
+	STATE_PREPARED   = 1,
+	STATE_QUEUED     = 2,
+	STATE_ACTIVE     = 3,
+	STATE_DONE       = 4,
+	STATE_ERROR      = 5,
+	STATE_IDLE       = 6,
+};
+
+struct videobuf_buffer {
+	unsigned int            i;
+
+	/* info about the buffer */
+	unsigned int            width;
+	unsigned int            height;
+	unsigned long           size;
+	enum v4l2_field         field;
+	enum videobuf_state     state;
+	struct videobuf_dmabuf  dma;
+	struct list_head        stream;  /* QBUF/DQBUF list */
+
+	/* for mmap'ed buffers */
+	size_t                  boff;    /* buffer offset (mmap) */
+	size_t                  bsize;   /* buffer size */
+	unsigned long           baddr;   /* buffer addr (userland ptr!) */
+	struct videobuf_mapping *map;
+
+	/* touched by irq handler */
+	struct list_head        queue;
+	wait_queue_head_t       done;
+	unsigned int            field_count;
+	struct timeval          ts;
+};
+
+struct videobuf_queue_ops {
+	int (*buf_setup)(struct file *file,
+			 unsigned int *count, unsigned int *size);
+	int (*buf_prepare)(struct file *file,struct videobuf_buffer *vb,
+			   enum v4l2_field field);
+	void (*buf_queue)(struct file *file,struct videobuf_buffer *vb);
+	void (*buf_release)(struct file *file,struct videobuf_buffer *vb);
+};
+
+struct videobuf_queue {
+        struct semaphore           lock;
+	spinlock_t                 *irqlock;
+	struct pci_dev             *pci;
+
+	enum v4l2_buf_type         type;
+	unsigned int               msize;
+	enum v4l2_field            field;
+	enum v4l2_field            last; /* for field=V4L2_FIELD_ALTERNATE */
+	struct videobuf_buffer     *bufs[VIDEO_MAX_FRAME];
+	struct videobuf_queue_ops  *ops;
+
+	/* capture via mmap() + ioctl(QBUF/DQBUF) */
+	unsigned int               streaming;
+	struct list_head           stream;
+
+	/* capture via read() */
+	unsigned int               reading;
+	unsigned int               read_off;
+	struct videobuf_buffer     *read_buf;
+};
+
+void* videobuf_alloc(unsigned int size);
+int videobuf_waiton(struct videobuf_buffer *vb, int non_blocking, int intr);
+int videobuf_iolock(struct pci_dev *pci, struct videobuf_buffer *vb);
+
+void videobuf_queue_init(struct videobuf_queue *q,
+			 struct videobuf_queue_ops *ops,
+			 struct pci_dev *pci, spinlock_t *irqlock,
+			 enum v4l2_buf_type type,
+			 enum v4l2_field field,
+			 unsigned int msize);
+int  videobuf_queue_is_busy(struct videobuf_queue *q);
+void videobuf_queue_cancel(struct file *file, struct videobuf_queue *q);
+
+void videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
+		     enum v4l2_buf_type type);
+int videobuf_reqbufs(struct file *file, struct videobuf_queue *q,
+		     struct v4l2_requestbuffers *req);
+int videobuf_querybuf(struct videobuf_queue *q, struct v4l2_buffer *b);
+int videobuf_qbuf(struct file *file, struct videobuf_queue *q,
+		  struct v4l2_buffer *b);
+int videobuf_dqbuf(struct file *file, struct videobuf_queue *q,
+		   struct v4l2_buffer *b);
+int videobuf_streamon(struct file *file, struct videobuf_queue *q);
+int videobuf_streamoff(struct file *file, struct videobuf_queue *q);
+
+int videobuf_read_start(struct file *file, struct videobuf_queue *q);
+void videobuf_read_stop(struct file *file, struct videobuf_queue *q);
+ssize_t videobuf_read_stream(struct file *file, struct videobuf_queue *q,
+			     char *data, size_t count, loff_t *ppos,
+			     int vbihack);
+ssize_t videobuf_read_one(struct file *file, struct videobuf_queue *q,
+			  char *data, size_t count, loff_t *ppos);
+unsigned int videobuf_poll_stream(struct file *file,
+				  struct videobuf_queue *q,
+				  poll_table *wait);
+
+int videobuf_mmap_setup(struct file *file, struct videobuf_queue *q,
+			unsigned int bcount, unsigned int bsize);
+int videobuf_mmap_free(struct file *file, struct videobuf_queue *q);
+int videobuf_mmap_mapper(struct vm_area_struct *vma,
+			 struct videobuf_queue *q);
+
+/* --------------------------------------------------------------------- */
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
