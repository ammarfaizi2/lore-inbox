Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSL3AYO>; Sun, 29 Dec 2002 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSL3AYO>; Sun, 29 Dec 2002 19:24:14 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:11823 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S262492AbSL3AYL>;
	Sun, 29 Dec 2002 19:24:11 -0500
Date: Sun, 29 Dec 2002 19:51:07 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
Message-ID: <20021230005107.GA25318@lnuxlab.ath.cx>
References: <20021229202610.GA24554@lnuxlab.ath.cx> <3E0F5E2C.70F7D112@digeo.com> <20021229233236.GA25035@lnuxlab.ath.cx> <3E0F8B4C.568C018C@digeo.com> <20021230002604.GA25134@lnuxlab.ath.cx> <3E0F8EF6.3C264886@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0F8EF6.3C264886@digeo.com>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 04:10:30PM -0800, Andrew Morton wrote:
> khromy wrote:
> > 
> > On Sun, Dec 29, 2002 at 03:54:52PM -0800, Andrew Morton wrote:
> > > khromy wrote:
> > > >
> > > > On Sun, Dec 29, 2002 at 12:42:20PM -0800, Andrew Morton wrote:
> > > > > khromy wrote:
> > > > > >
> > > > > > Running 2.5.53-mm3, I found the following in dmesg.  I don't remember
> > > > > > getting anything like this with 2.5.53-mm3.
> > > > > >
> > > > > > xmms: page allocation failure. order:5, mode:0x20
> > > > >
> > > > > gack.  Someone is requesting 128k of memory with GFP_ATOMIC.  It fell
> > > > > afoul of the reduced memory reserves.  It deserved to.
> > > > >
> > > > > Could you please add this patch, and make sure that you have set
> > > > > CONFIG_KALLSYMS=y?  This will find the culprit.
> > > >
> > > > XFree86: page allocation failure. order:0, mode:0xd0
> > > > Call Trace:
> > > >  [<c012a3dd>] __alloc_pages+0x255/0x264
> > > >  [<c012a414>] __get_free_pages+0x28/0x60
> > > >  [<c012c7e6>] cache_grow+0xb6/0x20c
> > > >  [<c012c9cf>] __cache_alloc_refill+0x93/0x220
> > > >  [<c012cb96>] cache_alloc_refill+0x3a/0x58
> > > >  [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
> > > >  [<c017e36c>] journal_alloc_journal_head+0x10/0x68
> > > >  [<c017e458>] journal_add_journal_head+0x80/0x120
> > >
> > > oops, sorry.  They're all expected.  I'd like to know where
> > > the 5-order failure during xmms usage came from.  Were you
> > > using a CDROM at the time??
> > 
> > Nope, playing mp3s from a harddrive.  I can reproduce it by doing some
> > IO or compiling something and then switching back and forth through
> > workspaces really fast at the same time..
> 
> Ah.  Well could you please add the second patch?  That'll find the source.

It didn't apply ontop of the one that you sent earlier so I compiled
with only the second one..

I got this while applying the second one:
patching file mm/page_alloc.c
Hunk #1 succeeded at 572 (offset 25 lines).

And here is dmesg:

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

xmms: page allocation failure. order:5, mode:0x20
Call Trace:
 [<c012a3e7>] __alloc_pages+0x25f/0x26c
 [<c012a41c>] __get_free_pages+0x28/0x60
 [<c010e36e>] dma_alloc_coherent+0x3e/0x74
 [<c021c8ba>] prog_dmabuf+0x7e/0x2b4
 [<c021c31d>] set_dac2_rate+0xb5/0xe0
 [<c021f01d>] es1371_ioctl+0x10d5/0x140c
 [<c012d228>] kmem_cache_free+0x174/0x1b8
 [<c014ccf9>] sys_ioctl+0x1fd/0x254
 [<c01089af>] syscall_call+0x7/0xb

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
