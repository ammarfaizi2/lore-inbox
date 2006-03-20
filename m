Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWCTIbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWCTIbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCTIbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:31:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44742 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932218AbWCTIbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:31:13 -0500
Date: Mon, 20 Mar 2006 00:30:52 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       ak@suse.de, haveblue@us.ibm.com, mingo@elte.hu, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: alloc_pages_node overrides cpuset constraints
Message-Id: <20060320003052.7ca3f261.pj@sgi.com>
In-Reply-To: <20060319230712.5b15ee3e.akpm@osdl.org>
References: <20060318204027.13217.34767.sendpatchset@sam.engr.sgi.com>
	<20060319230712.5b15ee3e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're kidding.  This adds more code to every page allocation on every
> machine, cpusets or not.
> 
> I stuck this on top:
> 
>  ...
> 
> But it's a bit ugly.


The code path we care about for this __GFP_NOCPUSET flag is for memory
migration.  When it says it wants memory allocated on a certain node,
it really wants it there.

While I consider it a bug in the cpuset implementation that any kernel
alloc_pages_node(), kmalloc_node() or vmalloc_node() call has the
requested node ignored if it falls outside the current tasks cpuset,
that's not a priority bug in my view.  It's been that way for a year
(since cpusets went in), and no one has noticed.

Christoph - I suspect that the following patch, instead of the one
we sent, would meet with greater approval from Andrew.

The patch below just adds the __GFP_NOCPUSET flag on the memory
migration code path, where we need it.  That code path is not
performance critical.

We can deal with the long standing bug in cpusets, where it overrides
all alloc_pages_node() calls, some other day.

What think you of this, Christoph?  Should we send it to Andrew?


 include/linux/gfp.h |    1 +
 kernel/cpuset.c     |    2 ++
 mm/migrate.c        |    5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

--- 2.6.16-rc6-mm2.orig/include/linux/gfp.h	2006-03-18 13:07:51.000000000 -0800
+++ 2.6.16-rc6-mm2/include/linux/gfp.h	2006-03-19 23:55:19.000000000 -0800
@@ -47,6 +47,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_NOCPUSET	((__force gfp_t)0x40000u)/* Ignore cpuset constraints */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
--- 2.6.16-rc6-mm2.orig/kernel/cpuset.c	2006-03-18 13:15:04.000000000 -0800
+++ 2.6.16-rc6-mm2/kernel/cpuset.c	2006-03-19 23:52:42.000000000 -0800
@@ -2209,6 +2209,8 @@ int __cpuset_zone_allowed(struct zone *z
 	node = z->zone_pgdat->node_id;
 	if (node_isset(node, current->mems_allowed))
 		return 1;
+	if (gfp_mask & __GFP_NOCPUSET)
+		return 1;
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
 		return 0;
 
--- 2.6.16-rc6-mm2.orig/mm/migrate.c	2006-03-18 13:12:53.000000000 -0800
+++ 2.6.16-rc6-mm2/mm/migrate.c	2006-03-20 00:24:36.000000000 -0800
@@ -614,12 +614,13 @@ redo:
 			 * a certain old page is moved to so we cannot
 			 * specify the correct address.
 			 */
-			page = alloc_page_vma(GFP_HIGHUSER, vma,
+			page = alloc_page_vma(GFP_HIGHUSER|__GFP_NOCPUSET, vma,
 					offset + vma->vm_start);
 			offset += PAGE_SIZE;
 		}
 		else
-			page = alloc_pages_node(dest, GFP_HIGHUSER, 0);
+			page = alloc_pages_node(dest,
+					GFP_HIGHUSER|__GFP_NOCPUSET, 0);
 
 		if (!page) {
 			err = -ENOMEM;


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
