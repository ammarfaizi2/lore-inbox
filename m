Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290824AbSARVWB>; Fri, 18 Jan 2002 16:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290831AbSARVVp>; Fri, 18 Jan 2002 16:21:45 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38623 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290824AbSARVV3>; Fri, 18 Jan 2002 16:21:29 -0500
Message-Id: <200201182121.g0ILLJq10540@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Date: Fri, 18 Jan 2002 13:21:17 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0112261341470.9842-100000@freak.distro.conectiva> <200201080914.g089EHq21694@butler1.beaverton.ibm.com> <15640000.1010482915@flay>
In-Reply-To: <15640000.1010482915@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 January 2002 01:41 am, Martin J. Bligh wrote:
> > There's a problem with that -- despite its name, CONFIG_MULTIQUAD is used
> > for the old NUMA-Q hardware.  It turns on some memory mapped port I/O
> > code that doesn't have any purpose for other machines.  The PCI bus
> > overflow happens on our new Foster-based boxes that may or may not
> > contain multiple quad CPU boards.
> >
> > Still, CONFIG_MULTIQUAD is better than nothing.  It just may take a
> > little bit of redefinition, so long as we can coax the various distros to
> > build their installation and working kernels with CONFIG_MULTIQUAD turned
> > on....
>
> That's not a good idea. You're going to introduce extra switches to every
> port IO path, and every IPI (for everybody, not just yourself).
> CONFIG_MULTIQUAD is also used to alter the way that PCI config space writes
> are done (in later patches). I suggest you use a different config option,
> or construct it dynamically.
>
> Martin.

OK, I've thrown together an attempt at dynamic table allocation that works on 
the boxes with all the busses.  For safety's sake I keep the static tables 
and only reallocate if they overflow:

diff -ru 2.4.17/arch/i386/kernel/mpparse.c test/arch/i386/kernel/mpparse.c
--- 2.4.17/arch/i386/kernel/mpparse.c	Fri Nov  9 17:58:18 2001
+++ test/arch/i386/kernel/mpparse.c	Fri Jan 18 13:12:46 2002
@@ -35,16 +35,22 @@
  * MP-table.
  */
 int apic_version [MAX_APICS];
-int mp_bus_id_to_type [MAX_MP_BUSSES];
-int mp_bus_id_to_node [MAX_MP_BUSSES];
-int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
+int static_mp_bus_id_to_type[MAX_MP_BUSSES];
+int static_mp_bus_id_to_node[MAX_MP_BUSSES];
+int static_mp_bus_id_to_pci_bus[MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = 
-1 };
+int *mp_bus_id_to_type = static_mp_bus_id_to_type;
+int *mp_bus_id_to_node = static_mp_bus_id_to_node;
+int *mp_bus_id_to_pci_bus = static_mp_bus_id_to_pci_bus;
+int max_mp_busses = MAX_MP_BUSSES;
+int max_irq_sources = MAX_IRQ_SOURCES;
 int mp_current_pci_id;
 
 /* I/O APIC entries */
 struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
 
 /* # of MP IRQ source entries */
-struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+struct mpc_config_intsrc static_mp_irqs[MAX_IRQ_SOURCES];
+struct mpc_config_intsrc *mp_irqs = static_mp_irqs;
 
 /* MP IRQ source entries */
 int mp_irq_entries;
@@ -219,6 +225,7 @@
 	if (m->mpc_apicid > MAX_APICS) {
 		printk("Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
+		--num_processors;
 		return;
 	}
 	ver = m->mpc_apicver;
@@ -296,7 +303,7 @@
 			m->mpc_irqtype, m->mpc_irqflag & 3,
 			(m->mpc_irqflag >> 2) & 3, m->mpc_srcbus,
 			m->mpc_srcbusirq, m->mpc_dstapic, m->mpc_dstirq);
-	if (++mp_irq_entries == MAX_IRQ_SOURCES)
+	if (++mp_irq_entries == max_irq_sources)
 		panic("Max # of irq sources exceeded!!\n");
 }
 
@@ -385,6 +392,7 @@
 
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
+	int num_bus, num_irq;
 	char str[16];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
@@ -434,6 +442,76 @@
 	}
 
 	/*
+	 * Pre-scan to see if the bus and interrupt records are too big to fit
+	 * in the static tables.  If so, then alloc bigger ones.
+	 */
+    {
+	int cnt = count;
+	unsigned char *mpp = mpt;
+	size_t size;
+
+	num_bus = 0;
+	num_irq = 0;
+	while (cnt < mpc->mpc_length) {
+		switch (*mpp) {
+			case MP_PROCESSOR:
+				size = sizeof(struct mpc_config_processor);
+				break;
+			case MP_BUS:
+				++num_bus;
+				size = sizeof(struct mpc_config_bus);
+				break;
+			case MP_INTSRC:
+				++num_irq;
+				size = sizeof(struct mpc_config_intsrc);
+				break;
+			case MP_IOAPIC:
+				size = sizeof(struct mpc_config_ioapic);
+				break;
+			case MP_LINTSRC:
+				size = sizeof(struct mpc_config_lintsrc);
+				break;
+			default:
+				cnt = mpc->mpc_length;
+				size = 0;
+				break;
+		}
+		mpp += size;
+		cnt += size;
+	}
+	if (num_bus > MAX_MP_BUSSES || num_irq >= MAX_IRQ_SOURCES) {
+		unsigned char *up;
+
+		/* Paranoia: Alloc one extra of each. */
+		max_mp_busses = ++num_bus;
+		if (num_irq < 4 * num_bus)
+			num_irq = 4 * num_bus;	/* 4 intr/PCI slot */
+		max_irq_sources = ++num_irq;
+		num_bus *= sizeof(int);
+		cnt = 3 * num_bus;
+		num_irq *= sizeof(struct mpc_config_intsrc);
+		cnt += num_irq;
+		up = alloc_bootmem(cnt);
+		if (!up) {
+			printk("smp_read_mpc: Bus/Intr table realloc (%d "
+				"bytes) failed!  MPS records will be lost!\n",
+				cnt);
+		} else {
+			mp_bus_id_to_type = (int *)up;
+			up += num_bus;
+			mp_bus_id_to_node = (int *)up;
+			up += num_bus;
+			mp_bus_id_to_pci_bus = (int *)up;
+			up += num_bus;
+			mp_irqs = (struct mpc_config_intsrc *)up;
+			memset(mp_bus_id_to_pci_bus, -1, num_bus);
+		}
+	}
+	num_bus = 0;
+	num_irq = 0;
+    }
+
+	/*
 	 *	Now process the configuration blocks.
 	 */
 	while (count < mpc->mpc_length) {
@@ -454,7 +532,11 @@
 			{
 				struct mpc_config_bus *m=
 					(struct mpc_config_bus *)mpt;
-				MP_bus_info(m);
+				if (++num_bus < max_mp_busses)
+					MP_bus_info(m);
+				else
+					printk("Dropped bus #%d (%.6s)!\n",
+						m->mpc_busid, m->mpc_bustype);
 				mpt += sizeof(*m);
 				count += sizeof(*m);
 				break;
@@ -473,7 +555,12 @@
 				struct mpc_config_intsrc *m=
 					(struct mpc_config_intsrc *)mpt;
 
-				MP_intsrc_info(m);
+				if (++num_irq < max_irq_sources)
+					MP_intsrc_info(m);
+				else
+					printk("Dropped intsrc! (%d, %d, %02x, %d)\n",
+						m->mpc_srcbus, m->mpc_srcbusirq,
+						m->mpc_dstapic, m->mpc_dstirq);
 				mpt+=sizeof(*m);
 				count+=sizeof(*m);
 				break;
diff -ru 2.4.17/include/asm-i386/io_apic.h test/include/asm-i386/io_apic.h
--- 2.4.17/include/asm-i386/io_apic.h	Wed Jan  9 15:58:47 2002
+++ test/include/asm-i386/io_apic.h	Fri Jan 18 13:10:31 2002
@@ -96,7 +96,7 @@
 extern int mp_irq_entries;
 
 /* MP IRQ source entries */
-extern struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+extern struct mpc_config_intsrc *mp_irqs;
 
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
diff -ru 2.4.17/include/asm-i386/mpspec.h test/include/asm-i386/mpspec.h
--- 2.4.17/include/asm-i386/mpspec.h	Wed Jan  9 15:58:47 2002
+++ test/include/asm-i386/mpspec.h	Fri Jan 18 13:10:31 2002
@@ -197,8 +197,8 @@
 	MP_BUS_PCI,
 	MP_BUS_MCA
 };
-extern int mp_bus_id_to_type [MAX_MP_BUSSES];
-extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
+extern int *mp_bus_id_to_type;
+extern int *mp_bus_id_to_pci_bus;
 
 extern unsigned int boot_cpu_physical_apicid;
 extern unsigned long phys_cpu_present_map;
@@ -207,11 +207,11 @@
 extern void get_smp_config (void);
 extern int nr_ioapics;
 extern int apic_version [MAX_APICS];
-extern int mp_bus_id_to_type [MAX_MP_BUSSES];
+extern int *mp_bus_id_to_type;
 extern int mp_irq_entries;
-extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
+extern struct mpc_config_intsrc *mp_irqs;
 extern int mpc_default_type;
-extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
+extern int *mp_bus_id_to_pci_bus;
 extern int mp_current_pci_id;
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;


-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

