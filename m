Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754709AbWKMOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbWKMOIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 09:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbWKMOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 09:08:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52899 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1754709AbWKMOIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 09:08:47 -0500
Date: Mon, 13 Nov 2006 14:14:00 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Remi <remi.colinet@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
Message-ID: <20061113141400.12ff22be@localhost.localdomain>
In-Reply-To: <1163425477.455876c5637f6@imp4-g19.free.fr>
References: <1163425477.455876c5637f6@imp4-g19.free.fr>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 14:44:37 +0100
Remi <remi.colinet@free.fr> wrote:

> => Step 1 : with the patch applied, the resource of the pci device
> dev->resource[x] are initialized to claim legacy I/O ports from 0x01f0 up to
> 0x01f7 with the flag IORESOURCE_IO (drivers/pci/probe.c).

This is correct behaviour. The resource addresses are implied resources.

> => Step 2 : then, these resources are allocated from the I/O port resources, by
> pcibios_allocate_resources (arch/i386/pci/i386.c).

That is correct, the implied resources end up in the tree as they should
so we now have a correct map of the PCI resources

> which requests the same resources but with the IORESOURCE_BUSY flag. I/O ports
> resources are then :
> 
> 01f0-01f7 : 0000:00:1f.2
>     01f0-01f7 : libata

This is an ugly hack that is done by the libata code to deal with old v
new IDE handling. All is still correct however
> 
> => Step 4 : then the libata tries to allocate once more the same ressources and
> fails.
> 
> [<f00e3eed>] ata_pci_init_one+0xad/0x423 [libata]
>  [<f001f9c1>] piix_init_one+0x4b7/0x4d4 [ata_piix]

ata_pci_init_one should have followed the legacy_mode path at this point,
and the legacy mode path should not be trying to request the legacy
regions the quirk code already reserved.

I suspect the code should only do the pci_request_regions() call if the
device on if (!legacy_mode), and the legacy code should
pci_request_region(pdev, 4, ...);



