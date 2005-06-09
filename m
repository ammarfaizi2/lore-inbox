Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVFIEvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVFIEvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 00:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVFIEvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 00:51:32 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:63673 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262131AbVFIEv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 00:51:29 -0400
Message-ID: <42A7CB87.40706@stesmi.com>
Date: Thu, 09 Jun 2005 06:54:31 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de> <1118129500.5497.16.camel@laptopd505.fenrus.org> <20050607161029.GB15345@suse.de>
In-Reply-To: <20050607161029.GB15345@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Greg.

>>>>* What if the driver writer does not want MSI enabled for their
>>>>  hardware (even though there is an MSI capabilities entry)?  Reasons
>>>>  include: overhead involved in initiating the MSI; no support in some
>>>>  versions of firmware (QLogic hardware).
>>>
>>>Yes, a very good point.  I guess I should keep the pci_enable_msi() and
>>>pci_disable_msi() functions exported for this reason.
>>>
>>
>>well... only pci_disable_msi() is needed for this ;)
> 
> I thought so too, until I looked at the IB driver :(
> 
> The issue is, if pci_enable_msix() fails, we want to fall back to MSI,
> so you need to call pci_enable_msi() for that (after calling
> pci_disable_msi() before calling pci_enable_msix(), what a mess...)
> 
> So we still need both functions, and for MSI-X, the logic involved in
> enabling it is horrible.  Let me see if this can be made saner...

Why not make pci_switch_to_msix() (yeah, horrible name) instead?

pci_switch_to_msix(dev)
{
  pci_disable_msi(dev);
  if (!psi_enable_msix(dev))
    pci_enable_msi(dev);
}

And it can naturally inform the caller if it failed or not.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCp8uHBrn2kJu9P78RAid6AKCqYFJM0+kg0JYIgOYQiHSHv5Cw0gCfQw8w
A+z+BYzzvfi4oaBl6isuaEM=
=qL+F
-----END PGP SIGNATURE-----
