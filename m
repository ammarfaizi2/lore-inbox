Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSGXQ70>; Wed, 24 Jul 2002 12:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSGXQ70>; Wed, 24 Jul 2002 12:59:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15770 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317401AbSGXQ7Z>;
	Wed, 24 Jul 2002 12:59:25 -0400
Date: Wed, 24 Jul 2002 19:02:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DAC960 Bitrot
Message-ID: <20020724170227.GD15201@suse.de>
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17WlGV-00052g-00@starship> <20020724143931.GG5159@suse.de> <E17XPSR-0007tD-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17XPSR-0007tD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Daniel Phillips wrote:
> On Wednesday 24 July 2002 16:39, Jens Axboe wrote:
> > The only changes I did to this driver where trivial conversions in the
> > 2.5.1-pre days, in fact even before multi-page bio's existed. This,
> > btw, is also something you should keep an eye out for -- multi-page bio
> > support is currently broken.
> 
> I spotted that.  I changed bio_size (which is gone) to bio_sectors(bio) << 9, 
> is this correct?

Probably not. There are all sorts of issues about when to go to the next
bio (bi_next) and when just to grab the next bvec by increasing bi_idx.
It can be pretty hairy for a driver to do.

> > I would suggest also moving DAC960 to the
> > pci dma api (this is a must) and then move it to use the generic block
> > helpers for mapping requests. That way there isn't a lot of nasty
> > duplication there as well, plus it will automatically get the multi-page
> > issues right.
> 
> My first concern is to get something working any way I can so that I can 
> start doing regression testing.  True/false: the bad old way of doing dma 

I think that's a really bad idea. Yes it's a lot of work to do the pci
dma conversion (but it's not _hard_), but you'll get the rest for free
once that is done. Really. If you do it your way, then you'll just fix
up the old driver only to rewrite the dma handling (and then convert to
the block helpers) later on. Twice the work. Did I sell the idea or
what?

> will still work, it's just deprecated?  If true, then I should (trivially) 
> switch back to the old way of doing things, get the rest working, then 
> convert to the dma api.  Maybe *you* could make all the changes at the same 
> time and expect to end up with something that works, but I can't.

See above :)

> The alternative is to go back many kernel versions and find the first one  
> that broke something, but I don't want to do that because too much else was 
> broken at the time.

Well, you'll go back to 2.5.1-preX and find that the breaking point is
when the bio stuff got merged. And you'll find that the DAC960 driver is
about the same as it is now. So that will buy you nothing, I'm afraid.

> > Hmm, is DAC960 using a full major per controller?!
> 
> As you saw, it implements the top level block interface instead of being a 
> scsi device as it should be.  So for disk subsystems we have: 1) IDE 2) SCSI 
> 3) DAC960.  Eep.  At some point it's all going to be SCSI, right?

Nah not really, at some point it will just be the 'disk' sub system.
BTW, you also forgot at least cpqarray and cciss :-)

-- 
Jens Axboe

