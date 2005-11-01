Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVKAPXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVKAPXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVKAPXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:23:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:64924 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750860AbVKAPXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:23:17 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Dave Hansen <haveblue@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mel Gorman <mel@csn.ul.ie>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051101150142.GA10636@elte.hu>
References: <4366A8D1.7020507@yahoo.com.au>
	 <Pine.LNX.4.58.0510312333240.29390@skynet> <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>
	 <1130856555.14475.77.camel@localhost>  <20051101150142.GA10636@elte.hu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:22:59 +0100
Message-Id: <1130858580.14475.98.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 16:01 +0100, Ingo Molnar wrote:
> so it's all about expectations: _could_ you reasonably remove a piece of 
> RAM? Customer will say: "I have stopped all nonessential services, and 
> free RAM is at 90%, still I cannot remove that piece of faulty RAM, fix 
> the kernel!".

That's an excellent example.  Until we have some kind of kernel
remapping, breaking the 1:1 kernel virtual mapping, these pages will
always exist.  The easiest example of this kind of memory is kernel
text.

Another example might be a somewhat errant device driver which has
allocates some large buffers and is doing DMA to or from them.  In this
case, we need to have APIs to require devices to give up and reacquire
any dynamically allocated structures.  If the device driver does not
implement these APIs it is not compatible with memory hotplug.

> > There is also no precedent in existing UNIXes for a 100% solution.
> 
> does this have any relevance to the point, other than to prove that it's 
> a hard problem that we should not pretend to be able to solve, without 
> seeing a clear path towards a solution?

Agreed.  It is a hard problem.  One that some other UNIXes have not
fully solved.

Here are the steps that I think we need to take.  Do you see any holes
in their coverage?  Anything that seems infeasible?

1. Fragmentation avoidance
   * by itself, increases likelyhood of having an area of memory
     which might be easily removed
   * very small (if any) performance overhead
   * other potential in-kernel users
   * creates infrastructure to enforce the "hotplugablity" of any
     particular are of memory.
2. Driver APIs
   * Require that drivers specifically request for areas which must
     retain constant physical addresses
   * Driver must relinquish control of such areas upon request
   * Can be worked around by hypervisors
3. Break 1:1 Kernel Virtual/Physial Mapping 
   * In any large area of physical memory we wish to remove, there will
     likely be very, very few straggler pages, which can not easily be
     freed.
   * Kernel will transparently move the contents of these physical pages
     to new pages, keeping constant virtual addresses.
   * Negative TLB overhead, as in-kernel large page mappings are broken
     down into smaller pages.
   * __{p,v}a() become more expensive, likely a table lookup

I've already done (3) on a limited basis, in the early days of memory
hotplug.  Not the remapping, just breaking the 1:1 assumptions.  It
wasn't too horribly painful.

We'll also need to make some decisions along the way about what to do
about thinks like large pages.  Is it better to just punt like AIX and
refuse to remove their areas?  Break them down into small pages and
degrade performance?

-- Dave

