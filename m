Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTEKKYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTEKKX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:23:57 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:38204 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S261244AbTEKKVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:39 -0400
Date: Sun, 11 May 2003 12:31:06 +0200
Message-Id: <200305111031.h4BAV6Bg019736@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound resurrection
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect dmasound:
  - Re-add dmasound to the build process
  - Update dmasound.h, which got missed in the dmasound update in 2.5.15
  - Compile fixes for core, Atari, Amiga Paula, and Q40:
      o Update for s/MINOR/minor/g changes
      o Add missing <linux/interrupt.h>
      o Fix spinlock typo

--- linux-2.5.68/sound/Makefile	Mon Feb 10 21:59:35 2003
+++ linux-m68k-2.5.68/sound/Makefile	Mon Apr  7 16:49:16 2003
@@ -3,6 +3,7 @@
 
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
+obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/
 
 ifeq ($(CONFIG_SND),y)
--- linux-2.5.68/sound/oss/dmasound/dmasound.h	Tue Oct  1 18:44:25 2002
+++ linux-m68k-2.5.68/sound/oss/dmasound/dmasound.h	Mon Apr 21 17:33:54 2003
@@ -1,4 +1,4 @@
-
+#ifndef _dmasound_h_
 /*
  *  linux/drivers/sound/dmasound/dmasound.h
  *
@@ -10,11 +10,11 @@
  *  device for true DSP processors but it will be called something else.
  *  In v3.0 it's /dev/sndproc but this could be a temporary solution.
  */
+#define _dmasound_h_
 
-
+#include <linux/types.h>
 #include <linux/config.h>
 
-
 #define SND_NDEVS	256	/* Number of supported devices */
 #define SND_DEV_CTL	0	/* Control port /dev/mixer */
 #define SND_DEV_SEQ	1	/* Sequencer output /dev/sequencer (FM
@@ -29,23 +29,16 @@
 #define SND_DEV_SNDPROC 9	/* /dev/sndproc for programmable devices */
 #define SND_DEV_PSS	SND_DEV_SNDPROC
 
-#define DSP_DEFAULT_SPEED	8000
-
-#define ON		1
-#define OFF		0
+/* switch on various prinks */
+#define DEBUG_DMASOUND 1
 
 #define MAX_AUDIO_DEV	5
-#define MAX_MIXER_DEV	2
+#define MAX_MIXER_DEV	4
 #define MAX_SYNTH_DEV	3
 #define MAX_MIDI_DEV	6
 #define MAX_TIMER_DEV	3
 
-
 #define MAX_CATCH_RADIUS	10
-#define MIN_BUFFERS		4
-#define MIN_BUFSIZE		4	/* in KB */
-#define MAX_BUFSIZE		128	/* Limit for Amiga in KB */
-
 
 #define le2be16(x)	(((x)<<8 & 0xff00) | ((x)>>8 & 0x00ff))
 #define le2be16dbl(x)	(((x)<<8 & 0xff00ff00) | ((x)>>8 & 0x00ff00ff))
@@ -67,21 +60,34 @@
      */
 
 #undef HAS_8BIT_TABLES
-#undef HAS_14BIT_TABLES
-#undef HAS_16BIT_TABLES
 #undef HAS_RECORD
 
 #if defined(CONFIG_DMASOUND_ATARI) || defined(CONFIG_DMASOUND_ATARI_MODULE) ||\
     defined(CONFIG_DMASOUND_PAULA) || defined(CONFIG_DMASOUND_PAULA_MODULE) ||\
     defined(CONFIG_DMASOUND_Q40) || defined(CONFIG_DMASOUND_Q40_MODULE)
 #define HAS_8BIT_TABLES
+#define MIN_BUFFERS	4
+#define MIN_BUFSIZE	(1<<12)	/* in bytes (- where does this come from ?) */
+#define MIN_FRAG_SIZE	8	/* not 100% sure about this */
+#define MAX_BUFSIZE	(1<<17)	/* Limit for Amiga is 128 kb */
+#define MAX_FRAG_SIZE	15	/* allow *4 for mono-8 => stereo-16 (for multi) */
+
+#else /* is pmac and multi is off */
+
+#define MIN_BUFFERS	2
+#define MIN_BUFSIZE	(1<<8)	/* in bytes */
+#define MIN_FRAG_SIZE	8
+#define MAX_BUFSIZE	(1<<18)	/* this is somewhat arbitrary for pmac */
+#define MAX_FRAG_SIZE	16	/* need to allow *4 for mono-8 => stereo-16 */
 #endif
-#if defined(CONFIG_DMASOUND_AWACS) || defined(CONFIG_DMASOUND_AWACS_MODULE)
-#define HAS_16BIT_TABLES
+
+#define DEFAULT_N_BUFFERS 4
+#define DEFAULT_BUFF_SIZE (1<<15)
+
+#if defined(CONFIG_DMASOUND_PMAC) || defined(CONFIG_DMASOUND_PMAC_MODULE)
 #define HAS_RECORD
 #endif
 
-
     /*
      *  Initialization
      */
@@ -93,6 +99,14 @@
 #define dmasound_deinit()	do { } while (0)
 #endif
 
+/* description of the set-up applies to either hard or soft settings */
+
+typedef struct {
+    int format;		/* AFMT_* */
+    int stereo;		/* 0 = mono, 1 = stereo */
+    int size;		/* 8/16 bit*/
+    int speed;		/* speed */
+} SETTINGS;
 
     /*
      *  Machine definitions
@@ -117,30 +131,29 @@
     int (*setTreble)(int);
     int (*setGain)(int);
     void (*play)(void);
-    void (*record)(void);			/* optional */
-    void (*mixer_init)(void);			/* optional */
-    int (*mixer_ioctl)(u_int, u_long);		/* optional */
-    void (*write_sq_setup)(void);		/* optional */
-    void (*read_sq_setup)(void);		/* optional */
-    void (*sq_open)(void);			/* optional */
-    int (*state_info)(char *);			/* optional */
-    void (*abort_read)(void);			/* optional */
+    void (*record)(void);		/* optional */
+    void (*mixer_init)(void);		/* optional */
+    int (*mixer_ioctl)(u_int, u_long);	/* optional */
+    int (*write_sq_setup)(void);	/* optional */
+    int (*read_sq_setup)(void);		/* optional */
+    int (*sq_open)(mode_t);		/* optional */
+    int (*state_info)(char *, size_t);	/* optional */
+    void (*abort_read)(void);		/* optional */
     int min_dsp_speed;
+    int max_dsp_speed;
+    int version ;
+    int hardware_afmts ;		/* OSS says we only return h'ware info */
+					/* when queried via SNDCTL_DSP_GETFMTS */
+    int capabilities ;		/* low-level reply to SNDCTL_DSP_GETCAPS */
+    SETTINGS default_hard ;	/* open() or init() should set something valid */
+    SETTINGS default_soft ;	/* you can make it look like old OSS, if you want to */
 } MACHINE;
 
-
     /*
      *  Low level stuff
      */
 
 typedef struct {
-    int format;		/* AFMT_* */
-    int stereo;		/* 0 = mono, 1 = stereo */
-    int size;		/* 8/16 bit*/
-    int speed;		/* speed */
-} SETTINGS;
-
-typedef struct {
     ssize_t (*ct_ulaw)(const u_char *, size_t, u_char *, ssize_t *, ssize_t);
     ssize_t (*ct_alaw)(const u_char *, size_t, u_char *, ssize_t *, ssize_t);
     ssize_t (*ct_s8)(const u_char *, size_t, u_char *, ssize_t *, ssize_t);
@@ -171,11 +184,10 @@
 
 extern struct sound_settings dmasound;
 
+#ifdef HAS_8BIT_TABLES
 extern char dmasound_ulaw2dma8[];
 extern char dmasound_alaw2dma8[];
-extern short dmasound_ulaw2dma16[];
-extern short dmasound_alaw2dma16[];
-
+#endif
 
     /*
      *  Mid level stuff
@@ -208,14 +220,17 @@
 
 struct sound_queue {
     /* buffers allocated for this queue */
-    int numBufs;
-    int bufSize;			/* in bytes */
+    int numBufs;		/* real limits on what the user can have */
+    int bufSize;		/* in bytes */
     char **buffers;
 
     /* current parameters */
-    int max_count;
-    int block_size;			/* in bytes */
-    int max_active;
+    int locked ;		/* params cannot be modified when != 0 */
+    int user_frags ;		/* user requests this many */
+    int user_frag_size ;	/* of this size */
+    int max_count;		/* actual # fragments <= numBufs */
+    int block_size;		/* internal block size in bytes */
+    int max_active;		/* in-use fragments <= max_count */
 
     /* it shouldn't be necessary to declare any of these volatile */
     int front, rear, count;
@@ -231,19 +246,32 @@
     int active;
     wait_queue_head_t action_queue, open_queue, sync_queue;
     int open_mode;
-    int busy, syncing;
+    int busy, syncing, xruns, died;
 };
 
 #define SLEEP(queue)		interruptible_sleep_on_timeout(&queue, HZ)
 #define WAKE_UP(queue)		(wake_up_interruptible(&queue))
 
 extern struct sound_queue dmasound_write_sq;
-extern struct sound_queue dmasound_read_sq;
-
 #define write_sq	dmasound_write_sq
+
+#ifdef HAS_RECORD
+extern struct sound_queue dmasound_read_sq;
 #define read_sq		dmasound_read_sq
+#endif
 
 extern int dmasound_catchRadius;
-
 #define catchRadius	dmasound_catchRadius
 
+/* define the value to be put in the byte-swap reg in mac-io
+   when we want it to swap for us.
+*/
+#define BS_VAL 1
+
+static inline void wait_ms(unsigned int ms)
+{
+	current->state = TASK_UNINTERRUPTIBLE;
+	schedule_timeout(1 + ms * HZ / 1000);
+}
+
+#endif /* _dmasound_h_ */
--- linux-2.5.68/sound/oss/dmasound/dmasound_atari.c	Sun Apr 20 12:29:14 2003
+++ linux-m68k-2.5.68/sound/oss/dmasound/dmasound_atari.c	Mon Apr 21 18:17:41 2003
@@ -20,6 +20,8 @@
 #include <linux/soundcard.h>
 #include <linux/mm.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/atariints.h>
--- linux-2.5.68/sound/oss/dmasound/dmasound_core.c	Sun Apr 20 12:29:14 2003
+++ linux-m68k-2.5.68/sound/oss/dmasound/dmasound_core.c	Mon Apr 21 17:40:45 2003
@@ -904,7 +904,7 @@
 	  O_RDONLY and dsp1 could be opened O_WRONLY
 	*/
 
-	dmasound.minDev = MINOR(inode->i_rdev) & 0x0f;
+	dmasound.minDev = minor(inode->i_rdev) & 0x0f;
 
 	/* OK. - we should make some attempt at consistency. At least the H'ware
 	   options should be set with a valid mode.  We will make it that the LL
--- linux-2.5.68/sound/oss/dmasound/dmasound_paula.c	Sun Apr 20 12:29:14 2003
+++ linux-m68k-2.5.68/sound/oss/dmasound/dmasound_paula.c	Mon Apr 21 17:42:35 2003
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/soundcard.h>
+#include <linux/interrupt.h>
 
 #include <asm/uaccess.h>
 #include <asm/setup.h>
--- linux-2.5.68/sound/oss/dmasound/dmasound_q40.c	Sun Apr 20 12:29:14 2003
+++ linux-m68k-2.5.68/sound/oss/dmasound/dmasound_q40.c	Mon Apr 21 18:22:25 2003
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/soundcard.h>
+#include <linux/interrupt.h>
 
 #include <asm/uaccess.h>
 #include <asm/q40ints.h>
@@ -461,7 +462,7 @@
 	}
 	spin_lock_irqsave(&dmasound.lock, flags);
 	Q40PlayNextFrame(1);
-	spin_unlock_irqrestore_flags(&dmasound.lock, flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 }
 
 static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
