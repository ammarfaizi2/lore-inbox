Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135513AbRDZPVn>; Thu, 26 Apr 2001 11:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135516AbRDZPVe>; Thu, 26 Apr 2001 11:21:34 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:40910 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135513AbRDZPV3>; Thu, 26 Apr 2001 11:21:29 -0400
Message-ID: <3AE83CF0.9DBF702A@coplanar.net>
Date: Thu, 26 Apr 2001 11:21:21 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Block device strategy and requests
In-Reply-To: <20010426153815.B2101@sable.ox.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malcolm Beattie wrote:

> I'm designing a block device driver for a high performance disk
> subsystem with unusual characteristics. To what extent is the
> limited number of "struct request"s (128 by default) necessary for
> back-pressure? With this I/O subsystem it would be possible for the
> strategy function to rip the requests from the request list straight
> away, arrange for the I/Os to be done to/from the buffer_heads (with
> no additional state required) with no memory "leak". This would
> effectively mean that the only limit on the number of I/Os queued
> would be the number of buffer_heads allocated; not a fixed number of
> "struct request"s in flight. Is this reasonable or does any memory or
> resource balancing depend on the number of I/Os outstanding being
> bounded?
>
> Also, there is a lot of flexibility in how often interrupts are sent
> to mark the buffer_heads up-to-date. (With the requests pulled
> straight off the queue, the job of end_that_request_first() in doing
> the linked list updates and bh->b_end_io() callbacks would be done by
> the interrupt routine directly.) At one extreme, I could take an
> interrupt for each 4K block issued and mark it up-to-date very
> quickly making for very low-latency I/O but a very large interrupt
> rate when I/O throughput is high. The alternative would be to arrange
> for an interrupt every n buffer_heads (or based on some other
> criterion) and only take an interrupt and mark buffers up-to-date on

I believe it is common practice for this type of problem is to mix both
approaches:
Wait for a certain number of requests *OR* a timeout, whichever comes first.
Then, if there's not much IO, things are still guaranteed to be updated
reasonably
quickly.  If io is heavy,
then things will be updated in large chunks, becoming more efficient (fewer
interrupts) when it is needed most.

>
> each of those). Are there any rules of thumb on which is best or
> doesn't it matter too much?
>

