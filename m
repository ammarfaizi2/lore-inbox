Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSLBChF>; Sun, 1 Dec 2002 21:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSLBChF>; Sun, 1 Dec 2002 21:37:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:62080 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263760AbSLBChE>;
	Sun, 1 Dec 2002 21:37:04 -0500
Message-ID: <3DEAC905.86769170@digeo.com>
Date: Sun, 01 Dec 2002 18:44:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Maximum Physical Memory on 2.4 and ia32
References: <20021202120835.4ecb87fd.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 02:44:25.0723 (UTC) FILETIME=[BA349CB0:01C299AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> 
> Hi all,
> 
> This may be a FAQ (but I did search).
> 
> Given this statement by RedHat:
> 
> "RAM Limitations on IA32
> 
> Red Hat Linux releases based on the 2.4 kernel -- including Red Hat Linux
> 7.1, 7.2, 7.3 and Red Hat Linux Advanced Server 2.1 -- support a maximum
> of 16GB of RAM. Previous product announcements from Red Hat suggested that
> Red Hat Linux 7.1 (and by extension, other releases based on the 2.4
> kernel) supported up to 64GB of RAM. A more accurate statement is the
> 2.4-based kernels included in Red Hat Linux 7.1, 7.2, 7.3 and Red Hat
> Linux Advanced Server 2.1 support the hardware extensions that support up
> to 64GB of RAM. This is an important distinction: while the hardware will
> indeed support up to 64GB of physical memory, the operating system design
> limits the supported physical memory to approximately 16GB."
> 
> (http://www.redhat.com/services/techsupport/production/GSS_caveat.html)
> What are the "operating system design limits" that restrict the amount of
> supported memory to 16GB?

It's a practical limit.  The mem_map array alone would consume 720 megabytes,
so you have no normal-zone memory left.

At 16G, mem_map[] consumes 180 megabytes and there's 540ish megabytes
of normal zone left for general use.

Even at this 20:1 highmem:lowmem ratio, the system will be struggling.
Any time you have normal-zone data structures which are pinned by
pages, the maths gets you in the end.

buffer_heads, pagetable pages, radix-tree nodes, pte_chains and inodes
are normal-zone data structures which, depending on the kernel version,
may be pinned into the normal zone by highmem pages.

In 2.5, with ext2's no-buffer-head option, shared pagetables, highpte,
with your fingers crossed and the wind in the south east, 32G might
be practical.
