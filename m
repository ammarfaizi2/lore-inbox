Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbSKPRZh>; Sat, 16 Nov 2002 12:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbSKPRZh>; Sat, 16 Nov 2002 12:25:37 -0500
Received: from [195.223.140.107] ([195.223.140.107]:48017 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267308AbSKPRZg>;
	Sat, 16 Nov 2002 12:25:36 -0500
Date: Sat, 16 Nov 2002 18:32:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Message-ID: <20021116173224.GG31697@dualathlon.random>
References: <200211161657.51357.m.c.p@wolk-project.de> <20021116165956.GF31697@dualathlon.random> <200211161810.23039.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211161810.23039.m.c.p@wolk-project.de>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 06:23:26PM +0100, Marc-Christian Petersen wrote:
> On Saturday 16 November 2002 17:59, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > Your pausing problem have little to do with the pausing fix, the problem
> > for you is the read latency, you're not triggering the race condition
> > fixed by the pausing fix so it can't make differences. One of the
> > foundamental obstacles to the read latency is the size of the I/O queue,
> > factor that is workarounded by the read-latency patch that basically
> > bypasses the size of the queue hiding the problem and in turn can't fix
> > the write latency with O_SYNC and the read latency during true read aio
> > etc...
> ok, after some further tests, I think this is _somewhat_ FS dependent. I tried 
> this with ext2, ext3 (no difference there) and also with ReiserFS and what 
> must I say, those "Pausings" caused be the write latency doing it with 
> ReiserFS are alot less than with ext2|ext3 but are still occuring.
> 
> There must went in something bullshitty into 2.4.19/2.4.20 that causes those 
> ugly things because 2.4.18 does not have that problem. This is still why I 
> don't use any kernels >2.4.18.
> 
> After changing elevator things like this:
> 
> root@codeman:[/] # elvtune /dev/hda
> 
> /dev/hda elevator ID            0
>         read_latency:           2048
>         write_latency:          1024
>         max_bomb_segments:      0
> 
> those "pausings" are less worse than before but are still there.
> NOTE: Write latency is lower than read latency (it's not a typo :)

you may want to try with this setting that helps with very slow devices:

	echo 2 500 0 0 500 3000 3 1 0 > /proc/sys/vm/bdflush

or also with my current default tuned for high performance:

	echo 50 500 0 0 500 3000 60 20 > /proc/sys/vm/bdflush

you may have too many dirty buffers around and you end running at disk
speed at every memory allocation, the first setting will decrease the
amount of dirty buffers dramatically, if you still have significant
slowdown with the first setting above, it's most probably only the usual
elevator issue.

Andrea
