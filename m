Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUCYDfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbUCYDfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:35:23 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:16393
	"EHLO muru.com") by vger.kernel.org with ESMTP id S263147AbUCYDee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:34:34 -0500
Date: Wed, 24 Mar 2004 19:34:34 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: acpi-devel-request@lists.sourceforge.net, patches@x86-64.org, ak@suse.de,
       len.brown@intel.com, pavel@ucw.cz, ccheney@debian.org
Subject: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040325033434.GB8139@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi & Len,

Sorry for cross posting all over the place, I tried to CC some people who have
been bugged by this bug.

I finally got the IOAPIC working on my eMachines m6805 amd64 laptop with the
following patch. I have not tried it on any other machines, so can you guys
please check the sanity and make the necessary changes if needed?

This fixes at least ACPI bug 2090:

http://bugme.osdl.org/show_bug.cgi?id=2090

Might fix some other x86 VIA bugs too?

To turn it on, apic still needs to be specified in the kernel cmdline:

root=/dev/hda3 ro psmouse.proto=imps apic console=tty0

Now cat /proc/interrupts shows:

 0:      70843    IO-APIC-edge  timer
 1:          9    IO-APIC-edge  i8042
 2:          0          XT-PIC  cascade
 8:          0    IO-APIC-edge  rtc
10:          0   IO-APIC-level  acpi
12:         44    IO-APIC-edge  i8042
14:       2734    IO-APIC-edge  ide0
15:         19    IO-APIC-edge  ide1
17:          0   IO-APIC-level  yenta
18:          0   IO-APIC-level  eth0
21:        565   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
22:          0   IO-APIC-level  VIA8233
23:          6   IO-APIC-level  eth1
NMI:         12 
LOC:      70752 
ERR:          0
MIS:          0

And things are just working :)

Regards,

Tony

And here's the patch, it's against 2.6.5-rc2:


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-amd64-via-ioapic

diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	Wed Feb 25 21:11:46 2004
+++ b/drivers/acpi/pci_link.c	Wed Mar 24 18:47:48 2004
@@ -402,10 +402,8 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to read status\n"));
 		return_VALUE(result);
 	}
-	if (!link->device->status.enabled) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link disabled\n"));
-		return_VALUE(-ENODEV);
-	}
+	if (!link->device->status.enabled)
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link disabled: VIA chipset? Trying to continue\n"));
 
 	/* Make sure the active IRQ is the one we requested. */
 	result = acpi_pci_link_try_get_current(link, irq);
@@ -415,11 +413,9 @@
    
 	if (link->irq.active != irq) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
-			"Attempt to enable at IRQ %d resulted in IRQ %d\n", 
-			irq, link->irq.active));
-		link->irq.active = 0;
-		acpi_ut_evaluate_object (link->handle, "_DIS", 0, NULL);	   
-		return_VALUE(-ENODEV);
+			"Attempt to enable at IRQ %d resulted in IRQ %d: VIA chipset? Using irq %d\n", 
+			irq, link->irq.active, irq));
+		link->irq.active = irq;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));

--7JfCtLOvnd9MIVvH--
