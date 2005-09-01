Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVIAJJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVIAJJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVIAJJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:09:17 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35004 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750747AbVIAJJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:09:16 -0400
Date: Thu, 1 Sep 2005 02:09:05 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       Dinakar Guniguntala <dino@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Simon Derr <Simon.Derr@bull.net>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-Id: <20050901090905.18441.86997.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2/4] cpusets new __GFP_HARDWALL flag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add another GFP flag: __GFP_HARDWALL.

A subsequent "cpuset_zone_allowed" patch will use this flag to mark
GFP_USER allocations, and distinguish them from GFP_KERNEL allocations.

Allocations (such as GFP_USER) marked GFP_HARDWALL are constrainted to
the current tasks cpuset.  Other allocations (such as GFP_KERNEL) can
steal from the possibly larger nearest mem_exclusive cpuset ancestor,
if memory is tight on every node in the current cpuset.

This patch collides with Mel Gorman's patch to reduce fragmentation
in the standard buddy allocator, which adds two GFP flags.  This was
discussed on linux-mm in July.  Most likely, one of his flags for
user reclaimable memory can be the same as my __GFP_HARDWALL flag,
under some generic name meaning its user address space memory.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6.13-mem_exclusive_oom/include/linux/gfp.h
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/include/linux/gfp.h
+++ linux-2.6.13-mem_exclusive_oom/include/linux/gfp.h
@@ -40,6 +40,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
 #define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
+#define __GFP_HARDWALL   0x40000u /* Enforce hardwall cpuset memory allocs */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
@@ -48,14 +49,15 @@ struct vm_area_struct;
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_NORECLAIM)
+			__GFP_NOMEMALLOC|__GFP_NORECLAIM|__GFP_HARDWALL)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
 #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
 #define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
+#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HARDWALL | \
+			 __GFP_HIGHMEM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
