Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSGVIoz>; Mon, 22 Jul 2002 04:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGVIoy>; Mon, 22 Jul 2002 04:44:54 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:58030 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316591AbSGVIoh>;
	Mon, 22 Jul 2002 04:44:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Initcall depends
Date: Mon, 22 Jul 2002 18:46:21 +1000
Message-Id: <20020722084837.BDC4C44BB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

	This gets rid of the magic 7 levels of initcall dependencies,
replacing them with "mm", "bus" and "driver", and allowing objects to
define more fine-grained depends, like so:

	initcall(foo, init_as_part_of(bus_initcalls));
	initcall(bar, init_as_part_of(bus_initcalls), init_after(foo));

Script could be optimized by a sed-expert...
Rusty.

Name: initcall depends
Author: Rusty Russell, Peter Moulder
Status: Tested in 2.5.27 PPC64 and i386

D: Introduces initcall(function [, dependencies ]).  Dependencies
D: are: init_after(name), init_before(name) and init_as_part_of(name).
D: Replaces all the core_initcall, subsys_initcall etc, with three
D: more general systems: "mm_initcalls", "bus_initcalls" and
D: "driver_initcalls", which the other initcall can define their orders in
D: terms of.  The old __initcall is supported, and link order still
D: controls their invocation order (after driver_initcalls are
D: finished).

diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/Makefile working-2.5.27-initcalls/Makefile
--- linux-2.5.27/Makefile	Sun Jul 21 17:43:05 2002
+++ working-2.5.27-initcalls/Makefile	Mon Jul 22 17:45:14 2002
@@ -259,6 +259,7 @@ cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LD
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -275,7 +276,10 @@ define rule_link_vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+init/generated-initcalls.c: $(vmlinux-objs) scripts/build-initcalls
+	sh -e scripts/build-initcalls $(OBJDUMP) $(vmlinux-objs) >$@
+
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
 #	The actual objects are generated when descending, 
@@ -586,7 +590,7 @@ defconfig:
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
-	include/linux/compile.h \
+	init/generated-initcalls.c include/linux/compile.h \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/alpha/kernel/pci.c working-2.5.27-initcalls/arch/alpha/kernel/pci.c
--- linux-2.5.27/arch/alpha/kernel/pci.c	Thu May 30 10:00:47 2002
+++ working-2.5.27-initcalls/arch/alpha/kernel/pci.c	Mon Jul 22 17:45:14 2002
@@ -198,7 +198,7 @@ pcibios_init(void)
 	alpha_mv.init_pci();
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 char * __init
 pcibios_setup(char *str)
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/kernel/ecard.c working-2.5.27-initcalls/arch/arm/kernel/ecard.c
--- linux-2.5.27/arch/arm/kernel/ecard.c	Sat May 25 14:34:35 2002
+++ working-2.5.27-initcalls/arch/arm/kernel/ecard.c	Mon Jul 22 17:45:14 2002
@@ -1055,7 +1055,9 @@ void __init ecard_init(void)
 	ecard_proc_init();
 }
 
-subsys_initcall(ecard_init);
+initcall(ecard_init,
+	 init_after(pci_registration_init),
+	 init_as_part_of(bus_initcalls));
 
 EXPORT_SYMBOL(ecard_startfind);
 EXPORT_SYMBOL(ecard_find);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-footbridge/cats-pci.c working-2.5.27-initcalls/arch/arm/mach-footbridge/cats-pci.c
--- linux-2.5.27/arch/arm/mach-footbridge/cats-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.27-initcalls/arch/arm/mach-footbridge/cats-pci.c	Mon Jul 22 17:45:14 2002
@@ -52,4 +52,4 @@ static int cats_pci_init(void)
 	return 0;
 }
 
-subsys_initcall(cats_pci_init);
+initcall(cats_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-footbridge/ebsa285-pci.c working-2.5.27-initcalls/arch/arm/mach-footbridge/ebsa285-pci.c
--- linux-2.5.27/arch/arm/mach-footbridge/ebsa285-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.27-initcalls/arch/arm/mach-footbridge/ebsa285-pci.c	Mon Jul 22 17:45:14 2002
@@ -45,4 +45,4 @@ static int __init ebsa285_init_pci(void)
 	return 0;
 }
 
-subsys_initcall(ebsa285_init_pci);
+initcall(ebsa285_init_pci, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-footbridge/netwinder-pci.c working-2.5.27-initcalls/arch/arm/mach-footbridge/netwinder-pci.c
--- linux-2.5.27/arch/arm/mach-footbridge/netwinder-pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.27-initcalls/arch/arm/mach-footbridge/netwinder-pci.c	Mon Jul 22 17:45:14 2002
@@ -59,4 +59,4 @@ static int __init netwinder_pci_init(voi
 	return 0;
 }
 
-subsys_initcall(netwinder_pci_init);
+initcall(netwinder_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-footbridge/personal-pci.c working-2.5.27-initcalls/arch/arm/mach-footbridge/personal-pci.c
--- linux-2.5.27/arch/arm/mach-footbridge/personal-pci.c	Wed Jul 17 10:25:45 2002
+++ working-2.5.27-initcalls/arch/arm/mach-footbridge/personal-pci.c	Mon Jul 22 17:45:14 2002
@@ -53,4 +53,4 @@ static int __init personal_pci_init(void
 	return 0;
 }
 
-subsys_initcall(personal_pci_init);
+initcall(personal_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-ftvpci/pci.c working-2.5.27-initcalls/arch/arm/mach-ftvpci/pci.c
--- linux-2.5.27/arch/arm/mach-ftvpci/pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.27-initcalls/arch/arm/mach-ftvpci/pci.c	Mon Jul 22 17:45:14 2002
@@ -57,4 +57,4 @@ static int __init ftv_pci_init(void)
 	return 0;
 }
 
-subsys_initcall(ftv_pci_init);
+initcall(ftv_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-integrator/pci.c working-2.5.27-initcalls/arch/arm/mach-integrator/pci.c
--- linux-2.5.27/arch/arm/mach-integrator/pci.c	Sat May 25 14:34:35 2002
+++ working-2.5.27-initcalls/arch/arm/mach-integrator/pci.c	Mon Jul 22 17:45:14 2002
@@ -130,4 +130,4 @@ static int __init integrator_pci_init(vo
 	return 0;
 }
 
-subsys_initcall(integrator_pci_init);
+initcall(integrator_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-iop310/iq80310-pci.c working-2.5.27-initcalls/arch/arm/mach-iop310/iq80310-pci.c
--- linux-2.5.27/arch/arm/mach-iop310/iq80310-pci.c	Wed Jul 17 10:25:45 2002
+++ working-2.5.27-initcalls/arch/arm/mach-iop310/iq80310-pci.c	Mon Jul 22 17:45:15 2002
@@ -161,4 +161,4 @@ static int __init iq80310_pci_init(void)
 	return 0;
 }
 
-subsys_initcall(iq80310_pci_init);
+initcall(iq80310_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/arm/mach-shark/pci.c working-2.5.27-initcalls/arch/arm/mach-shark/pci.c
--- linux-2.5.27/arch/arm/mach-shark/pci.c	Sat May 25 14:34:36 2002
+++ working-2.5.27-initcalls/arch/arm/mach-shark/pci.c	Mon Jul 22 17:45:15 2002
@@ -39,4 +39,4 @@ static int __init shark_pci_init(void)
 	return 0;
 }
 
-subsys_initcall(shark_pci_init);
+initcall(shark_pci_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/kernel/mca.c working-2.5.27-initcalls/arch/i386/kernel/mca.c
--- linux-2.5.27/arch/i386/kernel/mca.c	Wed Feb 20 17:55:58 2002
+++ working-2.5.27-initcalls/arch/i386/kernel/mca.c	Mon Jul 22 17:45:15 2002
@@ -311,7 +311,7 @@ void __init mca_init(void)
 #endif
 }
 
-subsys_initcall(mca_init);
+initcall(mca_init, init_as_part_of(bus_initcalls));
 
 /*--------------------------------------------------------------------*/
 
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/acpi.c working-2.5.27-initcalls/arch/i386/pci/acpi.c
--- linux-2.5.27/arch/i386/pci/acpi.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/i386/pci/acpi.c	Mon Jul 22 17:45:15 2002
@@ -22,4 +22,4 @@ static int __init pci_acpi_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_acpi_init);
+initcall(pci_acpi_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/common.c working-2.5.27-initcalls/arch/i386/pci/common.c
--- linux-2.5.27/arch/i386/pci/common.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/i386/pci/common.c	Mon Jul 22 17:45:15 2002
@@ -139,7 +139,7 @@ static int __init pcibios_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 char * __devinit  pcibios_setup(char *str)
 {
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/direct.c working-2.5.27-initcalls/arch/i386/pci/direct.c
--- linux-2.5.27/arch/i386/pci/direct.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/i386/pci/direct.c	Mon Jul 22 17:45:15 2002
@@ -364,4 +364,6 @@ static int __init pci_direct_init(void)
 	return 0;
 }
 
-arch_initcall(pci_direct_init);
+initcall(pci_direct_init,
+	 init_as_part_of(bus_initcalls),
+	 init_after(pci_pcbios_init)); /* FIXME: Does it matter? --RR */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/irq.c working-2.5.27-initcalls/arch/i386/pci/irq.c
--- linux-2.5.27/arch/i386/pci/irq.c	Mon Jun  3 12:21:20 2002
+++ working-2.5.27-initcalls/arch/i386/pci/irq.c	Mon Jul 22 17:45:15 2002
@@ -717,7 +717,9 @@ static int __init pcibios_irq_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_irq_init);
+initcall(pcibios_irq_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
 
 void __init pcibios_fixup_irqs(void)
 {
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/legacy.c working-2.5.27-initcalls/arch/i386/pci/legacy.c
--- linux-2.5.27/arch/i386/pci/legacy.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/i386/pci/legacy.c	Mon Jul 22 17:45:15 2002
@@ -54,4 +54,6 @@ static int __init pci_legacy_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_legacy_init);
+initcall(pci_legacy_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/numa.c working-2.5.27-initcalls/arch/i386/pci/numa.c
--- linux-2.5.27/arch/i386/pci/numa.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/i386/pci/numa.c	Mon Jul 22 17:45:15 2002
@@ -120,4 +120,6 @@ static int __init pci_numa_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_numa_init);
+initcall(pci_numa_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/i386/pci/pcbios.c working-2.5.27-initcalls/arch/i386/pci/pcbios.c
--- linux-2.5.27/arch/i386/pci/pcbios.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/i386/pci/pcbios.c	Mon Jul 22 17:45:15 2002
@@ -557,4 +557,4 @@ static int __init pci_pcbios_init(void)
 	return 0;
 }
 
-arch_initcall(pci_pcbios_init);
+initcall(pci_pcbios_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ia64/hp/sim/simscsi.c working-2.5.27-initcalls/arch/ia64/hp/sim/simscsi.c
--- linux-2.5.27/arch/ia64/hp/sim/simscsi.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.27-initcalls/arch/ia64/hp/sim/simscsi.c	Mon Jul 22 17:45:15 2002
@@ -363,6 +363,7 @@ simscsi_queuecommand (Scsi_Cmnd *sc, voi
 
 static Scsi_Host_Template driver_template = SIMSCSI;
 
-#define __initcall(fn)	late_initcall(fn)
+/* FIXME: Um, really? --RR */
+#define __initcall(fn)	initcall(fn, init_after(device_initcalls))
 
 #include "../drivers/scsi/scsi_module.c"
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ia64/kernel/pci.c working-2.5.27-initcalls/arch/ia64/kernel/pci.c
--- linux-2.5.27/arch/ia64/kernel/pci.c	Thu May 30 10:00:47 2002
+++ working-2.5.27-initcalls/arch/ia64/kernel/pci.c	Mon Jul 22 17:45:15 2002
@@ -221,7 +221,7 @@ pcibios_init (void)
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 /*
  *  Called after each bus is probed, but before its children
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc/kernel/pci.c working-2.5.27-initcalls/arch/ppc/kernel/pci.c
--- linux-2.5.27/arch/ppc/kernel/pci.c	Sun Jul  7 02:12:18 2002
+++ working-2.5.27-initcalls/arch/ppc/kernel/pci.c	Mon Jul 22 17:45:15 2002
@@ -1079,7 +1079,7 @@ pcibios_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 unsigned char __init
 common_swizzle(struct pci_dev *dev, unsigned char *pinp)
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc/kernel/setup.c working-2.5.27-initcalls/arch/ppc/kernel/setup.c
--- linux-2.5.27/arch/ppc/kernel/setup.c	Wed Jul 17 10:25:46 2002
+++ working-2.5.27-initcalls/arch/ppc/kernel/setup.c	Mon Jul 22 17:45:15 2002
@@ -582,7 +582,7 @@ int __init ppc_init(void)
 	return 0;
 }
 
-arch_initcall(ppc_init);
+initcall(ppc_init, arch_init, init_after(core_initcalls));
 
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc/platforms/lopec_setup.c working-2.5.27-initcalls/arch/ppc/platforms/lopec_setup.c
--- linux-2.5.27/arch/ppc/platforms/lopec_setup.c	Sun Jul  7 02:12:18 2002
+++ working-2.5.27-initcalls/arch/ppc/platforms/lopec_setup.c	Mon Jul 22 17:45:15 2002
@@ -236,7 +236,7 @@ lopec_request_io(void)
 	return 0;
 }
 
-device_initcall(lopec_request_io);
+initcall(lopec_request_io, init_as_part_of(device_initcalls));
 
 static void __init
 lopec_map_io(void)
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc/platforms/pmac_feature.c working-2.5.27-initcalls/arch/ppc/platforms/pmac_feature.c
--- linux-2.5.27/arch/ppc/platforms/pmac_feature.c	Mon May 13 12:00:32 2002
+++ working-2.5.27-initcalls/arch/ppc/platforms/pmac_feature.c	Mon Jul 22 17:45:15 2002
@@ -2126,4 +2126,4 @@ pmac_feature_late_init(void)
 	return 0;
 }
 
-device_initcall(pmac_feature_late_init);
+initcall(pmac_feature_late_init, init_as_part_of(device_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc/platforms/pmac_setup.c working-2.5.27-initcalls/arch/ppc/platforms/pmac_setup.c
--- linux-2.5.27/arch/ppc/platforms/pmac_setup.c	Wed Jul 17 10:25:46 2002
+++ working-2.5.27-initcalls/arch/ppc/platforms/pmac_setup.c	Mon Jul 22 17:45:15 2002
@@ -444,7 +444,11 @@ static int pmac_late_init(void)
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
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc/platforms/prep_setup.c working-2.5.27-initcalls/arch/ppc/platforms/prep_setup.c
--- linux-2.5.27/arch/ppc/platforms/prep_setup.c	Wed Jul 17 10:25:46 2002
+++ working-2.5.27-initcalls/arch/ppc/platforms/prep_setup.c	Mon Jul 22 17:45:15 2002
@@ -817,7 +817,7 @@ prep_request_io(void)
 	return 0;
 }
 
-device_initcall(prep_request_io);
+initcall(prep_request_io, init_as_part_of(device_initcalls));
 
 void __init
 prep_init(unsigned long r3, unsigned long r4, unsigned long r5,
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc64/kernel/pci.c working-2.5.27-initcalls/arch/ppc64/kernel/pci.c
--- linux-2.5.27/arch/ppc64/kernel/pci.c	Mon Jun  3 12:21:20 2002
+++ working-2.5.27-initcalls/arch/ppc64/kernel/pci.c	Mon Jul 22 17:45:15 2002
@@ -498,7 +498,7 @@ pcibios_init(void)
 
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 int __init
 pcibios_assign_all_busses(void)
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/ppc64/kernel/setup.c working-2.5.27-initcalls/arch/ppc64/kernel/setup.c
--- linux-2.5.27/arch/ppc64/kernel/setup.c	Mon Jun 17 23:19:16 2002
+++ working-2.5.27-initcalls/arch/ppc64/kernel/setup.c	Mon Jul 22 17:45:15 2002
@@ -486,7 +486,7 @@ int __init ppc_init(void)
 	return 0;
 }
 
-arch_initcall(ppc_init);
+initcall(ppc_init, arch_init, init_after(core_initcalls));
 
 void __init ppc64_calibrate_delay(void)
 {
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/sparc64/kernel/pci.c working-2.5.27-initcalls/arch/sparc64/kernel/pci.c
--- linux-2.5.27/arch/sparc64/kernel/pci.c	Sun May 19 12:07:29 2002
+++ working-2.5.27-initcalls/arch/sparc64/kernel/pci.c	Mon Jul 22 17:45:15 2002
@@ -201,7 +201,7 @@ static int __init pcibios_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 struct pci_fixup pcibios_fixups[] = {
 	{ 0 }
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/x86_64/pci/acpi.c working-2.5.27-initcalls/arch/x86_64/pci/acpi.c
--- linux-2.5.27/arch/x86_64/pci/acpi.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.27-initcalls/arch/x86_64/pci/acpi.c	Mon Jul 22 17:45:15 2002
@@ -22,4 +22,4 @@ static int __init pci_acpi_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_acpi_init);
+initcall(pci_acpi_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/x86_64/pci/common.c working-2.5.27-initcalls/arch/x86_64/pci/common.c
--- linux-2.5.27/arch/x86_64/pci/common.c	Mon Jun 17 23:19:18 2002
+++ working-2.5.27-initcalls/arch/x86_64/pci/common.c	Mon Jul 22 17:45:15 2002
@@ -137,7 +137,7 @@ static int __init pcibios_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_init);
+initcall(pcibios_init, init_as_part_of(bus_initcalls));
 
 char * __devinit  pcibios_setup(char *str)
 {
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/x86_64/pci/direct.c working-2.5.27-initcalls/arch/x86_64/pci/direct.c
--- linux-2.5.27/arch/x86_64/pci/direct.c	Mon Jun 17 23:19:18 2002
+++ working-2.5.27-initcalls/arch/x86_64/pci/direct.c	Mon Jul 22 17:45:15 2002
@@ -364,4 +364,6 @@ static int __init pci_direct_init(void)
 	return 0;
 }
 
-arch_initcall(pci_direct_init);
+initcall(pci_direct_init,
+	 init_as_part_of(bus_initcalls),
+	 init_after(pci_pcbios_init)); /* FIXME: Does it matter? --RR */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/x86_64/pci/irq.c working-2.5.27-initcalls/arch/x86_64/pci/irq.c
--- linux-2.5.27/arch/x86_64/pci/irq.c	Mon Jun 17 23:19:18 2002
+++ working-2.5.27-initcalls/arch/x86_64/pci/irq.c	Mon Jul 22 17:45:15 2002
@@ -557,7 +557,9 @@ static int __init pcibios_irq_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_irq_init);
+initcall(pcibios_irq_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
 
 void __init pcibios_fixup_irqs(void)
 {
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/arch/x86_64/pci/legacy.c working-2.5.27-initcalls/arch/x86_64/pci/legacy.c
--- linux-2.5.27/arch/x86_64/pci/legacy.c	Mon Jun 17 23:19:18 2002
+++ working-2.5.27-initcalls/arch/x86_64/pci/legacy.c	Mon Jul 22 17:45:15 2002
@@ -54,4 +54,6 @@ static int __init pci_legacy_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_legacy_init);
+initcall(pci_legacy_init,
+	 init_after(pcibios_init),
+	 init_before(device_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/acpi/bus.c working-2.5.27-initcalls/drivers/acpi/bus.c
--- linux-2.5.27/drivers/acpi/bus.c	Wed Jul 17 10:25:47 2002
+++ working-2.5.27-initcalls/drivers/acpi/bus.c	Mon Jul 22 17:45:15 2002
@@ -2167,6 +2167,7 @@ acpi_setup(char *str)
 	return 1;
 }
 
-subsys_initcall(acpi_init);
+initcall(acpi_init,
+	 init_as_part_of(bus_initcalls)); /* FIXME: should it be after?-- RR */
 
 __setup("acpi=", acpi_setup);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/base/bus.c working-2.5.27-initcalls/drivers/base/bus.c
--- linux-2.5.27/drivers/base/bus.c	Mon Jun 10 16:03:48 2002
+++ working-2.5.27-initcalls/drivers/base/bus.c	Mon Jul 22 17:45:15 2002
@@ -198,13 +198,15 @@ void put_bus(struct bus_type * bus)
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
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/base/core.c working-2.5.27-initcalls/drivers/base/core.c
--- linux-2.5.27/drivers/base/core.c	Mon Jun 10 16:03:48 2002
+++ working-2.5.27-initcalls/drivers/base/core.c	Mon Jul 22 17:45:15 2002
@@ -278,7 +278,7 @@ static int __init device_init_root(void)
 	return device_register(&device_root);
 }
 
-static int __init device_init(void)
+static int __init driverfs_init(void)
 {
 	int error;
 
@@ -293,7 +293,7 @@ static int __init device_init(void)
 	return error;
 }
 
-core_initcall(device_init);
+initcall(driverfs_init, init_before(bus_initcalls));
 
 EXPORT_SYMBOL(device_register);
 EXPORT_SYMBOL(put_device);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/base/sys.c working-2.5.27-initcalls/drivers/base/sys.c
--- linux-2.5.27/drivers/base/sys.c	Mon Jun 10 16:03:48 2002
+++ working-2.5.27-initcalls/drivers/base/sys.c	Mon Jul 22 17:45:15 2002
@@ -44,6 +44,7 @@ static int sys_bus_init(void)
        return device_register(&system_bus);
 }
 
-postcore_initcall(sys_bus_init);
+initcall(sys_bus_init, init_after(driverfs_init), init_before(bus_initcalls));
+
 EXPORT_SYMBOL(register_sys_device);
 EXPORT_SYMBOL(unregister_sys_device);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/dio/dio.c working-2.5.27-initcalls/drivers/dio/dio.c
--- linux-2.5.27/drivers/dio/dio.c	Wed Feb 20 17:56:01 2002
+++ working-2.5.27-initcalls/drivers/dio/dio.c	Mon Jul 22 17:45:15 2002
@@ -208,7 +208,7 @@ void __init dio_init(void)
         }
 }
 
-subsys_initcall(dio_init);
+initcall(dio_init, init_as_part_of(bus_initcalls));
 
 /* Bear in mind that this is called in the very early stages of initialisation
  * in order to get the virtual address of the serial port for the console...
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/macintosh/mac_hid.c working-2.5.27-initcalls/drivers/macintosh/mac_hid.c
--- linux-2.5.27/drivers/macintosh/mac_hid.c	Wed Jul 17 10:25:49 2002
+++ working-2.5.27-initcalls/drivers/macintosh/mac_hid.c	Mon Jul 22 17:45:15 2002
@@ -206,4 +206,4 @@ int __init mac_hid_init(void)
 	return 0;
 }
 
-device_initcall(mac_hid_init);
+initcall(mac_hid_init, init_as_part_of(device_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/macintosh/mediabay.c working-2.5.27-initcalls/drivers/macintosh/mediabay.c
--- linux-2.5.27/drivers/macintosh/mediabay.c	Thu May 30 10:00:53 2002
+++ working-2.5.27-initcalls/drivers/macintosh/mediabay.c	Mon Jul 22 17:45:15 2002
@@ -834,4 +834,4 @@ media_bay_init(void)
 	return 0;
 }
 
-device_initcall(media_bay_init);
+initcall(media_bay_init, init_as_part_of(device_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/macintosh/via-cuda.c working-2.5.27-initcalls/drivers/macintosh/via-cuda.c
--- linux-2.5.27/drivers/macintosh/via-cuda.c	Sun May 19 12:07:30 2002
+++ working-2.5.27-initcalls/drivers/macintosh/via-cuda.c	Mon Jul 22 17:45:15 2002
@@ -204,7 +204,7 @@ static int __init via_cuda_start(void)
     return 0;
 }
 
-device_initcall(via_cuda_start);
+initcall(via_cuda_start, init_as_part_of(device_initcalls));
 
 #ifdef CONFIG_ADB
 static int
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/macintosh/via-pmu.c working-2.5.27-initcalls/drivers/macintosh/via-pmu.c
--- linux-2.5.27/drivers/macintosh/via-pmu.c	Sun May 19 12:07:30 2002
+++ working-2.5.27-initcalls/drivers/macintosh/via-pmu.c	Mon Jul 22 17:45:15 2002
@@ -394,7 +394,6 @@ pmu_init(void)
  * It happens after IDE and SCSI initialization, which can take a few
  * seconds, and by that time the PMU could have given up on us and
  * turned us off.
- * Thus this is called with arch_initcall rather than device_initcall.
  */
 static int __init via_pmu_start(void)
 {
@@ -440,10 +439,10 @@ static int __init via_pmu_start(void)
 	return 0;
 }
 
-arch_initcall(via_pmu_start);
+initcall(via_pmu_start, init_before(device_initcalls));
 
 /*
- * This has to be done after pci_init, which is a subsys_initcall.
+ * This has to be done after pci_init.
  */
 static int __init via_pmu_dev_init(void)
 {
@@ -498,7 +497,7 @@ static int __init via_pmu_dev_init(void)
 	return 0;
 }
 
-device_initcall(via_pmu_dev_init);
+initcall(via_pmu_dev_init, via_pmu_init, init_after(pci_init));
 
 static int __openfirmware
 init_pmu()
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/nubus/nubus.c working-2.5.27-initcalls/drivers/nubus/nubus.c
--- linux-2.5.27/drivers/nubus/nubus.c	Wed Feb 20 17:56:05 2002
+++ working-2.5.27-initcalls/drivers/nubus/nubus.c	Mon Jul 22 17:45:15 2002
@@ -1040,4 +1040,4 @@ void __init nubus_init(void)
 #endif
 }
 
-subsys_initcall(nubus_init);
+initcall(nubus_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/pci/pci-driver.c working-2.5.27-initcalls/drivers/pci/pci-driver.c
--- linux-2.5.27/drivers/pci/pci-driver.c	Thu Jun 20 01:28:50 2002
+++ working-2.5.27-initcalls/drivers/pci/pci-driver.c	Mon Jul 22 17:45:15 2002
@@ -199,12 +199,14 @@ struct bus_type pci_bus_type = {
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
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/pci/pci.c working-2.5.27-initcalls/drivers/pci/pci.c
--- linux-2.5.27/drivers/pci/pci.c	Mon May 13 12:00:36 2002
+++ working-2.5.27-initcalls/drivers/pci/pci.c	Mon Jul 22 17:45:15 2002
@@ -555,7 +555,7 @@ pci_dac_set_dma_mask(struct pci_dev *dev
 	return 0;
 }
 
-static int __devinit pci_init(void)
+static int __devinit pci_fixups(void)
 {
 	struct pci_dev *dev;
 
@@ -580,7 +580,7 @@ static int __devinit pci_setup(char *str
 	return 1;
 }
 
-device_initcall(pci_init);
+initcall(pci_fixups, init_after(bus_initcalls), init_before(device_initcalls));
 
 __setup("pci=", pci_setup);
 
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/pci/power.c working-2.5.27-initcalls/drivers/pci/power.c
--- linux-2.5.27/drivers/pci/power.c	Tue May 21 16:33:32 2002
+++ working-2.5.27-initcalls/drivers/pci/power.c	Mon Jul 22 17:45:15 2002
@@ -162,4 +162,5 @@ static int __init pci_pm_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_pm_init);
+initcall(pci_pm_init,
+	 init_as_part_of(bus_initcalls)); /* FIXME: should it be after?-- RR */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/pcmcia/ds.c working-2.5.27-initcalls/drivers/pcmcia/ds.c
--- linux-2.5.27/drivers/pcmcia/ds.c	Mon May 13 12:00:36 2002
+++ working-2.5.27-initcalls/drivers/pcmcia/ds.c	Mon Jul 22 17:45:15 2002
@@ -966,7 +966,7 @@ int __init init_pcmcia_ds(void)
     return 0;
 }
 
-late_initcall(init_pcmcia_ds);
+initcall(init_pcmcia_ds, init_after(device_initcalls));
 
 #ifdef MODULE
 
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/pnp/isapnp.c working-2.5.27-initcalls/drivers/pnp/isapnp.c
--- linux-2.5.27/drivers/pnp/isapnp.c	Thu Mar 21 14:14:48 2002
+++ working-2.5.27-initcalls/drivers/pnp/isapnp.c	Mon Jul 22 17:45:15 2002
@@ -2393,7 +2393,7 @@ int __init isapnp_init(void)
 	return 0;
 }
 
-subsys_initcall(isapnp_init);
+initcall(isapnp_init, init_as_part_of(bus_initcalls));
 
 #ifdef MODULE
 
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/pnp/pnpbios_core.c working-2.5.27-initcalls/drivers/pnp/pnpbios_core.c
--- linux-2.5.27/drivers/pnp/pnpbios_core.c	Sat May 25 14:34:46 2002
+++ working-2.5.27-initcalls/drivers/pnp/pnpbios_core.c	Mon Jul 22 17:45:15 2002
@@ -1218,7 +1218,7 @@ static int __init pnpbios_setup(char *st
 __setup("pnpbios=", pnpbios_setup);
 #endif
 
-subsys_initcall(pnpbios_init);
+initcall(pnpbios_init, init_as_part_of(bus_initcalls));
 
 int __init pnpbios_init(void)
 {
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/sbus/sbus.c working-2.5.27-initcalls/drivers/sbus/sbus.c
--- linux-2.5.27/drivers/sbus/sbus.c	Mon Apr 15 11:47:28 2002
+++ working-2.5.27-initcalls/drivers/sbus/sbus.c	Mon Jul 22 17:45:15 2002
@@ -517,4 +517,4 @@ static int __init sbus_init(void)
 	return 0;
 }
 
-subsys_initcall(sbus_init);
+initcall(sbus_init, init_as_part_of(bus_initcalls));
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/tc/tc.c working-2.5.27-initcalls/drivers/tc/tc.c
--- linux-2.5.27/drivers/tc/tc.c	Wed Feb 20 17:56:08 2002
+++ working-2.5.27-initcalls/drivers/tc/tc.c	Mon Jul 22 17:45:15 2002
@@ -165,7 +165,7 @@ static void __init tc_probe(unsigned lon
 /*
  * the main entry
  */
-void __init tc_init(void)
+void __init turbochannel_init(void)
 {
 	int tc_clock;
 	int i;
@@ -236,7 +236,7 @@ void __init tc_init(void)
 	}
 }
 
-subsys_initcall(tc_init);
+initcall(turbochannel_init, init_as_part_of(bus_initcalls));
 
 EXPORT_SYMBOL(search_tc_card);
 EXPORT_SYMBOL(claim_tc_card);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/usb/core/usb.c working-2.5.27-initcalls/drivers/usb/core/usb.c
--- linux-2.5.27/drivers/usb/core/usb.c	Sun Jul 21 17:43:07 2002
+++ working-2.5.27-initcalls/drivers/usb/core/usb.c	Mon Jul 22 17:45:15 2002
@@ -1510,7 +1510,7 @@ static void __exit usb_exit(void)
 	usb_hub_cleanup();
 }
 
-subsys_initcall(usb_init);
+initcall(usb_init, init_as_part_of(bus_initcalls));
 module_exit(usb_exit);
 
 /*
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/drivers/zorro/zorro.c working-2.5.27-initcalls/drivers/zorro/zorro.c
--- linux-2.5.27/drivers/zorro/zorro.c	Mon May 13 12:00:37 2002
+++ working-2.5.27-initcalls/drivers/zorro/zorro.c	Mon Jul 22 17:45:15 2002
@@ -172,7 +172,7 @@ static int __init zorro_init(void)
     return 0;
 }
 
-subsys_initcall(zorro_init);
+initcall(zorro_init, init_as_part_of(bus_initcalls));
 
 EXPORT_SYMBOL(zorro_find_device);
 EXPORT_SYMBOL(zorro_unused_z2ram);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/include/linux/init.h working-2.5.27-initcalls/include/linux/init.h
--- linux-2.5.27/include/linux/init.h	Mon Jun 10 16:03:55 2002
+++ working-2.5.27-initcalls/include/linux/init.h	Mon Jul 22 17:45:15 2002
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
@@ -86,7 +108,6 @@ extern struct kernel_param __setup_start
 #define __setup(str, fn)								\
 	static char __setup_str_##fn[] __initdata = str;				\
 	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -135,7 +156,6 @@ extern struct kernel_param __setup_start
 #define __exit
 #define __initdata
 #define __exitdata
-#define __initcall(fn)
 /* For assembly routines */
 #define __INIT
 #define __FINIT
@@ -159,14 +179,7 @@ typedef void (*__cleanup_module_func_t)(
 
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
@@ -185,5 +198,17 @@ typedef void (*__cleanup_module_func_t)(
 #define __devexitdata __exitdata
 #define __devexit_p(x)  0
 #endif
+
+/* This many levels of indirection really required */
+#define ___CAT3(a,b,c) a##_##b##_##c
+#define __CAT3(a,b,c) ___CAT3(a,b,c)
+#define __FAKENAME(fn) __CAT3(fn,KBUILD_BASENAME,__LINE__)
+
+#define ___initcall(a,...) initcall(a, __VA_ARGS__)
+
+/* Backwards compat macro: deprecated */
+#define __initcall(fn)						\
+	static int __FAKENAME(fn)(void) { return fn(); }	\
+	___initcall(__FAKENAME(fn), init_as_part_of(deprecated_initcalls))
 
 #endif /* _LINUX_INIT_H */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/init/main.c working-2.5.27-initcalls/init/main.c
--- linux-2.5.27/init/main.c	Sun Jul 21 17:43:10 2002
+++ working-2.5.27-initcalls/init/main.c	Mon Jul 22 17:45:15 2002
@@ -420,19 +420,7 @@ asmlinkage void __init start_kernel(void
 
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
@@ -484,6 +472,8 @@ static void __init do_basic_setup(void)
 
 	start_context_thread();
 	do_initcalls();
+	/* Make sure there is no pending stuff from the initcall sequence */
+	flush_scheduled_tasks();
 }
 
 extern void prepare_namespace(void);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/kernel/exec_domain.c working-2.5.27-initcalls/kernel/exec_domain.c
--- linux-2.5.27/kernel/exec_domain.c	Fri Mar  8 14:49:30 2002
+++ working-2.5.27-initcalls/kernel/exec_domain.c	Mon Jul 22 17:45:15 2002
@@ -275,14 +275,13 @@ static struct ctl_table abi_root_table[]
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
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/kernel/softirq.c working-2.5.27-initcalls/kernel/softirq.c
--- linux-2.5.27/kernel/softirq.c	Wed Jul 17 10:25:53 2002
+++ working-2.5.27-initcalls/kernel/softirq.c	Mon Jul 22 17:45:15 2002
@@ -414,4 +414,4 @@ static __init int spawn_ksoftirqd(void)
 	return 0;
 }
 
-__initcall(spawn_ksoftirqd);
+initcall(spawn_ksoftirqd, init_before(bus_initcalls)); /* Really? */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/lib/crc32.c working-2.5.27-initcalls/lib/crc32.c
--- linux-2.5.27/lib/crc32.c	Wed Feb 20 17:56:42 2002
+++ working-2.5.27-initcalls/lib/crc32.c	Mon Jul 22 18:05:44 2002
@@ -564,7 +564,7 @@ static void __exit cleanup_crc32(void)
 	crc32cleanup_be();
 }
 
-fs_initcall(init_crc32);
+initcall(init_crc32, init_after(mm_initcalls), init_before(device_initcalls));
 module_exit(cleanup_crc32);
 
 EXPORT_SYMBOL(crc32_le);
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/mm/highmem.c working-2.5.27-initcalls/mm/highmem.c
--- linux-2.5.27/mm/highmem.c	Thu Jun 20 01:28:52 2002
+++ working-2.5.27-initcalls/mm/highmem.c	Mon Jul 22 17:45:15 2002
@@ -222,7 +222,9 @@ static __init int init_emergency_pool(vo
 	return 0;
 }
 
-__initcall(init_emergency_pool);
+initcall(init_emergency_pool,
+	 init_as_part_of(mm_initcalls),
+	 init_before(mm_slab_init));
 
 /*
  * highmem version, map in to vec
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/mm/slab.c working-2.5.27-initcalls/mm/slab.c
--- linux-2.5.27/mm/slab.c	Wed Jul 17 10:25:54 2002
+++ working-2.5.27-initcalls/mm/slab.c	Mon Jul 22 17:45:15 2002
@@ -499,7 +499,7 @@ void __init kmem_cache_sizes_init(void)
 	} while (sizes->cs_size);
 }
 
-int __init kmem_cpucache_init(void)
+int __init mm_slab_init(void)
 {
 #ifdef CONFIG_SMP
 	g_cpucache_up = 1;
@@ -508,7 +508,7 @@ int __init kmem_cpucache_init(void)
 	return 0;
 }
 
-__initcall(kmem_cpucache_init);
+initcall(mm_slab_init, init_as_part_of(mm_initcalls));
 
 /* Interface to system's page allocator. No need to hold the cache-lock.
  */
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/net/irda/irsyms.c working-2.5.27-initcalls/net/irda/irsyms.c
--- linux-2.5.27/net/irda/irsyms.c	Fri Jun 21 09:41:57 2002
+++ working-2.5.27-initcalls/net/irda/irsyms.c	Mon Jul 22 17:45:15 2002
@@ -332,7 +332,7 @@ void __exit irda_cleanup(void)
  *
  * Jean II
  */
-subsys_initcall(irda_init);
+initcall(irda_init, init_before(device_initcalls));
 module_exit(irda_cleanup);
  
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> & Jean Tourrilhes <jt@hpl.hp.com>");
diff -urNp -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.27/scripts/build-initcalls working-2.5.27-initcalls/scripts/build-initcalls
--- linux-2.5.27/scripts/build-initcalls	Thu Jan  1 10:00:00 1970
+++ working-2.5.27-initcalls/scripts/build-initcalls	Mon Jul 22 17:45:15 2002
@@ -0,0 +1,119 @@
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
+TMPFILE=
+TMPFILE2=
+REGEX=
+trap 'rm -f "$TMPFILE" "$TMPFILE2" "$REGEX"' 0
+TMPFILE="`mktemp \"${TMPDIR:-/tmp}/build-initcalls.XXXXXX\"`"
+TMPFILE2="`mktemp \"${TMPDIR:-/tmp}/build-initcalls2.XXXXXX\"`"
+REGEX="`mktemp \"${TMPDIR:-/tmp}/build-real.XXXXXX\"`"
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
