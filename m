Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTJWQXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 12:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJWQXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 12:23:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53126 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263592AbTJWQXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 12:23:11 -0400
Date: Thu, 23 Oct 2003 18:23:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031023162310.GQ6461@suse.de>
References: <20031013140858.GU1107@suse.de> <200310210146.35881.phillips@arcor.de> <20031021054044.GC1128@suse.de> <200310231822.36023.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310231822.36023.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23 2003, Daniel Phillips wrote:
> On Tuesday 21 October 2003 07:40, Jens Axboe wrote:
> > On Tue, Oct 21 2003, Daniel Phillips wrote:
> > > Maybe what you're saying is, there are only two ways to deal with IDE
> > > drives with non-disablable writeback cache:
> > >
> > >   1) flush the cache on every write
> > >   2) Implement write barriers, add them to all the journalling
> > > filesystems, and flush only on the write barrier
> > >
> > > and (1) is just too slow.  Correct?
> >
> > Yes, that is exactly what I'm saying. It's not just that, though.
> > Completely disabling write back caching on IDE drives totally kills
> > performance typically, they are just not meant to be driven this way.
> 
> OK, this is still experimental development in the middle of the stability 
> freeze in order to fix a performance bug, but that's a tradition anyway so 
> let me join in.

It's not a performance bug, fer crissakes!! Do you suggest disabling
write back cache on all ide drives? People will scream bloody murder if
we do. So it's a question of data integrity.

> I'm specifically interested in working out the issues related to stacked 
> virtual devices, and there are many.  Let me start with an easy one.
> 
> Consider a multipath virtual device that is doing load balancing and
> wants to handle write barriers efficiently, not just allow the
> downstream queues to drain before allowing new writes.  This device
> wants to send a write barrier to each of the downstream devices,
> however, we have only one write request to carry the barrier bit.  How
> do you recommend handling this situation?

That needs something to hold the state in, and a bio per device. As
they complete, mark them as such. When they all have completed, barrier
is done.

That's just an idea, I'm sure there are other ways. Depending on how
complex it gets, it might not be a bad idea to just let the queues drain
though. I think I'd prefer that approach.

-- 
Jens Axboe

