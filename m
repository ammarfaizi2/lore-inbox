Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279808AbRKFRhe>; Tue, 6 Nov 2001 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279805AbRKFRhY>; Tue, 6 Nov 2001 12:37:24 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:17164 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S279808AbRKFRhP>;
	Tue, 6 Nov 2001 12:37:15 -0500
Date: Tue, 6 Nov 2001 10:31:21 -0700
From: Michael Barabanov <baraban@fsmlabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@tech9.net>, manfred@colorfullife.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        Victor Yodaiken <yodaiken@fsmlabs.com>
Subject: Re: Using %cr2 to reference "current"
Message-ID: <20011106103121.A26976@hq2>
In-Reply-To: <1005033690.808.2.camel@phantasy> <E1613t5-00005M-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1613t5-00005M-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Organization: FSMLabs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my version of hard cpu id (RTLinux version):

extern inline int rtl_getcpuid(void)
{
        unsigned cpu;
        __asm__ (
                        "str %%ax\n\t"
                        "shr $5, %%eax\n\t"
                        "sub $3, %%eax\n\t"
                        : "=a"(cpu));
        return cpu;
}

No cr2 involved; extremely fast. This takes advantage of the fact that
TSS-CPU mapping is 1-1 in 2.4.

Michael.

Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > I too am confused.  More so, the difference between hard_get_current and
> > get_current is confusing.  I further question things because I suspect
> 
> hard_get_current always works
> get_current assumes %cr2 is loaded correctly
> 
> > do_page_fault, cpu_init" but all these functions call other functions
> > that may very well use get_current.  How is this going to work?
> 
> do_page_fault and cpu_init load %cr2
> 
> > Further, the preemptible kernel patch oopses with this patch (IOW, don't
> > use 2.4.13-ac8 + preempt-kernel, unless you remove all these bits like I
> > did :>).  I think it may be because of:
> 
> You must ensure that you don't pre-empt until %cr2 is loaded. Obviously this
> isnt a problem with the traditional low latency patch but if you pre-empty
> very early in page fault handling then I suspect you might get the odd
> suprise.
> 
> The reasoning behind all this is to fix the cache pessimal nature of the x86
> stack layout - we had all task structs on the same cache colour and all 
> stacks aligned within pages (so every apache thread waiting at the same
> point is on the same colour too and each wait queue entry on their stacks
> is linked to entries all the same colour)
> 
> Alan
