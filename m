Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTLQTkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLQTkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:40:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:54452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264511AbTLQTkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:40:40 -0500
Date: Wed, 17 Dec 2003 11:40:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
In-Reply-To: <20031217192244.GB12121@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0312171129040.8541@home.osdl.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws>
 <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
 <20031217192244.GB12121@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Dec 2003, Jamie Lokier wrote:
> 
> If a large fs-level I/O transaction is split into lots of 32k
> transactions by the RAID layer, many of those 32k transactions will be
> contiguous on the disks.

Yes.

> That doesn't mean they're contiguous from the fs point of view, but
> given that all modern hardware does scatter-gather, shouldn't the
> contiguous transactions be merged before being sent to the disk?

Yes, as long as the RAID layer (or lowlevel disk) doesn't try to avoid the 
elevator.

BUT (and this is a big but) - apart from wasting a lot of CPU time by
splitting and re-merging, the problem is more fundamental than that.

Let's say that you are striping four disks, with 32kB blocking. Not 
an unreasonable setup.

Now, let's say that the contiguous block IO from high up is 256kB in size. 
Again, this is not unreasonable, although it is actually larger than a lot 
of IO actually is (it is smaller than _some_ IO patterns, but on the whole 
I'm willing to bet that it's in the "high 1%" of the IO done).

Now, we can split that up in 32kB blocks (8 of them), and then merge it
back into 4 64kB blocks sent to disk. We can even avoid a lot of the CPU
overhead by not merging in the first place (and I think we largely do,
actually), and just generate 4 64kB requests in the first place.

But did you notice something?

In one schenario, the disk got a 256kB request, in the other it got a 64kB 
requests.

And guess what? The bigger request is likely to be more efficient.  
Normal disks these days have 8MB+ of cache on the disk, and do partial 
track buffering etc, and the bigger the requests are, the better.

> It may strain the CPU (splitting and merging in a different order lots
> of requests), but I don't see why it should kill I/O access patterns,
> as they can be as large as if you had large stripes in the first place.

But you _did_ kill the IO access patterns. You started out with a 256kB 
IO, and you ended up splitting it in four. You lose.

The thing is, in real life you do NOT have "infinite IO blocks" to start 
with. If that were true, splitting it up across the disks wouldn't cost 
you anything: infinite divided by four is still infinite. But in real life 
you have something that is already of a finite length and a few hundred kB 
is "good" in most normal loads - and splitting it in four is a BAD IDEA!

In contrast, imagine that you had a 1MB stripe. Most of the time the 256kB 
request wouldn't be split at all, and even in the worst case it would get 
split into just 2 requests.

Yes, there are some loads where you can get largely "infinite" request 
sizes. But I'd claim that they are quite rare.

			Linus
