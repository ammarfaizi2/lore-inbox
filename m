Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbUCYABK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUCXX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:59:15 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:51894 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262316AbUCXX5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:57:35 -0500
Subject: [patch 2/22] __early_param for i386
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, greg@kroah.com
From: trini@kernel.crashing.org
Message-Id: <20040324235731.YEKZ19401.fed1mtao06.cox.net@localhost.localdomain>
Date: Wed, 24 Mar 2004 18:57:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Greg KH <greg@kroah.com>
- Remove saved_command_line (and saving of the command line).
- Call parse_early_options
- Convert mem=, memmap=, acpi=, noapic, highmem=, apic=,
  and pci= to __early_param (Greg, is this OK?  It looks like it after
  a quick skim).


---

 linux-2.6-early_setup-trini/arch/i386/kernel/setup.c       |  257 +++++--------
 linux-2.6-early_setup-trini/arch/i386/kernel/vmlinux.lds.S |    3 
 linux-2.6-early_setup-trini/arch/i386/mach-generic/probe.c |   53 +-
 linux-2.6-early_setup-trini/drivers/pci/pci.c              |    2 
 4 files changed, 149 insertions(+), 166 deletions(-)

diff -puN arch/i386/kernel/setup.c~i386 arch/i386/kernel/setup.c
--- linux-2.6-early_setup/arch/i386/kernel/setup.c~i386	2004-03-24 16:15:04.953072474 -0700
+++ linux-2.6-early_setup-trini/arch/i386/kernel/setup.c	2004-03-24 16:15:04.962070448 -0700
@@ -127,9 +127,6 @@ unsigned long saved_videomode;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000	
 
-static char command_line[COMMAND_LINE_SIZE];
-       char saved_command_line[COMMAND_LINE_SIZE];
-
 unsigned char __initdata boot_params[PARAM_SIZE];
 
 static struct resource code_resource = { "Kernel code", 0x100000, 0 };
@@ -485,140 +482,136 @@ static void __init setup_memory_region(v
 } /* setup_memory_region */
 
 
-static void __init parse_cmdline_early (char ** cmdline_p)
+/*
+ * "mem=nopentium" disables the 4MB page tables.
+ * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
+ * to <mem>, overriding the bios size.
+ *
+ * HPA tells me bootloaders need to parse mem=, so no new
+ * option should be mem=  [also see Documentation/i386/boot.txt]
+ */
+static int __init early_mem(char *from)
 {
-	char c = ' ', *to = command_line, *from = saved_command_line;
-	int len = 0;
-	int userdef = 0;
+	if (!memcmp(from, "nopentium", 9)) {
+		clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
+		disable_pse = 1;
+	} else {
+		/* If the user specifies memory size, we
+		 * limit the BIOS-provided memory map to
+		 * that size. exactmap can be used to specify
+		 * the exact map. mem=number can be used to
+		 * trim the existing memory map.
+		 */
+		unsigned long long mem_size;
 
-	/* Save unparsed command line copy for /proc/cmdline */
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+		mem_size = memparse(from, &from);
+		limit_regions(mem_size);
+		printk(KERN_INFO "user-defined physical RAM map:\n");
+		print_memory_map("user");
+	}
 
-	for (;;) {
-		/*
-		 * "mem=nopentium" disables the 4MB page tables.
-		 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
-		 * to <mem>, overriding the bios size.
-		 * "memmap=XXX[KkmM]@XXX[KkmM]" defines a memory region from
-		 * <start> to <start>+<mem>, overriding the bios size.
-		 *
-		 * HPA tells me bootloaders need to parse mem=, so no new
-		 * option should be mem=  [also see Documentation/i386/boot.txt]
-		 */
-		if (c == ' ' && !memcmp(from, "mem=", 4)) {
-			if (to != command_line)
-				to--;
-			if (!memcmp(from+4, "nopentium", 9)) {
-				from += 9+4;
-				clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
-				disable_pse = 1;
-			} else {
-				/* If the user specifies memory size, we
-				 * limit the BIOS-provided memory map to
-				 * that size. exactmap can be used to specify
-				 * the exact map. mem=number can be used to
-				 * trim the existing memory map.
-				 */
-				unsigned long long mem_size;
- 
-				mem_size = memparse(from+4, &from);
-				limit_regions(mem_size);
-				userdef=1;
-			}
-		}
+	return 0;
+}
+__early_param("mem=", early_mem);
 
-		if (c == ' ' && !memcmp(from, "memmap=", 7)) {
-			if (to != command_line)
-				to--;
-			if (!memcmp(from+7, "exactmap", 8)) {
-				from += 8+7;
-				e820.nr_map = 0;
-				userdef = 1;
-			} else {
-				/* If the user specifies memory size, we
-				 * limit the BIOS-provided memory map to
-				 * that size. exactmap can be used to specify
-				 * the exact map. mem=number can be used to
-				 * trim the existing memory map.
-				 */
-				unsigned long long start_at, mem_size;
- 
-				mem_size = memparse(from+7, &from);
-				if (*from == '@') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_RAM);
-				} else if (*from == '#') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_ACPI);
-				} else if (*from == '$') {
-					start_at = memparse(from+1, &from);
-					add_memory_region(start_at, mem_size, E820_RESERVED);
-				} else {
-					limit_regions(mem_size);
-					userdef=1;
-				}
-			}
-		}
+/*
+ * "memmap=XXX[KkmM][@#$]XXX[KkmM]" defines a memory region from
+ * <start> to <start>+<mem>, overriding the bios size.
+ */
+static int __init early_memmap(char *from)
+{
+	int userdef = 0;
 
-#ifdef CONFIG_ACPI_BOOT
-		/* "acpi=off" disables both ACPI table parsing and interpreter */
-		else if (!memcmp(from, "acpi=off", 8)) {
-			acpi_ht = 0;
-			acpi_disabled = 1;
+	if (!memcmp(from, "exactmap", 8)) {
+		e820.nr_map = 0;
+		userdef = 1;
+	} else {
+		/* If the user specifies memory size, we
+		 * limit the BIOS-provided memory map to
+		 * that size. exactmap can be used to specify
+		 * the exact map. mem=number can be used to
+		 * trim the existing memory map.
+		 */
+		unsigned long long start_at, mem_size;
+		mem_size = memparse(from, &from);
+		if (*from == '@') {
+			start_at = memparse(from + 1, &from);
+			add_memory_region(start_at, mem_size, E820_RAM);
+		} else if (*from == '#') {
+			start_at = memparse(from + 1, &from);
+			add_memory_region(start_at, mem_size, E820_ACPI);
+		} else if (*from == '$') {
+			start_at = memparse(from + 1, &from);
+			add_memory_region(start_at, mem_size, E820_RESERVED);
+		} else {
+			limit_regions(mem_size);
+			userdef = 1;
 		}
+	}
 
-		/* acpi=force to over-ride black-list */
-		else if (!memcmp(from, "acpi=force", 10)) {
-			acpi_force = 1;
-			acpi_ht=1;
-			acpi_disabled = 0;
-		}
+	if (userdef) {
+		printk(KERN_INFO "user-defined physical RAM map:\n");
+		print_memory_map("user");
+	}
 
-		/* acpi=strict disables out-of-spec workarounds */
-		else if (!memcmp(from, "acpi=strict", 11)) {
-			acpi_strict = 1;
-		}
+	return 0;
+}
+__early_param("memmap=", early_memmap);
 
-		/* Limit ACPI just to boot-time to enable HT */
-		else if (!memcmp(from, "acpi=ht", 7)) {
-			acpi_ht = 1;
-			if (!acpi_force) acpi_disabled = 1;
-		}
+#ifdef CONFIG_ACPI_BOOT
+static int __init early_acpi(char *from)
+{
+	/* "off" disables both ACPI table parsing and interpreter */
+	if (!memcmp(from, "off", 3)) {
+		acpi_ht = 0;
+		acpi_disabled = 1;
+	}
+
+	/* "force" to over-ride black-list */
+	else if (!memcmp(from, "force", 5)) {
+		acpi_force = 1;
+		acpi_ht=1;
+		acpi_disabled = 0;
+	}
+
+	/* "strict" disables out-of-spec workarounds */
+	else if (!memcmp(from, "strict", 6))
+		acpi_strict = 1;
+
+	/* Limit ACPI just to boot-time to enable HT */
+	else if (!memcmp(from, "ht", 2)) {
+		acpi_ht = 1;
+		if (!acpi_force) acpi_disabled = 1;
+	}
 
-		/* "pci=noacpi" disables ACPI interrupt routing */
-		else if (!memcmp(from, "pci=noacpi", 10)) {
-			acpi_noirq_set();
-		}
+	return 0;
+}
+__early_param("acpi=", early_acpi);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-		/* disable IO-APIC */
-		else if (!memcmp(from, "noapic", 6))
-			disable_ioapic_setup();
+/* Disable IO-APIC. */
+static int __init early_disable_ioapic(char *from)
+{
+	disable_ioapic_setup();
+
+	return 0;
+}
+__early_param("noapic", early_disable_ioapic);
 #endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
-		/*
-		 * highmem=size forces highmem to be exactly 'size' bytes.
-		 * This works even on boxes that have no highmem otherwise.
-		 * This also works to reduce highmem size on bigger boxes.
-		 */
-		if (c == ' ' && !memcmp(from, "highmem=", 8))
-			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
-	
-		c = *(from++);
-		if (!c)
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*(to++) = c;
-	}
-	*to = '\0';
-	*cmdline_p = command_line;
-	if (userdef) {
-		printk(KERN_INFO "user-defined physical RAM map:\n");
-		print_memory_map("user");
-	}
+/*
+ * highmem=size forces highmem to be exactly 'size' bytes.
+ * This works even on boxes that have no highmem otherwise.
+ * This also works to reduce highmem size on bigger boxes.
+ */
+static int __init early_highmem_size(char *from)
+{
+	highmem_pages = memparse(from, &from) >> PAGE_SHIFT;
+
+	return 0;
 }
+__early_param("highmem=", early_highmem_size);
 
 /*
  * Callback for efi_memory_walk.
@@ -1063,6 +1056,7 @@ __setup("noreplacement", noreplacement_s
  */
 void __init setup_arch(char **cmdline_p)
 {
+	extern char saved_command_line[];
 	unsigned long max_low_pfn;
 
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
@@ -1121,8 +1115,9 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = virt_to_phys(_etext);
 	data_resource.end = virt_to_phys(_edata)-1;
 
-	parse_cmdline_early(cmdline_p);
-
+	/* We have the original cmdline stored here already. */
+	*cmdline_p = saved_command_line;
+	parse_early_options(cmdline_p);
 	max_low_pfn = setup_memory();
 
 	/*
@@ -1135,24 +1130,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 	paging_init();
 
-#ifdef CONFIG_EARLY_PRINTK
-	{
-		char *s = strstr(*cmdline_p, "earlyprintk=");
-		if (s) {
-			extern void setup_early_printk(char *);
-
-			setup_early_printk(s);
-			printk("early console enabled\n");
-		}
-	}
-#endif
-
-
 	dmi_scan_machine();
 
-#ifdef CONFIG_X86_GENERICARCH
-	generic_apic_probe(*cmdline_p);
-#endif	
 	if (efi_enabled)
 		efi_map_memmap();
 
diff -puN arch/i386/kernel/vmlinux.lds.S~i386 arch/i386/kernel/vmlinux.lds.S
--- linux-2.6-early_setup/arch/i386/kernel/vmlinux.lds.S~i386	2004-03-24 16:15:04.955072024 -0700
+++ linux-2.6-early_setup-trini/arch/i386/kernel/vmlinux.lds.S	2004-03-24 16:15:04.963070223 -0700
@@ -65,6 +65,9 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
+  __early_begin = .;
+  __early_param : { *(__early_param) }
+  __early_end = .;
   __start___param = .;
   __param : { *(__param) }
   __stop___param = .;
diff -puN arch/i386/mach-generic/probe.c~i386 arch/i386/mach-generic/probe.c
--- linux-2.6-early_setup/arch/i386/mach-generic/probe.c~i386	2004-03-24 16:15:04.957071574 -0700
+++ linux-2.6-early_setup-trini/arch/i386/mach-generic/probe.c	2004-03-24 16:15:04.963070223 -0700
@@ -28,41 +28,42 @@ struct genapic *apic_probe[] __initdata 
 	NULL,
 };
 
-void __init generic_apic_probe(char *command_line) 
-{ 
-	char *s;
+static int __init generic_apic_probe(char *command_line)
+{
+	char *s = command_line;
 	int i;
 	int changed = 0;
 
-	s = strstr(command_line, "apic=");
-	if (s && (s == command_line || isspace(s[-1]))) { 
-		char *p = strchr(s, ' '), old; 
-		if (!p)
-			p = strchr(s, '\0'); 
-		old = *p; 
-		*p = 0; 
-		for (i = 0; !changed && apic_probe[i]; i++) {
-			if (!strcmp(apic_probe[i]->name, s+5)) { 
-				changed = 1;
-				genapic = apic_probe[i];
-			}
+	char *p = strchr(s, ' '), old;
+	if (!p)
+		p = strchr(s, '\0');
+	old = *p;
+	*p = 0;
+	for (i = 0; !changed && apic_probe[i]; i++) {
+		if (!strcmp(apic_probe[i]->name, s+5)) {
+			changed = 1;
+			genapic = apic_probe[i];
 		}
-		if (!changed)
-			printk(KERN_ERR "Unknown genapic `%s' specified.\n", s);
-		*p = old;
-	} 
-	for (i = 0; !changed && apic_probe[i]; i++) { 
+	}
+	if (!changed)
+		printk(KERN_ERR "Unknown genapic `%s' specified.\n", s);
+	*p = old;
+
+	for (i = 0; !changed && apic_probe[i]; i++) {
 		if (apic_probe[i]->probe()) {
 			changed = 1;
-			genapic = apic_probe[i]; 
-		} 
+			genapic = apic_probe[i];
+		}
 	}
-	/* Not visible without early console */ 
-	if (!changed) 
-		panic("Didn't find an APIC driver"); 
+	/* Not visible without early console */
+	if (!changed)
+		panic("Didn't find an APIC driver");
 
 	printk(KERN_INFO "Using APIC driver %s\n", genapic->name);
-} 
+
+	return 0;
+}
+__early_param("apic=", generic_apic_probe);
 
 /* These functions can switch the APIC even after the initial ->probe() */
 
diff -puN drivers/pci/pci.c~i386 drivers/pci/pci.c
--- linux-2.6-early_setup/drivers/pci/pci.c~i386	2004-03-24 16:15:04.959071123 -0700
+++ linux-2.6-early_setup-trini/drivers/pci/pci.c	2004-03-24 16:15:04.964069998 -0700
@@ -718,7 +718,7 @@ static int __devinit pci_setup(char *str
 
 device_initcall(pci_init);
 
-__setup("pci=", pci_setup);
+__early_param("pci=", pci_setup);
 
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 /* FIXME: Some boxes have multiple ISA bridges! */

_
