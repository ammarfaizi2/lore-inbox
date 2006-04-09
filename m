Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWDIPmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWDIPmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWDIPmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:42:06 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:65364 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750791AbWDIPmF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:42:05 -0400
Message-ID: <b29067a0604090842h3bb11a88re9c175a467763c9f@mail.gmail.com>
Date: Sun, 9 Apr 2006 11:42:02 -0400
From: "Rahul Karnik" <rahul@genebrew.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Tracking down leaking applications
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are using an old P3 866 MHz with 512 MB of RAM to host a
development Apache server, and over the past few days have experienced
oom kills on a regular basis. Kernel being used is Fedora Core's
2.6.15-1_1831. A typical oom trace is shown below.

Apr  4 14:41:13 fedora kernel: oom-killer: gfp_mask=0x201d2, order=0
Apr  4 14:41:13 fedora kernel: Mem-info:
Apr  4 14:41:13 fedora kernel: DMA per-cpu:
Apr  4 14:41:13 fedora kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Apr  4 14:41:13 fedora kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Apr  4 14:41:13 fedora kernel: DMA32 per-cpu: empty
Apr  4 14:41:13 fedora kernel: Normal per-cpu:
Apr  4 14:41:13 fedora kernel: cpu 0 hot: low 0, high 186, batch 31 used:171
Apr  4 14:41:13 fedora kernel: cpu 0 cold: low 0, high 62, batch 15 used:49
Apr  4 14:41:13 fedora kernel: HighMem per-cpu: empty
Apr  4 14:41:13 fedora kernel: Free pages:        5320kB (0kB HighMem)
Apr  4 14:41:13 fedora kernel: Active:122584 inactive:645 dirty:0
writeback:0 unstable:0 free:1330 slab:2313 mapped:122684
pagetables:726
Apr  4 14:41:13 fedora kernel: DMA free:2068kB min:88kB low:108kB
high:132kB active:10280kB inactive:8kB present:16384kB
pages_scanned:12133 all_unreclaimable? yes
Apr  4 14:41:13 fedora kernel: lowmem_reserve[]: 0 0 495 495
Apr  4 14:41:13 fedora kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable?
no
Apr  4 14:41:13 fedora kernel: lowmem_reserve[]: 0 0 495 495
Apr  4 14:41:13 fedora kernel: Normal free:3252kB min:2800kB
low:3500kB high:4200kB active:480056kB inactive:2572kB
present:506880kB pages_scanned:671522 all_unreclaimable? yes
Apr  4 14:41:13 fedora kernel: lowmem_reserve[]: 0 0 0 0
Apr  4 14:41:13 fedora kernel: HighMem free:0kB min:128kB low:128kB
high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0
all_unreclaimable? no
Apr  4 14:41:13 fedora kernel: lowmem_reserve[]: 0 0 0 0
Apr  4 14:41:13 fedora kernel: DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 2068kB
Apr  4 14:41:13 fedora kernel: DMA32: empty
Apr  4 14:41:13 fedora kernel: Normal: 137*4kB 2*8kB 2*16kB 1*32kB
1*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3252kB
Apr  4 14:41:13 fedora kernel: HighMem: empty
Apr  4 14:41:13 fedora kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Apr  4 14:41:13 fedora kernel: Free swap  = 0kB
Apr  4 14:41:13 fedora kernel: Total swap = 0kB
Apr  4 14:41:13 fedora kernel: Free swap:            0kB
Apr  4 14:41:13 fedora kernel: 130816 pages of RAM
Apr  4 14:41:13 fedora kernel: 0 pages of HIGHMEM
Apr  4 14:41:13 fedora kernel: 2143 reserved pages
Apr  4 14:41:13 fedora kernel: 74708 pages shared
Apr  4 14:41:13 fedora kernel: 0 pages swap cached
Apr  4 14:41:13 fedora kernel: 0 pages dirty
Apr  4 14:41:13 fedora kernel: 0 pages writeback
Apr  4 14:41:13 fedora kernel: 122684 pages mapped
Apr  4 14:41:13 fedora kernel: 2313 pages slab
Apr  4 14:41:13 fedora kernel: 726 pages pagetables
Apr  4 14:41:13 fedora kernel: Out of Memory: Killed process 24188 (httpd).

The process killed has been either httpd or cronolog so far. For now,
I have upgraded to FC4's 2.6.16-1_1069 and added some swap, where
previously there was none.

Is there a way to:
- confirm that it is a userspace and not a kernel issue?
- track down the application that is leaking memory?

Thanks for the help,
Rahul
--
Rahul Karnik
rahul@genebrew.com
