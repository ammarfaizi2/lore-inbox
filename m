Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbULHHds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbULHHds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbULHHbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:31:23 -0500
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:57723 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262055AbULHH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:29:14 -0500
Subject: Re: Time sliced CFQ io scheduler
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208072052.GC19522@suse.de>
References: <20041202195232.GA26695@suse.de>
	 <20041208003736.GD16322@dualathlon.random>
	 <1102467253.8095.10.camel@npiggin-nld.site>
	 <20041208013732.GF16322@dualathlon.random>
	 <20041207180033.6699425b.akpm@osdl.org>
	 <20041208022020.GH16322@dualathlon.random>
	 <20041207182557.23eed970.akpm@osdl.org>
	 <1102473213.8095.34.camel@npiggin-nld.site> <20041208065858.GH3035@suse.de>
	 <1102490086.8095.63.camel@npiggin-nld.site>
	 <20041208072052.GC19522@suse.de>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 18:29:05 +1100
Message-Id: <1102490945.8095.77.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 08:20 +0100, Jens Axboe wrote:
> On Wed, Dec 08 2004, Nick Piggin wrote:
> > On Wed, 2004-12-08 at 07:58 +0100, Jens Axboe wrote:
> > > On Wed, Dec 08 2004, Nick Piggin wrote:
> > > > On Tue, 2004-12-07 at 18:25 -0800, Andrew Morton wrote:
> > 
> > > > I think we could detect when a disk asks for more than, say, 4
> > > > concurrent requests, and in that case turn off read anticipation
> > > > and all the anti-starvation for TCQ by default (with the option
> > > > to force it back on).
> > > 
> > > CFQ only allows a certain depth a the hardware level, you can control
> > > that. I don't think you should drop the AS behaviour in that case, you
> > > should look at when the last request comes in and what type it is.
> > > 
> > > With time sliced cfq I'm seeing some silly SCSI disk behaviour as well,
> > > it gets harder to get good read bandwidth as the disk is trying pretty
> > > hard to starve me. Maybe killing write back caching would help, I'll
> > > have to try.
> > > 
> > 
> > I "fixed" this in AS. It gets (or got, last time we checked, many months
> > ago) pretty good read latency even with a big write and a very large
> > tag depth.
> > 
> > What were the main things I had to do... hmm, I think the main one was
> > to not start on a new batch until all requests from a previous batch
> > are reported to have completed. So eg. you get all reads completing
> > before you start issuing any more writes. The write->read side of things
> > isn't so clear cut with your "smart" write caches on the IO systems, but
> > no doubt that helps a bit.
> 
> I can see the read/write batching being helpful there, at least to
> prevent writes starving reads if you let the queue drain completely
> before starting a new batch.
> 
> CFQ does something similar, just not batched together. But it does let
> the depth build up a little and drain out. In fact I think I'm missing
> a little fix there thinking about it, that could be why the read
> latencies hurt on write intensive loads (the dispatch queue is drained,
> the hardware queue is not fully).
> 

OK, you should look into that, because I found it was quite effective.
Maybe you have a little bug or oversight somewhere if you read latencies
are really bad. Note that AS read latencies at 256 tags aren't so good
as at 2 tags... but I think they're an order of magnitude better than
with deadline on the hardware we were testing.

> > Of course, after you do all that your database performance has well and
> > truly gone down the shitter. It is also hampered by the more fundamental
> > issue that read anticipating can block up the pipe for IO that is cached
> > on the controller/disks and would get satisfied immediately.
> 
> I think we need to end up with something that sets the machine profile
> for the interesting disks. Some things you can check for at runtime
> (like the writes being extremely fast is a good indicator of write
> caching), but it is just not possible to cover it all. Plus, you end up
> with 30-40% of the code being convoluted stuff added to detect it.
> 

Ideally maybe we would have a userspace program that is run to detect
various disk parameters and ask the user / config file what sort of
workloads we want to do, and spits out a recommended IO scheduler and
/sys configuration to accompany it.

That at least could be made quite sophisticated than a kernel solution,
and could gather quite a lot of "static" disk properties.

Of course there will be also some things that need to be done in
kernel...


