Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVKABhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVKABhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVKABhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:37:09 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:9863 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932537AbVKABhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:37:00 -0500
Date: Tue, 1 Nov 2005 01:36:56 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <4366AFC7.3060505@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0511010128190.29390@skynet>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie><20051031055725.GA3820@w-mikek2.ibm.com><4365BBC4.2090906@yahoo.com.au><20051030235440.6938a0e9.akpm@osdl.org><27700000.1130769270@[10.10.2.4]>
 <20051031112409.153e7048.akpm@osdl.org> <3660000.1130787652@flay>
 <4366AFC7.3060505@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Nick Piggin wrote:

> Martin J. Bligh wrote:
> > --On Monday, October 31, 2005 11:24:09 -0800 Andrew Morton <akpm@osdl.org>
> > wrote:
>
> > > I suspect this would all be a non-issue if the net drivers were using
> > > __GFP_NOWARN ;)
> >
> >
> > We still need to allocate them, even if it's GFP_KERNEL. As memory gets
> > larger and larger, and we have no targetted reclaim, we'll have to blow
> > away more and more stuff at random before we happen to get contiguous
> > free areas. Just statistics aren't in your favour ... Getting 4 contig
> > pages on a 1GB desktop is much harder than on a 128MB machine.
>
> However, these allocations are not of the "easy to reclaim" type, in
> which case they just use the regular fragmented-to-shit areas. If no
> contiguous pages are available from there, then an easy-reclaim area
> needs to be stolen, right?
>

Right.

> In which case I don't see why these patches don't have similar long
> term failure cases if there is strong demand for higher order
> allocations. Prolong things a bit, perhaps, but...
>

It hinges all on how long the high order kernel allocation is. If it's
short-lived, it will get freed back to the easyrclm free lists and we
don't fragment. If it turns out to be long lived, then we are in trouble.
If this turns out to be the case, a possibility would be to use the
__GFP_KERNRCLM flag for high order, short lived allocations. This would
tend to group large free areas in the same place. It would only be worth
investigating if we found that memory still got fragmented over very long
periods of time.

> > Is not going to get better as time goes on ;-) Yeah, yeah, I know, you
> > want recreates, numbers, etc. Not the easiest thing to reproduce in a
> > short-term consistent manner though.
> >
>
> Regardless, I think we need to continue our steady move away from
> higher order allocation requirements.
>

No arguement with you there. My actual aim is to guarantee HugeTLB
allocations for userspace which we currently have to reserve at boot time.
Stuff like memory hotplug remove and high order kernel allocations are
benefits that would be nice to pick up on the way.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
