Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSFQAYd>; Sun, 16 Jun 2002 20:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSFQAYd>; Sun, 16 Jun 2002 20:24:33 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:31174 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316649AbSFQAYZ>; Sun, 16 Jun 2002 20:24:25 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Initcall depends
Date: Mon, 17 Jun 2002 10:28:53 +1000
Message-Id: <E17JkO6-0000nW-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply (thanks to Peter Moulder for script tweaks).

Lack of response clearly means everyone thinks this is a brilliant
idea.  They're right 8)

Name: initcall depends
Author: Rusty Russell, Peter Moulder
Status: Tested in 2.5.21

D: Introduces initcall(function, name [, dependencies ]).  Dependencies
D: are: init_after(name), init_before(name) and init_as_part_of(name).
D: Replaces all the core_initcall, subsys_initcall etc, with three
D: more general systems: "mm_initcalls", "bus_initcalls" and
D: "driver_initcalls", which the other initcall define their orders in
D: terms of.  The old __initcall is supported, and link order still
D: controls their invocation order (after driver_initcalls are
D: finished).

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/init.h working-2.5.21-initorder/include/linux/init.h
--- linux-2.5.21/include/linux/init.h	Mon Jun 10 16:03:55 2002
+++ working-2.5.21-initorder/include/linux/init.h	Sun Jun 16 05:09:43 2002
@@ -1,7 +1,12 @@
 #ifndef _LINUX_INIT_H
 #define _LINUX_INIT_H
+/* Hacked on by just about everyone.  Explicit ordering work by:
+ * Rusty Russell (C) 2002 IBM Corporation */
+
+/* Change this file, make sure you don't break scripts/build-initcalls */
 
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -48,29 +53,46 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __initcall_start, __initcall_end;
+#define INITCALL_MAX_NAMELEN 64
+#define INITCALL_MAX_DEPS 3
 
-/* initcalls are now grouped by functionality into separate 
- * subsections. Ordering inside the subsections is determined
- * by link order. 
- * For backwards compatability, initcall() puts the call in 
- * the device init subsection.
- */
+/* Ensure it's initialized after x */
+#define init_after(x) { .follows = __stringify(x) "-end" }
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
+/* Ensure it's initialized before x */
+#define init_before(x) { .preceeds = __stringify(x) "-start" }
 
-#define core_initcall(fn)		__define_initcall("1",fn)
-#define postcore_initcall(fn)		__define_initcall("2",fn)
-#define arch_initcall(fn)		__define_initcall("3",fn)
-#define subsys_initcall(fn)		__define_initcall("4",fn)
-#define fs_initcall(fn)			__define_initcall("5",fn)
-#define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+/* This is part of the x subsystem initialization */
+#define init_as_part_of(x)						\
+  { .follows = __stringify(x) "-start",  .preceeds = __stringify(x) "-end" }
 
-#define __initcall(fn) device_initcall(fn)
+/* Example usage:
+	initcall(ppc_extras_init,
+		 init_after(other_device_init),
+		 init_as_part_of(device_initcalls));
+   Do not use a "_initcalls" name except for subsystems (ie. init_as_part_of).
+*/
+#define initcall(initfn,...)						\
+	static inline initcall_t __init_##initfn##_test(void)		\
+	{ return initfn; }						\
+	int __init_##initfn(void) __attribute__((alias(#initfn)));	\
+	static const struct initcall_info initfn##_initcall_info	\
+	__attribute__ ((__section__ (".initcalls"))) =			\
+	{ .name = __stringify(initfn), { __VA_ARGS__ } };
 
-#define __exitcall(fn)								\
+struct initcall_order
+{
+	char preceeds[INITCALL_MAX_NAMELEN];
+	char follows[INITCALL_MAX_NAMELEN];
+};
+
+struct initcall_info
+{
+	char name[INITCALL_MAX_NAMELEN];
+	struct initcall_order order[INITCALL_MAX_DEPS];
+};
+
+#define __exitcall(fn)	\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 /*
@@ -86,7 +108,6 @@
 #define __setup(str, fn)								\
 	static char __setup_str_##fn[] __initdata = str;				\
 	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -135,7 +156,6 @@
 #define __exit
 #define __initdata
 #define __exitdata
-#define __initcall(fn)
 /* For assembly routines */
 #define __INIT
 #define __FINIT
@@ -159,14 +179,7 @@
 
 #define __setup(str,func) /* nothing */
 
-#define core_initcall(fn)		module_init(fn)
-#define postcore_initcall(fn)		module_init(fn)
-#define arch_initcall(fn)		module_init(fn)
-#define subsys_initcall(fn)		module_init(fn)
-#define fs_initcall(fn)			module_init(fn)
-#define device_initcall(fn)		module_init(fn)
-#define late_initcall(fn)		module_init(fn)
-
+#define initcall(initfn,initname,...) module_init(initfn)
 #endif
 
 /* Data marked not to be saved by software_suspend() */
@@ -185,5 +198,17 @@
 #define __devexitdata __exitdata
 #define __devexit_p(x)  0
 #endif
+
+/* This many levels of indirection really required */
+#define ___CAT3(a,b,c) a##_##b##_##c
+#define __CAT3(a,b,c) ___CAT3(a,b,c)
+#define __FAKENAME(fn) __CAT3(KBUILD_BASENAME,fn,__LINE__)
+
+#define ___initcall(a,...) initcall(a, __VA_ARGS__)
+
+/* Backwards compat macro: deprecated */
+#define __initcall(fn)						\
+	static int __FAKENAME(fn)(void) { return fn(); }	\
+	___initcall(__FAKENAME(fn), init_as_part_of(deprecated_initcalls))
 
 #endif /* _LINUX_INIT_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/Makefile working-2.5.21-initorder/Makefile
--- linux-2.5.21/Makefile	Mon Jun 10 16:03:45 2002
+++ working-2.5.21-initorder/Makefile	Sun Jun 16 05:09:43 2002
@@ -216,6 +216,7 @@
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -232,7 +233,10 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+init/generated-initcalls.c: $(vmlinux-objs) scripts/build-initcalls
+	sh -e scripts/build-initcalls $(OBJDUMP) $(vmlinux-objs) >$@
+
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
 #	The actual objects are generated when descending, 
@@ -574,7 +578,7 @@
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
-	kernel/ksyms.lst include/linux/compile.h \
+	init/generated-initcalls.c kernel/ksyms.lst include/linux/compile.h \
 	vmlinux System.map \
 	.tmp* \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/alpha/kernel/pci.c working-2.5.21-initorder/arch/alpha/kernel/pci.c
--- linux-2.5.21/arch/alpha/kernel/pci.c	Thu May 30 10:00:47 2002
+++ working-2.5.21-initorder/arch/alpha/kernel/pci.c	Sun Jun 16 05:09:44 2002
@@ -198,7 +198,7 @@
 	alpha_mv.init_pci();
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 char * __init
 pcibios_setup(char *str)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/kernel/ecard.c working-2.5.21-initorder/arch/arm/kernel/ecard.c
--- linux-2.5.21/arch/arm/kernel/ecard.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/kernel/ecard.c	Sun Jun 16 05:09:44 2002
@@ -1055,7 +1055,9 @@
 	ecard_proc_init();
 }
 
-subsys_initcall(ecard_init);
+initcall(ecard_init,
+	 init_after(pci_registration_init),
+	 init_as_part_of(bus_initcalls));
 
 EXPORT_SYMBOL(ecard_startfind);
 EXPORT_SYMBOL(ecard_find);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-footbridge/cats-pci.c working-2.5.21-initorder/arch/arm/mach-footbridge/cats-pci.c
--- linux-2.5.21/arch/arm/mach-footbridge/cats-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/mach-footbridge/cats-pci.c	Sun Jun 16 05:09:44 2002
@@ -52,4 +52,4 @@
 	return 0;
 }
 
-subsys_initcall(cats_pci_init);
+initcall(cats_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-footbridge/ebsa285-pci.c working-2.5.21-initorder/arch/arm/mach-footbridge/ebsa285-pci.c
--- linux-2.5.21/arch/arm/mach-footbridge/ebsa285-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/mach-footbridge/ebsa285-pci.c	Sun Jun 16 05:09:44 2002
@@ -45,4 +45,4 @@
 	return 0;
 }
 
-subsys_initcall(ebsa285_init_pci);
+initcall(ebsa285_init_pci, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-footbridge/netwinder-pci.c working-2.5.21-initorder/arch/arm/mach-footbridge/netwinder-pci.c
--- linux-2.5.21/arch/arm/mach-footbridge/netwinder-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/mach-footbridge/netwinder-pci.c	Sun Jun 16 05:09:44 2002
@@ -59,4 +59,4 @@
 	return 0;
 }
 
-subsys_initcall(netwinder_pci_init);
+initcall(netwinder_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-footbridge/personal-pci.c working-2.5.21-initorder/arch/arm/mach-footbridge/personal-pci.c
--- linux-2.5.21/arch/arm/mach-footbridge/personal-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/mach-footbridge/personal-pci.c	Sun Jun 16 05:09:44 2002
@@ -53,4 +53,4 @@
 	return 0;
 }
 
-subsys_initcall(&personal_pci_init);
+initcall(personal_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-ftvpci/pci.c working-2.5.21-initorder/arch/arm/mach-ftvpci/pci.c
--- linux-2.5.21/arch/arm/mach-ftvpci/pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/mach-ftvpci/pci.c	Sun Jun 16 05:09:44 2002
@@ -57,4 +57,4 @@
 	return 0;
 }
 
-subsys_initcall(ftv_pci_init);
+initcall(ftv_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-integrator/pci.c working-2.5.21-initorder/arch/arm/mach-integrator/pci.c
--- linux-2.5.21/arch/arm/mach-integrator/pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.21-initorder/arch/arm/mach-integrator/pci.c	Sun Jun 16 05:09:44 2002
@@ -130,4 +130,4 @@
 	return 0;
 }
 
-subsys_initcall(integrator_pci_init);
+initcall(integrator_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-iop310/iq80310-pci.c working-2.5.21-initorder/arch/arm/mach-iop310/iq80310-pci.c
--- linux-2.5.21/arch/arm/mach-iop310/iq80310-pci.c	Sat May 25 14:34:36 2002
+++ working-2.5.21-initorder/arch/arm/mach-iop310/iq80310-pci.c	Sun Jun 16 05:09:44 2002
@@ -156,4 +156,4 @@
 	return 0;
 }
 
-subsys_initcall(iq80310_pci_init);
+initcall(iq80310_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/arm/mach-shark/pci.c working-2.5.21-initorder/arch/arm/mach-shark/pci.c
--- linux-2.5.21/arch/arm/mach-shark/pci.c	Sat May 25 14:34:36 2002
+++ working-2.5.21-initorder/arch/arm/mach-shark/pci.c	Sun Jun 16 05:09:44 2002
@@ -39,4 +39,4 @@
 	return 0;
 }
 
-subsys_initcall(shark_pci_init);
+initcall(shark_pci_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/kernel/mca.c working-2.5.21-initorder/arch/i386/kernel/mca.c
--- linux-2.5.21/arch/i386/kernel/mca.c	Wed Feb 20 17:55:58 2002
+++ working-2.5.21-initorder/arch/i386/kernel/mca.c	Sun Jun 16 05:09:44 2002
@@ -311,7 +311,7 @@
 #endif
 }
 
-subsys_initcall(mca_init);
+initcall(mca_init, init_as_part_of(bus_initcalls));
 
 /*--------------------------------------------------------------------*/
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/acpi.c working-2.5.21-initorder/arch/i386/pci/acpi.c
--- linux-2.5.21/arch/i386/pci/acpi.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-initorder/arch/i386/pci/acpi.c	Sun Jun 16 05:09:44 2002
@@ -22,4 +22,4 @@
 	return 0;
 }
 
-subsys_initcall(pci_acpi_init);
+initcall(pci_acpi_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/common.c working-2.5.21-initorder/arch/i386/pci/common.c
--- linux-2.5.21/arch/i386/pci/common.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-initorder/arch/i386/pci/common.c	Sun Jun 16 05:09:44 2002
@@ -139,7 +139,7 @@
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 char * __devinit  pcibios_setup(char *str)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/direct.c working-2.5.21-initorder/arch/i386/pci/direct.c
--- linux-2.5.21/arch/i386/pci/direct.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-initorder/arch/i386/pci/direct.c	Sun Jun 16 05:09:44 2002
@@ -364,4 +364,6 @@
 	return 0;
 }
 
-arch_initcall(pci_direct_init);
+initcall(pci_direct_init,
+	 init_as_part_of(bus_initcalls),
+	 init_after(pci_pcbios_init)); /* FIXME: Does it matter? --RR */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/irq.c working-2.5.21-initorder/arch/i386/pci/irq.c
--- linux-2.5.21/arch/i386/pci/irq.c	Mon Jun  3 12:21:20 2002
+++ working-2.5.21-initorder/arch/i386/pci/irq.c	Sun Jun 16 05:09:44 2002
@@ -717,7 +717,9 @@
 	return 0;
 }
 
-subsys_initcall(pcibios_irq_init);
+initcall(pcibios_irq_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
 
 void __init pcibios_fixup_irqs(void)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/legacy.c working-2.5.21-initorder/arch/i386/pci/legacy.c
--- linux-2.5.21/arch/i386/pci/legacy.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-initorder/arch/i386/pci/legacy.c	Sun Jun 16 05:09:44 2002
@@ -54,4 +54,6 @@
 	return 0;
 }
 
-subsys_initcall(pci_legacy_init);
+initcall(pci_legacy_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/numa.c working-2.5.21-initorder/arch/i386/pci/numa.c
--- linux-2.5.21/arch/i386/pci/numa.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-initorder/arch/i386/pci/numa.c	Sun Jun 16 05:09:44 2002
@@ -120,4 +120,6 @@
 	return 0;
 }
 
-subsys_initcall(pci_numa_init);
+initcall(pci_numa_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/pci/pcbios.c working-2.5.21-initorder/arch/i386/pci/pcbios.c
--- linux-2.5.21/arch/i386/pci/pcbios.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-initorder/arch/i386/pci/pcbios.c	Sun Jun 16 05:09:44 2002
@@ -557,4 +557,4 @@
 	return 0;
 }
 
-arch_initcall(pci_pcbios_init);
+initcall(pci_pcbios_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ia64/hp/sim/simscsi.c working-2.5.21-initorder/arch/ia64/hp/sim/simscsi.c
--- linux-2.5.21/arch/ia64/hp/sim/simscsi.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.21-initorder/arch/ia64/hp/sim/simscsi.c	Sun Jun 16 05:09:44 2002
@@ -363,6 +363,7 @@
 
 static Scsi_Host_Template driver_template = SIMSCSI;
 
-#define __initcall(fn)	late_initcall(fn)
+/* FIXME: Um, really? --RR */
+#define __initcall(fn)	initcall(fn, init_after(device_initcalls))
 
 #include "../drivers/scsi/scsi_module.c"
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ia64/kernel/pci.c working-2.5.21-initorder/arch/ia64/kernel/pci.c
--- linux-2.5.21/arch/ia64/kernel/pci.c	Thu May 30 10:00:47 2002
+++ working-2.5.21-initorder/arch/ia64/kernel/pci.c	Sun Jun 16 05:09:44 2002
@@ -221,7 +221,7 @@
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 /*
  *  Called after each bus is probed, but before its children
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/kernel/pci.c working-2.5.21-initorder/arch/ppc/kernel/pci.c
--- linux-2.5.21/arch/ppc/kernel/pci.c	Mon May 13 12:00:31 2002
+++ working-2.5.21-initorder/arch/ppc/kernel/pci.c	Sun Jun 16 05:09:45 2002
@@ -1074,7 +1074,7 @@
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 unsigned char __init
 common_swizzle(struct pci_dev *dev, unsigned char *pinp)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/kernel/setup.c working-2.5.21-initorder/arch/ppc/kernel/setup.c
--- linux-2.5.21/arch/ppc/kernel/setup.c	Mon May 13 12:00:32 2002
+++ working-2.5.21-initorder/arch/ppc/kernel/setup.c	Sun Jun 16 05:09:45 2002
@@ -581,7 +581,7 @@
 	return 0;
 }
 
-arch_initcall(ppc_init);
+initcall(ppc_init, arch_init, init_after(core_initcalls));
 
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/platforms/lopec_setup.c working-2.5.21-initorder/arch/ppc/platforms/lopec_setup.c
--- linux-2.5.21/arch/ppc/platforms/lopec_setup.c	Thu May 30 10:00:49 2002
+++ working-2.5.21-initorder/arch/ppc/platforms/lopec_setup.c	Sun Jun 16 05:09:45 2002
@@ -235,7 +235,7 @@
 	return 0;
 }
 
-device_initcall(lopec_request_io);
+initcall(lopec_request_io, init_as_part_of(device_initcalls));
 
 static void __init
 lopec_map_io(void)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/platforms/pmac_feature.c working-2.5.21-initorder/arch/ppc/platforms/pmac_feature.c
--- linux-2.5.21/arch/ppc/platforms/pmac_feature.c	Mon May 13 12:00:32 2002
+++ working-2.5.21-initorder/arch/ppc/platforms/pmac_feature.c	Sun Jun 16 05:09:45 2002
@@ -2126,4 +2126,4 @@
 	return 0;
 }
 
-device_initcall(pmac_feature_late_init);
+initcall(pmac_feature_late_init, init_as_part_of(device_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/platforms/pmac_setup.c working-2.5.21-initorder/arch/ppc/platforms/pmac_setup.c
--- linux-2.5.21/arch/ppc/platforms/pmac_setup.c	Mon May 13 12:00:32 2002
+++ working-2.5.21-initorder/arch/ppc/platforms/pmac_setup.c	Sun Jun 16 05:09:45 2002
@@ -463,7 +463,11 @@
 	return 0;
 }
 
-late_initcall(pmac_late_init);
+/* Say it's after both so it doesn't break when deprecated_initcalls
+   vanishes */
+initcall(pmac_late_init,
+	 init_after(device_initcalls),
+	 init_after(deprecated_initcalls));
 
 /* can't be __init - can be called whenever a disk is first accessed */
 void __pmac
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/platforms/prep_setup.c working-2.5.21-initorder/arch/ppc/platforms/prep_setup.c
--- linux-2.5.21/arch/ppc/platforms/prep_setup.c	Thu May 30 10:00:49 2002
+++ working-2.5.21-initorder/arch/ppc/platforms/prep_setup.c	Sun Jun 16 05:09:45 2002
@@ -825,7 +825,7 @@
 	return 0;
 }
 
-device_initcall(prep_request_io);
+initcall(prep_request_io, init_as_part_of(device_initcalls));
 
 void __init
 prep_init(unsigned long r3, unsigned long r4, unsigned long r5,
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc64/kernel/pci.c working-2.5.21-initorder/arch/ppc64/kernel/pci.c
--- linux-2.5.21/arch/ppc64/kernel/pci.c	Mon Jun  3 12:21:20 2002
+++ working-2.5.21-initorder/arch/ppc64/kernel/pci.c	Sun Jun 16 05:09:45 2002
@@ -498,7 +498,7 @@
 
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 int __init
 pcibios_assign_all_busses(void)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc64/kernel/setup.c working-2.5.21-initorder/arch/ppc64/kernel/setup.c
--- linux-2.5.21/arch/ppc64/kernel/setup.c	Mon Jun  3 12:21:21 2002
+++ working-2.5.21-initorder/arch/ppc64/kernel/setup.c	Sun Jun 16 05:09:45 2002
@@ -485,7 +485,7 @@
 	return 0;
 }
 
-arch_initcall(ppc_init);
+initcall(ppc_init, arch_init, init_after(core_initcalls));
 
 void __init ppc64_calibrate_delay(void)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/sparc64/kernel/pci.c working-2.5.21-initorder/arch/sparc64/kernel/pci.c
--- linux-2.5.21/arch/sparc64/kernel/pci.c	Sun May 19 12:07:29 2002
+++ working-2.5.21-initorder/arch/sparc64/kernel/pci.c	Sun Jun 16 05:09:45 2002
@@ -201,7 +201,7 @@
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 struct pci_fixup pcibios_fixups[] = {
 	{ 0 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/acpi/bus.c working-2.5.21-initorder/drivers/acpi/bus.c
--- linux-2.5.21/drivers/acpi/bus.c	Mon Jun  3 12:21:21 2002
+++ working-2.5.21-initorder/drivers/acpi/bus.c	Sun Jun 16 05:09:45 2002
@@ -2190,6 +2190,7 @@
 	return 1;
 }
 
-subsys_initcall(acpi_init);
+initcall(acpi_init,
+	 init_as_part_of(bus_initcalls)); /* FIXME: should it be after?-- RR */
 
 __setup("acpi=", acpi_setup);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/base/bus.c working-2.5.21-initorder/drivers/base/bus.c
--- linux-2.5.21/drivers/base/bus.c	Mon Jun 10 16:03:48 2002
+++ working-2.5.21-initorder/drivers/base/bus.c	Sun Jun 16 05:09:45 2002
@@ -198,13 +198,15 @@
 	driverfs_remove_dir(&bus->dir);
 }
 
-static int __init bus_init(void)
+static int __init driverfs_bus_init(void)
 {
 	/* make 'bus' driverfs directory */
 	return driverfs_create_dir(&bus_dir,NULL);
 }
 
-core_initcall(bus_init);
+initcall(driverfs_bus_init,
+	 init_after(driverfs_init),
+	 init_before(bus_initcalls));
 
 EXPORT_SYMBOL(bus_for_each_dev);
 EXPORT_SYMBOL(bus_for_each_drv);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/base/core.c working-2.5.21-initorder/drivers/base/core.c
--- linux-2.5.21/drivers/base/core.c	Mon Jun 10 16:03:48 2002
+++ working-2.5.21-initorder/drivers/base/core.c	Sun Jun 16 05:09:45 2002
@@ -278,7 +278,7 @@
 	return device_register(&device_root);
 }
 
-static int __init device_init(void)
+static int __init driverfs_init(void)
 {
 	int error;
 
@@ -293,7 +293,7 @@
 	return error;
 }
 
-core_initcall(device_init);
+initcall(driverfs_init, init_before(bus_initcalls));
 
 EXPORT_SYMBOL(device_register);
 EXPORT_SYMBOL(put_device);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/base/sys.c working-2.5.21-initorder/drivers/base/sys.c
--- linux-2.5.21/drivers/base/sys.c	Mon Jun 10 16:03:48 2002
+++ working-2.5.21-initorder/drivers/base/sys.c	Sun Jun 16 05:09:45 2002
@@ -44,6 +44,7 @@
        return device_register(&system_bus);
 }
 
-postcore_initcall(sys_bus_init);
+initcall(sys_bus_init, init_after(driverfs_init), init_before(bus_initcalls));
+
 EXPORT_SYMBOL(register_sys_device);
 EXPORT_SYMBOL(unregister_sys_device);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/dio/dio.c working-2.5.21-initorder/drivers/dio/dio.c
--- linux-2.5.21/drivers/dio/dio.c	Wed Feb 20 17:56:01 2002
+++ working-2.5.21-initorder/drivers/dio/dio.c	Sun Jun 16 05:09:45 2002
@@ -208,7 +208,7 @@
         }
 }
 
-subsys_initcall(dio_init);
+initcall(dio_init, init_as_part_of(bus_initcalls));
 
 /* Bear in mind that this is called in the very early stages of initialisation
  * in order to get the virtual address of the serial port for the console...
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/macintosh/mediabay.c working-2.5.21-initorder/drivers/macintosh/mediabay.c
--- linux-2.5.21/drivers/macintosh/mediabay.c	Thu May 30 10:00:53 2002
+++ working-2.5.21-initorder/drivers/macintosh/mediabay.c	Sun Jun 16 05:09:45 2002
@@ -834,4 +834,4 @@
 	return 0;
 }
 
-device_initcall(media_bay_init);
+initcall(media_bay_init, init_as_part_of(device_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/macintosh/via-cuda.c working-2.5.21-initorder/drivers/macintosh/via-cuda.c
--- linux-2.5.21/drivers/macintosh/via-cuda.c	Sun May 19 12:07:30 2002
+++ working-2.5.21-initorder/drivers/macintosh/via-cuda.c	Sun Jun 16 05:09:45 2002
@@ -204,7 +204,7 @@
     return 0;
 }
 
-device_initcall(via_cuda_start);
+initcall(via_cuda_start, init_as_part_of(device_initcalls));
 
 #ifdef CONFIG_ADB
 static int
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/macintosh/via-pmu.c working-2.5.21-initorder/drivers/macintosh/via-pmu.c
--- linux-2.5.21/drivers/macintosh/via-pmu.c	Sun May 19 12:07:30 2002
+++ working-2.5.21-initorder/drivers/macintosh/via-pmu.c	Sun Jun 16 05:09:45 2002
@@ -440,7 +440,7 @@
 	return 0;
 }
 
-arch_initcall(via_pmu_start);
+initcall(via_pmu_start, init_before(device_initcalls));
 
 /*
  * This has to be done after pci_init, which is a subsys_initcall.
@@ -498,7 +498,7 @@
 	return 0;
 }
 
-device_initcall(via_pmu_dev_init);
+initcall(via_pmu_dev_init, via_pmu_init, init_after(pci_init));
 
 static int __openfirmware
 init_pmu()
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/nubus/nubus.c working-2.5.21-initorder/drivers/nubus/nubus.c
--- linux-2.5.21/drivers/nubus/nubus.c	Wed Feb 20 17:56:05 2002
+++ working-2.5.21-initorder/drivers/nubus/nubus.c	Sun Jun 16 05:09:45 2002
@@ -1040,4 +1040,4 @@
 #endif
 }
 
-subsys_initcall(nubus_init);
+initcall(nubus_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/pci/pci-driver.c working-2.5.21-initorder/drivers/pci/pci-driver.c
--- linux-2.5.21/drivers/pci/pci-driver.c	Mon Jun 10 16:03:50 2002
+++ working-2.5.21-initorder/drivers/pci/pci-driver.c	Sun Jun 16 05:09:45 2002
@@ -199,12 +199,14 @@
 	match:	pci_bus_match,
 };
 
-static int __init pci_driver_init(void)
+static int __init pci_registration_init(void)
 {
 	return bus_register(&pci_bus_type);
 }
 
-postcore_initcall(pci_driver_init);
+initcall(pci_registration_init,
+	 init_before(bus_initcalls),
+	 init_after(driverfs_bus_init));
 
 EXPORT_SYMBOL(pci_match_device);
 EXPORT_SYMBOL(pci_register_driver);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/pci/pci.c working-2.5.21-initorder/drivers/pci/pci.c
--- linux-2.5.21/drivers/pci/pci.c	Mon May 13 12:00:36 2002
+++ working-2.5.21-initorder/drivers/pci/pci.c	Sun Jun 16 05:09:45 2002
@@ -555,7 +555,7 @@
 	return 0;
 }
 
-static int __devinit pci_init(void)
+static int __devinit pci_fixups(void)
 {
 	struct pci_dev *dev;
 
@@ -580,7 +580,7 @@
 	return 1;
 }
 
-device_initcall(pci_init);
+initcall(pci_fixups, init_after(bus_initcalls), init_before(device_initcalls));
 
 __setup("pci=", pci_setup);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/pci/power.c working-2.5.21-initorder/drivers/pci/power.c
--- linux-2.5.21/drivers/pci/power.c	Tue May 21 16:33:32 2002
+++ working-2.5.21-initorder/drivers/pci/power.c	Sun Jun 16 05:09:45 2002
@@ -162,4 +162,5 @@
 	return 0;
 }
 
-subsys_initcall(pci_pm_init);
+initcall(pci_pm_init,
+	 init_as_part_of(bus_initcalls)); /* FIXME: should it be after?-- RR */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/pcmcia/ds.c working-2.5.21-initorder/drivers/pcmcia/ds.c
--- linux-2.5.21/drivers/pcmcia/ds.c	Mon May 13 12:00:36 2002
+++ working-2.5.21-initorder/drivers/pcmcia/ds.c	Sun Jun 16 05:09:45 2002
@@ -966,7 +966,7 @@
     return 0;
 }
 
-late_initcall(init_pcmcia_ds);
+initcall(init_pcmcia_ds, init_after(device_initcalls));
 
 #ifdef MODULE
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/pnp/isapnp.c working-2.5.21-initorder/drivers/pnp/isapnp.c
--- linux-2.5.21/drivers/pnp/isapnp.c	Thu Mar 21 14:14:48 2002
+++ working-2.5.21-initorder/drivers/pnp/isapnp.c	Sun Jun 16 05:09:45 2002
@@ -2393,7 +2393,7 @@
 	return 0;
 }
 
-subsys_initcall(isapnp_init);
+initcall(isapnp_init, init_as_part_of(bus_initcalls));
 
 #ifdef MODULE
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/pnp/pnpbios_core.c working-2.5.21-initorder/drivers/pnp/pnpbios_core.c
--- linux-2.5.21/drivers/pnp/pnpbios_core.c	Sat May 25 14:34:46 2002
+++ working-2.5.21-initorder/drivers/pnp/pnpbios_core.c	Sun Jun 16 05:09:45 2002
@@ -1218,7 +1218,7 @@
 __setup("pnpbios=", pnpbios_setup);
 #endif
 
-subsys_initcall(pnpbios_init);
+initcall(pnpbios_init, init_as_part_of(bus_initcalls));
 
 int __init pnpbios_init(void)
 {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/sbus/sbus.c working-2.5.21-initorder/drivers/sbus/sbus.c
--- linux-2.5.21/drivers/sbus/sbus.c	Mon Apr 15 11:47:28 2002
+++ working-2.5.21-initorder/drivers/sbus/sbus.c	Sun Jun 16 05:09:46 2002
@@ -517,4 +517,4 @@
 	return 0;
 }
 
-subsys_initcall(sbus_init);
+initcall(sbus_init, init_as_part_of(bus_initcalls));
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/tc/tc.c working-2.5.21-initorder/drivers/tc/tc.c
--- linux-2.5.21/drivers/tc/tc.c	Wed Feb 20 17:56:08 2002
+++ working-2.5.21-initorder/drivers/tc/tc.c	Sun Jun 16 05:09:46 2002
@@ -165,7 +165,7 @@
 /*
  * the main entry
  */
-void __init tc_init(void)
+void __init turbochannel_init(void)
 {
 	int tc_clock;
 	int i;
@@ -236,7 +236,7 @@
 	}
 }
 
-subsys_initcall(tc_init);
+initcall(turbochannel_init, init_as_part_of(bus_initcalls));
 
 EXPORT_SYMBOL(search_tc_card);
 EXPORT_SYMBOL(claim_tc_card);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/usb/core/usb.c working-2.5.21-initorder/drivers/usb/core/usb.c
--- linux-2.5.21/drivers/usb/core/usb.c	Mon Jun  3 12:21:26 2002
+++ working-2.5.21-initorder/drivers/usb/core/usb.c	Sun Jun 16 05:09:46 2002
@@ -1447,7 +1447,7 @@
 	usb_hub_cleanup();
 }
 
-subsys_initcall(usb_init);
+initcall(usb_init, init_as_part_of(bus_initcalls));
 module_exit(usb_exit);
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/drivers/zorro/zorro.c working-2.5.21-initorder/drivers/zorro/zorro.c
--- linux-2.5.21/drivers/zorro/zorro.c	Mon May 13 12:00:37 2002
+++ working-2.5.21-initorder/drivers/zorro/zorro.c	Sun Jun 16 05:09:46 2002
@@ -172,7 +172,7 @@
     return 0;
 }
 
-subsys_initcall(zorro_init);
+initcall(zorro_init, init_as_part_of(bus_initcalls));
 
 EXPORT_SYMBOL(zorro_find_device);
 EXPORT_SYMBOL(zorro_unused_z2ram);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/init/main.c working-2.5.21-initorder/init/main.c
--- linux-2.5.21/init/main.c	Mon Jun 10 16:03:56 2002
+++ working-2.5.21-initorder/init/main.c	Sun Jun 16 05:09:46 2002
@@ -421,19 +421,7 @@
 
 struct task_struct *child_reaper = &init_task;
 
-static void __init do_initcalls(void)
-{
-	initcall_t *call;
-
-	call = &__initcall_start;
-	do {
-		(*call)();
-		call++;
-	} while (call < &__initcall_end);
-
-	/* Make sure there is no pending stuff from the initcall sequence */
-	flush_scheduled_tasks();
-}
+extern void do_initcalls(void);
 
 /*
  * Ok, the machine is now initialized. None of the devices
@@ -485,6 +473,8 @@
 
 	start_context_thread();
 	do_initcalls();
+	/* Make sure there is no pending stuff from the initcall sequence */
+	flush_scheduled_tasks();
 }
 
 extern void prepare_namespace(void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/kernel/exec_domain.c working-2.5.21-initorder/kernel/exec_domain.c
--- linux-2.5.21/kernel/exec_domain.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.21-initorder/kernel/exec_domain.c	Sun Jun 16 05:09:46 2002
@@ -275,14 +275,13 @@
 };
 
 static int __init
-abi_register_sysctl(void)
+abi_init(void)
 {
 	register_sysctl_table(abi_root_table, 1);
 	return 0;
 }
 
-__initcall(abi_register_sysctl);
-
+initcall(abi_init, init_before(device_initcalls));
 
 EXPORT_SYMBOL(abi_defhandler_coff);
 EXPORT_SYMBOL(abi_defhandler_elf);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/kernel/softirq.c working-2.5.21-initorder/kernel/softirq.c
--- linux-2.5.21/kernel/softirq.c	Mon Jun  3 12:21:28 2002
+++ working-2.5.21-initorder/kernel/softirq.c	Sun Jun 16 05:09:46 2002
@@ -412,4 +412,4 @@
 	return 0;
 }
 
-__initcall(spawn_ksoftirqd);
+initcall(spawn_ksoftirqd, init_before(bus_initcalls)); /* Really? */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/lib/crc32.c working-2.5.21-initorder/lib/crc32.c
--- linux-2.5.21/lib/crc32.c	Wed Feb 20 17:56:42 2002
+++ working-2.5.21-initorder/lib/crc32.c	Sun Jun 16 05:09:46 2002
@@ -564,7 +564,7 @@
 	crc32cleanup_be();
 }
 
-fs_initcall(init_crc32);
+initcall(init_crc32, init_after(mm), init_before(device_initcalls));
 module_exit(cleanup_crc32);
 
 EXPORT_SYMBOL(crc32_le);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/mm/highmem.c working-2.5.21-initorder/mm/highmem.c
--- linux-2.5.21/mm/highmem.c	Mon Jun 10 16:03:56 2002
+++ working-2.5.21-initorder/mm/highmem.c	Sun Jun 16 05:09:46 2002
@@ -221,7 +221,9 @@
 	return 0;
 }
 
-__initcall(init_emergency_pool);
+initcall(init_emergency_pool,
+	 init_as_part_of(mm_initcalls),
+	 init_before(mm_slab_init));
 
 /*
  * highmem version, map in to vec
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/mm/slab.c working-2.5.21-initorder/mm/slab.c
--- linux-2.5.21/mm/slab.c	Mon May 13 12:00:40 2002
+++ working-2.5.21-initorder/mm/slab.c	Sun Jun 16 05:09:46 2002
@@ -499,7 +499,7 @@
 	} while (sizes->cs_size);
 }
 
-int __init kmem_cpucache_init(void)
+int __init mm_slab_init(void)
 {
 #ifdef CONFIG_SMP
 	g_cpucache_up = 1;
@@ -508,7 +508,7 @@
 	return 0;
 }
 
-__initcall(kmem_cpucache_init);
+initcall(mm_slab_init, init_as_part_of(mm_initcalls));
 
 /* Interface to system's page allocator. No need to hold the cache-lock.
  */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/net/irda/af_irda.c working-2.5.21-initorder/net/irda/af_irda.c
--- linux-2.5.21/net/irda/af_irda.c	Mon May  6 11:12:01 2002
+++ working-2.5.21-initorder/net/irda/af_irda.c	Sun Jun 16 05:09:46 2002
@@ -2634,7 +2634,7 @@
 	return 0;
 }
 
-late_initcall(irda_proto_init);
+initcall(irda_proto_init, init_after(device_initcalls));
 
 /*
  * Function irda_proto_cleanup (void)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/scripts/build-initcalls working-2.5.21-initorder/scripts/build-initcalls
--- linux-2.5.21/scripts/build-initcalls	Thu Jan  1 10:00:00 1970
+++ working-2.5.21-initorder/scripts/build-initcalls	Sun Jun 16 05:12:13 2002
@@ -0,0 +1,116 @@
+#! /bin/sh
+# Given an objdump binary, and a list of object files, spit out C code to
+# call all the inits in order.
+
+# Hardcoded section orderings here.
+FIXED="mm bus device deprecated"
+
+# Don't do this in the top line, as we are invoked with sh explicitly.
+set -e
+
+if [ $# -le 1 ]; then
+    echo "Usage: $0 objdump objfile..." >&2
+    exit 1
+fi
+
+OBJDUMP="$1"
+shift
+
+# Get the structure sizes.
+INCLUDE_FILE=include/linux/init.h
+NAMELEN="`sed -n 's/[ 	]*$//;/^[ 	]*#[ 	]*define[ 	]*INITCALL_MAX_NAMELEN[ 	]*/s///p' $INCLUDE_FILE`"
+NUMDEPS="`sed -n 's/[ 	]*$//;/^[ 	]*#[ 	]*define[ 	]*INITCALL_MAX_DEPS[ 	]*/s///p' $INCLUDE_FILE`"
+if [ x"$NUMDEPS" = x ] || [ x"$NAMELEN" = x ] || [ x"`expr $NAMELEN % 16 2>/dev/null`" != x0 ]; then
+    echo "Invalid include file values: $NAMELEN and $NUMDEPS" >&2
+    exit 1
+fi
+# Objdump deals in 16-byte quantities.
+NAMELEN=`expr $NAMELEN / 16`
+
+# Simple numeric check (and also evaluate expression).
+NUMDEPS=`expr $NUMDEPS`
+
+# I hate mktemp, but tempfile isn't avail on RedHat
+TMPFILE="`mktemp \"${TMPDIR:-/tmp}/build-initcalls.XXXXXX\"`"
+TMPFILE2="`mktemp \"${TMPDIR:-/tmp}/build-initcalls2.XXXXXX\"`"
+REGEX="`mktemp \"${TMPDIR:-/tmp}/build-real.XXXXXX\"`"
+trap "echo exiting;rm -f \"$TMPFILE\" \"$TMPFILE2\" \"$REGEX\"" 0
+
+echo -n "s/\(" > "$REGEX"
+
+STATE=IN_NAME
+HEXABYTES=0
+FULLSTRING=""
+LASTOBSOLETE=""
+"$OBJDUMP" --section=.initcalls --full-contents "$@" |
+grep '^ *[0-9a-f][0-9a-f][0-9a-f][0-9a-f]' |
+while read POS HEX1 HEX2 HEX3 HEX4 STRING; do
+    # objdump uses . for non-printable, and we don't use real .s anyway.
+    FULLSTRING="$FULLSTRING`echo -n \"$STRING\" | tr -d .`"
+    HEXABYTES=`expr $HEXABYTES + 1`
+    if [ $HEXABYTES = $NAMELEN ]; then
+	case $STATE in
+	IN_NAME)
+	    NAME="$FULLSTRING"
+	    # Mentioned as a name: actual routine, not subsystem.
+	    [ -z "$NAME" ] || echo -n "$NAME\|" >> $REGEX
+	    STATE=IN_INITCALL_PRECEEDS
+	    INITCALL_NUM=0
+	    ;;
+	IN_INITCALL_PRECEEDS)
+	    [ -z "$FULLSTRING" ] || echo "$NAME"-start "$FULLSTRING"
+	    # Maintain link ordering for __initcalls
+	    if [ x"$FULLSTRING" = x"obsolete_initcalls-end" ]; then
+		[ -z "$LASTOBSOLETE" ] || echo "$NAME" "$LASTOBSOLETE"
+		LASTOBSOLETE="$NAME"
+	    fi
+	    STATE=IN_INITCALL_FOLLOWS
+	    ;;
+	IN_INITCALL_FOLLOWS)
+	    [ -z "$FULLSTRING" ] || echo "$FULLSTRING" "$NAME"-end
+	    INITCALL_NUM=`expr $INITCALL_NUM + 1`
+	    if [ $INITCALL_NUM = $NUMDEPS ]; then
+		STATE=IN_NAME
+	    else
+		STATE=IN_INITCALL_PRECEEDS
+	    fi
+	    ;;
+	esac
+	HEXABYTES=0
+	FULLSTRING=""
+    fi
+done > "$TMPFILE"
+
+# For everything which is an actual routine name, -start and -end are
+# the same.  Use regex to strip them.
+echo "INVALID-NAME\)-\(start\|end\)/\1/g" >> "$REGEX"
+sed -f "$REGEX" < "$TMPFILE" > "$TMPFILE2"
+
+# Add in fixed orderings.
+prev_fixed=""
+for fixed in $FIXED; do
+    [ x"$prev_fixed" = x ] || echo ${prev_fixed}_initcalls-end ${fixed}_initcalls-start
+    echo ${fixed}_initcalls-start ${fixed}_initcalls-end
+    prev_fixed=$fixed
+done >> "$TMPFILE2"
+
+# Do the sort.
+tsort < "$TMPFILE2" > "$TMPFILE"
+
+# Generate output
+echo "/* Auto-generated by build-initcalls: DO NOT EDIT. */"
+echo "#include <linux/init.h>"
+echo ""
+echo "void __init do_initcalls(void)"
+echo "{"
+while read VALUE; do
+    case $VALUE in
+    *-end|*-start)
+	echo "/* $VALUE */"
+	;;
+    *)
+	echo "	{ extern int __init_$VALUE(void); __init_$VALUE(); }"
+	;;
+    esac
+done < "$TMPFILE"
+echo "}"
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
