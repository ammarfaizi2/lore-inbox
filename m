Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTALJDn>; Sun, 12 Jan 2003 04:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTALJDn>; Sun, 12 Jan 2003 04:03:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16075 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267334AbTALJDi>; Sun, 12 Jan 2003 04:03:38 -0500
Date: Sun, 12 Jan 2003 10:12:22 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small cleanups for sound/oss/*
Message-ID: <20030112091222.GR21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following smal fixes for sound/oss/*:
- remove #if'd kernel 2.0 code
- MIN -> min

I've tested the compilation with 2.5.56.

cu
Adrian

--- linux-2.5.56/sound/oss/msnd.c.old	2003-01-12 09:51:29.000000000 +0100
+++ linux-2.5.56/sound/oss/msnd.c	2003-01-12 09:52:26.000000000 +0100
@@ -25,9 +25,6 @@
  ********************************************************************/
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE < 0x020101
-#  define LINUX20
-#endif
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -35,18 +32,10 @@
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#ifdef LINUX20
-#  include <linux/major.h>
-#  include <linux/fs.h>
-#  include <linux/sound.h>
-#  include <asm/segment.h>
-#  include "sound_config.h"
-#else
-#  include <linux/init.h>
-#  include <asm/io.h>
-#  include <asm/uaccess.h>
-#  include <linux/spinlock.h>
-#endif
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <linux/spinlock.h>
 #include <asm/irq.h>
 #include "msnd.h"
 
@@ -364,7 +353,6 @@
 	return -EIO;
 }
 
-#ifndef LINUX20
 EXPORT_SYMBOL(msnd_register);
 EXPORT_SYMBOL(msnd_unregister);
 EXPORT_SYMBOL(msnd_get_num_devs);
@@ -387,7 +375,6 @@
 
 EXPORT_SYMBOL(msnd_enable_irq);
 EXPORT_SYMBOL(msnd_disable_irq);
-#endif
 
 #ifdef MODULE
 MODULE_AUTHOR				("Andrew Veliath <andrewtv@usa.net>");
--- linux-2.5.56/sound/oss/os.h.old	2003-01-12 09:54:06.000000000 +0100
+++ linux-2.5.56/sound/oss/os.h	2003-01-12 09:54:44.000000000 +0100
@@ -7,10 +7,6 @@
 #include <linux/module.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE > 131328
-#define LINUX21X
-#endif
-
 #ifdef __KERNEL__
 #include <linux/utsname.h>
 #include <linux/string.h>
--- linux-2.5.56/sound/core/rtctimer.c.old	2003-01-12 09:55:13.000000000 +0100
+++ linux-2.5.56/sound/core/rtctimer.c	2003-01-12 09:55:50.000000000 +0100
@@ -31,11 +31,7 @@
 
 #if defined(CONFIG_RTC) || defined(CONFIG_RTC_MODULE)
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 2, 12)	/* FIXME: which 2.2.x kernel? */
-#include <linux/rtc.h>
-#else
 #include <linux/mc146818rtc.h>
-#endif
 
 /* use tasklet for interrupt handling */
 #define USE_TASKLET
--- linux-2.5.56/sound/oss/soundcard.c.old	2003-01-12 09:56:51.000000000 +0100
+++ linux-2.5.56/sound/oss/soundcard.c	2003-01-12 09:57:07.000000000 +0100
@@ -135,10 +135,6 @@
 	return 0;
 }
 
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
 /* 4K page size but our output routines use some slack for overruns */
 #define PROC_BLOCK_SIZE (3*1024)
 
--- linux-2.5.56/sound/oss/nm256_audio.c.old	2003-01-12 09:56:22.000000000 +0100
+++ linux-2.5.56/sound/oss/nm256_audio.c	2003-01-12 10:05:38.000000000 +0100
@@ -451,9 +451,6 @@
     }
 }
 
-/* Ultra cheez-whiz.  But I'm too lazy to grep headers. */
-#define MIN(X,Y) ((X) < (Y) ? (X) : (Y))
-
 /* 
  * Read the last-recorded block from the ring buffer, copy it into the
  * saved buffer pointer, and invoke DMAuf_inputintr() with the recording
@@ -481,7 +478,7 @@
 	/* If we wrapped around, copy everything from the start of our
 	   recording buffer to the end of the buffer. */
 	if (currptr < card->curRecPos) {
-	    u32 amt = MIN (ringsize - card->curRecPos, amtToRead);
+	    u32 amt = min (ringsize - card->curRecPos, amtToRead);
 
 	    nm256_readBuffer8 (card, card->recBuf, 1,
 				 card->abuf2 + card->curRecPos,
@@ -494,7 +491,7 @@
 	}
 
 	if ((card->curRecPos < currptr) && (amtToRead > 0)) {
-	    u32 amt = MIN (currptr - card->curRecPos, amtToRead);
+	    u32 amt = min (currptr - card->curRecPos, amtToRead);
 	    nm256_readBuffer8 (card, card->recBuf, 1,
 				 card->abuf2 + card->curRecPos, amt);
 	    card->curRecPos = ((card->curRecPos + amt) % ringsize);
@@ -504,7 +501,6 @@
 	DMAbuf_inputintr (card->dev_for_record);
     }
 }
-#undef MIN
 
 /* 
  * Initialize the hardware. 


