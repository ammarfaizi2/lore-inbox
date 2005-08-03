Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVHCUJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVHCUJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVHCUJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:09:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262441AbVHCUIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:08:10 -0400
Date: Wed, 3 Aug 2005 22:08:08 +0200
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Cc: Andi Kleen <ak@suse.de>, Martin Hicks <mort@sgi.com>,
       Ingo Molnar <mingo@elte.hu>, Linux MM <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050803200808.GE8266@wotan.suse.de>
References: <20050801113913.GA7000@elte.hu> <20050803142440.GQ26803@localhost> <20050803143855.GA10895@wotan.suse.de> <200508031459.22834.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031459.22834.raybry@mpdtxmail.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 02:59:22PM -0500, Ray Bryant wrote:
> On Wednesday 03 August 2005 09:38, Andi Kleen wrote:
> > On Wed, Aug 03, 2005 at 10:24:40AM -0400, Martin Hicks wrote:
> > > On Wed, Aug 03, 2005 at 04:15:29PM +0200, Andi Kleen wrote:
> > > > On Wed, Aug 03, 2005 at 09:56:46AM -0400, Martin Hicks wrote:
> > > > > Here's the promised sysctl to dump a node's pagecache.  Please
> > > > > review!
> > > > >
> > > > > This patch depends on the zone reclaim atomic ops cleanup:
> > > > > http://marc.theaimsgroup.com/?l=linux-mm&m=112307646306476&w=2
> > > >
> > > > Doesn't numactl --bind=node memhog nodesize-someslack do the same?
> > > >
> > > > It just might kick in the oom killer if someslack is too small
> > > > or someone has unfreeable data there. But then there should be
> > > > already an sysctl to turn that one off.
> > >
> Hmmm.... What happens if there are already mapped pages (e. g. mapped in the 
> sense that pages are mapped into an address space) on the node and you want 
> to allocate some more, but can't because the node is full of clean page cache 
> pages?   Then one would have to set the memhog argument to the right thing to 

If you have a bind policy in the memory grabbing program then the standard try_to_free_pages
should DTRT. That is because we generated a custom zone list only containing nodes
in that zone and the zone reclaim only looks into those.

With prefered or other policies it's different though, in that cases t_t_f_p
will also look into other nodes because the policy is not binding.

That said it might be probably possible to even make non bind policies more
aggressive at freeing in the current node before looking into other nodes. 
I think the zone balancing has been mostly tuned on non NUMA systems, so
some improvements might be possible here.

Most people don't use BIND and changing the default policies like this 
might give NUMA systems a better "out of the box" experience.  However this 
memory balance is very subtle code and easy to break, so this would need some
care.

I don't think sysctls or new syscalls are the way to go here though.

-Andi
