Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUDCPU2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 10:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDCPU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 10:20:27 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3762
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261784AbUDCPUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 10:20:25 -0500
Date: Sat, 3 Apr 2004 17:20:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040403152026.GE2307@dualathlon.random>
References: <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403094058.A13091@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 09:40:58AM +0100, Christoph Hellwig wrote:
> On Fri, Apr 02, 2004 at 10:35:14PM +0200, Andrea Arcangeli wrote:
> > how can that be the second one? (I deduced it was the first one because
> > it cannot be the second one and the offset didn't look at the very end
> > of the function). This is the second one:
> > 
> > 		if (!PageCompound(p))
> > 			bad_page(__FUNCTION__, p);
> > 
> > but bad_page shows p->flags == 0x00080008 and 1<<PG_compound ==
> > 0x80000.
> > 
> > So PG_compound is definitely set for "p" and it can't be the second one
> > triggering.
> > 
> > Can you double check? Maybe we should double check the asm. Something
> > sounds fundamentally wrong in the asm, sounds like a miscompilation,
> > which compiler are you using?
> 
> Because I didn't trust my ppc assembly reading that much I put in a printk
> and it's actually the third bad_page(), sorry.

ok no problem, so page->private got screwed. I cannot see what could
change page->private though. I should also have noticed myself that
page->private was wrong: 0xc07721ff is not a 4byte aligned address, that
explains the weird page count too, since page_count follows
page->private to return the page->count of the master page.

I've no idea what could set page->private to such a weird address. the
"p" page is at address c0772380, that seems sane, the page->flags and
page->mapping as well are sane (p->count cannot be seen, what we see is
p->private->count), only page->private is screwed apparently.

if you want you can give a spin to this patch. As far as the old code
worked (i.e. with hugetlbfs=n) this should work too, since it disables
the compound feature completely, but if it works it probably only hides
the real bug. You can use rc3-aa3 for this (it already has the latest
robustness fixes I posted to you)

--- x/mm/page_alloc.c.~1~	2004-04-02 20:37:14.000000000 +0200
+++ x/mm/page_alloc.c	2004-04-03 17:15:52.647449336 +0200
@@ -563,7 +563,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	cold = 0;
 	if (gfp_mask & __GFP_COLD)
 		cold = __GFP_COLD;
+#if 0
 	if (gfp_mask & __GFP_NO_COMP)
+#endif
 		cold |= __GFP_NO_COMP;
 
 	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
