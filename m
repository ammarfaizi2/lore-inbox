Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSAPTbQ>; Wed, 16 Jan 2002 14:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287177AbSAPTbJ>; Wed, 16 Jan 2002 14:31:09 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:46342 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287155AbSAPTal>; Wed, 16 Jan 2002 14:30:41 -0500
Date: Wed, 16 Jan 2002 14:30:39 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: pte-highmem-5
Message-ID: <20020116143039.C12216@redhat.com>
In-Reply-To: <20020116185814.I22791@athlon.random> <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 16, 2002 at 10:19:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 10:19:56AM -0800, Linus Torvalds wrote:
>  - please don't do that "pte_offset_atomic_irq()" have special support in
>    the header files: it is _not_ a generic operation, and it is only used
>    by the x86 page fault logic. For that reason, I would suggest moving
>    all that logic out of the header files, and into i386/mm/fault.c,
>    something along the lines of
> 
> 	pte = pte_offset_nokmap(..)
> 	addr = kmap_atomic(pte, KM_VMFAULT);
> 
>    instead of having special magic logic in the header files.

Ah, here's where I come in and say that kmap_atomic stinks and needs to be 
replaced. ;-)  If you take a look at code in various places making use of 
atomic kmaps, some of the more interesting cases (like bio) have to disable 
irqs during memory copies in order to avoid races on reuse of an atomic 
kmap.  I think that's a sign of an interface that needs redesign.  My 
proposal: make kmap_atomic more like kmap in that it allocates from a pool, 
but make the pool per cpu with ~4 entries reserved per context.  The only 
concern I have is that we might not be restricting the depth of irq entry 
currently, but I'm not familiar with that code.  Time to code up a patch...

> Other than that it looks fairly straightforward, I think.

Agreed.

		-ben
