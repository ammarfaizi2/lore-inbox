Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316260AbSEKS43>; Sat, 11 May 2002 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316261AbSEKS42>; Sat, 11 May 2002 14:56:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23308 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316260AbSEKS41>; Sat, 11 May 2002 14:56:27 -0400
Date: Sat, 11 May 2002 11:56:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Gerrit Huizenga <gh@us.ibm.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
 IDE 56)
In-Reply-To: <20020511113710.C30126@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0205111141070.879-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 May 2002, Larry McVoy wrote:
> On Sat, May 11, 2002 at 11:35:21AM -0700, Linus Torvalds wrote:
> > See my details on doing the perfect zero-copy copy thing.
> >
> > The mmap doesn't actually touch the page tables - it ends up being nothing
> > but a "placeholder".
>
> Huh, I must have missed something, does the mmap() not create any page
> tables at all?

It can. But go down to the end in my first explanation to see why it
doesn't have to.

I'll write up the implementation notes and you'll see what I'm talking
about:

 - readahead(fd, offset, size)

   Obvious (except the readahead is free to ignore the size, it's just a
   hint)

 - mmap( MAP_UNCACHED )

   This only sets up the "vma" descriptor (like all other MMAP's). It's
   exactly like a regular private mapping, except instead of just
   incrementing the page count on a page-in, it will look at whether the
   page can just be removed from the page cache and inserted as a private
   page into the mapping ("stealing" the page).

 - fdatasync_area( fd, offset, len)

   Obvious. It's fdatasync, except it only guarantees the specific range.

 - mwrite(fd, addr, len)

   This is really does the "reverse" of mmap(MAP_UNCACHED) (and like a
   mapping, addr/len have to be page-aligned).

   This walks the page tables, and does the _smart_ thing:

    - if no mapping exists, it looks at the backing store of the vma,
      and gets the page directly from the backing store instead of
      bothering to populate the page tables.

    - if the mapped page exists, it removes it from the page table

    - in either case, it moves the page it got into the page cache of the
      destination file descriptor.

NOTE on zero-copy / no-page-fault behaviour:
 - mwrite has to walk the page tables _anyway_ (the same as O_DIRECT),
   since that's the only way to do zero-copy.
 - since mwrite has to do that part, it's trivial to notice that the page
   tables don't exist. In fact, it's a very natural result of the whole
   algorithm.
 - if user space doesn't touch the mapping itself in any way (other than
   point mwrite() at it), you never build up any page tables at all, and
   you never even need to touch the TLB (ie no flushes, no nothing).
 - note how even "mmap( MAP_UNCACHED )" doesn't actually touch the TLB or
   the page tables (unless it uses MAP_FIXED and you use it to unmap a
   previous area, of course - that's all in the normal mmap code already)

See?

I will _guarantee_ that this is more efficient than any O_DIRECT ever was,
and it will get very close to your "optimal" thing (it does need to look
at some page tables, but since the page tables haven't ever really needed
to be built up for the pure copy case, it will be able to decide that the
page isn't there from the top-level page table if you align the virtual
area properly - ie at 4MB boundaries on an x86).

I suspect that this is about a few hundred lines of code (and a lot of
testing). And you can emulate O_DIRECT behaviour with it, along with
splice (only for page-cache entities, though), and a lot of other
off-by-one uses.

			Linus

