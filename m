Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUFXB4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUFXB4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUFXB4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:56:09 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:57459 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263731AbUFXBzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:55:44 -0400
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "long" <tlnguyen@snoqualmie.dp.intel.com>, <ak@muc.de>, <akpm@osdl.org>,
       <greg@kroah.com>, <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       <zwane@linuxpower.ca>, <eli@mellanox.co.il>
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E502405843FF0@orsmsx404.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 23 Jun 2004 18:42:57 -0700
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502405843FF0@orsmsx404.amr.corp.intel.com> (Tom
 L. Nguyen's message of "Wed, 23 Jun 2004 15:03:19 -0700")
Message-ID: <52y8mdd93y.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Jun 2004 01:42:57.0957 (UTC) FILETIME=[9395AD50:01C4598C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Long> It was my initial thought. However, below two reasons
    Long> convince me that the patch should enforce the rules to
    Long> ensure that the software device driver behaves properly.

    Long> -The software driver is responsible for asking how many
    Long> vectors it actually needs to serivce its hardward needs. Why
    Long> does it asks for more than what it actually uses?

I could imagine hardware where the driver does not know exactly how
many vectors it will use until it starts up.  As a hypothetical
example, imagine some storage networking host adapter that supports an
interrupt vector per storage target.  The driver does not know how
many vectors it will actually use until it has logged into the storage
fabric; in fact, the driver may want to keep some vectors "in reserve"
in case a new target is added to the fabric later.

I think it would be better to preserve maximum flexibility for devices
and drivers, and not mandate that every allocated MSI-X vector is
always used.

    Long> -Assuming I add pci_disable_msix() API, then there are two
    Long> consequences for this approach. It would be a problem for
    Long> the kernel to determine whether the MSI vectors are unhooked
    Long> cleanly from their corresponding driver ISR before freeing
    Long> these MSI vectors for reuse purpose on other devices. If
    Long> there is an error in the driver, it may result an unexpected
    Long> behavior. Second, for example if a driver asks for 10 MSI
    Long> vector for the first time and decides to call
    Long> pci_disable_msix() to free up 5. If the driver switches
    Long> interrupt mode back and forth, the next MSI request by
    Long> calling pci_enable_msix() will result 5 given instead of 10.

It seems in the code right now you are able to tell if any MSI-X
vectors are hooked, since you wait for the last vector to be unhooked
to disable MSI-X.  I would just have it be a WARN_ON() (or maybe
BUG_ON()) if a driver calls pci_disable_msix() without calling
free_irq for all its MSI-X vectors.

Right now there is an issue if a driver is unloaded without freeing
all its IRQs -- the device will be left in MSI-X mode and can not be
recovered without rebooting.

Also, drivers have a problem in their error paths right now with
freeing MSI-X resources.  For example, suppose a driver successfully
requests 4 MSI-X vectors.  request_irq() is a function call that can
fail, for example if the kernel can't allocate memory.  What should
the driver do if its second (out of 4) request_irq() call fails?
There doesn't seem to be any way for it to proceed without leaking
MSI-X resources.

Similarly, with the API as it stands in your patch, a driver must be
very careful not to take any action that may fail in between calling
pci_enable_msix() and actually calling request_irq(), or otherwise the
only way to avoid leaking MSI-X resources is to take the very risky
step of calling request_irq() on an error path.  This doesn't fit very
well with the structure of lots of device drivers, for example Intel's
very own e1000 driver, which wait until the device is actually opened
to call request_irq().

For your second point, I would have pci_disable_msix() always free all
MSI-X vectors that have been allocated... the only parameter that I
expect it would take is a struct pci_dev *.

 - Roland
