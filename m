Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269800AbRHDFbN>; Sat, 4 Aug 2001 01:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269801AbRHDFbE>; Sat, 4 Aug 2001 01:31:04 -0400
Received: from [63.209.4.196] ([63.209.4.196]:31762 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269800AbRHDFa4> convert rfc822-to-8bit; Sat, 4 Aug 2001 01:30:56 -0400
Date: Fri, 3 Aug 2001 22:28:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108040055090.11200-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108032216350.1032-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id WAA22722
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001, Ben LaHaise wrote:
>
> > How about capping the number of requests to something sane, like 128? Then
> > the natural request allocation (together with the batching that we already
> > have) should work just dandy.
>
> This has other drawbacks that are quite serious: namely, the order in
> which io is submitted to the block layer is not anywhere close to optimal
> for getting useful amounts of work done.

Now this is true _whatever_ we do.

We all agree that we have to cap the thing somewhere, no?

Which means that we may be cutting off at a point where if we didn't cut
off, we could have merged better etc. So that problem we have regardless
of whether we could bhäs submitted to ll_rw_block() or we count requests
submitted to the actual IO layer.

The advantage off cutting off on a per-request basis is:

 - doing contiguous IO is "almost free" on most hardware today. So it's ok
   to allow a lot more IO if it's contiguous - because the cost of doing
   one request (even if large) is usually much lower than the cost of
   doing two (smaller) requests.

 - What we really want to do is to have a sliding window of active
   requests - enough to get reasonable elevator behaviour, and small
   enough to get reasonable latency. Again, for both of these, the
   "request" is the right entity - latency comes mostly from seeks (ie
   between request boundaries), and similarly the elevator obviously works
   on request boundaries too, not on "bh" boundaries.

Also, I doubt it makes all that much sense to change the number of queue
entries based on memory size. It probably makes more sense to scale the
number of requests by disk speed, for example.

[ Although there's almost certainly some amount of correlation - if you
  have 2GB of RAM, you probably have fast disks too. But not the linear
  function that we currently have. ]

>			  This situation only gets worse
> as more and more tasks find that they need to clean buffers in order to
> allocate memory, and start throwing more and more buffers from different
> tasks into the io queue (think what happens when two tasks are walking
> the dirty buffer lists locking buffers and then attempting to allocate a
> request which then delays one of the tasks).

Note that this really is a sitation we've had forever.

There are good reasons to believe that we should do a better job of
sorting the IO requests at a higher level in _addition_ to the low-level
elevator. Filesystems should strive to allocate blocks contiguously etc,
and we should strive to keep (and write out) the dirty lists etc in a
somewhat cronological order to take advantage of usually contiguous writes
(and maybe actively sort the dirty queue on writes that are _not_ going to
have good locality, like swapping).

		Linus

