Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278737AbRJaQRi>; Wed, 31 Oct 2001 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280220AbRJaQR2>; Wed, 31 Oct 2001 11:17:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278737AbRJaQRQ>; Wed, 31 Oct 2001 11:17:16 -0500
Date: Wed, 31 Oct 2001 08:15:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.14-pre6
Message-ID: <Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <3BDFBFF5.9F54B938@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>
>Appended here is a program which creates 100,000 small files.
>Using ext2 on -pre5.  We see how long it takes to run
>
>	(make-many-files ; sync)
>
>For several values of queue_nr_requests:
>
>queue_nr_requests:	128	8192	32768
>execution time:		4:43	3:25	3:20
>
>Almost all of the execution time is in the `sync'.

Hmm..  I don't consider "sync" to be a benchmark, and one of the things
that made me limit the queue size was in fact that Linux in the
timeframe before roughly 2.4.7 or so was _completely_ unresponsive when
you did a big "untar" followed by a "sync".

I'd rather have a machine where I don't even much notice the sync than
one where a made-up-load and a "sync" that servers no purpose shows
lower throughput.

Do you actually have any real load that cares?

>By restricting the number of requests in flight to 128 we're
>giving new requests only a very small chance of getting merged with
>an existing request.  More seeking.

If you can come up with alternatives that do not suck from a latency
standpoint, I'm open to ideas.

However, having tested the -ac approach, I know from personal experience
that it's just way too easy to find behaviour with so horrible latency
on a 2GB machine that it's not in the _least_ funny.

Making the elevator heavily favour reads over writes might be ok enough
to make the long queues even an option but:

>OK, not an interesting workload.  But I suspect that there are real
>workloads which will be bitten by this.
>
>Why is the queue length so tiny now?  Latency?  If so, couldn't this
>be addressed by giving reads higher priority versus writes?

It's a write-write latency thing too, but that's probably not as strong an
argument.

Trivial example: do the above thing at the same time you have a mail agent
open that does a "fsync()" on its mail store (and depending on your mail
agent and your mail folder layout, you may have quite a lot of small
fsyncs going on).

I don't know about you, but I start up mail agents a _lot_ more often
than I do "sync". And I'd rather do "sync &" than have bad interactive
performance from the mail agent.

I'm not against making the queues larger, but on the other hand I see so
many _better_ approaches that I would rather people spent some effort on,
for example, making the dirty list itself be more ordered.

We have actually talked about some higher-level ordering of the dirty list
for at least five years, but nobody has ever done it. And I bet you $5
that you'll get (a) better throughput than by making the queues longer and
(b) you'll have fine latency while you write and (c) that you want to
order the write-queue anyway for filesystems that care about ordering.

So yes, making the queue longer is an "easy" solution, but if it then
leads to complex problems like how to make an elevator that is guaranteed
to not have bad latency behaviour, I actually think that doing some (even
just fairly rudimentary) ordering of the write queue ends up being easier
_and_ more effective.

		Linus

