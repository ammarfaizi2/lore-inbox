Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTIHFhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 01:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTIHFhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 01:37:11 -0400
Received: from relay-1v.club-internet.fr ([194.158.96.112]:12733 "EHLO
	relay-1v.club-internet.fr") by vger.kernel.org with ESMTP
	id S261939AbTIHFg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 01:36:59 -0400
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] usb won't work with kernel 2.4.22
Date: Mon,  8 Sep 2003 07:36:58 CEST
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet3.1062999418.2284.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Sven_Köhler <>
>Subject: [BUG?] usb won't work with kernel 2.4.22
>Date Mon, 08 Sep 2003 04:20:15 +0200
[...]
>After upgrading from 2.4.21 to 2.4.22 my USB doens't work anymore.
lsusb doesn't show any devices - find /proc/bus/usb too.
[...]

I got the same probleme with K7S5A/SiS735 and it doesn't come from USB.
I found that the acpi upgrade between 2.4.22-rc2 and 2.4.22-rc3 break the USB detection. I made a fall-back diff about this.
I discussed about this with Andrew de Quincey on acpi mailing-list. His last acpi global patch correct this problem too but I don't know if it will be implemented.

Look at acpi archive (last week):
http://sourceforge.net/mailarchive/forum.php?forum_id=6102

Here is the fall back diff for this specific problem (2.4.22 and 2.4.23-pre3)

diff -ru linux-2.4.22-rc3/arch/i386/kernel/mpparse.c linux-2.4.22-rc2/arch/i386/kernel/mpparse.c
--- linux-2.4.22-rc3/arch/i386/kernel/mpparse.c 2003-09-03 02:14:22.000000000 +0900
+++ linux-2.4.22-rc2/arch/i386/kernel/mpparse.c 2003-09-03 02:32:54.000000000 +0900
@@ -1276,16 +1273,12 @@

                /* Need to get irq for dynamic entry */
                if (entry->link.handle) {
-                       irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &edge_level, &active_high_low);
+                       irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
                        if (!irq)
                                continue;
                }
-               else {
-                       /* Hardwired IRQ. Assume PCI standard settings */
+               else
                        irq = entry->link.index;
-                       edge_level = 1;
-                       active_high_low = 1;
-               }

                /* Don't set up the ACPI SCI because it's already set up */
                if (acpi_fadt.sci_int == irq)
diff -ru linux-2.4.22-rc3/drivers/acpi/pci_irq.c linux-2.4.22-rc2/drivers/acpi/pci_irq.c
--- linux-2.4.22-rc3/drivers/acpi/pci_irq.c     2003-09-03 02:14:27.000000000 +0900
+++ linux-2.4.22-rc2/drivers/acpi/pci_irq.c     2003-09-03 02:32:57.000000000 +0900
@@ -258,7 +253,7 @@
        }

        if (!entry->irq && entry->link.handle) {
-               entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, NULL, NULL);
+               entry->irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
                if (!entry->irq) {
                        ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Invalid IRQ link routing entry\n"));
                        return_VALUE(0);
diff -ru linux-2.4.22-rc3/drivers/acpi/pci_link.c linux-2.4.22-rc2/drivers/acpi/pci_link.c
--- linux-2.4.22-rc3/drivers/acpi/pci_link.c    2003-09-03 02:14:27.000000000 +0900
+++ linux-2.4.22-rc2/drivers/acpi/pci_link.c    2003-09-03 02:32:57.000000000 +0900
@@ -65,9 +65,6 @@

 struct acpi_pci_link_irq {
        u8                      active;                 /* Current IRQ */
-       u8                      edge_level;             /* All IRQs */
-       u8                      active_high_low;        /* All IRQs */
-       u8                      setonboot;
        u8                      possible_count;
        u8                      possible[ACPI_PCI_LINK_MAX_POSSIBLE];
 };
@@ -117,8 +114,6 @@
                        link->irq.possible[i] = p->interrupts[i];
                        link->irq.possible_count++;
                }
-               link->irq.edge_level = p->edge_level;
-               link->irq.active_high_low = p->active_high_low;
                break;
        }
        case ACPI_RSTYPE_EXT_IRQ:
@@ -137,8 +132,6 @@
                        link->irq.possible[i] = p->interrupts[i];
                        link->irq.possible_count++;
                }
-               link->irq.edge_level = p->edge_level;
-               link->irq.active_high_low = p->active_high_low;
                break;
        }
        default:
@@ -296,33 +290,28 @@
        if (!link || !irq)
                return_VALUE(-EINVAL);

-       /* We don't check irqs the first time around */
-       if (link->irq.setonboot) {
-               /* See if we're already at the target IRQ. */
-               if (irq == link->irq.active)
-                       return_VALUE(0);
-
-               /* Make sure the target IRQ in the list of possible IRQs. */
-               for (i=0; i<link->irq.possible_count; i++) {
-                       if (irq == link->irq.possible[i])
-                               valid = 1;
-               }
-               if (!valid) {
-                       ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Target IRQ %d invalid\n", irq));
-                       return_VALUE(-EINVAL);
-               }
+       /* See if we're already at the target IRQ. */
+       if (irq == link->irq.active)
+               return_VALUE(0);
+
+       /* Make sure the target IRQ in the list of possible IRQs. */
+       for (i=0; i<link->irq.possible_count; i++) {
+               if (irq == link->irq.possible[i])
+                       valid = 1;
+       }
+       if (!valid) {
+               ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Target IRQ %d invalid\n", irq));
+               return_VALUE(-EINVAL);
        }

        memset(&resource, 0, sizeof(resource));

-       /* NOTE: PCI interrupts are always level / active_low / shared. But not all
-          interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for
-          parameters */
+       /* NOTE: PCI interrupts are always level / active_low / shared. */
        if (irq <= 15) {
                resource.res.id = ACPI_RSTYPE_IRQ;
                resource.res.length = sizeof(struct acpi_resource);
-               resource.res.data.irq.edge_level = link->irq.edge_level;
-               resource.res.data.irq.active_high_low = link->irq.active_high_low;
+               resource.res.data.irq.edge_level = ACPI_LEVEL_SENSITIVE;
+               resource.res.data.irq.active_high_low = ACPI_ACTIVE_LOW;
                resource.res.data.irq.shared_exclusive = ACPI_SHARED;
                resource.res.data.irq.number_of_interrupts = 1;
                resource.res.data.irq.interrupts[0] = irq;
@@ -331,8 +320,8 @@
                resource.res.id = ACPI_RSTYPE_EXT_IRQ;
                resource.res.length = sizeof(struct acpi_resource);
                resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
-               resource.res.data.extended_irq.edge_level = link->irq.edge_level;
-               resource.res.data.extended_irq.active_high_low = link->irq.active_high_low;
+               resource.res.data.extended_irq.edge_level = ACPI_LEVEL_SENSITIVE;
+               resource.res.data.extended_irq.active_high_low = ACPI_ACTIVE_LOW;
                resource.res.data.extended_irq.shared_exclusive = ACPI_SHARED;
                resource.res.data.extended_irq.number_of_interrupts = 1;
                resource.res.data.extended_irq.interrupts[0] = irq;
@@ -438,23 +424,23 @@
                }
        }

-       return_VALUE(0);
-}
-
-static int acpi_pci_link_allocate(struct acpi_pci_link* link) {
-       int irq;
-       int i;
+       /*
+        * Pass #2: Enable boot-disabled Links at 'best' IRQ.
+        */
+       list_for_each(node, &acpi_link.entries) {
+               int             irq = 0;
+               int             i = 0;

-       ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
+               link = list_entry(node, struct acpi_pci_link, node);
+               if (!link || !link->irq.possible_count) {
+                       ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+                       continue;
+               }

-       if (link->irq.setonboot)
-               return_VALUE(0);
+               if (link->irq.active)
+                       continue;

-       if (link->irq.active) {
-               irq = link->irq.active;
-       } else {
                irq = link->irq.possible[0];
-       }

                /*
                 * Select the best IRQ.  This is done in reverse to promote
@@ -465,20 +451,16 @@
                                irq = link->irq.possible[i];
                }

-       /* Attempt to enable the link device at this IRQ. */
-       if (acpi_pci_link_set(link, irq)) {
-               printk(PREFIX "Unable to set IRQ for %s [%s] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off\n",
-                       acpi_device_name(link->device),
-                       acpi_device_bid(link->device));
-               return_VALUE(-ENODEV);
-       } else {
+               /* Enable the link device at this IRQ. */
+               acpi_pci_link_set(link, irq);
+
                acpi_irq_penalty[link->irq.active] += 100;
+
                printk(PREFIX "%s [%s] enabled at IRQ %d\n",
                        acpi_device_name(link->device),
                        acpi_device_bid(link->device), link->irq.active);
        }

-       link->irq.setonboot = 1;
        return_VALUE(0);
 }

@@ -486,9 +468,7 @@
 int
 acpi_pci_link_get_irq (
        acpi_handle             handle,
-       int                     index,
-       int*                    edge_level,
-       int*                    active_high_low)
+       int                     index)
 {
        int                     result = 0;
        struct acpi_device      *device = NULL;
@@ -514,17 +494,11 @@
                return_VALUE(0);
        }

-       if (acpi_pci_link_allocate(link)) {
-               return -ENODEV;
-       }
-
        if (!link->irq.active) {
                ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link disabled\n"));
                return_VALUE(0);
        }

-       if (edge_level) *edge_level = link->irq.edge_level;
-       if (active_high_low) *active_high_low = link->irq.active_high_low;
        return_VALUE(link->irq.active);
 }

diff -ru linux-2.4.22-rc3/include/acpi/acpi_drivers.h linux-2.4.22-rc2/include/acpi/acpi_drivers.h
--- linux-2.4.22-rc3/include/acpi/acpi_drivers.h        2003-09-03 02:14:36.000000000 +0900
+++ linux-2.4.22-rc2/include/acpi/acpi_drivers.h        2003-09-03 02:33:04.000000000 +0900
@@ -174,7 +174,7 @@
 #define ACPI_PCI_LINK_FILE_STATUS      "state"

 int acpi_pci_link_check (void);
-int acpi_pci_link_get_irq (acpi_handle handle, int index, int* edge_level, int* active_high_low);
+int acpi_pci_link_get_irq (acpi_handle handle, int index);
 int acpi_pci_link_init (void);
 void acpi_pci_link_exit (void);

Regards,

Jerome Pinot

