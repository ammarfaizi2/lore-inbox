Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbTCAGRh>; Sat, 1 Mar 2003 01:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbTCAGRh>; Sat, 1 Mar 2003 01:17:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:33111
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268515AbTCAGRe>; Sat, 1 Mar 2003 01:17:34 -0500
Date: Sat, 1 Mar 2003 01:25:50 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>, Martin Bligh <mbligh@aracnet.com>
Subject: [PATCH][2.5] why noirqbalance doesn't work
Message-ID: <Pine.LNX.4.50.0303010109360.1132-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes what seems to have been a longstanding bug. Ever since we 
moved cpu bringup later into the boot process, we end up programming the 
ioapics before we have any of our possible cpus in the cpu_online_map. 
Therefore leading to the following current situation;

For walmart-smp, bigsmp and summit we set the logical destination for cpu 
to TARGET_CPUS which can depend on the cpu_online_map, so what you would 
normally see with noirqbalance would be all interrupts handled on cpu0 
since at that stage no other cpu apart from the BSP is online.

You can check for this by looking at the ioredtbls at boottime for a two 
way system;

.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59

Notice that 'Log' is set to 1 instead of 3.

This patch will simply reprogram all the ioredtbls to handle the other 
online cpus.

Patch tested on my 2way P2-400 and a 16way NUMAQ both with noirqbalance. 
It will not affect the irqbalance case because we are simply setting 
TARGET_CPUS which is done anyway.

before:
  CPU0       CPU1
  0:    1495632          0    IO-APIC-edge  timer
  1:       4270          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:      83592          0    IO-APIC-edge  i8042
 14:      93791          0    IO-APIC-edge  ide0
 15:     103167          0    IO-APIC-edge  ide1
 17:    1396088          0   IO-APIC-level  EMU10K1, eth0
 18:      56125          0   IO-APIC-level  aic7xxx, aic7xxx
 19:       2258          0   IO-APIC-level  uhci-hcd, eth1, serial
NMI:          0          0
LOC:    1495566    1497133

after:
           CPU0       CPU1       
  0:    1046157    1015670    IO-APIC-edge  timer
  1:       4923       4173    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:      48596      48968    IO-APIC-edge  i8042
 14:       4238       3416    IO-APIC-edge  ide0
 15:      25362      31525    IO-APIC-edge  ide1
 17:       3757       4014   IO-APIC-level  EMU10K1, eth0
 18:        335        366   IO-APIC-level  aic7xxx, aic7xxx
 19:       1052        908   IO-APIC-level  uhci-hcd, eth1
NMI:          0          0 
LOC:    2061856    2061893 

Index: linux-2.5.63-DBE/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.63/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io_apic.c
--- linux-2.5.63-DBE/arch/i386/kernel/io_apic.c	27 Feb 2003 22:03:36 -0000	1.1.1.1
+++ linux-2.5.63-DBE/arch/i386/kernel/io_apic.c	1 Mar 2003 06:22:57 -0000
@@ -194,6 +194,31 @@
 			clear_IO_APIC_pin(apic, pin);
 }
 
+/*
+ * This function currently is only a helper for the i386 smp boot process where 
+ * we need to reprogram the ioredtbls to cater for the cpus which have come online
+ * so mask in all cases should simply be TARGET_CPUS
+ */
+void __devinit set_ioapic_logical_dest (unsigned long mask)
+{
+	struct IO_APIC_route_entry entry;
+	unsigned long flags;
+	int apic, pin;
+
+	spin_lock_irqsave(&ioapic_lock, flags);
+	for (apic = 0; apic < nr_ioapics; apic++) {
+		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
+			*(((int *)&entry)+0) = io_apic_read(apic, 0x10+pin*2);
+			*(((int *)&entry)+1) = io_apic_read(apic, 0x11+pin*2);
+			entry.dest.logical.logical_dest = mask;
+			io_apic_write(apic, 0x10 + 2 * pin, *(((int *)&entry) + 0));
+			io_apic_write(apic, 0x11 + 2 * pin, *(((int *)&entry) + 1));
+		}
+
+	}
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
 static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
 {
 	unsigned long flags;
Index: linux-2.5.63-DBE/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.63/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smpboot.c
--- linux-2.5.63-DBE/arch/i386/kernel/smpboot.c	27 Feb 2003 22:03:36 -0000	1.1.1.1
+++ linux-2.5.63-DBE/arch/i386/kernel/smpboot.c	1 Mar 2003 05:37:20 -0000
@@ -1152,8 +1152,10 @@
 	return 0;
 }
 
+extern void set_ioapic_logical_dest(unsigned long mask);
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+	set_ioapic_logical_dest(TARGET_CPUS);
 	zap_low_mappings();
 }
 

-- 
function.linuxpower.ca
