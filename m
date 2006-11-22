Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWKVESS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWKVESS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031177AbWKVESH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:18:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19981 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030684AbWKVERp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:17:45 -0500
Date: Wed, 22 Nov 2006 05:17:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: [2.6 patch] arch/i386/kernel/: remove remaining pc98 code
Message-ID: <20061122041745.GD5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the remaining code of the removed pc98 support.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/io_apic.c    |   23 ++---------------------
 arch/i386/kernel/mpparse.c    |    2 --
 include/asm-i386/mpspec_def.h |    2 --
 3 files changed, 2 insertions(+), 25 deletions(-)

--- linux-2.6.19-rc5-mm2/include/asm-i386/mpspec_def.h.old	2006-11-22 01:56:41.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-i386/mpspec_def.h	2006-11-22 01:58:48.000000000 +0100
@@ -97,7 +97,6 @@ struct mpc_config_bus
 #define BUSTYPE_TC	"TC"
 #define BUSTYPE_VME	"VME"
 #define BUSTYPE_XPRESS	"XPRESS"
-#define BUSTYPE_NEC98	"NEC98"
 
 struct mpc_config_ioapic
 {
@@ -182,7 +181,6 @@ enum mp_bustype {
 	MP_BUS_EISA,
 	MP_BUS_PCI,
 	MP_BUS_MCA,
-	MP_BUS_NEC98
 };
 #endif
 
--- linux-2.6.19-rc5-mm2/arch/i386/kernel/mpparse.c.old	2006-11-22 01:57:01.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/i386/kernel/mpparse.c	2006-11-22 01:57:17.000000000 +0100
@@ -249,8 +249,6 @@ static void __init MP_bus_info (struct m
 		mp_current_pci_id++;
 	} else if (strncmp(str, BUSTYPE_MCA, sizeof(BUSTYPE_MCA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_MCA;
-	} else if (strncmp(str, BUSTYPE_NEC98, sizeof(BUSTYPE_NEC98)-1) == 0) {
-		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_NEC98;
 	} else {
 		printk(KERN_WARNING "Unknown bustype %s - ignoring\n", str);
 	}
--- linux-2.6.19-rc5-mm2/arch/i386/kernel/io_apic.c.old	2006-11-22 01:57:26.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/i386/kernel/io_apic.c	2006-11-22 01:58:21.000000000 +0100
@@ -843,8 +843,7 @@ static int __init find_isa_irq_pin(int i
 
 		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
 		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_NEC98
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA
 		    ) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
@@ -863,8 +862,7 @@ static int __init find_isa_irq_apic(int 
 
 		if ((mp_bus_id_to_type[lbus] == MP_BUS_ISA ||
 		     mp_bus_id_to_type[lbus] == MP_BUS_EISA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_MCA ||
-		     mp_bus_id_to_type[lbus] == MP_BUS_NEC98
+		     mp_bus_id_to_type[lbus] == MP_BUS_MCA
 		    ) &&
 		    (mp_irqs[i].mpc_irqtype == type) &&
 		    (mp_irqs[i].mpc_srcbusirq == irq))
@@ -994,12 +992,6 @@ static int EISA_ELCR(unsigned int irq)
 #define default_MCA_trigger(idx)	(1)
 #define default_MCA_polarity(idx)	(0)
 
-/* NEC98 interrupts are always polarity zero edge triggered,
- * when listed as conforming in the MP table. */
-
-#define default_NEC98_trigger(idx)     (0)
-#define default_NEC98_polarity(idx)    (0)
-
 static int __init MPBIOS_polarity(int idx)
 {
 	int bus = mp_irqs[idx].mpc_srcbus;
@@ -1034,11 +1026,6 @@ static int __init MPBIOS_polarity(int id
 					polarity = default_MCA_polarity(idx);
 					break;
 				}
-				case MP_BUS_NEC98: /* NEC 98 pin */
-				{
-					polarity = default_NEC98_polarity(idx);
-					break;
-				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -1108,11 +1095,6 @@ static int MPBIOS_trigger(int idx)
 					trigger = default_MCA_trigger(idx);
 					break;
 				}
-				case MP_BUS_NEC98: /* NEC 98 pin */
-				{
-					trigger = default_NEC98_trigger(idx);
-					break;
-				}
 				default:
 				{
 					printk(KERN_WARNING "broken BIOS!!\n");
@@ -1174,7 +1156,6 @@ static int pin_2_irq(int idx, int apic, 
 		case MP_BUS_ISA: /* ISA pin */
 		case MP_BUS_EISA:
 		case MP_BUS_MCA:
-		case MP_BUS_NEC98:
 		{
 			irq = mp_irqs[idx].mpc_srcbusirq;
 			break;

