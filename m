Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWJRMmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWJRMmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWJRMmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:42:15 -0400
Received: from brick.kernel.dk ([62.242.22.158]:64331 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030253AbWJRMmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:42:14 -0400
Date: Wed, 18 Oct 2006 14:42:53 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018124253.GH24452@kernel.dk>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018122323.GW23492@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Jakob Oestergaard wrote:
> On Wed, Oct 18, 2006 at 01:49:14PM +0200, Jens Axboe wrote:
> > On Wed, Oct 18 2006, Jakob Oestergaard wrote:
> ...
> > > I have no idea how much bandwidth my database needs... But I have a
> > > rough idea about how many I/O operations it does for a given operation.
> > > And if I don't, strace can tell me pretty quick :)
> > 
> > That's crazy. So you want a user of this to strace and write a script
> > parsing strace output to tell you possibly how many iops/sec you need?
> 
> Come up with something better then, genious  :)
> 
> strace for iops is doable albeit complicated.

The concept was already described, bandwidth.

> Determining MiB/sec requirement for sufficient db performance is
> impossible.

But you can say you want to give the db 90% of the disk bandwidth, and
at least 50%. The iops/sec metric doesn't help you.

It's an entirely diffent thing from the mp3 player. With the player app,
you want to have the bitrate available at the right latency. For a db, I
guess you typically want to contain it somehow - make sure it gets at
least foo amount of the disk, but don't let it suck everything.

> > > So, what I'm arguing is; you will not want to specify a fixed sequential
> > > bandwidth for your mp3 player.
> > >
> > > What you want to do is this: Allocate 5 iops/sec for your mp3 player
> > > because either a quick calculation - or - experience has shown that this
> > > is enough for it to keep its buffer from depleting at all times.
> > 
> > But that is the only number that makes sense. To give some sort of soft
> > QOS for bandwidth, you need the file given so the kernel can bring in
> > the meta data (to avoid those seeks) and see how the file is laid out.
> 
> Ok I see where you're going. I think it sounds very complicated - for
> the user and for the kernel.
> 
> Would you want to limit bandwidth on a per-file or per-process basis?
> You're talking files, above, I was thinking about processes (consumers
> if you like) the whole time.

You need to define your workload for the kernel to know what to do. So
for the bandwidth case, you need to tell the kernel against what file
you want to allocate that bandwidth. If you go the percentage route, you
don't need that. The percentage route doesn't care about sequential or
random io, it just gets you foo % of the disk time. If the slice given
is large enough, with 10% of the disk time you may have 90% of the total
bandwidth if the remaining 90% of the time is spent doing random io. But
you still have 10% of the time allocated.

> Have you thought about how this would work in the long run, with many
> files coming into use? The kernel can't have the meta-data cached for
> all files - so the reading-in of metadata would affect the remaining
> available disk performance... 

Just like any other system activity affects the disk bandwidth. That's
exactly one of the reasons why you want to operate in terms of time, not
requests.

> > For the mp3 case, you should not even need to ask the user anything. The
> > player app knows exactly how much bandwidth it needs and what kind of
> > latency, if can tell from the bitrate of the media.
> 
> Agreed. And this holds true for both base metrics, bandwidth or iops/sec.

Right, because they are sides of the same story. The difference is not
in the metric, but the meaning it gives to the user.

> > What you are arguing
> > for is doing trial and error
> 
> Sort-of correct.

How would you otherwise do it?

> > with a magic iops/sec metric that is both
> > hard to understand and impossible to quantify.
> 
> iops/sec is what you get from your disks. In real world scenarios. It's
> no more magic than the real world, and no harder to understand than real
> world disks. Although I admit real-world disks can be a bitch at times ;)

Again, iops/sec doesn't make sense unless you say how big the iops is
and what your stream of iops look like. That's why I say it's a
benchmark metric.

> My argument is that it is simpler to understand than bandwidth.

And mine is that that is nonsense :-)

> Sure, for the streaming file example bandwidth sounds simple. But how
> many real-world applications are like that?  What about databases? What
> about web servers?  What about mail servers?  What about 99% of the
> real-world applications out there that are not streaming audio or video
> players?

Reserving bandwidth at x kib/sec for an mp3 player and containing a
different type of app are two separate things. A decent io scheduler
should make sure in general that nobody is totally starved. If you have
5 services running on your machine and you want to make sure that eg the
web server gets 50% of the bandwidth, you will want to inform the kernel
of that fact. Since you don't know what the throughput of the disk is at
any given time (be it Mib/sec or iops/sec, doesn't matter), you can only
say 50% at that time.

I really don't see how this pertains to bandwidth vs iops/sec.

> > > Limiting on iops/sec rather than bandwidth, is simply accepting that
> > > bandwidth does not make sense (because you cannot know how much of it
> > > you have and therefore you cannot slice up your total capacity), and,
> > > realizing that bandwidth in the scenarios where limiting is interesting
> > > is in reality bound by seeks rather than sequential on-disk throughput.
> > 
> > I don't understand your arguments, to be honest. If you can tell the
> > iops/sec rate for a given workload, you can certainly see the bandwidth
> > as well.
> 
> My thesis is, that for most applications it is not the bandwidth you
> care about.
> 
> If I am not right in this, sure, you have a point then. But hey, how
> many of the applications out there are mp3 players?  (in other words;
> please oh please, prove me wrong, I like it :)

We are talking about two seperate things here. The mp3 player vs some
other app argument is totally separate from iops/sec vs MiB/sec.

> > Both iops/sec and bandwidth will vary wildly depending on the
> > workload(s) on the disk.
> 
> The total iops/sec "available" from a given disk will not vary a lot,
> compared to how the total bandwidth available from a given disk will
> vary.

That's only true if you scale your iops. And how are you going to give
that number? You need to define what an iop is for it to be meaningfull.

> > > I can only see a problem with specifying iops/sec in the one scenario
> > > where you have multiple sequential readers or writers, and you want to
> > > distribute bandwidth between them.
> > 
> > If you only have one app doing io, you don't need QOS.
> 
> Precisely!
> 
> In the *one* case where it is actually possible to implement a QOS
> system based on bandwidth, you don't need QOS.
> 
> With more than 1 client, you get seeks, and then bandwidth is no longer
> a sensible measure.

And neither is iops/sec. But things don't deteriorate that quickly, if
you can tolerate higher latency, it's quite possible to have most of the
potential bandwidth available for > 1 client workloads.

-- 
Jens Axboe

