Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTKGWd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTKGW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:27:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:15062 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264364AbTKGV7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 16:59:38 -0500
Date: Fri, 7 Nov 2003 13:58:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use NODES_SHIFT to calculate ZONE_SHIFT
Message-Id: <20031107135806.3c929688.akpm@osdl.org>
In-Reply-To: <20031105211608.GA23560@sgi.com>
References: <20031105211608.GA23560@sgi.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Now that we have a proper NODES_SHIFT value, we need to use it to define
> ZONE_SHIFT otherwise we'll spill over 8 bits if we have more than 85
> nodes.  How does this look?  The '+2' should really be
> log2(MAX_NR_NODES), but I think this is an improvement over what was
> there.

You mean log2(MAX_NR_ZONES).

How about we do it this way, so at least the duplicated information is on
adjacent lines, and they are unlikely to get out of sync?


 
diff -puN include/linux/mm.h~ZONE_SHIFT-from-NODES_SHIFT include/linux/mm.h
--- 25/include/linux/mm.h~ZONE_SHIFT-from-NODES_SHIFT	Fri Nov  7 13:51:22 2003
+++ 25-akpm/include/linux/mm.h	Fri Nov  7 13:55:11 2003
@@ -322,8 +322,10 @@ static inline void put_page(struct page 
 /*
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
+ * We'll have up to log2(MAX_NUMNODES * MAX_NR_ZONES) zones
+ * total, so we use NODES_SHIFT here to get enough bits.
  */
-#define ZONE_SHIFT (BITS_PER_LONG - 8)
+#define ZONE_SHIFT (BITS_PER_LONG - NODES_SHIFT - MAX_NR_ZONES_SHIFT)
 
 struct zone;
 extern struct zone *zone_table[];
diff -puN include/linux/mmzone.h~ZONE_SHIFT-from-NODES_SHIFT include/linux/mmzone.h
--- 25/include/linux/mmzone.h~ZONE_SHIFT-from-NODES_SHIFT	Fri Nov  7 13:51:49 2003
+++ 25-akpm/include/linux/mmzone.h	Fri Nov  7 13:57:19 2003
@@ -159,7 +159,10 @@ struct zone {
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1
 #define ZONE_HIGHMEM		2
-#define MAX_NR_ZONES		3
+
+#define MAX_NR_ZONES		3	/* Sync this with MAX_NR_ZONES_SHIFT */
+#define MAX_NR_ZONES_SHIFT	2	/* ceil(log2(MAX_NR_ZONES)) */
+
 #define GFP_ZONEMASK	0x03
 
 /*

_

