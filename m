Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425136AbWLHIA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425136AbWLHIA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425140AbWLHIA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 03:00:26 -0500
Received: from brick.kernel.dk ([62.242.22.158]:23596 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425136AbWLHIAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 03:00:25 -0500
Date: Fri, 8 Dec 2006 09:01:19 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Nate Diller <nate.diller@gmail.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up single bio_vec allocation
Message-ID: <20061208080118.GD23887@kernel.dk>
References: <5c49b0ed0612071346g5bccedd5q709e5ba66808c7fc@mail.gmail.com> <000201c71a4a$0fa32280$ff0da8c0@amr.corp.intel.com> <5c49b0ed0612071433o3a77be20h9b19326bf6a70281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c49b0ed0612071433o3a77be20h9b19326bf6a70281@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07 2006, Nate Diller wrote:
> On 12/7/06, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> >Nate Diller wrote on Thursday, December 07, 2006 1:46 PM
> >> the current code is straightforward and obviously correct.  you want
> >> to make the alloc/dealloc paths more complex, by special-casing for an
> >> arbitrary limit of "small" I/O, AFAICT.  of *course* you can expect
> >> less overhead when you're doing one large I/O vs. two small ones,
> >> that's the whole reason we have all this code to try to coalesce
> >> contiguous I/O, do readahead, swap page clustering, etc.  we *want*
> >> more complexity if it will get us bigger I/Os.  I don't see why we
> >> want more complexity to reduce the *inherent* penalty of doing smaller
> >> ones.
> >
> >You should check out the latest proposal from Jens Axboe which treats
> >all biovec size the same and stuff it along with struct bio.  I think
> >it is a better approach than my first cut of special casing 1 segment
> >biovec.  His patch will speed up all sized I/O.
> 
> i rather agree with his reservations on that, since we'd be making the
> allocator's job harder by requesting order 1 pages for all allocations
> on x86_64 large I/O patterns.  but it reduces complexity instead of
> increasing it ... can you produce some benchmarks not just for your
> workload but for one that triggers the order 1 case?  biovec-(256)
> transfers are more common than you seem to think, and if the allocator
> can't do it, that forces the bio code to fall back to 2 x biovec-128,
> which, as you indicated above, would show a real penalty.

The question is if the slab allocator is only doing 2^0 order
allocations for the 256-page bio_vec currently - it's at 4096 bytes, so
potentially (I suspect) the worst size it could be.

On the 1 vs many page bio_vec patterns, I agree with Nate. I do see lots
of larger bio_vecs here. > 1 page bio_vec usage is also becoming more
prevalent, not less. So optimizing for a benchmark case that
predominately uses 1 page bio's is indeed a silly thing.

-- 
Jens Axboe

