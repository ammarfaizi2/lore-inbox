Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDDWyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDDWyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDDWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:54:49 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:46545 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261452AbVDDWml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:42:41 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Daniel Drake <dsd@gentoo.org>, Peter Baumann <waste.manager@gmx.de>
Subject: Re: [Fwd: Re: [Bug] invalid mac address after rebooting (kernel 2.6.11.5)]
Date: Tue, 5 Apr 2005 00:42:11 +0200
User-Agent: KMail/1.5.4
References: <424FF773.8070704@gentoo.org>
In-Reply-To: <424FF773.8070704@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       habraken@yahoo.com, greg@kroah.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504050042.11987.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 April 2005 16:02, Daniel Drake wrote:
> Peter Baumann wrote:
> > On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> > 
> >>Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> >>
> >>>
> >>>I'm hitting an annoying bug in kernel 2.6.11.5
> >>>
> >>>Every time I _reboot_ (warmstart) my pc my two network cards won't get
> >>>recognized any longer.
> >>>
> >>>Following error message appears on my screen:
> >>>
> >>>PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> >>>ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> >>>3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> >>>0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> >>>PCI: Setting latency timer of device 0000:00:0b.0 to 64
> >>>*** EEPROM MAC address is invalid.
> >>>3c59x: vortex_probe1 fails.  Returns -22
> >>>3c59x: probe of 0000:00:0b.0 failed with error -22
> >>>PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
> >>>ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
> >>>0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
> >>>PCI: Setting latency timer of device 0000:00:0d.0 to 64
> >>>*** EEPROM MAC address is invalid.
> >>>3c59x: vortex_probe1 fails.  Returns -22
> >>>3c59x: probe of 0000:00:0d.0 failed with error -22
> >>>
> >>>This doesn't happen with older kernels (especially with 2.6.10) and so
> >>>I've done a binary search and narrowed it down to 2.6.11-rc5 where it
> >>>first hits me.
> >>>
> >>>My config, lspci output and the dmesg output of the working and non-working
> >>>version can be found at [1]
> >>>
> >>>Feel free to ask if any information is missing or if I am supposed to try
> >>>a patch.
> >>
> >>Thanks for doing the bsearch - it helps.
> >>
> >>There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
> >>
> >>The only PCI change I see is
> >>
> >>--- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> >>+++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> >>@@ -268,7 +268,7 @@
> >>                return -EIO; 
> >> 
> >>        pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> >>-       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> >>+       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> >>                printk(KERN_DEBUG
> >>                       "PCI: %s has unsupported PM cap regs version (%u)\n",
> >>                       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> >>
> >>and you're not getting that message (are you?)
> >>
> > 
> > 
> > Reverting the above patch solved it.

nice. could i get dmesg output, lspci, lspci -vvvn output with the attached
patch applied?

thanks, rgds
-daniel

--- 1.81/drivers/pci/pci.c	2005-03-03 08:17:57 +01:00
+++ edited/drivers/pci/pci.c	2005-04-05 00:37:13 +02:00
@@ -268,7 +268,7 @@
 		return -EIO; 
 
 	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
-	if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
+	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		printk(KERN_DEBUG
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
 		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
@@ -287,15 +287,19 @@
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
-	if (dev->current_state >= PCI_D3hot)
+	printk("PCI: %s pmc: %04x, current_state: %08x, pmcsr: ", pci_name(dev), pmc, dev->current_state);
+	if (dev->current_state >= PCI_D3hot) {
 		pmcsr = 0;
-	else {
+		printk("0");
+	} else {
 		pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+		printk("%04x", pmcsr);
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
 	}
 
 	/* enter specified state */
+	printk(", new: %04x\n", pmcsr);
 	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
 
 	/* Mandatory power management transition delays */

