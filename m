Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318939AbSHTOsD>; Tue, 20 Aug 2002 10:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319006AbSHTOsD>; Tue, 20 Aug 2002 10:48:03 -0400
Received: from host-65-162-110-4.intense3d.com ([65.162.110.4]:60426 "EHLO
	exchusa03.intense3d.com") by vger.kernel.org with ESMTP
	id <S318939AbSHTOsC>; Tue, 20 Aug 2002 10:48:02 -0400
Message-ID: <23B25974812ED411B48200D0B774071701248AA8@exchusa03.intense3d.com>
From: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>,
       Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Alloc and lock down large amounts of memory
Date: Tue, 20 Aug 2002 09:51:58 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK. *AFAIK* most drivers that use DMA request the memory 
> allocation with
> GFP_DMA so that the allocators (whatever they chose) will give them
> DMAbale memory from the DMA memory zone. Memory from that 
> zone is fixed
> (not pagable). You can then map that memory into proccesses address
> space according to demand (and the Linux device drivers 
> second addition
> has a good example of doing that).
>
OK, understood.  
 
> Now, if I understood you correctly you want to allocate 256M of memroy
> and perform DMA into it? if so, you *cannot* use memory 
> allocated using
> vmalloc because the memory it supplies is virtual, that is it not
> contigous in physical memory but might be scattered all over the place
> and I doubt that whatever device you're DMAing from can handle that.
 
I was thinking a scatter gather page table would convert the virtual address
into physical addresses that DMA can use.

> Also, I think you don't want this memory to be swapable, because if it
> is swapped out and then in and might very well end up on a completly
> different address in physical memory from where it were and again, I
> don't think the device that does DMA will be able to handle that - all
> the ones I know require physical addresses (well actualy bus addresses
> but for the sake of argument let's ignore that for a second).
> 
> In short, I don't think you need what you think want... :-)

Gee, how did you guess?  :-) I was mistaken about who does the big 128M
alloc. 
The 128M will actually be malloced in user space and filled up with data in 
user space. This memory will then have to be mapped into kernel space and 
DMA performed. Before DMA is performed the memory obviously needs to be
locked 
down.  How does this play out with respect to DMA memory zone and GFP_DMA
flag, 
specifically pinning down memory?

Thanks Gilad!
 
> > 
> > Does the VM_RESERVED flag lock down the memory so that it 
> doesn't get paged out
> > during DMA?
> 
> AFAIK the VM_RESERVED flag will cause kswapd to ignore the page
> completly - no paging in or out at all.
> 
> > 
> > >
> > >
> > > >     Can 256M be allocated using vmalloc, if so is it swappable?
> > >
> > > It can be alloacted via vmalloc and AFAIK it is not swappable by
> > > default. This doesn't sound like a very good idea though.
> > 
> > Is there a good way to allocate large sums of memory in 
> Linux?  Doesn't have to
> > be
> > vmalloc but I don't think kmalloc, get_free_pages will work 
> for this purpose.  I
> > looked
> > into get_free_pages, but the largest order is 9 which 
> results in 512 pages.
> 
> > Does the memory allocated by vmalloc has visibility across 
> processes?
> 
> See my previous answer regarding why you don't vmalloced memory at
> visibility.
> 
> > I didn't mean shared memory.   If several processes open a 
> given device,
> > under normal conditions the data structure stays till the 
> last close at which
> > time a
> > release is done.   This depends on the usage or minor 
> number count.  Can there
> > be a case where the device exits before the processes 
> close?   In which case
> > the processes will be left hanging.    How is the close 
> handled if the driver is 
> > killed?
> 
> Very simple - you can't unload the device until the ref count says all
> the users (proccesses in thuis case) have closed it.
> 
> Gilad.
> 
> -- 
> Gilad Ben-Yossef <gilad@benyossef.com>
> http://benyossef.com
> 
> "Money talks, bullshit walks and GNU awks."
>   -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza
> 
