Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVCPFGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVCPFGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVCPFGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:06:47 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:25860
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262521AbVCPFGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:06:10 -0500
Date: Tue, 15 Mar 2005 21:05:38 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace zone padding with a definition in cache.h
In-Reply-To: <1110947099.24808.3.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.58.0503152105020.6087@server.graphe.net>
References: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
 <1110947099.24808.3.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, Nick Piggin wrote:

> >
> > +#ifndef ____cacheline_pad_in_smp
> > +#if defined(CONFIG_SMP)
> > +#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp
>                                              ^^^^^^^
>
> Doesn't this add a redundant cacheline if the padding is
> previously perfect? Because of the extra byte you're adding?
>
> IIRC, the char x[0]; trick does the job correctly.

Good idea.

This patch removes the zone padding hack and establishes definitions
in include/linux/cache.h to define the padding within struct zone.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.11/include/linux/cache.h
===================================================================
--- linux-2.6.11.orig/include/linux/cache.h	2005-03-08 18:40:15.000000000 -0800
+++ linux-2.6.11/include/linux/cache.h	2005-03-14 10:33:45.247701040 -0800
@@ -48,4 +48,12 @@
 #endif
 #endif

+#ifndef ____cacheline_pad_in_smp
+#if defined(CONFIG_SMP)
+#define ____cacheline_pad_in_smp struct { char  x[0]; } ____cacheline_maxaligned_in_smp
+#else
+#define ____cacheline_pad_in_smp
+#endif
+#endif
+
 #endif /* __LINUX_CACHE_H */
Index: linux-2.6.11/include/linux/mmzone.h
===================================================================
--- linux-2.6.11.orig/include/linux/mmzone.h	2005-03-14 10:33:01.037422024 -0800
+++ linux-2.6.11/include/linux/mmzone.h	2005-03-14 10:33:45.248700888 -0800
@@ -28,21 +28,6 @@ struct free_area {

 struct pglist_data;

-/*
- * zone->lock and zone->lru_lock are two of the hottest locks in the kernel.
- * So add a wild amount of padding here to ensure that they fall into separate
- * cachelines.  There are very few zone structures in the machine, so space
- * consumption is not a concern here.
- */
-#if defined(CONFIG_SMP)
-struct zone_padding {
-	char x[0];
-} ____cacheline_maxaligned_in_smp;
-#define ZONE_PADDING(name)	struct zone_padding name;
-#else
-#define ZONE_PADDING(name)
-#endif
-
 struct per_cpu_pages {
 	int count;		/* number of pages in the list */
 	int low;		/* low watermark, refill needed */
@@ -131,7 +116,14 @@ struct zone {
 	struct free_area	free_area[MAX_ORDER];


-	ZONE_PADDING(_pad1_)
+	/*
+	 * zone->lock and zone->lru_lock are two of the hottest locks in the kernel.
+	 * So add a wild amount of padding here to ensure that they fall into separate
+	 * cachelines.  There are very few zone structures in the machine, so space
+	 * consumption is not a concern here.
+	 */
+
+	____cacheline_pad_in_smp;

 	/* Fields commonly accessed by the page reclaim scanner */
 	spinlock_t		lru_lock;
@@ -164,7 +156,7 @@ struct zone {
 	int prev_priority;


-	ZONE_PADDING(_pad2_)
+	____cacheline_pad_in_smp;
 	/* Rarely used or read-mostly fields */

 	/*
