Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSCMRbk>; Wed, 13 Mar 2002 12:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310869AbSCMRba>; Wed, 13 Mar 2002 12:31:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62212 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293680AbSCMRbQ>; Wed, 13 Mar 2002 12:31:16 -0500
Date: Wed, 13 Mar 2002 09:17:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: bert hubert <ahu@ds9a.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ide filters / 'ide dump' / 'bio dump'
In-Reply-To: <3C8F25BE.9040000@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203130910420.29865-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Mar 2002, Jeff Garzik wrote:
> bert hubert wrote:
>
> ># biodump /dev/hda
> >09:09:33.023 READ block 12345 [10 blocks]
> >09:09:33.024 READ block 12355 [10 blocks]
> >09:09:33.025 READ block 12365 [10 blocks]
> >09:09:34.000 WRITE block 12345 [1 block]
>
> Definitely an interesting idea...   With this new stuff Linus talked
> about in his proposal and what I'm thinking about, it shouldn't be too
> hard to do.

Note that I actually think we're talking about two different things.

There's the notion of _feeding_ special requests onto the request queue
through some interface that also can refuse to feed certain kinds of
requests. That is needed for the special commands, and is "above" the
requests queue layer.

That interface doesn't really support filtering of requests that other
people (notably the regular kernel itself) is also feeding to the request
queue.

Note that one of the big issues with the request queue is that it acts as
a funnel: it (very much by design) can, and does, take requests from
different places, and nobody needs to "own" the request queue. But the
kind of "feed this raw request down" module that has been talked about
would have absolutely _zero_ visibility into what others are feeding into
the request queue.

If you actually want to filter other peoples requests, then you have to do
something completely different, namely set up a request queue of your own,
then exporting _your_ request queue as the request queue for <major,minor>
and then taking the requests off that queue internally, and moving them to
the original queue after you've done filtering.

Basically a simplified "loopback" thing that doesn't even need to do any
remapping.

The two are totally independent, they work on requests queues at different
levels (one feeds some random request queue, the other changes how we look
up a request queue and inserts its own queue in between).

			Linus

