Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVI2QcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVI2QcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVI2QcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:32:04 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:62453 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S932167AbVI2QcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:32:02 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=eLgs9H6L2Uoz9T69IWTG0b6D463wcfnZNJdyEEdGFGE9hEf6WgZ+BEWqND8CLE4ja
	pZeVFqztLA1xkn6X1Rn5g==
Date: Thu, 29 Sep 2005 09:31:22 -0700
From: David Brownell <david-b@pacbell.net>
To: torvalds@osdl.org
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
Cc: rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, daniel.ritz@gmx.ch,
       akpm@osdl.org
References: <20050908053042.6e05882f.akpm@osdl.org>
 <200509282334.58365.rjw@sisk.pl>
 <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509290032.26815.daniel.ritz@gmx.ch>
 <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <Pine.LNX.4.58.0509290832190.3308@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509290832190.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050929163123.15945E372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 29 2005 Our Fearless Leader <torvalds@osdl.org> wrote:

> > You could try adding
> > 
> > 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> > 
> > near the end of ohci_pci_suspend().  
>
> Give it up.

Actually the notion of doing _that_ predated that "recent" ACPI stuff,
since from time to time people with OHCI in ASICs (and without ACPI)
have said they need to run with a patch doing just that.

Which is why regardless of that other ACPI-ish issue, I'd like to
hear test results on this one.  I suspect they'll be "OHCI resume
breaks for other reasons", unfortunately, but that's one reason we
have a 2.6.15 cycle upcoming.  (And such reports would put a rather
different complexion on this whole recent thread too ... ;)


> The right thing is to not free and re-aquire the damn interrupt in the 
> first place. It was a MISTAKE. We undid the ACPI braindamage that made it 
> be required a month ago, because sane people REALIZED it was a mistake.
>
> It's not just "random luck" that not releasing the interrupt over suspend 
> fixes the problem. The problem is _due_ to drivers releasing the 
> interrupt in the first place.

The patch above would be orthogonal to that issue, though ...


If we change how usbcore does this stuff -- so hcd-pci.c won't release
and later re-allocate the IRQ -- I don't think I'd object.  But I'd
rather do it in the 2.6.15 cycle, since as I understand things the
bug that restores that "ACPI braindamage" is only in the MM tree, and
there have been _no failures at all_ reported using mainstream kernels.

- Dave


> IT DOESN'T MATTER what we do before the suspend, because we don't control 
> the wakeup sequence. If the BIOS wakeup enables the devices again, the 
> fact that we disabled them on suspend makes zero difference.
>
> And yes, we can always "fix" things by selecting the right order to 
> re-aquire the interrupts, but the thing is, the "right order" will be 
> machine-dependent and in general depend on the phase of the moon and BIOS 
> version, and ACPI quirks.
>
> The _only_ sane thing to do is to not drop the interrupts in the first 
> place. So that if you start getting interrupts before you expect them, you 
> can still handle them.
>
> 		Linus
>
