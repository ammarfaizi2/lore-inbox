Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRCOIRW>; Thu, 15 Mar 2001 03:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131648AbRCOIRQ>; Thu, 15 Mar 2001 03:17:16 -0500
Received: from linuxcare.com.au ([203.29.91.49]:46857 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131644AbRCOIRF>; Thu, 15 Mar 2001 03:17:05 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 15 Mar 2001 19:13:52 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: Only one memory zone for sparc64
Message-ID: <20010315191352.D1598@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On sparc64 we dont care about the different memory zones and iterating
through them all over the place only serves to waste CPU. I suspect this
would be the case with some other architectures but for the moment I
have just enabled it for sparc64.

With this patch I get close to a 1% improvement in dbench on the dual
ultra60.

Anton

diff -ru linux/include/linux/mmzone.h linux_work/include/linux/mmzone.h
--- linux/include/linux/mmzone.h	Thu Mar 15 19:03:47 2001
+++ linux_work/include/linux/mmzone.h	Tue Mar 13 18:46:59 2001
@@ -63,7 +63,19 @@
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1
 #define ZONE_HIGHMEM		2
+#ifdef __sparc_v9__
+#define MAX_NR_ZONES		1
+#define ZONE_NAMES		{ "DMA" }
+#define ZONE_BALANCE_RATIO	{ 32 }
+#define ZONE_BALANCE_MIN	{ 10 }
+#define ZONE_BALANCE_MAX	{ 255 }
+#else
 #define MAX_NR_ZONES		3
+#define ZONE_NAMES		{ "DMA", "Normal", "HighMem" }
+#define ZONE_BALANCE_RATIO	{ 32, 128, 128 }
+#define ZONE_BALANCE_MIN	{ 10, 10, 10 }
+#define ZONE_BALANCE_MAX	{ 255, 255, 255 }
+#endif
 
 /*
  * One allocation request operates on a zonelist. A zonelist
diff -ru linux/mm/page_alloc.c linux_work/mm/page_alloc.c
--- linux/mm/page_alloc.c	Mon Mar 12 13:33:02 2001
+++ linux_work/mm/page_alloc.c	Mon Mar 12 13:00:08 2001
@@ -23,10 +23,10 @@
 int nr_inactive_dirty_pages;
 pg_data_t *pgdat_list;
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
-static int zone_balance_ratio[MAX_NR_ZONES] = { 32, 128, 128, };
-static int zone_balance_min[MAX_NR_ZONES] = { 10 , 10, 10, };
-static int zone_balance_max[MAX_NR_ZONES] = { 255 , 255, 255, };
+static char *zone_names[MAX_NR_ZONES] = ZONE_NAMES;
+static int zone_balance_ratio[MAX_NR_ZONES] = ZONE_BALANCE_RATIO;
+static int zone_balance_min[MAX_NR_ZONES] = ZONE_BALANCE_MIN;
+static int zone_balance_max[MAX_NR_ZONES] = ZONE_BALANCE_MAX;
 
 struct list_head active_list;
 struct list_head inactive_dirty_list;
