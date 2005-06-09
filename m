Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVFIXqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVFIXqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVFIXqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:46:04 -0400
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:56520 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262439AbVFIXpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:45:50 -0400
Message-ID: <42A8D586.4070903@stesmi.com>
Date: Fri, 10 Jun 2005 01:49:26 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Greg KH <gregkh@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Roland Dreier <roland@topspin.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com
Subject: Re: [Penance PATCH] PCI: clean up the MSI code a bit
References: <20050608063559.GA22869@suse.de> <20050608134109.GW23831@wotan.suse.de> <20050608171440.GD5908@colo.lackof.org> <20050608174548.GA3725@suse.de> <20050609141534.GF23831@wotan.suse.de>
In-Reply-To: <20050609141534.GF23831@wotan.suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

> Also see the proposals from Jeff/Stefan et.al. for simpler interfaces
> for this. No need to actually make it messy if we have nice helpers.

Could even be simplified one step closer.

My helper could simply be incorporated into pci_enable_msix().

pci_enable_msix(dev)
{
  if (is_dev_msi(dev)) {
    cur_status=MSI;
    pci_disable_msi(dev);
  }
  else if (is_dev_msix(dev))
    return(ALREADY_MSIX);
  else
    cur_status=OLD_FASHIONED;
  if (!__pci_enable_msix(dev))
    if (cur_status==MSI)
      pci_enable_msi(dev);
}

Add error-checking, etc, etc, etc.

Naturally pci_enable_msix() is renamed to __pci_enable_msix() in my
example. You can also just put it inside here, or whatever.

That way, if you want to enable msix and it fails, it will return
to whatever it was using before pci_enable_msix() was called.

Why this ALSO will work is that msi will already be enabled for devices
that handle it (I'm thinking of this together with making msi default).

That's why we cache the current status, so that we can return the device
to the previous state, be it normal or be it msi mode.

Hm. Can a device that fails MSI (due to any reason - NB not supporting
it or some other reason) go to MSIX mode at all?

If it can't, then it's even shorter.

pci_enable_msix(dev)
{
  if (is_dev_msi(dev))
    pci_disable_msi(dev);
  else if (is_dev_msix(dev))
    return(ALREADY_MSIX);
  else
    return(MSIX_NOT_AVAILABLE);
  if (!__pci_enable_msix(dev))
    pci_enable_msi(dev);
}

That way noone needs to explicitly turn off msi as it's done
automatically instead and the device will after this call
always be in either MSIX, MSI or NORMAL IRQ mode, and
always in the "best" mode the device, motherboard, bios, NB,
whatever combination is available.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCqNWGBrn2kJu9P78RAjvUAJsFS2yj15j34CWKyh3CJ9iSDMydpACfc2a5
MA7LncSpbj6tQHigOFmFmrQ=
=4bMK
-----END PGP SIGNATURE-----
