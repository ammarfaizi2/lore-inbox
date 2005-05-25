Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVEYClq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVEYClq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVEYClp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:41:45 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10495 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262242AbVEYCla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:41:30 -0400
Message-Id: <200505250241.j4P2fJtP024511@dell.home>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: CONFIG_HOTPLUG, 2.4.x and ppc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 May 2005 22:41:18 -0400
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm dealing with a custom BRIDGE_OTHER chip, which has PCI devices
on the other side...the configuration cycles don't follow a standard, and
I'm trying to establish the bus behind the bridge when I install a module...
essentially I'm doing things similar to hotplug drivers...

I have no experience with hotplug drivers, but it appears to be incompatible
with the ppc architure...

Calling pci_do_scan_bus, it calls pcibios_fixup_bus.

In the 2.4 ppc kernels, pcibios_fixup_bus is defined to be:
void __init pcibios_fixup_bus(struct pci_bus *bus)

On intel, its defined to be:
void __devinit  pcibios_fixup_bus(struct pci_bus *bus)


Since pci_do_scan_bus needs CONFIG_HOTPLUG, this path is exercised,
and pcibios_fixup_bus isn't present on ppc after bootup...

This patch is necessary if we CONFIG_HOTPLUG on ppc...there seems
to be no reason why not -- others changes like this might be necessary...


:1 mleisner@santa 04:28:16; rcsdiff -r1.1 -u arch/ppc/kernel/pci.c
===================================================================
RCS file: arch/ppc/kernel/pci.c,v
retrieving revision 1.1
diff -u -r1.1 arch/ppc/kernel/pci.c
--- arch/ppc/kernel/pci.c       2005/05/18 19:08:09     1.1
+++ arch/ppc/kernel/pci.c       2005/05/24 19:23:33
@@ -1384,7 +1384,7 @@
        return start;
 }
 
-void __init pcibios_fixup_bus(struct pci_bus *bus)
+void  __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
        struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
        unsigned long io_offset;


The patch is wrt to 2.4.20, but 2.4.30 appears to have the same problem...




Marty Leisner
leisner@rochester.rr.com


