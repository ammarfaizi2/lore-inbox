Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293159AbSCTTMu>; Wed, 20 Mar 2002 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSCTTMm>; Wed, 20 Mar 2002 14:12:42 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:27153 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293159AbSCTTM0>;
	Wed, 20 Mar 2002 14:12:26 -0500
Date: Wed, 20 Mar 2002 11:11:31 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dynamic MAX_MP_BUSSES and MAX_IRQ_SOURCES
Message-ID: <20020320191131.GC5959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Feb 2002 15:47:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.19-pre3-ac4 that allows MAX_MP_BUSSES and
MAX_IRQ_SOURCES to be automatically determined at run time.  This patch
is required for the Intel Foster machines from IBM (the x360 and x440
machines) with an expansion PCI bus plugged in to allow the machine to
boot properly.

I also tested this patch on a NUMA machine, and verified that we can
remove the #ifdef CONFIG_MULTIQUAD around the definition of
MAX_IRQ_SOURCES.  This ends up with a small memory savings on these
machines.

This patch also saves kernel memory if a SMP kernel is run on a UP
machine.  It has been tested on a wide range of SMP and UP machines
(including lots of non-IBM hardware.)  It was originally written by
James Cleverdon.

thanks,

greg k-h


diff -Naur -X /home/greg/linux/dontdiff linux-2.4.19-pre3-ac4/arch/i386/kernel/mpparse.c linux-2.4.19-pre3-ac4-greg/arch/i386/kernel/mpparse.c
--- linux-2.4.19-pre3-ac4/arch/i386/kernel/mpparse.c	Wed Mar 20 10:20:08 2002
+++ linux-2.4.19-pre3-ac4-greg/arch/i386/kernel/mpparse.c	Wed Mar 20 10:27:42 2002
@@ -35,18 +35,20 @@
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
@@ -303,7 +305,7 @@
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries == max_irq_sources)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
@@ -396,6 +398,9 @@
 	char str[16];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
+	int num_bus = 0;
+	int num_irq = 0;
+	unsigned char *bus_data;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
@@ -441,9 +446,70 @@
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
diff -Naur -X /home/greg/linux/dontdiff linux-2.4.19-pre3-ac4/include/asm-i386/io_apic.h linux-2.4.19-pre3-ac4-greg/include/asm-i386/io_apic.h
--- linux-2.4.19-pre3-ac4/include/asm-i386/io_apic.h	Mon Feb 25 11:38:12 2002
+++ linux-2.4.19-pre3-ac4-greg/include/asm-i386/io_apic.h	Wed Mar 20 10:29:35 2002
@@ -97,7 +97,7 @@
 extern int mp_irq_entries;
 
 /* MP IRQ source entries */
-extern struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+extern struct mpc_config_intsrc *mp_irqs;
 
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
diff -Naur -X /home/greg/linux/dontdiff linux-2.4.19-pre3-ac4/include/asm-i386/mpspec.h linux-2.4.19-pre3-ac4-greg/include/asm-i386/mpspec.h
--- linux-2.4.19-pre3-ac4/include/asm-i386/mpspec.h	Wed Mar 20 10:19:46 2002
+++ linux-2.4.19-pre3-ac4-greg/include/asm-i386/mpspec.h	Wed Mar 20 10:29:35 2002
@@ -184,11 +184,7 @@
  *	7	2 CPU MCA+PCI
  */
 
-#ifdef CONFIG_MULTIQUAD
-#define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_MULTIQUAD */
 #define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_MULTIQUAD */
 
 #define MAX_MP_BUSSES 32
 enum mp_bustype {
@@ -197,11 +193,11 @@
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
@@ -210,11 +206,9 @@
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
