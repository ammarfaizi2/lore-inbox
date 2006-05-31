Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWEaX7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWEaX7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWEaX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:59:31 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19856 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751500AbWEaX7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:59:31 -0400
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 1 Jun 2006 09:59:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17534.11730.599721.445091@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: message from Nick Piggin on Thursday June 1
References: <447AC011.8050708@yahoo.com.au>
	<20060529121556.349863b8.akpm@osdl.org>
	<447B8CE6.5000208@yahoo.com.au>
	<20060529183201.0e8173bc.akpm@osdl.org>
	<447BB3FD.1070707@yahoo.com.au>
	<Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
	<447BD31E.7000503@yahoo.com.au>
	<447BD63D.2080900@yahoo.com.au>
	<Pine.LNX.4.64.0605301041200.5623@g5.osdl.org>
	<447CE43A.6030700@yahoo.com.au>
	<Pine.LNX.4.64.0605301739030.24646@g5.osdl.org>
	<447D9A41.8040601@yahoo.com.au>
	<Pine.LNX.4.64.0605310740530.24646@g5.osdl.org>
	<447DAEDE.5070305@yahoo.com.au>
	<Pine.LNX.4.64.0605310809250.24646@g5.osdl.org>
	<447DB765.6030702@yahoo.com.au>
	<Pine.LNX.4.64.0605310840000.24646@g5.osdl.org>
	<447DC22C.5070503@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday June 1, nickpiggin@yahoo.com.au wrote:
> 
> I keep telling you. Put the unplug after submission of IO. Not before
> waiting for IO.
> 
> I'll give you one example of how it could be better (feel free to ask
> for others too). Your sys_readahead(). Someone asks to readahead 1MB
> of data, currently if the queue is empty, that's going to sit around
> for 4ms before starting the read. 4ms later, the app comes back hoping
> for the request to have finished. Unfortunately it takes another 4ms.
> Throughput is halved.

I think this is all a question of heuristics.  There is a trade off
between throughput and latency, and making the right decisions require
prescience, and I don't think either Intel or AMD have implemented
yet.

One could argue that the best you can get would involve making
decisions at the lowest level - where device characteristics are
known - and using hints from upper levels like "I'm going to submit
lots of requests now" and "Ok, I'm done" and "I want this page NOW".
These should be hints and the device can treat them as it likes.

Maybe a disk device could estimate the time it would take to process
the current plugged queue, and if the first request were older than
half that time, unplug the queue, unless there was a genuine
expectation of more requests very soon...

Currently the decisions are made at a reasonably low level, but the
only hint is "I want some page somewhere on this device now, or maybe
I just want to stop anyone changing ->mapping", which is a fairly
broad and inaccurate hint....

But the real point is that as this is an heuristic, it is very hard to
argue in the abstract about what is best.  We really need measurements
to show that changes to have a measurable effect.

I have an interesting issue with plugging and raid5 at the moment.  As
I mentioned earlier, plugging only affects incomplete stripes being
written.  So if a very long, totally sequential write is being issued
(dd of=/dev/md0) then we never really need to unplug (except may at
the end).  But unplugging does happen (3msec timeout at least) and so
we sometimes end up pre-reading for partial stripes even though there
is really no need.

What I would really like is for ->unplug_fn to know something about
why it is being called.
 - if it is for read, I'll unplug component devices, but not
     incomplete writes.
 - if it is for write, I'll unplug writes, but I'd really rather 
     know which address was required
 - if it is a timeout, I'll unplug writes that have been pending
     for more than 2msec.

I suspect there is at least one workload that this would help, but I
would need to measure to be sure.

... maybe I'll try adding a 'how' option to ->unplug_fn and see what I
can come up with...

NeilBrown
