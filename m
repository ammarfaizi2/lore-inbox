Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271140AbSITCz4>; Thu, 19 Sep 2002 22:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274675AbSITCz4>; Thu, 19 Sep 2002 22:55:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24818 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271140AbSITCzm>;
	Thu, 19 Sep 2002 22:55:42 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Summit patch for 2.4.36
Date: Thu, 19 Sep 2002 20:00:29 -0700
User-Agent: KMail/1.4.1
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_T0VPHWCXATGYUOING3R5"
Message-Id: <200209192000.29508.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_T0VPHWCXATGYUOING3R5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here's the Summit patch (IBM x360 and x440 boxen) rerolled for 2.4.36.

No changes, aside for resolving the conflicts in arch/i386/kernel/acpi.c

--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_T0VPHWCXATGYUOING3R5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="summit_patch.2002-09-19_2.5.36"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="summit_patch.2002-09-19_2.5.36"

diff -ruN 2.5.36/arch/i386/kernel/acpi.c d36/arch/i386/kernel/acpi.c
--- 2.5.36/arch/i386/kernel/acpi.c	Tue Sep 17 17:59:13 2002
+++ d36/arch/i386/kernel/acpi.c	Thu Sep 19 16:28:31 2002
@@ -127,6 +127,8 @@
 	printk(KERN_INFO PREFIX "Local APIC address 0x%08x\n",
 		madt->lapic_address);
 
+	acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
+
 	return 0;
 }
 
@@ -423,8 +425,10 @@
 #endif /*CONFIG_X86_IO_APIC*/
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (acpi_lapic && acpi_ioapic)
+	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
+		smp_cluster_apic_check();
+	}
 #endif
 
 	return 0;
diff -ruN 2.5.36/arch/i386/kernel/apic.c d36/arch/i386/kernel/apic.c
--- 2.5.36/arch/i386/kernel/apic.c	Tue Sep 17 17:59:20 2002
+++ d36/arch/i386/kernel/apic.c	Thu Sep 19 16:22:08 2002
@@ -29,6 +29,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/smpboot.h>
 
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
@@ -272,6 +273,16 @@
 	apic_write_around(APIC_LVT1, value);
 }
 
+static inline unsigned long apic_ldr_value(unsigned long value)
+{
+	if (clustered_apic_numaq)
+		return (value);
+	if (clustered_apic_xapic)
+		return (((value) & ~APIC_LDR_MASK) |
+			SET_APIC_LOGICAL_ID(xapic_physical_to_logical_apicid(hard_smp_processor_id())));
+	return (((value) & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(1UL << smp_processor_id()));
+}
+
 void __init setup_local_APIC (void)
 {
 	unsigned long value, ver, maxlvt;
@@ -304,21 +315,22 @@
 	 * document number 292116).  So here it goes...
 	 */
 
-	if (!clustered_apic_mode) {
+	if (!clustered_apic_numaq) {
 		/*
-		 * In clustered apic mode, the firmware does this for us 
-		 * Put the APIC into flat delivery mode.
-		 * Must be "all ones" explicitly for 82489DX.
+		 * For NUMA-Q, the firmware does this for us.  Otherwise, put the APIC into clustered or flat
+		 *
+		 * delivery mode.  Must be "all ones" explicitly for 82489DX.
 		 */
-		apic_write_around(APIC_DFR, 0xffffffff);
+		if (clustered_apic_mode)
+			apic_write_around(APIC_DFR, APIC_DFR_CLUSTER);
+		else
+			apic_write_around(APIC_DFR, APIC_DFR_FLAT);
 
 		/*
 		 * Set up the logical destination ID.
 		 */
 		value = apic_read(APIC_LDR);
-		value &= ~APIC_LDR_MASK;
-		value |= (1<<(smp_processor_id()+24));
-		apic_write_around(APIC_LDR, value);
+		apic_write_around(APIC_LDR, apic_ldr_value(value));
 	}
 
 	/*
diff -ruN 2.5.36/arch/i386/kernel/io_apic.c d36/arch/i386/kernel/io_apic.c
--- 2.5.36/arch/i386/kernel/io_apic.c	Tue Sep 17 17:58:51 2002
+++ d36/arch/i386/kernel/io_apic.c	Thu Sep 19 16:22:08 2002
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include <asm/smpboot.h>
 
 #undef APIC_LOCKUP_DEBUG
 
@@ -199,84 +200,6 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
-#if CONFIG_SMP
-
-typedef struct {
-	unsigned int cpu;
-	unsigned long timestamp;
-} ____cacheline_aligned irq_balance_t;
-
-static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
-			= { [ 0 ... NR_IRQS-1 ] = { 0, 0 } };
-
-extern unsigned long irq_affinity [NR_IRQS];
-
-#endif
-
-#define IDLE_ENOUGH(cpu,now) \
-		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
-
-#define IRQ_ALLOWED(cpu,allowed_mask) \
-		((1 << cpu) & (allowed_mask))
-
-#if CONFIG_SMP
-
-#define IRQ_BALANCE_INTERVAL (HZ/50)
-	
-static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
-{
-	int search_idle = 1;
-	int cpu = curr_cpu;
-
-	goto inside;
-
-	do {
-		if (unlikely(cpu == curr_cpu))
-			search_idle = 0;
-inside:
-		if (direction == 1) {
-			cpu++;
-			if (cpu >= NR_CPUS)
-				cpu = 0;
-		} else {
-			cpu--;
-			if (cpu == -1)
-				cpu = NR_CPUS-1;
-		}
-	} while (!cpu_online(cpu) || !IRQ_ALLOWED(cpu,allowed_mask) ||
-			(search_idle && !IDLE_ENOUGH(cpu,now)));
-
-	return cpu;
-}
-
-static inline void balance_irq(int irq)
-{
-	irq_balance_t *entry = irq_balance + irq;
-	unsigned long now = jiffies;
-
-	if (clustered_apic_mode)
-		return;
-
-	if (unlikely(time_after(now, entry->timestamp + IRQ_BALANCE_INTERVAL))) {
-		unsigned long allowed_mask;
-		unsigned int new_cpu;
-		int random_number;
-
-		rdtscl(random_number);
-		random_number &= 1;
-
-		allowed_mask = cpu_online_map & irq_affinity[irq];
-		entry->timestamp = now;
-		new_cpu = move(entry->cpu, allowed_mask, now, random_number);
-		if (entry->cpu != new_cpu) {
-			entry->cpu = new_cpu;
-			set_ioapic_affinity(irq, 1 << new_cpu);
-		}
-	}
-}
-#else /* !SMP */
-static inline void balance_irq(int irq) { }
-#endif
 
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
@@ -692,9 +615,39 @@
 	return current_vector;
 }
 
+/*
+ * round_robin_cpu_apic_id -- Since i386 Linux doesn't use the APIC TPRs to
+ * set task/interrupt priority, xAPICs' tiebreaker rule tends to hit one CPU
+ * with all interrupts for each quad.  Distribute the interrupts using a
+ * simple round robin scheme.
+ */
+static int round_robin_cpu_apic_id(void)
+{
+	int val;
+	static unsigned	next_cpu = 0;
+
+	if (next_cpu >= NR_CPUS || cpu_2_logical_apicid[next_cpu] == BAD_APICID)
+		next_cpu = 0;
+	val = cpu_present_to_apicid(next_cpu) | APIC_DEST_CPUS_MASK;
+	++next_cpu;
+	return (val);
+}
+
+static inline int target_cpus(void)
+{
+	if (clustered_apic_numaq)
+		return APIC_BROADCAST_ID_APIC;	/* broadcast to local quad */
+	if (clustered_apic_xapic)
+		return round_robin_cpu_apic_id();
+	return logical_cpu_present_map & 0xFFu;
+}
+
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
+#undef KERN_DEBUG
+#define KERN_DEBUG
+
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
@@ -712,9 +665,9 @@
 		memset(&entry,0,sizeof(entry));
 
 		entry.delivery_mode = dest_LowestPrio;
-		entry.dest_mode = INT_DELIVERY_MODE;
+		entry.dest_mode = INT_DEST_ADDR_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest = target_cpus();
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -732,7 +685,6 @@
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -792,9 +744,9 @@
 	 * We use logical delivery to get the timer IRQ
 	 * to the first CPU.
 	 */
-	entry.dest_mode = INT_DELIVERY_MODE;
+	entry.dest_mode = INT_DEST_ADDR_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = target_cpus();
 	entry.delivery_mode = dest_LowestPrio;
 	entry.polarity = 0;
 	entry.trigger = 0;
@@ -1151,7 +1103,7 @@
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
+		if (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1163,14 +1115,16 @@
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
+		 * I/O APIC IDs no longer have any meaning for xAPICs.
 		 */
-		if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid)) {
+		if (!clustered_apic_xapic &&
+		    (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			for (i = 0; i < 0xf; i++)
 				if (!(phys_id_present_map & (1 << i)))
 					break;
-			if (i >= 0xf)
+			if (i >= apic_broadcast_id)
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
@@ -1298,7 +1252,6 @@
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
-	balance_irq(irq);
 	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 					== (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
@@ -1338,7 +1291,6 @@
 	unsigned long v;
 	int i;
 
-	balance_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
@@ -1859,8 +1811,8 @@
 	memset(&entry,0,sizeof(entry));
 
 	entry.delivery_mode = dest_LowestPrio;
-	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest_mode = INT_DEST_ADDR_MODE;
+	entry.dest.logical.logical_dest = target_cpus();
 	entry.mask = 1;					 /* Disabled (masked) */
 	entry.trigger = 1;				   /* Level sensitive */
 	entry.polarity = 1;					/* Low active */
diff -ruN 2.5.36/arch/i386/kernel/irq.c d36/arch/i386/kernel/irq.c
--- 2.5.36/arch/i386/kernel/irq.c	Tue Sep 17 17:58:44 2002
+++ d36/arch/i386/kernel/irq.c	Thu Sep 19 16:22:08 2002
@@ -331,6 +331,7 @@
 
 	irq_enter();
 	kstat.irqs[cpu][irq]++;
+	apic_adj_tpr(TPR_IRQ);
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
@@ -389,6 +390,7 @@
 	 */
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
+	apic_adj_tpr(-TPR_IRQ);
 
 	irq_exit();
 
diff -ruN 2.5.36/arch/i386/kernel/mpparse.c d36/arch/i386/kernel/mpparse.c
--- 2.5.36/arch/i386/kernel/mpparse.c	Tue Sep 17 17:58:50 2002
+++ d36/arch/i386/kernel/mpparse.c	Thu Sep 19 16:22:08 2002
@@ -30,6 +30,7 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
+#include <asm/smpboot.h>
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -68,6 +69,13 @@
 
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
+unsigned long logical_cpu_present_map;
+
+u32 apic_broadcast_id = APIC_BROADCAST_ID_APIC;
+u8 clustered_apic_mode = 0;
+u8 esr_disable = 0;
+u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+static u8 clustered_hint = 0;
 
 /*
  * Intel MP BIOS table parsing routines:
@@ -104,8 +112,8 @@
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
 
-	logical_apicid = m->mpc_apicid;
-	if (clustered_apic_mode) {
+	logical_apicid = 0x01;
+	if (clustered_apic_numaq) {
 		quad = translation_table[mpc_record]->trans_quad;
 		logical_apicid = (quad << 4) + 
 			(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
@@ -186,11 +194,8 @@
 	}
 	ver = m->mpc_apicver;
 
-	if (clustered_apic_mode) {
-		phys_cpu_present_map |= (logical_apicid&0xf) << (4*quad);
-	} else {
-		phys_cpu_present_map |= 1 << m->mpc_apicid;
-	}
+	logical_cpu_present_map |= 1 << (num_processors-1);
+	phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
 	/*
 	 * Validate version
 	 */
@@ -199,6 +204,7 @@
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
 static void __init MP_bus_info (struct mpc_config_bus *m)
@@ -209,7 +215,7 @@
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
 	
-	if (clustered_apic_mode) {
+	if (clustered_apic_numaq) {
 		quad = translation_table[mpc_record]->trans_quad;
 		mp_bus_id_to_node[m->mpc_busid] = quad;
 		mp_bus_id_to_local[m->mpc_busid] = translation_table[mpc_record]->trans_local;
@@ -236,10 +242,23 @@
 	}
 }
 
+static int __init ioapic_dup_check(unsigned long apicaddr)
+{
+	register int	i;
+
+	for (i = nr_ioapics; --i >= 0; ) {
+		if (mp_ioapics[i].mpc_apicaddr == apicaddr)
+			return 1;	/* Got a dup. */
+	}
+	return 0;			/* No dup. */
+}
+
 static void __init MP_ioapic_info (struct mpc_config_ioapic *m)
 {
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;
+	if (ioapic_dup_check(m->mpc_apicaddr))
+		return;
 
 	printk("I/O APIC #%d Version %d at 0x%lX.\n",
 		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
@@ -255,6 +274,15 @@
 	}
 	mp_ioapics[nr_ioapics] = *m;
 	nr_ioapics++;
+	/******
+	 * Warning!  We have an APIC version number collision between the APICs
+	 * on Scorpio-based NUMA-Q boxes and Summit xAPICs.  Intel didn't
+	 * define the xAPIC ver ID range until late in the development cycle,
+	 * so there is working silicon out there that doesn't match it.
+	 * A test in smp_cluster_apic_check() resolves the above conflict.
+	 ******/
+	if (m->mpc_apicver >= XAPIC_VER_LOW && m->mpc_apicver <= XAPIC_VER_HIGH)
+		clustered_hint |= CLUSTERED_APIC_XAPIC;
 }
 
 static void __init MP_intsrc_info (struct mpc_config_intsrc *m)
@@ -350,12 +378,37 @@
 }
 
 /*
+ * Common code for MPS and ACPI/MADT.
+ */
+void __init smp_cluster_apic_check(void)
+{
+	static const char *mode_names[] = {
+		"Flat", "Clustered NUMA-Q", "Clustered xAPIC", "???"
+	};
+
+	if (clustered_hint) {
+		if (clustered_hint & CLUSTERED_APIC_NUMAQ) {
+			/* NUMA-Q boxes never had xAPICs */
+			clustered_hint &= ~CLUSTERED_APIC_XAPIC;
+		}
+		clustered_apic_mode = clustered_hint;
+		esr_disable = 1;
+		if (clustered_apic_xapic)
+			apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
+		phys_cpu_present_map = logical_cpu_present_map;
+	}
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		mode_names[clustered_apic_mode], nr_ioapics);
+}
+
+/*
  * Read/parse the MPC
  */
 
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
-	char str[16];
+	char oem[10];
+	char prod[14];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
@@ -380,13 +433,20 @@
 		printk(KERN_ERR "SMP mptable: null local APIC address!\n");
 		return 0;
 	}
-	memcpy(str,mpc->mpc_oem,8);
-	str[8]=0;
-	printk("OEM ID: %s ",str);
-
-	memcpy(str,mpc->mpc_productid,12);
-	str[12]=0;
-	printk("Product ID: %s ",str);
+	memcpy(oem, mpc->mpc_oem, 8);
+	oem[8] = 0;
+	memcpy(prod, mpc->mpc_productid, 12);
+	prod[12] = 0;
+	printk("OEM ID: %s ", oem);
+	printk("Product ID: %s ",prod);
+	/*
+	 * Can't recognize Summit xAPICs (see MP_ioapic_info), so use
+	 * OEM/Product IDs.
+	 */
+	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(prod, "VIGIL SMP", 9))
+		clustered_hint |= CLUSTERED_APIC_XAPIC;
+	else if (!strncmp(oem, "IBM NUMA", 8))
+		clustered_hint |= CLUSTERED_APIC_NUMAQ;
 
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
@@ -397,7 +457,7 @@
 	if (!acpi_lapic)
 		mp_lapic_addr = mpc->mpc_lapic;
 
-	if (clustered_apic_mode && mpc->mpc_oemptr) {
+	if (clustered_apic_numaq && mpc->mpc_oemptr) {
 		/* We need to process the oem mpc tables to tell us which quad things are in ... */
 		mpc_record = 0;
 		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, mpc->mpc_oemsize);
@@ -465,6 +525,7 @@
 		}
 		++mpc_record;
 	}
+	smp_cluster_apic_check();
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
@@ -642,10 +703,8 @@
 	 * ACPI supports both logical (e.g. Hyper-Threading) and physical 
 	 * processors, where MPS only supports physical.
 	 */
-	if (acpi_lapic && acpi_ioapic) {
+	if (acpi_lapic && acpi_ioapic)
 		printk(KERN_INFO "Using ACPI (MADT) for SMP configuration information\n");
-		return;
-	}
 	else if (acpi_lapic)
 		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration information\n");
 
@@ -900,6 +959,8 @@
 {
 	int			idx = 0;
 
+	if (ioapic_dup_check(address))
+		return;
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
 			"(found %d)\n", MAX_IO_APICS, nr_ioapics);
@@ -936,6 +997,17 @@
 		mp_ioapic_routing[idx].irq_start,
 		mp_ioapic_routing[idx].irq_end);
 
+	/******
+	 * Warning!  We have an APIC version number collision between the APICs
+	 * on Scorpio-based NUMA-Q boxes and Summit xAPICs.  Intel didn't
+	 * define the xAPIC ver ID range until late in the development cycle,
+	 * so there is working silicon out there that doesn't match it.
+	 * A test in smp_cluster_apic_check() resolves the above conflict.
+	 ******/
+	if (mp_ioapics[idx].mpc_apicver >= XAPIC_VER_LOW &&
+	    mp_ioapics[idx].mpc_apicver <= XAPIC_VER_HIGH)
+		clustered_hint |= CLUSTERED_APIC_XAPIC;
+
 	return;
 }
 
@@ -1053,6 +1125,13 @@
 	return;
 }
 
+/* Hook from generic ACPI tables.c */
+void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", 8))
+		clustered_hint |= CLUSTERED_APIC_XAPIC;
+}
+
 #ifdef CONFIG_ACPI_PCI
 
 void __init mp_parse_prt (void)
diff -ruN 2.5.36/arch/i386/kernel/process.c d36/arch/i386/kernel/process.c
--- 2.5.36/arch/i386/kernel/process.c	Tue Sep 17 17:58:40 2002
+++ d36/arch/i386/kernel/process.c	Thu Sep 19 16:22:08 2002
@@ -144,7 +144,9 @@
 		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 		while (!need_resched())
 			idle();
+		apic_set_tpr(TPR_TASK);
 		schedule();
+		apic_set_tpr(TPR_IDLE);
 	}
 }
 
@@ -196,7 +198,7 @@
 			}
 				/* we will leave sorting out the final value 
 				when we are ready to reboot, since we might not
- 				have set up boot_cpu_id or smp_num_cpu */
+ 				have set up boot_cpu_physical_apicid or smp_num_cpu */
 			break;
 #endif
 		}
diff -ruN 2.5.36/arch/i386/kernel/smpboot.c d36/arch/i386/kernel/smpboot.c
--- 2.5.36/arch/i386/kernel/smpboot.c	Tue Sep 17 17:58:58 2002
+++ d36/arch/i386/kernel/smpboot.c	Thu Sep 19 16:22:08 2002
@@ -496,59 +496,23 @@
 	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
-/* which physical APIC ID maps to which logical CPU number */
-volatile int physical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
-volatile int cpu_2_physical_apicid[NR_CPUS];
+volatile u8 cpu_2_physical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
-/* which logical APIC ID maps to which logical CPU number */
-volatile int logical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which logical APIC ID */
-volatile int cpu_2_logical_apicid[NR_CPUS];
+volatile u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
-static inline void init_cpu_to_apicid(void)
-/* Initialize all maps between cpu number and apicids */
-{
-	int apicid, cpu;
-
-	for (apicid = 0; apicid < MAX_APICID; apicid++) {
-		physical_apicid_2_cpu[apicid] = -1;
-		logical_apicid_2_cpu[apicid] = -1;
-	}
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpu_2_physical_apicid[cpu] = -1;
-		cpu_2_logical_apicid[cpu] = -1;
-	}
-}
 
-static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
-/* 
- * set up a mapping between cpu and apicid. Uses logical apicids for multiquad,
- * else physical apic ids
- */
+static inline void map_cpu_to_boot_apicid(int cpu, u8 phys_apicid, u8 log_apicid)
 {
-	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = cpu;	
-		cpu_2_logical_apicid[cpu] = apicid;
-	} else {
-		physical_apicid_2_cpu[apicid] = cpu;	
-		cpu_2_physical_apicid[cpu] = apicid;
-	}
+	cpu_2_logical_apicid[cpu] = log_apicid;
+	cpu_2_physical_apicid[cpu] = phys_apicid;
 }
 
-static inline void unmap_cpu_to_boot_apicid(int cpu, int apicid)
-/* 
- * undo a mapping between cpu and apicid. Uses logical apicids for multiquad,
- * else physical apic ids
- */
+static inline void unmap_cpu_to_boot_apicid(int cpu, u8 phys_apicid, u8 log_apicid)
 {
-	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_logical_apicid[cpu] = -1;
-	} else {
-		physical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_physical_apicid[cpu] = -1;
-	}
+	cpu_2_logical_apicid[cpu] = BAD_APICID;
+	cpu_2_physical_apicid[cpu] = BAD_APICID;
 }
 
 #if APIC_DEBUG
@@ -762,7 +726,7 @@
 
 extern unsigned long cpu_initialized;
 
-static void __init do_boot_cpu (int apicid) 
+static void __init do_boot_cpu(u8 phys_apicid, u8 log_apicid)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -772,7 +736,7 @@
 	unsigned long boot_error = 0;
 	int timeout, cpu;
 	unsigned long start_eip;
-	unsigned short nmi_high, nmi_low;
+	unsigned short nmi_high = 0, nmi_low = 0;
 
 	cpu = ++cpucount;
 	/*
@@ -789,7 +753,7 @@
 	 */
 	init_idle(idle, cpu);
 
-	map_cpu_to_boot_apicid(cpu, apicid);
+	map_cpu_to_boot_apicid(cpu, phys_apicid, log_apicid);
 
 	idle->thread.eip = (unsigned long) start_secondary;
 
@@ -799,7 +763,8 @@
 	start_eip = setup_trampoline();
 
 	/* So we see what's up   */
-	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
+	printk("Booting processor %d/0x%02X/0x%02X eip 0x%lX\n",
+		cpu, phys_apicid, log_apicid, start_eip);
 	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
 
 	/*
@@ -811,7 +776,7 @@
 
 	Dprintk("Setting warm reset code and vector.\n");
 
-	if (clustered_apic_mode) {
+	if (clustered_apic_numaq) {
 		/* stash the current NMI vector, so we can put things back */
 		nmi_high = *((volatile unsigned short *) TRAMPOLINE_HIGH);
 		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
@@ -828,7 +793,7 @@
 	/*
 	 * Be paranoid about clearing APIC errors.
 	 */
-	if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[apicid])) {
+	if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[phys_apicid])) {
 		apic_read_around(APIC_SPIV);
 		apic_write(APIC_ESR, 0);
 		apic_read(APIC_ESR);
@@ -843,10 +808,10 @@
 	 * Starting actual IPI sequence...
 	 */
 
-	if (clustered_apic_mode)
-		boot_error = wakeup_secondary_via_NMI(apicid);
-	else 
-		boot_error = wakeup_secondary_via_INIT(apicid, start_eip);
+	if (clustered_apic_numaq)
+		boot_error = wakeup_secondary_via_NMI(log_apicid);
+	else
+		boot_error = wakeup_secondary_via_INIT(phys_apicid, start_eip);
 
 	if (!boot_error) {
 		/*
@@ -881,14 +846,15 @@
 				/* trampoline code not run */
 				printk("Not responding.\n");
 #if APIC_DEBUG
+			/* xAPICs don't do remote inquiries. */
 			if (!clustered_apic_mode)
-				inquire_remote_apic(apicid);
+				inquire_remote_apic(phys_apicid);
 #endif
 		}
 	}
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
-		unmap_cpu_to_boot_apicid(cpu, apicid);
+		unmap_cpu_to_boot_apicid(cpu, phys_apicid, log_apicid);
 		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
@@ -897,7 +863,7 @@
 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)phys_to_virt(8192)) = 0;
 
-	if(clustered_apic_mode) {
+	if (clustered_apic_numaq) {
 		printk("Restoring NMI vector\n");
 		*((volatile unsigned short *) TRAMPOLINE_HIGH) = nmi_high;
 		*((volatile unsigned short *) TRAMPOLINE_LOW) = nmi_low;
@@ -956,7 +922,6 @@
 extern int prof_old_multiplier[NR_CPUS];
 extern int prof_counter[NR_CPUS];
 
-static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
 
@@ -965,7 +930,9 @@
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit;
-
+	int cpu, bit;
+	u8 phys_apicid, log_apicid;
+  
 	/*
 	 * Initialize the logical to physical CPU number mapping
 	 * and the per-CPU profiling counter/multiplier
@@ -977,8 +944,6 @@
 		prof_multiplier[cpu] = 1;
 	}
 
-	init_cpu_to_apicid();
-
 	/*
 	 * Setup boot CPU information
 	 */
@@ -991,8 +956,15 @@
 	 */
 	set_bit(0, &cpu_online_map);
 	set_bit(0, &cpu_callout_map);
-	boot_cpu_logical_apicid = logical_smp_processor_id();
-	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
+	if (clustered_apic_xapic)
+		boot_cpu_logical_apicid = xapic_physical_to_logical_apicid(boot_cpu_physical_apicid);
+	else if (clustered_apic_numaq)
+		boot_cpu_logical_apicid = logical_smp_processor_id();
+	else
+		boot_cpu_logical_apicid = 0x01;
+	map_cpu_to_boot_apicid(0, boot_cpu_physical_apicid, boot_cpu_logical_apicid);
+	printk("Boot CPU #0/0x%02X/0x%02X\n",
+		boot_cpu_physical_apicid, boot_cpu_logical_apicid);
 
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
@@ -1060,7 +1032,7 @@
 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
 
-        if (clustered_apic_mode && (numnodes > 1)) {
+        if (clustered_apic_numaq && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
 			numnodes);
                 printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
@@ -1069,6 +1041,7 @@
                 xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
 			numnodes * XQUAD_PORTIO_LEN);
         }
+#endif
 
 	/*
 	 * Scan the CPU present map and fire up the other CPUs via do_boot_cpu
@@ -1079,28 +1052,44 @@
 	 */
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
-	for (bit = 0; bit < NR_CPUS; bit++) {
-		apicid = cpu_present_to_apicid(bit);
+	for (cpu = 1, bit = 0; bit < NR_CPUS; bit++) {
+		if (!(logical_cpu_present_map & (1ul << bit)))
+			continue;
+		if ((max_cpus >= 0) && (max_cpus <= cpucount + 1))
+			continue;
+		phys_apicid = raw_phys_apicid[bit];
 		/*
 		 * Don't even attempt to start the boot CPU!
 		 */
-		if (apicid == boot_cpu_apicid)
+		if (phys_apicid == boot_cpu_physical_apicid)
 			continue;
-
-		if (!(phys_cpu_present_map & (1 << bit)))
-			continue;
-		if (max_cpus <= cpucount+1)
+		if (phys_apicid == BAD_APICID)
 			continue;
+		if (clustered_apic_xapic)
+			log_apicid = (u8)xapic_physical_to_logical_apicid(phys_apicid);
+		else if (clustered_apic_numaq)
+			log_apicid = ((bit >> 2) << 4) | (1 << (bit & 0x3));
+		else {
+			/* Yes, this overflows if cpu > 7.  The APIC
+			 * destination register is only 8 bits wide.
+			 * For more than 8 CPUs, must use clustered mode. */
+			log_apicid = 1u << cpu;
+			if (log_apicid == 0)
+				BUG();
+		}
 
-		do_boot_cpu(apicid);
+		do_boot_cpu(phys_apicid, log_apicid);
 
 		/*
 		 * Make sure we unmap all failed CPUs
 		 */
-		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
-			printk("CPU #%d not responding - cannot use it.\n",
-								apicid);
+		if ((cpu_2_physical_apicid[cpu] == BAD_APICID) &&
+				(logical_cpu_present_map & (1ul << bit))) {
+			printk("CPU #%d/0x%02X/0x%02X not responding - cannot use it.\n",
+					bit, phys_apicid, log_apicid);
+			logical_cpu_present_map &= ~(1ul << bit);
+		} else
+			++cpu;		/* Got a live one. */
 	}
 
 	/*
diff -ruN 2.5.36/arch/i386/kernel/trampoline.S d36/arch/i386/kernel/trampoline.S
--- 2.5.36/arch/i386/kernel/trampoline.S	Tue Sep 17 17:58:52 2002
+++ d36/arch/i386/kernel/trampoline.S	Thu Sep 19 16:22:08 2002
@@ -36,9 +36,7 @@
 
 ENTRY(trampoline_data)
 r_base = .
-#ifdef CONFIG_MULTIQUAD
 	wbinvd
-#endif /* CONFIG_MULTIQUAD */
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
diff -ruN 2.5.36/include/asm-i386/acpi.h d36/include/asm-i386/acpi.h
--- 2.5.36/include/asm-i386/acpi.h	Tue Sep 17 17:59:16 2002
+++ d36/include/asm-i386/acpi.h	Thu Sep 19 16:22:08 2002
@@ -138,6 +138,9 @@
 /* early initialization routine */
 extern void acpi_reserve_bootmem(void);
 
+/* Check for special HW using OEM name lists */
+extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);
+
 #endif /*CONFIG_ACPI_SLEEP*/
 
 #endif /*__KERNEL__*/
diff -ruN 2.5.36/include/asm-i386/apic.h d36/include/asm-i386/apic.h
--- 2.5.36/include/asm-i386/apic.h	Tue Sep 17 17:59:20 2002
+++ d36/include/asm-i386/apic.h	Thu Sep 19 16:22:08 2002
@@ -64,6 +64,22 @@
 	apic_write_around(APIC_EOI, 0);
 }
 
+static inline void apic_set_tpr(unsigned long val)
+{
+	unsigned long value;
+
+	value = apic_read(APIC_TASKPRI);
+	apic_write_around(APIC_TASKPRI, (value & ~APIC_TPRI_MASK) + val);
+}
+
+static inline void apic_adj_tpr(long adj)
+{
+	unsigned long value;
+
+	value = apic_read(APIC_TASKPRI);
+	apic_write_around(APIC_TASKPRI, value + adj);
+}
+
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
@@ -97,6 +113,15 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+#else /* CONFIG_X86_LOCAL_APIC */
+#define apic_set_tpr(val)
+#define apic_adj_tpr(adj)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+/* Priority values for apic_adj_tpr() and apic_set_tpr() */
+/* xAPICs only do priority comparisons on the upper nibble. */
+#define TPR_IDLE	(0x00L)
+#define TPR_TASK	(0x10L)
+#define TPR_IRQ		(0x10L)
+
 #endif /* __ASM_APIC_H */
diff -ruN 2.5.36/include/asm-i386/apicdef.h d36/include/asm-i386/apicdef.h
--- 2.5.36/include/asm-i386/apicdef.h	Tue Sep 17 17:58:59 2002
+++ d36/include/asm-i386/apicdef.h	Thu Sep 19 16:22:08 2002
@@ -11,8 +11,10 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
-#define			APIC_ID_MASK		(0x0F<<24)
-#define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#define			APIC_ID_MASK		(0xFF<<24)
+#define			GET_APIC_ID(x)		(((x)>>24)&0xFF)
+#define				XAPIC_VER_LOW	0x14	/* Version num range */
+#define				XAPIC_VER_HIGH	0x1F
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
@@ -32,6 +34,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER	0x0FFFFFFFul	/* Clustered */
+#define			APIC_DFR_FLAT		0xFFFFFFFFul	/* Flat mode */
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
@@ -58,6 +62,7 @@
 #define			APIC_INT_ASSERT		0x04000
 #define			APIC_ICR_BUSY		0x01000
 #define			APIC_DEST_LOGICAL	0x00800
+#define				APIC_DEST_PHYSICAL	0x0	/* For symmetry */
 #define			APIC_DM_FIXED		0x00000
 #define			APIC_DM_LOWEST		0x00100
 #define			APIC_DM_SMI		0x00200
@@ -108,7 +113,13 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
-#define MAX_IO_APICS 8
+#define MAX_IO_APICS 32	/* Summit boxes can have 4*(2+3*2) I/O APICs */
+
+/*
+ * The intr broadcast ID is 0xF for old APICs and 0xFF for xAPICs.
+ */
+#define APIC_BROADCAST_ID_XAPIC	0xFF
+#define APIC_BROADCAST_ID_APIC	0x0F
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well
diff -ruN 2.5.36/include/asm-i386/mpspec.h d36/include/asm-i386/mpspec.h
--- 2.5.36/include/asm-i386/mpspec.h	Tue Sep 17 17:58:40 2002
+++ d36/include/asm-i386/mpspec.h	Thu Sep 19 16:22:08 2002
@@ -14,13 +14,10 @@
 #define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
 
 /*
- * a maximum of 16 APICs with the current APIC ID architecture.
+ * A maximum of 16 APICs with the classic APIC ID architecture.
+ * xAPICs can have up to 256.
  */
-#ifdef CONFIG_MULTIQUAD
 #define MAX_APICS 256
-#else /* !CONFIG_MULTIQUAD */
-#define MAX_APICS 16
-#endif /* CONFIG_MULTIQUAD */
 
 #define MAX_MPC_ENTRY 1024
 
@@ -204,6 +201,7 @@
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
+extern unsigned int boot_cpu_logical_apicid;
 extern unsigned long phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
diff -ruN 2.5.36/include/asm-i386/smp.h d36/include/asm-i386/smp.h
--- 2.5.36/include/asm-i386/smp.h	Tue Sep 17 17:58:43 2002
+++ d36/include/asm-i386/smp.h	Thu Sep 19 16:22:08 2002
@@ -18,33 +18,56 @@
 #include <asm/io_apic.h>
 #endif
 #include <asm/apic.h>
-#endif
-#endif
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_X86_LOCAL_APIC */
 
-#ifdef CONFIG_SMP
-# ifdef CONFIG_MULTIQUAD
-#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
-#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
-# else
-#  define TARGET_CPUS cpu_online_map
-#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
-# endif
-#else
-# define INT_DELIVERY_MODE 1     /* logical delivery */
-# define TARGET_CPUS 0x01
-#endif
+#ifndef __ASSEMBLY__
+extern u8 clustered_apic_mode;
+extern u8 esr_disable;
+extern u32 apic_broadcast_id;
+extern unsigned long logical_cpu_present_map;
+extern unsigned long phys_cpu_present_map;
+
+/*
+ * Some lowlevel functions might want to know about
+ * the real APIC ID <-> CPU # mapping.
+ */
+#define MAX_APICID 256
+#define BAD_APICID 0xFFu
+extern volatile u8 cpu_2_physical_apicid[NR_CPUS];
+extern volatile u8 physical_apicid_2_cpu[MAX_APICID];
+extern volatile u8 cpu_2_logical_apicid[NR_CPUS];
+extern volatile u8 logical_apicid_2_cpu[MAX_APICID];
+
+/*
+ * This function is needed by all SMP systems. It must _always_ be valid
+ * from the initial startup. We map APIC_BASE very early in page_setup(),
+ * so this is correct in the x86 case.
+ */
+
+#ifndef CONFIG_X86_LOCAL_APIC
+
+#define clustered_apic_mode	(0)
+#define esr_disable		(0)
+
+#endif /* !CONFIG_X86_LOCAL_APIC */
+
+#endif /* !__ASSEMBLY__ */
+
+#define CLUSTERED_APIC_NUMAQ	0x01
+#define CLUSTERED_APIC_XAPIC	0x02
+
+#define clustered_apic_numaq	(clustered_apic_mode & CLUSTERED_APIC_NUMAQ)
+#define clustered_apic_xapic	(clustered_apic_mode & CLUSTERED_APIC_XAPIC)
+
+#define APIC_DEST_CPUS_MASK	0x0Fu	/* Destination masks for */
+#define APIC_DEST_CLUSTER_MASK	0xF0u	/* clustered mode. */
+#define INT_DEST_ADDR_MODE	1	/* logical delivery */
 
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
-  #define esr_disable (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
-  #define esr_disable (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif 
 
 #ifdef CONFIG_SMP
+#define smp_processor_id() (current->processor)
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -52,7 +75,6 @@
  */
  
 extern void smp_alloc_memory(void);
-extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
@@ -66,16 +88,7 @@
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
-
-/*
- * Some lowlevel functions might want to know about
- * the real APIC ID <-> CPU # mapping.
- */
-#define MAX_APICID 256
-extern volatile int cpu_to_physical_apicid[NR_CPUS];
-extern volatile int physical_apicid_to_cpu[MAX_APICID];
-extern volatile int cpu_to_logical_apicid[NR_CPUS];
-extern volatile int logical_apicid_to_cpu[MAX_APICID];
+extern void smp_cluster_apic_check(void);	/* cluster mode test */
 
 /*
  * This function is needed by all SMP systems. It must _always_ be valid
@@ -122,7 +135,7 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define NO_PROC_ID		0xFF		/* No processor magic marker */
+#define NO_PROC_ID		0xFFu		/* No processor magic marker */
 
-#endif
-#endif
+#endif /* CONFIG_SMP */
+#endif /* __ASM_SMP_H */
diff -ruN 2.5.36/include/asm-i386/smpboot.h d36/include/asm-i386/smpboot.h
--- 2.5.36/include/asm-i386/smpboot.h	Tue Sep 17 17:59:18 2002
+++ d36/include/asm-i386/smpboot.h	Thu Sep 19 16:22:08 2002
@@ -1,62 +1,42 @@
 #ifndef __ASM_SMPBOOT_H
 #define __ASM_SMPBOOT_H
 
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif 
- 
-#ifdef CONFIG_MULTIQUAD
- #define TRAMPOLINE_LOW phys_to_virt(0x8)
- #define TRAMPOLINE_HIGH phys_to_virt(0xa)
-#else /* !CONFIG_MULTIQUAD */
- #define TRAMPOLINE_LOW phys_to_virt(0x467)
- #define TRAMPOLINE_HIGH phys_to_virt(0x469)
-#endif /* CONFIG_MULTIQUAD */
-
-#ifdef CONFIG_MULTIQUAD
- #define boot_cpu_apicid boot_cpu_logical_apicid
-#else /* !CONFIG_MULTIQUAD */
- #define boot_cpu_apicid boot_cpu_physical_apicid
-#endif /* CONFIG_MULTIQUAD */
+#ifndef __ASM_SMP_H
+#include "asm/smp.h"
+#endif
+
+#define TRAMPOLINE_LOW phys_to_virt(clustered_apic_numaq?0x8:0x467)
+#define TRAMPOLINE_HIGH phys_to_virt(clustered_apic_numaq?0xa:0x469)
+
+/*
+ * To build the logical APIC ID for each CPU we have three cases:
+ *  1) Normal flat mode:  use a bitmap of the CPU numbers
+ *  2) NUMA-Q:  do nothing, the BIOS has set it up
+ *  3) xAPIC:  convert the Intel standard physical APIC ID to a cluster
+ *	nibble/cpu bitmap nibble
+ */
+/* cpu index numbr:  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, ... */
+/* phys xAPIC IDs : 00, 01, 02, 03, 10, 11, 12, 13, 20, 21, 22, ... */
+/* logical APIC ID: 01, 02, 04, 08, 11, 12, 14, 18, 21, 22, 24, ... */
+#define xapic_physical_to_logical_apicid(phys_apic) ((1ul << ((phys_apic) & 0x3)) | ((phys_apic) & APIC_DEST_CLUSTER_MASK))
 
 /*
- * How to map from the cpu_present_map
+ * How to map from phys_cpu_present_map.
+ *  1) Normal flat mode:  use the mps_cpu, apicid bitmap
+ *  2) Multi-Quad:  only 4 CPUs per cluster, cluster ID in high nibble
  */
-#ifdef CONFIG_MULTIQUAD
- #define cpu_present_to_apicid(mps_cpu) ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) )
-#else /* !CONFIG_MULTIQUAD */
- #define cpu_present_to_apicid(apicid) (apicid)
-#endif /* CONFIG_MULTIQUAD */
+#define cpu_present_to_apicid(cpu)	(cpu_to_logical_apicid(cpu))
+extern unsigned char raw_phys_apicid[NR_CPUS];
+#define apicid_to_phys_cpu_present(apicid)	(clustered_apic_mode ? (1ul << ((((apicid) >> 4) << 2) | ((apicid) & 0x3))) : (1ul << (apicid)))
 
 /*
  * Mappings between logical cpu number and logical / physical apicid
- * The first four macros are trivial, but it keeps the abstraction consistent
  */
-extern volatile int logical_apicid_2_cpu[];
-extern volatile int cpu_2_logical_apicid[];
-extern volatile int physical_apicid_2_cpu[];
-extern volatile int cpu_2_physical_apicid[];
-
-#define logical_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
-#define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
-#ifdef CONFIG_MULTIQUAD			/* use logical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_logical_apicid[cpu]
-#else /* !CONFIG_MULTIQUAD */		/* use physical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
-#endif /* CONFIG_MULTIQUAD */
-
-
-#ifdef CONFIG_MULTIQUAD
-#else /* !CONFIG_MULTIQUAD */
-#endif /* CONFIG_MULTIQUAD */
+extern volatile u8 cpu_2_logical_apicid[];
+extern volatile u8 cpu_2_physical_apicid[];
+
+#define cpu_to_logical_apicid(cpu)	(int)cpu_2_logical_apicid[cpu]
+#define cpu_to_physical_apicid(cpu)	(int)cpu_2_physical_apicid[cpu]
 
 
 #endif

--------------Boundary-00=_T0VPHWCXATGYUOING3R5--

