Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUEOKJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUEOKJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 06:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUEOKJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 06:09:18 -0400
Received: from 64-52-142-65.client.cypresscom.net ([64.52.142.65]:16566 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id S261704AbUEOKJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 06:09:14 -0400
Date: Sat, 15 May 2004 03:07:46 -0700 (PDT)
From: John Heil <kerndev@sc-software.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
In-Reply-To: <20040514232842.63fd3240.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405150241540.8086@scsoftware.sc-software.com>
References: <20040515062258.7048.qmail@science.horizon.com>
 <20040514232842.63fd3240.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004, Andrew Morton wrote:

> Date: Fri, 14 May 2004 23:28:42 -0700
> From: Andrew Morton <akpm@osdl.org>
> To: linux@horizon.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.6 is crashing repeatedly
>
> linux@horizon.com wrote:
> >
> >  I have now captured a kernel crash.  Everything after iput in the second crash
> >  was hand-coped, and may suffer from transcription errors, but it was done
> >  quite carefully.
> >
> >  System has ECC memory and has been very stable, with uptimes in excess of
> >  1 year when kernel upgrades were infrequent (2.5 development).
> >
> >  Stock 2.6.6 kernel, config as posted before.
> >
> >  Unable to handle kernel NULL pointer dereference at virtual address 00000004
> >   printing eip:
> >  c012a392
> >  *pde = 00000000
> >  Oops: 0002 [#1]
> >  CPU:    0
> >  EIP:    0060:[<c012a392>]    Not tainted
> >  EFLAGS: 00010012   (2.6.6)
> >  EIP is at free_block+0x52/0xd0
> >  eax: 00000000   ebx: e9a3f000   ecx: e9a3f200   edx: df654000
> >  esi: f7f8a560   edi: 00000016   ebp: f7f8a56c   esp: f7d89dec
> >  ds: 007b   es: 007b   ss: 0068
> >  Process kswapd0 (pid: 8, threadinfo=f7d88000 task=f7d8eb50)
> >  Stack: f7f8a57c 0000001b c17fd784 c17fd784 f7f8a560 dc3cdac0 0000001b c012a449
> >         f7fe73dc c17fd774 c17fd774 00000296 dc3cdac0 c037a304 c012a61a dc3cdb40
> >         f7d89e5c 0000003d c014f385 dc3cdb40 c014f5c3 dc19c0c8 dc19c0c0 00000080
> >  Call Trace:
> >   [<c012a449>] cache_flusharray+0x39/0xc0
> >   [<c012a61a>] kmem_cache_free+0x3a/0x50
> >   [<c014f385>] destroy_inode+0x35/0x40
> >   [<c014f5c3>] dispose_list+0x43/0x70
> >   [<c014f87e>] prune_icache+0xae/0x1b0
> >   [<c014f995>] shrink_icache_memory+0x15/0x20
>
> Drat, random memory corruption.
>

Interesting...

FWIW, a data point: I've been chasing memory corruption in 2.6.5-mm2.
(Although I suspect it pre-dates that level.)

The first 2K of a DMA page is overlayed w what looks like code
(even disassembles to something almost meaningful, looking like
interrupt handling code ie w several iret's. Althought I've yet to
find where exactly it's from.) I obtain dma mem from the page
via dma_pool_alloc, having created the pool w dma_pool_create.
The hi 2k of the page w the overlay, remains in tact.

I've been running w CONFIG_SLAB_DEBUG  And CONFIG_DEBUG_PAGEALLOC
usually to no avail. However I do sometimes find freed memory
0xA7 poison words occasionally involved. I temporarily commented out
the dma_pool_free that would release the memory and I still get the
2K overlay.

johnh

> Can you enable CONFIG_SLAB_DEBUG?  And CONFIG_DEBUG_PAGEALLOC too, although
> beware that the latter is a bit costly in terms of CPU cycles and memory
> usage.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------
