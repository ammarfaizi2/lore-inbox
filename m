Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318111AbSHKHbb>; Sun, 11 Aug 2002 03:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSHKHa4>; Sun, 11 Aug 2002 03:30:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45574 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318216AbSHKH0h>;
	Sun, 11 Aug 2002 03:26:37 -0400
Message-ID: <3D5614E0.B947304@zip.com.au>
Date: Sun, 11 Aug 2002 00:40:16 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 20/21] optimise layout of struct zone
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use the new max cache alignment to optimise the layout of struct zone.

struct zone goes from ~270 bytes (UP) to 768 bytes (SMP, x86).  This is
not a trick which should be generally used.



 mmzone.h |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletion(-)

--- 2.5.31/include/linux/mmzone.h~zone-lock-alignment	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/mmzone.h	Sun Aug 11 00:20:50 2002
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/wait.h>
+#include <linux/cache.h>
 #include <asm/atomic.h>
 
 /*
@@ -28,6 +29,21 @@ typedef struct free_area_struct {
 struct pglist_data;
 
 /*
+ * zone->lock and zone->lru_lock are two of the hottest locks in the kernel.
+ * So add a wild amount of padding here to ensure that they fall into separate
+ * cachelines.  There are very few zone structures in the machine, so space
+ * consumption is not a concern here.
+ */
+#if defined(CONFIG_SMP)
+struct zone_padding {
+	int x;
+} ____cacheline_maxaligned_in_smp;
+#define ZONE_PADDING(name)	struct zone_padding name;
+#else
+#define ZONE_PADDING(name)
+#endif
+
+/*
  * On machines where it is needed (eg PCs) we divide physical memory
  * into multiple physical zones. On a PC we have 3 zones:
  *
@@ -35,6 +51,7 @@ struct pglist_data;
  * ZONE_NORMAL	16-896 MB	direct mapped by the kernel
  * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
  */
+
 struct zone {
 	/*
 	 * Commonly accessed fields:
@@ -44,6 +61,8 @@ struct zone {
 	unsigned long		pages_min, pages_low, pages_high;
 	int			need_balance;
 
+	ZONE_PADDING(_pad1_)
+
 	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
@@ -51,6 +70,8 @@ struct zone {
 	unsigned long		nr_active;
 	unsigned long		nr_inactive;
 
+	ZONE_PADDING(_pad2_)
+
 	/*
 	 * free areas of different sizes
 	 */
@@ -97,7 +118,7 @@ struct zone {
 	 */
 	char			*name;
 	unsigned long		size;
-};
+} ____cacheline_maxaligned_in_smp;
 
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1

.
