Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVJSOJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVJSOJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 10:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVJSOJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 10:09:37 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:28384 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S1750983AbVJSOJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 10:09:36 -0400
Date: Wed, 19 Oct 2005 16:09:30 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
In-Reply-To: <4356194C.7050402@vc.cvut.cz>
Message-ID: <Pine.HPX.4.33n.0510191540170.2146-100000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scan-Signature: 662e038451b8b068b0aa52dea6f1912d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Clemens Ladisch wrote:
> > However, I've patched my kernel to initialize the HPET manually
> > because my BIOS doesn't bother to do it at all.  A quick Google search
> > shows that in most cases where the BIOS _does_ bother, the third timer
> > (which is the only free one after system timer and RTC have grabbed
> > theirs) didn't get initialized and is still set to interrupt 0 (which
> > isn't actually supported by most HPET hardware).
> >
> > This means that hpet.c must initialize the interrupt routing register
> > in this case.  I'll write a patch for this.
>
> I'm using attached diff.

The other changes of your patch are already in the -mm kernel.

> But I gave up on HPET.  On VIA periodic mode is hopelessly broken,

I've heard it works with timer 0, and the capability bit on timer 1 is
just wrong.

> on AMD HPET read takes about 1500ns (23 HPET cycles),

It's a round trip to the southbridge.  Intel needs about 500 ns.

> and current Linux RTC emulation has problem that when interrupt is
> delayed it stops until counter rollover.

I'm planning to fix this.

OTOH, the hpet.c implementation has the problem that all interrupt
delays affect the timer, i.e., it isn't precise anymore.

> And fixing this would add at least 1.5us to the interrupt handler,
> and it seems quite lot to me...

I didn't measure how much reading the RTC registers costs us, but
those aren't likely to be faster.

I'm thinking of a different approach:  Assuming that such a big delay
almost never actually does happen, we run a separate watchdog timer
(using a kernel timer that is guaranteed to work) at a much lower
frequency to check whether the real timer got stuck.  This trades off
the HPET register read against the timer_list overhead (and that we
still lose _some_ interrupts when the worst case happens).


Regards,
Clemens

