Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbQJ0A4e>; Thu, 26 Oct 2000 20:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130434AbQJ0A4Y>; Thu, 26 Oct 2000 20:56:24 -0400
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:5623 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130415AbQJ0A4K>; Thu, 26 Oct 2000 20:56:10 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200010270055.e9R0tkH27477@webber.adilger.net>
Subject: Re: LVM snapshotting broken?
In-Reply-To: <Pine.LNX.4.21.0010261632440.15696-100000@duckman.distro.conectiva>
 "from Rik van Riel at Oct 26, 2000 04:36:37 pm"
To: Rik van Riel <riel@conectiva.com.br>
Date: Thu, 26 Oct 2000 18:55:45 -0600 (MDT)
CC: mauelshagen@sistina.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik writes:
> it looks like the LVM snapshotting in 2.4 doesn't allow you
> to create snapshots from anything else than the _first_ LV
> in the VG...
> 
> It looks like somewhere in either the utilities or the
> kernel, the argument of which LV to snapshot gets mangled...
> Oh, I'm using version 0.8final of the LVM utities.

One thing to notice is that the 0.8final tools have several bugs in them.
Most of these bugs are fixed in my user tools SRPM at:
ftp://ftp.stelias.com/pub/adilger/

If you are compiling on a 2.4 system, you need to patch the lvm.h file
with the following patch, so that you can use the same header in kernel
and user space.  One of the problems with snapshots is that there is a

char __unused

field added in the 2.4 kernel sources that is not in the header for the
user tools, and this is only affecting snapshots, so it is best to use
the same header for both.  This patch should probably be added to the
stock 2.4 kernel...

Give my user tools a try (if you aren't doing so already), to ensure
you aren't hitting a known bug, and the lvm.h patch so you aren't
having trouble with struct parsing between kernel and user space.

Cheers, Andreas
------------ patch to make 2.4 lvm.h usable from LVM user tools ---------
--- linux-2.4.0-test10-pre5/include/linux/lvm.h	Thu Oct 26 18:43:42 2000
+++ linux/include/linux/lvm.h	Thu Oct 26 18:39:13 2000
@@ -49,6 +50,8 @@
  *    08/12/1999 - changed LVM_LV_SIZE_MAX macro to reflect current 1TB limit
  *    01/01/2000 - extended lv_v2 core structure by wait_queue member
  *    12/02/2000 - integrated Andrea Arcagnelli's snapshot work
+ *    18/02/2000 - seperated user and kernel space parts by 
+ *                 #ifdef them with __KERNEL__
  *
  */
 
@@ -56,7 +59,9 @@
 #ifndef _LVM_H_INCLUDE
 #define _LVM_H_INCLUDE
 
-#define	_LVM_H_VERSION	"LVM 0.8final (15/2/2000)"
+#define	_LVM_H_VERSION	"LVM 0.8final (22/02/2000)"
+
+#include <linux/version.h>
 
 /*
  * preprocessor definitions
@@ -64,8 +69,9 @@
 /* if you like emergency reset code in the driver */
 #define	LVM_TOTAL_RESET
 
+#ifdef __KERNEL__
 #define LVM_GET_INODE
-#undef	LVM_HD_NAME
+#define	LVM_HD_NAME
 
 /* lots of debugging output (see driver source)
    #define DEBUG_LVM_GET_INFO
@@ -80,20 +86,19 @@
    #define DEBUG_KFREE
  */
 
-#include <linux/version.h>
-
-#ifndef __KERNEL__
-#define ____NOT_KERNEL____
+#include <linux/kdev_t.h>
+#include <linux/list.h>
+#else
 #define __KERNEL__
-#endif
 #include <linux/kdev_t.h>
-#ifdef ____NOT_KERNEL____
-#undef ____NOT_KERNEL____
+#include <linux/list.h>
 #undef __KERNEL__
-#endif
+#endif /* #ifndef __KERNEL__ */
 
+#include <asm/types.h>
 #include <linux/major.h>
 
+#ifdef __KERNEL__
 #if LINUX_VERSION_CODE >= KERNEL_VERSION ( 2, 3 ,0)
 #include <linux/spinlock.h>
 #else
@@ -101,6 +106,8 @@
 #endif
 
 #include <asm/semaphore.h>
+#endif /* #ifdef __KERNEL__ */
+
 #include <asm/page.h>
 
 #if !defined ( LVM_BLK_MAJOR) || !defined ( LVM_CHAR_MAJOR)
@@ -125,7 +132,7 @@
 #define pv_disk_t pv_disk_v1_t
 #define lv_disk_t lv_disk_v1_t
 #define vg_disk_t vg_disk_v1_t
-#define lv_exception_t lv_v2_exception_t
+#define lv_block_exception_t lv_block_exception_v1_t
 #endif
 
 
@@ -220,7 +227,7 @@
                                     LVM_TIMESTAMP_DISK_SIZE)
 
 /* now for the dynamically calculated parts of the VGDA */
-#define	LVM_LV_DISK_OFFSET(a, b) ( (a)->lv_on_disk.base + sizeof ( lv_t) * b)
+#define	LVM_LV_DISK_OFFSET(a, b) ( (a)->lv_on_disk.base + sizeof ( lv_disk_t) * b)
 #define	LVM_DISK_SIZE(pv) 	 ( (pv)->pe_on_disk.base + \
                                    (pv)->pe_on_disk.size)
 #define	LVM_PE_DISK_OFFSET(pe, pv)	( pe * pv->pe_size + \
@@ -386,8 +392,7 @@
     kdev_t rdev_org;
     ulong rsector_new;
     kdev_t rdev_new;
-} lv_block_exception_t;
-
+} lv_block_exception_v1_t;
 
 /* disk stored pe information */
 typedef struct
@@ -597,10 +558,14 @@
     __u32 lv_remap_end;
     __u32 lv_chunk_size;
     __u32 lv_snapshot_minor;
+#ifdef __KERNEL__
     struct kiobuf * lv_iobuf;
     struct semaphore lv_snapshot_sem;
     struct list_head * lv_snapshot_hash_table;
-    unsigned long lv_snapshot_hash_mask;
+    ulong  lv_snapshot_hash_mask;
+#else
+    char  dummy[200];
+#endif
 } lv_v2_t;
 
 /* disk */
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
