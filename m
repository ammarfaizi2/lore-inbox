Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbUCTQJR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUCTQJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:09:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263456AbUCTQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:09:15 -0500
Date: Sat, 20 Mar 2004 16:09:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320160911.B6726@flint.arm.linux.org.uk>
Mail-Followup-To: Jaroslav Kysela <perex@suse.cz>,
	Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>; from perex@suse.cz on Sat, Mar 20, 2004 at 04:58:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 04:58:21PM +0100, Jaroslav Kysela wrote:
> On Sat, 20 Mar 2004, Russell King wrote:
> > Actually, ALSA is broken in that respect - it isn't portable as it
> > stands.  It isn't the API which is broken - it's ALSA which is broken.
> > Performing virt_to_page() on any non-direct mapped RAM page (which
> > means the value returned from dma_alloc_coherent or pci_alloc_consistent)
> > is undefined.
> > 
> > One of my current projects is fixing this crap in ALSA.
> 
> Yes, but if there's no API in the kernel code allowing to obtain page 
> pointers using any value returned from dma_alloc_coherent(), then we 
> cannot fix this problem.

It is fixable, if someone sits down and works through it, which is
precisely what I've been doing.

> So, it's not much subsystem (ALSA) problem, but kernel core is not matured
> enough.

It is well known that virt_to_page() is only valid on virtual addresses
which correspond to kernel direct mapped RAM pages, and undefined on
everything else.  Unfortunately, ALSA has been using it with
pci_alloc_consistent() for a long time, and this behaviour is what
makes ALSA broken.  The fact it works on x86 is merely incidental.

If ALSA wants this functionality, the ALSA people should ideally have
put their requirements forward during the 2.5 development cycle so the
problem could be addressed.  However, luckily in this instance, it is
not a big problem to solve.  It just requires time to sort through all
the abstraction layers upon abstraction layers which ALSA has.

- and I'm doing exactly this, right now.  Be patient. -

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
