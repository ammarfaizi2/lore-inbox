Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268323AbRHDFNV>; Sat, 4 Aug 2001 01:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269797AbRHDFNK>; Sat, 4 Aug 2001 01:13:10 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:58461 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S268323AbRHDFNA>; Sat, 4 Aug 2001 01:13:00 -0400
Date: Sat, 4 Aug 2001 01:13:04 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032141370.894-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108040055090.11200-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Linus Torvalds wrote:

> [ Quick grep later ]
>
> On my 1GB machine, we apparently allocate 1792 requests for _each_ queue.
> Considering that a single request can have hundreds of buffers allocated
> to it, that is just _ridiculous_.

> How about capping the number of requests to something sane, like 128? Then
> the natural request allocation (together with the batching that we already
> have) should work just dandy.

This has other drawbacks that are quite serious: namely, the order in
which io is submitted to the block layer is not anywhere close to optimal
for getting useful amounts of work done.  This situation only gets worse
as more and more tasks find that they need to clean buffers in order to
allocate memory, and start throwing more and more buffers from different
tasks into the io queue (think what happens when two tasks are walking
the dirty buffer lists locking buffers and then attempting to allocate a
request which then delays one of the tasks).

> Ben, willing to do some quick benchmarks?

Within reason.  I'm actually heading to bed now, so it'll have to wait
until tomorrow, but it is fairly trivial to reproduce by dd'ing to an 8GB
non-sparse file.  Also, duplicating a huge file will show similar
breakdown under load.  Cheers,

		-ben

