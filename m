Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSD2Nfw>; Mon, 29 Apr 2002 09:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSD2Nfu>; Mon, 29 Apr 2002 09:35:50 -0400
Received: from [195.223.140.120] ([195.223.140.120]:15888 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312687AbSD2Net>; Mon, 29 Apr 2002 09:34:49 -0400
Date: Mon, 29 Apr 2002 15:35:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020429153500.B28887@dualathlon.random>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 12:10:20AM +0200, Daniel Phillips wrote:
> On Friday 26 April 2002 20:27, Russell King wrote:
> > Hi,
> > 
> > I've been looking at some of the ARM discontigmem implementations, and
> > have come across a nasty bug.  To illustrate this, I'm going to take
> > part of the generic kernel, and use the Alpha implementation to
> > illustrate the problem we're facing on ARM.
> > 
> > I'm going to argue here that virt_to_page() can, in the discontigmem
> > case, produce rather a nasty bug when used with non-direct mapped
> > kernel memory arguments.
> 
> It's tough to follow, even when you know the code.  While cooking my
> config_nonlinear patch I noticed the line you're concerned about and
> regarded it with deep suspicion.  My patch does this:
> 
> -               page = virt_to_page(__va(phys_addr));
> +               page = phys_to_page(phys_addr);
> 
> And of course took care that phys_to_page does the right thing in all
> cases.

The problem remains the same also going from phys to page, the problem
is that it's not a contigous mem_map and it choked when the phys addr
was above the max ram physaddr. The patch I posted a few days ago will
fix it (modulo for ununused ram space, but attempting to map into the
address space unused ram space is a bug in the first place).

> 
> <plug>
> The new config_nonlinear was designed as a cleaner, more powerful
> replacement for all non-numa uses of config_discontigmem.
> </plug>

I maybe wrong because I only had a short look at it so far, but the
"non-numa" is what I noticed too and that's what renders it not a very
interesting option IMHO. Most discontigmem needs numa too. If it cannot
handle numa it doesn't worth to add the complexity there, with numa we
must view those chunks differently, not linearly. Also there's nothing
magic that says mem_map must have a magical meaning, doesn't worth to
preserve the mem_map thing, virt_to_page is a much cleaner abstraction
than doing mem_map + pfn by hand.

Andrea
