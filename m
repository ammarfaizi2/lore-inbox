Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130403AbRBVWz6>; Thu, 22 Feb 2001 17:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130298AbRBVWzs>; Thu, 22 Feb 2001 17:55:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43307 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130141AbRBVWzh>; Thu, 22 Feb 2001 17:55:37 -0500
Date: Thu, 22 Feb 2001 23:57:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ll_rw_block/submit_bh and request limits
Message-ID: <20010222235700.B30330@athlon.random>
In-Reply-To: <20010222223811.A29372@athlon.random> <Pine.LNX.4.21.0102221832470.2401-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102221832470.2401-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 22, 2001 at 06:40:48PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 06:40:48PM -0200, Marcelo Tosatti wrote:
> You want to throttle IO if the amount of on flight data is higher than
> a given percentage of _main memory_. 
> 
> As far as I can see, your patch avoids each individual queue from being
> bigger than the high watermark (which is a percentage of main
> memory). However, you do not avoid multiple queues together from being
> bigger than the high watermark.

I of course see what you mean and I considered but I tend to believe that's a
minor issue and that most machines will be happier without the global unplug
even if without the global limit.

The only reason we added the limit of I/O in flight is to be allowed to have an
huge number of requests so we can do very large reordering and merges in the
elevator with seeking I/O (4k large IO request) _but_ still we don't have to
wait to lock in ram giga of pages before starting the I/O if the I/O was
contigous. We absolutely need such a sanity limit, it would be absolutely
unsane to wait kupdate to submit 10G of ram to a single harddisk before
unplugging on a 30G machine.

It doesn't need to be exactly "if we unplug not exactly after 1/3 of the global
ram is locked then performance sucks or the machine crashes or task gets
killed".  As Jens noticed sync_page_buffers will unplug the queue at some point
if we're low on ram anyways.

The limit just says "unplug after a rasonable limit, after it doesn't matter
anymore to try to delay requests for this harddisk, not matter if there are
still I/O requests available".

However if you have houndred of different queues doing I/O at the same time it
may make a difference, but probably with tons of harddisks you'll also have
tons of ram... In theory we could put a global limit on top of the the
per-queue one. Or we could at least upper bound the total_ram / 3.

Note that 2.4.0 as well doesn't enforce a global limit of packets in flight.
(while in 2.2 the limit is global as it has a shared pool of I/O requests).

Andrea
