Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWBNQ2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWBNQ2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbWBNQ2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:28:10 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:12804 "EHLO
	bacchus.dhis.org") by vger.kernel.org with ESMTP id S1161122AbWBNQ2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:28:08 -0500
Date: Tue, 14 Feb 2006 16:23:57 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Greg KH <gregkh@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Mark E Mason <mark.e.mason@broadcom.com>
Subject: Re: PCI probe leaves master abort disabled in PCI_BRIDGE_CONTROL
Message-ID: <20060214162357.GB21016@linux-mips.org>
References: <20060213.171321.126221906.davem@davemloft.net> <20060214051700.GA28721@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214051700.GA28721@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:17:00PM -0800, Greg KH wrote:
> Date:	Mon, 13 Feb 2006 21:17:00 -0800
> From:	Greg KH <gregkh@suse.de>
> To:	"David S. Miller" <davem@davemloft.net>
> Cc:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
> 	linux-pci@atrey.karlin.mff.cuni.cz
> Subject: Re: PCI probe leaves master abort disabled in PCI_BRIDGE_CONTROL
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, Feb 13, 2006 at 05:13:21PM -0800, David S. Miller wrote:
> > 
> > In drivers/pci/probe.c:pci_scan_bridge(), if this is not the first
> > pass (pass != 0) we don't restore the PCI_BRIDGE_CONTROL_REGISTER and
> > thus leave PCI_BRIDGE_CTL_MASTER_ABORT off:
> > 
> > int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass)
> > {
> >  ...
> > 	/* Disable MasterAbortMode during probing to avoid reporting
> > 	   of bus errors (in some architectures) */ 
> > 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
> > 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> > 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
> >  ...
> > 	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
> > 		unsigned int cmax, busnr;
> > 		/*
> > 		 * Bus already configured by firmware, process it in the first
> > 		 * pass and just note the configuration.
> > 		 */
> > 		if (pass)
> > 			return max;
> >  ...
> > 	}
> > 
> > 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
> >  ...
> > 
> > This doesn't seem intentional.
> 
> No it doesn't.  Ralf added that code, way back in 2.6.2-rc2, with a
> patch description of "[PATCH] PCI: fix probing for some mips systems"
> 
> David, does this break some stuff on your boxes?
> 
> Ralf, any thoughts?  It was way back in January of 2004 that this change
> went in.

Agreed, looks like an accident.  The patch [1] originally came from Kip
Walker (Broadcom back then) between 2.6.0-test3 and 2.6.0-test4.  As I
recall it was supposed to fix an issue with with PCI aborts being
signalled by the PCI bridge of the Broadcom BCM1250 family of SOCs when
probing behind pci_scan_bridge.  It is undeseriable to disable
PCI_BRIDGE_CTL_MASTER_ABORT in pci_{read,write)_config_* and the
behaviour wasn't considered a bug in need of a workaround, so this was
put in probe.c.

I don't have an affected system at hand, so can't really test but I
propose something like the below patch.

  Ralf

[1] http://www.linux-mips.org/git?p=linux.git;a=commit;h=599457e0cb702a31a3247ea6a5d9c6c99c4cf195

[PCI] Avoid leaving MASTER_ABORT disabled permanently when returning from pci_scan_bridge.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index adfad4f..6de7c59 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -456,7 +456,7 @@ int __devinit pci_scan_bridge(struct pci
 		 * pass and just note the configuration.
 		 */
 		if (pass)
-			return max;
+			goto out;
 		busnr = (buses >> 8) & 0xFF;
 
 		/*
@@ -466,12 +466,12 @@ int __devinit pci_scan_bridge(struct pci
 		if (pci_find_bus(pci_domain_nr(bus), busnr)) {
 			printk(KERN_INFO "PCI: Bus %04x:%02x already known\n",
 					pci_domain_nr(bus), busnr);
-			return max;
+			goto out;
 		}
 
 		child = pci_add_new_bus(bus, dev, busnr);
 		if (!child)
-			return max;
+			goto out;
 		child->primary = buses & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
 		child->bridge_ctl = bctl;
@@ -496,7 +496,7 @@ int __devinit pci_scan_bridge(struct pci
 				   bus ranges. */
 				pci_write_config_dword(dev, PCI_PRIMARY_BUS,
 						       buses & ~0xffffff);
-			return max;
+			goto out;
 		}
 
 		/* Clear errors */
@@ -505,7 +505,7 @@ int __devinit pci_scan_bridge(struct pci
 		/* Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged */
 		if (pci_find_bus(pci_domain_nr(bus), max+1))
-			return max;
+			goto out;
 		child = pci_add_new_bus(bus, dev, ++max);
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
@@ -576,8 +576,6 @@ int __devinit pci_scan_bridge(struct pci
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
 
-	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
-
 	sprintf(child->name, (is_cardbus ? "PCI CardBus #%02x" : "PCI Bus #%02x"), child->number);
 
 	while (bus->parent) {
@@ -596,6 +594,9 @@ int __devinit pci_scan_bridge(struct pci
 		bus = bus->parent;
 	}
 
+out:
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
+
 	return max;
 }
 
