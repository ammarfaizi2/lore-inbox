Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284726AbRLEVEI>; Wed, 5 Dec 2001 16:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLEVD0>; Wed, 5 Dec 2001 16:03:26 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:17676 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S284727AbRLEVDE>;
	Wed, 5 Dec 2001 16:03:04 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200112052102.WAA29674@nbd.it.uc3m.es>
Subject: Re: Current NBD 'stuff'
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.LNX.4.10.10112051058140.17617-100000@clements.sc.steeleye.com>
 "from Paul Clements at Dec 5, 2001 11:14:43 am"
To: Paul.Clements@steeleye.com
Date: Wed, 5 Dec 2001 22:02:56 +0100 (CET)
Cc: Edward Muller <emuller@learningpatterns.com>, linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Paul Clements wrote:"
> On 4 Dec 2001, Edward Muller wrote:
> 
> A word of caution on this. I played around with ENBD (as well as some
> others) about 6 months ago. I also did some performance testing with
> the different drivers and user-level utilities. What I found was that
> ENBD achieved only about 1/3 ~ 1/4 the throughput of NBD (even with
> multiple replication paths and various block sizes). YMMV.

It strikes me that possibly you were using the 2.2 kernel. My logic is
that (1) nowadays kernels coalesce all requests into large lumps - limited
only by the drivers wishes - before the driver gets them, (2) I don't
think I ever managed to get req merging working in kernel 2.2, but now
the kernel does it for free.  When nbd sets the limit as 256KB, it gets
256KB sized requests to treat.  Did you see the req size distribution in
my previous reply?  It was flat-out at the size limit every time.

So whatever time is spent in the kernel or in userspace per req (possibly
the context switch is still significant, but make the lumps bigger then
..) is dwarfed by the time spent in kernel networking, making the lumps
go out and come back from the net.  On 100BT we are talking about 1/4s in
networking, per request. If we waste 10m/s over pavel in actual coding
and context switches (ridiculous!) we lose only 4% in speed, not 75%!

So I think you could compile in visual basic and get no variance in
speed at the client end, at least. That leaves the server net-to-disk
time to contend with.

I don't know about that end. But Enbd does not do anything different in
principle from what kernel nbd does. It might well be slower because
the code is heavily layered. I suspect that at that end transfers are
done at the local disk blocksize, which may be small enough to make
code differences noticable. But in general I find that Enbd goes
either at the speed of the net or at the speed of the remote disk,
whichever is slower.

It also uses a trick when writing that usually results in exceeding the 
cable bandwidth by a factor of two during raid resyncs over nbd.


> I also looked at DRBD, which performed pretty well (comparable to NBD).
> 
> > But that's mostly because Pavel doesn't have much time at the moment for
> > it AFAIK.

Peter
