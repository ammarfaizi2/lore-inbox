Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262931AbTCKOdT>; Tue, 11 Mar 2003 09:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262933AbTCKOdT>; Tue, 11 Mar 2003 09:33:19 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:63445 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262931AbTCKOdS>;
	Tue, 11 Mar 2003 09:33:18 -0500
Date: Tue, 11 Mar 2003 16:59:23 -0500
From: Christoph Hellwig <hch@sgi.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: [PATCH] fix kmem_cache_size() for new slab poisoning
Message-ID: <20030311165923.A25018@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new slab poisoning code broke kmem_cache_size(), it now returns
a too large size as the poisoning area after the object is includes.
XFS's kmem_zone_zalloc thus overwrites exactly that area and triggers
the new checks everytime such an object is freed again.

I don't recommend using XFS on BK-current without this patch applied :)


--- 1.68/mm/slab.c	Sat Mar  8 23:50:36 2003
+++ edited/mm/slab.c	Tue Mar 11 15:15:44 2003
@@ -2041,11 +2041,16 @@
 
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
+	unsigned int objlen = cachep->objsize;
+
 #if DEBUG
 	if (cachep->flags & SLAB_RED_ZONE)
-		return (cachep->objsize - 2*BYTES_PER_WORD);
+		objlen -= 2*BYTES_PER_WORD;
+	if (cachep->flags & SLAB_STORE_USER)
+		objlen -= BYTES_PER_WORD;
 #endif
-	return cachep->objsize;
+
+	return objlen;
 }
 
 kmem_cache_t * kmem_find_general_cachep (size_t size, int gfpflags)
