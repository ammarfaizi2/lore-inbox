Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270487AbTGZV6F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTGZV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:58:05 -0400
Received: from lidskialf.net ([62.3.233.115]:8640 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270487AbTGZV54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:57:56 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Mika Liljeberg <mika.liljeberg@welho.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.6.0-test1: irq18 nobody cared! on Intel D865PERL motherboard
Date: Sat, 26 Jul 2003 23:13:08 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030714131240.21759.qmail@linuxmail.org> <1059256372.8484.9.camel@hades>
In-Reply-To: <1059256372.8484.9.camel@hades>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0zvI/3HuBaWinIx"
Message-Id: <200307262313.08819.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0zvI/3HuBaWinIx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 26 July 2003 22:52, Mika Liljeberg wrote:
> On Mon, 2003-07-14 at 16:12, Felipe Alfaro Solana wrote:
> > I'm having problems with an Intel D865PERL motherboard and Serial ATA
> > support. Everytime I boot my RHL9 box using 2.6.0-test1, I get an
> > "irq18 nobody cared!" error and then "Disabling IRQ #18". Any attempt
> > to access any of the SATA controllers makes the system hang and
> > spitting out problems with timings on the "hde" interface.
>
> I have the same problem with Abit IS7-E, which also has the i865PE
> chipset.
>
> Add "noirqdebug" to the kernel command line and you should be able to
> boot, although the irq will be firing continously until the device
> driver gets initialized and catches it.

Out of interest, do these boxes have an IO-APIC and are you using ACPI? If so, 
can you tell me if the attached patch helps?

These are exactly the symptoms I got without the attached patch (it fixes an 
IO-APIC setup bug with ACPI).

--Boundary-00=_0zvI/3HuBaWinIx
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.5.75-acpi-irqparams-final.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.5.75-acpi-irqparams-final.patch"

--- linux-2.5.75.orig/arch/i386/kernel/io_apic.c	2003-07-10 21:07:34.000000000 +0100
+++ linux-2.5.75-noprocfs/arch/i386/kernel/io_apic.c	2003-07-26 21:21:18.000000000 +0100
@@ -2313,7 +2313,7 @@
 }
 
 
-int io_apic_set_pci_routing (int ioapic, int pin, int irq)
+int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low)
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
@@ -2335,19 +2335,23 @@
 	entry.delivery_mode = INT_DELIVERY_MODE;
 	entry.dest_mode = INT_DEST_MODE;
 	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
-	entry.mask = 1;					 /* Disabled (masked) */
-	entry.trigger = 1;				   /* Level sensitive */
-	entry.polarity = 1;					/* Low active */
+	entry.trigger = edge_level;
+	entry.polarity = active_high_low;
+	entry.mask  = 1;
 
 	add_pin_to_irq(irq, ioapic, pin);
 
 	entry.vector = assign_irq_vector(irq);
 
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic, 
-		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
+		"IRQ %d Mode:%i Active:%i)\n", ioapic, 
+		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq, edge_level, active_high_low);
 
+	if (edge_level) {
 	irq_desc[irq].handler = &ioapic_level_irq_type;
+	} else {
+		irq_desc[irq].handler = &ioapic_edge_irq_type;
+	}
 
 	set_intr_gate(entry.vector, interrupt[irq]);
 
--- linux-2.5.75.orig/arch/i386/kernel/mpparse.c	2003-07-10 21:06:59.000000000 +0100
+++ linux-2.5.75-noprocfs/arch/i386/kernel/mpparse.c	2003-07-26 21:02:26.000000000 +0100
@@ -1065,7 +1065,7 @@
 
 	ioapic_pin = irq - mp_ioapic_routing[ioapic].irq_start;
 
-	io_apic_set_pci_routing(ioapic, ioapic_pin, irq);
+	io_apic_set_pci_routing(ioapic, ioapic_pin, irq, 1, 1); // Active low, edge triggered
 }
 
 #endif /*CONFIG_ACPI_HT_ONLY*/
@@ -1080,6 +1080,8 @@
 	int			ioapic_pin = 0;
 	int			irq = 0;
 	int			idx, bit = 0;
+        int                     edge_level = 0;
+        int                     active_high_low = 0;
 
 	/*
 	 * Parsing through the PCI Interrupt Routing Table (PRT) and program
@@ -1090,7 +1092,7 @@
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
 			if (!irq)
 				continue;
 		}
@@ -1130,7 +1132,7 @@
 
 		mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);
 
-		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq))
+		if (!io_apic_set_pci_routing(ioapic, ioapic_pin, irq, edge_level, active_high_low))
 			entry->irq = irq;
 
 		printk(KERN_DEBUG "%02x:%02x:%02x[%c] -> %d-%d -> IRQ %d\n",
--- linux-2.5.75.orig/drivers/acpi/pci_irq.c	2003-07-10 21:08:54.000000000 +0100
+++ linux-2.5.75-noprocfs/drivers/acpi/pci_irq.c	2003-07-26 21:05:19.000000000 +0100
@@ -249,7 +249,7 @@
 	}
 
 	if (!entry->irq && entry->link.handle) {
-		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+		entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
 		if (!entry->irq) {
 			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
 			return_VALUE(0);
@@ -389,7 +389,9 @@
 	}
 
 	/* Make sure all link devices have a valid IRQ. */
-	acpi_pci_link_check();
+	if (acpi_pci_link_check()) {
+		return_VALUE(-ENODEV);
+	}
 
 #ifdef CONFIG_X86_IO_APIC
 	/* Program IOAPICs using data from PRT entries. */
--- linux-2.5.75.orig/drivers/acpi/pci_link.c	2003-07-10 21:04:58.000000000 +0100
+++ linux-2.5.75-noprocfs/drivers/acpi/pci_link.c	2003-07-26 21:12:52.000000000 +0100
@@ -69,6 +69,8 @@
 
 struct acpi_pci_link_irq {
 	u8			active;			/* Current IRQ */
+	u8			edge_level;		/* All IRQs */
+	u8			active_high_low;	/* All IRQs */
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 };
@@ -118,6 +120,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+		link->irq.edge_level = p->edge_level;
+		link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	case ACPI_RSTYPE_EXT_IRQ:
@@ -136,6 +140,8 @@
 			link->irq.possible[i] = p->interrupts[i];
 			link->irq.possible_count++;
 		}
+	        link->irq.edge_level = p->edge_level;
+   	        link->irq.active_high_low = p->active_high_low;
 		break;
 	}
 	default:
@@ -310,13 +316,14 @@
 
 	memset(&resource, 0, sizeof(resource));
 
-	/* NOTE: PCI interrupts are always level / active_low / shared. */
+	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
+	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
+	   parameters */
 	if (irq <= 15) {
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
-		resource.res.data.irq.edge_level = ACPI_LEVEL_SENSITIVE;
-		resource.res.data.irq.active_high_low = ACPI_ACTIVE_LOW;
-		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
+		resource.res.data.irq.edge_level = link->irq.edge_level;
+		resource.res.data.irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
 	}
@@ -324,15 +331,15 @@
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
-		resource.res.data.extended_irq.edge_level = ACPI_LEVEL_SENSITIVE;
-		resource.res.data.extended_irq.active_high_low = ACPI_ACTIVE_LOW;
-		resource.res.data.extended_irq.shared_exclusive = ACPI_SHARED;
+		resource.res.data.extended_irq.edge_level = link->irq.edge_level;
+		resource.res.data.extended_irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
+	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
@@ -355,11 +362,13 @@
 	if (result) {
 		return_VALUE(result);
 	}
+   
 	if (link->irq.active != irq) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Attempt to enable at IRQ %d resulted in IRQ %d\n", 
 			irq, link->irq.active));
 		link->irq.active = 0;
+		acpi_ut_evaluate_object (link->handle, "__DIS", 0, NULL);	   
 		return_VALUE(-ENODEV);
 	}
 
@@ -455,15 +464,20 @@
 				irq = link->irq.possible[i];
 		}
 
-		/* Enable the link device at this IRQ. */
-		acpi_pci_link_set(link, irq);
-
+		/* Attempt to enable the link device at this IRQ. */
+		if (acpi_pci_link_set(link, irq)) {
+			printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off\n",
+				acpi_device_name(link->device),
+				acpi_device_bid(link->device));
+			return_VALUE(-ENODEV);
+		} else {
 		acpi_irq_penalty[link->irq.active] += 100;
 
 		printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
 			acpi_device_name(link->device),
 			acpi_device_bid(link->device), link->irq.active);
 	}
+	}
 
 	return_VALUE(0);
 }
@@ -472,7 +486,9 @@
 int
 acpi_pci_link_get_irq (
 	acpi_handle		handle,
-	int			index)
+	int			index,
+	int*			edge_level,
+	int*			active_high_low)
 {
 	int                     result = 0;
 	struct acpi_device	*device = NULL;
@@ -503,6 +519,8 @@
 		return_VALUE(0);
 	}
 
+	if (edge_level) *edge_level = link->irq.edge_level;
+	if (active_high_low) *active_high_low = link->irq.active_high_low;
 	return_VALUE(link->irq.active);
 }
 
--- linux-2.5.75.orig/include/acpi/acpi_drivers.h	2003-07-10 21:12:26.000000000 +0100
+++ linux-2.5.75-noprocfs/include/acpi/acpi_drivers.h	2003-07-26 20:59:45.000000000 +0100
@@ -60,7 +60,7 @@
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index);
+int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
 
 /* ACPI PCI Interrupt Routing (pci_irq.c) */
 
--- linux-2.5.75.orig/include/asm-i386/io_apic.h	2003-07-10 21:12:15.000000000 +0100
+++ linux-2.5.75-noprocfs/include/asm-i386/io_apic.h	2003-07-26 21:01:16.000000000 +0100
@@ -170,7 +170,7 @@
 extern int io_apic_get_unique_id (int ioapic, int apic_id);
 extern int io_apic_get_version (int ioapic);
 extern int io_apic_get_redir_entries (int ioapic);
-extern int io_apic_set_pci_routing (int ioapic, int pin, int irq);
+extern int io_apic_set_pci_routing (int ioapic, int pin, int irq, int edge_level, int active_high_low);
 #endif /*CONFIG_ACPI_BOOT*/
 
 #else  /* !CONFIG_X86_IO_APIC */

--Boundary-00=_0zvI/3HuBaWinIx--

