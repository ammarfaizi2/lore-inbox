Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUCCEh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUCCEfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:35:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:39810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262370AbUCCEWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:05 -0500
Subject: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
In-Reply-To: <20040303042034.GA17156@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:21:45 -0800
Message-Id: <10782877051959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1621, 2004/03/01 09:48:14-08:00, torben.mathiasen@hp.com

[PATCH] PCI Hotplug: Patch to get cpqphp working with IOAPIC

On Fri, Feb 13 2004, Sy, Dely L wrote:
> Since filling out the INTERRUPT_LINE is needed for systems running
> with legacy irqs and not needed for systems running with IO-APIC.  The

> possible
> solutions:
> 1) Best is there is a run-time check (a flag or an API call) that tells
>    whether the system is running on legacy mode or IO-APIC mode. Is there
>    such check that you know of?

Dan suggested that we look at what IRQ the hotplug controller has been
assigned in the MPS table. If its < 0x10 we're in legacy/mapped mode.
That would probaly work

> > >
> > > Do those servers work on 2.6.2 without my patch?
> > >
>
> > Yes
>
> They work but they get dev->irq = 9 or 11 in the APIC enabled mode.
> Correct?
>

Yes. All hot-added adapters get legacy IRQs like IRQ5 in the example
below where eth2 was added after bootup:


linux:~ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
0:     831113          0          0          0    IO-APIC-edge  timer
1:        255          0          0          0    IO-APIC-edge  i8042
2:          0          0          0          0          XT-PIC  cascade
5:          0          0          0          0          XT-PIC  eth2
8:          2          0          0          0    IO-APIC-edge  rtc
12:         92          0          0          0   IO-APIC-edge  i8042
14:         29          0          0          0   IO-APIC-edge  ide0
20:          0          0          0          0   IO-APIC-level cciss0
21:          0          0          0          0   IO-APIC-level cciss1
29:        107          0          0          0   IO-APIC-level eth0
30:       7702          0          0          0   IO-APIC-level aic7xxx
31:         30          0          0          0   IO-APIC-level aic7xxx
34:        336          0          0          0   IO-APIC-level
cpqphp.o, cpqphp.o
NMI:          0          0          0          0
LOC:     830760     830893     830892     830891
ERR:          0
MIS:          0

I attached a patch that does the legacy mode check that Dan suggested
and IRQs for hot-added adapters seems to be given out in the APIC range.


 drivers/pci/hotplug/cpqphp.h      |    1 
 drivers/pci/hotplug/cpqphp_core.c |    5 ++++
 drivers/pci/hotplug/cpqphp_ctrl.c |   47 +++++++++++++++++++-------------------
 drivers/pci/hotplug/cpqphp_pci.c  |   36 ++++++++++++++---------------
 4 files changed, 48 insertions(+), 41 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
--- a/drivers/pci/hotplug/cpqphp.h	Tue Mar  2 19:43:03 2004
+++ b/drivers/pci/hotplug/cpqphp.h	Tue Mar  2 19:43:03 2004
@@ -444,6 +444,7 @@
 
 /* Global variables */
 extern int cpqhp_debug;
+extern int cpqhp_legacy_mode;
 extern struct controller *cpqhp_ctrl_list;
 extern struct pci_func *cpqhp_slot_list[256];
 
diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	Tue Mar  2 19:43:03 2004
+++ b/drivers/pci/hotplug/cpqphp_core.c	Tue Mar  2 19:43:03 2004
@@ -49,6 +49,7 @@
 
 /* Global variables */
 int cpqhp_debug;
+int cpqhp_legacy_mode;
 struct controller *cpqhp_ctrl_list;	/* = NULL */
 struct pci_func *cpqhp_slot_list[256];
 
@@ -1169,6 +1170,10 @@
 	 */
 	// The next line is required for cpqhp_find_available_resources
 	ctrl->interrupt = pdev->irq;
+	if (ctrl->interrupt < 0x10) {
+		cpqhp_legacy_mode = 1;
+		dbg("System seems to be configured for Full Table Mapped MPS mode\n");
+	}
 
 	ctrl->cfgspc_irq = 0;
 	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &ctrl->cfgspc_irq);
diff -Nru a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
--- a/drivers/pci/hotplug/cpqphp_ctrl.c	Tue Mar  2 19:43:03 2004
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c	Tue Mar  2 19:43:03 2004
@@ -3020,33 +3020,34 @@
 				}
 			}
 		}		// End of base register loop
+		if (cpqhp_legacy_mode) {
+			// Figure out which interrupt pin this function uses
+			rc = pci_bus_read_config_byte (pci_bus, devfn, 
+				PCI_INTERRUPT_PIN, &temp_byte);
 
-#if !defined(CONFIG_X86_IO_APIC)
-		// Figure out which interrupt pin this function uses
-		rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_INTERRUPT_PIN, &temp_byte);
-
-		// If this function needs an interrupt and we are behind a bridge
-		// and the pin is tied to something that's alread mapped,
-		// set this one the same
-		if (temp_byte && resources->irqs && 
-		    (resources->irqs->valid_INT & 
-		     (0x01 << ((temp_byte + resources->irqs->barber_pole - 1) & 0x03)))) {
-			// We have to share with something already set up
-			IRQ = resources->irqs->interrupt[(temp_byte + resources->irqs->barber_pole - 1) & 0x03];
-		} else {
-			// Program IRQ based on card type
-			rc = pci_bus_read_config_byte (pci_bus, devfn, 0x0B, &class_code);
-
-			if (class_code == PCI_BASE_CLASS_STORAGE) {
-				IRQ = cpqhp_disk_irq;
+			// If this function needs an interrupt and we are behind a bridge
+			// and the pin is tied to something that's alread mapped,
+			// set this one the same
+			if (temp_byte && resources->irqs && 
+			    (resources->irqs->valid_INT & 
+			     (0x01 << ((temp_byte + resources->irqs->barber_pole - 1) & 0x03)))) {
+				// We have to share with something already set up
+				IRQ = resources->irqs->interrupt[(temp_byte + 
+					resources->irqs->barber_pole - 1) & 0x03];
 			} else {
-				IRQ = cpqhp_nic_irq;
+				// Program IRQ based on card type
+				rc = pci_bus_read_config_byte (pci_bus, devfn, 0x0B, &class_code);
+
+				if (class_code == PCI_BASE_CLASS_STORAGE) {
+					IRQ = cpqhp_disk_irq;
+				} else {
+					IRQ = cpqhp_nic_irq;
+				}
 			}
-		}
 
-		// IRQ Line
-		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_INTERRUPT_LINE, IRQ);
-#endif
+			// IRQ Line
+			rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_INTERRUPT_LINE, IRQ);
+		}
 
 		if (!behind_bridge) {
 			rc = cpqhp_set_irq(func->bus, func->device, temp_byte + 0x09, IRQ);
diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	Tue Mar  2 19:43:03 2004
+++ b/drivers/pci/hotplug/cpqphp_pci.c	Tue Mar  2 19:43:03 2004
@@ -151,32 +151,32 @@
  */
 int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
-#if !defined(CONFIG_X86_IO_APIC)	
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
 	struct pci_bus fakebus;
 
-	fakedev.devfn = dev_num << 3;
-	fakedev.bus = &fakebus;
-	fakebus.number = bus_num;
-	dbg("%s: dev %d, bus %d, pin %d, num %d\n",
-	    __FUNCTION__, dev_num, bus_num, int_pin, irq_num);
-	rc = pcibios_set_irq_routing(&fakedev, int_pin - 0x0a, irq_num);
-	dbg("%s: rc %d\n", __FUNCTION__, rc);
-	if (!rc)
-		return !rc;
+	if (cpqhp_legacy_mode) {
+		fakedev.devfn = dev_num << 3;
+		fakedev.bus = &fakebus;
+		fakebus.number = bus_num;
+		dbg("%s: dev %d, bus %d, pin %d, num %d\n",
+		    __FUNCTION__, dev_num, bus_num, int_pin, irq_num);
+		rc = pcibios_set_irq_routing(&fakedev, int_pin - 0x0a, irq_num);
+		dbg("%s: rc %d\n", __FUNCTION__, rc);
+		if (!rc)
+			return !rc;
 
-	// set the Edge Level Control Register (ELCR)
-	temp_word = inb(0x4d0);
-	temp_word |= inb(0x4d1) << 8;
+		// set the Edge Level Control Register (ELCR)
+		temp_word = inb(0x4d0);
+		temp_word |= inb(0x4d1) << 8;
 
-	temp_word |= 0x01 << irq_num;
+		temp_word |= 0x01 << irq_num;
 
-	// This should only be for x86 as it sets the Edge Level Control Register
-	outb((u8) (temp_word & 0xFF), 0x4d0);
-	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
-#endif
+		// This should only be for x86 as it sets the Edge Level Control Register
+		outb((u8) (temp_word & 0xFF), 0x4d0);
+		outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
+	}
 
 	return 0;
 }

