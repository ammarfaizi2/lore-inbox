Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268129AbRHUD1W>; Mon, 20 Aug 2001 23:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268702AbRHUD1M>; Mon, 20 Aug 2001 23:27:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20742 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268129AbRHUD1C>; Mon, 20 Aug 2001 23:27:02 -0400
Date: Mon, 20 Aug 2001 22:58:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mark Hemment <markhe@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswap spinning
In-Reply-To: <Pine.LNX.4.21.0108200706330.32519-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0108202257470.538-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Aug 2001, Marcelo Tosatti wrote:

> 
> 
> On Sat, 18 Aug 2001, Mark Hemment wrote:
> 
> > Hi,
> > 
> >   Jumping from 2.4.7 to 2.4.9 has shown up a problem with the VM balancing
> > code.
> >   Under load, I've seen kswapd become a CPU hog (on a 5GB box).  Now that
> > I've got a theory, I cannot reproduce the problem for confirmation, but
> > here is the theory anyway.
> > 
> >   The tests in free_shortage() and inactive_shortage() assume that the
> > memory state for a zone can be improved by calling refill_inactive_scan(),
> > page_launder(), the inode/dcache shrinking functions, and the general
> > slab-cache reaping func.  Usually, some combination of the reaping
> > functions will improve a zone's state - but not always.
> > 
> >   The problem is the DMA zone.  As it is (relatively) small on some archs
> > (IA-32 for example), it is possible that almost all pages from this zone
> > are being used by a sub-systems which simply won't give them up.  Examples
> > of use are; vmalloc()ed page for modules, pre-allocated socket buffs
> > for NICs, task-structs/kernel-stack - you get the idea.
> > 
> >   In the case I believe I'm seeing, both free_shortage() and
> > inactive_shortage() are returning a shortage for the DMA zone which
> > triggers all the work in do_try_to_free_pages().  But as there aren't any
> > DMA pages left in the page-cache, being used as anonymous pages, or being
> > used in the other places the code looks, do_try_to_free_pages() returns
> > non-zero to kswapd() and off we go again.  This also causes callers of
> > try_to_free_pages() (from __alloc_pages()) to suck CPU cycles as well.
> > 
> >   On HIGHMEM boxes, it is possible for the NORMAL zone to get into the
> > same state (although v unlikely).
> > 
> >   I'd rather not get into having specialist code in mm/vmscan.c (or arch
> > specific code) to handle a small DMA zone - so what are the other
> > solutions?  (Assuming the above theory holds true.)
> > 
> >   One possible solution is not to give DMA memory out, except for;
> > 	o explicit DMA allocations
> > 	o page-cache, anonymous page, allocations
> > assuming explicit DMA allocations are low, we'll at least know the
> > remaining DMA pages are somewhere we can get at them - would need to be
> > trigger by an arch specific flag for those that don't have a "tiny" zone.
> > However, I don't like this, feels like fixing the wrong problem. :(
> 
> The DMA zone problem _can_ happen, but it should also happen with 2.4.7 I
> think. (I'm not completly sure, though. Maybe Linus changes to
> try_to_free_pages() are the reason...)
> 
> Lets first find out the actual problem.
> 
> Could you please boot with profile=2 and use readprofile to find out where
> kswapd is spending its time? 

Well, I've just noted Linus made kswapd loop as long as there is any kind
(inactive or free) shortage.

I guess that is the reason. 

