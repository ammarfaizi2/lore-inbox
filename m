Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSHBTao>; Fri, 2 Aug 2002 15:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSHBTao>; Fri, 2 Aug 2002 15:30:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25873 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316900AbSHBTan>; Fri, 2 Aug 2002 15:30:43 -0400
Date: Fri, 2 Aug 2002 12:34:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <E17ahdi-0001RC-00@w-gerrit2>
Message-ID: <Pine.LNX.4.33.0208021219160.2229-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ linux-kernel cc'd, simply because I don't want to write the same thing 
  over and over again ]

[ Executive summary: the current large-page-patch is nothing but a magic 
  interface to the TLB. Don't view it as anything else, or you'll just be
  confused by all the smoke and mirrors. ]

On Fri, 2 Aug 2002, Gerrit Huizenga wrote:
> > Because _none_ of the large-page codepaths are shared with _any_ of the
> > normal cases.
> 
> Isn't that currently an implementation detail?

Yes and no.

We may well expand the FS layer to bigger pages, but "bigger" is almost
certainly not going to include things like 256MB pages - if for no other
reason than the fact that memory fragmentation really means that the limit
on page sizes in practice is somewhere around 128kB for any reasonable
usage patterns even with gigabytes of RAM. 

And _maybe_ we might get to the single-digit megabytes. I doubt it, simply
because even with a good buddy allocator and a memory manager that
actively frees pages to get large contiguous chunks of RAM, it's basically
impossible to have something that can reliably give you that big chunks
without making normal performance go totally down the toiled.

(Yeah, once you have terabytes of memory, that worry probably ends up
largely going away. I don't think that is going to be a common enough
platform for Linux to care about in the next ten years, though).

So there are implementation issues, yes. In particular, there _is_ a push 
for larger pages in the FS and generic MM layers too, but the issues there 
are very different and have no basically no generality with the TLB and 
page table mapping issues of the current push.

What this VM/VFS push means is that we may actually have a _different_ 
"large page" support on that level, where the most likely implementation 
is that the "struct address_space" will at some point have a new member 
that specifies the "page allocation order" for that address space. This 
will allow us to do per-file allocations, so that some files (or some 
filesystems) migth want to do all IO in 64kB chunks, and they'd just make 
the address_space specify a page allocation order that matches that.

This is in fact one of the reasons I explicitly _want_ to keep the
interfaces separate - because there are two totally different issues at
play, and I suspect that we'll end up implementing _both_ of them, but
that they will _still_ have no commonalities.

The current largepage patch is really nothing but an interface to the TLB.  
Please view it as that - a direct TLB interface that has zero impact on
the VFS or VM layers, and that is meant _purely_ as a way to expose hw 
capabilities to the few applications that really really want them.

The important thing to take away from this is that _even_ if we could
change the FS and VM layers to know about a per-address_space variable-
sized PAGE_CACHE_SIZE (which I think it the long-term goal), that doesn't 
impact the fact that we _also_ want to have the TLB interface. 

Maybe the largepage patch could be improved upon by just renaming it, and
making clear that it's a "TLB_hugepage" thing. That's what a CPU designer
thinks of when you say "largepage" to him. Some of the confusion is 
probably because a VM/FS person in an OS group does _not_ necessarily 
think the same way, but thinks about doing big-granularity IO.

			Linus

