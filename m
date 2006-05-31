Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWEaA5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWEaA5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWEaA5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 20:57:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932548AbWEaA5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 20:57:05 -0400
Date: Tue, 30 May 2006 17:56:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447CE43A.6030700@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 May 2006, Nick Piggin wrote:
> 
> The requests can only get merged if contiguous requests from the upper
> layers come down, right?

It has nothing to do with merging. It has to do with IO patterns.

Seeking.

Seeking is damn expensive - much more so than command issue. People forget 
that sometimes.

If you can sort the requests so that you don't have to seek back and 
forth, that's often a HUGE win. 

Yes, the requests will still be small, and yes, the IO might happen in 4kB 
chunks, but it happens a lot faster if you do it in a good elevator 
ordering and if you hit the track cache than if you seek back and forth.

And part of that is that you have to submit multiple requests when you 
start, and allow the elevator to work on it.

Now, of course, if you have tons of reqeusts already in flight, you don't 
care (you already have lots of work for the elevator), but at least in 
desktop loads the "starting from idle" case is pretty common. Getting just 
a few requests to start up with is good.

(Yes, tagged queueing makes it less of an issue, of course. I know, I 
know. But I _think_ a lot of disks will start seeking for an incoming 
command the moment they see it, just to get the best latency, rather than 
wait a millisecond or two to see if they get another request. So even 
with tagged queuing, the elevator can help, _especially_ for the initial 
request).

> Why would plugging help if the requests can't get merged, though?

Why do you think we _have_ an elevator in the first place?

And just how well do you think it works if you submit one entry at a time 
(regardless of how _big_ it is) and start IO on it immediately? Vs trying 
to get several IO's out there, so that we can say "do this one first".

Sometimes I think harddisks have gotten too quiet - people no longer hear 
it when access patters are horrible. But the big issue with plugging was 
only partially about request coalescing, and was always about trying to 
get the _order_ right when you start to actually submit the requests to 
the hardware.

And yes, I realize that modern disks do remapping, and that we will never 
do a "perfect" job. But it's still true that the block number has _some_ 
(fairly big, in fact) relationship to the actual disk layout, and that 
avoiding seeking is a big deal.

Rotational latency is often an even bigger issue, of course, but we can't 
do much about that. We really can't estimate where the head is, like 
people used to try to do three decades ago. _That_ time is long past, but 
we can try to avoid long seeks, and it's still true that you can get 
blocks that are _close_ faster (if only because they may end up being on 
the same cylinder and not need a seek).

Even better than "same cylinder" is sometimes "same cache block" - disks 
often do track caching, and they aren't necessarily all that smart about 
it, so even if you don't read one huge contiguous block, it's much better 
to read an area _close_ to another than seek back and forth, because 
you're more likely to hit the disks own track cache.

And I know, disks aren't as sensitive to long seeks as they used to be (a 
short seek is almost as expensive as a long one, and a lot of it is the 
head settling time), but as another example - I think for CD-ROMs you can 
still have things like the motor spinning faster or slower depending on 
where the read head is, for example, meaning that short seeks are cheaper 
than long ones.

(Maybe constant angular velocity is what people use, though. I dunno).

		Linus
