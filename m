Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWHBDyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWHBDyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWHBDyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:54:08 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:9154 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751114AbWHBDyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:54:06 -0400
Subject: Re: [Xen-devel] Re: [PATCH 8 of 13] Add a bootparameter to reserve
	high linear address space for hypervisors
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <p73lkq7zvu3.fsf@verdi.suse.de>
References: <0adfc39039c79e4f4121.1154462446@ezr>
	 <200608012347.20556.ak@suse.de>
	 <1154479684.2570.14.camel@localhost.localdomain>
	 <p73lkq7zvu3.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 13:54:00 +1000
Message-Id: <1154490840.2570.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 04:59 +0200, Andi Kleen wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> > 
> > I only implemented parse_early_param two years ago; maybe it is time for
> > i386 to use it...
> 
> Problem is that it's too late. Some of the stuff is already needed
> in setup_arch. You would need to move it before it first.

Hi Andi!

	I think you misunderstand the purpose of parse_early_param?  It is
designed to be called directly by the arch at some point (it is
idempotent, so the second call in init/main.c does nothing if the arch
has called it).  ie. in i386, it replaces parse_cmdline_early().

Here's the patch against 2.6.18-rc2-mm1.  Tested with various
configurations, but it's still possible I broke something.


Subject: Replace i386 open-coded cmdline parsing with early_param/parse_early_param

This patch replaces the open-coded early commandline parsing
throughout the i386 boot code with the generic mechanism (already used
by ppc, powerpc, ia64 and s390).  The replaced code is inconsistent
with whether it deletes the option from the cmdline or not, meaning
some of these will get passed through the environment into init.

This transformation is mainly mechanical, but there are some notable
parts:

1) Grammar: s/linux never set's it up/linux never sets it up/

2) Remove hacked-in earlyprintk= option scanning.  When someone
   actually implements CONFIG_EARLY_PRINTK, then they can use
   early_param().

3) Move declaration of generic_apic_probe() from setup.c into asm/apic.h

4) "crashkernel" param can now be handled directly in machine_kexec.c

5) I left "pci=noacpi" as a manual hack, because there's a
   __setup("pci") already, and so an early_param("pci") would
   (depending in link order!) override it entirely. 

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/arch/i386/kernel/machine_kexec.c working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/kernel/machine_kexec.c
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/machine_kexec.c	2006-08-01 14:11:48.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/kernel/machine_kexec.c	2006-08-02 13:45:43.000000000 +1000
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/kexec.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -209,3 +210,25 @@ NORET_TYPE void machine_kexec(struct kim
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
 	(*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
 }
+
+/* crashkernel=size@addr specifies the location to reserve for
+ * a crash kernel.  By reserving this memory we guarantee
+ * that linux never sets it up as a DMA target.
+ * Useful for holding code to do something appropriate
+ * after a kernel panic.
+ */
+static int __init parse_crashkernel(char *arg)
+{
+	unsigned long size, base;
+	size = memparse(arg, &arg);
+	if (*arg == '@') {
+		base = memparse(arg+1, &arg);
+		/* FIXME: Do I want a sanity check
+		 * to validate the memory range?
+		 */
+		crashk_res.start = base;
+		crashk_res.end   = base + size - 1;
+	}
+	return 0;
+}
+early_param("crashkernel", parse_crashkernel);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/arch/i386/kernel/setup.c working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/kernel/setup.c
--- linux-2.6.18-rc2-mm1/arch/i386/kernel/setup.c	2006-08-01 14:11:48.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/kernel/setup.c	2006-08-02 13:42:22.000000000 +1000
@@ -149,7 +149,6 @@ EXPORT_SYMBOL(ist_info);
 struct e820map e820;
 
 extern void early_cpu_init(void);
-extern void generic_apic_probe(char *);
 extern int root_mountflags;
 
 unsigned long saved_videomode;
@@ -715,238 +714,213 @@ static inline void copy_edd(void)
 }
 #endif
 
-static void __init parse_cmdline_early (char ** cmdline_p)
-{
-	char c = ' ', *to = command_line, *from = saved_command_line;
-	int len = 0;
-	int userdef = 0;
-
-	/* Save unparsed command line copy for /proc/cmdline */
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+static int __initdata user_defined_memmap = 0;
 
-	for (;;) {
-		if (c != ' ')
-			goto next_char;
-		/*
-		 * "mem=nopentium" disables the 4MB page tables.
-		 * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
-		 * to <mem>, overriding the bios size.
-		 * "memmap=XXX[KkmM]@XXX[KkmM]" defines a memory region from
-		 * <start> to <start>+<mem>, overriding the bios size.
-		 *
-		 * HPA tells me bootloaders need to parse mem=, so no new
-		 * option should be mem=  [also see Documentation/i386/boot.txt]
+/*
+ * "mem=nopentium" disables the 4MB page tables.
+ * "mem=XXX[kKmM]" defines a memory region from HIGH_MEM
+ * to <mem>, overriding the bios size.
+ * "memmap=XXX[KkmM]@XXX[KkmM]" defines a memory region from
+ * <start> to <start>+<mem>, overriding the bios size.
+ *
+ * HPA tells me bootloaders need to parse mem=, so no new
+ * option should be mem=  [also see Documentation/i386/boot.txt]
+ */
+static int __init parse_mem(char *arg)
+{
+	if (strcmp(arg, "nopentium") == 0) {
+		clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
+		disable_pse = 1;
+	} else {
+		/* If the user specifies memory size, we
+		 * limit the BIOS-provided memory map to
+		 * that size. exactmap can be used to specify
+		 * the exact map. mem=number can be used to
+		 * trim the existing memory map.
 		 */
-		if (!memcmp(from, "mem=", 4)) {
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
+		unsigned long long mem_size;
  
-				mem_size = memparse(from+4, &from);
-				limit_regions(mem_size);
-				userdef=1;
-			}
-		}
+		mem_size = memparse(arg, &arg);
+		limit_regions(mem_size);
+		user_defined_memmap = 1;
+	}
+	return 0;
+}
+early_param("mem", parse_mem);
 
-		else if (!memcmp(from, "memmap=", 7)) {
-			if (to != command_line)
-				to--;
-			if (!memcmp(from+7, "exactmap", 8)) {
+static int __init parse_memmap(char *arg)
+{
+	if (strcmp(arg, "exactmap") == 0) {
 #ifdef CONFIG_CRASH_DUMP
-				/* If we are doing a crash dump, we
-				 * still need to know the real mem
-				 * size before original memory map is
-				 * reset.
-				 */
-				find_max_pfn();
-				saved_max_pfn = max_pfn;
+		/* If we are doing a crash dump, we
+		 * still need to know the real mem
+		 * size before original memory map is
+		 * reset.
+		 */
+		find_max_pfn();
+		saved_max_pfn = max_pfn;
 #endif
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
+		e820.nr_map = 0;
+		user_defined_memmap = 1;
+	} else {
+		/* If the user specifies memory size, we
+		 * limit the BIOS-provided memory map to
+		 * that size. exactmap can be used to specify
+		 * the exact map. mem=number can be used to
+		 * trim the existing memory map.
+		 */
+		unsigned long long start_at, mem_size;
  
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
+		mem_size = memparse(arg, &arg);
+		if (*arg == '@') {
+			start_at = memparse(arg+1, &arg);
+			add_memory_region(start_at, mem_size, E820_RAM);
+		} else if (*arg == '#') {
+			start_at = memparse(arg+1, &arg);
+			add_memory_region(start_at, mem_size, E820_ACPI);
+		} else if (*arg == '$') {
+			start_at = memparse(arg+1, &arg);
+			add_memory_region(start_at, mem_size, E820_RESERVED);
+		} else {
+			limit_regions(mem_size);
+			user_defined_memmap = 1;
 		}
+	}
+	return 0;
+}
+early_param("memmap", parse_memmap);
 
-		else if (!memcmp(from, "noexec=", 7))
-			noexec_setup(from + 7);
-
-
-#ifdef  CONFIG_X86_SMP
-		/*
-		 * If the BIOS enumerates physical processors before logical,
-		 * maxcpus=N at enumeration-time can be used to disable HT.
-		 */
-		else if (!memcmp(from, "maxcpus=", 8)) {
-			extern unsigned int maxcpus;
+#ifdef CONFIG_X86_SMP
+/*
+ * If the BIOS enumerates physical processors before logical,
+ * maxcpus=N at enumeration-time can be used to disable HT.
+ */
+static int __init parse_maxcpus(char *arg)
+{
+	extern unsigned int maxcpus;
 
-			maxcpus = simple_strtoul(from + 8, NULL, 0);
-		}
+	maxcpus = simple_strtoul(arg, NULL, 0);
+	return 0;
+}
+early_param("maxcpus", parse_maxcpus);
 #endif
 
 #ifdef CONFIG_ACPI
-		/* "acpi=off" disables both ACPI table parsing and interpreter */
-		else if (!memcmp(from, "acpi=off", 8)) {
+static int __init parse_acpi(char *arg)
+{
+	/* "acpi=off" disables both ACPI table parsing and interpreter */
+	if (strcmp(arg, "off") == 0) {
+		disable_acpi();
+	} 
+	/* acpi=force to over-ride black-list */
+	else if (strcmp(arg, "force") == 0) {
+		acpi_force = 1;
+		acpi_ht = 1;
+		acpi_disabled = 0;
+	}
+	/* acpi=strict disables out-of-spec workarounds */
+	else if (strcmp(arg, "strict") == 0) {
+		acpi_strict = 1;
+	}
+	/* Limit ACPI just to boot-time to enable HT */
+	else if (strcmp(arg, "ht") == 0) {
+		if (!acpi_force)
 			disable_acpi();
-		}
-
-		/* acpi=force to over-ride black-list */
-		else if (!memcmp(from, "acpi=force", 10)) {
-			acpi_force = 1;
-			acpi_ht = 1;
-			acpi_disabled = 0;
-		}
-
-		/* acpi=strict disables out-of-spec workarounds */
-		else if (!memcmp(from, "acpi=strict", 11)) {
-			acpi_strict = 1;
-		}
-
-		/* Limit ACPI just to boot-time to enable HT */
-		else if (!memcmp(from, "acpi=ht", 7)) {
-			if (!acpi_force)
-				disable_acpi();
-			acpi_ht = 1;
-		}
-		
-		/* "pci=noacpi" disable ACPI IRQ routing and PCI scan */
-		else if (!memcmp(from, "pci=noacpi", 10)) {
-			acpi_disable_pci();
-		}
-		/* "acpi=noirq" disables ACPI interrupt routing */
-		else if (!memcmp(from, "acpi=noirq", 10)) {
-			acpi_noirq_set();
-		}
-
-		else if (!memcmp(from, "acpi_sci=edge", 13))
-			acpi_sci_flags.trigger =  1;
-
-		else if (!memcmp(from, "acpi_sci=level", 14))
-			acpi_sci_flags.trigger = 3;
-
-		else if (!memcmp(from, "acpi_sci=high", 13))
-			acpi_sci_flags.polarity = 1;
-
-		else if (!memcmp(from, "acpi_sci=low", 12))
-			acpi_sci_flags.polarity = 3;
+		acpi_ht = 1;
+	}
+	/* "acpi=noirq" disables ACPI interrupt routing */
+	else if (strcmp(arg, "noirq") == 0) {
+		acpi_noirq_set();
+	} else {
+		/* Core will printk when we return error. */
+		return -EINVAL;
+	}
+	return 0;
+}
+early_param("acpi", parse_acpi);
 
 #ifdef CONFIG_X86_IO_APIC
-		else if (!memcmp(from, "acpi_skip_timer_override", 24))
-			acpi_skip_timer_override = 1;
+static int __init parse_acpi_skip_timer_override(char *arg)
+{
+	acpi_skip_timer_override = 1;
+	return 0;
+}
+early_param("acpi_skip_timer_override", parse_acpi_skip_timer_override);
 
-		if (!memcmp(from, "disable_timer_pin_1", 19))
-			disable_timer_pin_1 = 1;
-		if (!memcmp(from, "enable_timer_pin_1", 18))
-			disable_timer_pin_1 = -1;
+static int __init parse_disable_timer_pin_1(char *arg)
+{
+	disable_timer_pin_1 = 1;
+	return 0;
+}
+early_param("disable_timer_pin_1", parse_disable_timer_pin_1);
 
-		/* disable IO-APIC */
-		else if (!memcmp(from, "noapic", 6))
-			disable_ioapic_setup();
+static int __init parse_enable_timer_pin_1(char *arg)
+{
+	disable_timer_pin_1 = -1;
+	return 0;
+}
+early_param("enable_timer_pin_1", parse_enable_timer_pin_1);
+
+static int __init parse_noapic(char *arg)
+{
+	/* disable IO-APIC */
+	disable_ioapic_setup();
+	return 0;
+}
+early_param("noapic", parse_noapic);
 #endif /* CONFIG_X86_IO_APIC */
 #endif /* CONFIG_ACPI */
 
 #ifdef CONFIG_X86_LOCAL_APIC
-		/* enable local APIC */
-		else if (!memcmp(from, "lapic", 5))
-			lapic_enable();
-
-		/* disable local APIC */
-		else if (!memcmp(from, "nolapic", 6))
-			lapic_disable();
+static int __init parse_lapic(char *arg)
+{
+	lapic_enable();
+	return 0;
+}
+early_param("lapic", parse_lapic);
+static int __init parse_nolapic(char *arg)
+{
+	lapic_disable();
+	return 0;
+}
+early_param("nolapic", parse_nolapic);
 #endif /* CONFIG_X86_LOCAL_APIC */
 
-#ifdef CONFIG_KEXEC
-		/* crashkernel=size@addr specifies the location to reserve for
-		 * a crash kernel.  By reserving this memory we guarantee
-		 * that linux never set's it up as a DMA target.
-		 * Useful for holding code to do something appropriate
-		 * after a kernel panic.
-		 */
-		else if (!memcmp(from, "crashkernel=", 12)) {
-			unsigned long size, base;
-			size = memparse(from+12, &from);
-			if (*from == '@') {
-				base = memparse(from+1, &from);
-				/* FIXME: Do I want a sanity check
-				 * to validate the memory range?
-				 */
-				crashk_res.start = base;
-				crashk_res.end   = base + size - 1;
-			}
-		}
-#endif
 #ifdef CONFIG_PROC_VMCORE
-		/* elfcorehdr= specifies the location of elf core header
-		 * stored by the crashed kernel.
-		 */
-		else if (!memcmp(from, "elfcorehdr=", 11))
-			elfcorehdr_addr = memparse(from+11, &from);
-#endif
+/* elfcorehdr= specifies the location of elf core header
+ * stored by the crashed kernel.
+ */
+static int __init parse_elfcorehdr(char *arg)
+{
+	elfcorehdr_addr = memparse(arg, &arg);
+	return 0;
+}
+early_param("elfcorehdr", parse_elfcorehdr);
+#endif /* CONFIG_PROC_VMCORE */
 
-		/*
-		 * highmem=size forces highmem to be exactly 'size' bytes.
-		 * This works even on boxes that have no highmem otherwise.
-		 * This also works to reduce highmem size on bigger boxes.
-		 */
-		else if (!memcmp(from, "highmem=", 8))
-			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
-	
-		/*
-		 * vmalloc=size forces the vmalloc area to be exactly 'size'
-		 * bytes. This can be used to increase (or decrease) the
-		 * vmalloc area - the default is 128m.
-		 */
-		else if (!memcmp(from, "vmalloc=", 8))
-			__VMALLOC_RESERVE = memparse(from+8, &from);
+/*
+ * highmem=size forces highmem to be exactly 'size' bytes.
+ * This works even on boxes that have no highmem otherwise.
+ * This also works to reduce highmem size on bigger boxes.
+ */
+static int __init parse_highmem(char *arg)
+{
+	highmem_pages = memparse(arg, &arg) >> PAGE_SHIFT;
+	return 0;
+}
+early_param("highmem", parse_highmem);
 
-	next_char:
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
+ * vmalloc=size forces the vmalloc area to be exactly 'size'
+ * bytes. This can be used to increase (or decrease) the
+ * vmalloc area - the default is 128m.
+ */
+static int __init parse_vmalloc(char *arg)
+{
+	__VMALLOC_RESERVE = memparse(arg, &arg);
+	return 0;
 }
+early_param("vmalloc", parse_vmalloc);
 
 /*
  * Callback for efi_memory_walk.
@@ -1578,17 +1552,23 @@ void __init setup_arch(char **cmdline_p)
 	data_resource.start = virt_to_phys(_etext);
 	data_resource.end = virt_to_phys(_edata)-1;
 
-	parse_cmdline_early(cmdline_p);
-
-#ifdef CONFIG_EARLY_PRINTK
-	{
-		char *s = strstr(*cmdline_p, "earlyprintk=");
-		if (s) {
-			setup_early_printk(strchr(s, '=') + 1);
-			printk("early console enabled\n");
-		}
+#ifdef CONFIG_ACPI
+	/* FIXME: This is a hack, but early_param("pci") would risk
+	 * overriding drivers/pci/pci.c's __setup("pci="). */
+	/* "pci=noacpi" disable ACPI IRQ routing and PCI scan */
+	if (strstr(saved_command_line, "pci=noacpi")) {
+		acpi_disable_pci();
 	}
 #endif
+	parse_early_param();
+
+	if (user_defined_memmap) {
+		printk(KERN_INFO "user-defined physical RAM map:\n");
+		print_memory_map("user");
+	}
+
+	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
 
 	max_low_pfn = setup_memory();
 
@@ -1617,7 +1597,7 @@ void __init setup_arch(char **cmdline_p)
 	dmi_scan_machine();
 
 #ifdef CONFIG_X86_GENERICARCH
-	generic_apic_probe(*cmdline_p);
+	generic_apic_probe();
 #endif	
 	if (efi_enabled)
 		efi_map_memmap();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/arch/i386/mach-generic/probe.c working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/mach-generic/probe.c
--- linux-2.6.18-rc2-mm1/arch/i386/mach-generic/probe.c	2006-08-01 14:11:48.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/mach-generic/probe.c	2006-08-02 13:43:59.000000000 +1000
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 #include <asm/fixmap.h>
 #include <asm/mpspec.h>
 #include <asm/apicdef.h>
@@ -29,7 +30,21 @@ struct genapic *apic_probe[] __initdata 
 	NULL,
 };
 
-static int cmdline_apic;
+static int cmdline_apic __initdata;
+static int __init parse_apic(char *arg)
+{
+	int i;
+
+	for (i = 0; apic_probe[i]; i++) {
+		if (!strcmp(apic_probe[i]->name, arg)) { 
+			genapic = apic_probe[i];
+			cmdline_apic = 1;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+early_param("apic", parse_apic);
 
 void __init generic_bigsmp_probe(void)
 {
@@ -48,40 +63,20 @@ void __init generic_bigsmp_probe(void)
 		}
 }
 
-void __init generic_apic_probe(char *command_line) 
+void __init generic_apic_probe(void) 
 { 
-	char *s;
-	int i;
-	int changed = 0;
-
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
+	if (!cmdline_apic) {
+		int i;
+		for (i = 0; apic_probe[i]; i++) { 
+			if (apic_probe[i]->probe()) {
 				genapic = apic_probe[i];
+				break;
 			}
 		}
-		if (!changed)
-			printk(KERN_ERR "Unknown genapic `%s' specified.\n", s);
-		*p = old;
-		cmdline_apic = changed;
-	} 
-	for (i = 0; !changed && apic_probe[i]; i++) { 
-		if (apic_probe[i]->probe()) {
-			changed = 1;
-			genapic = apic_probe[i]; 
-		} 
+		/* Not visible without early console */ 
+		if (!apic_probe[i])
+			panic("Didn't find an APIC driver"); 
 	}
-	/* Not visible without early console */ 
-	if (!changed) 
-		panic("Didn't find an APIC driver"); 
-
 	printk(KERN_INFO "Using APIC driver %s\n", genapic->name);
 } 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/arch/i386/mm/init.c working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/mm/init.c
--- linux-2.6.18-rc2-mm1/arch/i386/mm/init.c	2006-08-01 14:11:48.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/arch/i386/mm/init.c	2006-08-02 11:01:22.000000000 +1000
@@ -435,7 +435,7 @@ u64 __supported_pte_mask __read_mostly =
  * on      Enable
  * off     Disable
  */
-void __init noexec_setup(const char *str)
+static int __init noexec_setup(char *str)
 {
 	if (!strncmp(str, "on",2) && cpu_has_nx) {
 		__supported_pte_mask |= _PAGE_NX;
@@ -444,7 +444,9 @@ void __init noexec_setup(const char *str
 		disable_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
 	}
+	return 0;
 }
+early_param("noexec", noexec_setup);
 
 int nx_enabled = 0;
 #ifdef CONFIG_X86_PAE
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/include/asm-i386/apic.h working-2.6.18-rc2-mm1-i386-parse_early_param/include/asm-i386/apic.h
--- linux-2.6.18-rc2-mm1/include/asm-i386/apic.h	2006-07-21 20:27:58.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/include/asm-i386/apic.h	2006-08-02 13:43:42.000000000 +1000
@@ -42,6 +42,8 @@ static inline void lapic_enable(void)
 	} while (0)
 
 
+extern void generic_apic_probe(void);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.18-rc2-mm1/include/asm-i386/pgtable.h working-2.6.18-rc2-mm1-i386-parse_early_param/include/asm-i386/pgtable.h
--- linux-2.6.18-rc2-mm1/include/asm-i386/pgtable.h	2006-07-27 16:00:56.000000000 +1000
+++ working-2.6.18-rc2-mm1-i386-parse_early_param/include/asm-i386/pgtable.h	2006-08-02 11:02:33.000000000 +1000
@@ -391,8 +391,6 @@ extern pte_t *lookup_address(unsigned lo
  static inline int set_kernel_exec(unsigned long vaddr, int enable) { return 0;}
 #endif
 
-extern void noexec_setup(const char *str);
-
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))

-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

