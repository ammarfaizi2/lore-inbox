Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269993AbUJHOlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269993AbUJHOlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269996AbUJHOlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:41:07 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:16008
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269993AbUJHOkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:40:33 -0400
Subject: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is right for sector_t
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 08 Oct 2004 16:40:33 +0200
Message-Id: <20041008144034.EB891B557@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Device Manager code barfs when sector_t is 64bit wide (i.e. an u64);
this can happen with CONFIG_LBD on i386, too, but sector_t is usually a long.
And region_t, chunk_t are typedefs for sector_t.

The problem is this code in drivers/md/dm.h (wouldn't we better fix the
FIXME?):

/*
 * FIXME: I think this should be with the definition of sector_t
 * in types.h.
 */
#ifdef CONFIG_LBD
#define SECTOR_FORMAT "%Lu"
#else
#define SECTOR_FORMAT "%lu"
#endif

Btw, x86_64 does not need to define sector_t on its own.
If there is any _good_ reason for that, the fix becomes adding a 
#define SECTOR_FORMAT "%Lu"
in fact, gcc tries to be smart for warnings to ensure portability; so, even
when sizeof(long) == sizeof(long long), "%ld" and "%Ld" are different, for the
warnings).

Sample warnings (from both 2.6.8.1 and 2.6.9-rc2):
drivers/md/dm-raid1.c: In function `get_mirror':
drivers/md/dm-raid1.c:930: warning: long unsigned int format, sector_t arg (arg 3)
drivers/md/dm-raid1.c: In function `mirror_status':
drivers/md/dm-raid1.c:1200: warning: long unsigned int format, region_t arg (arg 4)
drivers/md/dm-raid1.c:1200: warning: long unsigned int format, region_t arg (arg 5)
drivers/md/dm-raid1.c:1206: warning: long unsigned int format, sector_t arg (arg 5)
drivers/md/dm-raid1.c:1212: warning: long unsigned int format, sector_t arg (arg 5)

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/drivers/md/dm.h            |   10 ----------
 linux-2.6.9-current-paolo/include/asm-h8300/types.h  |    1 +
 linux-2.6.9-current-paolo/include/asm-i386/types.h   |    1 +
 linux-2.6.9-current-paolo/include/asm-mips/types.h   |    1 +
 linux-2.6.9-current-paolo/include/asm-ppc/types.h    |    1 +
 linux-2.6.9-current-paolo/include/asm-s390/types.h   |    1 +
 linux-2.6.9-current-paolo/include/asm-sh/types.h     |    1 +
 linux-2.6.9-current-paolo/include/asm-x86_64/types.h |    3 ---
 linux-2.6.9-current-paolo/include/linux/types.h      |    1 +
 9 files changed, 7 insertions(+), 13 deletions(-)

diff -puN drivers/md/dm.h~fix-dm-warnings drivers/md/dm.h
--- linux-2.6.9-current/drivers/md/dm.h~fix-dm-warnings	2004-10-08 16:39:05.888125592 +0200
+++ linux-2.6.9-current-paolo/drivers/md/dm.h	2004-10-08 16:39:05.942117384 +0200
@@ -22,16 +22,6 @@
 #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
 			  0 : scnprintf(result + sz, maxlen - sz, x))
 
-/*
- * FIXME: I think this should be with the definition of sector_t
- * in types.h.
- */
-#ifdef CONFIG_LBD
-#define SECTOR_FORMAT "%Lu"
-#else
-#define SECTOR_FORMAT "%lu"
-#endif
-
 #define SECTOR_SHIFT 9
 
 /*
diff -puN include/asm-h8300/types.h~fix-dm-warnings include/asm-h8300/types.h
--- linux-2.6.9-current/include/asm-h8300/types.h~fix-dm-warnings	2004-10-08 16:39:05.902123464 +0200
+++ linux-2.6.9-current-paolo/include/asm-h8300/types.h	2004-10-08 16:39:05.959114800 +0200
@@ -56,6 +56,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 
 #define HAVE_SECTOR_T
+#define SECTOR_FORMAT "%Lu"
 typedef u64 sector_t;
 
 typedef unsigned int kmem_bufctl_t;
diff -puN include/asm-i386/types.h~fix-dm-warnings include/asm-i386/types.h
--- linux-2.6.9-current/include/asm-i386/types.h~fix-dm-warnings	2004-10-08 16:39:05.914121640 +0200
+++ linux-2.6.9-current-paolo/include/asm-i386/types.h	2004-10-08 16:39:05.959114800 +0200
@@ -60,6 +60,7 @@ typedef u64 dma64_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FORMAT "%Lu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-mips/types.h~fix-dm-warnings include/asm-mips/types.h
--- linux-2.6.9-current/include/asm-mips/types.h~fix-dm-warnings	2004-10-08 16:39:05.915121488 +0200
+++ linux-2.6.9-current-paolo/include/asm-mips/types.h	2004-10-08 16:39:05.980111608 +0200
@@ -96,6 +96,7 @@ typedef unsigned long phys_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FORMAT "%Lu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-ppc/types.h~fix-dm-warnings include/asm-ppc/types.h
--- linux-2.6.9-current/include/asm-ppc/types.h~fix-dm-warnings	2004-10-08 16:39:05.916121336 +0200
+++ linux-2.6.9-current-paolo/include/asm-ppc/types.h	2004-10-08 16:39:05.980111608 +0200
@@ -59,6 +59,7 @@ typedef u64 dma64_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FORMAT "%Lu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-s390/types.h~fix-dm-warnings include/asm-s390/types.h
--- linux-2.6.9-current/include/asm-s390/types.h~fix-dm-warnings	2004-10-08 16:39:05.917121184 +0200
+++ linux-2.6.9-current-paolo/include/asm-s390/types.h	2004-10-08 16:39:05.981111456 +0200
@@ -92,6 +92,7 @@ typedef union {
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FORMAT "%Lu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-sh/types.h~fix-dm-warnings include/asm-sh/types.h
--- linux-2.6.9-current/include/asm-sh/types.h~fix-dm-warnings	2004-10-08 16:39:05.920120728 +0200
+++ linux-2.6.9-current-paolo/include/asm-sh/types.h	2004-10-08 16:39:05.981111456 +0200
@@ -55,6 +55,7 @@ typedef u32 dma_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FORMAT "%Lu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-x86_64/types.h~fix-dm-warnings include/asm-x86_64/types.h
--- linux-2.6.9-current/include/asm-x86_64/types.h~fix-dm-warnings	2004-10-08 16:39:05.921120576 +0200
+++ linux-2.6.9-current-paolo/include/asm-x86_64/types.h	2004-10-08 16:39:05.981111456 +0200
@@ -48,9 +48,6 @@ typedef unsigned long long u64;
 typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-
 typedef unsigned short kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
diff -puN include/linux/types.h~fix-dm-warnings include/linux/types.h
--- linux-2.6.9-current/include/linux/types.h~fix-dm-warnings	2004-10-08 16:39:05.939117840 +0200
+++ linux-2.6.9-current-paolo/include/linux/types.h	2004-10-08 16:39:05.959114800 +0200
@@ -130,6 +130,7 @@ typedef		__s64		int64_t;
  */
 #ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
+#define SECTOR_FORMAT "%lu"
 #endif
 
 /*
_
