Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUIWJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUIWJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268340AbUIWJU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:20:28 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:53259 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S268333AbUIWJUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:20:09 -0400
Date: Thu, 23 Sep 2004 12:18:21 +0300 (EAT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH]Fix IO-APIC on Presario R3000 (nForce3)
Message-ID: <Pine.LNX.4.53.0409230659200.2712@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From googling it appears that people are using the Compaq R3000 laptops
with the IOAPIC disabled since IDE, network etc randomly stop working with
it enabled. The problem really is only that the ACPI/MADT specifies a bad
irq override for irq0, ignoring the override makes the R3000 usable and
stable (i've been using it for a number of days, failure was usually
within the first hour) with the IOAPIC enabled. If you would like to test
this fix simply boot with the 'acpi_skip_timer_override' kernel parameter
(in i386 mode only, you need the patch for x86_64). Before the fix
/proc/interrupts shows that irq0 is going via i8259 and ExtINT which ,as
far as ACPI is concerned, is not a compliant mode of operation. Andi i've
made a rather big assumption by allowing all nForce3 to skip timer
override on x86_64 too, but i'm confident that it's a safe bet. It'd be
nice to see this get some testing, but i'd also like to hear from nForce3
owners who have working IOAPICs (cat /proc/interrupts | grep APIC).

before:
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
...
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.

after:
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: IRQ9 used by override.
...
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=0 pin2=-1

I've added lspci for reference/google;

00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
00:06.1 Modem: nVidia Corporation: Unknown device 00d9 (rev a2)
00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go 32M] (rev a3)
02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:02.0 Network controller: Broadcom Corporation BCM94306 802.11g (rev 03)
02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
02:04.2 System peripheral: Texas Instruments: Unknown device 8201 (rev 01)

 arch/i386/kernel/dmi_scan.c  |   12 ++++++++++++
 arch/x86_64/kernel/io_apic.c |    8 ++++----
 include/asm-x86_64/acpi.h    |    1 +
 3 files changed, 17 insertions(+), 4 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc2-mm1/arch/i386/kernel/dmi_scan.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc2-mm1/arch/i386/kernel/dmi_scan.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 dmi_scan.c
--- linux-2.6.9-rc2-mm1/arch/i386/kernel/dmi_scan.c	16 Sep 2004 13:41:17 -0000	1.1.1.1
+++ linux-2.6.9-rc2-mm1/arch/i386/kernel/dmi_scan.c	22 Sep 2004 22:16:44 -0000
@@ -410,6 +410,18 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BOARD_NAME, "AN35"),
 			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
 			MATCH(DMI_BIOS_DATE, "12/05/2003") }},
+	/*
+	 * Compaq R3000 with nForce3 has an override for timer as well,
+	 * resulting in the timer irq incorrectly being setup in PIC mode,
+	 * this mode fails shortly afterwards.
+	 * There are a lot more models affected than the below. Tested on
+	 * Presario R3140CA.
+	 */
+	{ ignore_timer_override, "Presario R3000", {
+			MATCH(DMI_BOARD_VENDOR, "Compal"),
+			MATCH(DMI_BOARD_NAME, "08A0"),
+			MATCH(DMI_BIOS_VERSION, "F.03"),
+			MATCH(DMI_BIOS_DATE, "02/24/2004") }},
 #endif	// CONFIG_ACPI_BOOT
 
 #ifdef	CONFIG_ACPI_PCI
Index: linux-2.6.9-rc2-mm1/arch/x86_64/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc2-mm1/arch/x86_64/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.9-rc2-mm1/arch/x86_64/kernel/io_apic.c	16 Sep 2004 13:41:05 -0000	1.1.1.1
+++ linux-2.6.9-rc2-mm1/arch/x86_64/kernel/io_apic.c	23 Sep 2004 05:02:49 -0000
@@ -219,8 +219,8 @@ __setup("apic", enable_ioapic_setup);
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
 
-/* Temporary Hack. Nvidia and VIA boards currently only work with IO-APIC
-   off. Check for an Nvidia or VIA PCI bridge and turn it off.
+/* Temporary Hack. Nvidia and VIA boards have various IOAPIC problems.
+   Check for an Nvidia or VIA PCI bridge and apply workarounds.
    Use pci direct infrastructure because this runs before the PCI subsystem. 
 
    Can be overwritten with "apic"
@@ -267,9 +267,9 @@ void __init check_ioapic(void) 
 				case PCI_VENDOR_ID_NVIDIA:
 #ifndef CONFIG_SMP
 					printk(KERN_INFO 
-     "PCI bridge %02x:%02x from %x found. Setting \"noapic\". Overwrite with \"apic\"\n",
+     "PCI bridge %02x:%02x from %x found. Ignoring timer override\n",
 					       num,slot,vendor); 
-					skip_ioapic_setup = 1;
+					acpi_skip_timer_override = 1;
 #endif
 					return;
 				} 
Index: linux-2.6.9-rc2-mm1/include/asm-x86_64/acpi.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc2-mm1/include/asm-x86_64/acpi.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 acpi.h
--- linux-2.6.9-rc2-mm1/include/asm-x86_64/acpi.h	16 Sep 2004 13:39:23 -0000	1.1.1.1
+++ linux-2.6.9-rc2-mm1/include/asm-x86_64/acpi.h	23 Sep 2004 05:08:35 -0000
@@ -113,6 +113,7 @@ extern int acpi_strict;
 extern int acpi_disabled;
 extern int acpi_pci_disabled;
 extern int acpi_ht;
+extern int acpi_skip_timer_override;
 static inline void disable_acpi(void) 
 { 
 	acpi_disabled = 1; 
