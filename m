Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUC1UfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUC1Uea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:34:30 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:23729 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262461AbUC1UdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:33:20 -0500
Date: Sun, 28 Mar 2004 13:33:57 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328203357.GB6405@bounceswoosh.org>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	"Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org> <40667734.8090203@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40667734.8090203@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 at 16:56, Nick Piggin wrote:
>Eric D. Mudama wrote:
>>32-MB requests are the best for raw throughput.
>>
>>~15ms to land at your target location, then pure 50-60MB/sec for the .5
>>seconds it takes to finish the operation. (media limited at that point)
>>
>>Sure, there's more latency, but I guess that is application dependant.
>>
>
>What about a queue depth of 2, and writing that 32MB in 1MB requests?

I'm 99% sure that it'll wind up slower... The concept of "ZLR - zero
latency read?" where they start reading immediately wherever they
land, then merge that into the host request later, possibly catching
the front of the command at the very end can help.  However, if you
issue those 32 tags immediately, there's the chance that the drive
won't recognize the pattern as quickly, and wind up doing additional
seeks, or even worse, additional, unnecessary dwell...  In queueing,
you could wind up caching data on the back end of 32 host requests
without the first LBA in cache for any of them, which means you can't
start those data transfers until you've read a "first LBA", meaning
you now need to discard something you've intentionally read from the
media.

The kicker when handling any request larger than the on-disk cache
size combined with queueing is that you don't know ahead of time if
you'll be able to satisfy the request by the time you get there.  If
the drive was already holding megabytes 4-5 in cache, that works
pretty well as it'll be an instant cache hit, however, if you were
holding megabytes 4-4.99, there's a chance you will have had to
discard some of that data to make room for other in-process disk work
(say you had a buffer almost full of dirty writes and therefore
insufficient buffer for the entire host request), which means you may
need to toss megabytes 4.5-4.99 out, in which case you'll need to do
the disk I/O anyway.  In that case, starting at the beginning of the
entire region and just tossing from cache as you transfer to the host
works a lot better.

On a large sequential access, the odds of a cache hit into that
sequential area is minimal in practice, so we can actually just churn
the same small chunk of buffer satisfying the large read, while not
losing any efficiency due to having 6.5MB of dirty random writes ready
to go on the back end.

A 32-MB op by definition cannot be atomic with an 8MB DRAM on the
drive, so once we give up that idea, we optimize our buffer usage for
maximum cache efficiency and granularity.  (Basically, if the drive
reports a hard error writing a 32MB request, you need to assume the
entire 32MB request needs to be reissued.  You can't assume that just
because the error was on the last block, that you can "trust" that the
first LBA of the request actually made it.)

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

