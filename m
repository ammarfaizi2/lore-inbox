Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTEUJUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTEUJUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:20:54 -0400
Received: from zero.aec.at ([193.170.194.10]:37904 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261324AbTEUJUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:20:52 -0400
Date: Wed, 21 May 2003 11:33:43 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: pat support in the kernel
Message-ID: <20030521093343.GA2819@averell>
References: <20030520190017$773c@gated-at.bofh.it> <m38yt1igdh.fsf@averell.firstfloor.org> <20030520201855.GE1050@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520201855.GE1050@hygelac>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 10:18:55PM +0200, Terence Ripperda wrote:
> > For normal memory you would need to find a way to synchronize the
> > attributes in all mappers (e.g. setting a flag in struct page or
> > similar).
> 
> are you refering to generic memory that might have shared mappings between multiple processes? I had really only thought of memory explicitly allocated by a driver and mapped to a process, in which this wouldn't be an issue (or is an issue isolated to the specific driver).

Yes.

> 
> it seems it would be easy enough to add a flag to struct page indicating that any future mappings of this memory must be marked with the given attribute. But you'd need to also worry about previous mappings of that page. wouldn't that require a fairly exhaustive scan of who has the physical memory mapped?

Not in 2.5 - it has the new RMAP vm with backlinks from struct page to ptes.
I already used that in a new machine check handler that has similar requirements.

> 
> would it make sense to limit this functionality to memory mmapped with MAP_PRIVATE rather than MAP_SHARED?

That would be a bit ugly, but possible if there is no better way.

> 
> what if process 1 mapped a region WC, forcing process 2 to later map it the same way even though process 2 doesn't care. then process 1 exits and process 3 decides to map the memory. does the caching attribute remain sticky with process 2 (causing process 3 to also need the memory WC), or revert to cached/whatever when the requestor's mapping is removed?

You have to walk the rmap chains and change the ptes, or return -EINVAL.

(e.g. you could define the API that only transition from writeback to other mappings
is allowed or reversal) 

The locking of this is a bit tricky however.

> 
> what if 2 processes ask for conflicting mappings? process 1 wants the framebuffer mapped WC, but process 2 asks for it cacheable. or process 1 maps 1/2 of the framebuffer WC and process 2 asks for the full framebuffer uncached.

One of them has to lose. Or use the EINVAL method above.

> 
> a lot of these are corner cases that are unlikely to be desirable, but probably should be protected against.

Yes, definitely.

> > For frame buffer you also need to handle it in all mmap'ers
> > (like fbcon or /dev/mem). I think handling these generic cases will
> > need a few VM changes.
> 
> yes, this was the case I was more worried about, but it looks like the case above will have the same issues.

The problem is that the frame buffer and the agp aperture normally have no struct page,
so you need to find a different way to store the shared state for them (e.g. a new
rbtree)

> 
> I don't think there's any way currently to determine if anyone already has a mapping to a given address range. And it seems that scanning for pre-existing mappings would be pretty ugly. are there any other suggestions for how to handle this?

In 2.4 there isn't, unless you run a RMAP kernel.

In 2.5 it's easy.

-Andi
