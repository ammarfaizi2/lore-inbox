Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUEaLTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUEaLTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 07:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUEaLTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 07:19:47 -0400
Received: from potato.cts.ucla.edu ([149.142.36.49]:14006 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S263413AbUEaLTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 07:19:44 -0400
Date: Mon, 31 May 2004 04:19:39 -0700 (PDT)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops, 2.4.26 and jfs
In-Reply-To: <20040530173858.GA11692@logos.cnet>
Message-ID: <Pine.LNX.4.58.0405310409100.1282@potato.cts.ucla.edu>
References: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu>
 <1085776292.13846.18.camel@shaggy.austin.ibm.com>
 <Pine.LNX.4.58.0405281757360.18184@potato.cts.ucla.edu> <20040530173858.GA11692@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004, Marcelo Tosatti wrote:

>  On Fri, May 28, 2004 at 06:16:22PM -0700, Chris Stromsoe wrote:
>
> > Aside from that:
> >
> > > May 26 06:28:10 begonia kernel: __alloc_pages: 0-order allocation
> > > failed (gfp=0x1f0/0)
> >
> > I'm curious about why 0-order allocations would fail.  From everything
> > I've read (google searching for the error message), that indicates an
> > out of memory condition, which shouldn't be the case.
> >
> > The box in question has 4Gb of physical ram (512Mb is used as tmpfs)
> > and 9Gb of swap.  When the oops happened, no swap was in use.
> > Physical ram was pretty much filled, but no swap at all.  OOM_KILLER
> > is not enabled.
>
> Hi Chris,
>
> This seems to be a normal allocation (which can wait), it really looks
> the system was out of memory.

Hrm.  No swap was in use at all when it happened; there was >9Gb free.
Since I started watching memory usage (mid-October), I've never seen this
particular machine use more than ~ 200Mb or so of swap.  The workload
generates a lot of disk access and most of hte "used" memory is cache.
/proc/meminfo right now shows:

cbs:~ > cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  4175282176 4049809408 125472768        0 155308032 3207811072
Swap: 9606946816    12288 9606934528
MemTotal:      4077424 kB
MemFree:        122532 kB
MemShared:           0 kB
Buffers:        151668 kB
Cached:        3132616 kB
SwapCached:         12 kB
Active:         608876 kB
Inactive:      3019980 kB
HighTotal:     3211264 kB
HighFree:       112708 kB
LowTotal:       866160 kB
LowFree:          9824 kB
SwapTotal:     9381784 kB
SwapFree:      9381772 kB

which is pretty typical.  Should it be able to OOM when there is swap
free?  Or when most of the used memory is cache?

> Can you stick a call to show_free_areas() in mm/page_alloc.c after
>
>         printk(KERN_NOTICE "__alloc_pages: %u-order allocation failed (gfp=0x%x/%i)\n",
>                order, gfp_mask, !!(current->flags & PF_MEMALLOC));
>
> so we know the state of the memory areas when it happens again.
>
> Also turn on /proc/sys/vm/vm_gfp_debug.

done.  I'll wait until the crash happens again.  It could be a few weeks.
What will vm_gfp_debug do -- what should I look for when it happens?



-Chris
