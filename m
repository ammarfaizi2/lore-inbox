Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933801AbWKTAQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801AbWKTAQn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933802AbWKTAQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:16:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29133 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S933801AbWKTAQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:16:42 -0500
Date: Mon, 20 Nov 2006 11:15:40 +1100
From: David Chinner <dgc@sgi.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH -mm 0/2] Use freezeable workqueues to avoid suspend-related XFS corruptions
Message-ID: <20061120001540.GX11034@melbourne.sgi.com>
References: <200611160912.51226.rjw@sisk.pl> <20061117005052.GK11034@melbourne.sgi.com> <200611171719.31389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611171719.31389.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 05:19:30PM +0100, Rafael J. Wysocki wrote:
> On Friday, 17 November 2006 01:50, David Chinner wrote:
> > On Thu, Nov 16, 2006 at 09:12:49AM +0100, Rafael J. Wysocki wrote:
 > > Hi,
> > > 
> > > The following two patches introduce a mechanism that should allow us to
> > > avoid suspend-related corruptions of XFS without the freezing of bdevs which
> > > Pavel considers as too invasive (apart from this, the freezing of bdevs may
> > > lead to some undesirable interactions with dm and for now it seems to be
> > > supported for real by XFS only).
> > 
> > Has this been tested and proven to fix the problem with XFS? It's
> > been asserted that this will fix XFS and suspend, but it's
> > not yet been proven that this is even the problem.
> 
> The worker threads of the XFS work queues need not run after all of the other
> tasks have been frozen.  In particular, they need not run after the suspend
> image has been created, so making them freeze is reasonsble anyway.

Right, but that doesn't mean that this was the problem being seen.

> [BTW, I'm going to do the same with all of the worker threads in the system
> that need not run during the suspend.]

So you're planning on changing the current default workqueue
implementation rather than needing special freezable workqueues?

> The question remains whether it's _sufficient_ to freeze these worker threads
> and my opinion is that yes, it should be sufficient.

I still don't see how doing this for XFS changes anything at all....

> > I think the problem is a race between sys_sync, the kernel thread
> > freeze and the xfsbufd flushing async, delayed write metadata
> > buffers resulting in a inconsistent suspend image being created.
> > If this is the case, then freezing the workqueues does not
> > fix the problem. i.e:
> > 
> > suspend				xfs
> > -------				---
> > sys_sync completes
> > 				xfsbufd flushes delwri metadata
> > kernel thread freeze
> > workqueue freeze
> 
> freeze device
> disable IRQs
> freeze system devices (including APICs etc.)
> 
> > suspend image start
> > 				async I/O starts to complete
> 
> Now please tell me how this is possible?

Right, that is not possible, but....

> > suspend image finishes
> > 				async I/O all complete

... it seems this is.

> > The problem here is the memory image has an empty delayed write
> > metadata buffer queue, but the I/O completion queue will be missing
> > some (or all) of the I/O that was issued, and so on resume we have
> > a memory image that still thinks the I/Os are progress but they
> > are not queued anywhere for completion processing.
> 
> Everything that was in memory before the suspend image has been created
> will also be there right after the resume, because the only thing that can
> access memory while the image is being created is the suspend thread.
> 
> I think the only problem that _may_ happen (without the patch) is this:
> 
> suspend				xfs
> -------				----
> suspend image start
> suspend image finishes
> thaw system devices
> enable IRQs
> thaw devices
> 				xfsbufd flushes delwri metadata
>  				async I/O starts to complete
> save image
>
> Now, after a successful resume xfsbufd will attempt to flush the metadata
> _once_ _again_, because it doesn't know of what has happend after
> creating the image.

The question about the scenario you propose above is how does
xfsbufd run at that point in time if kernel threads were frozen
before the system image was taken?  However, that is irrelevant
because the XFS image, as you state, would be consistent in memory
in the suspend image because you didn't trip over the sys_sync/
xfsbufd/kernel thread freeze race that takes the filesystem
out of idle state....

I think we are at a stalemate here - you say it's sufficient, I
think it doesn't change anything - and we don't have a repeatable
test case that we can use to find the real problem with and break
the stalemate....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
