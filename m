Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314743AbSEKVH2>; Sat, 11 May 2002 17:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315165AbSEKVH1>; Sat, 11 May 2002 17:07:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15525 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314743AbSEKVH0>;
	Sat, 11 May 2002 17:07:26 -0400
To: Linus Torvalds <torvalds@transmeta.com>
cc: Larry McVoy <lm@bitmover.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56) 
In-Reply-To: Your message of Sat, 11 May 2002 11:56:17 PDT.
             <Pine.LNX.4.44.0205111141070.879-100000@home.transmeta.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21199.1021153373.1@us.ibm.com>
Date: Sat, 11 May 2002 14:42:53 -0700
Message-Id: <E176eeA-0005Vz-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205111141070.879-100000@home.transmeta.com>, > : Lin
us Torvalds writes:
> 
> 
> On Sat, 11 May 2002, Larry McVoy wrote:
> > On Sat, May 11, 2002 at 11:35:21AM -0700, Linus Torvalds wrote:
> > > See my details on doing the perfect zero-copy copy thing.
> > >
> > > The mmap doesn't actually touch the page tables - it ends up being nothing
> > > but a "placeholder".
> 
> I'll write up the implementation notes and you'll see what I'm talking
> about:
> 
>  - readahead(fd, offset, size)
> 
>    Obvious (except the readahead is free to ignore the size, it's just a
>    hint)

[...snip... lots of good ideas...]
 
I'm not sure this is quite the same problem that Oracle (and others)
typically used O_DIRECT for (not trying to be an apologist here, just
making sure the right problem gets solved)...

Most of what Oracle was managing with O_DIRECT was its "Shared Global
Area", which is usually a region of all possible memory that the OS
and other applications aren't using.  It uses that space like a giant
buffer cache.  Most of the IO's for OLTP applications were little
bitty random 2K IOs.  So, their ideal goal was to have the ability to
say here's a list of 10,000 random 2K IOs I want you to do really
quickly and spread them out at these spots within the SGS.  Those IOs
can be read asynchronously, but there needs to be some way to know when
the bits make it from disk to memory.  Think of it as something like
a big async readv, ideally with the buffer cache and as much of the OS
out of the way as possible.

When the SGA is "full" (memory pressure) they do big async, no buffer
cache, non-deferred writev's (by non deferred, I mean that the write
is actually scheduled for disk, not buffered in memory indefinitely -
they really believe they are done with those buffers).

Now the mmap( MAP_UNCACHED ) thing might work, except that this isn't
really a private mapping - it's a shared mapping.  So something like
tmpfs might be the answer, where the tmpfs had a property of being
uncached (in fact, Oracle would love it if that space were pinned into
memory/non-pageable/non-swappable).  That way the clients don't block
taking page faults and the server schedules activities to get the
greatest throughput (e.g. schedule clients who wouldn't block).

Unfortunately, tmpfs takes away the niceness of the VM optimizations,
I fear.

Oh, and Database DSS workloads (Decision Support, scan all disks looking
for needles in a big haystack) has different tradeoffs, mostly needing
to focus on lots of sequential IO where pre-fetching and reading, and
discard buffers immediately after use are the primary focus and write
performance is not critical.

gerrit
