Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVDNRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDNRme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVDNRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:42:34 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:35803 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261571AbVDNRmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:42:25 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [Bug] invalid mac address after rebooting (2.6.12-rc2-mm2)
Date: Thu, 14 Apr 2005 19:40:52 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <200504132124.04871.daniel.ritz@gmx.ch> <20050413224108.GA29349@faui00u.informatik.uni-erlangen.de>
In-Reply-To: <20050413224108.GA29349@faui00u.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504141940.53506.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 April 2005 00:41, Peter Baumann wrote:
> On Wed, Apr 13, 2005 at 09:24:04PM +0200, Daniel Ritz wrote:
> > On Tuesday 12 April 2005 11:09, Andrew Morton wrote:
> > > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> > > >
> > > > On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> > > > > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
> > > > > >
> > > > > > 
> > > > > > I'm hitting an annoying bug in kernel 2.6.11.5
> > > > > > 
> > > > > > Every time I _reboot_ (warmstart) my pc my two network cards won't get
> > > > > > recognized any longer.
> > > > > >
> > > > > > Following error message appears on my screen:
> > > > > >
> > > > > > PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
> > > > > > ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > > > > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > > > > > 0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
> > > > > > PCI: Setting latency timer of device 0000:00:0b.0 to 64
> > > > > > *** EEPROM MAC address is invalid.
> > > > > > 3c59x: vortex_probe1 fails.  Returns -22
> > > > > > 3c59x: probe of 0000:00:0b.0 failed with error -22
> > > > > > PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
> > > > > > ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
> > > > > > 0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
> > > > > > PCI: Setting latency timer of device 0000:00:0d.0 to 64
> > > > > > *** EEPROM MAC address is invalid.
> > > > > > 3c59x: vortex_probe1 fails.  Returns -22
> > > > > > 3c59x: probe of 0000:00:0d.0 failed with error -22
> > > > > >
> > > > > > This doesn't happen with older kernels (especially with 2.6.10) and so
> > > > > > I've done a binary search and narrowed it down to 2.6.11-rc5 where it
> > > > > > first hits me.
> > > > > >
> > > > > > My config, lspci output and the dmesg output of the working and non-working
> > > > > > version can be found at [1]
> > > > > >
> > > > > > Feel free to ask if any information is missing or if I am supposed to try
> > > > > > a patch.
> > > > >
> > > > > Thanks for doing the bsearch - it helps.
> > > > >
> > > > > There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
> > > > >
> > > > > The only PCI change I see is
> > > > >
> > > > > --- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> > > > > +++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> > > > > @@ -268,7 +268,7 @@
> > > > >                 return -EIO;
> > > > >
> > > > >         pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> > > > > -       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> > > > > +       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> > > > >                 printk(KERN_DEBUG
> > > > >                        "PCI: %s has unsupported PM cap regs version (%u)\n",
> > > > >                        dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> > > > >
> > > > > and you're not getting that message (are you?)
> > > > >
> > > > 
> > > > I have still the problem described above with 2.6.12-rc2-mm2 and
> > > > reverting the above patch solved it. And yes, now I get many of those
> > > > 
> > > > PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
> > > > PCI: 0000:00:0d.0 has unsupported PM cap regs version (1)
> > > > PCI: 0000:00:09.0 has unsupported PM cap regs version (1)
> > > > 
> > > > messages.
> > > > 
> > > 
> > > Yes, we need to work out what's going on here.
> > > 
> > > Daniel?
> > 
> > yes. i already posted a debugging patch and asked to have to dmesg output.
> > but no response. Message-Id: <200504050042.11987.daniel.ritz@gmx.ch>
> > 
> > i see two possibilities:
> > - it's not really writing to the PM registers but somewhere else (or it's
> >   writing some crap)
> > - the device hates when somebody writes the current state again
> >   (yes, there is a check for this but it's useless during boot). i have
> >   a patch for this but i didn't send it until now because i really like
> >   to see the debugging output first...attached anyway...
> > 
> > rgds
> > -daniel
> > 
> > ------------------
> > 
> > [PATCH] PCI PM: read initial state from device
> > 
> > the PCI PM code tries not to write to the PM registers when there is no change
> > in state. this however fails when a device is initially set up. and because
> > some devices are broken they hate being forced to the state they are in. fix
> > it by reading the current state from the device itself. also does some other
> > things:
> > - support PCI PM CAP version 3 (as defined in PCI PM Interface Spec v1.2)
> > - add and export the function pci_get_power_state() to get it from the device
> > - pci.h defines "4" as D3cold while probe.c uses it for unknown state
> > - minor cleanups
> > 
> 
> [patch snipped]
> 
> I tried your patch with 2.6.12-rc2-mm3 (did not apply cleanly, I have
> applied one hunk per hand) and here is a diff of the dmesg of a
> working/non-working version. If I should try something else, then tell
> me and I will do.
> 
> The full dmesg output can be obtained from
> 
> http://wwwcip.informatik.uni-erlangen.de/~siprbaum/kernel/2.6.12-rc2-mm3_firstboot.txt
> http://wwwcip.informatik.uni-erlangen.de/~siprbaum/kernel/2.6.12-rc2-mm3_secondboot.txt
> 

could you apply this debuggin patch instead and send me the dmsg output
plus output from lspci, lspci -vvvn. also please send me a hexdump from
/proc/bus/pci/00/0b.0

i think i'm having some 3coms around so maybe i can reprocude :)

rgds
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
+	printk("PCI: %s pmc: %04x, current_state, pmcsr: %08x", pci_name(dev), pmc, dev->current_state);
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

