Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSAPTtq>; Wed, 16 Jan 2002 14:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSAPTth>; Wed, 16 Jan 2002 14:49:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6184 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287368AbSAPTt0>; Wed, 16 Jan 2002 14:49:26 -0500
Date: Wed, 16 Jan 2002 20:50:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: pte-highmem-5
Message-ID: <20020116205003.D3113@athlon.random>
In-Reply-To: <20020116185814.I22791@athlon.random> <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com> <20020116143039.C12216@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020116143039.C12216@redhat.com>; from bcrl@redhat.com on Wed, Jan 16, 2002 at 02:30:39PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 02:30:39PM -0500, Benjamin LaHaise wrote:
> On Wed, Jan 16, 2002 at 10:19:56AM -0800, Linus Torvalds wrote:
> >  - please don't do that "pte_offset_atomic_irq()" have special support in
> >    the header files: it is _not_ a generic operation, and it is only used
> >    by the x86 page fault logic. For that reason, I would suggest moving
> >    all that logic out of the header files, and into i386/mm/fault.c,
> >    something along the lines of
> > 
> > 	pte = pte_offset_nokmap(..)
> > 	addr = kmap_atomic(pte, KM_VMFAULT);
> > 
> >    instead of having special magic logic in the header files.
> 
> Ah, here's where I come in and say that kmap_atomic stinks and needs to be 
> replaced. ;-)  If you take a look at code in various places making use of 
> atomic kmaps, some of the more interesting cases (like bio) have to disable 
> irqs during memory copies in order to avoid races on reuse of an atomic 
> kmap.  I think that's a sign of an interface that needs redesign.  My 
> proposal: make kmap_atomic more like kmap in that it allocates from a pool, 
> but make the pool per cpu with ~4 entries reserved per context.  The only 
> concern I have is that we might not be restricting the depth of irq entry 
> currently, but I'm not familiar with that code.  Time to code up a patch...

you said it, there's no depth of irq entry points (only restriction
right now is the stack and if you overflow you notice the hard way :). I
think current way of doing the atomic kmaps is ok even if I see the
irq latency issue with the cli, we could probably make one irq entry
non-cli driven by protecting it with a per-cpu counter etc... (so only the
nested irq will have to take the cli), that could be an improvement for
irq latency, feel free to implement it. the pool approch with the pool
as large as the max number of reentrant irq doesn't sounds a good
approch to me instead. If you really want to make something like a pool,
then I'd just extend the same logic where even the first nested irq
doesn't need to take the cli, but only the second nested one needs.
There could be a #define that tells which is the last level of nested
irq that needs to take the cli instead of having a free kmap.

btw, In the pte_offset_atomic_irq case I was also too lazy to cli only
if it was an highmem page, because that's an extremely slow path
anyways, so a cli there doesn't really matter, at least with the bio
stuff I made sure we have the cli only with highmem pages by hiding it
inside.

> 
> > Other than that it looks fairly straightforward, I think.
> 
> Agreed.

Good to hear! thanks,

Andrea
