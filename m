Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSJAPoW>; Tue, 1 Oct 2002 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSJAPoW>; Tue, 1 Oct 2002 11:44:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16551 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261908AbSJAPoV>;
	Tue, 1 Oct 2002 11:44:21 -0400
Date: Tue, 1 Oct 2002 17:49:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.39-mm1
Message-ID: <20021001154928.GC5755@suse.de>
References: <200209301941.41627.conman@kolivas.net> <200210012219.53464.conman@kolivas.net> <20021001123013.GS3867@suse.de> <200210012344.38964.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210012344.38964.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tuesday 01 Oct 2002 10:30 pm, Jens Axboe wrote:
> > On Tue, Oct 01 2002, Con Kolivas wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > On Tuesday 01 Oct 2002 8:20 pm, Andrew Morton wrote:
> > > > Jens Axboe wrote:
> > > > > On Mon, Sep 30 2002, Andrew Morton wrote:
> > > > > > > io_load:
> > > > > > > Kernel                  Time            CPU             Ratio
> > > > > > > 2.4.19                  216.05          33%             3.19
> > > > > > > 2.5.38                  887.76          8%              13.11
> > > > > > > 2.5.38-mm3              105.17          70%             1.55
> > > > > > > 2.5.39                  229.4           34%             3.4
> > > > > > > 2.5.39-mm1              239.5           33%             3.4
> > > > > >
> > > > > > I think I'll set fifo_batch to 16 again...
> > > > >
> > > > > As not to compare oranges and apples, I'd very much like to see a
> > > > > 2.5.39-mm1 vs 2.5.39-mm1 with fifo_batch=16. Con, would you do that?
> > > > > Thanks!
> > > >
> > > > The presence of /proc/sys/vm/fifo_batch should make that pretty easy.
> > >
> > > Thanks. That made it a lot easier and faster, and made me curious enough
> > > to create a family or very interesting results. All these are with
> > > 2.5.39-mm1 with fifo_batch set to 1->16, average of three runs. The first
> > > result is the unmodified 2.5.39-mm1 (fifo_batch=32).
> >
> > Ah excellent, thanks a lot!
> >
> > > io_load:
> > > Kernel                  Time            CPU%            Ratio
> > > 2.5.39-mm1              239.5           32              3.54
> > > 2539mm1fb16             131.2           57              1.94
> > > 2539mm1fb8              109.1           68              1.61
> > > 2539mm1fb4              146.4           51              2.16
> > > 2539mm1fb2              112.7           65              1.67
> > > 2539mm1fb1              125.4           60              1.85
> > >
> > > What's most interesting is the variation was small until the number was
> > > <8; then the variation between runs increased. Dare I say it there
> > > appears to be a sweet spot in the results.
> >
> > Yes it's an interesting curve. What makes it interesting is that 8 is
> > better than 16. Both allow one seek to be dispatched, they only differ
> > in the streamed amount of data we allow to dispatch. 8 will give you
> > either 1 seek, or 8*256 == 2048 sectors == 1MiB. 16 will give you 1 seek
> > or 2MiB of streamed I/O.
> >
> > Tests with other io benchmarks need to be considered as well. And I need
> > a bit of time to digest this :-). The 8 vs 16 numbers are not what I
> > expected.
> 
> It would seem reasonable to me to assume it may be related to the filesystem 
> in use (in this case ReiserFS). If this is the case it is possible that each 
> different filesystem has a different sweetspot? (and for that matter each 
> piece of hardware, each type of ata driver etc etc..)
> 
> This was performed on an ATA100 5400rpm drive running ReiserFS. I'm afraid I 
> don't have the hardware to do any other comparisons of different filesystems.

8 being better than 16 would seem to indicate a slower driver, which
fits with what you have. The sweet spot for this particular benchmark
may be 8, that may not be the sweet spot for some other benchmark
though. 16 will perhaps make a good default, we shall see once more
benchmarks are done.

I think you'll find that results will be similar on other file systems,
the io scheduler settings will be more affected by the underlying
hardware.

-- 
Jens Axboe

