Return-Path: <linux-kernel-owner+w=401wt.eu-S965395AbXATVYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965395AbXATVYq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 16:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbXATVYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 16:24:43 -0500
Received: from 1wt.eu ([62.212.114.60]:2100 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965391AbXATVYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 16:24:42 -0500
Date: Sat, 20 Jan 2007 22:24:14 +0100
From: Willy Tarreau <w@1wt.eu>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Ismail =?iso-8859-1?Q?D=F6nm?= <ismail@pardus.org.tr>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120212414.GF25307@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu> <200701201952.54714.ismail@pardus.org.tr> <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de> <20070120202821.GD25307@1wt.eu> <Pine.LNX.4.63.0701202135380.23938@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701202135380.23938@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 09:39:25PM +0100, Tim Schmielau wrote:
> On Sat, 20 Jan 2007, Willy Tarreau wrote:
> > On Sat, Jan 20, 2007 at 09:10:22PM +0100, Tim Schmielau wrote:
> > > 
> > > Note that these dd "benchmarks" are completely bogus, because the data 
> > > doesn't actually get written to disk in that time. For some enlightening 
> > > data, try
> > > 
> > >   time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time sync
> > > 
> > > The dd returns as soon as all data could be buffered in RAM. Only sync 
> > > will show how long it takes to actually write out the data to disk.
> > 
> > While I 100% agree with you on this, I'd like to note that I don't agree
> > with the following statement :
> > 
> > > also explains why you see better results is writeout starts earlier.
> > 
> > The results should be better when writeout starts later since most of
> > the transfer will have been performed at RAM speed. That's what happens
> > with the user above with 2 GB RAM. But in case of the VAIO with 512 MB,
> > there's really something strange IMHO. I suspect it has two RAM areas,
> > one fast and one slow (probably one two large non-cacheable area for a
> > shared video or such a crap, which can be avoided when reducing the
> > cache size).
> 
> No - the earlier the writeout starts, the earlier he will have enough free 
> RAM to finish the dd command by buffering the remaining data.

OK I see your point. While trying to show why I got you wrong, I in fact
demonstrated to myself that you were right :-)

For instance, let's say we have 500 MB cache at 1000 MB/s and a write out
threshold of 80% with a disk at 100 MB/s. Writing 1000 MB would produce
this pattern :

  time     data sent   written    dirty data
  in sec    from dd    to disk     in cache
   0.0        0 MB        0 MB        0 MB
   0.4      400 MB        0 MB      400 MB  -> writeout starts
   1.0      560 MB       60 MB      500 MB
   5.4     1000 MB      500 MB      500 MB  -> dd leaves.
  10.4     1000 MB     1000 MB        0 MB  -> write terminated.

-> avg dd   speed = 1000/5.4 = 185 MB/s
   avg disk speed = 1000/10.4 = 96 MB/s


Now with a lower writeout threshold of 2% (10 MB) :

  time     data sent   written    dirty data
  in sec    from dd    to disk     in cache
   0.0        0 MB        0 MB        0 MB
   0.01      10 MB        0 MB       10 MB  -> writeout starts
   1.0      599 MB       99 MB      500 MB
  5.01     1000 MB      500 MB      500 MB  -> dd leaves.
 10.01     1000 MB     1000 MB        0 MB  -> write terminated.

-> avg dd   speed = 1000/5.01 = 199.6 MB/s
   avg disk speed = 1000/10.01 = 99.9 MB/s

At least, numbers are not that much different to justify a one to two speed
ratio on the VAIO. The difference being caused by cache speed, it's clearly
possible that his RAM is definitely very very slow which would then explain
the difference.

----
> Note that we did not cap the amount of buffers, just started to write out 
> earlier.
----

Indeed, that's what makes the whole difference. I was used to cap the amount
of buffers, but the behaviour here is different.

Thanks for your insight !
Willy

