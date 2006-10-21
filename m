Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992743AbWJUAGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992743AbWJUAGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992527AbWJUAGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:06:09 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:34764 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1030355AbWJUAGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:06:05 -0400
Date: Sat, 21 Oct 2006 01:06:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061021000609.GA32701@linux-mips.org>
References: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020214916.GA27810@linux-mips.org> <Pine.LNX.4.64.0610201500040.3962@g5.osdl.org> <20061020.152247.111203913.davem@davemloft.net> <20061020225118.GA30965@linux-mips.org> <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 04:28:37PM -0700, Linus Torvalds wrote:

> > > My understanding is that this works because in Ralf's original patch
> > > (which is the context in which he is removing the flush_cache_mm()
> > > call), he uses kmap()/kunmap() to map the page(s) being accessed at a
> > > kernel virtual address which will fall into the same cache color as
> > > the user virtual address --> no alias problems.
> > >
> > > Since he does this for every page touched on the kernel side during
> > > dup_mmap(), the existing flush_cache_mm() call in dup_mmap() does in
> > > fact become redundant.
> > 
> > Correct.
> > 
> > It means no cache flush operation to deal with aliases at all left in
> > fork and COW code.
> 
> Umm. That would seem to only happen to work for a direct-mapped virtually 
> indexed cache where the index is taken purely from the virtual address, 
> and there are no "process context" bits in the virtually indexed D$.

No MIPS processor has something like that.  See below.

> The moment there are process context bits involved, afaik you absolutely 
> _need_ to flush, because otherwise the other process will never pick up 
> the dirty state (which it would need to reload from memory).

Correct.

> That said, maybe nobody does that. Virtual caches are a total braindamage 
> in the first place, so hopefully they have limited use.

On MIPS we never had pure virtual caches.  The major variants in existence
are:

 o D-cache PIPT, I-cache PIPT
 o PIVT (no typo!)
   Only the R6000 has this and it's not supported by Linux.
 o D-cache VIPT, I-cache VIPT
   This is by far the most common on any MIPS designed since '91.
   A variant of these caches has hardware logic to detect cache aliases and
   fix them automatically and therefore is equivalent to PIPT even though
   they are not implemented as PIPT.  And obviously the alias replay of the
   pipe will cost a few cycles.  The R10000 family of SGI belongs into this
   class and the 24K/34K family of synthesizable cores by MIPS Technologies
   have this as a synthesis option.
   Another variant throws virtual coherency exceptions as I've explained in
   another thread.
 o D-cache PIPT, I-cache VIVT with additional address space tags.
 o Cacheless.  Not usually running Linux but heck, it's working anyway.

Be sure I'm sending a CPU designers a strong message about aliases.  And I
think they're slowly getting the message that kernel hackers like to poke
needles into voodoo dolls for aliases ;-)

  Ralf
