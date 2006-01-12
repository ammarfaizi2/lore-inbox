Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161297AbWALVWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbWALVWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWALVWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:22:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20916 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161283AbWALVWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:22:19 -0500
Date: Thu, 12 Jan 2006 16:22:05 -0500
From: Bill Nottingham <notting@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Daniel Drake <dsd@gentoo.org>, Jon Mason <jdmason@us.ibm.com>,
       mulix@mulix.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pcnet32 devices with incorrect trident vendor ID
Message-ID: <20060112212205.GA28395@devserv.devel.redhat.com>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Daniel Drake <dsd@gentoo.org>, Jon Mason <jdmason@us.ibm.com>,
	mulix@mulix.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <20060112175051.GA17539@us.ibm.com> <43C6C0E6.7030705@gentoo.org> <20060112205714.GK19769@parisc-linux.org> <20060112210559.GL19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112210559.GL19769@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (matthew@wil.cx) said: 
> On Thu, Jan 12, 2006 at 01:57:14PM -0700, Matthew Wilcox wrote:
> > On Thu, Jan 12, 2006 at 08:49:42PM +0000, Daniel Drake wrote:
> > > interesting:
> > > 
> > > http://forums.gentoo.org/viewtopic-t-420013-highlight-trident.html
> > > 
> > > The user saw the correct vendor ID (AMD) in 2.4, but when upgrading to 
> > > 2.6, it changed to Trident.
> > 
> > It looks to me like there used to be a quirk that knew about this bug
> > and fixed it.
> > 
> > The reason I say this is that the lspci -x dumps are the same -- both
> > featuring the wrong vendor ID.  Want to dig through 2.4 and look for
> > this quirk?
> 
> Oh -- found it.  It's still in 2.6:
> 
> static void
> fixup_broken_pcnet32(struct pci_dev* dev)
> {
>         if ((dev->class>>8 == PCI_CLASS_NETWORK_ETHERNET)) {
>                 dev->vendor = PCI_VENDOR_ID_AMD;
>                 pci_write_config_word(dev, PCI_VENDOR_ID, PCI_VENDOR_ID_AMD);
>         }
> }
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT, PCI_ANY_ID,                     
> fixup_broken_pcnet32);
> 
> Wonder why it isn't working now ... someone with a PPC box needs to check
> (a) whether this function is being called and (b) if it is called, why
> it's not doing what it's supposed to.

I remember looking at this a while back. I think the corrected information
is only being propagated to the 'vendor' file, and the write_config_word
isn't actually updating the 'config' entry in sysfs.

If you remove the "#if 0" from lib/sysfs.c in pciutils, it should
start reporting the corrected value in base lspci, etc.

Bill
