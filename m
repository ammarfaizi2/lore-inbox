Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVDMT1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDMT1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVDMT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:27:21 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:38828 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261231AbVDMTZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:25:37 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Andrew Morton <akpm@osdl.org>,
       Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Date: Wed, 13 Apr 2005 21:24:04 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <20050412085922.GA6664@faui00u.informatik.uni-erlangen.de> <20050412020956.4c64cbb4.akpm@osdl.org>
In-Reply-To: <20050412020956.4c64cbb4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504132124.04871.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 April 2005 11:09, Andrew Morton wrote:
> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> >
> > On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> > > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> > > >
> > > > 
> > > > I'm hitting an annoying bug in kernel 2.6.11.5
> > > > 
> > > > Every time I _reboot_ (warmstart) my pc my two network cards won't get
> > > > recognized any longer.
> > > >
> > > > Following error message appears on my screen:
> > > >
> > > > PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> > > > ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > > > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> > > > PCI: Setting latency timer of device 0000:00:0b.0 to 64
> > > > *** EEPROM MAC address is invalid.
> > > > 3c59x: vortex_probe1 fails.  Returns -22
> > > > 3c59x: probe of 0000:00:0b.0 failed with error -22
> > > > PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
> > > > ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > > 0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
> > > > PCI: Setting latency timer of device 0000:00:0d.0 to 64
> > > > *** EEPROM MAC address is invalid.
> > > > 3c59x: vortex_probe1 fails.  Returns -22
> > > > 3c59x: probe of 0000:00:0d.0 failed with error -22
> > > >
> > > > This doesn't happen with older kernels (especially with 2.6.10) and so
> > > > I've done a binary search and narrowed it down to 2.6.11-rc5 where it
> > > > first hits me.
> > > >
> > > > My config, lspci output and the dmesg output of the working and non-working
> > > > version can be found at [1]
> > > >
> > > > Feel free to ask if any information is missing or if I am supposed to try
> > > > a patch.
> > >
> > > Thanks for doing the bsearch - it helps.
> > >
> > > There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
> > >
> > > The only PCI change I see is
> > >
> > > --- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> > > +++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> > > @@ -268,7 +268,7 @@
> > >                 return -EIO;
> > >
> > >         pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> > > -       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> > > +       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> > >                 printk(KERN_DEBUG
> > >                        "PCI: %s has unsupported PM cap regs version (%u)\n",
> > >                        dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> > >
> > > and you're not getting that message (are you?)
> > >
> > 
> > I have still the problem described above with 2.6.12-rc2-mm2 and
> > reverting the above patch solved it. And yes, now I get many of those
> > 
> > PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
> > PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
> > PCI: 0000:00:09.0 has unsupported PM cap regs version (1)
> > 
> > messages.
> > 
> 
> Yes, we need to work out what's going on here.
> 
> Daniel?

yes. i already posted a debugging patch and asked to have to dmesg output.
but no response. Message-Id: <200504050042.11987.daniel.ritz@gmx.ch>

i see two possibilities:
- it's not really writing to the PM registers but somewhere else (or it's
  writing some crap)
- the device hates when somebody writes the current state again
  (yes, there is a check for this but it's useless during boot). i have
  a patch for this but i didn't send it until now because i really like
  to see the debugging output first...attached anyway...

rgds
-daniel

------------------

[PATCH] PCI PM: read initial state from device

the PCI PM code tries not to write to the PM registers when there is no change
in state. this however fails when a device is initially set up. and because
some devices are broken they hate being forced to the state they are in. fix
it by reading the current state from the device itself. also does some other
things:
- support PCI PM CAP version 3 (as defined in PCI PM Interface Spec v1.2)
- add and export the function pci_get_power_state() to get it from the device
- pci.h defines "4" as D3cold while probe.c uses it for unknown state
- minor cleanups

--- 1.151/include/linux/pci.h	2005-02-03 19:08:22 +01:00
+++ edited/include/linux/pci.h	2005-04-09 00:49:42 +02:00
@@ -501,6 +501,7 @@
 #define PCI_D2	((pci_power_t __force) 2)
 #define PCI_D3hot	((pci_power_t __force) 3)
 #define PCI_D3cold	((pci_power_t __force) 4)
+#define PCI_UNKNOWN	((pci_power_t __force) 5)
 
 /*
  * The pci_dev structure is used to describe PCI devices.
@@ -822,6 +823,7 @@
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
+pci_power_t pci_get_power_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
--- 1.81/drivers/pci/pci.c	2005-03-03 08:17:57 +01:00
+++ edited/drivers/pci/pci.c	2005-04-09 01:02:15 +02:00
@@ -227,6 +227,28 @@
 }
 
 /**
+ * pci_get_power_state - Gets the power state of a PCI device
+ * @dev: PCI device
+ *
+ * RETURN VALUE:
+ * pci_power_t the current state
+ */
+pci_power_t pci_get_power_state(struct pci_dev *dev)
+{
+	int pm;
+	u16 pmcsr;
+
+	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	if (!pm)
+		return PCI_UNKNOWN;
+
+	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
+	pmcsr &= PCI_PM_CTRL_STATE_MASK;
+
+	return (pci_power_t) pmcsr;
+}
+
+/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to be suspended
  * @state: PCI power state (D0, D1, D2, D3hot, D3cold) we're entering
@@ -268,7 +290,7 @@
 		return -EIO; 
 
 	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
-	if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
+	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		printk(KERN_DEBUG
 		       "PCI: %s has unsupported PM cap regs version (%u)\n",
 		       pci_name(dev), pmc & PCI_PM_CAP_VER_MASK);
@@ -276,12 +298,10 @@
 	}
 
 	/* check if this device supports the desired state */
-	if (state == PCI_D1 || state == PCI_D2) {
-		if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
-			return -EIO;
-		else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
-			return -EIO;
-	}
+	if (state == PCI_D1 && !(pmc & PCI_PM_CAP_D1))
+		return -EIO;
+	else if (state == PCI_D2 && !(pmc & PCI_PM_CAP_D2))
+		return -EIO;
 
 	/* If we're in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
@@ -830,6 +850,7 @@
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
 
+EXPORT_SYMBOL(pci_get_power_state);
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
--- 1.80/drivers/pci/probe.c	2005-02-03 03:21:51 +01:00
+++ edited/drivers/pci/probe.c	2005-04-09 00:57:21 +02:00
@@ -563,7 +563,7 @@
 	    dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
 
 	/* "Unknown power state" */
-	dev->current_state = 4;
+	dev->current_state = PCI_UNKNOWN;
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
@@ -608,6 +608,9 @@
 		       pci_name(dev), class, dev->hdr_type);
 		dev->class = PCI_CLASS_NOT_DEFINED;
 	}
+
+	/* get the real power state from the device */
+	dev->current_state = pci_get_power_state(dev);
 
 	/* We found a fine healthy device, go go go... */
 	return 0;


