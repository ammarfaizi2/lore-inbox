Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVGaUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVGaUeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVGaUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 16:34:37 -0400
Received: from ms-smtp-01-smtplb.ohiordc.rr.com ([65.24.5.135]:51185 "EHLO
	ms-smtp-01-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S261996AbVGaUee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 16:34:34 -0400
Date: Sun, 31 Jul 2005 16:34:15 -0400
From: ambx1@neo.rr.com
Subject: Re: revert yenta free_irq on suspend
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Message-id: <2e00842e116e.2e116e2e0084@columbus.rr.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.04 (built Feb  8 2005)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Linus Torvalds <torvalds@osdl.org> 
Date: Sunday, July 31, 2005 11:53 am 
Subject: Re: revert yenta free_irq on suspend 

> 
> 
> On Sun, 31 Jul 2005, Pavel Machek wrote: 
> > 
> > Well, on some machines interrupts can change during suspend (or 
> so I 
> > was told). I did not like the ACPI change at one point, but it 
> is very 
> > wrong to revert PCMCIA fix without also fixing ACPI interpretter. 
> 
> We _are_ going to fix the ACPI interpreter. 
> 
> As to irq's changing during suspend - I'll believe that when I see 
> it, not 
> when some chicken little runs around worrying about it. I doubt 
> anybody 
> has ever seen it, and I'm 100% sure that we have serious breakage 
> right 
> now on machines where it definitely doesn't happen. 
> 
> > And it indeed seems that ACPI interpretter is hard to fix in the 
> right> way. 
> 
> We'll revert to the behaviour that it has traditionally had, and 
> start 
> working forwards in a more careful manner. Where we don't break 
> working 
> setups. 
> 
> Linus 

Hi Linus,

In general, I think that calling free_irq is the right behavior.
Although irqs changing after suspend is rare, there are also some
more serious issues.  This has been discussed in the past, and a
summary is as follows:

1.) race conditions:
Consider the case where several PCI devices are sharing a single PCI
interrupt.  One device is suspended, but doesn't call free_irq.  Now
another properly behaving device on the same interrupt line generates
an interrupt.  Let's say the suspended device had its handler
registered first, and therefore is called first.  The handler will
attempt to access registers on the physically-off device to determine
if it generated the interrupt.  The PCI bus will issue a master abort.
The driver's interrupt handler will likely interpret the read
incorrectly.

Every interrupt handler could be modified to check if the device is
available, but it would be cleaner and more efficient to unregister
the interrupt.  Either way, every driver has to be changed to support
PM correctly.

2.) runtime power management:
We don't want to leave stale interrupt handlers registered when only
suspending a specific device.  As we move toward supporting runtime
power management it will be important to ensure every driver calls
free_irq() in its suspend() (or whatever we're using at that point)
routine.  This avoids interrupt handler bugs and extra interrupt
overhead.


Also I'd like to point out that this patch broke APM suspend-to-ram,
not ACPI S3.  IMO, it may not be possible to support both APM and ACPI
on every system, as their specs are not intended to be compatible.
Progress toward proper suspend-to-ram support will, in many cases, be
a small setback for APM.  This really can't be avoided.

There are, however, some things we can do to mitigate the breakage
toward APM.  Specifically, we should indicate the type of suspend state,
including if it's an ACPI or APM state, for each driver's ->suspend()
routine.  This will give drivers the opportunity to act differently
for APM when necessary.  I'm currenlty working on this issue.

APM is useful for legacy hardware and systems with blacklisted ACPI
support.  I don't think we should attempt to support APM on any system
with working ACPI suspend/resume.

Thanks,
Adam

