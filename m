Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030635AbWBPWHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbWBPWHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWBPWHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:07:01 -0500
Received: from cantor2.suse.de ([195.135.220.15]:45549 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932565AbWBPWHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:07:00 -0500
Date: Thu, 16 Feb 2006 23:06:56 +0100 (CET)
From: Bernhard Kaindl <bk@suse.de>
To: alan <alan@clueserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/Cardbus cards hidden, needs pci=assign-busses to fix
In-Reply-To: <1136555288.30498.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602162054020.13089@jbgna.fhfr.qr>
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
 <1136555288.30498.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"In some cases, especially on modern laptops with a lot of PCI and cardbus
bridges, we're unable to assign correct secondary/subordinate bus numbers
to all cardbus bridges due to BIOS limitations unless we are using
"pci=assign-busses" boot option." -- Ivan Kokshaysky (from a patch comment)

Without it, Cardbus cards inserted are never seen by PCI because the
parent PCI-PCI Bridge of the Cardbus bridge will not pass and translate
Type 1 PCI configuration cycles correctly and the system will fail to
find and initialise the PCI devices in the system.

Reference: PCI-PCI Bridges: PCI Configuration Cycles and PCI Bus Numbering:
http://www.science.unitn.it/~fiorella/guidelinux/tlk/node72.html

The reason for this is that:
 ``All PCI busses located behind a PCI-PCI bridge must reside between the
secondary bus number and the subordinate bus number (inclusive).''

"pci=assign-busses" makes pcibios_assign_all_busses return 1 and this
turns on PCI renumbering during PCI probing.

Alan suggested to use DMI to make that function cause that on problem systems:

On Fri, 6 Jan 2006, Alan Cox wrote:
[...]
> 
> Your system works if this is set to 1 ?
> 
> If so you might want to use the DMI layer to make that function return 0
> except for matches on problem systems.
> 
> Alan

It is trivial to do, simply match the problem systems using DMI and
set the PCI_ASSIGN_ALL_BUSSES bit which is returned by the function:

This is the initial, working patch which I put together using cut and paste
from ACPI init where it is used for ACPI blacklisting:

--- arch/i386/pci/common.c
+++ arch/i386/pci/common.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/dmi.h>
 
 #include <asm/acpi.h>
 #include <asm/segment.h>
@@ -120,11 +121,40 @@
 	pci_read_bridge_bases(b);
 }
 
+/*
+ * Enable renumbering of PCI bus# ranges to reach all PCI busses (Cardbus)
+ */
+static int __init assign_all_busses(struct dmi_system_id *d)
+{
+	pci_probe |= PCI_ASSIGN_ALL_BUSSES;
+		printk(KERN_INFO "%s detected: enabling PCI bus# renumbering"
+			" (pci=assign-busses)\n", d->ident);
+	return 0;
+}
+
+static struct dmi_system_id __initdata pciprobe_dmi_table[] = {
+	/*
+	 * Laptops which need pci=assign-busses to see Cardbus cards
+	 */
+#ifdef __i386__
+	{
+	 .callback = assign_all_busses,
+	 .ident = "Samsung X20 Laptop",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Samsung Electronics"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "SX20S"),
+		     },
+	 },
+#endif				/* __i386__ */
+	{}
+};
 
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
 	struct pci_bus *bus = NULL;
 
+	dmi_check_system(pciprobe_dmi_table);
+
 	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		if (bus->number == busnum) {
 			/* Already scanned */

Straightforward, I just copied everything from kernel/acpi/boot.c.

The only question for me was where to put it. I put it directly before
scanning PCI bus into pcibios_scan_root() because it's called from legacy,
acpi and numa and so it can be one place for all systems and configurations
which may need it.

AMD64 Laptops are also affected and fixed by assign-busses, and the code is
also incuded from arch/x86_64/pci/ that place will also work for x86_64 kernels,
I only ifdef'-ed the x86-only Laptop in this example.

Comments? - Can it be included in the next kernels?

Thanks,
Bernhard

PS:

Affected and known or assumed to be fixed with it are (found by googling):

* ASUS Z71V and L3s
* Samsung X20
* Compaq R3140us and all Compaq R3000 series laptops with TI1620 Controller,
  also Compaq R4000 series (from a kernel.org bugreport)
* HP zv5000z (AMD64 3700+, known that fixup_parent_subordinate_busnr fixes it)
* HP zv5200z
* IBM ThinkPad 240
* An IBM ThinkPad (1.8 GHz Pentium M) debugged by Pavel Machek
  gives the correspondig message which detects the possible problem.
* MSI S260 / Medion SIM 2100 MD 95600

Russell King wrote once:
>
> The assumption that the PCI BIOS will sanely assign the PCI bus numbers
> and that Linux does not need to reassign them is looking increasingly
> incorrect - most of the Cardbus "why can't the system see my card"
> are resolved by passing "pci=assign-busses", which causes the PCI
> subsystem to renumber all PCI busses.
>
> So far, no one who has tried this solution has reported any additional
> problems that I'm aware of.

Of course, I would not want to do this at this stage of the release.

To know if pci=assign-busses and the DMI check could fix your cardus,
you have two possibiltes. With kernels newer than 2.6.13.3, you look
closely at your boot messages (or dmesg output if they are still there)
to check if a message like this is there:

PCI: Bus #10 (-#13) may be hidden behind transparent bridge #02 (-#0f) (try 'pci=assign-busses') 

If you are running an older kernel, you can check your lspci output:

lspci -v| grep -e subor -e ^0|grep -B1 subor

If it looks like (output reduced to be more readable):

0000:00:1c.0 PCI bridge: PCI Express
        Bus: primary=00, secondary=02, subordinate=02

0000:00:1e.0 PCI bridge: Intel 82801 Mobile PCI Bridge
        Bus: primary=00, secondary=06, subordinate=06

0000:06:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II
        Bus: primary=06, secondary=07, subordinate=0a

In this example, the bus range (secordary to subordinate)
of the parent bridge of the CardBus Brige (in the middle)
is 06-06, but the bus range of the CardBus Brige below is
07-0a, and that is outside of 06-06, so the devices there
(you PCI Cardbus cards) cannot get the PCI messages.

The PCI bridge in the middle is the parent of the CardBus
bridge, because the CardBus bridge has primary=06, and that
is is within the bus rage of the PCI brige about (06-06).

That ment that Cardbus controller itself was detected, but
a PCI CardBus card inserted into get not PCI messages routed.

If your System is fixed with pci=assign-busses and works
flawlessy and dmidecode is installed (part of pmtools)
you can run this command to send me your system's DMI data
so that it can be added to the table and it will be possible
to enable it automatically on the systems where it's indicated
to use it:

su -c dmidecode | mail -s "This system works fine with pci=assign-busses" bk@suse.de

(best if you send the mail from an account where I can answer,
and any other way to get the output of dmidecode will work)

PPS:

I'd also like to suggest a patch like this for the detection function
to information with systems need pci=assign-busses into the DMI table:

--- drivers/pci/probe.c
+++ drivers/pci/probe.c
@@ -585,13 +585,15 @@
 		    (child->number > bus->subordinate) ||
 		    (child->number < bus->number) ||
 		    (child->subordinate < bus->number)) {
-			printk(KERN_WARNING "PCI: Bus #%02x (-#%02x) may be "
+			printk(KERN_WARNING "PCI: Bus #%02x (-#%02x) is "
 			       "hidden behind%s bridge #%02x (-#%02x)%s\n",
 			       child->number, child->subordinate,
 			       bus->self->transparent ? " transparent" : " ",
 			       bus->number, bus->subordinate,
 			       pcibios_assign_all_busses() ? " " :
 			       " (try 'pci=assign-busses')");
+			printk(KERN_WARNING "Please report the result to "
+			       "linux-kernel to fix this future(using DMI)");
 		}
 		bus = bus->parent;
 	}

(best may be a short dedicated email address instead of l-k)
