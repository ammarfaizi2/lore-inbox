Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWJRLsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWJRLsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWJRLsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:48:36 -0400
Received: from brick.kernel.dk ([62.242.22.158]:43309 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030243AbWJRLsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:48:35 -0400
Date: Wed, 18 Oct 2006 13:49:14 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018114913.GG24452@kernel.dk>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018113001.GV23492@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Jakob Oestergaard wrote:
> On Wed, Oct 18, 2006 at 11:40:56AM +0200, Arjan van de Ven wrote:
> ...
> > Hi,
> > 
> > I can see that that makes it simple, but.. what would it MEAN? Eg what
> > would a system administrator use it for?
> 
> For example, I could allocate "at least 100 iops/sec" for my database.
> The VMWare can take whatever is left.
> 
> I have no idea how much bandwidth my database needs... But I have a
> rough idea about how many I/O operations it does for a given operation.
> And if I don't, strace can tell me pretty quick :)

That's crazy. So you want a user of this to strace and write a script
parsing strace output to tell you possibly how many iops/sec you need?

> > It then no longer means "my mp3
> > player is guaranteed to get the streaming mp3 from the disk at this
> > bitrate" or something like that...
> 
> In a sense you are right.
> 
> You cannot be certain that the mp3 player will get a specific bandwidth.
> The mp3 player will be accessing the underlying storage through a
> filesystem, which again means that accessing a file sequentially *will*
> cause non-sequential I/O on the underlying device(s).
> 
> If you wanted to guarantee any specific bandwidth, you would somehow
> assume that you had an infinite (or at least very very high) number of
> seeks at your disposal. Or that seeks were free... In any other
> scenario, the total "capacity" of your underlying storage, the maximum
> amount of bandwidth (including non-free seeks) available, would vary
> depending on how it is currently used (how many seeks are issued) by all
> the clients.
> 
> So, what I'm arguing is; you will not want to specify a fixed sequential
> bandwidth for your mp3 player.
>
> What you want to do is this: Allocate 5 iops/sec for your mp3 player
> because either a quick calculation - or - experience has shown that this
> is enough for it to keep its buffer from depleting at all times.

But that is the only number that makes sense. To give some sort of soft
QOS for bandwidth, you need the file given so the kernel can bring in
the meta data (to avoid those seeks) and see how the file is laid out.
For the mp3 case, you should not even need to ask the user anything. The
player app knows exactly how much bandwidth it needs and what kind of
latency, if can tell from the bitrate of the media. What you are arguing
for is doing trial and error with a magic iops/sec metric that is both
hard to understand and impossible to quantify.

> Describing iops/sec for your mp3 player is at least as simple as
> sequential bitrate. The difference is, that you can implement iops/sec
> allocation whereas you cannot implement bitrate allocation (in a
> meaningful way at least)   :)
>
>
> > so my question to you is: can you
> > describe what it'd bring the admin to put such an allocation in place?
> 
> Limiting on iops/sec rather than bandwidth, is simply accepting that
> bandwidth does not make sense (because you cannot know how much of it
> you have and therefore you cannot slice up your total capacity), and,
> realizing that bandwidth in the scenarios where limiting is interesting
> is in reality bound by seeks rather than sequential on-disk throughput.

I don't understand your arguments, to be honest. If you can tell the
iops/sec rate for a given workload, you can certainly see the bandwidth
as well. Both iops/sec and bandwidth will vary wildly depending on the
workload(s) on the disk.

> > If we find that it can be a good approach.. but if not, I'm less certain
> > this'll be used..
> 
> I can only see a problem with specifying iops/sec in the one scenario
> where you have multiple sequential readers or writers, and you want to
> distribute bandwidth between them.

If you only have one app doing io, you don't need QOS. The thing is, you
always have competing apps. Even with only one user space app running,
the kernel may still generate io for you.

> In all other scenarios, I believe iops/sec is by far a superios way of
> describing the ressource allocation. For two reasons:
> 1)  It describes what the hardware provides
> 2)  By describing a concept based on the real world it may actually be
>     possible to implement so that it works as intended

Same arguments. You can't universally state that this disk gives you
80MiB/sec, and you can't universally state that this disk gives you 1000
iops/sec. You need to also define the conditions for when it can provide
this performance. So if you instead say this disk does 80MiB/sec if read
with at least 8KiB blocks from lba 0 to 50000 sequentially. Or you can
state the same with iops/sec.

-- 
Jens Axboe

