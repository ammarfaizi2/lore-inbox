Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWGCV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWGCV4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWGCV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:56:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51602 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932135AbWGCV4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:56:01 -0400
Date: Mon, 3 Jul 2006 14:55:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060703215555.7566.80891.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 4/8] Remove display of counters for not available zones
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eventcounters: Do not display counters for zones that are not available on an arch

Remove the counter display for all zones that are not in use.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/vmstat.h	2006-07-03 13:58:32.623475826 -0700
+++ linux-2.6.17-mm6/include/linux/vmstat.h	2006-07-03 14:04:27.383794230 -0700
@@ -18,7 +18,17 @@
  * generated will simply be the increment of a global address.
  */
 
-#define FOR_ALL_ZONES(x) x##_DMA, x##_DMA32, x##_NORMAL, x##_HIGH
+#ifdef CONFIG_DMA32
+#define FOR_ALL_LOWER_ZONES(xx) xx##_DMA, xx##_DMA32, xx##_NORMAL
+#else
+#define FOR_ALL_LOWER_ZONES(xx) xx##_DMA, xx##_NORMAL
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#define FOR_ALL_ZONES(xx) FOR_ALL_LOWER_ZONES(xx), xx##_HIGH
+#else
+#define FOR_ALL_ZONES(xx) FOR_ALL_LOWER_ZONES(xx)
+#endif
 
 enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(PGALLOC),
Index: linux-2.6.17-mm6/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/vmstat.c	2006-07-03 13:47:22.663933375 -0700
+++ linux-2.6.17-mm6/mm/vmstat.c	2006-07-03 14:04:27.383794230 -0700
@@ -381,6 +381,18 @@ struct seq_operations fragmentation_op =
 	.show	= frag_show,
 };
 
+#ifdef CONFIG_ZONE_DMA32
+#define TEXTS_FOR_LOWER_ZONES(xx) xx "_dma", xx "_dma32", xx "_normal"
+#else
+#define TEXTS_FOR_LOWER_ZONES(xx) xx "_dma", xx "_normal"
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#define TEXTS_FOR_ZONES(xx) TEXTS_FOR_LOWER_ZONES(xx), xx "_high"
+#else
+#define TEXTS_FOR_ZONES(xx) TEXTS_FOR_LOWER_ZONES(xx)
+#endif
+
 static char *vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_anon_pages",
@@ -408,10 +420,7 @@ static char *vmstat_text[] = {
 	"pswpin",
 	"pswpout",
 
-	"pgalloc_dma",
-	"pgalloc_dma32",
-	"pgalloc_normal",
-	"pgalloc_high",
+	TEXTS_FOR_ZONES("pgalloc"),
 
 	"pgfree",
 	"pgactivate",
@@ -420,25 +429,10 @@ static char *vmstat_text[] = {
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
+	TEXTS_FOR_ZONES("pgrefill"),
+	TEXTS_FOR_ZONES("pgsteal"),
+	TEXTS_FOR_ZONES("pgscan_kswapd"),
+	TEXTS_FOR_ZONES("pgscan_direct"),
 
 	"pginodesteal",
 	"slabs_scanned",
