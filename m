Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317920AbSFSQNj>; Wed, 19 Jun 2002 12:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317922AbSFSQNj>; Wed, 19 Jun 2002 12:13:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64016 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317920AbSFSQNh>;
	Wed, 19 Jun 2002 12:13:37 -0400
Message-ID: <3D10AEBC.176441BA@zip.com.au>
Date: Wed, 19 Jun 2002 09:18:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Craig Kulesa <ckulesa@as.arizona.edu>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
References: <Pine.LNX.4.44.0206181340380.3031-100000@loke.as.arizona.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Kulesa wrote:
> 
> ...
> Various details for the curious or bored:
> 
>         - Tested:   UP, 16 MB < mem < 256 MB, x86 arch.
>           Untested: SMP, highmem, other archs.
> 
>           In particular, I didn't even attempt to port rmap-related
>           changes to 2.5's arch/arm/mm/mm-armv.c.
> 
>         - page_launder() is coarse and tends to clean/flush too
>           many pages at once.  This is known behavior, but seems slightly
>           worse in 2.5 for some reason.
> 
>         - pf_gfp_mask() doesn't exist in 2.5, nor does PF_NOIO.  I have
>           simply dropped the call in try_to_free_pages() in vmscan.c, but
>           there is probably a way to reinstate its logic
>           (i.e. avoid memory balancing I/O if the current task
>           can't block on I/O).  I didn't even attempt it.

That's OK.  PF_NOIO is a 2.4 "oh shit" for a loop driver deadlock.
That all just fixed itself up.

>         - Writeback:  instead of forcing reinstating a page on the
>           inactive list when !PageActive, page->mapping, !Pagedirty, and
>           !PageWriteback (see mm/page-writeback.c, fs/mpage.c), I just
>           let it go without any LRU list changes.  If the page is
>           inactive and needs attention, it'll end up on the inactive
>           dirty list soon anyway, AFAICT.  Seems okay so far, but that
>           may be flawed/sloppy reasoning... We could always look at the
>           page flags and reinstate the page to the appropriate LRU list
>           (i.e. inactive clean or dirty) if this turns out to be a
>           problem...

The thinking there was this: the 2.4 shrink_cache() code was walking the
LRU, running writepage() against dirty pages at the tail.  Each written
page was moved to the head of the LRU while under writeout, because we
can't do anything with it yet.  Get it out of the way.

When I changed that single-page writepage() into a "clustered 32-page
writeout via ->dirty_pages", the same thing had to happen: get those
pages onto the "far" end of the inactive list.

So basically, you'll need to give them the same treatment as Rik
was giving them when they were written out in vmscan.c.  Whatever
that was - it's been a while since I looked at rmap, sorry.

> ...
> 
>         - To be consistent with 2.4-rmap, this patch includes a
>           minimal BIO-ified port of Andrew Morton's read-latency2 patch
>           (i.e. minus the elvtune ioctl stuff) to 2.5, from his patch
>           sets.  This adds about 7 kB to the patch.

Heh.   Probably we should not include this in your patch.  It gets
in the way of evaluating rmap.  I suggest we just suffer with the
existing IO scheduling for the while ;)

>         - The patch also includes compilation fixes:
>         (2.5.22)
>               drivers/scsi/constants.c (undeclared integer variable)
>               drivers/pci/pci-driver.c (unresolved symbol in pcmcia_core)
>         (2.5.23)
>               include/linux/smp.h (define cpu_online_map for UP)
>               kernel/ksyms.c    (export default_wake_function for modules)
>               arch/i386/i386_syms.c   (export ioremap_nocache for modules)
> 
> Hope this is of use to someone!  It's certainly been a fun and
> instructive exercise for me so far.  ;)

Good stuff, thanks.

-
