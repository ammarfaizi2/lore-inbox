Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWEEOuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWEEOuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWEEOuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:50:22 -0400
Received: from ccerelrim04.cce.hp.com ([161.114.21.25]:27283 "EHLO
	ccerelrim04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751132AbWEEOuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:50:21 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Fri, 5 May 2006 10:50:18 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Bob Picco <bob.picco@hp.com>, Andy Whitcroft <apw@shadowen.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060505145018.GI19859@localhost>
References: <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu> <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org> <20060505135503.GA5708@localhost> <1146839590.22503.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146839590.22503.48.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-PMX-Version: 5.1.2.240295, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.5.5.72607
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:	[Fri May 05 2006, 10:33:10AM EDT]
> On Fri, 2006-05-05 at 09:55 -0400, Bob Picco wrote:
> > -               if (!page_is_buddy(buddy, order))
> > +               if (page_in_zone_hole(buddy))
> > +                       break;
> > +               else if (page_zonenum(buddy) != page_zonenum(page))
> > +                       break;
> > +               else if (!page_is_buddy(buddy, order))
> >                         break;          /* Move the buddy up one level. */ 
> 
> The page_zonenum() checks look good, but I'm not sure I understand the
> page_in_zone_hole() part.  If a page is in a hole in a zone, it will
> still have a valid mem_map entry, right?  It should also never have been
> put into the allocator, so it also won't ever be coalesced.  
This has always been subtle and not too revealing.  It probably should
have a comment. The page_in_zone_hole check is for ia64 
VIRTUAL_MEM_MAP. You might compute a page structure which is in a hole not 
backed by memory; an unallocated page which covers pages structures. 
VIRTUAL_MEM_MAP uses a contiguous virtual region with virtual space holes
not backed by memory. Take a look at ia64_pfn_valid.
> 
> I'm a bit confused. :(
> 
> BTW, I like the idea of just aligning HIGHMEM's start because it has no
> runtime cost.  Buuuuut, it is still just a shift and compare of the two
> page->flags, which should already be (or will soon anyway be) in the
> cache.
Yes. I'll defer to Andy whether he wants the zonenum check or to align
HIGHMEM corrrectly.
> 
> -- Dave
> 
bob
