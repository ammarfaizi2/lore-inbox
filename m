Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQLTJtJ>; Wed, 20 Dec 2000 04:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQLTJs7>; Wed, 20 Dec 2000 04:48:59 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:29075 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129823AbQLTJsq>; Wed, 20 Dec 2000 04:48:46 -0500
Date: Wed, 20 Dec 2000 01:14:56 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Cc: acme@conectiva.com.br, acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: [Acpi] 2.4.0-test13pre3 acpi circular dependency
Message-ID: <20001220011456.A29289@baldur.yggdrasil.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE54A@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE54A@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Tue, Dec 19, 2000 at 06:00:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	The following fixes a circular depency problem between
drivers/acpi/ and arch/{i386,ia64}/kernel/acpi.c.  I think the
problem only occurs if you manually tweak the build to make
acpi.o as a module, but it still should be fixed.  This patch
also fixes the Makefiles in drivers/acpi so that they do not
blow up if you try to build drivers/acpi as a module (these
are corrections to some variable names, not a new functional
addition to the Makefiles).

	I have deliberately not included the patch to change
CONFIG_ACPI into a tristate because I wonder if there is some problem
with acpi.o as a module that I am not aware of that is the reason
that CONFIG_ACPI in the stock kernels is configured as a boolean, even
though there is module initialization code in drivers/acpi, that seems
to work just fine, at least for my purposes of deactivating the
power after a shutdown.  Does anybody know if there some known problem
with acpi.o as a module?

	I have attached my kernel patch below.  If this meets with
no obections, can somebody bless this and "send" it to Linus for
integration?

On Tue, Dec 19, 2000 at 06:00:15PM -0800, Grover, Andrew wrote:
> I'm thinking arch/i386/kernel/acpi.c should just go away, yes?
> 
> Its purpose is probably better served by an ifdef, like you mentioned.
[...]
> > From: Adam J. Richter [mailto:adam@yggdrasil.com]
> > 
> > 	Although the stock linux-2.4.0-test13pre3 does not allow
> > one to build the acpi interpreter as a loadable module, I had
> > tweaked the Makefiles in previous kernels to do this (the supporting
> > code is there and it seemed to work, at least for shutting off the
> > power after a shutdown).  Unfortunately, in 2.4.0-test13pre3, this
> > is no harder to do, because there is a circular dependency:
> > 
> > drivers/acpi/ references acpi_get_rsdp_ptr in arch/i386/kernel/acpi.c,
> > 				and
> > arch/i386/kernel/acpi.c references acp_find_root_pointer in 
> > drivers/acpi/.
> > 
> > 
> > 	I would like to recommend that the contents of
> > arch/i{386,a64}/kernel/acpi.c be merged back somewhere in 
> > drivers/acpi/,
> > and just selected with Makefile options, ifdefs, or perhaps runtime
> > options (if the ia64 code is potentionally useable to an i386 kernel
> > that find itself running on an ia64 CPU, which will probably 
> > be the case
> > with most Linux distributions initially installed on ia64 hardware).
> > 
> > 	If need be, I would be willing to at least write a quick and
> > dirty #ifdef-based version of this proposed change.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi.diffs"

diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/Makefile linux/drivers/acpi/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/Makefile	Wed Dec 20 00:03:27 2000
@@ -3,6 +3,7 @@
 #
 
 O_TARGET := acpi.o
+obj-m := $(O_TARGET)
 
 export-objs := ksyms.o
 
@@ -25,13 +26,23 @@
 
 subdir-$(CONFIG_ACPI) += $(acpi-subdirs)
 
-obj-$(CONFIG_ACPI) := $(patsubst %,%.o,$(acpi-subdirs))
-obj-$(CONFIG_ACPI) += os.o ksyms.o
+obj-y := $(patsubst %,%.o,$(acpi-subdirs))
+obj-y += os.o ksyms.o
+
+$(patsubst %,%.o,$(acpi-subdirs)):
+	$(MAKE) $(MFLAGS) -C $$(basename $@ .o) ../$@
 
 ifdef CONFIG_ACPI_KERNEL_CONFIG
-  obj-$(CONFIG_ACPI) += acpiconf.o osconf.o
+  obj-y += acpiconf.o osconf.o
 else
-  obj-$(CONFIG_ACPI) += driver.o cmbatt.o cpu.o ec.o ksyms.o sys.o table.o
+  obj-y += driver.o cmbatt.o cpu.o ec.o ksyms.o sys.o table.o
+endif
+
+ifdef CONFIG_X86
+  obj-y += rsdp_x86.o
+endif
+ifdef CONFIG_IA64
+  obj-y += rsdp_ia64.o
 endif
 
 include $(TOPDIR)/Rules.make
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/common/Makefile linux/drivers/acpi/common/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/common/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/common/Makefile	Tue Dec 19 08:58:42 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/dispatcher/Makefile linux/drivers/acpi/dispatcher/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/dispatcher/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/dispatcher/Makefile	Tue Dec 19 08:58:42 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/events/Makefile linux/drivers/acpi/events/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/events/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/events/Makefile	Tue Dec 19 08:58:42 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/hardware/Makefile linux/drivers/acpi/hardware/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/hardware/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/hardware/Makefile	Tue Dec 19 08:58:42 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/interpreter/Makefile linux/drivers/acpi/interpreter/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/interpreter/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/interpreter/Makefile	Tue Dec 19 08:58:42 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/ksyms.c linux/drivers/acpi/ksyms.c
--- linux-2.4.0-test13-pre3/drivers/acpi/ksyms.c	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/ksyms.c	Tue Dec 19 09:58:21 2000
@@ -90,3 +90,5 @@
 EXPORT_SYMBOL(acpi_get_processor_cx_info);
 EXPORT_SYMBOL(acpi_set_processor_sleep_state);
 EXPORT_SYMBOL(acpi_processor_sleep);
+
+EXPORT_SYMBOL(acpi_find_root_pointer);
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/namespace/Makefile linux/drivers/acpi/namespace/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/namespace/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/namespace/Makefile	Tue Dec 19 08:58:42 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/parser/Makefile linux/drivers/acpi/parser/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/parser/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/parser/Makefile	Tue Dec 19 08:58:43 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/resources/Makefile linux/drivers/acpi/resources/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/resources/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/resources/Makefile	Tue Dec 19 08:58:43 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/rsdp_ia64.c linux/drivers/acpi/rsdp_ia64.c
--- linux-2.4.0-test13-pre3/drivers/acpi/rsdp_ia64.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/acpi/rsdp_ia64.c	Wed Dec 20 00:03:28 2000
@@ -0,0 +1,289 @@
+/*
+ * Advanced Configuration and Power Interface 
+ *
+ * Based on 'ACPI Specification 1.0b' February 2, 1999 and 
+ * 'IA-64 Extensions to ACPI Specification' Revision 0.6
+ * 
+ * Copyright (C) 1999 VA Linux Systems
+ * Copyright (C) 1999,2000 Walt Drummond <drummond@valinux.com>
+ */
+
+#include <linux/config.h>
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/irq.h>
+
+#include <asm/acpi-ext.h>
+#include <asm/efi.h>
+#include <asm/io.h>
+#include <asm/iosapic.h>
+#include <asm/machvec.h>
+#include <asm/page.h>
+#ifdef CONFIG_ACPI_KERNEL_CONFIG
+# include <asm/acpikcfg.h>
+#endif
+
+#undef ACPI_DEBUG		/* Guess what this does? */
+
+/* These are ugly but will be reclaimed by the kernel */
+int __initdata available_cpus;
+int __initdata total_cpus;
+
+void (*pm_idle)(void);
+
+/*
+ * Identify usable CPU's and remember them for SMP bringup later.
+ */
+static void __init
+acpi_lsapic(char *p) 
+{
+	int add = 1;
+
+	acpi_entry_lsapic_t *lsapic = (acpi_entry_lsapic_t *) p;
+
+	if ((lsapic->flags & LSAPIC_PRESENT) == 0) 
+		return;
+
+	printk("      CPU %d (%.04x:%.04x): ", total_cpus, lsapic->eid, lsapic->id);
+
+	if ((lsapic->flags & LSAPIC_ENABLED) == 0) {
+		printk("Disabled.\n");
+		add = 0;
+	} else if (lsapic->flags & LSAPIC_PERFORMANCE_RESTRICTED) {
+		printk("Performance Restricted; ignoring.\n");
+		add = 0;
+	}
+	
+#ifdef CONFIG_SMP
+	smp_boot_data.cpu_phys_id[total_cpus] = -1;
+#endif
+	if (add) {
+		printk("Available.\n");
+		available_cpus++;
+#ifdef CONFIG_SMP
+		smp_boot_data.cpu_phys_id[total_cpus] = (lsapic->id << 8) | lsapic->eid;
+#endif /* CONFIG_SMP */
+	}
+	total_cpus++;
+}
+
+/*
+ * Configure legacy IRQ information in iosapic_vector
+ */
+static void __init
+acpi_legacy_irq(char *p)
+{
+	/*
+	 * This is not good.  ACPI is not necessarily limited to CONFIG_IA64_DIG, yet
+	 * ACPI does not necessarily imply IOSAPIC either.  Perhaps there should be
+	 * a means for platform_setup() to register ACPI handlers?
+	 */
+#ifdef CONFIG_IA64_IRQ_ACPI
+	acpi_entry_int_override_t *legacy = (acpi_entry_int_override_t *) p;
+	unsigned char vector; 
+	int i;
+
+	vector = isa_irq_to_vector(legacy->isa_irq);
+
+	/*
+	 * Clobber any old pin mapping.  It may be that it gets replaced later on
+	 */
+	for (i = 0; i < IA64_MAX_VECTORED_IRQ; i++) {
+		if (i == vector) 
+			continue;
+		if (iosapic_pin(i) == iosapic_pin(vector))
+			iosapic_pin(i) = 0xff;
+        }
+
+	iosapic_pin(vector) = legacy->pin;
+	iosapic_bus(vector) = BUS_ISA;	/* This table only overrides the ISA devices */
+	iosapic_busdata(vector) = 0;
+	
+	/* 
+	 * External timer tick is special... 
+	 */
+	if (vector != TIMER_IRQ)
+		iosapic_dmode(vector) = IO_SAPIC_LOWEST_PRIORITY;
+	else 
+		iosapic_dmode(vector) = IO_SAPIC_FIXED;
+	
+	/* See MPS 1.4 section 4.3.4 */
+	switch (legacy->flags) {
+	case 0x5:
+		iosapic_polarity(vector) = IO_SAPIC_POL_HIGH;
+		iosapic_trigger(vector) = IO_SAPIC_EDGE;
+		break;
+	case 0x8:
+		iosapic_polarity(vector) = IO_SAPIC_POL_LOW;
+		iosapic_trigger(vector) = IO_SAPIC_EDGE;
+		break;
+	case 0xd:
+		iosapic_polarity(vector) = IO_SAPIC_POL_HIGH;
+		iosapic_trigger(vector) = IO_SAPIC_LEVEL;
+		break;
+	case 0xf:
+		iosapic_polarity(vector) = IO_SAPIC_POL_LOW;
+		iosapic_trigger(vector) = IO_SAPIC_LEVEL;
+		break;
+	default:
+		printk("    ACPI Legacy IRQ 0x%02x: Unknown flags 0x%x\n", legacy->isa_irq,
+		       legacy->flags);
+		break;
+	}
+
+# ifdef ACPI_DEBUG
+	printk("Legacy ISA IRQ %x -> IA64 Vector %x IOSAPIC Pin %x Active %s %s Trigger\n", 
+	       legacy->isa_irq, vector, iosapic_pin(vector), 
+	       ((iosapic_polarity(vector) == IO_SAPIC_POL_LOW) ? "Low" : "High"),
+	       ((iosapic_trigger(vector) == IO_SAPIC_LEVEL) ? "Level" : "Edge"));
+# endif /* ACPI_DEBUG */
+#endif /* CONFIG_IA64_IRQ_ACPI */
+}
+
+/*
+ * Info on platform interrupt sources: NMI. PMI, INIT, etc.
+ */
+static void __init
+acpi_platform(char *p)
+{
+	acpi_entry_platform_src_t *plat = (acpi_entry_platform_src_t *) p;
+
+	printk("PLATFORM: IOSAPIC %x -> Vector %lx on CPU %.04u:%.04u\n",
+	       plat->iosapic_vector, plat->global_vector, plat->eid, plat->id);
+}
+
+/*
+ * Parse the ACPI Multiple SAPIC Table
+ */
+static void __init
+acpi_parse_msapic(acpi_sapic_t *msapic)
+{
+	char *p, *end;
+
+	/* Base address of IPI Message Block */
+	ipi_base_addr = (unsigned long) ioremap(msapic->interrupt_block, 0);
+
+	p = (char *) (msapic + 1);
+	end = p + (msapic->header.length - sizeof(acpi_sapic_t));
+
+	while (p < end) {
+		
+		switch (*p) {
+		case ACPI_ENTRY_LOCAL_SAPIC:
+			acpi_lsapic(p);
+			break;
+	
+		case ACPI_ENTRY_IO_SAPIC:
+			platform_register_iosapic((acpi_entry_iosapic_t *) p);
+			break;
+
+		case ACPI_ENTRY_INT_SRC_OVERRIDE:
+			acpi_legacy_irq(p);
+			break;
+		
+		case ACPI_ENTRY_PLATFORM_INT_SOURCE:
+			acpi_platform(p);
+			break;
+		
+		default:
+			break;
+		}
+
+		/* Move to next table entry. */
+#define BAD_ACPI_TABLE
+#ifdef BAD_ACPI_TABLE
+		/*
+		 * Some prototype Lion's have a bad ACPI table
+		 * requiring this fix.  Without this fix, those
+		 * machines crash during bootup.
+		 */
+		if (p[1] == 0)
+			p = end;
+		else
+#endif
+			p += p[1];
+	}
+
+	/* Make bootup pretty */
+	printk("      %d CPUs available, %d CPUs total\n", available_cpus, total_cpus);
+}
+
+int __init 
+acpi_parse(acpi_rsdp_t *rsdp)
+{
+	acpi_rsdt_t *rsdt;
+	acpi_desc_table_hdr_t *hdrp;
+	long tables, i;
+
+	if (!rsdp) {
+		printk("Uh-oh, no ACPI Root System Description Pointer table!\n");
+		return 0;
+	}
+
+	if (strncmp(rsdp->signature, ACPI_RSDP_SIG, ACPI_RSDP_SIG_LEN)) {
+		printk("Uh-oh, ACPI RSDP signature incorrect!\n");
+		return 0;
+	}
+
+	rsdp->rsdt = __va(rsdp->rsdt);
+	rsdt = rsdp->rsdt;
+	if (strncmp(rsdt->header.signature, ACPI_RSDT_SIG, ACPI_RSDT_SIG_LEN)) {
+		printk("Uh-oh, ACPI RDST signature incorrect!\n");
+		return 0;
+	}
+
+	printk("ACPI: %.6s %.8s %d.%d\n", rsdt->header.oem_id, rsdt->header.oem_table_id, 
+	       rsdt->header.oem_revision >> 16, rsdt->header.oem_revision & 0xffff);
+	
+#ifdef CONFIG_ACPI_KERNEL_CONFIG
+	acpi_cf_init(rsdp);
+#endif
+
+	tables = (rsdt->header.length - sizeof(acpi_desc_table_hdr_t)) / 8;
+	for (i = 0; i < tables; i++) {
+		hdrp = (acpi_desc_table_hdr_t *) __va(rsdt->entry_ptrs[i]);
+
+		/* Only interested int the MSAPIC table for now ... */
+		if (strncmp(hdrp->signature, ACPI_SAPIC_SIG, ACPI_SAPIC_SIG_LEN) != 0)
+			continue;
+
+		acpi_parse_msapic((acpi_sapic_t *) hdrp);
+	}
+
+#ifdef CONFIG_ACPI_KERNEL_CONFIG
+       acpi_cf_terminate();
+#endif
+
+#ifdef CONFIG_SMP
+	if (available_cpus == 0) {
+		printk("ACPI: Found 0 CPUS; assuming 1\n");
+		available_cpus = 1; /* We've got at least one of these, no? */
+	}
+	smp_boot_data.cpu_count = available_cpus;
+#endif
+	return 1;
+}
+
+const char *
+acpi_get_sysname (void)
+{       
+	/* the following should go away once we have an ACPI parser: */
+#ifdef CONFIG_IA64_GENERIC
+	return "hpsim";
+#else
+# if defined (CONFIG_IA64_HP_SIM)
+	return "hpsim";
+# elif defined (CONFIG_IA64_SGI_SN1)
+	return "sn1";
+# elif defined (CONFIG_IA64_DIG)
+	return "dig";
+# else
+#	error Unknown platform.  Fix acpi.c.
+# endif
+#endif
+}
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/rsdp_x86.c linux/drivers/acpi/rsdp_x86.c
--- linux-2.4.0-test13-pre3/drivers/acpi/rsdp_x86.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/acpi/rsdp_x86.c	Wed Dec 20 00:03:28 2000
@@ -0,0 +1,53 @@
+/*
+ *  acpi.c - Linux ACPI arch-specific functions
+ *
+ *  Copyright (C) 1999-2000 Andrew Henroid
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * Changes:
+ * Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 2000/08/31
+ * - check copy*user return
+ * - get rid of check_region
+ * - get rid of verify_area
+ * Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 2000/09/28
+ * - do proper release on failure in acpi_claim_ioports and acpi_init
+ * Andrew Grover <andrew.grover@intel.com> - 2000/11/13
+ * - Took out support for user-level interpreter. ACPI 2.0 changes preclude
+ *   its maintenance.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+
+#define _LINUX
+#include <linux/acpi.h>
+/* Is there a better way to include this? */
+#include <../drivers/acpi/include/acpi.h>
+
+ACPI_PHYSICAL_ADDRESS
+acpi_get_rsdp_ptr()
+{
+	ACPI_PHYSICAL_ADDRESS rsdp_phys;
+
+	if(ACPI_SUCCESS(acpi_find_root_pointer(&rsdp_phys)))
+		return rsdp_phys;
+	else
+		return 0;
+}
diff --new-file -r -u linux-2.4.0-test13-pre3/drivers/acpi/tables/Makefile linux/drivers/acpi/tables/Makefile
--- linux-2.4.0-test13-pre3/drivers/acpi/tables/Makefile	Wed Dec 20 00:49:37 2000
+++ linux/drivers/acpi/tables/Makefile	Tue Dec 19 08:58:43 2000
@@ -4,7 +4,7 @@
 
 O_TARGET := ../$(shell basename `pwd`).o
 
-obj-$(CONFIG_ACPI) := $(patsubst %.c,%.o,$(wildcard *.c))
+obj-y := $(patsubst %.c,%.o,$(wildcard *.c))
 
 EXTRA_CFLAGS += -I../include
 
--- linux-2.4.0-test13-pre3/arch/i386/kernel/Makefile	Wed Dec 20 00:49:36 2000
+++ linux/arch/i386/kernel/Makefile	Wed Dec 20 00:03:27 2000
@@ -40,6 +40,5 @@
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
-obj-$(CONFIG_ACPI)	+= acpi.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4.0-test13-pre3/arch/ia64/kernel/Makefile	Mon Oct  9 17:54:53 2000
+++ linux/arch/ia64/kernel/Makefile	Wed Dec 20 00:52:33 2000
@@ -9,7 +9,7 @@
 
 all: kernel.o head.o init_task.o
 
-obj-y := acpi.o entry.o gate.o efi.o efi_stub.o irq.o irq_ia64.o irq_sapic.o ivt.o		\
+obj-y := entry.o gate.o efi.o efi_stub.o irq.o irq_ia64.o irq_sapic.o ivt.o		\
 	 machvec.o pal.o pci-dma.o process.o perfmon.o ptrace.o sal.o semaphore.o setup.o	\
 	 signal.o sys_ia64.o traps.o time.o unaligned.o unwind.o
 
--- linux-2.4.0-test13-pre3/arch/i386/kernel/acpi.c	Wed Dec 20 00:49:36 2000
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,53 +0,0 @@
-/*
- *  acpi.c - Linux ACPI arch-specific functions
- *
- *  Copyright (C) 1999-2000 Andrew Henroid
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * Changes:
- * Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 2000/08/31
- * - check copy*user return
- * - get rid of check_region
- * - get rid of verify_area
- * Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 2000/09/28
- * - do proper release on failure in acpi_claim_ioports and acpi_init
- * Andrew Grover <andrew.grover@intel.com> - 2000/11/13
- * - Took out support for user-level interpreter. ACPI 2.0 changes preclude
- *   its maintenance.
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pm.h>
-
-#define _LINUX
-#include <linux/acpi.h>
-/* Is there a better way to include this? */
-#include <../drivers/acpi/include/acpi.h>
-
-ACPI_PHYSICAL_ADDRESS
-acpi_get_rsdp_ptr()
-{
-	ACPI_PHYSICAL_ADDRESS rsdp_phys;
-
-	if(ACPI_SUCCESS(acpi_find_root_pointer(&rsdp_phys)))
-		return rsdp_phys;
-	else
-		return 0;
-}
--- linux-2.4.0-test13-pre3/arch/ia64/kernel/acpi.c	Mon Oct  9 17:54:53 2000
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,289 +0,0 @@
-/*
- * Advanced Configuration and Power Interface 
- *
- * Based on 'ACPI Specification 1.0b' February 2, 1999 and 
- * 'IA-64 Extensions to ACPI Specification' Revision 0.6
- * 
- * Copyright (C) 1999 VA Linux Systems
- * Copyright (C) 1999,2000 Walt Drummond <drummond@valinux.com>
- */
-
-#include <linux/config.h>
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/irq.h>
-
-#include <asm/acpi-ext.h>
-#include <asm/efi.h>
-#include <asm/io.h>
-#include <asm/iosapic.h>
-#include <asm/machvec.h>
-#include <asm/page.h>
-#ifdef CONFIG_ACPI_KERNEL_CONFIG
-# include <asm/acpikcfg.h>
-#endif
-
-#undef ACPI_DEBUG		/* Guess what this does? */
-
-/* These are ugly but will be reclaimed by the kernel */
-int __initdata available_cpus;
-int __initdata total_cpus;
-
-void (*pm_idle)(void);
-
-/*
- * Identify usable CPU's and remember them for SMP bringup later.
- */
-static void __init
-acpi_lsapic(char *p) 
-{
-	int add = 1;
-
-	acpi_entry_lsapic_t *lsapic = (acpi_entry_lsapic_t *) p;
-
-	if ((lsapic->flags & LSAPIC_PRESENT) == 0) 
-		return;
-
-	printk("      CPU %d (%.04x:%.04x): ", total_cpus, lsapic->eid, lsapic->id);
-
-	if ((lsapic->flags & LSAPIC_ENABLED) == 0) {
-		printk("Disabled.\n");
-		add = 0;
-	} else if (lsapic->flags & LSAPIC_PERFORMANCE_RESTRICTED) {
-		printk("Performance Restricted; ignoring.\n");
-		add = 0;
-	}
-	
-#ifdef CONFIG_SMP
-	smp_boot_data.cpu_phys_id[total_cpus] = -1;
-#endif
-	if (add) {
-		printk("Available.\n");
-		available_cpus++;
-#ifdef CONFIG_SMP
-		smp_boot_data.cpu_phys_id[total_cpus] = (lsapic->id << 8) | lsapic->eid;
-#endif /* CONFIG_SMP */
-	}
-	total_cpus++;
-}
-
-/*
- * Configure legacy IRQ information in iosapic_vector
- */
-static void __init
-acpi_legacy_irq(char *p)
-{
-	/*
-	 * This is not good.  ACPI is not necessarily limited to CONFIG_IA64_DIG, yet
-	 * ACPI does not necessarily imply IOSAPIC either.  Perhaps there should be
-	 * a means for platform_setup() to register ACPI handlers?
-	 */
-#ifdef CONFIG_IA64_IRQ_ACPI
-	acpi_entry_int_override_t *legacy = (acpi_entry_int_override_t *) p;
-	unsigned char vector; 
-	int i;
-
-	vector = isa_irq_to_vector(legacy->isa_irq);
-
-	/*
-	 * Clobber any old pin mapping.  It may be that it gets replaced later on
-	 */
-	for (i = 0; i < IA64_MAX_VECTORED_IRQ; i++) {
-		if (i == vector) 
-			continue;
-		if (iosapic_pin(i) == iosapic_pin(vector))
-			iosapic_pin(i) = 0xff;
-        }
-
-	iosapic_pin(vector) = legacy->pin;
-	iosapic_bus(vector) = BUS_ISA;	/* This table only overrides the ISA devices */
-	iosapic_busdata(vector) = 0;
-	
-	/* 
-	 * External timer tick is special... 
-	 */
-	if (vector != TIMER_IRQ)
-		iosapic_dmode(vector) = IO_SAPIC_LOWEST_PRIORITY;
-	else 
-		iosapic_dmode(vector) = IO_SAPIC_FIXED;
-	
-	/* See MPS 1.4 section 4.3.4 */
-	switch (legacy->flags) {
-	case 0x5:
-		iosapic_polarity(vector) = IO_SAPIC_POL_HIGH;
-		iosapic_trigger(vector) = IO_SAPIC_EDGE;
-		break;
-	case 0x8:
-		iosapic_polarity(vector) = IO_SAPIC_POL_LOW;
-		iosapic_trigger(vector) = IO_SAPIC_EDGE;
-		break;
-	case 0xd:
-		iosapic_polarity(vector) = IO_SAPIC_POL_HIGH;
-		iosapic_trigger(vector) = IO_SAPIC_LEVEL;
-		break;
-	case 0xf:
-		iosapic_polarity(vector) = IO_SAPIC_POL_LOW;
-		iosapic_trigger(vector) = IO_SAPIC_LEVEL;
-		break;
-	default:
-		printk("    ACPI Legacy IRQ 0x%02x: Unknown flags 0x%x\n", legacy->isa_irq,
-		       legacy->flags);
-		break;
-	}
-
-# ifdef ACPI_DEBUG
-	printk("Legacy ISA IRQ %x -> IA64 Vector %x IOSAPIC Pin %x Active %s %s Trigger\n", 
-	       legacy->isa_irq, vector, iosapic_pin(vector), 
-	       ((iosapic_polarity(vector) == IO_SAPIC_POL_LOW) ? "Low" : "High"),
-	       ((iosapic_trigger(vector) == IO_SAPIC_LEVEL) ? "Level" : "Edge"));
-# endif /* ACPI_DEBUG */
-#endif /* CONFIG_IA64_IRQ_ACPI */
-}
-
-/*
- * Info on platform interrupt sources: NMI. PMI, INIT, etc.
- */
-static void __init
-acpi_platform(char *p)
-{
-	acpi_entry_platform_src_t *plat = (acpi_entry_platform_src_t *) p;
-
-	printk("PLATFORM: IOSAPIC %x -> Vector %lx on CPU %.04u:%.04u\n",
-	       plat->iosapic_vector, plat->global_vector, plat->eid, plat->id);
-}
-
-/*
- * Parse the ACPI Multiple SAPIC Table
- */
-static void __init
-acpi_parse_msapic(acpi_sapic_t *msapic)
-{
-	char *p, *end;
-
-	/* Base address of IPI Message Block */
-	ipi_base_addr = (unsigned long) ioremap(msapic->interrupt_block, 0);
-
-	p = (char *) (msapic + 1);
-	end = p + (msapic->header.length - sizeof(acpi_sapic_t));
-
-	while (p < end) {
-		
-		switch (*p) {
-		case ACPI_ENTRY_LOCAL_SAPIC:
-			acpi_lsapic(p);
-			break;
-	
-		case ACPI_ENTRY_IO_SAPIC:
-			platform_register_iosapic((acpi_entry_iosapic_t *) p);
-			break;
-
-		case ACPI_ENTRY_INT_SRC_OVERRIDE:
-			acpi_legacy_irq(p);
-			break;
-		
-		case ACPI_ENTRY_PLATFORM_INT_SOURCE:
-			acpi_platform(p);
-			break;
-		
-		default:
-			break;
-		}
-
-		/* Move to next table entry. */
-#define BAD_ACPI_TABLE
-#ifdef BAD_ACPI_TABLE
-		/*
-		 * Some prototype Lion's have a bad ACPI table
-		 * requiring this fix.  Without this fix, those
-		 * machines crash during bootup.
-		 */
-		if (p[1] == 0)
-			p = end;
-		else
-#endif
-			p += p[1];
-	}
-
-	/* Make bootup pretty */
-	printk("      %d CPUs available, %d CPUs total\n", available_cpus, total_cpus);
-}
-
-int __init 
-acpi_parse(acpi_rsdp_t *rsdp)
-{
-	acpi_rsdt_t *rsdt;
-	acpi_desc_table_hdr_t *hdrp;
-	long tables, i;
-
-	if (!rsdp) {
-		printk("Uh-oh, no ACPI Root System Description Pointer table!\n");
-		return 0;
-	}
-
-	if (strncmp(rsdp->signature, ACPI_RSDP_SIG, ACPI_RSDP_SIG_LEN)) {
-		printk("Uh-oh, ACPI RSDP signature incorrect!\n");
-		return 0;
-	}
-
-	rsdp->rsdt = __va(rsdp->rsdt);
-	rsdt = rsdp->rsdt;
-	if (strncmp(rsdt->header.signature, ACPI_RSDT_SIG, ACPI_RSDT_SIG_LEN)) {
-		printk("Uh-oh, ACPI RDST signature incorrect!\n");
-		return 0;
-	}
-
-	printk("ACPI: %.6s %.8s %d.%d\n", rsdt->header.oem_id, rsdt->header.oem_table_id, 
-	       rsdt->header.oem_revision >> 16, rsdt->header.oem_revision & 0xffff);
-	
-#ifdef CONFIG_ACPI_KERNEL_CONFIG
-	acpi_cf_init(rsdp);
-#endif
-
-	tables = (rsdt->header.length - sizeof(acpi_desc_table_hdr_t)) / 8;
-	for (i = 0; i < tables; i++) {
-		hdrp = (acpi_desc_table_hdr_t *) __va(rsdt->entry_ptrs[i]);
-
-		/* Only interested int the MSAPIC table for now ... */
-		if (strncmp(hdrp->signature, ACPI_SAPIC_SIG, ACPI_SAPIC_SIG_LEN) != 0)
-			continue;
-
-		acpi_parse_msapic((acpi_sapic_t *) hdrp);
-	}
-
-#ifdef CONFIG_ACPI_KERNEL_CONFIG
-       acpi_cf_terminate();
-#endif
-
-#ifdef CONFIG_SMP
-	if (available_cpus == 0) {
-		printk("ACPI: Found 0 CPUS; assuming 1\n");
-		available_cpus = 1; /* We've got at least one of these, no? */
-	}
-	smp_boot_data.cpu_count = available_cpus;
-#endif
-	return 1;
-}
-
-const char *
-acpi_get_sysname (void)
-{       
-	/* the following should go away once we have an ACPI parser: */
-#ifdef CONFIG_IA64_GENERIC
-	return "hpsim";
-#else
-# if defined (CONFIG_IA64_HP_SIM)
-	return "hpsim";
-# elif defined (CONFIG_IA64_SGI_SN1)
-	return "sn1";
-# elif defined (CONFIG_IA64_DIG)
-	return "dig";
-# else
-#	error Unknown platform.  Fix acpi.c.
-# endif
-#endif
-}

--Q68bSM7Ycu6FN28Q--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
