Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbTICB3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbTICB3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:29:07 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:9220 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263714AbTICB26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:28:58 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.6.0-test4: Tested the Power Management Update
Date: Wed, 3 Sep 2003 09:27:18 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0309021625310.9537-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0309021625310.9537-100000@localhost.localdomain>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309030927.18137.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 07:28, Patrick Mochel wrote:
> > 5) MAJOR UNCHANGED: (ACPI routed) PCI interrupt links still stay dead
> > on S3 resume as their state was lost upon powerdown of the router and
> > on resume USB, Network and PCMCIA/Yenta are dead.
> >
> > I had posted a patch earlier to set all links again in ACPI prior to
> > resuming devices, Russell said it was discussed at OLS, what will be
> > done about it?
>
> Sorry, I completely forgot about this. Would you please send me the patch
> again? It's ok if it's old and doesn't apply. We'll get it worked out and
> fixed.
>

This message of 18 July refers to and patch is against 2.6.0-test1.

Current implementation:

- Looses PCI IRQ links on resume from 
  ACPI S1-S4 when the router was powered down. 
  This results in nonfunctional PCI IRQ's 
  after S3 for example.

- Does not set PCI IRQ links claimed to be set by BIOS,
  which results in the IRQ not working when BIOS did
  not really set it or when setting was "lost".
 
- BIOS enabled IRQ's are frequently reused resulting in 2 
  links being assigned to the same IRQ while other 
  IRQ's remain available and unused.

This patch:

1) Always sets ACPI-routed PCI interrupt links regardless of whether 
link is claimed to be set by BIOS already. 

2) Restores ACPI-routed PCI interrupt links on resume from ACPI S1-S4

3) Prevents BIOS-enabled IRQ's being reused by BIOS-disabled IRQ's

On my system, all PCI interrupts are now routed without conflicts 
and functional on resume. yenta_socket and e100 resume fine. 
ohci-hcd must be reloaded, as it's interrupt handler does not 
survive suspending.

===== include/acpi/acpi_drivers.h 1.15 vs edited =====
--- 1.15/include/acpi/acpi_drivers.h    Wed Jun 25 05:16:55 2003
+++ edited/include/acpi/acpi_drivers.h  Fri Jul 18 17:49:16 2003
@@ -59,6 +59,7 @@
 
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
+int acpi_pci_links_set (void);
 int acpi_pci_link_check (void);
 int acpi_pci_link_get_irq (acpi_handle handle, int index);
 
===== drivers/acpi/sleep/main.c 1.24 vs edited =====
--- 1.24/drivers/acpi/sleep/main.c      Wed Jul  9 06:13:14 2003
+++ edited/drivers/acpi/sleep/main.c    Fri Jul 18 18:11:31 2003
@@ -264,7 +264,10 @@
        acpi_leave_sleep_state(state);
        acpi_system_restore_state(state);
 
-       /* make sure interrupts are enabled */
+       /* Resume pci interrupt links */
+       acpi_pci_links_set();
+
+  /* make sure interrupts are enabled */
        ACPI_ENABLE_IRQS();
 
        /* reset firmware waking vector */
===== drivers/acpi/pci_link.c 1.15 vs edited =====
--- 1.15/drivers/acpi/pci_link.c        Fri Feb 28 08:24:14 2003
+++ edited/drivers/acpi/pci_link.c      Fri Jul 18 17:51:16 2003
@@ -294,10 +294,6 @@
        if (!link || !irq)
                return_VALUE(-EINVAL);
 
-       /* See if we're already at the target IRQ. */
-       if (irq == link->irq.active)
-               return_VALUE(0);
-
        /* Make sure the target IRQ in the list of possible IRQs. */
        for (i=0; i<link->irq.possible_count; i++) {
                if (irq == link->irq.possible[i])
@@ -368,7 +364,6 @@
        return_VALUE(0);
 }
 
-
 /* --------------------------------------------------------------------------
                             PCI Link IRQ Management
    -------------------------------------------------------------------------- */
@@ -396,6 +391,42 @@
          10000,   100000,   100000,   100000,
 };
 
+/*
+ * acpi_pci_links_set sets all PCI IRQ links 
+ *   on completion of acpi_pci_link_check 
+ * or 
+ *   on resume from S1-S4 as the PCI IRQ router
+ *   may have lost power
+ * W
+ */
+
+int
+acpi_pci_links_set (void)
+{
+       int result = 0;
+
+       struct list_head        *node = NULL;
+       struct acpi_pci_link    *link = NULL;
+
+       ACPI_FUNCTION_TRACE("acpi_pci_links_set");
+
+       list_for_each(node, &acpi_link.entries) {
+
+               link = list_entry(node, struct acpi_pci_link, node);
+               if (!link) {
+                       ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
+                       continue;
+               }
+
+               if (link->irq.active) {
+                       printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
+                               acpi_device_name(link->device),
+                               acpi_device_bid(link->device), link->irq.active);
+                       result |= acpi_pci_link_set(link, link->irq.active) != 0;
+               }
+       }
+       return_VALUE(result ? -ENODEV : 0);
+}
 
 int
 acpi_pci_link_check (void)
@@ -417,8 +448,9 @@
                        continue;
                }
 
-               if (link->irq.active)
-                       acpi_irq_penalty[link->irq.active] += 100;
+               /* Never use an active IRQ */
+               if (link->irq.active) 
+                       acpi_irq_penalty[link->irq.active] = 1000000;
                else if (link->irq.possible_count) {
                        int penalty = 100 / link->irq.possible_count;
                        for (i=0; i<link->irq.possible_count; i++) {
@@ -432,7 +464,6 @@
         * Pass #2: Enable boot-disabled Links at 'best' IRQ.
         */
        list_for_each(node, &acpi_link.entries) {
-               int             irq = 0;
                int             i = 0;
 
                link = list_entry(node, struct acpi_pci_link, node);
@@ -441,33 +472,27 @@
                        continue;
                }
 
-               if (link->irq.active)
+               /* Never use BIOS enabled IRQ's */
+               if (link->irq.active) 
                        continue;
-
-               irq = link->irq.possible[0];
+               link->irq.active = link->irq.possible[0];
 
                /* 
                 * Select the best IRQ.  This is done in reverse to promote 
                 * the use of IRQs 9, 10, 11, and >15.
                 */
                for (i=(link->irq.possible_count-1); i>0; i--) {
-                       if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-                               irq = link->irq.possible[i];
+                       if (acpi_irq_penalty[link->irq.active] > acpi_irq_penalty[link->irq.possible[i]])
+                               link->irq.active = link->irq.possible[i];
                }
 
-               /* Enable the link device at this IRQ. */
-               acpi_pci_link_set(link, irq);
-
-               acpi_irq_penalty[link->irq.active] += 100;
-
-               printk(PREFIX "%s [%s] enabled at IRQ %d\n", 
-                       acpi_device_name(link->device),
-                       acpi_device_bid(link->device), link->irq.active);
+               /* Never re-use an activated IRQ */
+               acpi_irq_penalty[link->irq.active] = 1000000;
        }
-
-       return_VALUE(0);
+       
+       /* Now set all links */
+       return acpi_pci_links_set();
 }
-
 
 int
 acpi_pci_link_get_irq (


> > 6) MINOR UNCHANGED: As to the mouse, i8042 does not resume, so I
> > config i8042 as a module and reload it on resume. However, current
> > drivers/input/serio/Kconfig makes this impossible, which I whined
> > about a few times already ;)
>
> I presume by your later message you got this worked out ok?
>

After biting my lower rear portion again - (last time was with 
logbuffer size = 256), but here is no documentation to read...

Could there be another menu to select system type when x86

-Standard-PC EMBEDDED=0 X86=1, MMU=1, VID16=1, SBUS=0, GENERIC_ISA_DMA=1

  Use this for ease of configuration in most PC applications.

-Custom-PC EMBEDDED=0 X86=0, MMU=1, VID16=1, SBUS=0, GENERIC_ISA_DMA=1

  Use this in specialized PC applications to enable less
  frequently used configuration options.
  Beware that this requires more intricate knowledge of PC 
  hardware and the kernel subsystems

-Embedded EMBEDDED=1 X86=0, MMU=user, VID16=user, SBUS=user, GENERIC_ISA_DMA=user 

  Use this option when running the kernel on an embedded system to
  maximize configuration capability. This option is generally unsuitable
  in PC applications.

Regards
Michael

