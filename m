Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUBDT7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUBDT7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:59:32 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264229AbUBDT7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:59:22 -0500
Date: Wed, 4 Feb 2004 14:59:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Alok Mooley <rangdi@yahoo.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
In-Reply-To: <40214A11.3060007@techsource.com>
Message-ID: <Pine.LNX.4.53.0402041436030.2965@chaos>
References: <20040204185446.91810.qmail@web9705.mail.yahoo.com>
 <Pine.LNX.4.53.0402041402310.2722@chaos> <40214A11.3060007@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Timothy Miller wrote:

>
>
> Richard B. Johnson wrote:
>
> > If this is an Intel x86 machine, it is impossible for pages
> > to get fragmented in the first place. The hardware allows any
> > page, from anywhere in memory, to be concatenated into linear
> > virtual address space. Even the kernel address space is virtual.
> > The only time you need physically-adjacent pages is if you
> > are doing DMA that is more than a page-length at a time. The
> > kernel keeps a bunch of those pages around for just that
> > purpose.
> >
> > So, if you are making a "memory defragmenter", it is a CPU time-sink.
> > That's all.
>
> Would memory fragmentation have any appreciable impact on L2 cache line
> collisions?
>
> Would defragmenting it help?
>
> In the case of the Opteron, there is a 1M cache that is (I forget) N-way
> set associative, and it's physically indexed.  If a bunch of pages were
> located such that there were a disproportionately large number of lines
> which hit the same tag, you could be thrashing the cache.
>
> There are two ways to deal with this:  (1) intelligently locates pages
> in physical memory; (2) hope that natural entropy keeps things random
> enough that it doesn't matter.
>
>

Certainly anybody can figure out some special case where a
cache-line might get flushed or whatever. Eventually you
get to the fact that even contiguous physical RAM doesn't
have to be contiguous and, in fact, with modern controllers
it's quite unlikely that it is. It's a sack of bits that
are uniquely addressable.

The rest of the hardware makes this look like a bunch of RAM
"pages", seldom the size of CPU pages, and the controller
makes these pages look like contiguous RAM sitting in linear
address-space. There is lots of wasted RAM in the Intel/IBM/PC
architecture because the stuff that would be where the screen
regen buffer is, where the graphics aperture exists, where
the screen BIOS ROM is, where the BIOS ROM is (unless shadowed),
all that space is occupied by RAM that can't even be addressed.
So there are address-holes that are never accessed. This means
that there are few nice clean cache-line fills for physical RAM
below 1 megabyte.

Fortunately most accesses are above 1 megabytes. The locality-of-
action helps reduce the amount of paging required in that memory
accesses remain with a very short distance of each other in real
programs. Of course, again, you can make a memory-corrupting
program that thrashes the swap-file, but if you design to reduce
that, you destroy interactivity.

Since the days of VAXen people have been trying to improve memory
managers. So far, every improvement in special cases hurts the
general case. I remember the controvesy at DEC when it was decided
to keep some zero-filled pages around (demand-zero paging). These
would be allocated as "readable". It's only when somebody would
attempt to write to them, that a real page needed to be allocated.
My question was; "Why a bunch of pages?". You only need one. As
a customer, I was told that I didn't understand. So, DEC is out-
of-business and nobody does demand-zero paging because it's dumb,
damn stupid.

The same is true of "memory defragmentation".

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


