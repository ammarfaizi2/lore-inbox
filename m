Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSGZGDj>; Fri, 26 Jul 2002 02:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGZGDj>; Fri, 26 Jul 2002 02:03:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:12215 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316886AbSGZGDi>;
	Fri, 26 Jul 2002 02:03:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] bitmap_member -> DECLARE_BITMAP
Date: Fri, 26 Jul 2002 16:05:45 +1000
Message-Id: <20020726060801.727734353@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick, quick!  Before it spreads!

Thanks,
Rusty.

Name: Bitops Cleanup
Author: Rusty Russell
Status: Trivial

D: This renames bitmap_member to DECLARE_BITMAP, and moves it to bitops.h.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/drivers/zorro/zorro.c linux-2.5.28.31516.updated/drivers/zorro/zorro.c
--- linux-2.5.28.31516/drivers/zorro/zorro.c	Thu Jul 25 10:13:15 2002
+++ linux-2.5.28.31516.updated/drivers/zorro/zorro.c	Fri Jul 26 16:01:10 2002
@@ -80,7 +80,7 @@ struct zorro_dev *zorro_find_device(zorr
      *  FIXME: use the normal resource management
      */
 
-bitmap_member(zorro_unused_z2ram, 128);
+DECLARE_BITMAP(zorro_unused_z2ram, 128);
 
 
 static void __init mark_region(unsigned long start, unsigned long end,
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/linux/bitops.h linux-2.5.28.31516.updated/include/linux/bitops.h
--- linux-2.5.28.31516/include/linux/bitops.h	Mon Jun 24 00:53:24 2002
+++ linux-2.5.28.31516.updated/include/linux/bitops.h	Fri Jul 26 15:59:03 2002
@@ -2,6 +2,9 @@
 #define _LINUX_BITOPS_H
 #include <asm/bitops.h>
 
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -106,8 +109,5 @@ static inline unsigned int generic_hweig
         res = (res & 0x33) + ((res >> 2) & 0x33);
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
-
-#include <asm/bitops.h>
-
 
 #endif
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/linux/types.h linux-2.5.28.31516.updated/include/linux/types.h
--- linux-2.5.28.31516/include/linux/types.h	Mon Jun 17 23:19:25 2002
+++ linux-2.5.28.31516.updated/include/linux/types.h	Fri Jul 26 15:59:03 2002
@@ -3,9 +3,6 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
-
-#define bitmap_member(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
 #endif
 
 #include <linux/posix_types.h>
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/linux/zorro.h linux-2.5.28.31516.updated/include/linux/zorro.h
--- linux-2.5.28.31516/include/linux/zorro.h	Thu Jul 25 10:13:18 2002
+++ linux-2.5.28.31516.updated/include/linux/zorro.h	Fri Jul 26 16:00:30 2002
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
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/include/sound/ac97_codec.h linux-2.5.28.31516.updated/include/sound/ac97_codec.h
--- linux-2.5.28.31516/include/sound/ac97_codec.h	Fri Jun 21 09:41:55 2002
+++ linux-2.5.28.31516.updated/include/sound/ac97_codec.h	Fri Jul 26 15:59:03 2002
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
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/sound/core/seq/seq_clientmgr.h linux-2.5.28.31516.updated/sound/core/seq/seq_clientmgr.h
--- linux-2.5.28.31516/sound/core/seq/seq_clientmgr.h	Fri Jun 21 09:41:57 2002
+++ linux-2.5.28.31516.updated/sound/core/seq/seq_clientmgr.h	Fri Jul 26 15:59:03 2002
@@ -53,7 +53,7 @@ struct _snd_seq_client {
 	char name[64];		/* client name */
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
-	bitmap_member(event_filter, 256);
+	DECLARE_BITMAP(event_filter, 256);
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.31516/sound/core/seq/seq_queue.h linux-2.5.28.31516.updated/sound/core/seq/seq_queue.h
--- linux-2.5.28.31516/sound/core/seq/seq_queue.h	Fri Jun 21 09:41:57 2002
+++ linux-2.5.28.31516.updated/sound/core/seq/seq_queue.h	Fri Jul 26 15:59:03 2002
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
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
