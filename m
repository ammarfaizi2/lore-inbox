Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUJYU3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUJYU3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUJYU2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:28:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:39392 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261304AbUJYUR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:17:59 -0400
Date: Mon, 25 Oct 2004 22:17:58 +0200
From: Andi Kleen <ak@suse.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andi Kleen <ak@suse.de>, Corey Minyard <minyard@acm.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all kernels
Message-ID: <20041025201758.GG9142@wotan.suse.de>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:07:42PM +0100, Maciej W. Rozycki wrote:
> On Mon, 25 Oct 2004, Andi Kleen wrote:
> 
> > > They traced it down to the following code in arch/kernel/traps.c (now
> > > in include/asm-i386/mach-default/mach_traps.c):
> > > 
> > >     outb(0x8f, 0x70);
> > >     inb(0x71);              /* dummy */
> > >     outb(0x0f, 0x70);
> > >     inb(0x71);              /* dummy */
> > 
> > Just use a different dummy register, like 0x80 which is normally used
> > for delaying IO (I think that is what the dummy access does) 
> 
>  It's not the dummy read that causes the problem.  It's the index write
> that does.  It can be solved pretty easily by not changing the index.  It

True. It has to be cached once.

> > But I'm pretty sure this NMI handling is incorrect anyways, its
> > use of bits doesn't match what the datasheets say of modern x86
> > chipsets say. Perhaps it would be best to just get rid of 
> > that legacy register twiddling completely.
> 
>  The use is correct.  Bit #7 at I/O port 0x70 controls the NMI line
> pass-through flip-flop.  "0" means "pass-through" and "1" means "force
> inactive."  As the NMI line is level-driven and the NMI input is
> edge-triggered, the sequence is needed to regenerate an edge if another
> NMI arrives via the line (not via the APIC) while the handler is running.

At least in the datasheet I'm reading (AMD 8111) it is just a global
enable/disable bit.

-Andi
