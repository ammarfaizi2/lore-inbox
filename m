Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUG0Foq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUG0Foq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUG0Foq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:44:46 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:53996 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266273AbUG0Foo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:44:44 -0400
Date: Tue, 27 Jul 2004 01:48:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Roland Dreier <roland@topspin.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tom L Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH] rename CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI
In-Reply-To: <528yd65kj2.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0407270139280.25781@montezuma.fsmlabs.com>
References: <200407261615.52261.bjorn.helgaas@hp.com> <52llh65r6s.fsf@topspin.com>
 <200407261734.46494.bjorn.helgaas@hp.com> <528yd65kj2.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004, Roland Dreier wrote:

>     Bjorn> This is the bit I really want to get to.  In particular, I
>     Bjorn> want to support multiple interrupt vector spaces on ia64,
>     Bjorn> because we're running out of vectors.  I can't do that as
>     Bjorn> long as MSI mucks around with the arch-specific vector
>     Bjorn> allocation.  (There's plenty of ia64 code that needs to be
>     Bjorn> cleaned up, too; it's not just MSI.)

Agreed, this was discussed earlier and shouldn't be too hard to work into
the current MSI code. Something akin to arrays of msi_desc indexed by
irq handling node depending on the source irq/bus information.

>     Bjorn> I think there needs to be some arch interface to
>     Bjorn> allocate/deallocate Linux IRQ numbers (not interrupt
>     Bjorn> vectors).  Then MSI can allocate as many as it needs, and
>     Bjorn> use yet another arch interface to translate the Linux IRQ
>     Bjorn> numbers to the appropriate address/data info to program the
>     Bjorn> device.
>
> Sounds good, although I don't know much about the low-level details of
> interrupt vectors on either i386 or ia64.  Some way of exposing which
> interrupts are "closest" to which CPUs would be a good thing too.

We can do this right now using the topology information, it's been done
before on NUMAQ.

> One thing that I would be a little concerned about is making the
> numbers in /proc/interrupts too divorced from the underlying platform
> interrupt code -- it seems that ACPI debugging is hard enough as it
> is.

Ok, some of those really are vectors, the thing is, for irqs > 15 (non
legacy) we pass the real vector around. This is done by setting
pci_dev->irq the vector assigned to that irq line. It can get quite
confusing in places so variable naming is indeed important. But in
general, on i386, all irqs with CONFIG_PCI_MSI are vectors.
