Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbTAGUEL>; Tue, 7 Jan 2003 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTAGUEL>; Tue, 7 Jan 2003 15:04:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28959 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267442AbTAGUEI>; Tue, 7 Jan 2003 15:04:08 -0500
Date: Tue, 7 Jan 2003 15:11:44 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.org, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Oops on dual P5 (mp_bus_id_to_pci_bus==NULL)
Message-ID: <20030107151144.A1904@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, the attached patch is broken. What do you think happens
if (mpf->mpf_feature1 != 0) in get_smp_config()?
In my case, it looks like this:

Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
Default MP configuration #6
Processor #0 Pentium(tm) APIC version 16
Processor #1 Pentium(tm) APIC version 16
I/O APIC #2 Version 16 at 0xFEC00000.
Processors: 2
............... blah blah blah
PCI: PCI BIOS revision 2.00 entry at 0xfcad0, last bus=0
PCI: Using configuration type 2
PCI: Probing PCI hardware
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 <--- IO_APIC_get_PCI_irq_vector dies in if (mp_bus_id_to_pci_bus[bus] == -1)

I hope you have the time to fix this for -pre4.

Cheers,
-- Pete

------- patch-2.4.21-pre2-bogussmp.diff -------
(extracted by hand from 2.4.21-pre2 FYI, DO NOT run patch -R on this!)

diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.20/arch/i386/kernel/mpparse.c linux-2.4.21/arch/i386/kernel/mpparse.c
--- linux-2.4.20/arch/i386/kernel/mpparse.c	2002-12-18 18:27:05.000000000 +0000
+++ linux-2.4.21/arch/i386/kernel/mpparse.c	2002-12-18 18:58:06.000000000 +0000
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
@@ -398,9 +405,12 @@
 
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
-	char str[16];
+	char oem[16], prod[14];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
+	int num_bus = 0;
+	int num_irq = 0;
+	unsigned char *bus_data;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
@@ -446,9 +458,70 @@
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
