Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVHGJuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVHGJuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 05:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVHGJuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 05:50:15 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:7042 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751364AbVHGJuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 05:50:14 -0400
Date: Sun, 7 Aug 2005 13:49:59 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <iod00d@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, linville@tuxdriver.com,
       yhlu <yhlu.kernel@gmail.com>
Subject: Re: [openib-general] Re: mthca and LinuxBIOS
Message-ID: <20050807134959.A3847@jurassic.park.msu.ru>
References: <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com> <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com> <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org> <20050805220015.GA3524@suse.de> <Pine.LNX.4.58.0508051602350.3258@g5.osdl.org> <20050805235937.GK25121@esmail.cup.hp.com> <20050806043354.GA27352@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050806043354.GA27352@esmail.cup.hp.com>; from iod00d@hp.com on Fri, Aug 05, 2005 at 09:33:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 09:33:54PM -0700, Grant Grundler wrote:
> > ISTR making comments before about the offending patch on linux-pci mailing
> > list.  Is this the same patch that assumes pci_dev->resource[i] == BAR[i] ?
> 
> I meant the patch assume 1:1 for pci_dev->resource[i] and BAR[i].
> not that the two are equivalent.

This is correct assumption. For 64-bit BAR[i] only pci_dev->resource[i] is
valid, pci_dev->resource[i+1] slot is unused and contains zeroes in all
fields. So all we need is just to check that we're going to update a _valid_
resource.
[Though, if we ever want to support >4Gb bus allocations on 32-bit
architectures we need to make resource start and end fields u64.]

Ivan.

--- 2.6.13-rc5-git4/drivers/pci/setup-res.c	Sun Aug  7 12:08:23 2005
+++ linux/drivers/pci/setup-res.c	Sun Aug  7 13:27:54 2005
@@ -33,6 +33,11 @@ pci_update_resource(struct pci_dev *dev,
 	u32 new, check, mask;
 	int reg;
 
+	/* Ignore resources for unimplemented BARs and unused resource slots
+	   for 64 bit BARs. */
+	if (!res->flags)
+		return;
+
 	pcibios_resource_to_bus(dev, &region, res);
 
 	pr_debug("  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
@@ -67,7 +72,7 @@ pci_update_resource(struct pci_dev *dev,
 
 	if ((new & (PCI_BASE_ADDRESS_SPACE|PCI_BASE_ADDRESS_MEM_TYPE_MASK)) ==
 	    (PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_MEM_TYPE_64)) {
-		new = 0; /* currently everyone zeros the high address */
+		new = region.start >> 32;
 		pci_write_config_dword(dev, reg + 4, new);
 		pci_read_config_dword(dev, reg + 4, &check);
 		if (check != new) {
