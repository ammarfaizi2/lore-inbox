Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265562AbRFVXPX>; Fri, 22 Jun 2001 19:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbRFVXPO>; Fri, 22 Jun 2001 19:15:14 -0400
Received: from ruckus.brouhaha.com ([209.185.79.17]:30602 "HELO brouhaha.com")
	by vger.kernel.org with SMTP id <S265562AbRFVXPA>;
	Fri, 22 Jun 2001 19:15:00 -0400
Date: 22 Jun 2001 23:14:57 -0000
Message-ID: <20010622231457.11642.qmail@brouhaha.com>
From: Eric Smith <eric@brouhaha.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0106161111041.9713-100000@penguin.transmeta.com>
	(message from Linus Torvalds on Sat, 16 Jun 2001 11:15:04 -0700 (PDT))
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <Pine.LNX.4.21.0106161111041.9713-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Does it make sense to turn pcibios_assign_all_busses into a variable
> with a default value of zero, and implement a kernel argument to set it?

After some discussion of various alternatives, including always turning it
on (bad for some systems), or writing a function to try to determine if
the configuration left by the BIOS is sane (maybe OK, but could still need
to be overridden), Linus wrote:
> Regardless, it would certainly make sense to have a manual override, with
> a kernel command line. If for no other reason than to allow for mistakes
> and let the user force the old/new behaviour.

Since I offered to generate a suitable patch, below find one against
2.4.5.  This patch ONLY tries to provide for the command line override.
I had to touch more files than I would have liked, and unfortunately can
only test it on x86 even though it potentially affects other
architectures.  It seems to do the right thing on my IBM ThinkPad 240.

What I've done is:

1)  Replaced the pcibios_assign_all_busses() macro in each architecture
    with a defined constant PCI_ASSIGN_ALL_BUSSES_DEFAULT.  Note that some
    architectures were using a function instead of a macro, but the function
    just returned the contents of a variable.

2)  Added the variable pci_assign_all_busses, which gets initialized from
    the defined constant PCI_ASSIGN_ALL_BUSSES_DEFAULT.

3)  Added a __setup macro and function to handle a command line argument
    "pci_assign_all_busses=1" (or zero), which sets the pci_assign_all_busses
    variable.

4)  Changed the code in drivers/pci/pci.c to use the variable rather than
    the old macro/function.

If code is added to attempt to automatically determine whether bus
configuration is needed, and if that code runs after the command line is
parsed, it might be necessary to add a second variable (or special
values of the existing one) to avoid changing the variable if the user
has specified a value on the command line, since the whole point is to
allow the user to override the default behavior.

If I've done this in a suboptimal manner, I'd be happy to hear
suggestions of better approaches.  As submitting kernel patches goes,
this is my first time, so please be gentle.  :-)

Thanks,
Eric



diff -uNr linux-2.4.5.orig/arch/parisc/kernel/inventory.c linux-2.4.5/arch/parisc/kernel/inventory.c
--- linux-2.4.5.orig/arch/parisc/kernel/inventory.c	Wed Dec  6 11:46:39 2000
+++ linux-2.4.5/arch/parisc/kernel/inventory.c	Thu Jun 21 18:26:52 2001
@@ -138,6 +138,7 @@
 	ulong pcell_loc;
 
 	pdc_pat = (pdc_pat_cell_get_number(&pdc_result) == PDC_OK);
+	pci_assign_all_busses = pdc_pat;
 	if (!pdc_pat)
 	{
 		return 0;
diff -uNr linux-2.4.5.orig/arch/ppc/kernel/pci.c linux-2.4.5/arch/ppc/kernel/pci.c
--- linux-2.4.5.orig/arch/ppc/kernel/pci.c	Mon May 21 17:04:47 2001
+++ linux-2.4.5/arch/ppc/kernel/pci.c	Thu Jun 21 18:26:52 2001
@@ -47,10 +47,6 @@
 static void pcibios_fixup_cardbus(struct pci_dev* dev);
 #endif
 
-/* By default, we don't re-assign bus numbers. We do this only on
- * some pmacs
- */
-int pci_assign_all_busses;
 
 struct pci_controller* hose_head;
 struct pci_controller** hose_tail = &hose_head;
@@ -752,11 +748,6 @@
 		ppc_md.pcibios_after_init();
 }
 
-int __init
-pcibios_assign_all_busses(void)
-{
-	return pci_assign_all_busses;
-}
 
 void __init
 pcibios_fixup_pbus_ranges(struct pci_bus * bus, struct pbus_set_ranges_data * ranges)
diff -uNr linux-2.4.5.orig/drivers/pci/pci.c linux-2.4.5/drivers/pci/pci.c
--- linux-2.4.5.orig/drivers/pci/pci.c	Sat May 19 17:43:06 2001
+++ linux-2.4.5/drivers/pci/pci.c	Thu Jun 21 18:26:52 2001
@@ -37,6 +37,19 @@
 LIST_HEAD(pci_root_buses);
 LIST_HEAD(pci_devices);
 
+
+int pci_assign_all_busses = PCI_ASSIGN_ALL_BUSSES_DEFAULT;
+
+
+static int __init pci_assign_all_busses_setup(char *str)
+{
+	pci_assign_all_busses = simple_strtol(str,NULL,0);
+	return 1;
+}
+
+__setup("pci_assign_all_busses=", pci_assign_all_busses_setup);
+
+
 /**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
@@ -957,7 +970,7 @@
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n", dev->slot_name, buses & 0xffffff, pass);
-	if ((buses & 0xffff00) && !pcibios_assign_all_busses()) {
+	if ((buses & 0xffff00) && !pci_assign_all_busses) {
 		/*
 		 * Bus already configured by firmware, process it in the first
 		 * pass and just note the configuration.
diff -uNr linux-2.4.5.orig/include/asm-alpha/pci.h linux-2.4.5/include/asm-alpha/pci.h
--- linux-2.4.5.orig/include/asm-alpha/pci.h	Mon May 21 13:38:41 2001
+++ linux-2.4.5/include/asm-alpha/pci.h	Thu Jun 21 18:26:52 2001
@@ -46,7 +46,7 @@
 /* Override the logic in pci_scan_bus for skipping already-configured
    bus numbers.  */
 
-#define pcibios_assign_all_busses()	1
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 1
 
 #define PCIBIOS_MIN_IO		alpha_mv.min_io_address
 #define PCIBIOS_MIN_MEM		alpha_mv.min_mem_address
diff -uNr linux-2.4.5.orig/include/asm-arm/arch-ebsa285/hardware.h linux-2.4.5/include/asm-arm/arch-ebsa285/hardware.h
--- linux-2.4.5.orig/include/asm-arm/arch-ebsa285/hardware.h	Mon Nov 27 17:07:59 2000
+++ linux-2.4.5/include/asm-arm/arch-ebsa285/hardware.h	Thu Jun 21 18:26:52 2001
@@ -131,7 +131,7 @@
 extern void cpld_modify(int mask, int set);
 #endif
 
-#define pcibios_assign_all_busses()	1
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 1
 
 #define PCIBIOS_MIN_IO		0x6000
 #define PCIBIOS_MIN_MEM 	0x40000000
diff -uNr linux-2.4.5.orig/include/asm-i386/pci.h linux-2.4.5/include/asm-i386/pci.h
--- linux-2.4.5.orig/include/asm-i386/pci.h	Fri May 25 18:02:07 2001
+++ linux-2.4.5/include/asm-i386/pci.h	Thu Jun 21 18:26:52 2001
@@ -7,7 +7,7 @@
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
 
-#define pcibios_assign_all_busses()	0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 extern unsigned long pci_mem_start;
 #define PCIBIOS_MIN_IO		0x1000
diff -uNr linux-2.4.5.orig/include/asm-ia64/pci.h linux-2.4.5/include/asm-ia64/pci.h
--- linux-2.4.5.orig/include/asm-ia64/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-ia64/pci.h	Thu Jun 21 18:26:52 2001
@@ -14,7 +14,7 @@
  * already-configured bus numbers - to be used for buggy BIOSes or
  * architectures with incomplete PCI setup by the loader.
  */
-#define pcibios_assign_all_busses()     0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -uNr linux-2.4.5.orig/include/asm-m68k/pci.h linux-2.4.5/include/asm-m68k/pci.h
--- linux-2.4.5.orig/include/asm-m68k/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-m68k/pci.h	Thu Jun 21 18:26:52 2001
@@ -33,7 +33,7 @@
 	void (*conf_device)(unsigned char bus, unsigned char device_fn);
 };
 
-#define pcibios_assign_all_busses()	0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 extern inline void pcibios_set_master(struct pci_dev *dev)
 {
diff -uNr linux-2.4.5.orig/include/asm-mips/pci.h linux-2.4.5/include/asm-mips/pci.h
--- linux-2.4.5.orig/include/asm-mips/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-mips/pci.h	Thu Jun 21 18:26:52 2001
@@ -13,7 +13,7 @@
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
 
-#define pcibios_assign_all_busses()	0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -uNr linux-2.4.5.orig/include/asm-mips64/pci.h linux-2.4.5/include/asm-mips64/pci.h
--- linux-2.4.5.orig/include/asm-mips64/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-mips64/pci.h	Thu Jun 21 18:26:52 2001
@@ -13,7 +13,7 @@
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
 
-#define pcibios_assign_all_busses()	0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -uNr linux-2.4.5.orig/include/asm-parisc/pci.h linux-2.4.5/include/asm-parisc/pci.h
--- linux-2.4.5.orig/include/asm-parisc/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-parisc/pci.h	Thu Jun 21 18:26:52 2001
@@ -204,9 +204,8 @@
 */
 #ifdef __LP64__
 extern int pdc_pat;  /* arch/parisc/kernel/inventory.c */
-#define pcibios_assign_all_busses()	pdc_pat
-#else
-#define pcibios_assign_all_busses()	0
+extern int pci_assign_all_busses;  /* drivers/pci/pci.c */
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 #endif
 
 #define PCIBIOS_MIN_IO          0x10
diff -uNr linux-2.4.5.orig/include/asm-ppc/pci.h linux-2.4.5/include/asm-ppc/pci.h
--- linux-2.4.5.orig/include/asm-ppc/pci.h	Mon May 21 15:02:06 2001
+++ linux-2.4.5/include/asm-ppc/pci.h	Thu Jun 21 18:26:52 2001
@@ -13,7 +13,11 @@
 #define IOBASE_ISA_MEM		4
 
 
-extern int pcibios_assign_all_busses(void);
+/* By default, we don't re-assign bus numbers. We do this only on
+ * some pmacs
+ */
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
+extern int pci_assign_all_busses;  /* drivers/pci/pci.c */
 
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM		0x10000000
diff -uNr linux-2.4.5.orig/include/asm-sh/pci.h linux-2.4.5/include/asm-sh/pci.h
--- linux-2.4.5.orig/include/asm-sh/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-sh/pci.h	Thu Jun 21 18:28:48 2001
@@ -7,7 +7,7 @@
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
 
-#define pcibios_assign_all_busses()	1
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 1
 
 /* These are currently the correct values for the STM overdrive board. 
  * We need some way of setting this on a board specific way, it will 
diff -uNr linux-2.4.5.orig/include/asm-sparc/pci.h linux-2.4.5/include/asm-sparc/pci.h
--- linux-2.4.5.orig/include/asm-sparc/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-sparc/pci.h	Thu Jun 21 18:26:52 2001
@@ -7,7 +7,7 @@
  * already-configured bus numbers - to be used for buggy BIOSes
  * or architectures with incomplete PCI setup by the loader.
  */
-#define pcibios_assign_all_busses()	0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
diff -uNr linux-2.4.5.orig/include/asm-sparc64/pci.h linux-2.4.5/include/asm-sparc64/pci.h
--- linux-2.4.5.orig/include/asm-sparc64/pci.h	Wed May 16 10:31:27 2001
+++ linux-2.4.5/include/asm-sparc64/pci.h	Thu Jun 21 18:26:52 2001
@@ -10,7 +10,7 @@
  * already-configured bus numbers - to be used for buggy BIOSes
  * or architectures with incomplete PCI setup by the loader.
  */
-#define pcibios_assign_all_busses()	0
+#define PCI_ASSIGN_ALL_BUSSES_DEFAULT 0
 
 #define PCIBIOS_MIN_IO		0UL
 #define PCIBIOS_MIN_MEM		0UL
