Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWFFFRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWFFFRk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 01:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFFFRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:17:40 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25298 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932105AbWFFFRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:17:39 -0400
Date: Tue, 6 Jun 2006 14:19:22 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: mbligh@google.com
Cc: akpm@osdl.org, apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060605200727.374cbf05.akpm@osdl.org>
References: <4484D174.7080902@google.com>
	<20060605200727.374cbf05.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 20:07:27 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 05 Jun 2006 17:51:00 -0700
> Martin Bligh <mbligh@google.com> wrote:
> 
> > http://test.kernel.org/abat/34264/debug/console.log
> > 
> > Only seems to happen on the sparsemem runs. Possibly a side-effect
> > of the page migration stuff, manifesting itself differently?
> > Or maybe not?
> > 
> > Out of Memory: Kill process 1 (idle) score 0 and children.
> > divide error: 0000 [#1]
> > SMP
> > last sysfs file:
> > CPU:    0
> > EIP:    0060:[<c013be6a>]    Not tainted VLI
> > EFLAGS: 00010246   (2.6.17-rc5-mm2-autokern1 #1)
> > EIP is at shrink_active_list+0x5b/0x382
> > eax: 00000000   ebx: 00000064   ecx: 00000000   edx: 00000000
> > esi: c0474500   edi: c03a8e64   ebp: c03a8dbc   esp: c03a8d9c
> > ds: 007b   es: 007b   ss: 0068
> > Process idle (pid: 1, threadinfo=c03a8000 task=c0769000)
> > Stack: 00000000 00000000 00000020 00000004 c03a8dac c03a8dac c03a8db4 
> > c03a8db4
> >         c03a8dbc c03a8dbc c03a8dfc c0137a14 00000000 c0137a37 c03a8df8 
> > c03a8df4
> >         c0474000 00000000 00000000 c03a8e64 c0137c5a 00000000 00028028 
> > 000dc0e0
> > Call Trace:
> >   <c0137a14> get_writeback_state+0x30/0x35  <c0137a37> 
> > get_dirty_limits+0x1e/0xc4
> >   <c0137c5a> throttle_vm_writeout+0x18/0x53  <c013c221> 
> > shrink_zone+0x90/0xc1
> >   <c013c29f> shrink_zones+0x4d/0x5e  <c013c39d> try_to_free_pages+0xed/0x1a8
> >   <c0136a91> __alloc_pages+0x16e/0x26a  <c014e6c9> kmem_getpages+0x5b/0xac
> >   <c014f42c> cache_grow+0xb5/0x147  <c014f655> 
> > cache_alloc_refill+0x197/0x1d3
> >   <c014fad0> kmem_cache_alloc+0x4f/0x5e  <c0276dd8> sk_alloc+0x15/0x63
> >   <c02bb9e0> inet_create+0xfb/0x21a  <c027546d> __sock_create+0xc0/0xea
> >   <c02754b0> sock_create_kern+0xb/0xe  <c03c413b> icmp_init+0x3a/0xc3
> >   <c03c445c> inet_init+0x12b/0x174  <c03aa7f6> do_initcalls+0x53/0xe4
> >   <c01320d8> register_irq_proc+0x6a/0x90  <c0180000> 
> > xlate_proc_name+0x87/0x90
> >   <c0100349> init+0x41/0xdc  <c0100308> init+0x0/0xdc
> >   <c01009d5> kernel_thread_helper+0x5/0xb
> > Code: 04 24 00 00 00 00 8d 44 24 10 89 44 24 10 89 44 24 14 83 79 10 00 
> > 74 38 8b 8a bc 01 00 00 6b 47 04 64 bb 64 00 00 00 31 d2 d3 fb <f7> 35 
> > 0c 6f 45 c0 ba 02 00 00 00 89 d1 99 f7 f9 01 d8 03 47 18
> > EIP: [<c013be6a>] shrink_active_list+0x5b/0x382 SS:ESP 0068:c03a8d9c
> 
> rofl.  Certainly someone's broken something.  I assume the divide-by-zero
> is due to total_memory being zero.
> 
> We shouldn't be running kswapd_init() as an initcall because sometimes when
> things are broken we will run page reclaim during boot.
> 
> So I'd assume there's something wrong in the memory setup which is causing
> us to enter page reclaim far too early.
> 

I looked back into 2.6.15, 2.6.16. 
It looks -mm's time of initialization of "total_memory" is not changed from them.
(yes, Andrew's fix looks sane.)

I'm intersted in the following texts in the log.
==
Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 0 DMA32: empty
Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Node 0 HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 2*2048kB 3962*4096kB = 16233724kB
Node 1 DMA: empty
Node 1 DMA32: empty
Node 1 Normal: empty
Node 1 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
Node 2 DMA: empty
Node 2 DMA32: empty
Node 2 Normal: empty
Node 2 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
Node 3 DMA: empty
Node 3 DMA32: empty
Node 3 Normal: empty
Node 3 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 3811*4096kB = 15611532kB
==
Looks 64GB memory. but there are only HIGHMEM, no NORMAL, DMA. so, shrink_zone() worked.

Martin, could you show memory layout of this host ?

-Kame









