Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317787AbSGKIQO>; Thu, 11 Jul 2002 04:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSGKIQN>; Thu, 11 Jul 2002 04:16:13 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:20893 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317787AbSGKIQM>;
	Thu, 11 Jul 2002 04:16:12 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bitops cleanup
Date: Thu, 11 Jul 2002 17:55:02 +1000
Message-Id: <20020711081915.1A4144506@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nomenclature tweak and move to bitops.h (also deleted redundant
<asm/bitops.h> double include.

Please apply,
Rusty.

Name: Bitops Cleanup
Author: Rusty Russell
Status: Trivial

D: This renames bitmap_member to DECLARE_BITMAP, and moves it to bitops.h.

diff -urN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24.7405/include/linux/bitops.h linux-2.5.24.7405.updated/include/linux/bitops.h
--- linux-2.5.24.7405/include/linux/bitops.h	Fri Jun  7 13:59:07 2002
+++ linux-2.5.24.7405.updated/include/linux/bitops.h	Sat Jun 22 05:07:14 2002
@@ -2,6 +2,9 @@
 #define _LINUX_BITOPS_H
 #include <asm/bitops.h>
 
+#define DECLARE_BITMAP(name,bits) 
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -106,8 +109,5 @@
         res = (res & 0x33) + ((res >> 2) & 0x33);
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
-
-#include <asm/bitops.h>
-
 
 #endif
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24.7405/include/linux/types.h linux-2.5.24.7405.updated/include/linux/types.h
--- linux-2.5.24.7405/include/linux/types.h	Mon Jun 17 23:19:25 2002
+++ linux-2.5.24.7405.updated/include/linux/types.h	Sat Jun 22 05:07:14 2002
@@ -3,9 +3,6 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
-
-#define bitmap_member(name,bits) 
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
 #endif
 
 #include <linux/posix_types.h>
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24.7405/include/sound/ac97_codec.h linux-2.5.24.7405.updated/include/sound/ac97_codec.h
--- linux-2.5.24.7405/include/sound/ac97_codec.h	Fri Jun 21 09:41:55 2002
+++ linux-2.5.24.7405.updated/include/sound/ac97_codec.h	Sat Jun 22 05:21:08 2002
@@ -25,6 +25,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include "control.h"
 #include "info.h"
 
@@ -169,7 +170,7 @@
 	unsigned int rates_mic_adc;
 	unsigned int spdif_status;
 	unsigned short regs[0x80]; /* register cache */
-	bitmap_member(reg_accessed,0x80); /* bit flags */
+	DECLARE_BITMAP(reg_accessed, 0x80); /* bit flags */
 	union {			/* vendor specific code */
 		struct {
 			unsigned short unchained[3];	// 0 = C34, 1 = C79, 2 = C69
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24.7405/sound/core/seq/seq_clientmgr.h linux-2.5.24.7405.updated/sound/core/seq/seq_clientmgr.h
--- linux-2.5.24.7405/sound/core/seq/seq_clientmgr.h	Fri Jun 21 09:41:57 2002
+++ linux-2.5.24.7405.updated/sound/core/seq/seq_clientmgr.h	Sat Jun 22 05:20:37 2002
@@ -53,7 +53,7 @@
 	char name[64];		/* client name */
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
-	bitmap_member(event_filter, 256);
+	DECLARE_BITMAP(event_filter, 256);
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.24.7405/sound/core/seq/seq_queue.h linux-2.5.24.7405.updated/sound/core/seq/seq_queue.h
--- linux-2.5.24.7405/sound/core/seq/seq_queue.h	Fri Jun 21 09:41:57 2002
+++ linux-2.5.24.7405.updated/sound/core/seq/seq_queue.h	Sat Jun 22 05:08:27 2002
@@ -26,6 +26,7 @@
 #include "seq_lock.h"
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 
 #define SEQ_QUEUE_NO_OWNER (-1)
 
@@ -51,7 +52,7 @@
 	spinlock_t check_lock;
 
 	/* clients which uses this queue (bitmap) */
-	bitmap_member(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
+ 	DECLARE_BITMAP(clients_bitmap, SNDRV_SEQ_MAX_CLIENTS);
 	unsigned int clients;	/* users of this queue */
 	struct semaphore timer_mutex;
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
