Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270612AbUJUEhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270612AbUJUEhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270581AbUJUEgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:36:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11714 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270557AbUJUEgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:36:05 -0400
Date: Thu, 21 Oct 2004 05:35:57 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, John Cherry <cherry@osdl.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
Message-ID: <20041021043557.GK23987@parcelfarce.linux.theplanet.co.uk>
References: <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org> <41770307.5060304@pobox.com> <20041021015522.GH23987@parcelfarce.linux.theplanet.co.uk> <41771813.8090204@pobox.com> <20041021022442.GI23987@parcelfarce.linux.theplanet.co.uk> <417720D6.1030908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417720D6.1030908@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 10:37:10PM -0400, Jeff Garzik wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> >IDGI.  Why do you insist on releasing these guys in library code?  Even
> 
> Because there are two distinct and separate models of port mapping/usage:
> 
> 1) A bunch of separate IO address spaces (PIO).  The "mapping" is 
> currently done in ata_pci_init_native_mode() and ata_pci_init_legacy_mode()
> 
> 2) One single linear address space (MMIO).  The mapping is done in the 
> low-level driver.
> 
> #1 is in the library because the logic is duplicated _precisely_, across 
> multiple host controllers, according to a hardware specification.
> 
> Thus, if the mapping is done in the library core, so should the unmapping.

Not really.  You are making the case for having a helper that would unmap
for case 1 and having it in the library, just as we do for mapping in that
case.  What you have is different, though - it's a single function that does
entire ->remove() for all (AFAICS) SATA drivers.

And that's where the problem is - decision on releasing resource should belong
to the driver; sure, it can and should use library helper, just as it did
when it was grabbing these resources.

Note, BTW, that current ata_pci_remove_one() is begging for trouble - for
one thing, it does iounmap() before we get to ata_scsi_release(), i.e.
ata_host_remove(), i.e. ->port_stop().   And the first look at the drivers
that provide ->port_stop() shows that ahci_port_stop() does readl()/writel()
on the ->mmio_base.  Oops...

free_irq() also looks fishy, BTW.  How about moving all that group past the
point where you are done with individual ports and merging it (and any other
unmapping we might want to do) into a single callback?  Depending on whether
->host_stop() is really needed early we might use ->host_stop for that...

Comments?


