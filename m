Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTJTXtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbTJTXtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:49:51 -0400
Received: from aneto.able.es ([212.97.163.22]:30377 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262942AbTJTXs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:48:58 -0400
Date: Tue, 21 Oct 2003 01:48:55 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: ACPI vs ServerWorksLE in 2.4.23-pre
Message-ID: <20031020234855.GC7429@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have discovered a little proble with ACPI. If I enable ACPI in a SuperMicro
P3TDLE the kernel does not see the 64 bit PCI bus (bus number 1).

It looks the same in -pre5 and -pre7.
The dmesg+lspci info that I have collected is at
http://giga.cps.unizar.es/~magallon/linux/acpi/
They are dmesg's for pre5 and pre7, just with HT_ONLY (and ACPI disabled in
-pre7, so as it is an SMP kernel I just get ACPI_BOOT), and with ACPI
enabled. There is also the diff between -pre7 and -pre7-acpi.

Some things:
- Without full ACPI, I see the pci 1 bus:
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:04.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev 0b)
00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:02.0 Ethernet controller: Intel Corp. 82543GC Gigabit Ethernet Controller (Copper) (rev 02)

- With ACPI, I do not see it.

- If try to boot with pci=noacpì, both kernels fail to initialize interrupts for
  the network cards (and perhaps more things), ifup takes an eon to timeout
  and the net cards do not work. This is cured by the patch posted by
  Thomas Schlichter <schlicht@uni-mannheim.de>:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=106616752330476&w=2
  With this, pci=noacpi works and the system is fine.

In the diff from -pre7 to -pre7-acpi I can see things like:
...
 IRQ7 -> 0:7
 IRQ8 -> 0:8
 IRQ9 -> 0:9
+IRQ10 -> 0:10
+IRQ11 -> 0:11
 IRQ12 -> 0:12
 IRQ13 -> 0:13
 IRQ14 -> 0:14
 IRQ15 -> 0:15
-IRQ26 -> 1:10
-IRQ31 -> 1:15
...
+PCI: Probing PCI hardware
+    ACPI-1120: *** Error: Method execution failed [\_SB_.LNUS._SRS] (Node f7a11860), AE_AML_BUFFER_LIMIT
+ACPI: Retrying with extended IRQ descriptor
+ACPI: Unable to set IRQ for PCI Interrupt Link [LNUS] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
...
+ACPI: Retrying with extended IRQ descriptor
+ACPI: Unable to set IRQ for PCI Interrupt Link [LNUS] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off

One other chipset to blacklist ?

This rises one other problem. For all people who upgrade from .22 to .23,
and have HT_ONLY, they will end with full ACPI active, and perhaps hit a buggy
BIOS. And their boxes will be unusable.
Would not be useful to maintain something like this for sometime:

-  if [ "$CONFIG_ACPI" = "y" ]; then
+  if [ "$CONFIG_ACPI" = "y" -a "$CONFIG_ACPI_HT_ONLY" != "y" ]; then

even if HT_ONLY is not a configurable option, just for the case it is read
from an old .config ?

TIA

(For people in the acpi list, please CC me, I am not subscribed)

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre7-jam2 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
