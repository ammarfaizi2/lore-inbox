Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284204AbRL2QQj>; Sat, 29 Dec 2001 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284240AbRL2QQa>; Sat, 29 Dec 2001 11:16:30 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:62851 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S284204AbRL2QQO>;
	Sat, 29 Dec 2001 11:16:14 -0500
Date: Sat, 29 Dec 2001 17:16:13 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200112291616.RAA10507@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] x86 DMI scan and UP_APIC fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 UP_APIC code breaks on some machines due to BIOS bugs,
in particular on all recent Dell Inspiron and Latitude laptops.
This is something the DMI scan could fix, but unfortunately
the boot order is such that the DMI scan occurs long after much
of the core hardware has been detected and initialised.

Moving DMI scan to setup_arch(), where it really belongs, would
solve this. The problem is that the DMI scan relies on ioremap()
and kmalloc(), and they don't work at that early point in the boot.

The patch below (against 2.4.17) contains a proposed fix:
- dmi_scan_machine() is called from setup_arch() instead of being
  a module_init() thing
- DMI scan now uses the new "bt_ioremap()": a restricted version of
  ioremap() which works early in the boot process. bt_ioremap() is
  implemented on top of the FIXMAP mechanism, which has been extended
  to permit temporary boot-time mappings
- dmi_scan.c and apic.c are augmented with workarounds for known
  broken machines: currently Dell laptops and Intel's AL440LX
- init_apic_mappings() is called from trap_init() instead of
  setup_arch(), i.e. after dmi_scan_machine() is done

I've been running this on several machines for the last 2 months,
and it does seem to work as intended with no observed breakage.

Is having a boot-time clone of ioremap() a reasonable approach,
or is there an easier solution I've overlooked?

Comments?

/Mikael

--- linux-2.4.17-init-order/arch/i386/kernel/apic.c.~1~	Fri Nov 23 22:40:14 2001
+++ linux-2.4.17-init-order/arch/i386/kernel/apic.c	Sun Dec 23 18:51:40 2001
@@ -571,12 +571,17 @@
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
+int dont_enable_local_apic __initdata = 0;
 
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
+	/* Disabled by DMI scan or kernel option? */
+	if (dont_enable_local_apic)
+		return -1;
+
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
 
@@ -894,8 +899,14 @@
 
 static unsigned int calibration_result;
 
+int dont_use_local_apic_timer __initdata = 0;
+
 void __init setup_APIC_clocks (void)
 {
+	/* Disabled by DMI scan or kernel option? */
+	if (dont_use_local_apic_timer)
+		return;
+
 	printk("Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
--- linux-2.4.17-init-order/arch/i386/kernel/dmi_scan.c.~1~	Fri Dec 21 23:19:54 2001
+++ linux-2.4.17-init-order/arch/i386/kernel/dmi_scan.c	Mon Dec 24 11:38:21 2001
@@ -9,6 +9,7 @@
 #include <linux/pm.h>
 #include <asm/keyboard.h>
 #include <asm/system.h>
+#include <linux/bootmem.h>
 
 unsigned long dmi_broken;
 int is_sony_vaio_laptop;
@@ -51,7 +52,7 @@
 	u8 *data;
 	int i=1;
 		
-	buf = ioremap(base, len);
+	buf = bt_ioremap(base, len);
 	if(buf==NULL)
 		return -1;
 
@@ -83,7 +84,7 @@
 		data+=2;
 		i++;
 	}
-	iounmap(buf);
+	bt_iounmap(buf, len);
 	return 0;
 }
 
@@ -155,7 +156,7 @@
 		return;
 	if (dmi_ident[slot])
 		return;
-	dmi_ident[slot] = kmalloc(strlen(p)+1, GFP_KERNEL);
+	dmi_ident[slot] = alloc_bootmem(strlen(p)+1);
 	if(dmi_ident[slot])
 		strcpy(dmi_ident[slot], p);
 	else
@@ -414,6 +415,43 @@
 	return 0;
 }
 
+/*
+ * Some machines, usually laptops, can't handle an enabled local APIC.
+ * The symptoms include hangs or reboots when suspending or resuming,
+ * attaching or detaching the power cord, or entering BIOS setup screens
+ * through magic key sequences.
+ */
+static int __init local_apic_kills_bios(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	extern int dont_enable_local_apic;
+	if (!dont_enable_local_apic) {
+		dont_enable_local_apic = 1;
+		printk(KERN_WARNING "%s with broken BIOS detected. "
+		       "Refusing to enable the local APIC.\n",
+		       d->ident);
+	}
+#endif
+	return 0;
+}
+
+/*
+ * The Intel AL440LX mainboard will hang randomly if the local APIC
+ * timer is running and the APM BIOS hasn't been disabled.
+ */
+static int __init apm_kills_local_apic_timer(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	extern int dont_use_local_apic_timer;
+	if (apm_info.bios.version && !dont_use_local_apic_timer) {
+		dont_use_local_apic_timer = 1;
+		printk(KERN_WARNING "%s with broken BIOS detected. "
+		       "The local APIC timer will not be used.\n",
+		       d->ident);
+	}
+#endif
+	return 0;
+}
 
 /*
  *	Simple "print if true" callback
@@ -558,6 +596,25 @@
 			MATCH(DMI_BIOS_DATE, "09/12/00"), NO_MATCH
 			} },
 
+	/* Machines which have problems handling enabled local APICs */
+
+	{ local_apic_kills_bios, "Dell Inspiron", {
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+			NO_MATCH, NO_MATCH
+			} },
+
+	{ local_apic_kills_bios, "Dell Latitude", {
+			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			MATCH(DMI_PRODUCT_NAME, "Latitude"),
+			NO_MATCH, NO_MATCH
+			} },
+
+	{ apm_kills_local_apic_timer, "Intel AL440LX", {
+			MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			MATCH(DMI_BOARD_NAME, "AL440LX"),
+			NO_MATCH, NO_MATCH } },
+
 	/* Problem Intel 440GX bioses */
 
 	{ broken_pirq, "SABR1 Bios", {			/* Bad $PIR */
@@ -726,12 +783,10 @@
 	}
 }
 
-static int __init dmi_scan_machine(void)
+int __init dmi_scan_machine(void)
 {
 	int err = dmi_iterate(dmi_decode);
 	if(err == 0)
 		dmi_check_blacklist();
 	return err;
 }
-
-module_init(dmi_scan_machine);
--- linux-2.4.17-init-order/arch/i386/kernel/setup.c.~1~	Fri Dec 21 23:19:54 2001
+++ linux-2.4.17-init-order/arch/i386/kernel/setup.c	Sun Dec 23 18:51:40 2001
@@ -992,7 +992,6 @@
 	 */
 	if (smp_found_config)
 		get_smp_config();
-	init_apic_mappings();
 #endif
 
 
@@ -1044,6 +1043,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	dmi_scan_machine();
 }
 
 static int cachesize_override __initdata = -1;
--- linux-2.4.17-init-order/arch/i386/kernel/traps.c.~1~	Thu Oct 11 13:34:39 2001
+++ linux-2.4.17-init-order/arch/i386/kernel/traps.c	Sun Dec 23 18:51:40 2001
@@ -920,6 +920,10 @@
 		EISA_bus = 1;
 #endif
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	init_apic_mappings();
+#endif
+
 	set_trap_gate(0,&divide_error);
 	set_trap_gate(1,&debug);
 	set_intr_gate(2,&nmi);
--- linux-2.4.17-init-order/arch/i386/mm/init.c.~1~	Fri Dec 21 23:19:54 2001
+++ linux-2.4.17-init-order/arch/i386/mm/init.c	Sun Dec 23 18:51:40 2001
@@ -128,7 +128,6 @@
 static inline void set_pte_phys (unsigned long vaddr,
 			unsigned long phys, pgprot_t flags)
 {
-	pgprot_t prot;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -144,10 +143,8 @@
 		return;
 	}
 	pte = pte_offset(pmd, vaddr);
-	if (pte_val(*pte))
-		pte_ERROR(*pte);
-	pgprot_val(prot) = pgprot_val(PAGE_KERNEL) | pgprot_val(flags);
-	set_pte(pte, mk_pte_phys(phys, prot));
+	/* <phys,flags> stored as-is, to permit clearing entries */
+	set_pte(pte, mk_pte_phys(phys, flags));
 
 	/*
 	 * It's enough to flush this one mapping.
--- linux-2.4.17-init-order/arch/i386/mm/ioremap.c.~1~	Fri Mar 30 19:05:04 2001
+++ linux-2.4.17-init-order/arch/i386/mm/ioremap.c	Mon Dec 24 11:42:12 2001
@@ -161,3 +161,69 @@
 	if (addr > high_memory)
 		return vfree((void *) (PAGE_MASK & (unsigned long) addr));
 }
+
+#include <asm/fixmap.h>
+void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
+{
+	unsigned long offset, last_addr;
+	unsigned int nrpages;
+	enum fixed_addresses idx;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Don't remap the low PCI/ISA area, it's always mapped..
+	 */
+	if (phys_addr >= 0xA0000 && last_addr < 0x100000)
+		return phys_to_virt(phys_addr);
+
+	/*
+	 * Mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr) - phys_addr;
+
+	/*
+	 * Mappings have to fit in the FIX_BTMAP area.
+	 */
+	nrpages = size >> PAGE_SHIFT;
+	if (nrpages > NR_FIX_BTMAPS)
+		return NULL;
+
+	/*
+	 * Ok, go for it..
+	 */
+	idx = FIX_BTMAP_BEGIN;
+	while (nrpages > 0) {
+		set_fixmap(idx, phys_addr);
+		phys_addr += PAGE_SIZE;
+		--idx;
+		--nrpages;
+	}
+	return (void*) (offset + fix_to_virt(FIX_BTMAP_BEGIN));
+}
+
+void __init bt_iounmap(void *addr, unsigned long size)
+{
+	unsigned long virt_addr;
+	unsigned long offset;
+	unsigned int nrpages;
+	enum fixed_addresses idx;
+
+	virt_addr = (unsigned long)addr;
+	if (virt_addr < fix_to_virt(FIX_BTMAP_BEGIN))
+		return;
+	offset = virt_addr & ~PAGE_MASK;
+	nrpages = PAGE_ALIGN(offset + size - 1) >> PAGE_SHIFT;
+
+	idx = FIX_BTMAP_BEGIN;
+	while (nrpages > 0) {
+		__set_fixmap(idx, 0, __pgprot(0));
+		--idx;
+		--nrpages;
+	}
+}
--- linux-2.4.17-init-order/include/asm-i386/fixmap.h.~1~	Sun Aug 12 11:35:53 2001
+++ linux-2.4.17-init-order/include/asm-i386/fixmap.h	Sun Dec 23 18:51:41 2001
@@ -65,6 +65,11 @@
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+	__end_of_permanent_fixed_addresses,
+	/* temporary boot-time mappings, used before ioremap() is functional */
+#define NR_FIX_BTMAPS	16
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
 	__end_of_fixed_addresses
 };
 
@@ -86,8 +91,8 @@
  * at the top of mem..
  */
 #define FIXADDR_TOP	(0xffffe000UL)
-#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
+#define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 
--- linux-2.4.17-init-order/include/asm-i386/io.h.~1~	Tue Nov  6 12:12:07 2001
+++ linux-2.4.17-init-order/include/asm-i386/io.h	Mon Dec 24 11:36:35 2001
@@ -98,6 +98,14 @@
 extern void iounmap(void *addr);
 
 /*
+ * bt_ioremap() and bt_iounmap() are for temporary early boot-time
+ * mappings, before the real ioremap() is functional.
+ * A boot-time mapping is currently limited to at most 16 pages.
+ */
+extern void *bt_ioremap(unsigned long offset, unsigned long size);
+extern void bt_iounmap(void *addr, unsigned long size);
+
+/*
  * IO bus memory addresses are also 1:1 with the physical address
  */
 #define virt_to_bus virt_to_phys
