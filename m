Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTJOFkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 01:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTJOFkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 01:40:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:2944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262152AbTJOFkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 01:40:19 -0400
Date: Tue, 14 Oct 2003 22:43:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
Message-Id: <20031014224352.0171e971.akpm@osdl.org>
In-Reply-To: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> I noticed that shrink_caches calls shrink_dcache_memory independant
>   of the classzone that is being shrunk.  So if we are trying to
>   shrink ZONE_HIGHMEM, the dentry_cache is shrunk, even though the
>   dentry_cache doesn't live in highmem.  However I'm not sure if I have
>   understood the classzones well enough for that observation even to
>   make sense.

Makes heaps of sense.  Here's an instabackport of what we did in 2.6:

 mm/vmscan.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~a mm/vmscan.c
--- 24/mm/vmscan.c~a	2003-10-14 22:41:34.000000000 -0700
+++ 24-akpm/mm/vmscan.c	2003-10-14 22:42:22.000000000 -0700
@@ -640,11 +640,17 @@ int try_to_free_pages_zone(zone_t *class
 			nr_pages = shrink_caches(classzone, gfp_mask, nr_pages, &failed_swapout);
 			if (nr_pages <= 0)
 				return 1;
-			shrink_dcache_memory(vm_vfs_scan_ratio, gfp_mask);
-			shrink_icache_memory(vm_vfs_scan_ratio, gfp_mask);
+			if (classzone - classzone->zone_pgdat->node_zones <
+						ZONE_HIGHMEM) {
+				shrink_dcache_memory(vm_vfs_scan_ratio,
+							gfp_mask);
+				shrink_icache_memory(vm_vfs_scan_ratio,
+							gfp_mask);
 #ifdef CONFIG_QUOTA
-			shrink_dqcache_memory(vm_vfs_scan_ratio, gfp_mask);
+				shrink_dqcache_memory(vm_vfs_scan_ratio,
+							gfp_mask);
 #endif
+			}
 			if (!failed_swapout)
 				failed_swapout = !swap_out(classzone);
 		} while (--tries);

_

