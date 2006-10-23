Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWJWXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWJWXWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbWJWXWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:22:22 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:65466 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1752057AbWJWXWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:22:21 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200610231607.17525.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610231236.54317.rjw@sisk.pl>
	 <1161605379.3315.23.camel@nigel.suspend2.net>
	 <200610231607.17525.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 09:22:18 +1000
Message-Id: <1161645738.7033.41.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 16:07 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 14:09, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2006-10-23 at 12:36 +0200, Rafael J. Wysocki wrote:
> > > On Monday, 23 October 2006 06:12, Nigel Cunningham wrote:
> > > > XFS can continue to submit I/O from a timer routine, even after
> > > > freezeable kernel and userspace threads are frozen. This doesn't seem to
> > > > be an issue for current swsusp code,
> > > 
> > > So it doesn't look like we need the patch _now_.
> > 
> > I'm trying to prepare the patches to make swsusp into suspend2.
> 
> Oh, I see.  Please don't do that.

(Yes, echoing Andrew..) Why not?

> > Please assume it's part of a stream of patches that belong together, rather
> > than an isolated modification. Yes, I'd really rather just rm -f swap.c
> > user.c swsusp.c,
> 
> And I'm against that, sorry.  Also I don't think you can remove user.c just
> like that.

Are you saying you're against a stream of patches that belong together?
Well, I'm sorry but that's the way things work sometimes. I know
everyone loves this evolutionary model, but it just doesn't work in
practice. We see sets of patches going through all the time in which
[2/4] prepares the foundations for [3/4] and so on. That's what I'm
doing, I just don't yet know how big the n is in [2/n].

Regarding removing user.c, I said I'd rather, not that I'm going to
submit a patch to do it :)

> > but I'm trying to do the incremental modification thing for you.
> >
> > > > but is definitely an issue for Suspend2, where the pages being written could
> > > > be overwritten by Suspend2's atomic copy.
> > > 
> > > And IMO that's a good reason why we shouldn't use RCU pages for storing the
> > > image.  XFS is one known example that breaks things if we do so and
> > > there may be more such things that we don't know of.  The fact that they
> > > haven't appeared in testing so far doesn't mean they don't exist and
> > > moreover some things like that may appear in the future.
> > 
> > Ok. We can modify the selection of pages to be overwritten. I agree that
> > absence of proof isn't proof of absence, but on the later part, we can't
> > rule some modification out now because something in the future might
> > break it.

(s/RCU/LRU applied to avoid confusion)

> This case is a bit special.  I don't think it would be right to require every
> device driver writer to avoid modifying LRU pages from the interrupt
> context, because that would break the suspend to disk ...

I'm not arguing for that.

> Besides, if there is an LRU page that we _know_ we can use to store the image
> in it, we can just include this page in the image without copying.  This
> already gives us one extra free page for the rest of the image and we can
> _avoid_ creating two images which suspend2 does and which adds a _lot_ of
> complexity to the code.

Do you have a number for '_lot_'? It's easy to say, but it would be
better to be able to say "I counted n lines of code you could remove if
you didn't save a full image of memory".

> > > > We can address this issue by freezing bdevs after stopping userspace
> > > > threads, and thawing them prior to thawing userspace.
> > > 
> > > This will only address the issues related to filesystems, but the RCU pages
> > > can also be modified from interrupt context by other code, AFAICT.
> > 
> > Agreed. We can find some other way to address that.
> 
> I think, to stat with, we should look for pages that we're deadly sure will
> _not_ be overwritten from the interrupt context (for example, the pages that
> are mapped read-only by the user space look promising).  Then, we should
> estimate the number of these pages and consider if dealing with them in
> a special way is worth the effort.

I was thinking of coming at it from the other direction, since I expect
the pages that might be modified from an interrupt context to be
minimal. The fact that Suspend2 has worked for years now using this
algorithm seems to confirm that.

Regards,

Nigel

