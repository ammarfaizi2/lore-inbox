Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSKKOCr>; Mon, 11 Nov 2002 09:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265110AbSKKOCr>; Mon, 11 Nov 2002 09:02:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59526 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265081AbSKKOCq>;
	Mon, 11 Nov 2002 09:02:46 -0500
Date: Mon, 11 Nov 2002 15:09:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021111140920.GA838@suse.de>
References: <20021111015445.GB5343@x30.random> <Pine.LNX.4.44L.0211111139450.30221-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211111139450.30221-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11 2002, Rik van Riel wrote:
> > Infact I today think the max_bomb_segment I researched some year back
> > was so beneficial in terms of read-latency just because it effectively
> 
> That must be why it was backed out ;)

Warning, incredibly bad quote snip above.

Rik, you basically deleted the interesting part there. The
max_bomb_segment logic was pretty uninteresting if you looked at it
from the POV that says that we must limit the size of a request to
prevent starvation. This is what the name implies, and this is flawed.
However, Andrea goes on to say that it sort-of worked anyways, just
not for the reaon he originally thought it would. It worked because it
limited the total size of pending writes in the queue. And this is
indeed the key factor to read latency in the 2.4 elevator, because reads
tend to get pushed in the back all the time because the queue looks like

R1-W1-W2-W3-....W127

service R1, queue is now

W1-W2-W3....-W127

application got R1 serviced, issue a new read. Queue is now:

W1-W2-W3....-W127-R2

So even with 0 read passover value, an application typically has to wait
for the total sum of writes in the queue. And this is what causes the
starvation. max_bomb_segments wasn't too good anyways, because in order
to get good latency you have to limit the sum of W1-W127 way too much
and then it starts to hurt write throughput really badly.

This is why the 2.4 io scheduler is fundamentally flawed from the read
latency view point. This is also why the 2.5 deadline io scheduler is
far superior in this area.

>> But when each request is large 512k it is pointless to allow the same
>> number of requests that we allow when the requests are 4k.

> A request of 512 kB will take about twice the time to service as a 4 kB
> request would take, assuming the disk does around 50 MB/s throughput.
> If you take one of those really modern disks Andre Hedrick has in his
> lab the difference gets even smaller.

I'll mention that for 2.5 the number of bytes that equals a full seek in
service time if called a stream_unit and is tweakable. Typically you are
looking at plain 40MiB/s and 8ms seek, so ~256-300KiB is more in the
normal range that 512KiB.

-- 
Jens Axboe

