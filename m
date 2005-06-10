Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVFJPxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVFJPxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbVFJPxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:53:23 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:43730 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262579AbVFJPwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:52:51 -0400
Message-ID: <42A9B80C.4030308@stesmi.com>
Date: Fri, 10 Jun 2005 17:55:56 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
CC: Andi Kleen <ak@suse.de>, Greg KH <gregkh@suse.de>,
       Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Roland Dreier <roland@topspin.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [Penance PATCH] PCI: clean up the MSI code a bit
References: <C7AB9DA4D0B1F344BF2489FA165E502408DF0142@orsmsx404.amr.corp.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502408DF0142@orsmsx404.amr.corp.intel.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tom.

>>pci_enable_msix(dev)
>>{
>> if (is_dev_msi(dev))
>>   pci_disable_msi(dev);
>> else if (is_dev_msix(dev))
>>   return(ALREADY_MSIX);
>> else
>>   return(MSIX_NOT_AVAILABLE);
>> if (!__pci_enable_msix(dev))
>>   pci_enable_msi(dev);
>>}
>>
>>That way noone needs to explicitly turn off msi as it's done
>>automatically instead and the device will after this call
>>always be in either MSIX, MSI or NORMAL IRQ mode, and
>>always in the "best" mode the device, motherboard, bios, NB,
>>whatever combination is available.
> 
> 
> Your logic does not work because existing MSI/MSI-X code does not allow
> a driver to switch back and forth between MSI mode and MSI-X mode. A
> driver can switch interrupt mode between NORMAL IRQ mode and MSI mode or
> between NORMAL IRQ mode and MSI-X mode but NOT between MSI mode and
> MSI-X mode. A device driver should know well which MSI mode or MSI-X
> mode it wants to run when its device supports both MSI and MSI-X
> capability structures. Please read MSI-HOWTO before any attempt. If you
> like to continue this path, then think of a better policy of how to
> manage vector sources for MSI and MSI-X allocation before making
> changes.

I know about the different capability structures, but the function
as listed above really "only" makes a few changes.

Currently, with legacy irq mode, the driver calls
pci_enable_msix(dev, .., ..);
and that's it.

If we default to MSI mode, then that is replaced by
pci_disable_msi(dev); pci_enable_msix(dev, .., ..);
with any error checking required, etc.

If we implement an error code for each of the cases, so that
the driver KNOWS which mode it's in after pci_enable_msix() is called
I don't see a difference. I'm not an expert on the subject and likely
missing things but ..

If we could successfully change from msi to msix mode we get a normal
zero return code from pci_enable_msix(), however if we ended up in
msi mode we could have a new return code indicating that we're now in
msi mode and if we ended up with legacy IRQ mode we have another one
telling us that. The problem as I see it is that we then don't get the
other error codes from pci_enable_msix(). Takes some thinking I guess.
Only solution I see, if we want to be able to pass the error code as
well as which mode we ended up in (if not msix), is either another
argument to pci_enable_msix, changing
int pci_enable_msix(struct pci_dev *dev, u32 *entries, int nvec)
to
int pci_enable_msix(struct pci_dev *dev, u32 *entries, int nvec, int *mode)
where mode is for instance 0 for msix, 1 for msi and 2 for legacy irq.
We could also have "mode" be a mask of what we support at all.

for instance the device driver would do:

mode = MSIX|LEGACY_IRQ;
pci_enable_msix(dev, entries, nvec, &mode);
where mode would be overwritten with the mode we ended up in.

Tell me I'm missing something here. This doesn't feel like too different
to the logic the driver must ALREADY have, since it ALREADY must know
how to fall back to legacy irq mode.

if (pci_enable_msix(dev, entries, nvec) < 0) {
  if (pci_enable_msi(dev) < 0)
   ...
  ...
}
This is all changed to

if (pci_enable_msix(dev, entries, nvec, mode) < 0) {
  if (mode==MSI)
    ..
  else if (mode==LEGACY_IRQ)
    ..
}

Or am I really not thinking straight?

The logic should be already there in the driver beforehand, so it's just
slightly different way of knowing it.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCqbgMBrn2kJu9P78RArWwAKCPk+xZcqhMfFybHztNUqwvSrOJagCgn0O2
EhWG6p+wb/b1cKtPLJU1vzc=
=AgYC
-----END PGP SIGNATURE-----
