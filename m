Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUFXGf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUFXGf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 02:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUFXGf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 02:35:29 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24704 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263942AbUFXGfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 02:35:18 -0400
Date: Thu, 24 Jun 2004 02:37:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Roland Dreier <roland@topspin.com>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>, ak@muc.de, akpm@osdl.org,
       greg@kroah.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       eli@mellanox.co.il
Subject: Re: [PATCH]2.6.7 MSI-X Update
In-Reply-To: <52y8mdd93y.fsf@topspin.com>
Message-ID: <Pine.LNX.4.58.0406240216170.3273@montezuma.fsmlabs.com>
References: <C7AB9DA4D0B1F344BF2489FA165E502405843FF0@orsmsx404.amr.corp.intel.com>
 <52y8mdd93y.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Roland Dreier wrote:

> I could imagine hardware where the driver does not know exactly how
> many vectors it will use until it starts up.  As a hypothetical
> example, imagine some storage networking host adapter that supports an
> interrupt vector per storage target.  The driver does not know how
> many vectors it will actually use until it has logged into the storage
> fabric; in fact, the driver may want to keep some vectors "in reserve"
> in case a new target is added to the fabric later.
>
> I think it would be better to preserve maximum flexibility for devices
> and drivers, and not mandate that every allocated MSI-X vector is
> always used.

The MSI subsystem should at most reserve and the driver make a request.
There may be a limit per PCI device as specified by the MSI subsystem for
some reason or other. Isn't this what we're all saying?

> It seems in the code right now you are able to tell if any MSI-X
> vectors are hooked, since you wait for the last vector to be unhooked
> to disable MSI-X.  I would just have it be a WARN_ON() (or maybe
> BUG_ON()) if a driver calls pci_disable_msix() without calling
> free_irq for all its MSI-X vectors.
>
> Right now there is an issue if a driver is unloaded without freeing
> all its IRQs -- the device will be left in MSI-X mode and can not be
> recovered without rebooting.

This sounds like a case of bad driver bug generally the kernel would oops
when the ISR text gets unloaded. What kind of behaviour do you expect
here?

> Also, drivers have a problem in their error paths right now with
> freeing MSI-X resources.  For example, suppose a driver successfully
> requests 4 MSI-X vectors.  request_irq() is a function call that can
> fail, for example if the kernel can't allocate memory.  What should
> the driver do if its second (out of 4) request_irq() call fails?
> There doesn't seem to be any way for it to proceed without leaking
> MSI-X resources.

I agree here, the request/free of vectors must be controllable in the
driver, this is one place where we may have to allow people to hang
themselves.

> Similarly, with the API as it stands in your patch, a driver must be
> very careful not to take any action that may fail in between calling
> pci_enable_msix() and actually calling request_irq(), or otherwise the
> only way to avoid leaking MSI-X resources is to take the very risky
> step of calling request_irq() on an error path.  This doesn't fit very
> well with the structure of lots of device drivers, for example Intel's
> very own e1000 driver, which wait until the device is actually opened
> to call request_irq().

Could you elaborate further here? Won't a matched pci_disable_msix() free
the necessary resources on failure?

> For your second point, I would have pci_disable_msix() always free all
> MSI-X vectors that have been allocated... the only parameter that I
> expect it would take is a struct pci_dev *.

If the driver is doing this, then we won't have to bother about
pci_disable_msix() doing the vector free surely?

Thanks Roland,
	Zwane
