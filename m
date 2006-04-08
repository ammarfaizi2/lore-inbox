Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWDHPRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWDHPRL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 11:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWDHPRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 11:17:11 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:421 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964992AbWDHPRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 11:17:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: Userland swsusp failure (mm-related)
Date: Sat, 8 Apr 2006 17:16:31 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@suse.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com>
In-Reply-To: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604081716.31836.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 08 April 2006 14:37, Fabio Comolli wrote:
> This is my first (and unique) failure since I began testing uswsusp
> (2.6.17-rc1 version). It happened (I think) because more than 50% of
> physical memory was occupied at suspend time (about 550 megs out og
> 1G) and that was what I was trying to test. After freeing some memory
> suspend worked (there was no need to reboot).

Well, it looks like we didn't free enough RAM for suspend in this case.
Unfortunately we were below the min watermark for ZONE_NORMAL and
we tried to allocate with GFP_ATOMIC (Nick, shouldn't we fall back to
ZONE_DMA in this case?).

I think we can safely ignore the watermarks in swsusp, so probably
we can set PF_MEMALLOC for the current task temporarily and reset
it when we have allocated memory.  Pavel, what do you think?

> I did not set the image size limit. Of course if I set the image size
> to 500M everything works.
> 
> I use fglrx; however this has never proved to be a problem:
> suspend-resume always worked perfectly, DRI was functioning after
> resume without any noticeable difference.
> 
> In my normal activity uswsusp work fine with both compression and
> encryption. Good work guys.

Thanks. :-)

Greetings,
Rafael


> -----------------------
> Apr  8 14:04:09 tycho kernel: Stopping tasks:
> ====================================================================================================|
> Apr  8 14:04:09 tycho kernel: Shrinking memory...  ^H-^H\^Hdone (19786
> pages freed)
> Apr  8 14:04:09 tycho kernel: eth1: Going into suspend...
> Apr  8 14:04:09 tycho kernel: swsusp: Need to copy 113906 pages
> Apr  8 14:04:09 tycho kernel: suspend: page allocation failure.
> order:0, mode:0x8120
> Apr  8 14:04:09 tycho kernel:  <c0131ccf> __alloc_pages+0x249/0x25d  
> <c0131d52> get_zeroed_page+0x31/0x4c
> Apr  8 14:04:09 tycho kernel:  <c0129e9d> alloc_data_pages+0x5b/0xb8  
> <c012a730> swsusp_save+0xea/0x244
> Apr  8 14:04:09 tycho kernel:  <c02265ea>
> swsusp_arch_suspend+0x2a/0x2c   <c0129852> swsusp_suspend+0x31/0x6b
> Apr  8 14:04:09 tycho kernel:  <c012b5bf> snapshot_ioctl+0x1ab/0x3f9  
> <c012b414> snapshot_ioctl+0x0/0x3f9
> Apr  8 14:04:09 tycho kernel:  <c0151da5> do_ioctl+0x39/0x48  
> <c0151fb3> vfs_ioctl+0x1ff/0x216
> Apr  8 14:04:09 tycho kernel:  <c0151ff6> sys_ioctl+0x2c/0x42  
> <c01028db> sysenter_past_esp+0x54/0x75
> Apr  8 14:04:09 tycho kernel: Mem-info:
> Apr  8 14:04:09 tycho kernel: DMA per-cpu:
> Apr  8 14:04:09 tycho kernel: cpu 0 hot: high 0, batch 1 used:0
> Apr  8 14:04:09 tycho kernel: cpu 0 cold: high 0, batch 1 used:0
> Apr  8 14:04:09 tycho kernel: DMA32 per-cpu: empty
> Apr  8 14:04:09 tycho kernel: Normal per-cpu:
> Apr  8 14:04:09 tycho kernel: cpu 0 hot: high 186, batch 31 used:0
> Apr  8 14:04:09 tycho kernel: cpu 0 cold: high 62, batch 15 used:14
> Apr  8 14:04:09 tycho kernel: HighMem per-cpu: empty
> Apr  8 14:04:09 tycho kernel: Free pages:        4952kB (0kB HighMem)
> Apr  8 14:04:09 tycho kernel: Active:45901 inactive:54562 dirty:0
> writeback:0 unstable:0 free:1238 slab:4155 mapped:43513 pagetables:472
> Apr  8 14:04:09 tycho kernel: DMA free:3548kB min:68kB low:84kB
> high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:0
> all_unreclaimable? no
> Apr  8 14:04:09 tycho kernel: lowmem_reserve[]: 0 0 880 880
> Apr  8 14:04:09 tycho kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
> active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable?
> no
> Apr  8 14:04:09 tycho kernel: lowmem_reserve[]: 0 0 880 880
> Apr  8 14:04:09 tycho kernel: Normal free:1404kB min:3756kB low:4692kB
> high:5632kB active:183604kB inactive:218248kB present:901120kB
> pages_scanned:0 all_unreclaimable? no
> Apr  8 14:04:09 tycho kernel: lowmem_reserve[]: 0 0 0 0
> Apr  8 14:04:09 tycho kernel: HighMem free:0kB min:128kB low:128kB
> high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0
> all_unreclaimable? no
> Apr  8 14:04:09 tycho kernel: lowmem_reserve[]: 0 0 0 0
> Apr  8 14:04:09 tycho kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
> 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
> Apr  8 14:04:09 tycho kernel: DMA32: empty
> Apr  8 14:04:09 tycho kernel: Normal: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB
> 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1404kB
> Apr  8 14:04:09 tycho kernel: HighMem: empty
> Apr  8 14:04:09 tycho kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
> Apr  8 14:04:09 tycho kernel: Free swap  = 1052248kB
> Apr  8 14:04:09 tycho kernel: Total swap = 1052248kB
> Apr  8 14:04:09 tycho kernel: Free swap:       1052248kB
> Apr  8 14:04:09 tycho kernel: 229376 pages of RAM
> Apr  8 14:04:09 tycho kernel: 0 pages of HIGHMEM
> Apr  8 14:04:09 tycho kernel: 2732 reserved pages
> Apr  8 14:04:09 tycho kernel: 93657 pages shared
> Apr  8 14:04:09 tycho kernel: 0 pages swap cached
> Apr  8 14:04:09 tycho kernel: 0 pages dirty
> Apr  8 14:04:09 tycho kernel: 0 pages writeback
> Apr  8 14:04:09 tycho kernel: 43513 pages mapped
> Apr  8 14:04:09 tycho kernel: 4155 pages slab
> Apr  8 14:04:09 tycho kernel: 472 pages pagetables
> Apr  8 14:04:09 tycho kernel: suspend: Allocating image pages failed.
> Apr  8 14:04:09 tycho kernel: Error -12 suspending
> 
