Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbRLFEpF>; Wed, 5 Dec 2001 23:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284971AbRLFEos>; Wed, 5 Dec 2001 23:44:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40918 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284970AbRLFEoc>; Wed, 5 Dec 2001 23:44:32 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_6UNWBLEIBOKGGDXX8HET"
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: linux-kernel@vger.kernel.org
Subject: [CFT] xAPIC patches break Dell 420
Date: Wed, 5 Dec 2001 20:44:30 -0800
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01120520443003.01494@w-jamesc.des.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6UNWBLEIBOKGGDXX8HET
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

The following patches are meant for the forthcoming Summit chipset for a new 
IBM NUMA box.  The problem is that bcrl at Red Hat found that they cause a 
Dell 420 box to take an infinite number of APIC error interrupts with a value 
of 8:  Receive Accept Error.  This happens around the time that network 
devices are being probed.  We've tried the patches on all the hardware handy 
and can't make it break.  Could someone out there give it a try on different 
SMP boxes?  Thanks!

Background:

These patches are to support up to 16 CPUs in a Foster/xAPIC NUMA box.  The 
xAPICs are used in parallel mode (i.e. they send the interrupt message down a 
system bus), much like the SAPICs for IA64.  As such, they share a problem 
with SAPICs:  only one CPU per cluster (usually 4 CPUs per cluster) will be 
hit by all the interrupts.  This is because Linux doesn't change the TPR or 
XTPR registers after zeroing them at boot.  So, all interrupts go to 
whichever CPU is picked by the host bridge's tie-breaker logic.  I've got a 
simple round robin function in the patch to help distribute the load a bit 
better, but it could certainly use some improvements, later.  Right now it 
works OK.

I've hijacked Martin Bligh's CONFIG_MULTIQUAD code to do this and broken it 
for the target hardware.  So, the dozen or so folks out there who run Linux 
instead of Dynix/ptx on their NUMA-Q boxes needn't try these patches yet.  8^)

Thanks again!

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com


--------------Boundary-00=_6UNWBLEIBOKGGDXX8HET
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="summit_patch.2001-12-04_2.4.16"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="summit_patch.2001-12-04_2.4.16"

diff -ru linux-2.4.16/arch/i386/kernel/apic.c jamesc-2.4.16/arch/i386/kernel/apic.c
--- linux-2.4.16/arch/i386/kernel/apic.c	Fri Nov  9 14:12:55 2001
+++ jamesc-2.4.16/arch/i386/kernel/apic.c	Wed Nov 28 19:21:12 2001
@@ -29,6 +29,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/smpboot.h>
 
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer = 0;
@@ -282,21 +283,20 @@
 	 * document number 292116).  So here it goes...
 	 */
 
-	if (!clustered_apic_mode) {
+	if (!clustered_apic_logical) {
 		/*
-		 * In clustered apic mode, the firmware does this for us 
-		 * Put the APIC into flat delivery mode.
-		 * Must be "all ones" explicitly for 82489DX.
+		 * For NUMA-Q (clustered apic logical), the firmware does this
+		 * for us.  Otherwise, put the APIC into clustered or flat
+		 * delivery mode.  Must be "all ones" explicitly for 82489DX.
 		 */
-		apic_write_around(APIC_DFR, 0xffffffff);
+		apic_write_around(APIC_DFR, (clustered_apic_mode ?
+					     APIC_DFR_CLUSTER : APIC_DFR_FLAT));
 
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
diff -ru linux-2.4.16/arch/i386/kernel/io_apic.c jamesc-2.4.16/arch/i386/kernel/io_apic.c
--- linux-2.4.16/arch/i386/kernel/io_apic.c	Tue Nov 13 17:28:41 2001
+++ jamesc-2.4.16/arch/i386/kernel/io_apic.c	Tue Dec  4 18:06:41 2001
@@ -32,6 +32,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include <asm/smpboot.h>
 
 #undef APIC_LOCKUP_DEBUG
 
@@ -577,6 +578,37 @@
 	return current_vector;
 }
 
+#ifdef CONFIG_SMP
+/*
+ * round_robin_cpu_apic_id -- Since Linux doesn't use either the APIC TPRs or
+ * XTPRs to set task/interrupt priority, xAPICs and SAPICs tend to hit one CPU
+ * with all interrupts for each quad.  Distribute the interrupts using a simple
+ * round robin scheme.
+ * (I wish we could get dynamic load leveling without serious hacks to
+ * the interrupt entry points, scheduler, etc.)
+ */
+static inline int round_robin_cpu_apic_id(void)
+{
+	int		val;
+	static unsigned	next_cpu = 0;
+
+	for (;; ++next_cpu) {
+		if (next_cpu >= NR_CPUS)
+			next_cpu = 0;
+		if (!(logical_cpu_present_map & (1UL << next_cpu)))
+			continue;
+		val = cpu_present_to_apicid(next_cpu);
+		++next_cpu;
+		return (val);
+	}
+}
+#else /* CONFIG_SMP */
+static inline int round_robin_cpu_apic_id(void)
+{
+	return (0);
+}
+#endif /* CONFIG_SMP */
+
 extern void (*interrupt[NR_IRQS])(void);
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
@@ -597,10 +629,12 @@
 		 */
 		memset(&entry,0,sizeof(entry));
 
-		entry.delivery_mode = dest_LowestPrio;
-		entry.dest_mode = INT_DELIVERY_MODE;
+		entry.delivery_mode = INT_DELIVERY_MODE;
+		entry.dest_mode = INT_DEST_ADDR_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest =
+			(clustered_apic_physical ? round_robin_cpu_apic_id() :
+						TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -618,7 +652,6 @@
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -977,6 +1010,11 @@
 		nr_ioapic_registers[i] = reg_01.entries+1;
 	}
 
+#if 0
+	if (clustered_apic_mode)
+		/* We don't have a good way to do this yet - hack */
+		phys_id_present_map = (u_long) 0xf;
+#endif
 	/*
 	 * Do not trust the IO-APIC being empty at bootup
 	 */
@@ -1027,7 +1065,7 @@
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
+		if (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1039,14 +1077,16 @@
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
+		 * I/O APIC IDs no longer have any meaning for xAPICs and SAPICs.
 		 */
-		if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid)) {
+		if (!clustered_apic_physical &&
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
diff -ru linux-2.4.16/arch/i386/kernel/mpparse.c jamesc-2.4.16/arch/i386/kernel/mpparse.c
--- linux-2.4.16/arch/i386/kernel/mpparse.c	Fri Nov  9 14:58:18 2001
+++ jamesc-2.4.16/arch/i386/kernel/mpparse.c	Tue Dec  4 19:29:16 2001
@@ -26,6 +26,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/smpboot.h>
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -62,6 +63,18 @@
 
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
+unsigned long logical_cpu_present_map;
+
+#ifdef CONFIG_SMP
+unsigned char clustered_apic_mode = 0;
+unsigned char clustered_apic_physical = 0;
+unsigned char esr_disable = 0;
+unsigned char target_cpus = APIC_BROADCAST_ID_APIC;
+unsigned char int_delivery_mode = dest_LowestPrio;
+unsigned char int_dest_addr_mode = (unsigned char) APIC_DEST_LOGICAL;
+unsigned int apic_broadcast_id = APIC_BROADCAST_ID_APIC;
+#endif /* CONFIG_SMP */
+unsigned char raw_phys_apicid[NR_CPUS] = { 0 };
 
 /*
  * Intel MP BIOS table parsing routines:
@@ -143,7 +156,7 @@
 		return;
 
 	logical_apicid = m->mpc_apicid;
-	if (clustered_apic_mode) {
+	if (clustered_apic_logical) {
 		quad = translation_table[mpc_record]->trans_quad;
 		logical_apicid = (quad << 4) + 
 			(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
@@ -223,11 +236,8 @@
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
@@ -236,6 +246,7 @@
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
 static void __init MP_bus_info (struct mpc_config_bus *m)
@@ -245,7 +256,7 @@
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
 	
-	if (clustered_apic_mode) {
+	if (clustered_apic_logical) {
 		mp_bus_id_to_node[m->mpc_busid] = translation_table[mpc_record]->trans_quad;
 		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, mp_bus_id_to_node[m->mpc_busid]);
 	} else {
@@ -388,6 +399,7 @@
 	char str[16];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
+	int xapic = 0;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
@@ -413,6 +425,11 @@
 	memcpy(str,mpc->mpc_oem,8);
 	str[8]=0;
 	printk("OEM ID: %s ",str);
+	/*
+	 * Can't recognize Summit xAPICs at present, so use the OEM ID.
+	 */
+	if (!strncmp(str, "IBM ENSW", 8)) 
+		xapic = 1;
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
@@ -426,7 +443,7 @@
 	if (!have_acpi_tables)
 		mp_lapic_addr = mpc->mpc_lapic;
 
-	if (clustered_apic_mode && mpc->mpc_oemptr) {
+	if (clustered_apic_logical && mpc->mpc_oemptr) {
 		/* We need to process the oem mpc tables to tell us which quad things are in ... */
 		mpc_record = 0;
 		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, mpc->mpc_oemsize);
@@ -466,6 +483,19 @@
 				MP_ioapic_info(m);
 				mpt+=sizeof(*m);
 				count+=sizeof(*m);
+		/******
+		 * Kludge Alert!  We have an APIC version number collision
+		 * between the APICs on Scorpio-based NUMA-Q boxes and Summit
+		 * xAPICs.  Intel didn't define the xAPIC ver ID range until
+		 * relatively recently, so there is working silicon out there
+		 * that doesn't match their range.
+		 * For now, use the OEM strings until we have some assurance
+		 * that only xAPICs occupy the version number range below.
+		 ****
+				if (m->mpc_apicver >= XAPIC_ID_LOW &&
+				    m->mpc_apicver <= XAPIC_ID_HIGH)
+					xapic = 1;
+		 ******/
 				break;
 			}
 			case MP_INTSRC:
@@ -495,10 +525,27 @@
 		}
 		++mpc_record;
 	}
-	if (clustered_apic_mode && nr_ioapics > 2) {
-		/* don't initialise IO apics on secondary quads */
+	if (xapic || clustered_apic_logical) {
+#ifdef CONFIG_SMP
+		clustered_apic_mode = (unsigned char) 1;
+		clustered_apic_physical = (unsigned char) xapic;
+		esr_disable = 1;
+		target_cpus = (xapic ? APIC_BROADCAST_ID_XAPIC : APIC_BROADCAST_ID_APIC);
+		apic_broadcast_id = (xapic ? APIC_BROADCAST_ID_XAPIC : APIC_BROADCAST_ID_APIC);
+		int_dest_addr_mode = (xapic ? APIC_DEST_PHYSICAL : APIC_DEST_LOGICAL);
+		int_delivery_mode = (xapic ? dest_Fixed : dest_LowestPrio);
+#endif /* CONFIG_SMP */
+		phys_cpu_present_map = logical_cpu_present_map;
+	}
+#ifdef CONFIG_SMP
+	if (clustered_apic_logical && nr_ioapics > 2) {
+		/* NUMA-Q: don't initialise IO apics on secondary quads, yet. */
 		nr_ioapics = 2;
 	}
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		(clustered_apic_mode ? (clustered_apic_logical ? "Clustered Logical" : "Physical") : "Flat"),
+		nr_ioapics);
+#endif /* CONFIG_SMP */
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
diff -ru linux-2.4.16/arch/i386/kernel/process.c jamesc-2.4.16/arch/i386/kernel/process.c
--- linux-2.4.16/arch/i386/kernel/process.c	Thu Oct  4 18:42:54 2001
+++ jamesc-2.4.16/arch/i386/kernel/process.c	Wed Nov 28 18:20:05 2001
@@ -186,7 +186,7 @@
 			}
 				/* we will leave sorting out the final value 
 				when we are ready to reboot, since we might not
- 				have set up boot_cpu_id or smp_num_cpu */
+ 				have set up boot_cpu_physical_apicid or smp_num_cpu */
 			break;
 #endif
 		}
diff -ru linux-2.4.16/arch/i386/kernel/smp.c jamesc-2.4.16/arch/i386/kernel/smp.c
--- linux-2.4.16/arch/i386/kernel/smp.c	Tue Oct 23 14:17:10 2001
+++ jamesc-2.4.16/arch/i386/kernel/smp.c	Tue Dec  4 18:23:00 2001
@@ -114,7 +114,7 @@
 
 static inline int __prepare_ICR (unsigned int shortcut, int vector)
 {
-	return APIC_DM_FIXED | shortcut | vector | APIC_DEST_LOGICAL;
+	return APIC_DM_FIXED | shortcut | vector | int_dest_addr_mode;
 }
 
 static inline int __prepare_ICR2 (unsigned int mask)
@@ -213,7 +213,9 @@
 			/*
 			 * prepare target chip field
 			 */
-			cfg = __prepare_ICR2(cpu_to_logical_apicid(query_cpu));
+			cfg = __prepare_ICR2(clustered_apic_physical ?
+					cpu_to_physical_apicid(query_cpu) :
+					cpu_to_logical_apicid(query_cpu));
 			apic_write_around(APIC_ICR2, cfg);
 		
 			/*
diff -ru linux-2.4.16/arch/i386/kernel/smpboot.c jamesc-2.4.16/arch/i386/kernel/smpboot.c
--- linux-2.4.16/arch/i386/kernel/smpboot.c	Wed Nov 21 10:35:48 2001
+++ jamesc-2.4.16/arch/i386/kernel/smpboot.c	Tue Dec  4 17:23:56 2001
@@ -536,7 +536,7 @@
  * else physical apic ids
  */
 {
-	if (clustered_apic_mode) {
+	if (clustered_apic_logical) {
 		logical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_logical_apicid[cpu] = apicid;
 	} else {
@@ -551,7 +551,7 @@
  * else physical apic ids
  */
 {
-	if (clustered_apic_mode) {
+	if (clustered_apic_logical) {
 		logical_apicid_2_cpu[apicid] = -1;	
 		cpu_2_logical_apicid[cpu] = -1;
 	} else {
@@ -781,7 +781,7 @@
 	unsigned long boot_error = 0;
 	int timeout, cpu;
 	unsigned long start_eip;
-	unsigned short nmi_high, nmi_low;
+	unsigned short nmi_high = 0, nmi_low = 0;
 
 	cpu = ++cpucount;
 	/*
@@ -826,7 +826,7 @@
 
 	Dprintk("Setting warm reset code and vector.\n");
 
-	if (clustered_apic_mode) {
+	if (clustered_apic_logical) {
 		/* stash the current NMI vector, so we can put things back */
 		nmi_high = *((volatile unsigned short *) TRAMPOLINE_HIGH);
 		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
@@ -858,7 +858,7 @@
 	 * Starting actual IPI sequence...
 	 */
 
-	if (clustered_apic_mode)
+	if (clustered_apic_logical)
 		boot_error = wakeup_secondary_via_NMI(apicid);
 	else 
 		boot_error = wakeup_secondary_via_INIT(apicid, start_eip);
@@ -913,7 +913,7 @@
 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)phys_to_virt(8192)) = 0;
 
-	if(clustered_apic_mode) {
+	if (clustered_apic_logical) {
 		printk("Restoring NMI vector\n");
 		*((volatile unsigned short *) TRAMPOLINE_HIGH) = nmi_high;
 		*((volatile unsigned short *) TRAMPOLINE_LOW) = nmi_low;
@@ -968,19 +968,23 @@
 extern int prof_counter[NR_CPUS];
 
 static int boot_cpu_logical_apicid;
+#ifdef CONFIG_MULTIQUAD
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio = NULL;
+#endif
 
 void __init smp_boot_cpus(void)
 {
 	int apicid, cpu, bit;
 
-        if (clustered_apic_mode) {
+#ifdef CONFIG_MULTIQUAD
+        if (clustered_apic_logical) {
                 /* remap the 1st quad's 256k range for cross-quad I/O */
                 xquad_portio = ioremap (XQUAD_PORTIO_BASE, XQUAD_PORTIO_LEN);
                 printk("Cross quad port I/O vaddr 0x%08lx, len %08lx\n",
                         (u_long) xquad_portio, (u_long) XQUAD_PORTIO_LEN);
         }
+#endif
 
 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */
@@ -1102,7 +1106,7 @@
 		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << bit)))
+		if (!(phys_cpu_present_map & (1ul << bit)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
@@ -1113,9 +1117,9 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
-			printk("CPU #%d not responding - cannot use it.\n",
-								apicid);
+				(phys_cpu_present_map & (1ul << bit)))
+			printk("CPU #%d/0x%02x not responding - cannot use it.\n",
+								bit, apicid);
 	}
 
 	/*
diff -ru linux-2.4.16/arch/i386/kernel/trampoline.S jamesc-2.4.16/arch/i386/kernel/trampoline.S
--- linux-2.4.16/arch/i386/kernel/trampoline.S	Thu Oct  4 18:42:54 2001
+++ jamesc-2.4.16/arch/i386/kernel/trampoline.S	Fri Nov 30 15:36:45 2001
@@ -36,9 +36,9 @@
 
 ENTRY(trampoline_data)
 r_base = .
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_SMP
 	wbinvd
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_SMP */
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
diff -ru linux-2.4.16/include/asm-i386/apicdef.h jamesc-2.4.16/include/asm-i386/apicdef.h
--- linux-2.4.16/include/asm-i386/apicdef.h	Sun Aug 12 11:13:59 2001
+++ jamesc-2.4.16/include/asm-i386/apicdef.h	Wed Nov 28 18:20:05 2001
@@ -11,13 +11,21 @@
 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
  
 #define		APIC_ID		0x20
+#ifdef CONFIG_SMP	/* Newer APIC family members have 8 bit phys IDs */
+#define			APIC_ID_MASK		(0xFF<<24)
+#define			GET_APIC_ID(x)		(((x)>>24)&0xFF)
+#else
 #define			APIC_ID_MASK		(0x0F<<24)
 #define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#endif /* CONFIG_SMP */
+#define				XAPIC_ID_LOW	0x14
+#define				XAPIC_ID_HIGH	0x1F
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
 #define			GET_APIC_MAXLVT(x)	(((x)>>16)&0xFF)
 #define			APIC_INTEGRATED(x)	((x)&0xF0)
+#define			xAPIC_VERSION_NUM	17	/* xAPICs at 17+ */
 #define		APIC_TASKPRI	0x80
 #define			APIC_TPRI_MASK		0xFF
 #define		APIC_ARBPRI	0x90
@@ -32,6 +40,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER	0x0FFFFFFFul	/* Clustered */
+#define			APIC_DFR_FLAT		0xFFFFFFFFul	/* Flat mode */
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
@@ -58,6 +68,7 @@
 #define			APIC_INT_ASSERT		0x04000
 #define			APIC_ICR_BUSY		0x01000
 #define			APIC_DEST_LOGICAL	0x00800
+#define				APIC_DEST_PHYSICAL	0x0	/* For symmetry */
 #define			APIC_DM_FIXED		0x00000
 #define			APIC_DM_LOWEST		0x00100
 #define			APIC_DM_SMI		0x00200
@@ -107,7 +118,18 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
-#define MAX_IO_APICS 8
+#ifdef CONFIG_SMP
+# define MAX_IO_APICS 16
+#else
+# define MAX_IO_APICS 8
+#endif /* CONFIG_SMP */
+
+/*
+ * The broadcast ID is 0xF for old APICs and 0xFF for xAPICs.  SAPICs
+ * don't broadcast (yet?), but if they did, they might use 0xFFFF.
+ */
+#define APIC_BROADCAST_ID_XAPIC	0xFF
+#define APIC_BROADCAST_ID_APIC	0x0F
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well
diff -ru linux-2.4.16/include/asm-i386/io.h jamesc-2.4.16/include/asm-i386/io.h
--- linux-2.4.16/include/asm-i386/io.h	Thu Nov 22 11:46:27 2001
+++ jamesc-2.4.16/include/asm-i386/io.h	Mon Dec  3 20:02:18 2001
@@ -235,6 +235,8 @@
 
 #ifdef CONFIG_MULTIQUAD
 extern void *xquad_portio;    /* Where the IO area was mapped */
+#else
+#define xquad_portio	((void *)0)	/* Just in case. */
 #endif /* CONFIG_MULTIQUAD */
 
 /*
diff -ru linux-2.4.16/include/asm-i386/mpspec.h jamesc-2.4.16/include/asm-i386/mpspec.h
--- linux-2.4.16/include/asm-i386/mpspec.h	Thu Nov 22 11:46:18 2001
+++ jamesc-2.4.16/include/asm-i386/mpspec.h	Tue Dec  4 14:47:49 2001
@@ -14,13 +14,14 @@
 #define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')
 
 /*
- * a maximum of 16 APICs with the current APIC ID architecture.
+ * A maximum of 16 APICs with the classic APIC ID architecture.
+ * xAPICs can have up to 256.  SAPICs have 16 ID bits.
  */
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_SMP
 #define MAX_APICS 256
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_SMP */
 #define MAX_APICS 16
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_SMP */
 
 #define MAX_MPC_ENTRY 1024
 
@@ -184,11 +185,11 @@
  *	7	2 CPU MCA+PCI
  */
 
-#ifdef CONFIG_MULTIQUAD
+#ifdef CONFIG_SMP
 #define MAX_IRQ_SOURCES 512
-#else /* !CONFIG_MULTIQUAD */
+#else /* !CONFIG_SMP */
 #define MAX_IRQ_SOURCES 256
-#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_SMP */
 
 #define MAX_MP_BUSSES 32
 enum mp_bustype {
diff -ru linux-2.4.16/include/asm-i386/smp.h jamesc-2.4.16/include/asm-i386/smp.h
--- linux-2.4.16/include/asm-i386/smp.h	Thu Nov 22 11:46:19 2001
+++ jamesc-2.4.16/include/asm-i386/smp.h	Tue Dec  4 19:10:00 2001
@@ -22,28 +22,35 @@
 #endif
 #endif
 
-#ifdef CONFIG_SMP
+#ifndef TARGET_CPUS
 # ifdef CONFIG_MULTIQUAD
-#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
-#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
+#  define clustered_apic_logical (1)
+# else
+#  define clustered_apic_logical (0)
+# endif /* CONFIG_MULTIQUAD */
+# ifdef CONFIG_SMP
+#  ifndef __ASSEMBLY__
+   extern unsigned char clustered_apic_mode;
+   extern unsigned char clustered_apic_physical;
+   extern unsigned char esr_disable;
+   extern unsigned char target_cpus;        /* if target_cpus = 0, use cpu_online_map */
+   extern unsigned char int_delivery_mode;  /* if target_cpus = 0, use default of 1   */
+   extern unsigned char int_dest_addr_mode;
+   extern unsigned int apic_broadcast_id;
+#  endif /* !__ASSEMBLY__ */
+#  define TARGET_CPUS (target_cpus ? target_cpus : cpu_online_map)
+#  define INT_DEST_ADDR_MODE (int_dest_addr_mode)
+#  define INT_DELIVERY_MODE  (int_delivery_mode)
 # else
-#  define TARGET_CPUS cpu_online_map
-#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
-# endif
-#else
-# define INT_DELIVERY_MODE 1     /* logical delivery */
-# define TARGET_CPUS 0x01
-#endif
-
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
-  #define esr_disable (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
-  #define esr_disable (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif 
+#  define clustered_apic_mode	(0)
+#  define clustered_apic_physical (0)
+#  define apic_broadcast_id	(APIC_BROADCAST_ID_APIC)
+#  define esr_disable (0)
+#  define TARGET_CPUS 0x01
+#  define INT_DEST_ADDR_MODE 1     /* logical delivery */
+#  define INT_DELIVERY_MODE  (dest_LowestPrio)
+# endif /* CONFIG_SMP */
+#endif /* TARGET_CPUS */
 
 #ifdef CONFIG_SMP
 #ifndef __ASSEMBLY__
@@ -53,10 +60,12 @@
  */
  
 extern void smp_alloc_memory(void);
+extern unsigned long logical_cpu_present_map;
 extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
+
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
@@ -109,7 +118,7 @@
 	return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
 }
 
-static __inline int logical_smp_processor_id(void)
+extern __inline int logical_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
diff -ru linux-2.4.16/include/asm-i386/smpboot.h jamesc-2.4.16/include/asm-i386/smpboot.h
--- linux-2.4.16/include/asm-i386/smpboot.h	Thu Nov 22 11:48:46 2001
+++ jamesc-2.4.16/include/asm-i386/smpboot.h	Mon Dec  3 22:18:47 2001
@@ -1,36 +1,57 @@
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
+#define TRAMPOLINE_LOW phys_to_virt(clustered_apic_logical?0x8:0x467)
+#define TRAMPOLINE_HIGH phys_to_virt(clustered_apic_logical?0xa:0x469)
+
+#define boot_cpu_apicid (clustered_apic_logical?boot_cpu_logical_apicid:boot_cpu_physical_apicid)
 
 /*
- * How to map from the cpu_present_map
+ * To build the logical APIC ID for each CPU we have three cases:
+ *  1) Normal flat mode:  use a bitmap of the CPU numbers
+ *  2) Logical multi-quad (NUMA-Q):  do nothing, the BIOS has set it up
+ *  3) Physical multi-quad (xAPIC clusters):  convert the Intel standard
+ *	physical APIC ID to a cluster nibble/cpu bitmap nibble
  */
-#ifdef CONFIG_MULTIQUAD
- #define cpu_present_to_apicid(mps_cpu) ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) )
-#else /* !CONFIG_MULTIQUAD */
- #define cpu_present_to_apicid(apicid) (apicid)
-#endif /* CONFIG_MULTIQUAD */
+#ifdef CONFIG_SMP
+/***	mps_cpu (index number):   0,  1,  2,  3,  4,  5,  6,  7,  8,  9, ... */
+/***  CPUs have xAPIC phys IDs:  00, 01, 02, 03, 10, 11, 12, 13, 20, 21, ... */
+/***		its logical ID:  01, 02, 04, 08, 11, 12, 14, 18, 21, 22, ... */
+#define physical_to_logical_apicid(phys_apic) ( (1UL << (phys_apic & 0x3)) | (phys_apic & 0xF0U) )
+
+static inline unsigned long apic_ldr_value(unsigned long value)
+{
+	if (clustered_apic_logical)
+		return (value);
+	if (clustered_apic_physical)
+		return (((value) & ~APIC_LDR_MASK) |
+			SET_APIC_LOGICAL_ID(physical_to_logical_apicid(hard_smp_processor_id())));
+	return (((value) & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(1UL << smp_processor_id()));
+}
+#else
+ #define apic_ldr_value(value)	(((value) & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(1UL << smp_processor_id()))
+#endif /* CONFIG_SMP */
+
+/*
+ * How to map from phys_cpu_present_map.
+ *  1) Normal flat mode:  use the mps_cpu, apicid bitmap
+ *  2) Multi-Quad:  only 4 CPUs per cluster, cluster ID in high nibble
+ *	use 
+ */
+#ifdef CONFIG_SMP
+#define cpu_present_to_apicid(mps_cpu)	(clustered_apic_logical ? \
+ 	( ((mps_cpu / 4) * 16) + (1 << (mps_cpu % 4)) ) : \
+	 (clustered_apic_physical ? raw_phys_apicid[mps_cpu] : (mps_cpu) ) )
+extern unsigned char raw_phys_apicid[NR_CPUS];
+#define apicid_to_phys_cpu_present(apicid)	(1UL << (((apicid >> 4) << 2) + (apicid & 0x3)) )
+#else /* CONFIG_SMP */
+#define cpu_present_to_apicid(mps_cpu)	(mps_cpu)
+#define apicid_to_phys_cpu_present(apicid)	(apicid)
+#endif /* CONFIG_SMP */
 
 /*
  * Mappings between logical cpu number and logical / physical apicid
@@ -45,18 +66,8 @@
 #define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
 #define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
 #define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
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
+#define boot_apicid_to_cpu(apicid) (clustered_apic_logical ? logical_apicid_2_cpu[apicid] : physical_apicid_2_cpu[apicid])
+#define cpu_to_boot_apicid(cpu) (clustered_apic_logical ? cpu_2_logical_apicid[cpu] : cpu_2_physical_apicid[cpu])
 
 
 #endif

--------------Boundary-00=_6UNWBLEIBOKGGDXX8HET--
