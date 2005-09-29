Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVI2PhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVI2PhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVI2PhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:37:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbVI2PhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:37:17 -0400
Date: Thu, 29 Sep 2005 08:36:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Brownell <david-b@pacbell.net>
cc: daniel.ritz@gmx.ch, rjw@sisk.pl, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hugh@veritas.com, akpm@osdl.org
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
In-Reply-To: <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Message-ID: <Pine.LNX.4.58.0509290832190.3308@g5.osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509282334.58365.rjw@sisk.pl>
 <20050928220409.DE48BE3724@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <200509290032.26815.daniel.ritz@gmx.ch>
 <20050929000929.2CEACE372B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Sep 2005, David Brownell wrote:
> 
> You could try adding
> 
> 	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
> 
> near the end of ohci_pci_suspend().  

Give it up.

The right thing is to not free and re-aquire the damn interrupt in the 
first place. It was a MISTAKE. We undid the ACPI braindamage that made it 
be required a month ago, because sane people REALIZED it was a mistake.

It's not just "random luck" that not releasing the interrupt over suspend 
fixes the problem. The problem is _due_ to drivers releasing the 
interrupt in the first place.

IT DOESN'T MATTER what we do before the suspend, because we don't control 
the wakeup sequence. If the BIOS wakeup enables the devices again, the 
fact that we disabled them on suspend makes zero difference.

And yes, we can always "fix" things by selecting the right order to 
re-aquire the interrupts, but the thing is, the "right order" will be 
machine-dependent and in general depend on the phase of the moon and BIOS 
version, and ACPI quirks.

The _only_ sane thing to do is to not drop the interrupts in the first 
place. So that if you start getting interrupts before you expect them, you 
can still handle them.

		Linus
