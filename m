Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUFXH2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUFXH2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 03:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUFXH2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 03:28:05 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:2721 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263980AbUFXH1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 03:27:54 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>, ak@muc.de, akpm@osdl.org,
       greg@kroah.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       eli@mellanox.co.il
Subject: Re: [PATCH]2.6.7 MSI-X Update
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E502405843FF0@orsmsx404.amr.corp.intel.com>
	<52y8mdd93y.fsf@topspin.com>
	<Pine.LNX.4.58.0406240216170.3273@montezuma.fsmlabs.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 24 Jun 2004 00:27:52 -0700
In-Reply-To: <Pine.LNX.4.58.0406240216170.3273@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Thu, 24 Jun 2004 02:37:29 -0400 (EDT)")
Message-ID: <52zn6tbekn.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Jun 2004 07:27:52.0324 (UTC) FILETIME=[C2637C40:01C459BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I think you may not have read Long's patch/API carefully, since
you seem to be misunderstanding my objection.  In any case...

    Roland> I could imagine hardware where the driver does not know
    Roland> exactly how many vectors it will use until it starts up.
    Roland> As a hypothetical example, imagine some storage networking
    Roland> host adapter that supports an interrupt vector per storage
    Roland> target.  The driver does not know how many vectors it will
    Roland> actually use until it has logged into the storage fabric;
    Roland> in fact, the driver may want to keep some vectors "in
    Roland> reserve" in case a new target is added to the fabric
    Roland> later.

    Roland> I think it would be better to preserve maximum flexibility
    Roland> for devices and drivers, and not mandate that every
    Roland> allocated MSI-X vector is always used.

    Zwane> The MSI subsystem should at most reserve and the driver
    Zwane> make a request.  There may be a limit per PCI device as
    Zwane> specified by the MSI subsystem for some reason or
    Zwane> other. Isn't this what we're all saying?

No, Long is actually saying that a driver must actually call
request_irq() on all the vectors that it is allocated.  I am saying
that this requirement is too stringent, since there may be devices and
drivers that cannot predict exactly how many MSI-X vectors they will
use during driver initialization.

    Roland> It seems in the code right now you are able to tell if any
    Roland> MSI-X vectors are hooked, since you wait for the last
    Roland> vector to be unhooked to disable MSI-X.  I would just have
    Roland> it be a WARN_ON() (or maybe BUG_ON()) if a driver calls
    Roland> pci_disable_msix() without calling free_irq for all its
    Roland> MSI-X vectors.

    Roland> Right now there is an issue if a driver is unloaded
    Roland> without freeing all its IRQs -- the device will be left in
    Roland> MSI-X mode and can not be recovered without rebooting.

    Zwane> This sounds like a case of bad driver bug generally the
    Zwane> kernel would oops when the ISR text gets unloaded. What
    Zwane> kind of behaviour do you expect here?

Yes, I agree, it is a bad driver bug if the driver is unloaded without
doing free_irq() on all the vectors it has done request_irq() on.
However, with Long's API, there is a problem if for example a device
driver does pci_enable_msix() and is allocated 2 vectors, then
correctly does request_irq()/free_irq() on one vector and doesn't
touch the second vector, and then is unloaded.  The device will be
left with MSI-X enabled and leak its vectors.

In the proposed API, since there is no pci_disable_msix() call, the
only way the driver can free its MSI-X vector is to actually do
request_irq()/free_irq() on it.

    Roland> Similarly, with the API as it stands in your patch, a
    Roland> driver must be very careful not to take any action that
    Roland> may fail in between calling pci_enable_msix() and actually
    Roland> calling request_irq(), or otherwise the only way to avoid
    Roland> leaking MSI-X resources is to take the very risky step of
    Roland> calling request_irq() on an error path.  This doesn't fit
    Roland> very well with the structure of lots of device drivers,
    Roland> for example Intel's very own e1000 driver, which wait
    Roland> until the device is actually opened to call request_irq().

    Zwane> Could you elaborate further here? Won't a matched
    Zwane> pci_disable_msix() free the necessary resources on failure?

Yes, a matched pci_disable_msix() would be exactly what is needed.
However, look at Long's patch -- there is no such function in the API
he is proposing.

    Roland> For your second point, I would have pci_disable_msix()
    Roland> always free all MSI-X vectors that have been
    Roland> allocated... the only parameter that I expect it would
    Roland> take is a struct pci_dev *.

    Zwane> If the driver is doing this, then we won't have to bother
    Zwane> about pci_disable_msix() doing the vector free surely?

I think the PCI core needs to know which vectors are in use and which
are free (and ready to assign to PCI devices that request them).

I believe the correct API/semantics for a device driver are:

	pci_enable_msix(dev, &entries, num_entries);
          /* On success, driver now has full use of the num_entries
             interrupt vectors returned through entries.  MSI-X enable
             bit is set in PCI header. */
          /* ... */
          /* driver freely does request_irq()/free_irq() on some or all
             vectors in entries while running. */
          /* ... */
        pci_disable_msix(dev);
          /* All handlers attached to MSI-X vectors must be removed with
             free_irq() before pci_disable_msi() call. */
          /* MSI-X enable bit is now cleared from PCI header, and all
             interrupt vectors are returned to the core for possible
             reallocation. */

The major change from Long's proposal is the addition of the
pci_disable_msix() function.

 - Roland
