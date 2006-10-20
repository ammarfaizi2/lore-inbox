Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWJTXaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWJTXaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWJTX37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:29:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48033 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750931AbWJTX36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:29:58 -0400
Date: Fri, 20 Oct 2006 16:28:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp,
       linux-arch@vger.kernel.org, schwidefsky@de.ibm.com,
       James.Bottomley@SteelEye.com
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061020225118.GA30965@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0610201625190.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
 <20061020214916.GA27810@linux-mips.org> <Pine.LNX.4.64.0610201500040.3962@g5.osdl.org>
 <20061020.152247.111203913.davem@davemloft.net> <20061020225118.GA30965@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Ralf Baechle wrote:
> 
> > My understanding is that this works because in Ralf's original patch
> > (which is the context in which he is removing the flush_cache_mm()
> > call), he uses kmap()/kunmap() to map the page(s) being accessed at a
> > kernel virtual address which will fall into the same cache color as
> > the user virtual address --> no alias problems.
> >
> > Since he does this for every page touched on the kernel side during
> > dup_mmap(), the existing flush_cache_mm() call in dup_mmap() does in
> > fact become redundant.
> 
> Correct.
> 
> It means no cache flush operation to deal with aliases at all left in
> fork and COW code.

Umm. That would seem to only happen to work for a direct-mapped virtually 
indexed cache where the index is taken purely from the virtual address, 
and there are no "process context" bits in the virtually indexed D$.

The moment there are process context bits involved, afaik you absolutely 
_need_ to flush, because otherwise the other process will never pick up 
the dirty state (which it would need to reload from memory).

That said, maybe nobody does that. Virtual caches are a total braindamage 
in the first place, so hopefully they have limited use.

		Linus
