Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTDNTqW (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTDNTqW (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:46:22 -0400
Received: from users.ccur.com ([208.248.32.211]:21820 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263800AbTDNTqU (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:46:20 -0400
Date: Mon, 14 Apr 2003 15:57:31 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 preemption bug in bh_kmap_irq
Message-ID: <20030414195730.GA17773@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030414172730.GA17451@rudolph.ccur.com> <200304141938.26328.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304141938.26328.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:40:14PM +0200, Marc-Christian Petersen wrote:
> On Monday 14 April 2003 19:27, Joe Korty wrote:
> 
> Hi Joe,
> 
> > The below patch compiles and boots ide=nodma on my preempt 2.4 kernel
> > on the one motherboard that had the problem.  Before this patch, the
> > kernel would not even boot for that motherboard.  I also applied and
> > test booted a pure 2.4.21-pre5 kernel with this patch.
> > The patch implements my preference for simplicity, so you may want to
> > take some other approach if maximal performance is what you want.
> yep, and here is the problem ^^^^^^^^. Your patch seems ok but is horribly 
> slow. I've tried it first the day you submitted the patch. It's even alot 
> slower than w/o Preempt or CONFIG_PREEMPT to no.
> 
> My Celeron 1,3GHz with 512 MB RAM felt like good old 486SX/25 while doing,
> for example, a kernel compilation :(
> 
> ciao, Marc


Hi Marc,
I've been re-reviewing the code and I can't see any problem.  There
are two cases: kernels compiled with CONFIG_HIGHMEM and those
without.

For the CONFIG_HIGHMEM case, the call in bh_kmap_irq to kmap_atomic
actually calls a real routine called kmap_atomic.  This has a version
of the 'if' statement equivalent to the one I removed from
bh_kmap_irq, right near the front:

    static inline void *kmap_atomic(...
    {
        ....
        preempt_disable();
        if (page < highmem_start_page)
                return page_address(page);

For the case where CONFIG_HIGHMEM is not set, the bh_kmap_irq call to
kmap_atomic is really (through the magic of #defines) a call to
page_address, which expands out to a near-NOP:

	#define page_address(page) ((page)->virtual)

So in one case I have the overhead of an extra procedure call/return,
in the other the overhead of an extra pointer dereference.  Neither
of these should be causing the performance impact you are seeing.

There is always the possibility of a case that I missed, but right
now I don't see it.

Regards,
Joe

