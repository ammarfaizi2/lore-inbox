Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271072AbUJVDLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271072AbUJVDLF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271056AbUJVDJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:09:26 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47064 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271072AbUJUWqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:46:16 -0400
Subject: [patch 1/1] dm: fix printk errors about whether %lu/%Lu is right for sector_t - revised
To: akpm@osdl.org
Cc: agk@redhat.com, neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 22 Oct 2004 00:45:54 +0200
Message-Id: <20041021224554.402233F37@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Device Manager code barfs when sector_t is 64bit wide (i.e. an u64) and
CONFIG_LBD is off. This happens on printk(), resulting in wrong memory
accesses, but also on sscanf(), resulting in overflows (because it uses %lu
for a long long in this case). And region_t, chunk_t are typedefs for
sector_t, so we have warnings for these, too.

Andrew Morton suggested simply using "%llu" and casting sector_t to unsigned
long long; but he missed the sscanf()'s, which cannot be fixed this way.

I've used %llu instead of %Lu for standards conformance, as suggested by 

The problem is this code in drivers/md/dm.h:
/*
 * FIXME: I think this should be with the definition of sector_t
 * in types.h.
 */
#ifdef CONFIG_LBD
#define SECTOR_FORMAT "%Lu"
#else
#define SECTOR_FORMAT "%lu"
#endif

So we must fix the FIXME. However, having sector_t defined by the arch is
wrong in all current cases, and we fix these: we can simply decide this in
linux/types.h following CONFIG_LBD.

So, I have also removed HAVE_SECTOR_T; you can readd it, but it has no users.

All 64-bit arch use a 64-bit wide long for sector_t; almost all 32-bit archs
use a long long only if CONFIG_LBD is on. The only exception is h8300: for
that case, we add CONFIG_LBD = y and we are again in the general case.
And x86_64 does not need to define sector_t on its own.

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

 linux-2.6.9-current-paolo/arch/h8300/Kconfig         |    4 ++++
 linux-2.6.9-current-paolo/drivers/md/dm.h            |   10 ----------
 linux-2.6.9-current-paolo/include/asm-h8300/types.h  |    3 ---
 linux-2.6.9-current-paolo/include/asm-i386/types.h   |    5 -----
 linux-2.6.9-current-paolo/include/asm-mips/types.h   |    5 -----
 linux-2.6.9-current-paolo/include/asm-ppc/types.h    |    5 -----
 linux-2.6.9-current-paolo/include/asm-s390/types.h   |    5 -----
 linux-2.6.9-current-paolo/include/asm-sh/types.h     |    5 -----
 linux-2.6.9-current-paolo/include/asm-x86_64/types.h |    3 ---
 linux-2.6.9-current-paolo/include/linux/types.h      |   17 ++++++++++++++---
 10 files changed, 18 insertions(+), 44 deletions(-)

diff -puN drivers/md/dm.h~fix-dm-warnings drivers/md/dm.h
--- linux-2.6.9-current/drivers/md/dm.h~fix-dm-warnings	2004-10-16 21:58:29.912802872 +0200
+++ linux-2.6.9-current-paolo/drivers/md/dm.h	2004-10-16 21:58:29.954796488 +0200
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
--- linux-2.6.9-current/include/asm-h8300/types.h~fix-dm-warnings	2004-10-16 21:58:29.913802720 +0200
+++ linux-2.6.9-current-paolo/include/asm-h8300/types.h	2004-10-16 21:58:29.954796488 +0200
@@ -55,9 +55,6 @@ typedef unsigned long long u64;
 
 typedef u32 dma_addr_t;
 
-#define HAVE_SECTOR_T
-typedef u64 sector_t;
-
 typedef unsigned int kmem_bufctl_t;
 
 #endif /* __KERNEL__ */
diff -puN include/asm-i386/types.h~fix-dm-warnings include/asm-i386/types.h
--- linux-2.6.9-current/include/asm-i386/types.h~fix-dm-warnings	2004-10-16 21:58:29.914802568 +0200
+++ linux-2.6.9-current-paolo/include/asm-i386/types.h	2004-10-16 21:58:29.955796336 +0200
@@ -58,11 +58,6 @@ typedef u32 dma_addr_t;
 #endif
 typedef u64 dma64_addr_t;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
 typedef unsigned short kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
diff -puN include/asm-mips/types.h~fix-dm-warnings include/asm-mips/types.h
--- linux-2.6.9-current/include/asm-mips/types.h~fix-dm-warnings	2004-10-16 21:58:29.915802416 +0200
+++ linux-2.6.9-current-paolo/include/asm-mips/types.h	2004-10-16 21:58:29.955796336 +0200
@@ -94,11 +94,6 @@ typedef unsigned long long phys_t;
 typedef unsigned long phys_t;
 #endif
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
 typedef unsigned short kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
diff -puN include/asm-ppc/types.h~fix-dm-warnings include/asm-ppc/types.h
--- linux-2.6.9-current/include/asm-ppc/types.h~fix-dm-warnings	2004-10-16 21:58:29.916802264 +0200
+++ linux-2.6.9-current-paolo/include/asm-ppc/types.h	2004-10-16 21:58:29.955796336 +0200
@@ -57,11 +57,6 @@ typedef __vector128 vector128;
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
 typedef unsigned int kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
diff -puN include/asm-s390/types.h~fix-dm-warnings include/asm-s390/types.h
--- linux-2.6.9-current/include/asm-s390/types.h~fix-dm-warnings	2004-10-16 21:58:29.917802112 +0200
+++ linux-2.6.9-current-paolo/include/asm-s390/types.h	2004-10-16 21:58:29.955796336 +0200
@@ -90,11 +90,6 @@ typedef union {
 	} subreg;
 } register_pair;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
 #endif /* ! __s390x__   */
 #endif /* __ASSEMBLY__  */
 #endif /* __KERNEL__    */
diff -puN include/asm-sh/types.h~fix-dm-warnings include/asm-sh/types.h
--- linux-2.6.9-current/include/asm-sh/types.h~fix-dm-warnings	2004-10-16 21:58:29.918801960 +0200
+++ linux-2.6.9-current-paolo/include/asm-sh/types.h	2004-10-16 21:58:29.956796184 +0200
@@ -53,11 +53,6 @@ typedef unsigned long long u64;
 
 typedef u32 dma_addr_t;
 
-#ifdef CONFIG_LBD
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-#endif
-
 typedef unsigned int kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
diff -puN include/asm-x86_64/types.h~fix-dm-warnings include/asm-x86_64/types.h
--- linux-2.6.9-current/include/asm-x86_64/types.h~fix-dm-warnings	2004-10-16 21:58:29.919801808 +0200
+++ linux-2.6.9-current-paolo/include/asm-x86_64/types.h	2004-10-16 21:58:29.956796184 +0200
@@ -48,9 +48,6 @@ typedef unsigned long long u64;
 typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
-typedef u64 sector_t;
-#define HAVE_SECTOR_T
-
 typedef unsigned short kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
diff -puN include/linux/types.h~fix-dm-warnings include/linux/types.h
--- linux-2.6.9-current/include/linux/types.h~fix-dm-warnings	2004-10-16 21:58:29.951796944 +0200
+++ linux-2.6.9-current-paolo/include/linux/types.h	2004-10-16 21:58:29.956796184 +0200
@@ -125,12 +125,23 @@ typedef		__s64		int64_t;
 
 /*
  * The type used for indexing onto a disc or disc partition.
- * If required, asm/types.h can override it and define
- * HAVE_SECTOR_T
+ * You cannot override it any more in asm- includes; define CONFIG_LBD
+ * to turn it inside a long long (only on 32-bit archs).
+ * The DM code must also scanf sector_t's, so here we define SECTOR_FORMAT
+ * for them.
  */
-#ifndef HAVE_SECTOR_T
+
+#ifndef CONFIG_LBD
 typedef unsigned long sector_t;
+#define SECTOR_FORMAT "%lu"
+#else /* CONFIG_LBD */
+#if BITS_PER_LONG == 64
+#error Cannot define CONFIG_LBD on 64-bit archs.
+#else
+typedef unsigned long long sector_t;
+#define SECTOR_FORMAT "%llu"
 #endif
+#endif /* CONFIG_LBD */
 
 /*
  * The type of an index into the pagecache.  Use a #define so asm/types.h
diff -puN arch/h8300/Kconfig~fix-dm-warnings arch/h8300/Kconfig
--- linux-2.6.9-current/arch/h8300/Kconfig~fix-dm-warnings	2004-10-16 21:58:29.952796792 +0200
+++ linux-2.6.9-current-paolo/arch/h8300/Kconfig	2004-10-16 21:58:29.956796184 +0200
@@ -25,6 +25,10 @@ config UID16
 	bool
 	default y
 
+config LBD
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
_
