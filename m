Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTJCXIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTJCXIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:08:31 -0400
Received: from fmr05.intel.com ([134.134.136.6]:35973 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261368AbTJCXGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:06:55 -0400
Date: Fri, 3 Oct 2003 16:22:56 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200310032322.h93NMuob005957@snoqualmie.dp.intel.com>
To: akpm@osdl.org, ebiederm@xmission.com
Subject: [resend] [updated patch] for efi support in ia32 kernels
Cc: linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, looks like the first mail got munged.  Here's the original mail with the patch inline.... Sorry for the trash.

matt


Attached is another patch that enables EFI boot-up support in ia32 =
kernels.  This one has numerous changes based on the various comments =
and suggestions made on the last one several weeks ago.  The patch is =
against 2.6.0-test6-mm2. =20

This patch departs from the last in that I am no longer adding separate =
boot parameters at the end of the the empty_zero_page; rather, based on =
Eric's suggestion, I've added EFI parameters via offset grouped with the =
rest of the existing boot parameters.  This allows the reuse of several =
parameters which were redundant (command-line, initrd, etc.).  This also =
simplifies some of the code in setup_arch(). =20

In order to continue to determine whether the kernel should initialize =
using EFI tables, I've temporarily added a check on the LOADER_TYPE boot =
parameter.  Although I haven't requested that elilo be assigned an id =
for this yet, I've used this to determine whether the kernel should use =
the EFI initialization path as well as a check to see if the EFI_SYSTAB =
boot parameter contains anything.  If someone has a better suggestion =
for determining this, I'm open...

This patch also uses the existing ioremapping functions to map the efi =
tables into kernel virtual address space.  I've added an option such =
that I could use Dave Hansen's boot_ioremap() before paging_init().  =
After paging_init, I then remap the efi memmap using bt_ioremap for use =
later.  This has eliminated the need for several functions...thanks for =
the suggestions and thanks for your help Dave.  Still this could use a =
look-see. =20

Something else that I'd like to solicit suggestions on is how to deal =
with CONFIG_ACPI_EFI.  One of the goals of this patch is to enable the =
kernel to "just know" at boot time when to use EFI information to =
initialize.  That way, the same kernel image would theoretically still =
boot on existing systems with a different BIOS.  I think this patch =
accomplishes that goal to some degree, but how best to deal with =
when/when not to look at the EFI config table for the RSDP is still =
dealt with at compile time.  I'd like to dynamically determine this as =
well, but am not sure of the best way...suggestions?  Len? Andrew?

Note, I'm still working on verifying this works properly on a system =
with >4GB system memory, as well as with the 4G/4G split (hence the =
reason this is against the -mm kernel)...hopefully, I'll be able to =
steal some time on one of those monsters next week.

Comments and suggestions are welcome...

thanks,
matt


diff -urN linux-2.6.0-test6-mm2/arch/i386/Kconfig linux-2.6.0-test6-mm2-efi/arch/i386/Kconfig
--- linux-2.6.0-test6-mm2/arch/i386/Kconfig	2003-10-03 11:50:44.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/Kconfig	2003-10-03 10:10:40.000000000 -0700
@@ -840,8 +840,9 @@
 # turning this on wastes a bunch of space.
 # Summit needs it only when NUMA is on
 config BOOT_IOREMAP
-	bool
-	depends on ((X86_SUMMIT || X86_GENERICARCH) && NUMA)
+	bool 
+	depends on X86_PC
+# depends on (((X86_SUMMIT || X86_GENERICARCH) && NUMA)) || X86_GENERICARCH
 	default y
 
 endmenu
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/acpi/boot.c linux-2.6.0-test6-mm2-efi/arch/i386/kernel/acpi/boot.c
--- linux-2.6.0-test6-mm2/arch/i386/kernel/acpi/boot.c	2003-10-03 11:50:44.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/acpi/boot.c	2003-10-03 10:10:40.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/config.h>
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -295,7 +296,11 @@
 acpi_find_rsdp (void)
 {
 	unsigned long		rsdp_phys = 0;
-
+	
+	if (efi.acpi20)
+		return __pa(efi.acpi20);
+	else if (efi.acpi)
+		return __pa(efi.acpi);
 	/*
 	 * Scan memory looking for the RSDP signature. First search EBDA (low
 	 * memory) paragraphs and then search upper memory (E0000-FFFFF).
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/efi.c linux-2.6.0-test6-mm2-efi/arch/i386/kernel/efi.c
--- linux-2.6.0-test6-mm2/arch/i386/kernel/efi.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/efi.c	2003-10-03 11:44:45.000000000 -0700
@@ -0,0 +1,606 @@
+/*
+ * Extensible Firmware Interface
+ *
+ * Based on Extensible Firmware Interface Specification version 1.0 
+ *
+ * Copyright (C) 1999 VA Linux Systems
+ * Copyright (C) 1999 Walt Drummond <drummond@valinux.com>
+ * Copyright (C) 1999-2002 Hewlett-Packard Co.
+ *	David Mosberger-Tang <davidm@hpl.hp.com>
+ *	Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * All EFI Runtime Services are not implemented yet as EFI only
+ * supports physical mode addressing on SoftSDV. This is to be fixed
+ * in a future version.  --drummond 1999-07-20
+ *
+ * Implemented EFI runtime services and virtual mode calls.  --davidm
+ *
+ * Goutham Rao: <goutham.rao@intel.com>
+ *	Skip non-WB memory and ignore empty memory ranges.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/spinlock.h>
+#include <linux/bootmem.h>
+#include <linux/ioport.h>
+#include <linux/proc_fs.h>
+#include <linux/efi.h>
+
+#include <asm/setup.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/desc.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+
+#define EFI_DEBUG	0
+#define PFX 		"EFI: "
+
+extern efi_status_t asmlinkage efi_call_phys(void *, ...);
+
+struct efi efi;
+struct efi efi_phys __initdata;
+struct efi_memory_map memmap __initdata;
+
+/* 
+ * We require an early boot_ioremap mapping mechanism initially 
+ */
+extern void * boot_ioremap(unsigned long, unsigned long);
+
+/*
+ * efi_dir is allocated here, but the directory isn't created 
+ * here, as proc_mkdir() doesn't work this early in the bootup
+ * process.  Therefore, each module, like efivars, must test for
+ *    if (!efi_dir) efi_dir = proc_mkdir("efi", NULL);
+ * prior to creating their own entries under /proc/efi.
+ */
+#ifdef CONFIG_PROC_FS
+struct proc_dir_entry *efi_dir;
+#endif
+
+
+/*
+ * To make EFI call EFI runtime service in physical addressing mode we need
+ * prelog/epilog before/after the invocation to disable interrupt, to 
+ * claim EFI runtime service handler exclusively and to duplicate a memory in
+ * low memory space say 0 - 3G.
+ */
+
+static unsigned long efi_rt_eflags;
+static spinlock_t efi_rt_lock = SPIN_LOCK_UNLOCKED;
+static pgd_t efi_bak_pg_dir_pointer[2];
+
+static void efi_call_phys_prelog(void)
+{
+	unsigned long cr4;
+	unsigned long temp;
+
+	spin_lock(&efi_rt_lock);
+	local_irq_save(efi_rt_eflags);
+	
+	/*
+	 * If I don't have PSE, I should just duplicate two entries in page
+	 * directory. If I have PSE, I just need to duplicate one entry in
+	 * page directory.
+	 */
+	__asm__ __volatile__("movl %%cr4, %0":"=r"(cr4));
+
+	if (cr4 & X86_CR4_PSE) {
+		efi_bak_pg_dir_pointer[0].pgd =
+		    swapper_pg_dir[pgd_index(0)].pgd;
+		swapper_pg_dir[0].pgd =
+		    swapper_pg_dir[pgd_index(PAGE_OFFSET)].pgd;
+	} else {
+		efi_bak_pg_dir_pointer[0].pgd =
+		    swapper_pg_dir[pgd_index(0)].pgd;
+		efi_bak_pg_dir_pointer[1].pgd =
+		    swapper_pg_dir[pgd_index(0x400000)].pgd;
+		swapper_pg_dir[pgd_index(0)].pgd =
+		    swapper_pg_dir[pgd_index(PAGE_OFFSET)].pgd;
+		temp = PAGE_OFFSET + 0x400000;
+		swapper_pg_dir[pgd_index(0x400000)].pgd =
+		    swapper_pg_dir[pgd_index(temp)].pgd;
+	}
+
+	/*
+	 * After the lock is released, the original page table is restored.
+	 */
+	local_flush_tlb();
+
+	cpu_gdt_descr[0].address = __pa(cpu_gdt_descr[0].address);
+	__asm__ __volatile__("lgdt %0":"=m"
+			    (*(struct Xgt_desc_struct *) __pa(&cpu_gdt_descr[0])));
+}
+
+static void efi_call_phys_epilog(void)
+{
+	unsigned long cr4;
+
+	cpu_gdt_descr[0].address = 
+		(unsigned long) __va(cpu_gdt_descr[0].address);
+	__asm__ __volatile__("lgdt %0":"=m"(cpu_gdt_descr));
+	__asm__ __volatile__("movl %%cr4, %0":"=r"(cr4));
+
+	if (cr4 & X86_CR4_PSE) {
+		swapper_pg_dir[pgd_index(0)].pgd =
+		    efi_bak_pg_dir_pointer[0].pgd;
+	} else {
+		swapper_pg_dir[pgd_index(0)].pgd =
+		    efi_bak_pg_dir_pointer[0].pgd;
+		swapper_pg_dir[pgd_index(0x400000)].pgd =
+		    efi_bak_pg_dir_pointer[1].pgd;
+	}
+
+	/*
+	 * After the lock is released, the original page table is restored.
+	 */
+	local_flush_tlb();
+
+	local_irq_restore(efi_rt_eflags);
+	spin_unlock(&efi_rt_lock);
+}
+
+static efi_status_t 
+phys_efi_set_virtual_address_map(unsigned long memory_map_size, 
+				 unsigned long descriptor_size,
+				 u32 descriptor_version, 
+				 efi_memory_desc_t *virtual_map)
+{
+	efi_status_t status;
+	
+	efi_call_phys_prelog();
+	status = efi_call_phys(efi_phys.set_virtual_address_map, 
+				     memory_map_size, descriptor_size,
+				     descriptor_version, virtual_map);
+	efi_call_phys_epilog();
+	return status;
+}
+
+efi_status_t 
+phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc)
+{
+	efi_status_t status;
+
+	efi_call_phys_prelog();
+	status = efi_call_phys(efi_phys.get_time, tm, tc);
+	efi_call_phys_epilog();
+	return status; 
+}
+
+void efi_gettimeofday(struct timespec *tv)
+{
+	efi_time_t tm;
+
+	memset(tv, 0, sizeof(*tv));
+	if ((*efi.get_time) (&tm, 0) != EFI_SUCCESS)
+		return;
+
+	tv->tv_sec = mktime(tm.year, tm.month, tm.day, tm.hour, tm.minute,
+		            tm.second);
+	tv->tv_nsec = tm.nanosecond;
+}
+
+int is_available_memory(efi_memory_desc_t * md)
+{
+	if (!(md->attribute & EFI_MEMORY_WB))
+		return 0;
+
+	switch (md->type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+			return 1;
+	}
+	return 0;
+}
+
+/* 
+ * We need to map the EFI memory map again after paging_init().  
+ */
+void __init efi_map_memmap(void)
+{
+	memmap.map = NULL;
+	
+	memmap.map = (efi_memory_desc_t *)
+		bt_ioremap((unsigned long) memmap.phys_map,
+			(memmap.nr_map * sizeof(efi_memory_desc_t)));
+
+	if (memmap.map == NULL)
+		printk(KERN_ERR PFX "Could not remap the EFI memmap!\n");
+}	
+
+void __init print_efi_memmap(void)
+{
+	efi_memory_desc_t *md;
+	int i;
+	
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+		printk(KERN_INFO "mem%02u: type=%u, attr=0x%llx, "
+			"range=[0x%016llx-0x%016llx) (%lluMB)\n",
+			i, md->type, md->attribute, md->phys_addr,
+			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT),
+			(md->num_pages >> (20 - EFI_PAGE_SHIFT)));
+	}
+}
+
+/*
+ * Walks the EFI memory map and calls CALLBACK once for each EFI
+ * memory descriptor that has memory that is available for kernel use.
+ */
+void efi_memmap_walk(efi_freemem_callback_t callback, void *arg)
+{
+	int prev_valid = 0;
+	struct range {
+		unsigned long start;
+		unsigned long end;
+	} prev, curr;
+	efi_memory_desc_t *md;
+	unsigned long start, end;
+	int i;
+
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+
+		if ((md->num_pages == 0) || (!is_available_memory(md)))	
+			continue;
+
+		curr.start = md->phys_addr;
+		curr.end = curr.start + (md->num_pages << EFI_PAGE_SHIFT);
+
+		if (!prev_valid) {
+			prev = curr;
+			prev_valid = 1;
+		} else {
+			if (curr.start < prev.start)
+				printk(KERN_INFO PFX "Unordered memory map\n");
+			if (prev.end == curr.start)
+				prev.end = curr.end;
+			else {
+				start =
+				    (unsigned long) (PAGE_ALIGN(prev.start));
+				end = (unsigned long) (prev.end & PAGE_MASK);
+				if ((end > start)
+				    && (*callback) (start, end, arg) < 0)
+					return;
+				prev = curr;
+			}
+		}
+	}
+	if (prev_valid) {
+		start = (unsigned long) PAGE_ALIGN(prev.start);
+		end = (unsigned long) (prev.end & PAGE_MASK);
+		if (end > start)
+			(*callback) (start, end, arg);
+	}
+}
+
+void __init efi_init(void)
+{
+	efi_config_table_t *config_tables;
+	efi_runtime_services_t *runtime;
+	efi_char16_t *c16;
+	char vendor[100] = "unknown";
+	unsigned long num_config_tables;
+	int i = 0;
+
+	memset(&efi, 0, sizeof(efi) );
+	memset(&efi_phys, 0, sizeof(efi_phys));
+
+	efi_phys.systab = EFI_SYSTAB;
+	memmap.phys_map = EFI_MEMMAP;
+	memmap.nr_map = EFI_MEMMAP_SIZE/EFI_MEMDESC_SIZE;
+	memmap.desc_version = EFI_MEMDESC_VERSION;
+
+	efi.systab = (efi_system_table_t *)
+		boot_ioremap((unsigned long) efi_phys.systab,
+			sizeof(efi_system_table_t));
+	/*
+	 * Verify the EFI Table
+	 */
+	if (efi.systab == NULL) 
+		printk(KERN_ERR PFX "Woah! Couldn't map the EFI system table.\n");
+	if (efi.systab->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
+		printk(KERN_ERR PFX "Woah! EFI system table signature incorrect\n");
+	if ((efi.systab->hdr.revision ^ EFI_SYSTEM_TABLE_REVISION) >> 16 != 0)
+		printk(KERN_ERR PFX
+		       "Warning: EFI system table major version mismatch: "
+		       "got %d.%02d, expected %d.%02d\n",
+		       efi.systab->hdr.revision >> 16,
+		       efi.systab->hdr.revision & 0xffff,
+		       EFI_SYSTEM_TABLE_REVISION >> 16,
+		       EFI_SYSTEM_TABLE_REVISION & 0xffff);
+	/* 
+	 * Grab some details from the system table 
+	 */
+	num_config_tables = efi.systab->nr_tables;
+	config_tables = (efi_config_table_t *)efi.systab->tables;
+	runtime = efi.systab->runtime;
+
+	/* 
+	 * Show what we know for posterity 
+	 */
+	c16 = (efi_char16_t *) boot_ioremap(efi.systab->fw_vendor, 2);
+	if (c16) {
+		for (i = 0; i < sizeof(vendor) && *c16; ++i) 
+			vendor[i] = *c16++;
+		vendor[i] = '\0';
+	} else
+		printk(KERN_ERR PFX "Could not map the firmware vendor!\n");
+
+	printk(KERN_INFO PFX "EFI v%u.%.02u by %s \n",
+	       efi.systab->hdr.revision >> 16,
+	       efi.systab->hdr.revision & 0xffff, vendor);
+
+	/*
+	 * Let's see what config tables the firmware passed to us.
+	 */
+	config_tables = (efi_config_table_t *)
+				boot_ioremap((unsigned long) config_tables,
+			        num_config_tables * sizeof(efi_config_table_t));
+
+	if (config_tables == NULL)
+		printk(KERN_ERR PFX "Could not map EFI Configuration Table!\n");
+
+	for (i = 0; i < num_config_tables; i++) {
+		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
+			efi.mps = (void *)config_tables[i].table;
+			printk(KERN_INFO " MPS=0x%lx ", config_tables[i].table);
+		} else
+		    if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
+			efi.acpi20 = __va(config_tables[i].table);
+			printk(KERN_INFO " ACPI 2.0=0x%lx ", config_tables[i].table);
+		} else
+		    if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
+			efi.acpi = __va(config_tables[i].table);
+			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
+		} else
+		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
+			efi.smbios = (void *) config_tables[i].table;
+			printk(KERN_INFO " SMBIOS=0x%lx ", config_tables[i].table);
+		} else
+		    if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
+			efi.hcdp = (void *)config_tables[i].table;
+			printk(KERN_INFO " HCDP=0x%lx ", config_tables[i].table);
+		} else
+		    if (efi_guidcmp(config_tables[i].guid, UGA_IO_PROTOCOL_GUID) == 0) {
+			efi.uga = (void *)config_tables[i].table;
+			printk(KERN_INFO " UGA=0x%lx ", config_tables[i].table);
+		} 
+	}
+	printk("\n");
+			
+	/*
+	 * Check out the runtime services table. We need to map 
+	 * the runtime services table so that we can grab the physical 
+	 * address of several of the EFI runtime functions, needed to 
+	 * set the firmware into virtual mode.
+	 */
+	    
+	runtime = (efi_runtime_services_t *) boot_ioremap((unsigned long) 
+						runtime,
+				      		sizeof(efi_runtime_services_t));
+	if (runtime != NULL) {
+		/* 
+	 	 * We will only need *early* access to the following 
+		 * two EFI runtime services before set_virtual_address_map 
+		 * is invoked.  
+ 	 	 */
+		efi_phys.get_time = (efi_get_time_t *) runtime->get_time;
+		efi_phys.set_virtual_address_map = 
+			(efi_set_virtual_address_map_t *) 
+				runtime->set_virtual_address_map;
+	} else
+		printk(KERN_ERR PFX "Could not map the runtime service table!\n");
+
+	/* Map the EFI memory map for use until paging_init() */
+
+	memmap.map = (efi_memory_desc_t *) 
+		boot_ioremap((unsigned long) EFI_MEMMAP, EFI_MEMMAP_SIZE);
+	
+	if (memmap.map == NULL)
+		printk(KERN_ERR PFX "Could not map the EFI memory map!\n");
+
+	if (EFI_MEMDESC_SIZE != sizeof(efi_memory_desc_t)) {
+		printk(KERN_WARNING PFX "Warning! Kernel-defined memdesc doesn't "
+			   "match the one from EFI!\n");
+	}
+#if EFI_DEBUG
+	print_efi_memmap();
+#endif
+}
+
+/* 
+ * This function will switch the EFI runtime services to virtual mode.  
+ * Essentially, look through the EFI memmap and map every region that
+ * has the runtime attribute bit set in its memory descriptor and update
+ * that memory descriptor with the virtual address obtained from ioremap().
+ * This enables the runtime services to be called without having to 
+ * thunk back into physical mode for every invocation.  
+ */
+
+void __init efi_enter_virtual_mode(void)
+{
+	efi_memory_desc_t *md;
+	efi_status_t status;
+	int i;
+
+	efi.systab = NULL;
+		
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+		
+		if (md->attribute & EFI_MEMORY_RUNTIME) {
+			md->virt_addr = 
+				(u64) ioremap((unsigned long) md->phys_addr,
+					      (unsigned long) (md->num_pages 
+						<< EFI_PAGE_SHIFT));
+			if (!(unsigned long) md->virt_addr) {
+				printk(KERN_ERR PFX "ioremap of md: 0x%lX failed \n", 
+					(unsigned long) md->phys_addr);
+			}
+
+			if (((unsigned long)md->phys_addr <= (unsigned long)efi_phys.systab) && ((unsigned long)efi_phys.systab < md->phys_addr + ((unsigned long) md->num_pages << EFI_PAGE_SHIFT))) {
+				efi.systab = (efi_system_table_t *) 
+					((md->virt_addr - md->phys_addr) + 
+					(u64)efi_phys.systab); 
+			}
+		}
+	}
+
+	if (!efi.systab)
+		BUG();
+	
+	status = phys_efi_set_virtual_address_map(
+			sizeof(efi_memory_desc_t) * memmap.nr_map, 
+			sizeof(efi_memory_desc_t),
+			memmap.desc_version,
+		       	memmap.phys_map);
+	
+	if (status != EFI_SUCCESS) {
+		printk (KERN_ALERT "You are screwed! "
+			"Unable to switch EFI into virtual mode "
+			"(status=%lx)\n", status);
+		panic("EFI call to SetVirtualAddressMap() failed!");
+	}
+
+	/*
+	 * Now that EFI is in virtual mode, update the function
+	 * pointers in the runtime service table to the new virtual addresses.
+	 */
+
+	efi.get_time = (efi_get_time_t *) efi.systab->runtime->get_time;
+	efi.set_time = (efi_set_time_t *) efi.systab->runtime->set_time;
+	efi.get_wakeup_time = (efi_get_wakeup_time_t *)
+					efi.systab->runtime->get_wakeup_time;
+	efi.set_wakeup_time = (efi_set_wakeup_time_t *)
+					efi.systab->runtime->set_wakeup_time;
+	efi.get_variable = (efi_get_variable_t *)
+					efi.systab->runtime->get_variable;
+	efi.get_next_variable = (efi_get_next_variable_t *)
+					efi.systab->runtime->get_next_variable;
+	efi.set_variable = (efi_set_variable_t *)
+					efi.systab->runtime->set_variable;
+	efi.get_next_high_mono_count = (efi_get_next_high_mono_count_t *)
+					efi.systab->runtime->get_next_high_mono_count;
+	efi.reset_system = (efi_reset_system_t *)
+					efi.systab->runtime->reset_system;
+}
+
+void __init 
+efi_initialize_iomem_resources(struct resource *code_resource,
+			       struct resource *data_resource)
+{
+	struct resource *res;
+	efi_memory_desc_t *md;
+	int i;
+
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+	
+		if ((md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >
+		    0x100000000ULL)
+			continue;
+		res = alloc_bootmem_low(sizeof(struct resource));
+		switch (md->type) {
+		case EFI_RESERVED_TYPE:
+			res->name = "Reserved Memory";
+			break;
+		case EFI_LOADER_CODE:
+			res->name = "Loader Code";
+			break;
+		case EFI_LOADER_DATA:
+			res->name = "Loader Data";
+			break;
+		case EFI_BOOT_SERVICES_DATA:
+			res->name = "BootServices Data";
+			break;
+		case EFI_BOOT_SERVICES_CODE:
+			res->name = "BootServices Code";
+			break;
+		case EFI_RUNTIME_SERVICES_CODE:
+			res->name = "Runtime Service Code";
+			break;
+		case EFI_RUNTIME_SERVICES_DATA:
+			res->name = "Runtime Service Data";
+			break;
+		case EFI_CONVENTIONAL_MEMORY:
+			res->name = "Conventional Memory";
+			break;
+		case EFI_UNUSABLE_MEMORY:
+			res->name = "Unusable Memory";
+			break;
+		case EFI_ACPI_RECLAIM_MEMORY:
+			res->name = "ACPI Reclaim";
+			break;
+		case EFI_ACPI_MEMORY_NVS:
+			res->name = "ACPI NVS";
+			break;
+		case EFI_MEMORY_MAPPED_IO:
+			res->name = "Memory Mapped IO";
+			break;
+		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+			res->name = "Memory Mapped IO Port Space";
+			break;
+		default:
+			res->name = "Reserved";
+			break;
+		}
+		res->start = md->phys_addr;
+		res->end = res->start + ((md->num_pages << EFI_PAGE_SHIFT) - 1);
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		if (request_resource(&iomem_resource, res) < 0)
+			printk(KERN_ERR PFX "Failed to allocate res %s : 0x%lx-0x%lx\n",
+				res->name, res->start, res->end);
+		/* 
+		 * We don't know which region contains kernel data so we try
+		 * it repeatedly and let the resource manager test it.
+		 */
+		if (md->type == EFI_CONVENTIONAL_MEMORY) {
+			request_resource(res, code_resource);
+			request_resource(res, data_resource);
+		}
+	}
+}
+
+/*
+ * Convenience functions to obtain memory types and attributes
+ */
+
+u32 efi_mem_type(unsigned long phys_addr)
+{
+	efi_memory_desc_t *md;
+	int i;
+	
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+		if ((md->phys_addr <= phys_addr) && (phys_addr <
+			(md->phys_addr + (md-> num_pages << EFI_PAGE_SHIFT)) ))
+			return md->type;
+	}
+	return 0;
+}
+
+u64 efi_mem_attributes(unsigned long phys_addr)
+{
+	efi_memory_desc_t *md;
+	int i;
+
+	for (i = 0; i < memmap.nr_map; i++) {
+		md = &memmap.map[i];
+		if ((md->phys_addr <= phys_addr) && (phys_addr <
+			(md->phys_addr + (md-> num_pages << EFI_PAGE_SHIFT)) ))
+			return md->attribute;
+	}
+	return 0;
+}
+
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/efi_stub.S linux-2.6.0-test6-mm2-efi/arch/i386/kernel/efi_stub.S
--- linux-2.6.0-test6-mm2/arch/i386/kernel/efi_stub.S	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/efi_stub.S	2003-10-03 10:10:40.000000000 -0700
@@ -0,0 +1,125 @@
+/*
+ * EFI call stub for IA32.
+ *
+ * This stub allows us to make EFI calls in physical mode with interrupts
+ * turned off.
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+/*
+ * efi_call_phys(void *, ...) is a function with variable parameters.
+ * All the callers of this function assure that all the parameters are 4-bytes.
+ */
+
+/*
+ * In gcc calling convention, EBX, ESP, EBP, ESI and EDI are all callee save.
+ * So we'd better save all of them at the beginning of this function and restore
+ * at the end no matter how many we use, because we can not assure EFI runtime 
+ * service functions will comply with gcc calling convention, too.
+ */
+
+.text
+.section .text, "a"
+ENTRY(efi_call_phys)
+	/* 
+	 * 0. The function can only be called in Linux kernel. So CS has been
+	 * set to 0x0010, DS and SS have been set to 0x0018. In EFI, I found
+	 * the values of these registers are the same. And, the corresponding 
+	 * GDT entries are identical. So I will do nothing about segment reg
+	 * and GDT, but change GDT base register in prelog and epilog.
+	 */
+
+	/*
+	 * 1. Now I am running with EIP = <physical address> + PAGE_OFFSET.
+	 * But to make it smoothly switch from virtual mode to flat mode.
+	 * The mapping of lower virtual memory has been created in prelog and
+	 * epilog.
+	 */
+	movl	$1f, %edx
+	subl	$__PAGE_OFFSET, %edx
+	jmp	*%edx
+1:
+
+	/*
+	 * 2. Now on the top of stack is the return 
+	 * address in the caller of efi_call_phys(), then parameter 1,
+	 * parameter 2, ..., param n. To make things easy, we save the return 
+	 * address of efi_call_phys in a global variable.
+	 */
+	popl	%edx
+	movl	%edx, saved_return_addr
+	/* get the function pointer into ECX*/
+	popl	%ecx
+	movl	%ecx, efi_rt_function_ptr
+	movl	$2f, %edx
+	subl	$__PAGE_OFFSET, %edx
+	pushl	%edx
+
+	/*
+	 * 3. Clear PG bit in %CR0.
+	 */
+	movl	%cr0, %edx
+	andl	$0x7fffffff, %edx
+	movl	%edx, %cr0
+	jmp	1f
+1:
+
+	/*
+	 * 4. Adjust stack pointer.
+	 */
+	subl	$__PAGE_OFFSET, %esp
+	
+	/*
+	 * 5. Call the physical function.
+	 */
+	jmp	*%ecx
+
+2:
+	/*
+	 * 6. After EFI runtime service returns, control will return to 
+	 * following instruction. We'd better readjust stack pointer first.
+	 */
+	addl	$__PAGE_OFFSET, %esp
+
+	/*
+	 * 7. Restore PG bit
+	 */
+	movl	%cr0, %edx
+	orl	$0x80000000, %edx
+	movl	%edx, %cr0
+	jmp	1f
+1:
+	/*
+	 * 8. Now restore the virtual mode from flat mode by
+	 * adding EIP with PAGE_OFFSET.
+	 */
+	movl	$1f, %edx
+	jmp	*%edx
+1:
+
+	/* 
+	 * 9. Balance the stack. And because EAX contain the return value,
+	 * we'd better not clobber it.
+	 */
+	leal	efi_rt_function_ptr, %edx
+	movl	(%edx), %ecx
+	pushl	%ecx
+
+	/*
+	 * 10. Push the saved return address onto the stack and return.
+	 */
+	leal	saved_return_addr, %edx
+	movl	(%edx), %ecx
+	pushl	%ecx
+	ret
+.previous
+
+.data
+saved_return_addr:
+	.long 0
+efi_rt_function_ptr:
+	.long 0
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/Makefile linux-2.6.0-test6-mm2-efi/arch/i386/kernel/Makefile
--- linux-2.6.0-test6-mm2/arch/i386/kernel/Makefile	2003-10-03 11:50:44.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/Makefile	2003-10-03 10:10:40.000000000 -0700
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o entry_trampoline.o
+		doublefault.o efi.o efi_stub.o entry_trampoline.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/reboot.c linux-2.6.0-test6-mm2-efi/arch/i386/kernel/reboot.c
--- linux-2.6.0-test6-mm2/arch/i386/kernel/reboot.c	2003-10-03 11:50:44.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/reboot.c	2003-10-03 10:10:40.000000000 -0700
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
+#include <linux/efi.h>
 #include <asm/uaccess.h>
 #include <asm/apic.h>
 #include "mach_reboot.h"
@@ -261,7 +262,12 @@
 	disable_IO_APIC();
 #endif
 
-	if(!reboot_thru_bios) {
+	if (!reboot_thru_bios) {
+		if (efi_enabled) {
+			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, 0);
+			__asm__ __volatile__("lidt %0": :"m" (no_idt));
+			__asm__ __volatile__("int3");
+		}
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
 		for (;;) {
@@ -271,6 +277,8 @@
 			__asm__ __volatile__("int3");
 		}
 	}
+	if (efi_enabled)
+		efi.reset_system(EFI_RESET_WARM, EFI_SUCCESS, 0, 0);
 
 	machine_real_restart(jump_to_bios, sizeof(jump_to_bios));
 }
@@ -281,6 +289,8 @@
 
 void machine_power_off(void)
 {
+	if (efi_enabled)
+		efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, 0);
 	if (pm_power_off)
 		pm_power_off();
 }
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/setup.c linux-2.6.0-test6-mm2-efi/arch/i386/kernel/setup.c
--- linux-2.6.0-test6-mm2/arch/i386/kernel/setup.c	2003-10-03 11:50:44.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/setup.c	2003-10-03 11:36:22.000000000 -0700
@@ -36,6 +36,8 @@
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/efi.h>
+#include <linux/init.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
@@ -56,6 +58,8 @@
  * Machine setup..
  */
 
+int efi_enabled = 0;
+
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
@@ -144,6 +148,20 @@
 	int i;
 	unsigned long long current_size = 0;
 
+	if (efi_enabled) {
+		for (i = 0; i < memmap.nr_map; i++) {
+			current_size = memmap.map[i].phys_addr +
+				       (memmap.map[i].num_pages << 12);
+			if (memmap.map[i].type == EFI_CONVENTIONAL_MEMORY) {
+				if (current_size > size) {
+					memmap.map[i].num_pages -=
+						(((current_size-size) + PAGE_SIZE-1) >> PAGE_SHIFT);
+					memmap.nr_map = i + 1;
+					return;
+				}
+			}
+		}
+	} 
 	for (i = 0; i < e820.nr_map; i++) {
 		if (e820.map[i].type == E820_RAM) {
 			current_size += e820.map[i].size;
@@ -158,17 +176,21 @@
 static void __init add_memory_region(unsigned long long start,
                                   unsigned long long size, int type)
 {
-	int x = e820.nr_map;
+	int x;
+	
+	if (!efi_enabled) {
+       		x = e820.nr_map;
 
-	if (x == E820MAX) {
-	    printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
-	    return;
-	}
+		if (x == E820MAX) {
+		    printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
+		    return;
+		}
 
-	e820.map[x].addr = start;
-	e820.map[x].size = size;
-	e820.map[x].type = type;
-	e820.nr_map++;
+		e820.map[x].addr = start;
+		e820.map[x].size = size;
+		e820.map[x].type = type;
+		e820.nr_map++;
+	}
 } /* add_memory_region */
 
 #define E820_DEBUG	1
@@ -445,7 +467,6 @@
 static void __init setup_memory_region(void)
 {
 	char *who = machine_specific_memory_setup();
-
 	printk(KERN_INFO "BIOS-provided physical RAM map:\n");
 	print_memory_map(who);
 } /* setup_memory_region */
@@ -583,6 +604,23 @@
 }
 
 /*
+ * Callback for efi_memory_walk.
+ */
+static int __init 
+efi_find_max_pfn(unsigned long start, unsigned long end, void *arg)
+{
+	unsigned long *max_pfn = arg, pfn;
+
+	if (start < end) {
+		pfn = PFN_UP(end -1);
+		if (pfn > *max_pfn)
+			*max_pfn = pfn;
+	}
+	return 0;
+}
+
+
+/*
  * Find the highest page frame number we have available
  */
 void __init find_max_pfn(void)
@@ -590,6 +628,11 @@
 	int i;
 
 	max_pfn = 0;
+	if (efi_enabled) {
+		efi_memmap_walk(efi_find_max_pfn, &max_pfn);
+		return;
+	}
+
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long start, end;
 		/* RAM? */
@@ -664,6 +707,25 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
+
+/* 
+ * Free all available memory for boot time allocation.  Used
+ * as a callback function by efi_memory_walk()
+ */
+
+static int __init 
+free_available_memory(unsigned long start, unsigned long end, void *arg)
+{
+	/* check max_low_pfn */
+	if (start >= ((max_low_pfn + 1) << PAGE_SHIFT))
+		return 0;
+	if (end >= ((max_low_pfn + 1) << PAGE_SHIFT))
+		end = (max_low_pfn + 1) << PAGE_SHIFT;
+	if (start < end)
+		free_bootmem(start, end - start);
+
+	return 0;
+}
 /*
  * Register fully available low RAM pages with the bootmem allocator.
  */
@@ -671,6 +733,10 @@
 {
 	int i;
 
+	if (efi_enabled) {
+		efi_memmap_walk(free_available_memory, NULL);
+		return;
+	}
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long curr_pfn, last_pfn, size;
 		/*
@@ -798,11 +864,11 @@
  * Request address space for all standard RAM and ROM resources
  * and also for regions reported as reserved by the e820.
  */
-static void __init register_memory(unsigned long max_low_pfn)
+static void __init 
+legacy_init_iomem_resources(struct resource *code_resource, struct resource *data_resource)
 {
-	unsigned long low_mem_size;
 	int i;
-
+	
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
@@ -825,11 +891,26 @@
 			 *  so we try it repeatedly and let the resource manager
 			 *  test it.
 			 */
-			request_resource(res, &code_resource);
-			request_resource(res, &data_resource);
+			request_resource(res, code_resource);
+			request_resource(res, data_resource);
 		}
 	}
+}
 
+/*
+ * Request address space for all standard resources
+ */
+static void __init register_memory(unsigned long max_low_pfn)
+{
+	unsigned long low_mem_size;
+	int i;
+
+	if (efi_enabled)
+		efi_initialize_iomem_resources(&code_resource, &data_resource);
+	else 
+		legacy_init_iomem_resources(&code_resource, &data_resource);
+
+ 	 /* EFI systems may still have VGA */
 	request_graphics_resource();
 
 	/* request I/O space for devices used on all i[345]86 PCs */
@@ -949,6 +1030,13 @@
 
 __setup("noreplacement", noreplacement_setup); 
 
+/* 
+ * Determine if we were loaded by an EFI loader.  If so, then we have also been 
+ * passed the efi memmap, systab, etc., so we should use these data structures 
+ * for initialization.  Note, the efi init code path is determined by the 
+ * global efi_enabled. This allows the same kernel image to be used on existing 
+ * systems (with a traditional BIOS) as well as on EFI systems.  
+ */
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long max_low_pfn;
@@ -957,6 +1045,12 @@
 	pre_setup_arch_hook();
 	early_cpu_init();
 
+	/* FIXME: This isn't an official loader_type right 
+	 * now but does currently work with elilo. 
+	 */
+	if ((LOADER_TYPE == 0x50) && EFI_SYSTAB)
+		efi_enabled = 1;
+
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
  	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
@@ -979,7 +1073,11 @@
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
 	ARCH_SETUP
-	setup_memory_region();
+	if (efi_enabled)
+		efi_init();
+	else
+		setup_memory_region();
+
 	copy_edd();
 
 	if (!MOUNT_ROOT_RDONLY)
@@ -1013,6 +1111,8 @@
 #ifdef CONFIG_X86_GENERICARCH
 	generic_apic_probe(*cmdline_p);
 #endif	
+	if (efi_enabled)
+		efi_map_memmap();
 
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
@@ -1028,7 +1128,8 @@
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
+	if (!efi_enabled || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
+		conswitchp = &vga_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
 #endif
diff -urN linux-2.6.0-test6-mm2/arch/i386/kernel/time.c linux-2.6.0-test6-mm2-efi/arch/i386/kernel/time.c
--- linux-2.6.0-test6-mm2/arch/i386/kernel/time.c	2003-09-27 17:50:20.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/kernel/time.c	2003-10-03 10:10:40.000000000 -0700
@@ -44,6 +44,7 @@
 #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
+#include <linux/efi.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -160,6 +161,37 @@
 	return retval;
 }
 
+static int efi_set_rtc_mmss(unsigned long nowtime)
+{
+	int real_seconds, real_minutes;
+	unsigned long 	flags;
+	efi_status_t 	status;
+	efi_time_t 	eft;
+	efi_time_cap_t 	cap;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+
+	status = efi.get_time(&eft, &cap);
+	if (status != EFI_SUCCESS)
+		panic("Ooops, efitime: can't read time!\n");
+	real_seconds = nowtime % 60;
+	real_minutes = nowtime / 60;
+
+	if (((abs(real_minutes - eft.minute) + 15)/30) & 1)
+		real_minutes += 30;
+	real_minutes %= 60;
+
+	eft.minute = real_minutes;
+	eft.second = real_seconds;
+
+	status = efi.set_time(&eft);
+	if (status != EFI_SUCCESS)
+		panic("Ooops: efitime: can't read time!\n");
+
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return 0;
+}
+
 /* last time the cmos clock got updated */
 static long last_rtc_update;
 
@@ -212,7 +244,7 @@
 			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000)
 			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
-		if (set_rtc_mmss(xtime.tv_sec) == 0)
+		if ((efi_enabled && (!efi_set_rtc_mmss(xtime.tv_sec) )) || (set_rtc_mmss(xtime.tv_sec) == 0))
 			last_rtc_update = xtime.tv_sec;
 		else
 			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
@@ -277,6 +309,27 @@
 	set_kset_name("pit"),
 };
 
+/*
+ * This is called before the RT mappings are in place, so we
+ * need to be able to get the time in physical mode.
+ */
+unsigned long efi_get_time(void)
+{
+	efi_status_t status;
+	unsigned long flags;
+	efi_time_t eft;
+	efi_time_cap_t cap;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	status = phys_efi_get_time(&eft, &cap);
+	if (status != EFI_SUCCESS)
+		printk("Oops: efitime: can't read time status: 0x%lx\n", status);
+
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	
+	return mktime(eft.year, eft.month, eft.day, eft.hour, eft.minute, eft.second);
+}
+
 /* XXX this driverfs stuff should probably go elsewhere later -john */
 static struct sys_device device_i8253 = {
 	.id	= 0,
@@ -298,7 +351,10 @@
 /* Duplicate of time_init() below, with hpet_enable part added */
 void __init hpet_time_init(void)
 {
-	xtime.tv_sec = get_cmos_time();
+	if (efi_enabled)
+		xtime.tv_sec = efi_get_time();
+	else
+		xtime.tv_sec = get_cmos_time();
 	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
@@ -324,8 +380,10 @@
 		return;
 	}
 #endif
-
-	xtime.tv_sec = get_cmos_time();
+	if (efi_enabled)
+		xtime.tv_sec = efi_get_time();
+	else
+		xtime.tv_sec = get_cmos_time();
 	wall_to_monotonic.tv_sec = -xtime.tv_sec;
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
diff -urN linux-2.6.0-test6-mm2/arch/i386/mm/init.c linux-2.6.0-test6-mm2-efi/arch/i386/mm/init.c
--- linux-2.6.0-test6-mm2/arch/i386/mm/init.c	2003-10-03 11:50:44.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/arch/i386/mm/init.c	2003-10-03 10:10:40.000000000 -0700
@@ -25,6 +25,7 @@
 #include <linux/bootmem.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
+#include <linux/efi.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -52,12 +53,30 @@
 	return 0;
 }
 
+extern int is_available_memory(efi_memory_desc_t *);
+
 static inline int page_is_ram(unsigned long pagenr)
 {
 	int i;
+	unsigned long addr, end;
+
+	if (efi_enabled) {
+		efi_memory_desc_t *md;
+		
+		for (i = 0; i < memmap.nr_map; i++) {
+			md = &memmap.map[i];
+			if (!is_available_memory(md))
+				continue;
+			addr = (md->phys_addr+PAGE_SIZE-1) >> PAGE_SHIFT;
+			end = (md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) >> PAGE_SHIFT;
+
+			if ((pagenr >= addr) && (pagenr < end))
+				return 1;
+		}
+		return 0;
+	}
 
 	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long addr, end;
 
 		if (e820.map[i].type != E820_RAM)	/* not usable memory */
 			continue;
diff -urN linux-2.6.0-test6-mm2/drivers/acpi/Kconfig linux-2.6.0-test6-mm2-efi/drivers/acpi/Kconfig
--- linux-2.6.0-test6-mm2/drivers/acpi/Kconfig	2003-10-03 11:50:45.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/drivers/acpi/Kconfig	2003-10-03 11:48:18.000000000 -0700
@@ -252,10 +252,16 @@
 	  dump your ACPI DSDT table using /proc/acpi/dsdt.
 
 config ACPI_EFI
-	bool
+ 	bool "Obtain RSDP from EFI Configuration Table" 
 	depends on ACPI_INTERPRETER
-	depends on IA64
-	default y
+	depends on IA64 || X86
+  	default y
+ 	help
+ 	   On EFI Systems the RSDP pointer is passed to the kernel via
+ 	   the EFI Configuration Table.  On Itanium systems this is 
+ 	   standard and required.  For IA-32, systems that have
+ 	   EFI firmware should leave this enabled.  Platforms with 
+ 	   traditional legacy BIOS should disable this option.
 
 config ACPI_RELAXED_AML
 	bool "Relaxed AML"
diff -urN linux-2.6.0-test6-mm2/drivers/acpi/osl.c linux-2.6.0-test6-mm2-efi/drivers/acpi/osl.c
--- linux-2.6.0-test6-mm2/drivers/acpi/osl.c	2003-09-27 17:50:48.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/drivers/acpi/osl.c	2003-10-03 10:10:40.000000000 -0700
@@ -43,7 +43,6 @@
 
 #ifdef CONFIG_ACPI_EFI
 #include <linux/efi.h>
-u64 efi_mem_attributes (u64 phys_addr);
 #endif
 
 
diff -urN linux-2.6.0-test6-mm2/include/asm-i386/setup.h linux-2.6.0-test6-mm2-efi/include/asm-i386/setup.h
--- linux-2.6.0-test6-mm2/include/asm-i386/setup.h	2003-09-27 17:50:31.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/include/asm-i386/setup.h	2003-10-03 10:10:40.000000000 -0700
@@ -29,6 +29,11 @@
 #define IST_INFO   (*(struct ist_info *) (PARAM+0x60))
 #define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
 #define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
+#define EFI_SYSTAB ((efi_system_table_t *) *((unsigned long *)(PARAM+0x1c4)))
+#define EFI_MEMDESC_SIZE (*((unsigned long *) (PARAM+0x1c8)))
+#define EFI_MEMDESC_VERSION (*((unsigned long *) (PARAM+0x1cc)))
+#define EFI_MEMMAP ((efi_memory_desc_t *) *((unsigned long *)(PARAM+0x1d0)))
+#define EFI_MEMMAP_SIZE (*((unsigned long *) (PARAM+0x1d4)))
 #define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
 #define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
 #define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
diff -urN linux-2.6.0-test6-mm2/include/linux/efi.h linux-2.6.0-test6-mm2-efi/include/linux/efi.h
--- linux-2.6.0-test6-mm2/include/linux/efi.h	2003-09-27 17:51:03.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/include/linux/efi.h	2003-10-03 15:41:21.000000000 -0700
@@ -16,6 +16,8 @@
 #include <linux/time.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/rtc.h>
+#include <linux/ioport.h>
 
 #include <asm/page.h>
 #include <asm/system.h>
@@ -89,6 +91,11 @@
 
 #define EFI_PAGE_SHIFT		12
 
+/* 
+ * For current x86 implementations of EFI, there is 
+ * additional padding in the mem descriptors.  This is not
+ * the case in ia64.  Need to have this fixed in the f/w.
+ */
 typedef struct {
 	u32 type;
 	u32 pad;
@@ -96,6 +103,9 @@
 	u64 virt_addr;
 	u64 num_pages;
 	u64 attribute;
+#if defined (__i386__)
+	u64 pad1;
+#endif
 } efi_memory_desc_t;
 
 typedef int efi_freemem_callback_t (unsigned long start, unsigned long end, void *arg);
@@ -132,6 +142,7 @@
  */
 #define EFI_RESET_COLD 0
 #define EFI_RESET_WARM 1
+#define EFI_RESET_SHUTDOWN 2
 
 /*
  * EFI Runtime Services table
@@ -169,6 +180,10 @@
 typedef efi_status_t efi_get_next_high_mono_count_t (u32 *count);
 typedef void efi_reset_system_t (int reset_type, efi_status_t status,
 				 unsigned long data_size, efi_char16_t *data);
+typedef efi_status_t efi_set_virtual_address_map_t (unsigned long memory_map_size,
+						unsigned long descriptor_size,
+						u32 descriptor_version,
+						efi_memory_desc_t *virtual_map);
 
 /*
  *  EFI Configuration Table and GUID definitions
@@ -194,6 +209,9 @@
 #define HCDP_TABLE_GUID	\
     EFI_GUID(  0xf951938d, 0x620b, 0x42ef, 0x82, 0x79, 0xa8, 0x4b, 0x79, 0x61, 0x78, 0x98 )
 
+#define UGA_IO_PROTOCOL_GUID \
+    EFI_GUID(  0x61a4d49e, 0x6f68, 0x4f1b, 0xb9, 0x22, 0xa8, 0x6e, 0xed, 0xb, 0x7, 0xa2 )
+
 typedef struct {
 	efi_guid_t guid;
 	unsigned long table;
@@ -218,6 +236,13 @@
 	unsigned long tables;
 } efi_system_table_t;
 
+struct efi_memory_map {
+	efi_memory_desc_t *phys_map;
+	efi_memory_desc_t *map;
+	int nr_map;
+	unsigned long desc_version;
+};
+
 /*
  * All runtime access to EFI goes through this structure:
  */
@@ -230,6 +255,7 @@
 	void *sal_systab;		/* SAL system table */
 	void *boot_info;		/* boot info table */
 	void *hcdp;			/* HCDP table */
+	void *uga;			/* UGA table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
@@ -239,6 +265,7 @@
 	efi_set_variable_t *set_variable;
 	efi_get_next_high_mono_count_t *get_next_high_mono_count;
 	efi_reset_system_t *reset_system;
+	efi_set_virtual_address_map_t *set_virtual_address_map;
 } efi;
 
 static inline int
@@ -260,12 +287,18 @@
 
 extern void efi_init (void);
 extern void efi_map_pal_code (void);
+extern void efi_map_memmap(void);
 extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
+extern void efi_initialize_iomem_resources(struct resource *code_resource,
+					struct resource *data_resource);
+extern efi_status_t phys_efi_get_time(efi_time_t *tm, efi_time_cap_t *tc);
+extern struct efi_memory_map memmap;
+extern int efi_enabled;
 
 /*
  * Variable Attributes
diff -urN linux-2.6.0-test6-mm2/init/main.c linux-2.6.0-test6-mm2-efi/init/main.c
--- linux-2.6.0-test6-mm2/init/main.c	2003-09-27 17:50:10.000000000 -0700
+++ linux-2.6.0-test6-mm2-efi/init/main.c	2003-10-03 10:10:40.000000000 -0700
@@ -37,6 +37,7 @@
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
+#include <linux/efi.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -436,6 +437,8 @@
 	pidmap_init();
 	pgtable_cache_init();
 	pte_chain_init();
+	if (efi_enabled)
+		efi_enter_virtual_mode();
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
