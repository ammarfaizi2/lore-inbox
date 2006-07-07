Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWGGXUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWGGXUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWGGXTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:47 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65213 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932392AbWGGXTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:19:24 -0400
Date: Fri, 7 Jul 2006 16:19:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060707231901.3790.43520.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 10/11] Remove display of counters for unconfigured zones
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eventcounters: Do not display counters for zones that are not available on an arch

Do not define or display counters for the DMA32 and the HIGHMEM zone
if such zones were not configured.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/vmstat.h	2006-07-04 09:24:16.598992964 -0700
+++ linux-2.6.17-mm6/include/linux/vmstat.h	2006-07-04 10:29:07.430918443 -0700
@@ -18,7 +18,19 @@
  * generated will simply be the increment of a global address.
  */
 
-#define FOR_ALL_ZONES(x) x##_DMA, x##_DMA32, x##_NORMAL, x##_HIGH
+#ifdef CONFIG_ZONE_DMA32
+#define DMA32_ZONE(xx) xx##_DMA32,
+#else
+#define DMA32_ZONE(xx)
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#define HIGHMEM_ZONE(xx) , xx##_HIGH
+#else
+#define HIGHMEM_ZONE(xx)
+#endif
+
+#define FOR_ALL_ZONES(xx) xx##_DMA, DMA32_ZONE(xx) xx##_NORMAL HIGHMEM_ZONE(xx)
 
 enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(PGALLOC),
Index: linux-2.6.17-mm6/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/vmstat.c	2006-07-03 13:47:22.663933375 -0700
+++ linux-2.6.17-mm6/mm/vmstat.c	2006-07-04 09:33:08.440126002 -0700
@@ -381,6 +381,21 @@ struct seq_operations fragmentation_op =
 	.show	= frag_show,
 };
 
+#ifdef CONFIG_ZONE_DMA32
+#define TEXT_FOR_DMA32(xx) xx "_dma32",
+#else
+#define TEXT_FOR_DMA32(xx)
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#define TEXT_FOR_HIGHMEM(xx) xx "_high",
+#else
+#define TEXT_FOR_HIGHMEM(xx)
+#endif
+
+#define TEXTS_FOR_ZONES(xx) xx "_dma", TEXT_FOR_DMA32(xx) xx "_normal", \
+					TEXT_FOR_HIGHMEM(xx)
+
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_anon_pages",
@@ -408,10 +423,7 @@ static char *vmstat_text[] = {
 	"pswpin",
 	"pswpout",
 
-	"pgalloc_dma",
-	"pgalloc_dma32",
-	"pgalloc_normal",
-	"pgalloc_high",
+	TEXTS_FOR_ZONES("pgalloc")
 
 	"pgfree",
 	"pgactivate",
@@ -420,25 +432,10 @@ static char *vmstat_text[] = {
 	"pgfault",
 	"pgmajfault",
 
-	"pgrefill_dma",
-	"pgrefill_dma32",
-	"pgrefill_normal",
-	"pgrefill_high",
-
-	"pgsteal_dma",
-	"pgsteal_dma32",
-	"pgsteal_normal",
-	"pgsteal_high",
-
-	"pgscan_kswapd_dma",
-	"pgscan_kswapd_dma32",
-	"pgscan_kswapd_normal",
-	"pgscan_kswapd_high",
-
-	"pgscan_direct_dma",
-	"pgscan_direct_dma32",
-	"pgscan_direct_normal",
-	"pgscan_direct_high",
+	TEXTS_FOR_ZONES("pgrefill")
+	TEXTS_FOR_ZONES("pgsteal")
+	TEXTS_FOR_ZONES("pgscan_kswapd")
+	TEXTS_FOR_ZONES("pgscan_direct")
 
 	"pginodesteal",
 	"slabs_scanned",
