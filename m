Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTBOTJs>; Sat, 15 Feb 2003 14:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbTBOTJs>; Sat, 15 Feb 2003 14:09:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264940AbTBOTJq>; Sat, 15 Feb 2003 14:09:46 -0500
Subject: PATCH: merge the NEC98 parsing code
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:19:58 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7qw-0007Hi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is nice and clean (your tree already knows the idents)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/kernel/io_apic.c linux-2.5.61-ac1/arch/i386/kernel/io_apic.c
--- linux-2.5.61/arch/i386/kernel/io_apic.c	2003-02-15 03:39:28.000000000 +0000
+++ linux-2.5.61-ac1/arch/i386/kernel/io_apic.c	2003-02-14 22:43:45.000000000 +0000
@@ -668,7 +670,9 @@
 
 		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
 		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA) &&
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA ||
+		     mp_bus_id_to_type[lbus] == MP_BUS_NEC98
+		    ) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
 
@@ -762,6 +766,12 @@
 #define default_MCA_trigger(idx)	(1)
 #define default_MCA_polarity(idx)	(0)
 
+/* NEC98 interrupts are always polarity zero edge triggered,
+ * when listed as conforming in the MP table. */
+
+#define default_NEC98_trigger(idx)     (0)
+#define default_NEC98_polarity(idx)    (0)
+
 static int __init MPBIOS_polarity(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
@@ -796,6 +806,11 @@
 					polarity = default_MCA_polarity(idx);
 					break;
 				}
+				case MP_BUS_NEC98: /* NEC 98 pin */
+				{
+					polarity = default_NEC98_polarity(idx);
+					break;
+				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -865,6 +880,11 @@
 					trigger = default_MCA_trigger(idx);
 					break;
 				}
+				case MP_BUS_NEC98: /* NEC 98 pin */
+				{
+					trigger = default_NEC98_trigger(idx);
+					break;
+				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -926,6 +946,7 @@
 		case MP_BUS_ISA: /* ISA pin */
 		case MP_BUS_EISA:
 		case MP_BUS_MCA:
+		case MP_BUS_NEC98:
 		{
 			irq = mp_irqs[idx].mpc_srcbusirq;
 			break;
