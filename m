Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUFYPSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUFYPSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266759AbUFYPSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:18:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9112 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266758AbUFYPSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:18:50 -0400
Subject: Re: Merging Nonlinear and Numa style memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: shai@ftcon.com
Cc: "'Yasunori Goto'" <ygoto@us.fujitsu.com>,
       "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Linux Hotplug Memory Support'" <lhms-devel@lists.sourceforge.net>,
       "'Linux-Node-Hotplug'" <lhns-devel@lists.sourceforge.net>,
       "'linux-mm'" <linux-mm@kvack.org>,
       "'BRADLEY CHRISTIANSEN [imap]'" <bradc1@us.ibm.com>
In-Reply-To: <200406250449.BSB05018@ms6.netsolmail.com>
References: <200406250449.BSB05018@ms6.netsolmail.com>
Content-Type: text/plain
Message-Id: <1088141355.3918.1493.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 25 Jun 2004 08:16:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 21:49, Shai Fultheim wrote:
> > > Doesn't this just find the lowest-numbered node's highmem?  Are you sure
> > > that no NUMA systems have memory at lower physical addresses on
> > > higher-numbered nodes?  I'm not sure that this is true.
> 
> In addition I'm involved in a NUMA-related project that might have
> zone-normal on other nodes beside node0.  I also think that in some cases it
> might be useful to have the code above and below in case of AMD machines
> that have less than 1GB per processor (or at least less than 1GB on the
> FIRST processor).

But, this code is just for i386 processors.  Do you have a NUMA AMD i386
system?

> > > Again, I don't see what this loop is used for.  You appear to be trying
> > > to detect which nodes have lowmem.  Is there currently any x86 NUMA
> > > architecture that has lowmem on any node but node 0?
> 
> As noted above, this is possible, the cost of this code is not much, so I
> would keep it in.

OK, I'll revise and say that it's impossible for all of the in-tree NUMA
systems.  I'd heavily encourage you to post your code so that we can
more easily understand what kind of system you have.  It's very hard to
analyze impact on systems that we've never seen code for.

In any case, I believe that the original loop should be kept pretty
close to what is there now:

        for (tmp = 0; tmp < max_low_pfn; tmp++)
                /*
                 * Only count reserved RAM pages
                 */
                if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
                        reservedpages++;

If you do, indeed, have non-ram pages between pfns 0 and max_low_pfn,
I'd suggest doing something like this:

                if (page_is_ram(tmp) && 
		    node_online(page_to_nid(tmp)) &&
                    PageReserved(pfn_to_page(tmp)))
                        reservedpages++;

That's a lot cleaner and more likely to work than replacing the entire
loop with an ifdef.

-- Dave

