Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274920AbTHPUco (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274923AbTHPUco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:32:44 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:39644 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id S274920AbTHPUcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:32:42 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Sat, 16 Aug 2003 14:32:10 -0600
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PowerPC consistent_free() didn't free physical, just virtual (fixed)
Message-ID: <20030816203210.GB23893@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

consistent_free() was only freeing the virtual addresses before.
This actually frees the virtual address and physical pages now.
The hacked "track" array allows us to keep track of the
address/order tuple so consistent_free() knows how large the area
was without passing it in (and changing the arity of the function).

I discovered this by using consistent_alloc() and consistent_free() several
times.  Eventually, there was no RAM was left and instead of returning an
error consistent_alloc() panics.


diff -Nru a/arch/ppc/mm/cachemap.c b/arch/ppc/mm/cachemap.c
--- a/arch/ppc/mm/cachemap.c	Sat Aug 16 14:31:27 2003
+++ b/arch/ppc/mm/cachemap.c	Sat Aug 16 14:31:27 2003
@@ -60,6 +60,18 @@
  * portions of the kernel with single large page TLB entries, and
  * still get unique uncached pages for consistent DMA.
  */
+
+/*
+ * consistent_free() was only freeing the virtual addresses before.
+ * This actually frees the virtual address and physical pages now.
+ * The hacked "track" array allows us to keep track of the
+ * address/order tuple so consistent_free() knows how large the area
+ * was without passing it in (and changing the arity of the function).
+ *   -- Cort <cort@fsmlabs.com>
+ */
+#define TRACK_SZ 100
+static unsigned long track[TRACK_SZ][3];
+
 void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
 {
 	int order, err, i;
@@ -125,6 +137,21 @@
 		return NULL;
 	}
 
+	{
+		int i;
+
+		for ( i = 0; i < TRACK_SZ ; i++ ) {
+			if ( track[i][0] == 0 ) {
+				break;
+			}
+		}
+		if ( i >= TRACK_SZ )
+			panic("ran out of space\n");
+		track[i][0] = ret;
+		track[i][1] = page;
+		track[i][2] = order;
+	}
+	
 	return ret;
 }
 
@@ -135,7 +162,26 @@
 {
 	if (in_interrupt())
 		BUG();
-	vfree(vaddr);
+	
+	{
+		int i;
+		
+		for ( i = 0; i < TRACK_SZ ; i++ ) {
+			if ( track[i][0] == vaddr ) {
+				break;
+			}
+		}
+		if ( i >= TRACK_SZ )
+			panic("couldn't find vaddr\n");
+
+		free_pages(track[i][1], track[i][2]);
+		
+		track[i][0] = 0;
+		track[i][1] = 0;
+		track[i][2] = 0;
+			
+	}
+
 }
 
 /*
