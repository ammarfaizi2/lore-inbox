Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWGLG5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGLG5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGLG5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:57:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3770 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750732AbWGLG5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:57:54 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Olson <olson@unixfolk.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<p734pxnojyt.fsf@verdi.suse.de>
	<m1wtajed4d.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0607112307130.10551@osa.unixfolk.com>
Date: Wed, 12 Jul 2006 00:56:42 -0600
In-Reply-To: <Pine.LNX.4.61.0607112307130.10551@osa.unixfolk.com> (Dave
	Olson's message of "Tue, 11 Jul 2006 23:10:53 -0700 (PDT)")
Message-ID: <m1psgbcnv9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@unixfolk.com> writes:

> On Tue, 11 Jul 2006, Eric W. Biederman wrote:
> | There is a hypertransport capability that implements a rough equivalent
> | of a per device ioapic.  It is quite similar to MSI but with a different
> | register level interface.
>
> It's really just the same as MSI, and is set up and handled pretty
> much the same way.

No it is not just the same.  There is not global enable bit, only
per irq enables.  There is always a mask bit.  The ht irq generates
a 0 byte (with magic defines for the 32 byte enables) write while an
msi generates a 4 byte write with no byte enables.  With ht irqs
the maximum number of irqs is 120 not the one with plain MSI or
the 4k with MSI-X.

But from the perspective of using them in a driver the concept really
is the same.


> | Since native hypertransport devices do not implement a pin emulation mode
> | as native pci express devices do so if you want an interrupt you must support
> | the native hypertransport method.
>
> Right.
>
> | The pathscale ipath-ht400 driver already in the kernel tree uses these
> | and uses so an ugly hack to make work that broke in the last round of
> | the msi cleanups.  I also know of a driver under development for a
> | device that uses these as well.
>
> Umm, it's not broken by any of the the MSI cleanups, at least
> through last week's 2.6.18.

The code that breaks it is only in -mm.  It's scheduled for 2.6.19.
All of the MSI magic in ioapic land on i386 and x86_64 is deleted.
The code just needs to age a bit and let the few unexpected
corner case crop up, and get sorted out.

Hopefully fixing the ipath driver is one of the things we can sort out.

> | So I want to use this so I can get irqs from native hypertransport
> | devices.
>
> This part I never really quite understood.  Why do you want a separate
> interface than the existing request_irq().

request_irq is still needed.  The question is how do you get the irq.

> and pci_enable_msi()? 

The HT and msi semantics are moderately different, but I have
implemented the equivalent of pci_enable/disable_msi.  So the
code is not a pci standard but just a ht standard I didn't use the
pci prefix.

>  Yes,
> there needs to be some HT-specific implementation behind it, but I
> don't see a reason for a whole new interface.  Most of the rest of
> the HT stuff is setup via the pci_* functions, so why not the interrupts?

The reason I did not reuse code from msi.c is that the code in msi.c
is absolutely terrible.  Also note that even the different flavors
of msi have their own enable/disable routines.

I expect I will make msi.c match htirq.c instead of the other way around.
Of course I don't expect the interface exported to drivers to change.

Eric


