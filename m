Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267389AbSLLBsl>; Wed, 11 Dec 2002 20:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267398AbSLLBsl>; Wed, 11 Dec 2002 20:48:41 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:10768 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267389AbSLLBsg>;
	Wed, 11 Dec 2002 20:48:36 -0500
Date: Wed, 11 Dec 2002 17:54:54 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Dynamic MP_BUSSES and IRQ_SOURCES for 2.4.21-pre1
Message-ID: <20021212015454.GJ16615@kroah.com>
References: <20021212015326.GI16615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021212015326.GI16615@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.812, 2002/12/11 11:53:05-08:00, greg@kroah.com

[PATCH] dynamic MAX_MP_BUSSES and MAX_IRQ_SOURCES

Here's a patch that fixes a problem for machines
that have more busses or irq sources than MAX_MP_BUSSES or
MAX_IRQ_SOURCES has been set to.  This happens on some Intel Foster
machines (or whatever they are calling the processors now) when a PCI
bus expansion unit is plugged in at boot time.

Without this patch, those machines can not boot Linux.

If the machine needs more busses or interrupts, they will be dynamically
allocated at boot time.  If not, the existing MAX_MP_BUSSES and
MAX_IRW_SOURCES value will be used.  Once nice side effect of this patch
is when running a SMP kernel on a UP machine without a MP table, less
kernel memory is used than without the patch.

This patch was originally written by James Cleverdon.


diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Wed Dec 11 17:49:52 2002
+++ b/arch/i386/kernel/mpparse.c	Wed Dec 11 17:49:52 2002
@@ -36,18 +36,20 @@
  * MP-table.
  */
 int apic_version [MAX_APICS];
-int mp_bus_id_to_type [MAX_MP_BUSSES];
-int mp_bus_id_to_node [MAX_MP_BUSSES];
-int mp_bus_id_to_local [MAX_MP_BUSSES];
 int quad_local_to_mp_bus_id [NR_CPUS/4][4];
-int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_current_pci_id;
+int *mp_bus_id_to_type;
+int *mp_bus_id_to_node;
+int *mp_bus_id_to_local;
+int *mp_bus_id_to_pci_bus;
+int max_mp_busses;
+int max_irq_sources;
 
 /* I/O APIC entries */
 struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
 
 /* # of MP IRQ source entries */
-struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+struct mpc_config_intsrc *mp_irqs;
 
 /* MP IRQ source entries */
 int mp_irq_entries;
@@ -313,7 +315,7 @@
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries == max_irq_sources)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
@@ -406,6 +408,9 @@
 	char oem[16], prod[14];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
+	int num_bus = 0;
+	int num_irq = 0;
+	unsigned char *bus_data;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
@@ -453,9 +458,70 @@
 		mpc_record = 0;
 	}
 
+	/* Pre-scan to determine the number of bus and 
+	 * interrupts records we have
+	 */
+	while (count < mpc->mpc_length) {
+		switch (*mpt) {
+			case MP_PROCESSOR:
+				mpt += sizeof(struct mpc_config_processor);
+				count += sizeof(struct mpc_config_processor);
+				break;
+			case MP_BUS:
+				++num_bus;
+				mpt += sizeof(struct mpc_config_bus);
+				count += sizeof(struct mpc_config_bus);
+				break;
+			case MP_INTSRC:
+				++num_irq;
+				mpt += sizeof(struct mpc_config_intsrc);
+				count += sizeof(struct mpc_config_intsrc);
+				break;
+			case MP_IOAPIC:
+				mpt += sizeof(struct mpc_config_ioapic);
+				count += sizeof(struct mpc_config_ioapic);
+				break;
+			case MP_LINTSRC:
+				mpt += sizeof(struct mpc_config_lintsrc);
+				count += sizeof(struct mpc_config_lintsrc);
+				break;
+			default:
+				count = mpc->mpc_length;
+				break;
+		}
+	}
+	/* 
+	 * Paranoia: Allocate one extra of both the number of busses and number
+	 * of irqs, and make sure that we have at least 4 interrupts per PCI
+	 * slot.  But some machines do not report very many busses, so we need
+	 * to fall back on the older defaults.
+	 */
+	++num_bus;
+	max_mp_busses = max(num_bus, MAX_MP_BUSSES);
+	if (num_irq < (4 * max_mp_busses))
+		num_irq = 4 * num_bus;	/* 4 intr/PCI slot */
+	++num_irq;
+	max_irq_sources = max(num_irq, MAX_IRQ_SOURCES);
+	
+	count = (max_mp_busses * sizeof(int)) * 4;
+	count += (max_irq_sources * sizeof(struct mpc_config_intsrc));
+	bus_data = alloc_bootmem(count);
+	if (!bus_data) {
+		printk(KERN_ERR "SMP mptable: out of memory!\n");
+		return 0;
+	}
+	mp_bus_id_to_type = (int *)&bus_data[0];
+	mp_bus_id_to_node = (int *)&bus_data[(max_mp_busses * sizeof(int))];
+	mp_bus_id_to_local = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 2];
+	mp_bus_id_to_pci_bus = (int *)&bus_data[(max_mp_busses * sizeof(int)) * 3];
+	mp_irqs = (struct mpc_config_intsrc *)&bus_data[(max_mp_busses * sizeof(int)) * 4];
+	memset(mp_bus_id_to_pci_bus, -1, max_mp_busses);
+
 	/*
 	 *	Now process the configuration blocks.
 	 */
+	count = sizeof(*mpc);
+	mpt = ((unsigned char *)mpc)+count;
 	while (count < mpc->mpc_length) {
 		switch(*mpt) {
 			case MP_PROCESSOR:
diff -Nru a/include/asm-i386/io_apic.h b/include/asm-i386/io_apic.h
--- a/include/asm-i386/io_apic.h	Wed Dec 11 17:49:52 2002
+++ b/include/asm-i386/io_apic.h	Wed Dec 11 17:49:52 2002
@@ -97,7 +97,7 @@
 extern int mp_irq_entries;
 
 /* MP IRQ source entries */
-extern struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+extern struct mpc_config_intsrc *mp_irqs;
 
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Wed Dec 11 17:49:52 2002
+++ b/include/asm-i386/mpspec.h	Wed Dec 11 17:49:52 2002
@@ -198,11 +198,11 @@
 	MP_BUS_PCI,
 	MP_BUS_MCA
 };
-extern int mp_bus_id_to_type [MAX_MP_BUSSES];
-extern int mp_bus_id_to_node [MAX_MP_BUSSES];
-extern int mp_bus_id_to_local [MAX_MP_BUSSES];
+extern int *mp_bus_id_to_type;
+extern int *mp_bus_id_to_node;
+extern int *mp_bus_id_to_local;
+extern int *mp_bus_id_to_pci_bus;
 extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
-extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern unsigned long phys_cpu_present_map;
@@ -211,11 +211,9 @@
 extern void get_smp_config (void);
 extern int nr_ioapics;
 extern int apic_version [MAX_APICS];
-extern int mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_irq_entries;
-extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
+extern struct mpc_config_intsrc *mp_irqs;
 extern int mpc_default_type;
-extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 extern int mp_current_pci_id;
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;
