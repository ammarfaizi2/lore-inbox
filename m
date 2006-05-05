Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWEEQSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWEEQSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWEEQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:18:34 -0400
Received: from mailhub.hp.com ([192.151.27.10]:21219 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1751631AbWEEQSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:18:33 -0400
From: "Bob Picco" <bob.picco@hp.com>
Date: Fri, 5 May 2006 12:18:31 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Bob Picco <bob.picco@hp.com>, Andy Whitcroft <apw@shadowen.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060505161831.GB5708@localhost>
References: <20060504013239.GG19859@localhost> <1146756066.22503.17.camel@localhost.localdomain> <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu> <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org> <20060505135503.GA5708@localhost> <1146839590.22503.48.camel@localhost.localdomain> <20060505145018.GI19859@localhost> <1146841064.22503.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146841064.22503.53.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:	[Fri May 05 2006, 10:57:44AM EDT]
> On Fri, 2006-05-05 at 10:50 -0400, Bob Picco wrote:
> > Dave Hansen wrote:	[Fri May 05 2006, 10:33:10AM EDT]
> > > The page_zonenum() checks look good, but I'm not sure I understand the
> > > page_in_zone_hole() part.  If a page is in a hole in a zone, it will
> > > still have a valid mem_map entry, right?  It should also never have been
> > > put into the allocator, so it also won't ever be coalesced.  
> > This has always been subtle and not too revealing.  It probably should
> > have a comment. The page_in_zone_hole check is for ia64 
> > VIRTUAL_MEM_MAP. You might compute a page structure which is in a hole not 
> > backed by memory; an unallocated page which covers pages structures. 
> > VIRTUAL_MEM_MAP uses a contiguous virtual region with virtual space holes
> > not backed by memory. Take a look at ia64_pfn_valid.
> 
> Ahhh.  I hadn't made the ia64 connection.  I wonder if it is worth
> making CONFIG_HOLES_IN_ZONE say ia64 or something about vmem_map in it
> somewhere.  Might be worth at least a comment like this:
> 
> +               if (page_in_zone_hole(buddy)) /* noop on all but ia64 */
> +                       break;
> +               else if (page_zonenum(buddy) != page_zonenum(page))
> +                       break;
> +               else if (!page_is_buddy(buddy, order))
>                         break;          /* Move the buddy up one level. */
> 
> BTW, wasn't the whole idea of discontig to have holes in zones (before
> NUMA) without tricks like this? ;)
Sure you could boot ia64 with just DISCONTIGMEM and no VIRTUAL_MEM_MAP.
In fact that's exactly what I did to test code added in alloc_node_mem_map.
Unfortunately I was missing 1Gb from free memory after booting. The
missing 1Gb was consumed by reserved pages structures :)
> 
> -- Dave
> 
bob
