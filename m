Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVBAVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVBAVGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 16:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVBAVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 16:06:48 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:10168 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262117AbVBAVGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 16:06:45 -0500
Date: Tue, 1 Feb 2005 21:06:43 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Helping prezoring with reduced fragmentation allocation
In-Reply-To: <Pine.LNX.4.58.0502011110560.3436@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0502011929020.16992@skynet>
References: <20050201171641.CC15EE5E8@skynet.csn.ul.ie>
 <Pine.LNX.4.58.0502011110560.3436@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Christoph Lameter wrote:

> On Tue, 1 Feb 2005, Mel Gorman wrote:
>
> > This is a patch that makes a step towards tieing the modified allocator
> > for reducing fragmentation with the prezeroing of pages that is based
> > on a discussion with Christoph. When a block has to be split to satisfy a
> > zero-page, both buddies are zero'd, one is allocated and the other is placed
> > on the free-list for the USERZERO pool. Care is taken to make sure the pools
> > are not accidently fragmented.
>
> Thanks for integrating the page zero stuff. If you are zeroing pages
> before their are fragmented then we may not need scrubd anymore. On the
> other hand, larger than necessary zeroing may be performaned in the hot
> code paths which may result in sporadically longer delays during
> allocation (well but then the page_allocator can generate these delays for
> a number of reasons).
>

I am not sure it eliminates the need for scrubd just yet. I will only zero
out more pages than necessary when a block of pages is being split but
once the zeroing has taken place, I will not need to zero again until all
the zerod pages are used. So even if the system was doing nothing else, my
patch will not bother zeroing out anything.

Right now, this patch is expensive because there is no cheap mechanism in
place that makes zering large groups of pages worth it (all
prep_zero_page() is doing is iterating and zeroing one at a time). For
this patch to make the most sense, your mechanism for quickly zeroing
large blocks of pages needs to be place.

> > I would expect that a scrubber daemon would go through the KERNNORCLM pool,
> > remove pages, scrub them and move them to USERZERO. It is important that pages
> > not be moved from the USERRCLM or KERNRCLM pools as it'll cause fragmentation
> > problems over time.
>
> Would it not be better to zero the global 2^MAX_ORDER pages by the scrub
> daemon and have a global zeroed page list? That way you may avoid zeroing
> when splitting pages?
>

Maybe, but right now when there are no 2^MAX_ORDER pages, the scrub daemon
is going to be doing nothing which is why I think it needs to look at the
free pages of lower orders.

That is solveable though in one of two ways. One, the scrub daemon can
zero pages from the global list and then add them to the USERZERO pool. It
has the advantage of requiring no more memory and is simple. The second is
to create a second global list. However, I think it only makes sense to
have this as part of the scrub daemon patch (I can write it if thats a
problem) rather than a standalone patch from me.

-- 
Mel Gorman
