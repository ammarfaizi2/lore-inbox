Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRFOGFv>; Fri, 15 Jun 2001 02:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264252AbRFOGFl>; Fri, 15 Jun 2001 02:05:41 -0400
Received: from www.wen-online.de ([212.223.88.39]:37647 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264244AbRFOGFX>;
	Fri, 15 Jun 2001 02:05:23 -0400
Date: Fri, 15 Jun 2001 08:04:31 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Roger Larsson <roger.larsson@norran.net>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <200106142030.f5EKUWH19842@maile.telia.com>
Message-ID: <Pine.LNX.4.33.0106150608590.523-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Roger Larsson wrote:

> On Thursday 14 June 2001 10:47, Daniel Phillips wrote:
> > On Thursday 14 June 2001 05:16, Rik van Riel wrote:
> > > On Wed, 13 Jun 2001, Tom Sightler wrote:
> > > > Quoting Rik van Riel <riel@conectiva.com.br>:
> > > > > After the initial burst, the system should stabilise,
> > > > > starting the writeout of pages before we run low on
> > > > > memory. How to handle the initial burst is something
> > > > > I haven't figured out yet ... ;)
> > > >
> > > > Well, at least I know that this is expected with the VM, although I do
> > > > still think this is bad behavior.  If my disk is idle why would I wait
> > > > until I have greater than 100MB of data to write before I finally
> > > > start actually moving some data to disk?
> > >
> > > The file _could_ be a temporary file, which gets removed
> > > before we'd get around to writing it to disk. Sure, the
> > > chances of this happening with a single file are close to
> > > zero, but having 100MB from 200 different temp files on a
> > > shell server isn't unreasonable to expect.
> >
> > This still doesn't make sense if the disk bandwidth isn't being used.
> >
>
> It does if you are running on a laptop. Then you do not want the pages
> go out all the time. Disk has gone too sleep, needs to start to write a few
> pages, stays idle for a while, goes to sleep, a few more pages, ...

True, you'd never want data trickling to disk on a laptop on battery.
If you have to write, you'd want to write everything dirty at once to
extend the period between disk powerups to the max.

With file IO, there is a high probability that the disk is running
while you are generating files temp or not (because you generally do
read/write, not ____/write), so that doesn't negate the argument.

Delayed write is definitely nice for temp files or whatever.. until
your dirty data no longer comfortably fits in ram.  At that point, the
write delay just became lost time and wasted disk bandwidth whether
it's a laptop or not.  The problem is how do you know the dirty data
is going to become too large for comfort?

One thing which seems to me likely to improve behavior is to have two
goals.  One is the trigger point for starting flushing, the second is
a goal below the start point so we define a quantity which needs to be
flushed to prevent us from having to flush again so soon.  Stopping as
soon as the flush trigger is reached means that we'll reach that limit
instantly if the box is doing any writing.. bad news for the laptop and
not beneficial to desktop or server boxen.  Another benefit of having
two goals is that it's easy to see if you're making progress or losing
ground so you can modify behavior accordingly.

Rik mentioned that the system definitely needs to be optimized for read,
and just thinking about it without posessing much OS theory, that rings
of golden truth.  Now, what does having much dirt lying around do to
asynchronous readahead?.. it turn it synchronous prematurely and negates
the read optimization.

	-Mike

(That's why I mentioned having tried a clean shortage, to ensure more
headroom for readahead to keep it asynchronous longer.  Not working the
disk hard 'enough' [define that;] must harm performance by turning both
read _and_ write into strictly synchronous operations prematurely)


