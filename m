Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTKQSFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTKQSFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:05:21 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23515 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263642AbTKQSFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:05:10 -0500
Date: Mon, 17 Nov 2003 10:04:40 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Bootmem broke ARM
Message-ID: <20031117180440.GA9711@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20031116101535.A592@flint.arm.linux.org.uk> <20031116121131.0796cf01.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116121131.0796cf01.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 12:11:31PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > With previous kernels, the nodes are added to the list in reverse order,
> > so architecture code knew we had to add the highest PFN first and the
> > lowest PFN node last.

You're right, I think the arch code should probably worry about this.

> It looks to be bogus on ia64 as well, for which the patch was written.

Yep, I think it is bogus.  There's only one caller on ia64 that would be
affected--swiotlb_init(), and afaik multi-node systems won't be using
that code (except maybe NEC?), so even if the pgdat list is out of order
we should be ok.  If not I'll fix the ia64 discontig code.

Thanks,
Jesse

===== mm/bootmem.c 1.22 vs edited =====
--- 1.22/mm/bootmem.c	Sun Sep 28 10:11:27 2003
+++ edited/mm/bootmem.c	Mon Nov 17 10:44:59 2003
@@ -48,24 +48,8 @@
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long mapsize = ((end - start)+7)/8;
 
-
-	/*
-	 * sort pgdat_list so that the lowest one comes first,
-	 * which makes alloc_bootmem_low_pages work as desired.
-	 */
-	if (!pgdat_list || pgdat_list->node_start_pfn > pgdat->node_start_pfn) {
-		pgdat->pgdat_next = pgdat_list;
-		pgdat_list = pgdat;
-	} else {
-		pg_data_t *tmp = pgdat_list;
-		while (tmp->pgdat_next) {
-			if (tmp->pgdat_next->node_start_pfn > pgdat->node_start_pfn)
-				break;
-			tmp = tmp->pgdat_next;
-		}
-		pgdat->pgdat_next = tmp->pgdat_next;
-		tmp->pgdat_next = pgdat;
-	}
+	pgdat->pgdat_next = pgdat_list;
+	pgdat_list = pgdat;
 
 	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
 	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
