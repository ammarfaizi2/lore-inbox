Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSHUFXR>; Wed, 21 Aug 2002 01:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSHUFXR>; Wed, 21 Aug 2002 01:23:17 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:25241 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317864AbSHUFXP>; Wed, 21 Aug 2002 01:23:15 -0400
Subject: RE: Alloc and lock down large amounts of memory
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <23B25974812ED411B48200D0B774071701248AA8@exchusa03.intense3d.com>
References: <23B25974812ED411B48200D0B774071701248AA8@exchusa03.intense3d.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Aug 2002 08:27:12 +0300
Message-Id: <1029907633.19202.21.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 17:51, Bhavana Nagendra wrote:

I think a  disclaimer is due before we begin - I'm not Linux drivers
guru not do i play one of TV. Take all of this with the apropriate grain
of salt. Actually, make that a spoon of salt :-)

> > Now, if I understood you correctly you want to allocate 256M of memroy
> > and perform DMA into it? if so, you *cannot* use memory 
> > allocated using
> > vmalloc because the memory it supplies is virtual, that is it not
> > contigous in physical memory but might be scattered all over the place
> > and I doubt that whatever device you're DMAing from can handle that.
>  
> I was thinking a scatter gather page table would convert the virtual address
> into physical addresses that DMA can use.


Scatter gather solves the need for contigous physical memory space
problem.

BUT AFAIK scatter gather works *if you're device supports it*. Either
support it (or the machine) has 'virtual bus addresses' or it can take
the buffers it needs to proccess in several seperate chunks. Does it?

According to my limited understanding you can set the page reserved one
page at a time, DMA it and then unset the reserved bit again, *but* - a.
it might mean very long latencies/jitter to transfer the buffer and your
device must DMA from various high regions of memory. AFAIK most
devices/boards have very specific limitations on what can be transfered
via DMA.

Reserving the entire 256M in one go sounds... dangerous to me :-) I'm no
VM guru but I doubt that it's a good idea unless you ave gobs and gobs
of free physical pages available.

> 
> > Also, I think you don't want this memory to be swapable, because if it
> > is swapped out and then in and might very well end up on a completly
> > different address in physical memory from where it were and again, I
> > don't think the device that does DMA will be able to handle that - all
> > the ones I know require physical addresses (well actualy bus addresses
> > but for the sake of argument let's ignore that for a second).
> > 
> > In short, I don't think you need what you think want... :-)
> 
> Gee, how did you guess?  :-) I was mistaken about who does the big 128M
> alloc. 
> The 128M will actually be malloced in user space and filled up with data in 
> user space. This memory will then have to be mapped into kernel space and 
> DMA performed. Before DMA is performed the memory obviously needs to be
> locked 
> down.  How does this play out with respect to DMA memory zone and GFP_DMA
> flag, 
> specifically pinning down memory?


Look, all memory allocations in user space are nothing more then doing
mmap on some file. malloc(), shat() or what have you - in the end they
all do the same - request the kernel to add some entries to the proccess
page table. The true allocation occurs in kernel space, whether when the
proccess request it or more usually in response to a page fault. But
regardless of which it's something in the kernel anyways that needs to
find and secure those physical pages for you. 

You have some serious strict limit on *what* memory you can get. You
might need it be contigous if your device cannot do scatter gather, it
needs to come from a memory area that the device can actually DMA and I
think you might even need to map these pages unto kernel address space,
which in cae of HIGHMEM areas might not be so easy as kmap slots are
scarce.

As other people have noted, the best bet is early allocation. The *best*
way to do it is via kernel interfaces but as noted before sometimes the
simplest thing is to tell the kernel at boot time (or equivilient) that
you  have less memory then the machine actually has and simply map that
later. It's crude, but it works and on some embedded device it might be
the simplest option when the client refuses to recieve ANY changes to
the kernel sources used.

Good luck,
Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

