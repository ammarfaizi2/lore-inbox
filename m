Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTKRJmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 04:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTKRJmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 04:42:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262128AbTKRJmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 04:42:10 -0500
Date: Tue, 18 Nov 2003 09:42:07 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Bootmem broke ARM
Message-ID: <20031118094207.B28004@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20031116101535.A592@flint.arm.linux.org.uk> <20031116121131.0796cf01.akpm@osdl.org> <20031117180440.GA9711@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031117180440.GA9711@sgi.com>; from jbarnes@sgi.com on Mon, Nov 17, 2003 at 10:04:40AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 10:04:40AM -0800, Jesse Barnes wrote:
> On Sun, Nov 16, 2003 at 12:11:31PM -0800, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > With previous kernels, the nodes are added to the list in reverse order,
> > > so architecture code knew we had to add the highest PFN first and the
> > > lowest PFN node last.
> 
> You're right, I think the arch code should probably worry about this.
> 
> > It looks to be bogus on ia64 as well, for which the patch was written.
> 
> Yep, I think it is bogus.  There's only one caller on ia64 that would be
> affected--swiotlb_init(), and afaik multi-node systems won't be using
> that code (except maybe NEC?), so even if the pgdat list is out of order
> we should be ok.  If not I'll fix the ia64 discontig code.

Ok, I've received word from the original reporter on the ARM lists that
this patch does indeed solve their problem.

Linus - can this be merged for 2.6.0-test10 please, or do you consider
this too large a change?

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

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
