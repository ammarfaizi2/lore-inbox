Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280424AbRJaTJA>; Wed, 31 Oct 2001 14:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280425AbRJaTIs>; Wed, 31 Oct 2001 14:08:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5905 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280424AbRJaTIi>; Wed, 31 Oct 2001 14:08:38 -0500
Date: Wed, 31 Oct 2001 11:06:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <3BE044A8.E91A4F01@zip.com.au>
Message-ID: <Pine.LNX.4.33.0110311059440.32727-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Andrew Morton wrote:
>
> But it's actually quite seductive to take a huge amount of data and
> just chuck it at the request layer and let Jens sort it out. This
> usually works well and keeps the complexity in one place.

Fair enough, I see your point. How would you suggest we handle the latency
thing, though?

I'm not against making the elevator more intelligent, and you have a
good argument. But I've very much against "allow the queues to grow with
no sense of latency".

> One does wonder whether everything is working as it should, though.
> Creating those 100,000 4k files is going to require writeout of
> how many blocks?  120,000?  And four minutes is enough time for
> 34,000 seven-millisecond seeks.  And ext2 is pretty good at laying
> things out contiguously.  These numbers don't gel.
>
> Ah-ha.  Look at the sync_inodes stuff:
>
> 	for (zillions of files) {
> 		filemap_fdatasync(file)
> 		filemap_fdatawait(file)
> 	}
>
> If we turn this into
>
> 	for (zillions of files)
> 		filemap_fdatasync(file)
> 	for (zillions of files)
> 		filemap_fdatawait(file)

Good catch, I bet you're right.

> kupdate runs this code path as well. Why is there any need for
> kupdate to wait on the writes?

At least historically (and I think it's still true in some cases),
kupdated was also in charge of trying to write out buffers under
low-memory circumstances. And without any throttling, blind writing can
make things worse.

However, the request throttle should be _plenty_ good enough, so I think
you're right.

Oh, one issue in case you're going to work on this: kupdated does need to
do the "wait_for_locked_buffers()" at some point, as that is also what
moves buffers from the locked list to the clean list. But that has nothing
to do with the fdatawait thing.

		Linus

