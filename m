Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbULHCLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbULHCLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbULHCLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:11:13 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:11221 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262005AbULHCJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:09:30 -0500
Date: Wed, 8 Dec 2004 03:09:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208020923.GG16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <1102470428.8095.29.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102470428.8095.29.camel@npiggin-nld.site>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 12:47:08PM +1100, Nick Piggin wrote:
> Buffered writes don't suffer the same problem obviously because the
> disk can can easily be kept fed from cache. Any read vs buffered write

This is true for very small buffered writes, which is the case for
desktop usage, but for more server oriented usage if the write isn't so
small, and you flush the writeback cache to disk very slowly, eventually
it will become a _sync_ write. So I agree that as long as the write
doesn't become synchronous "as" provides better behaviour.

One hidden side effect of "as" is that by writing so slowly (and
64KiB/sec really is slow), it increases the time it will take for a
dirty page to be flushed to disk (with tons of ram and lot of continous
readers I wouldn't be surprised if it could take hours for the data to
hit disk in an artificial testcase, you can do the math and find how
long it would take to the last page in the list to hit disk at
64KiB/sec).

> starvation you see will mainly be due to the /sys tunables that give
> more priority to reads (which isn't a bad idea, generally).

sure.

> Maybe. CFQ may be a bit closer to a traditional elevator behaviour,
> while AS uses some significantly different concepts which I guess
> aren't as well tested and optimised for.

It's already the best for desktop usage (even the 64KiB/sec is the best
on desktop), but as you said above it uses significantly different
concepts and that makes it by definition not general purpose (and
definitely a no-way for database, while cfq isn't a no-way on the
desktop).
