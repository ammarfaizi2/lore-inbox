Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHZGnB>; Mon, 26 Aug 2002 02:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSHZGnB>; Mon, 26 Aug 2002 02:43:01 -0400
Received: from dp.samba.org ([66.70.73.150]:57837 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317946AbSHZGm7>;
	Mon, 26 Aug 2002 02:42:59 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org,
       Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] (re-xmit) bitmap_member cleanup
Date: Mon, 26 Aug 2002 10:17:34 +1000
Message-Id: <20020826014738.22E1E2C110@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use bitmap_member, but the name is biassed towards declaring
struct fields.  Also fixes both current users.

Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Bitops Cleanup
Author: Rusty Russell
Status: Trivial

D: This renames bitmap_member to DECLARE_BITMAP, and moves it to bitops.h.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/drivers/zorro/zorro.c .7898-linux-2.5.31.updated/drivers/zorro/zorro.c
--- .7898-linux-2.5.31/drivers/zorro/zorro.c	2002-07-25 10:13:15.000000000 +1000
+++ .7898-linux-2.5.31.updated/drivers/zorro/zorro.c	2002-08-12 18:32:06.000000000 +1000
@@ -80,7 +80,7 @@ struct zorro_dev *zorro_find_device(zorr
      *  FIXME: use the normal resource management
      */
 
-bitmap_member(zorro_unused_z2ram, 128);
+DECLARE_BITMAP(zorro_unused_z2ram, 128);
 
 
 static void __init mark_region(unsigned long start, unsigned long end,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/include/linux/bitops.h .7898-linux-2.5.31.updated/include/linux/bitops.h
--- .7898-linux-2.5.31/include/linux/bitops.h	2002-06-24 00:53:24.000000000 +1000
+++ .7898-linux-2.5.31.updated/include/linux/bitops.h	2002-08-12 18:33:56.000000000 +1000
@@ -1,6 +1,11 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
 #include <asm/bitops.h>
+#include <asm/types.h>
+
+#define BITS_TO_LONG(bits) (((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[BITS_TO_LONG(bits)]
 
 /*
  * ffs: find first bit set. This is defined the same way as
@@ -107,7 +112,4 @@ static inline unsigned int generic_hweig
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
-#include <asm/bitops.h>
-
-
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/include/linux/types.h .7898-linux-2.5.31.updated/include/linux/types.h
--- .7898-linux-2.5.31/include/linux/types.h	2002-06-17 23:19:25.000000000 +1000
+++ .7898-linux-2.5.31.updated/include/linux/types.h	2002-08-12 18:32:06.000000000 +1000
@@ -3,9 +3,6 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
-
-#define bitmap_member(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
 #endif
 
 #include <linux/posix_types.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/include/linux/zorro.h .7898-linux-2.5.31.updated/include/linux/zorro.h
--- .7898-linux-2.5.31/include/linux/zorro.h	2002-07-25 10:13:18.000000000 +1000
+++ .7898-linux-2.5.31.updated/include/linux/zorro.h	2002-08-12 18:32:06.000000000 +1000
@@ -10,6 +10,7 @@
 
 #ifndef _LINUX_ZORRO_H
 #define _LINUX_ZORRO_H
+#include <linux/bitops.h>
 
 #ifndef __ASSEMBLY__
 
@@ -199,7 +200,7 @@ extern struct zorro_dev *zorro_find_devi
      *  the corresponding bits.
      */
 
-extern bitmap_member(zorro_unused_z2ram, 128);
+extern DECLARE_BITMAP(zorro_unused_z2ram, 128);
 
 #define Z2RAM_START		(0x00200000)
 #define Z2RAM_END		(0x00a00000)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/include/sound/ac97_codec.h .7898-linux-2.5.31.updated/include/sound/ac97_codec.h
--- .7898-linux-2.5.31/include/sound/ac97_codec.h	2002-06-21 09:41:55.000000000 +1000
+++ .7898-linux-2.5.31.updated/include/sound/ac97_codec.h	2002-08-12 18:32:06.000000000 +1000
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include "control.h"
 #include "info.h"
 
@@ -169,7 +170,7 @@ struct _snd_ac97 {
 	unsigned int rates_mic_adc;
 	unsigned int spdif_status;
 	unsigned short regs[0x80]; /* register cache */
-	bitmap_member(reg_accessed,0x80); /* bit flags */
+	DECLARE_BITMAP(reg_accessed, 0x80); /* bit flags */
 	union {			/* vendor specific code */
 		struct {
 			unsigned short unchained[3];	// 0 = C34, 1 = C79, 2 = C69
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/sound/core/seq/seq_clientmgr.h .7898-linux-2.5.31.updated/sound/core/seq/seq_clientmgr.h
--- .7898-linux-2.5.31/sound/core/seq/seq_clientmgr.h	2002-06-21 09:41:57.000000000 +1000
+++ .7898-linux-2.5.31.updated/sound/core/seq/seq_clientmgr.h	2002-08-12 18:32:06.000000000 +1000
@@ -53,7 +53,7 @@ struct _snd_seq_client {
 	char name[64];		/* client name */
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
-	bitmap_member(event_filter, 256);
+	DECLARE_BITMAP(event_filter, 256);
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7898-linux-2.5.31/sound/core/seq/seq_queue.h .7898-linux-2.5.31.updated/sound/core/seq/seq_queue.h
--- .7898-linux-2.5.31/sound/core/seq/seq_queue.h	2002-06-21 09:41:57.000000000 +1000
+++ .7898-linux-2.5.31.updated/sound/core/seq/seq_queue.h	2002-08-12 18:32:06.000000000 +1000
@@ -26,6 +26,7 @@
 #include "seq_lock.h"
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 
 #define SEQ_QUEUE_NO_OWNER (-1)
 
@@ -51,7 +52,7 @@ struct _snd_seq_queue {
 	spinlock_t check_lock;
 
 	/* clients which uses this queue (bitmap) */
-	bitmap_member(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
+ 	DECLARE_BITMAP(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
 	unsigned int clients;	/* users of this queue */
 	struct semaphore timer_mutex;
 
