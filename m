Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUEaOEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUEaOEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbUEaOEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:04:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26289 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264550AbUEaOEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:04:44 -0400
Date: Mon, 31 May 2004 11:05:46 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops, 2.4.26 and jfs
Message-ID: <20040531140546.GA20617@logos.cnet>
References: <Pine.LNX.4.58.0405281307550.18184@potato.cts.ucla.edu> <1085776292.13846.18.camel@shaggy.austin.ibm.com> <Pine.LNX.4.58.0405281757360.18184@potato.cts.ucla.edu> <20040530173858.GA11692@logos.cnet> <Pine.LNX.4.58.0405310409100.1282@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405310409100.1282@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 04:19:39AM -0700, Chris Stromsoe wrote:
> On Sun, 30 May 2004, Marcelo Tosatti wrote:
> 
> >  On Fri, May 28, 2004 at 06:16:22PM -0700, Chris Stromsoe wrote:
> >
> > > Aside from that:
> > >
> > > > May 26 06:28:10 begonia kernel: __alloc_pages: 0-order allocation
> > > > failed (gfp=0x1f0/0)
> > >
> > > I'm curious about why 0-order allocations would fail.  From everything
> > > I've read (google searching for the error message), that indicates an
> > > out of memory condition, which shouldn't be the case.
> > >
> > > The box in question has 4Gb of physical ram (512Mb is used as tmpfs)
> > > and 9Gb of swap.  When the oops happened, no swap was in use.
> > > Physical ram was pretty much filled, but no swap at all.  OOM_KILLER
> > > is not enabled.
> >
> > Hi Chris,
> >
> > This seems to be a normal allocation (which can wait), it really looks
> > the system was out of memory.
> 
> Hrm.  No swap was in use at all when it happened; there was >9Gb free.
> Since I started watching memory usage (mid-October), I've never seen this
> particular machine use more than ~ 200Mb or so of swap.  The workload
> generates a lot of disk access and most of hte "used" memory is cache.
> /proc/meminfo right now shows:
> 
> cbs:~ > cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  4175282176 4049809408 125472768        0 155308032 3207811072
> Swap: 9606946816    12288 9606934528
> MemTotal:      4077424 kB
> MemFree:        122532 kB
> MemShared:           0 kB
> Buffers:        151668 kB
> Cached:        3132616 kB
> SwapCached:         12 kB
> Active:         608876 kB
> Inactive:      3019980 kB
> HighTotal:     3211264 kB
> HighFree:       112708 kB
> LowTotal:       866160 kB
> LowFree:          9824 kB
> SwapTotal:     9381784 kB
> SwapFree:      9381772 kB
> 
> which is pretty typical.  Should it be able to OOM when there is swap
> free?  Or when most of the used memory is cache?

Should not really be able to OOM with swap free because of this check:

/**
 * out_of_memory - is the system out of memory?
 */
void out_of_memory(void)
{
        /*
         * oom_lock protects out_of_memory()'s static variables.
         * It's a global lock; this is not performance-critical.
         */
        static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
        static unsigned long first, last, count, lastkill;
        unsigned long now, since;
                                                                                      
        /*
         * Enough swap space left?  Not OOM.
         */
        if (nr_swap_pages > 0)
                return;
                                                                                      

> > Can you stick a call to show_free_areas() in mm/page_alloc.c after
> >
> >         printk(KERN_NOTICE "__alloc_pages: %u-order allocation failed (gfp=0x%x/%i)\n",
> >                order, gfp_mask, !!(current->flags & PF_MEMALLOC));
> >
> > so we know the state of the memory areas when it happens again.
> >
> > Also turn on /proc/sys/vm/vm_gfp_debug.
> 
> done.  I'll wait until the crash happens again.  It could be a few weeks.
> What will vm_gfp_debug do -- what should I look for when it happens?

It will print the calltrace when a memory allocation fails.

show_free_areas() should print the memory state (function used by alt+sysrq+m) 
