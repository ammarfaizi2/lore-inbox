Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbTAUDDi>; Mon, 20 Jan 2003 22:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTAUDDi>; Mon, 20 Jan 2003 22:03:38 -0500
Received: from 216-99-218-29.dsl.aracnet.com ([216.99.218.29]:41397 "EHLO
	dexter.groveronline.com") by vger.kernel.org with ESMTP
	id <S266809AbTAUDDT>; Mon, 20 Jan 2003 22:03:19 -0500
Date: Mon, 20 Jan 2003 19:12:20 -0800 (PST)
From: Andy Grover <agrover@groveronline.com>
To: linux-kernel@vger.kernel.org
cc: acpi-devel@sourceforge.net, <mbligh@us.ibm.com>, <mingo@redhat.com>
Subject: [PATCH] SMP parsing rewrite, phase 1
Message-ID: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The below patch against 2.5.59 is also available from 
ftp://ftp.kernel.org/pub/linux/kernel/people/grover/ ,
or bk pull http://linux-acpi.bkbits.net/linux-smp-init .

Before I spent any more time carving up mpparse.c, I just wanted to have
the chance for feedback from others.

This patch begins to draw a distinction between the structure of the MPS
table's items, and the kernel's internal data structures. Previously, it
made sense to just use MPS format throughout, but with the introduction of
a second method to enumerate CPUs, IOAPICs etc. on x86 (i.e. ACPI), this
really is no longer ideal. A clean, minimal interface for ACPI and MPS to 
report discovered resources will cut down on cross-module dependencies, 
shared global arrays, and will probably even reduce the kernel image 
somewhat.

See below for more detail, but to sum up, I:
1) Renamed MPS-specific structs starting with "mpc_" to "mps_", to reflect 
their actual purpose.
2) Do the same thing for variables.
3) Created arch/i386/kernel/smpenum.c, for the enum-method-neutral APIs. 
To begin with, I have only implemented the new interface to replace 
MP_processor_info - the others will be done in a similar manner.
4) An unrelated ACPI init changeset sneaked in, sorry :)

It's been tested on my machine in ACPI and MPS mode - obviously some more 
testing coverage would be nice.

Comments?

Thanks -- Regards -- Andy

The following files are affected:

 arch/i386/kernel/Makefile                    |    2 
 arch/i386/kernel/acpi.c                      |    9 
 arch/i386/kernel/apic.c                      |   12 
 arch/i386/kernel/mpparse.c                   |  274 +++------------
 arch/i386/kernel/setup.c                     |   20 -
 arch/i386/kernel/smpboot.c                   |    4 
 arch/i386/kernel/smpenum.c                   |  124 +++++-
 drivers/acpi/tables.c                        |    3 
 include/asm-i386/io_apic.h                   |    4 
 include/asm-i386/mach-default/mach_apic.h    |   11 
 include/asm-i386/mach-default/mach_mpparse.h |    8 
 include/asm-i386/mach-numaq/mach_apic.h      |    4 
 include/asm-i386/mach-numaq/mach_mpparse.h   |    8 
 include/asm-i386/mach-summit/mach_apic.h     |    4 
 include/asm-i386/mach-summit/mach_mpparse.h  |    8 
 include/asm-i386/mpspec.h                    |   20 -
 include/asm-i386/smp.h                       |    1 
 include/asm-i386/smpenum.h                   |  220 +++++++++++-
 include/linux/acpi.h                         |    4 
 19 files changed, 440 insertions(+), 300 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (03/01/15 1.914.1.28)
   [smpenum] Fixes for numaq and summit

<agrover@groveronline.com> (03/01/15 1.879.92.5)
   [smpenum] Replace MP_processor_info with a non-MPS-specific equivalent
   
   Remove now-obsolete MP_processor_info function from mpparse.c
   Rename mps_read_mpc -> mps_parse_table
   Remove unneeded includes in smpenum.c
   Bring over more variables from mpparse.c
   Implement smp_processor_register(). This function takes the place of
     MP_processor_info, but does not use MPS data structures.
   Change mpc_apic_id's printk to account for the removal of
     nonessential items from struct mpc_config_processor.
   Add include of smpenum.h in smp.h
   Remove nonessential fields from mpc_config_processor

<agrover@groveronline.com> (03/01/14 1.879.92.4)
   [smpenum] structs beginning with "mpc_" are actually MPS-specific. 
Rename
   structs to "mps_" to facilitate the creation of different "mpc_" struct
   definitions.
   
   Create smpenum.[ch], where all the enumeration-method-neutral code will 
go, and start moving some arrays there, for now.

<agrover@groveronline.com> (03/01/14 1.879.92.3)
   [mpparse] more smp -> mps renames

<agrover@groveronline.com> (03/01/14 1.879.92.2)
   [mpparse] Rename smp* things in mpparse.c that are actually 
MPS-specific (not SMP-specific) to mps*, including get_mps_config and 
found_mps_config.

<agrover@groveronline.com> (03/01/14 1.838.62.2)
   [mpparse] "smp" should only be used in non-ACPI or non-MPS-specific
code.  so, start to make that distinction clear

<agrover@groveronline.com> (02/12/17 1.838.62.1)
   ACPI: Boot functions don't use cmdline, so don't pass it




diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	2003-01-20 11:04:44.000000000 -0800
+++ b/arch/i386/kernel/acpi.c	2003-01-20 11:12:00.000000000 -0800
@@ -34,7 +34,7 @@
 #include <linux/bootmem.h>
 #include <linux/irq.h>
 #include <linux/acpi.h>
-#include <asm/mpspec.h>
+#include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/apic.h>
 #include <asm/apicdef.h>
@@ -303,8 +303,7 @@
 
 
 int __init
-acpi_boot_init (
-	char			*cmdline)
+acpi_boot_init (void)
 {
 	int			result = 0;
 
@@ -317,7 +316,7 @@
 	/* 
 	 * Initialize the ACPI boot-time table parser.
 	 */
-	result = acpi_table_init(cmdline);
+	result = acpi_table_init();
 	if (result)
 		return result;
 
@@ -435,7 +434,7 @@
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (acpi_lapic && acpi_ioapic) {
-		smp_found_config = 1;
+		mps_found_config = 1;
 		clustered_apic_check();
 	}
 #endif
diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2003-01-20 11:05:11.000000000 -0800
+++ b/arch/i386/kernel/apic.c	2003-01-20 11:12:56.000000000 -0800
@@ -258,7 +258,7 @@
 	 * Don't do the setup now if we have a SMP BIOS as the
 	 * through-I/O-APIC virtual wire mode might be active.
 	 */
-	if (smp_found_config || !cpu_has_apic)
+	if (mps_found_config || !cpu_has_apic)
 		return;
 
 	value = apic_read(APIC_LVR);
@@ -677,7 +677,7 @@
 	 * zeroes page to simulate the local APIC and another
 	 * one for the IO-APIC.
 	 */
-	if (!smp_found_config && detect_init_APIC()) {
+	if (!mps_found_config && detect_init_APIC()) {
 		apic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
 		apic_phys = __pa(apic_phys);
 	} else
@@ -699,12 +699,12 @@
 		int i;
 
 		for (i = 0; i < nr_ioapics; i++) {
-			if (smp_found_config) {
+			if (mps_found_config) {
 				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
 				if (!ioapic_phys) {
 					printk(KERN_ERR "WARNING: bogus zero IO-APIC address found in MPTABLE, disabling IO/APIC support!\n");
 
-					smp_found_config = 0;
+					mps_found_config = 0;
 					skip_ioapic_setup = 1;
 					goto fake_ioapic_page;
 				}
@@ -1122,7 +1122,7 @@
  */
 int __init APIC_init_uniprocessor (void)
 {
-	if (!smp_found_config && !cpu_has_apic)
+	if (!mps_found_config && !cpu_has_apic)
 		return -1;
 
 	/*
@@ -1148,7 +1148,7 @@
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		check_nmi_watchdog();
 #ifdef CONFIG_X86_IO_APIC
-	if (smp_found_config)
+	if (mps_found_config)
 		if (!skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
 #endif
diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2003-01-20 11:02:41.000000000 -0800
+++ b/arch/i386/kernel/Makefile	2003-01-20 11:10:25.000000000 -0800
@@ -20,7 +20,7 @@
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
-obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o
+obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o smpenum.o
 obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	2003-01-20 11:03:00.000000000 -0800
+++ b/arch/i386/kernel/mpparse.c	2003-01-20 11:10:29.000000000 -0800
@@ -28,6 +28,7 @@
 #include <asm/acpi.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
+#include <asm/smpenum.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 
@@ -35,13 +36,12 @@
 #include <mach_mpparse.h>
 
 /* Have we found an MP table */
-int smp_found_config;
+int mps_found_config;
 
 /*
  * Various Linux-internal data structures created from the
  * MP-table.
  */
-int apic_version [MAX_APICS];
 int mp_bus_id_to_type [MAX_MP_BUSSES];
 int mp_bus_id_to_node [MAX_MP_BUSSES];
 int mp_bus_id_to_local [MAX_MP_BUSSES];
@@ -49,36 +49,12 @@
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_current_pci_id;
 
-/* I/O APIC entries */
-struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
-
-/* # of MP IRQ source entries */
-struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
-
 /* MP IRQ source entries */
 int mp_irq_entries;
 
 int nr_ioapics;
 
 int pic_mode;
-unsigned long mp_lapic_addr;
-
-/* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid = -1U;
-unsigned int boot_cpu_logical_apicid = -1U;
-/* Internal processor count */
-static unsigned int __initdata num_processors;
-
-/* Bitmask of physically existing CPUs */
-unsigned long phys_cpu_present_map;
-
-int x86_summit = 0;
-u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
-
-/*
- * Intel MP BIOS table parsing routines:
- */
-
 
 /*
  * Checksum an MP configuration block.
@@ -94,116 +70,24 @@
 	return sum & 0xFF;
 }
 
-/*
- * Have to match translation table entries to main table entries by counter
- * hence the mpc_record variable .... can't see a less disgusting way of
- * doing this ....
- */
-
-static int mpc_record; 
-static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY] __initdata;
-
-void __init MP_processor_info (struct mpc_config_processor *m)
-{
- 	int ver, apicid;
- 	
-	if (!(m->mpc_cpuflag & CPU_ENABLED))
-		return;
-
-	apicid = mpc_apic_id(m, translation_table[mpc_record]->trans_quad);
-
-	if (m->mpc_featureflag&(1<<0))
-		Dprintk("    Floating point unit present.\n");
-	if (m->mpc_featureflag&(1<<7))
-		Dprintk("    Machine Exception supported.\n");
-	if (m->mpc_featureflag&(1<<8))
-		Dprintk("    64 bit compare & exchange supported.\n");
-	if (m->mpc_featureflag&(1<<9))
-		Dprintk("    Internal APIC present.\n");
-	if (m->mpc_featureflag&(1<<11))
-		Dprintk("    SEP present.\n");
-	if (m->mpc_featureflag&(1<<12))
-		Dprintk("    MTRR  present.\n");
-	if (m->mpc_featureflag&(1<<13))
-		Dprintk("    PGE  present.\n");
-	if (m->mpc_featureflag&(1<<14))
-		Dprintk("    MCA  present.\n");
-	if (m->mpc_featureflag&(1<<15))
-		Dprintk("    CMOV  present.\n");
-	if (m->mpc_featureflag&(1<<16))
-		Dprintk("    PAT  present.\n");
-	if (m->mpc_featureflag&(1<<17))
-		Dprintk("    PSE  present.\n");
-	if (m->mpc_featureflag&(1<<18))
-		Dprintk("    PSN  present.\n");
-	if (m->mpc_featureflag&(1<<19))
-		Dprintk("    Cache Line Flush Instruction present.\n");
-	/* 20 Reserved */
-	if (m->mpc_featureflag&(1<<21))
-		Dprintk("    Debug Trace and EMON Store present.\n");
-	if (m->mpc_featureflag&(1<<22))
-		Dprintk("    ACPI Thermal Throttle Registers  present.\n");
-	if (m->mpc_featureflag&(1<<23))
-		Dprintk("    MMX  present.\n");
-	if (m->mpc_featureflag&(1<<24))
-		Dprintk("    FXSR  present.\n");
-	if (m->mpc_featureflag&(1<<25))
-		Dprintk("    XMM  present.\n");
-	if (m->mpc_featureflag&(1<<26))
-		Dprintk("    Willamette New Instructions  present.\n");
-	if (m->mpc_featureflag&(1<<27))
-		Dprintk("    Self Snoop  present.\n");
-	if (m->mpc_featureflag&(1<<28))
-		Dprintk("    HT  present.\n");
-	if (m->mpc_featureflag&(1<<29))
-		Dprintk("    Thermal Monitor present.\n");
-	/* 30, 31 Reserved */
-
-
-	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
-		Dprintk("    Bootup CPU\n");
-		boot_cpu_physical_apicid = m->mpc_apicid;
-		boot_cpu_logical_apicid = apicid;
-	}
-
-	num_processors++;
-
-	if (m->mpc_apicid > MAX_APICS) {
-		printk("Processor #%d INVALID. (Max ID: %d).\n",
-			m->mpc_apicid, MAX_APICS);
-		--num_processors;
-		return;
-	}
-	ver = m->mpc_apicver;
-
-	phys_cpu_present_map |= apicid_to_cpu_present(apicid);
-	
-	/*
-	 * Validate version
-	 */
-	if (ver == 0x0) {
-		printk("BIOS bug, APIC version is 0 for CPU#%d! fixing up to 0x10. (tell your hw vendor)\n", m->mpc_apicid);
-		ver = 0x10;
-	}
-	apic_version[m->mpc_apicid] = ver;
-	bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;
-}
+extern int mps_record;
+extern struct mps_config_translation *translation_table[MAX_MPC_ENTRY];
 
-static void __init MP_bus_info (struct mpc_config_bus *m)
+static void __init MP_bus_info (struct mps_config_bus *m)
 {
 	char str[7];
 
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
 
-	mpc_oem_bus_info(m, str, translation_table[mpc_record]);
+	mpc_oem_bus_info(m, str, translation_table[mps_record]);
 
 	if (strncmp(str, BUSTYPE_ISA, sizeof(BUSTYPE_ISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
 	} else if (strncmp(str, BUSTYPE_EISA, sizeof(BUSTYPE_EISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_EISA;
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI)-1) == 0) {
-		mpc_oem_pci_bus(m, translation_table[mpc_record]);
+		mpc_oem_pci_bus(m, translation_table[mps_record]);
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_PCI;
 		mp_bus_id_to_pci_bus[m->mpc_busid] = mp_current_pci_id;
 		mp_current_pci_id++;
@@ -214,7 +98,7 @@
 	}
 }
 
-static void __init MP_ioapic_info (struct mpc_config_ioapic *m)
+static void __init MP_ioapic_info (struct mps_config_ioapic *m)
 {
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;
@@ -235,7 +119,7 @@
 	nr_ioapics++;
 }
 
-static void __init MP_intsrc_info (struct mpc_config_intsrc *m)
+static void __init MP_intsrc_info (struct mps_config_intsrc *m)
 {
 	mp_irqs [mp_irq_entries] = *m;
 	Dprintk("Int: type %d, pol %d, trig %d, bus %d,"
@@ -247,7 +131,7 @@
 		panic("Max # of irq sources exceeded!!\n");
 }
 
-static void __init MP_lintsrc_info (struct mpc_config_lintsrc *m)
+static void __init MP_lintsrc_info (struct mps_config_lintsrc *m)
 {
 	Dprintk("Lint: type %d, pol %d, trig %d, bus %d,"
 		" IRQ %02x, APIC ID %x, APIC LINT %02x\n",
@@ -270,14 +154,14 @@
 }
 
 #ifdef CONFIG_X86_NUMAQ
-static void __init MP_translation_info (struct mpc_config_translation *m)
+static void __init MP_translation_info (struct mps_config_translation *m)
 {
-	printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
+	printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mps_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
 
-	if (mpc_record >= MAX_MPC_ENTRY) 
+	if (mps_record >= MAX_MPC_ENTRY) 
 		printk("MAX_MPC_ENTRY exceeded!\n");
 	else
-		translation_table[mpc_record] = m; /* stash this for later */
+		translation_table[mps_record] = m; /* stash this for later */
 	if (m->trans_quad+1 > numnodes)
 		numnodes = m->trans_quad+1;
 }
@@ -286,13 +170,13 @@
  * Read/parse the MPC oem tables
  */
 
-static void __init smp_read_mpc_oem(struct mp_config_oemtable *oemtable, \
+static void __init mps_read_mpc_oem(struct mp_config_oemtable *oemtable, \
 	unsigned short oemsize)
 {
 	int count = sizeof (*oemtable); /* the header size */
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
 	
-	mpc_record = 0;
+	mps_record = 0;
 	printk("Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
@@ -312,12 +196,12 @@
 		switch (*oemptr) {
 			case MP_TRANSLATION:
 			{
-				struct mpc_config_translation *m=
-					(struct mpc_config_translation *)oemptr;
+				struct mps_config_translation *m=
+					(struct mps_config_translation *)oemptr;
 				MP_translation_info(m);
 				oemptr += sizeof(*m);
 				count += sizeof(*m);
-				++mpc_record;
+				++mps_record;
 				break;
 			}
 			default:
@@ -334,12 +218,13 @@
  * Read/parse the MPC
  */
 
-static int __init smp_read_mpc(struct mp_config_table *mpc)
+static int __init mps_parse_table(struct mp_config_table *mpc)
 {
 	char str[16];
 	char oem[10];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
+	int found_processor = 0;
 
 	if (memcmp(mpc->mpc_signature,MPC_SIGNATURE,4)) {
 		panic("SMP mptable: bad signature [%c%c%c%c]!\n",
@@ -384,24 +269,28 @@
 	/*
 	 *	Now process the configuration blocks.
 	 */
-	mpc_record = 0;
+	mps_record = 0;
 	while (count < mpc->mpc_length) {
 		switch(*mpt) {
 			case MP_PROCESSOR:
 			{
-				struct mpc_config_processor *m=
-					(struct mpc_config_processor *)mpt;
-				/* ACPI may have already provided this data */
-				if (!acpi_lapic)
-					MP_processor_info(m);
+				struct mps_config_processor *m=
+					(struct mps_config_processor *)mpt;
+				struct mpc_config_processor cpu;
+
+				cpu.mpc_apicid = m->mpc_apicid;
+				cpu.mpc_apicver = m->mpc_apicver;
+				smp_processor_register(&cpu);
+				found_processor++;
+
 				mpt += sizeof(*m);
 				count += sizeof(*m);
 				break;
 			}
 			case MP_BUS:
 			{
-				struct mpc_config_bus *m=
-					(struct mpc_config_bus *)mpt;
+				struct mps_config_bus *m=
+					(struct mps_config_bus *)mpt;
 				MP_bus_info(m);
 				mpt += sizeof(*m);
 				count += sizeof(*m);
@@ -409,8 +298,8 @@
 			}
 			case MP_IOAPIC:
 			{
-				struct mpc_config_ioapic *m=
-					(struct mpc_config_ioapic *)mpt;
+				struct mps_config_ioapic *m=
+					(struct mps_config_ioapic *)mpt;
 				MP_ioapic_info(m);
 				mpt+=sizeof(*m);
 				count+=sizeof(*m);
@@ -418,8 +307,8 @@
 			}
 			case MP_INTSRC:
 			{
-				struct mpc_config_intsrc *m=
-					(struct mpc_config_intsrc *)mpt;
+				struct mps_config_intsrc *m=
+					(struct mps_config_intsrc *)mpt;
 
 				MP_intsrc_info(m);
 				mpt+=sizeof(*m);
@@ -428,8 +317,8 @@
 			}
 			case MP_LINTSRC:
 			{
-				struct mpc_config_lintsrc *m=
-					(struct mpc_config_lintsrc *)mpt;
+				struct mps_config_lintsrc *m=
+					(struct mps_config_lintsrc *)mpt;
 				MP_lintsrc_info(m);
 				mpt+=sizeof(*m);
 				count+=sizeof(*m);
@@ -441,12 +330,12 @@
 				break;
 			}
 		}
-		++mpc_record;
+		++mps_record;
 	}
 	clustered_apic_check();
-	if (!num_processors)
+	if (!found_processor)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
-	return num_processors;
+	return found_processor;
 }
 
 static int __init ELCR_trigger(unsigned int irq)
@@ -459,7 +348,7 @@
 
 static void __init construct_default_ioirq_mptable(int mpc_default_type)
 {
-	struct mpc_config_intsrc intsrc;
+	struct mps_config_intsrc intsrc;
 	int i;
 	int ELCR_fallback = 0;
 
@@ -526,9 +415,9 @@
 static inline void __init construct_default_ISA_mptable(int mpc_default_type)
 {
 	struct mpc_config_processor processor;
-	struct mpc_config_bus bus;
-	struct mpc_config_ioapic ioapic;
-	struct mpc_config_lintsrc lintsrc;
+	struct mps_config_bus bus;
+	struct mps_config_ioapic ioapic;
+	struct mps_config_lintsrc lintsrc;
 	int linttypes[2] = { mp_ExtINT, mp_NMI };
 	int i;
 
@@ -540,19 +429,12 @@
 	/*
 	 * 2 CPUs, numbered 0 & 1.
 	 */
-	processor.mpc_type = MP_PROCESSOR;
 	/* Either an integrated APIC or a discrete 82489DX. */
 	processor.mpc_apicver = mpc_default_type > 4 ? 0x10 : 0x01;
-	processor.mpc_cpuflag = CPU_ENABLED;
-	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) |
-				   (boot_cpu_data.x86_model << 4) |
-				   boot_cpu_data.x86_mask;
-	processor.mpc_featureflag = boot_cpu_data.x86_capability[0];
-	processor.mpc_reserved[0] = 0;
-	processor.mpc_reserved[1] = 0;
 	for (i = 0; i < 2; i++) {
 		processor.mpc_apicid = i;
-		MP_processor_info(&processor);
+		processor.mpc_apicver = mpc_default_type > 4 ? 0x10 : 0x01;
+		smp_processor_register(&processor);
 	}
 
 	bus.mpc_type = MP_BUS;
@@ -611,7 +493,7 @@
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init get_smp_config (void)
+void __init get_mps_config (void)
 {
 	struct intel_mp_floating *mpf = mpf_found;
 
@@ -651,8 +533,8 @@
 		 * Read the physical hardware table.  Anything here will
 		 * override the defaults.
 		 */
-		if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
-			smp_found_config = 0;
+		if (!mps_parse_table((void *)mpf->mpf_physptr)) {
+			mps_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
 			return;
@@ -663,7 +545,7 @@
 		 * ISA defaults and hope it will work.
 		 */
 		if (!mp_irq_entries) {
-			struct mpc_config_bus bus;
+			struct mps_config_bus bus;
 
 			printk("BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)\n");
 
@@ -678,13 +560,12 @@
 	} else
 		BUG();
 
-	printk("Processors: %d\n", num_processors);
 	/*
 	 * Only use the first configuration found.
 	 */
 }
 
-static int __init smp_scan_config (unsigned long base, unsigned long length)
+static int __init mps_scan_config (unsigned long base, unsigned long length)
 {
 	unsigned long *bp = phys_to_virt(base);
 	struct intel_mp_floating *mpf;
@@ -701,7 +582,7 @@
 			((mpf->mpf_specification == 1)
 				|| (mpf->mpf_specification == 4)) ) {
 
-			smp_found_config = 1;
+			mps_found_config = 1;
 			printk("found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
@@ -716,7 +597,7 @@
 	return 0;
 }
 
-void __init find_smp_config (void)
+void __init find_mps_config (void)
 {
 	unsigned int address;
 
@@ -728,9 +609,9 @@
 	 * 2) Scan the top 1K of base RAM
 	 * 3) Scan the 64K of bios
 	 */
-	if (smp_scan_config(0x0,0x400) ||
-		smp_scan_config(639*0x400,0x400) ||
-			smp_scan_config(0xF0000,0x10000))
+	if (mps_scan_config(0x0,0x400) ||
+		mps_scan_config(639*0x400,0x400) ||
+			mps_scan_config(0xF0000,0x10000))
 		return;
 	/*
 	 * If it is an SMP machine we should know now, unless the
@@ -751,8 +632,8 @@
 
 	address = *(unsigned short *)phys_to_virt(0x40E);
 	address <<= 4;
-	smp_scan_config(address, 0x400);
-	if (smp_found_config)
+	mps_scan_config(address, 0x400);
+	if (mps_found_config)
 		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
 }
 
@@ -782,7 +663,6 @@
 	u8			enabled)
 {
 	struct mpc_config_processor processor;
-	int			boot_cpu = 0;
 	
 	if (id >= MAX_APICS) {
 		printk(KERN_WARNING "Processor #%d invalid (max %d)\n",
@@ -790,21 +670,9 @@
 		return;
 	}
 
-	if (id == boot_cpu_physical_apicid)
-		boot_cpu = 1;
-
-	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
 	processor.mpc_apicver = 0x10; /* TBD: lapic version */
-	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
-	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
-	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) | 
-		(boot_cpu_data.x86_model << 4) | boot_cpu_data.x86_mask;
-	processor.mpc_featureflag = boot_cpu_data.x86_capability[0];
-	processor.mpc_reserved[0] = 0;
-	processor.mpc_reserved[1] = 0;
-
-	MP_processor_info(&processor);
+	smp_processor_register(&processor);
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -891,7 +759,7 @@
 	u8			trigger, 
 	u32			global_irq)
 {
-	struct mpc_config_intsrc intsrc;
+	struct mps_config_intsrc intsrc;
 	int			i = 0;
 	int			found = 0;
 	int			ioapic = -1;
@@ -950,7 +818,7 @@
 
 void __init mp_config_acpi_legacy_irqs (void)
 {
-	struct mpc_config_intsrc intsrc;
+	struct mps_config_intsrc intsrc;
 	int			i = 0;
 	int			ioapic = -1;
 
diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	2003-01-20 11:03:39.000000000 -0800
+++ b/arch/i386/kernel/setup.c	2003-01-20 11:10:36.000000000 -0800
@@ -762,12 +762,6 @@
 	 */
 	acpi_reserve_bootmem();
 #endif
-#ifdef CONFIG_X86_FIND_SMP_CONFIG
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
-#endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
@@ -895,16 +889,24 @@
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
+
+#ifdef CONFIG_X86_FIND_SMP_CONFIG
+	/*
+	 * Find and reserve possible boot-time SMP configuration:
+	*/
+	find_mps_config();
+#endif
 #ifdef CONFIG_ACPI_BOOT
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
 	if (!acpi_disabled)
-		acpi_boot_init(*cmdline_p);
+		acpi_boot_init();
 #endif
+
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (smp_found_config)
-		get_smp_config();
+	if (mps_found_config)
+		get_mps_config();
 #endif
 
 	register_memory(max_low_pfn);
diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	2003-01-20 11:03:39.000000000 -0800
+++ b/arch/i386/kernel/smpboot.c	2003-01-20 11:10:36.000000000 -0800
@@ -976,7 +976,7 @@
 	 * If we couldnt find an SMP configuration at boot time,
 	 * get out of here now!
 	 */
-	if (!smp_found_config) {
+	if (!mps_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = 1;
@@ -1015,7 +1015,7 @@
 	 * If SMP should be disabled, then really disable it!
 	 */
 	if (!max_cpus) {
-		smp_found_config = 0;
+		mps_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = 1;
diff -Naur -X /root/bin/dontdiff a/arch/i386/kernel/smpenum.c b/arch/i386/kernel/smpenum.c
--- a/arch/i386/kernel/smpenum.c	1969-12-31 16:00:00.000000000 -0800
+++ b/arch/i386/kernel/smpenum.c	2003-01-20 11:11:52.000000000 -0800
@@ -0,0 +1,92 @@
+/*
+ *	Generic SMP enumeration code
+ *
+ *	(c) 2003 Andrew Grover <andrew.grover@intel.com>
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/mpspec.h>
+
+#include <mach_apic.h>
+#include <mach_mpparse.h>
+
+/* ---------- EXPORTED VARS ---------- */
+/*
+ * Various Linux-internal data structures created from the
+ * MP-table.
+ */
+int apic_version [MAX_APICS];
+
+/* Processor that is doing the boot up */
+unsigned int boot_cpu_physical_apicid = -1U;
+
+/* Bitmask of physically existing CPUs */
+unsigned long phys_cpu_present_map;
+
+/* I/O APIC entries */
+struct mps_config_ioapic mp_ioapics[MAX_IO_APICS];
+
+/* # of MP IRQ source entries */
+struct mps_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+
+unsigned long mp_lapic_addr;
+
+/* ---------- STATIC VARS ---------- */
+
+static u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+
+/*
+ * Have to match translation table entries to main table entries by counter
+ * hence the mps_record variable .... can't see a less disgusting way of
+ * doing this ....
+ */
+/* N.B. This is here temporarily until we can come up with a good way to put it in
+   a numa-only .c file - ASG */
+
+int mps_record;
+struct mps_config_translation *translation_table[MAX_MPC_ENTRY] __initdata;
+
+/* -- CODE -- */
+
+void __init smp_processor_register (struct mpc_config_processor *m)
+{
+ 	int ver, apicid;
+	static unsigned int num_processors;
+
+	apicid = mpc_apic_id(m, translation_table[mps_record]->trans_quad);
+ 	
+	/* I don't think this is needed, because apic.c sets
+	   boot_cpu_physical_apicid by reading it */
+	/*if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
+		Dprintk("    Bootup CPU\n");
+		boot_cpu_physical_apicid = m->mpc_apicid;
+	}*/
+
+	num_processors++;
+
+	if (m->mpc_apicid > MAX_APICS) {
+		printk("Processor #%d INVALID. (Max ID: %d).\n",
+			m->mpc_apicid, MAX_APICS);
+		--num_processors;
+		return;
+	}
+	ver = m->mpc_apicver;
+
+	phys_cpu_present_map |= apicid_to_cpu_present(apicid);
+	
+	/*
+	 * Validate version
+	 */
+	if (ver == 0x0) {
+		printk("BIOS bug, APIC version is 0 for CPU#%d! fixing up to 0x10. (tell your hw vendor)\n", m->mpc_apicid);
+		ver = 0x10;
+	}
+	apic_version[m->mpc_apicid] = ver;
+	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
+	Dprintk("Processor %d found, apicid %d\n", num_processors, apicid);
+}
+
diff -Naur -X /root/bin/dontdiff a/drivers/acpi/tables.c b/drivers/acpi/tables.c
--- a/drivers/acpi/tables.c	2003-01-20 11:03:13.000000000 -0800
+++ b/drivers/acpi/tables.c	2003-01-20 11:10:32.000000000 -0800
@@ -509,8 +509,7 @@
 
 
 int __init
-acpi_table_init (
-	char			*cmdline)
+acpi_table_init (void)
 {
 	struct acpi_table_rsdp	*rsdp = NULL;
 	unsigned long		rsdp_phys = 0;
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/io_apic.h b/include/asm-i386/io_apic.h
--- a/include/asm-i386/io_apic.h	2003-01-20 11:04:09.000000000 -0800
+++ b/include/asm-i386/io_apic.h	2003-01-20 11:10:42.000000000 -0800
@@ -95,13 +95,13 @@
  */
 
 /* I/O APIC entries */
-extern struct mpc_config_ioapic mp_ioapics[MAX_IO_APICS];
+extern struct mps_config_ioapic mp_ioapics[MAX_IO_APICS];
 
 /* # of MP IRQ source entries */
 extern int mp_irq_entries;
 
 /* MP IRQ source entries */
-extern struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
+extern struct mps_config_intsrc mp_irqs[MAX_IRQ_SOURCES];
 
 /* non-0 if default (table-less) MP configuration */
 extern int mpc_default_type;
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	2003-01-20 11:05:11.000000000 -0800
+++ b/include/asm-i386/mach-default/mach_apic.h	2003-01-20 11:12:56.000000000 -0800
@@ -81,11 +81,8 @@
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
 {
-	printk("Processor #%d %ld:%ld APIC version %d\n",
-			m->mpc_apicid,
-			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
-			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
-			m->mpc_apicver);
+	printk("Processor #%d APIC version %d\n",
+			m->mpc_apicid, m->mpc_apicver);
 	return (m->mpc_apicid);
 }
 
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mach-default/mach_mpparse.h b/include/asm-i386/mach-default/mach_mpparse.h
--- a/include/asm-i386/mach-default/mach_mpparse.h	2003-01-20 11:04:42.000000000 -0800
+++ b/include/asm-i386/mach-default/mach_mpparse.h	2003-01-20 11:11:56.000000000 -0800
@@ -1,14 +1,14 @@
 #ifndef __ASM_MACH_MPPARSE_H
 #define __ASM_MACH_MPPARSE_H
 
-static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
-				struct mpc_config_translation *translation)
+static inline void mpc_oem_bus_info(struct mps_config_bus *m, char *name, 
+				struct mps_config_translation *translation)
 {
 	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
 }
 
-static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
-				struct mpc_config_translation *translation)
+static inline void mpc_oem_pci_bus(struct mps_config_bus *m, 
+				struct mps_config_translation *translation)
 {
 }
 
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mach-numaq/mach_apic.h b/include/asm-i386/mach-numaq/mach_apic.h
--- a/include/asm-i386/mach-numaq/mach_apic.h	2003-01-20 11:03:27.000000000 -0800
+++ b/include/asm-i386/mach-numaq/mach_apic.h	2003-01-20 11:10:34.000000000 -0800
@@ -77,10 +77,8 @@
 {
 	int logical_apicid = generate_logical_apicid(quad, m->mpc_apicid);
 
-	printk("Processor #%d %ld:%ld APIC version %d (quad %d, apic %d)\n",
+	printk("Processor #%d APIC version %d (quad %d, apic %d)\n",
 			m->mpc_apicid,
-			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
-			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
 			m->mpc_apicver, quad, logical_apicid);
 	return logical_apicid;
 }
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mach-numaq/mach_mpparse.h b/include/asm-i386/mach-numaq/mach_mpparse.h
--- a/include/asm-i386/mach-numaq/mach_mpparse.h	2003-01-20 11:03:03.000000000 -0800
+++ b/include/asm-i386/mach-numaq/mach_mpparse.h	2003-01-20 11:10:30.000000000 -0800
@@ -4,8 +4,8 @@
 static void __init smp_read_mpc_oem(struct mp_config_oemtable *oemtable,
 		        unsigned short oemsize);
 
-static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
-				struct mpc_config_translation *translation)
+static inline void mpc_oem_bus_info(struct mps_config_bus *m, char *name, 
+				struct mps_config_translation *translation)
 {
 	int quad = translation->trans_quad;
 	int local = translation->trans_local;
@@ -15,8 +15,8 @@
 	printk("Bus #%d is %s (node %d)\n", m->mpc_busid, name, quad);
 }
 
-static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
-				struct mpc_config_translation *translation)
+static inline void mpc_oem_pci_bus(struct mps_config_bus *m, 
+				struct mps_config_translation *translation)
 {
 	int quad = translation->trans_quad;
 	int local = translation->trans_local;
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	2003-01-20 11:04:07.000000000 -0800
+++ b/include/asm-i386/mach-summit/mach_apic.h	2003-01-20 11:10:41.000000000 -0800
@@ -92,10 +92,8 @@
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
 {
-	printk("Processor #%d %ld:%ld APIC version %d\n",
+	printk("Processor #%d APIC version %d\n",
 			m->mpc_apicid,
-			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
-			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
 			m->mpc_apicver);
 	return (m->mpc_apicid);
 }
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h	2003-01-20 11:03:28.000000000 -0800
+++ b/include/asm-i386/mach-summit/mach_mpparse.h	2003-01-20 11:10:34.000000000 -0800
@@ -1,14 +1,14 @@
 #ifndef __ASM_MACH_MPPARSE_H
 #define __ASM_MACH_MPPARSE_H
 
-static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
-				struct mpc_config_translation *translation)
+static inline void mpc_oem_bus_info(struct mps_config_bus *m, char *name, 
+				struct mps_config_translation *translation)
 {
 	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
 }
 
-static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
-				struct mpc_config_translation *translation)
+static inline void mpc_oem_pci_bus(struct mps_config_bus *m, 
+				struct mps_config_translation *translation)
 {
 }
 
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	2003-01-20 11:02:04.000000000 -0800
+++ b/include/asm-i386/mpspec.h	2003-01-20 11:10:17.000000000 -0800
@@ -63,7 +63,7 @@
 #define	MP_LINTSRC	4
 #define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node locality */
 
-struct mpc_config_processor
+struct mps_config_processor
 {
 	unsigned char mpc_type;
 	unsigned char mpc_apicid;	/* Local APIC number */
@@ -79,7 +79,7 @@
 	unsigned long mpc_reserved[2];
 };
 
-struct mpc_config_bus
+struct mps_config_bus
 {
 	unsigned char mpc_type;
 	unsigned char mpc_busid;
@@ -107,7 +107,7 @@
 #define BUSTYPE_XPRESS	"XPRESS"
 #define BUSTYPE_NEC98	"NEC98"
 
-struct mpc_config_ioapic
+struct mps_config_ioapic
 {
 	unsigned char mpc_type;
 	unsigned char mpc_apicid;
@@ -117,7 +117,7 @@
 	unsigned long mpc_apicaddr;
 };
 
-struct mpc_config_intsrc
+struct mps_config_intsrc
 {
 	unsigned char mpc_type;
 	unsigned char mpc_irqtype;
@@ -140,7 +140,7 @@
 #define MP_IRQDIR_LOW		3
 
 
-struct mpc_config_lintsrc
+struct mps_config_lintsrc
 {
 	unsigned char mpc_type;
 	unsigned char mpc_irqtype;
@@ -162,7 +162,7 @@
 	char  mpc_oem[8];
 };
 
-struct mpc_config_translation
+struct mps_config_translation
 {
         unsigned char mpc_type;
         unsigned char trans_len;
@@ -207,14 +207,14 @@
 
 extern unsigned int boot_cpu_physical_apicid;
 extern unsigned long phys_cpu_present_map;
-extern int smp_found_config;
-extern void find_smp_config (void);
-extern void get_smp_config (void);
+extern int mps_found_config;
+extern void find_mps_config (void);
+extern void get_mps_config (void);
 extern int nr_ioapics;
 extern int apic_version [MAX_APICS];
 extern int mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_irq_entries;
-extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
+extern struct mps_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
 extern int mpc_default_type;
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 extern int mp_current_pci_id;
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/smpenum.h b/include/asm-i386/smpenum.h
--- a/include/asm-i386/smpenum.h	1969-12-31 16:00:00.000000000 -0800
+++ b/include/asm-i386/smpenum.h	2003-01-20 11:10:40.000000000 -0800
@@ -0,0 +1,182 @@
+#ifndef __ASM_SMPENUM_H
+#define __ASM_SMPENUM_H
+
+/*
+ * Generic structures for modular SMP init
+ */
+
+/* Followed by entries */
+
+#define	MP_PROCESSOR	0
+#define	MP_BUS		1
+#define	MP_IOAPIC	2
+#define	MP_INTSRC	3
+#define	MP_LINTSRC	4
+#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node locality */
+
+struct mpc_config_processor
+{
+	unsigned char mpc_apicid;	/* Local APIC number */
+	unsigned char mpc_apicver;	/* Local APIC version */
+};
+
+void smp_processor_register(struct mpc_config_processor *m);
+
+struct mpc_config_bus
+{
+	unsigned char mpc_type;
+	unsigned char mpc_busid;
+	unsigned char mpc_bustype[6] __attribute((packed));
+};
+
+#if 0
+
+/* List of Bus Type string values, Intel MP Spec. */
+#define BUSTYPE_EISA	"EISA"
+#define BUSTYPE_ISA	"ISA"
+#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */
+#define BUSTYPE_MCA	"MCA"
+#define BUSTYPE_VL	"VL"		/* Local bus */
+#define BUSTYPE_PCI	"PCI"
+#define BUSTYPE_PCMCIA	"PCMCIA"
+#define BUSTYPE_CBUS	"CBUS"
+#define BUSTYPE_CBUSII	"CBUSII"
+#define BUSTYPE_FUTURE	"FUTURE"
+#define BUSTYPE_MBI	"MBI"
+#define BUSTYPE_MBII	"MBII"
+#define BUSTYPE_MPI	"MPI"
+#define BUSTYPE_MPSA	"MPSA"
+#define BUSTYPE_NUBUS	"NUBUS"
+#define BUSTYPE_TC	"TC"
+#define BUSTYPE_VME	"VME"
+#define BUSTYPE_XPRESS	"XPRESS"
+#define BUSTYPE_NEC98	"NEC98"
+
+struct mpc_config_ioapic
+{
+	unsigned char mpc_type;
+	unsigned char mpc_apicid;
+	unsigned char mpc_apicver;
+	unsigned char mpc_flags;
+#define MPC_APIC_USABLE		0x01
+	unsigned long mpc_apicaddr;
+};
+
+struct mpc_config_intsrc
+{
+	unsigned char mpc_type;
+	unsigned char mpc_irqtype;
+	unsigned short mpc_irqflag;
+	unsigned char mpc_srcbus;
+	unsigned char mpc_srcbusirq;
+	unsigned char mpc_dstapic;
+	unsigned char mpc_dstirq;
+};
+
+enum mp_irq_source_types {
+	mp_INT = 0,
+	mp_NMI = 1,
+	mp_SMI = 2,
+	mp_ExtINT = 3
+};
+
+#define MP_IRQDIR_DEFAULT	0
+#define MP_IRQDIR_HIGH		1
+#define MP_IRQDIR_LOW		3
+
+
+struct mpc_config_lintsrc
+{
+	unsigned char mpc_type;
+	unsigned char mpc_irqtype;
+	unsigned short mpc_irqflag;
+	unsigned char mpc_srcbusid;
+	unsigned char mpc_srcbusirq;
+	unsigned char mpc_destapic;	
+#define MP_APIC_ALL	0xFF
+	unsigned char mpc_destapiclint;
+};
+
+struct mp_config_oemtable
+{
+	char oem_signature[4];
+#define MPC_OEM_SIGNATURE "_OEM"
+	unsigned short oem_length;	/* Size of table */
+	char  oem_rev;			/* 0x01 */
+	char  oem_checksum;
+	char  mpc_oem[8];
+};
+
+struct mpc_config_translation
+{
+        unsigned char mpc_type;
+        unsigned char trans_len;
+        unsigned char trans_type;
+        unsigned char trans_quad;
+        unsigned char trans_global;
+        unsigned char trans_local;
+        unsigned short trans_reserved;
+};
+
+/*
+ *	Default configurations
+ *
+ *	1	2 CPU ISA 82489DX
+ *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA chaining
+ *	3	2 CPU EISA 82489DX
+ *	4	2 CPU MCA 82489DX
+ *	5	2 CPU ISA+PCI
+ *	6	2 CPU EISA+PCI
+ *	7	2 CPU MCA+PCI
+ */
+
+#ifdef CONFIG_X86_NUMAQ
+#define MAX_IRQ_SOURCES 512
+#else /* !CONFIG_X86_NUMAQ */
+#define MAX_IRQ_SOURCES 256
+#endif /* CONFIG_X86_NUMAQ */
+
+#define MAX_MP_BUSSES 32
+enum mp_bustype {
+	MP_BUS_ISA = 1,
+	MP_BUS_EISA,
+	MP_BUS_PCI,
+	MP_BUS_MCA,
+	MP_BUS_NEC98
+};
+extern int mp_bus_id_to_type [MAX_MP_BUSSES];
+extern int mp_bus_id_to_node [MAX_MP_BUSSES];
+extern int mp_bus_id_to_local [MAX_MP_BUSSES];
+extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
+extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
+
+extern unsigned int boot_cpu_physical_apicid;
+extern unsigned long phys_cpu_present_map;
+extern int mps_found_config;
+extern void find_mps_config (void);
+extern void get_mps_config (void);
+extern int nr_ioapics;
+extern int apic_version [MAX_APICS];
+extern int mp_bus_id_to_type [MAX_MP_BUSSES];
+extern int mp_irq_entries;
+extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
+extern int mpc_default_type;
+extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
+extern int mp_current_pci_id;
+extern unsigned long mp_lapic_addr;
+extern int pic_mode;
+extern int using_apic_timer;
+
+#ifdef CONFIG_ACPI_BOOT
+extern void mp_register_lapic (u8 id, u8 enabled);
+extern void mp_register_lapic_address (u64 address);
+extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
+extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
+extern void mp_config_acpi_legacy_irqs (void);
+extern void mp_config_ioapic_for_sci(int irq);
+extern void mp_parse_prt (void);
+#endif /*CONFIG_ACPI_BOOT*/
+
+#endif
+
+#endif /* if 0 */
diff -Naur -X /root/bin/dontdiff a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	2003-01-20 11:03:56.000000000 -0800
+++ b/include/asm-i386/smp.h	2003-01-20 11:10:39.000000000 -0800
@@ -15,6 +15,7 @@
 #include <asm/fixmap.h>
 #include <asm/bitops.h>
 #include <asm/mpspec.h>
+#include <asm/smpenum.h>
 #ifdef CONFIG_X86_IO_APIC
 #include <asm/io_apic.h>
 #endif
diff -Naur -X /root/bin/dontdiff a/include/linux/acpi.h b/include/linux/acpi.h
--- a/include/linux/acpi.h	2003-01-20 11:02:04.000000000 -0800
+++ b/include/linux/acpi.h	2003-01-20 11:10:17.000000000 -0800
@@ -351,10 +351,10 @@
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
-int acpi_boot_init (char *cmdline);
+int acpi_boot_init (void);
 int acpi_numa_init (void);
 
-int acpi_table_init (char *cmdline);
+int acpi_table_init (void);
 int acpi_table_parse (enum acpi_table_id id, acpi_table_handler handler);
 int acpi_get_table_header_early (enum acpi_table_id id, struct acpi_table_header **header);
 int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_handler handler);

