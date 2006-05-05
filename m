Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWEEO6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWEEO6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWEEO6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:58:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:51357 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751137AbWEEO6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:58:52 -0400
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
From: Dave Hansen <haveblue@us.ibm.com>
To: Bob Picco <bob.picco@hp.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20060505145018.GI19859@localhost>
References: <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au>
	 <20060504013239.GG19859@localhost>
	 <1146756066.22503.17.camel@localhost.localdomain>
	 <20060504154652.GA4530@localhost> <20060504192528.GA26759@elte.hu>
	 <20060504194334.GH19859@localhost> <445A7725.8030401@shadowen.org>
	 <20060505135503.GA5708@localhost>
	 <1146839590.22503.48.camel@localhost.localdomain>
	 <20060505145018.GI19859@localhost>
Content-Type: text/plain
Date: Fri, 05 May 2006 07:57:44 -0700
Message-Id: <1146841064.22503.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-05 at 10:50 -0400, Bob Picco wrote:
> Dave Hansen wrote:	[Fri May 05 2006, 10:33:10AM EDT]
> > The page_zonenum() checks look good, but I'm not sure I understand the
> > page_in_zone_hole() part.  If a page is in a hole in a zone, it will
> > still have a valid mem_map entry, right?  It should also never have been
> > put into the allocator, so it also won't ever be coalesced.  
> This has always been subtle and not too revealing.  It probably should
> have a comment. The page_in_zone_hole check is for ia64 
> VIRTUAL_MEM_MAP. You might compute a page structure which is in a hole not 
> backed by memory; an unallocated page which covers pages structures. 
> VIRTUAL_MEM_MAP uses a contiguous virtual region with virtual space holes
> not backed by memory. Take a look at ia64_pfn_valid.

Ahhh.  I hadn't made the ia64 connection.  I wonder if it is worth
making CONFIG_HOLES_IN_ZONE say ia64 or something about vmem_map in it
somewhere.  Might be worth at least a comment like this:

+               if (page_in_zone_hole(buddy)) /* noop on all but ia64 */
+                       break;
+               else if (page_zonenum(buddy) != page_zonenum(page))
+                       break;
+               else if (!page_is_buddy(buddy, order))
                        break;          /* Move the buddy up one level. */

BTW, wasn't the whole idea of discontig to have holes in zones (before
NUMA) without tricks like this? ;)

-- Dave

