Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTIOM2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTIOM2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:28:30 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20610 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261308AbTIOM23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:28:29 -0400
Date: Mon, 15 Sep 2003 14:28:26 +0200 (MEST)
Message-Id: <200309151228.h8FCSQ2B022357@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 08:11:12 -0400 (EDT), Bill Davidsen <davidsen@tmr.com> wrote:
> On Mon, 15 Sep 2003, Alan Cox wrote:
> > That disable you talk about is bloat. It also trashes the performance of
> > PIV boxes. In fact I checked out of interest - the disable hack
> > currently being used is adding *over* 300 bytes to my kernel as its
> > inlined repeatedly. So its larger, and it ruins performance for all
> > processors.
> 
> The code to disable prefetch on Athlon is 300 bytes and hurts your PIV?
> Really? I'll dig back through the code, but I recall it as adding or
> deleting an entry in a table to enable prefetch. If it's affecting PIV the
> code to use prefetch is seriously broken.

Bill, look in include/asm-i386/processor.h:

extern inline void prefetch(const void *x)
{
        if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
                return;         /* Some athlons fault if the address is bad */
        alternative_input(ASM_NOP4,
                          "prefetchnta (%1)",
                          X86_FEATURE_XMM,
                          "r" (x));
}

A dynamic test at each occurrence. That's truly horrible.
(And I'll hack it out of _my_ kernels ASAP. Can't imagine
I missed that one.)

/Mikael
