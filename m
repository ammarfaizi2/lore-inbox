Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUJYUKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUJYUKe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUJYUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:10:20 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55568 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261313AbUJYUHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:07:50 -0400
Date: Mon, 25 Oct 2004 21:07:42 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels
In-Reply-To: <p73u0sik2fa.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Andi Kleen wrote:

> > They traced it down to the following code in arch/kernel/traps.c (now
> > in include/asm-i386/mach-default/mach_traps.c):
> > 
> >     outb(0x8f, 0x70);
> >     inb(0x71);              /* dummy */
> >     outb(0x0f, 0x70);
> >     inb(0x71);              /* dummy */
> 
> Just use a different dummy register, like 0x80 which is normally used
> for delaying IO (I think that is what the dummy access does) 

 It's not the dummy read that causes the problem.  It's the index write
that does.  It can be solved pretty easily by not changing the index.  It
may be done if an auxiliary variable is used and other users of the index
cooperate.  The dummy read isn't really necessary, but of course someone
broke their RTC access logic, so it was added as a workaround.

 But then the firmware may screw it up if it changes the index from within 
the SMM.

> But I'm pretty sure this NMI handling is incorrect anyways, its
> use of bits doesn't match what the datasheets say of modern x86
> chipsets say. Perhaps it would be best to just get rid of 
> that legacy register twiddling completely.

 The use is correct.  Bit #7 at I/O port 0x70 controls the NMI line
pass-through flip-flop.  "0" means "pass-through" and "1" means "force
inactive."  As the NMI line is level-driven and the NMI input is
edge-triggered, the sequence is needed to regenerate an edge if another
NMI arrives via the line (not via the APIC) while the handler is running.

  Maciej
