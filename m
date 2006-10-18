Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWJRMXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWJRMXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWJRMXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:23:24 -0400
Received: from unthought.net ([212.97.129.88]:55302 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751478AbWJRMXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:23:22 -0400
Date: Wed, 18 Oct 2006 14:23:24 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061018122323.GW23492@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jens Axboe <jens.axboe@oracle.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Phetteplace, Thad (GE Healthcare, consultant)" <Thad.Phetteplace@ge.com>,
	linux-kernel@vger.kernel.org
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018114913.GG24452@kernel.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 01:49:14PM +0200, Jens Axboe wrote:
> On Wed, Oct 18 2006, Jakob Oestergaard wrote:
...
> > I have no idea how much bandwidth my database needs... But I have a
> > rough idea about how many I/O operations it does for a given operation.
> > And if I don't, strace can tell me pretty quick :)
> 
> That's crazy. So you want a user of this to strace and write a script
> parsing strace output to tell you possibly how many iops/sec you need?

Come up with something better then, genious  :)

strace for iops is doable albeit complicated.

Determining MiB/sec requirement for sufficient db performance is
impossible.

> > 
> > So, what I'm arguing is; you will not want to specify a fixed sequential
> > bandwidth for your mp3 player.
> >
> > What you want to do is this: Allocate 5 iops/sec for your mp3 player
> > because either a quick calculation - or - experience has shown that this
> > is enough for it to keep its buffer from depleting at all times.
> 
> But that is the only number that makes sense. To give some sort of soft
> QOS for bandwidth, you need the file given so the kernel can bring in
> the meta data (to avoid those seeks) and see how the file is laid out.

Ok I see where you're going. I think it sounds very complicated - for
the user and for the kernel.

Would you want to limit bandwidth on a per-file or per-process basis?
You're talking files, above, I was thinking about processes (consumers
if you like) the whole time.

Have you thought about how this would work in the long run, with many
files coming into use? The kernel can't have the meta-data cached for
all files - so the reading-in of metadata would affect the remaining
available disk performance... 

> For the mp3 case, you should not even need to ask the user anything. The
> player app knows exactly how much bandwidth it needs and what kind of
> latency, if can tell from the bitrate of the media.

Agreed. And this holds true for both base metrics, bandwidth or iops/sec.

> What you are arguing
> for is doing trial and error

Sort-of correct.

> with a magic iops/sec metric that is both
> hard to understand and impossible to quantify.

iops/sec is what you get from your disks. In real world scenarios. It's
no more magic than the real world, and no harder to understand than real
world disks. Although I admit real-world disks can be a bitch at times ;)

My argument is that it is simpler to understand than bandwidth.

Sure, for the streaming file example bandwidth sounds simple. But how
many real-world applications are like that?  What about databases? What
about web servers?  What about mail servers?  What about 99% of the
real-world applications out there that are not streaming audio or video
players?

> > Limiting on iops/sec rather than bandwidth, is simply accepting that
> > bandwidth does not make sense (because you cannot know how much of it
> > you have and therefore you cannot slice up your total capacity), and,
> > realizing that bandwidth in the scenarios where limiting is interesting
> > is in reality bound by seeks rather than sequential on-disk throughput.
> 
> I don't understand your arguments, to be honest. If you can tell the
> iops/sec rate for a given workload, you can certainly see the bandwidth
> as well.

My thesis is, that for most applications it is not the bandwidth you
care about.

If I am not right in this, sure, you have a point then. But hey, how
many of the applications out there are mp3 players?  (in other words;
please oh please, prove me wrong, I like it :)

> Both iops/sec and bandwidth will vary wildly depending on the
> workload(s) on the disk.

The total iops/sec "available" from a given disk will not vary a lot,
compared to how the total bandwidth available from a given disk will
vary.

...
> > I can only see a problem with specifying iops/sec in the one scenario
> > where you have multiple sequential readers or writers, and you want to
> > distribute bandwidth between them.
> 
> If you only have one app doing io, you don't need QOS.

Precisely!

In the *one* case where it is actually possible to implement a QOS
system based on bandwidth, you don't need QOS.

With more than 1 client, you get seeks, and then bandwidth is no longer
a sensible measure.

> The thing is, you
> always have competing apps. Even with only one user space app running,
> the kernel may still generate io for you.

Sing it brother, sing it!  ;)

> > In all other scenarios, I believe iops/sec is by far a superios way of
> > describing the ressource allocation. For two reasons:
> > 1)  It describes what the hardware provides
> > 2)  By describing a concept based on the real world it may actually be
> >     possible to implement so that it works as intended
> 
> Same arguments. You can't universally state that this disk gives you
> 80MiB/sec, and you can't universally state that this disk gives you 1000
> iops/sec.

I agree.

But I would be lying a lot less if I made the claim in iops/sec  :)

They will vary a factor of two or three, depending on their nature.

Bandwidth will vary three to five orders of magnitude depending on the
nature of the I/O operations issued to the device.

> You need to also define the conditions for when it can provide
> this performance. So if you instead say this disk does 80MiB/sec if read
> with at least 8KiB blocks from lba 0 to 50000 sequentially. Or you can
> state the same with iops/sec.

Yep.

However, for the interface to be useful, it needs two things as I see it
(and I may well be overlooking something):
1) It needs to be simple to use
2) It needs to do what it claims, "well enough"



-- 

 / jakob

