Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVCJObQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVCJObQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 09:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVCJObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 09:31:16 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:24704 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262633AbVCJObL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 09:31:11 -0500
Date: Thu, 10 Mar 2005 14:31:09 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9)
 + prezeroing (Version 4)
In-Reply-To: <1110239966.6446.66.camel@localhost>
Message-ID: <Pine.LNX.4.58.0503101421260.2105@skynet>
References: <20050307193938.0935EE594@skynet.csn.ul.ie> <1110239966.6446.66.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005, Dave Hansen wrote:

> On Mon, 2005-03-07 at 19:39 +0000, Mel Gorman wrote:
> > The placement policy patch should now be more Hotplug-friendly and I
> > would like to hear from the Hotplug people if they have more
> > requirements of this patch.
>
> It looks like most of what we need is there already.  There are two
> things that come to mind.  We'll likely need some modifications that
> will deal with committing memory areas that are larger than MAX_ORDER to
> the different allocation pools.  That's because a hotplug area (memory
> section) might be larger than a single MAX_ORDER area, and each section
> may need to be limited to a single allocation type.
>

As you say later, stuff like that can be easily grafted on by fiddling
with the bitmap, just with more than one block of MAX_ORDER pages.

> The other thing is that we'll probably have to be a lot more strict
> about how the allocations fall back.  Some users will probably prefer to
> kill an application rather than let a kernel allocation fall back into a
> user memory area.
>

That will be a tad trickier because we'll need a way of specifying a
"fallback policy" at configure time. However, the fallback policy is
currently isolated within one while loop, having different fallback
policies is doable. The kicker is that that there might be nasty
interaction with the page reclaim code where the allocator is not falling
back due to policy but the reclaim code things everything is just fine.

> BTW, I wrote some requirements about how these section divisions might
> be dealt with.  Note that this is a completely hotplug-centric view of
> the whole problem, I didn't discern between reclaimable and
> unreclaimable kernel memory as your patch does.  This is probably waaaay
> more than you wanted to hear, but I thought I'd share anyway. :)
>

No, better to hear about it now so I have something to chew over :)

> > There are 2 kinds of sections: user and kernel.  The traditional
> > ZONE_HIGHMEM is full of user sections (except for vmalloc).

And PTEs if configured to be allocated from high memory. I have not double
checked but I don't think they can be trivially reclaimed.

> > Any
> > section which has slab pages or any kernel caller to alloc_pages() is
> > a kernel section.
> >

Slab pages could be moved to the user section as long as the cache owner
was able to reclaim the slabs on demand.

> > Some properties of these sections:
> > a. User sections are easily removed.
> > b. Kernel sections are hard to remove. (considered impossible)
> > c. User sections may *NOT* be used for kernel pages if all user
> >    sections are full. (but, see f.)
> > d. Kernel sections may be used for user pages if all user sections are
> >    full.
> > e. A transition from a kernel section to a user section is hard, and
> >    requires that it be empty of all kernel users.
> > f. A transition from a user section to a kernel section is easy.
> >    (although easy, this should be avoided because it's hard to turn it
> >    _back_ into a user section)
>

All of these requirements are similar (just not as strict) as those for
fragmentation so common ground should continue to exist.

-- 
Mel Gorman
Part-time Phd Student				Java Applications Developer
University of Limerick				    IBM Dublin Software Lab
