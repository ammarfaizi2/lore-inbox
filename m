Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDFQSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDFQSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWDFQSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:18:46 -0400
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:33668
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1750793AbWDFQSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:18:46 -0400
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: Re: mem= causes oops (was Re: BIOS causes (exposes?) modprobe (load_module) kernel oops)
Date: Thu, 6 Apr 2006 09:18:45 -0700
User-Agent: KMail/1.5.2
References: <200603212005.58274.jzb@aexorsyst.com> <200603251036.40379.jzb@aexorsyst.com> <20060405120742.ee9af120.rdunlap@xenotime.net>
In-Reply-To: <20060405120742.ee9af120.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604060918.45185.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 12:07, Randy.Dunlap wrote:
> On Sat, 25 Mar 2006 10:36:40 -0800 John Z. Bohach wrote:
> > On Friday 24 March 2006 16:32, Randy.Dunlap wrote:
> > > > Here it is:
> > > >
> > > > fails with cmdline:
> > > >
> > > > Kernel command line: ro root=/dev/sda1 rootdelay=10 mem=0x200M
> > > > console=ttyS0,115200n8
> > > >
> > > > works with:
> > > >
> > > > Kernel command line: ro root=/dev/sda1 rootdelay=10
> > > > console=ttyS0,115200n8
> > > >
> > > > Note the "mem=" being the differentiator!
> > >
> > > OK, that is memory map difference.
> > >
> > > Can you test a more recent kernel to see if it has the same problem?
> > > (like 2.6.16 or 2.6.16-git9)
> >
> > No luck, or difference, for that matter.  2.6.16 behaves identically. 
> > I'm trying a few different options, such as disabling MSI/MSI-X support,
> > because what I've seen is that it all works fine with it as long as the
> > h/w has MSI support, but in all the case I've seen fail, the common
> > denominator is no MSI (and also all ICH4 platforms).  The cases where I
> > can't make it fail is where the h/w has MSI support.  One other
> > noteworthy difference is that the failures all occur on Intel graphics
> > chipsets, while the successes are non-graphics. Still trying to find out
> > whether the failure follows graphics or the ICH4.
> >
> > Anyway, what would help me is if someone could tell me if the page fault
> > is a normal and expected code path by design, in order to page in the
> > area setup by __vmalloc_area() as triggered by the module_alloc() call. 
> > I'd really rather not have to trace through the page fault handler to
> > identify the difference between success/failure unless I have to.
>
> AFAIK the page fault is not expected, but I would be happier if someone
> else confirmed that.
>
> BTW, Documentation/kernel-parameters.txt suggests using mem= and memmap=
> together, so maybe you could use memmap=.... to prevent this problem.

I found the root cause, but don't know if its worth fixing.  If the board has more than
32 PCI busses on it, the mptable bus array will overwrite its bounds for the PCI busses,
and stomp on anything that's after it.  In this case, what got stomped on is the PAGE_KERNEL_EXEC
variable, which changed the bit-field settings for the page tables (cleared the 'present' bit,
and screwed up the rest), hence accounting for the page fault.

This can only happen if there are more than 32 PCI busses, so I'd say its an _extremely_ rare
condition on a desktop system.  At any rate, the fix would simply be to change the value of the
#define in the mptable.h header file (I forget which exactly, but its easy to find) from 32 to 256.
The side effect of that is that the kernel data area would grow, and mostly be a total waste,
since I can't fathom a desktop system with more than 32 PCI busses.  On arch's where more than
32 PCI busses are likely, the #define is already 256.

One thing to take away from all this is that runtime memory corruption can change the PAGE_KERNEL
and PAGE_KERNEL_EXEC values, causing bogus page faults, followed by oops's.  Usually a buggy
driver or module might cause this, and throw off whoever is trying to debug it from the original cause
of the error.  I'll at least double-check if the PAGE_KERNEL* vars. are still sane after any oops relating
to paging.  Might save me some time...

Thanks for everybody's input and patience.

--john


