Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTIOSWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTIOSWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:22:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20495 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261203AbTIOSWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:22:47 -0400
Date: Mon, 15 Sep 2003 14:13:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <200309151228.h8FCSQ2B022357@harpo.it.uu.se>
Message-ID: <Pine.LNX.3.96.1030915140344.20945A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Mikael Pettersson wrote:

> On Mon, 15 Sep 2003 08:11:12 -0400 (EDT), Bill Davidsen <davidsen@tmr.com> wrote:
> > On Mon, 15 Sep 2003, Alan Cox wrote:
> > > That disable you talk about is bloat. It also trashes the performance of
> > > PIV boxes. In fact I checked out of interest - the disable hack
> > > currently being used is adding *over* 300 bytes to my kernel as its
> > > inlined repeatedly. So its larger, and it ruins performance for all
> > > processors.
> > 
> > The code to disable prefetch on Athlon is 300 bytes and hurts your PIV?
> > Really? I'll dig back through the code, but I recall it as adding or
> > deleting an entry in a table to enable prefetch. If it's affecting PIV the
> > code to use prefetch is seriously broken.
> 
> Bill, look in include/asm-i386/processor.h:
> 
> extern inline void prefetch(const void *x)
> {
>         if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
>                 return;         /* Some athlons fault if the address is bad */
>         alternative_input(ASM_NOP4,
>                           "prefetchnta (%1)",
>                           X86_FEATURE_XMM,
>                           "r" (x));
> }
> 
> A dynamic test at each occurrence. That's truly horrible.
> (And I'll hack it out of _my_ kernels ASAP. Can't imagine
> I missed that one.)

That's exactly the type of thing a MINIMAL_CODE flag could
drop unless Athlon support was enabled. However, the test should be at the
caller(s), to avoid a call/return in the first place.

To avoid really ugly source code it would probably be desirable to just
define a do_prefetch_if_supported() macro, and put any and all future
magic there. If the fix is used the test for AMD isn't needed, I would
just like to avoid having the test or the fix at all on my Intel systems.
And if I read correctly, that errata will be fixed in future Athlon CPUs,
so a better test will be needed anyway.

The code is appropriate for a generic X86 kernel, but not for one built to
one specific CPU. Everyone can be happy through the magin of Kconfig ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

