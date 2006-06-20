Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWFTXm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWFTXm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWFTXm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:42:58 -0400
Received: from gw.goop.org ([64.81.55.164]:44436 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751863AbWFTXm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:42:57 -0400
Message-ID: <44988803.5090305@goop.org>
Date: Tue, 20 Jun 2006 16:42:59 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Fitzhardinge <jeremy@xensource.com>

Clean up and refactor i386 sub-architecture setup.

This change moves all the code from the 
asm-i386/mach-*/setup_arch_pre/post.h headers, into 
arch/i386/mach-*/setup.c.  mach-*/setup_arch_pre.h is renamed to 
setup_arch.h, and contains only things which should be in header files.  
It is purely code-motion; there should be no functional changes at all.

Several functions in arch/i386/kernel/setup.c needed to be made 
non-static so that they're visible to the code in mach-*/setup.c. 
asm-i386/setup.h is used to hold the prototypes for these functions.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/setup.c                        |   19 +-----
 arch/i386/mach-default/setup.c                  |   43 +++++++++++++
 arch/i386/mach-visws/setup.c                    |   49 +++++++++++++++
 arch/i386/mach-voyager/setup.c                  |   74 ++++++++++++++++++++++++
 include/asm-i386/mach-default/setup_arch.h      |    5 +
 include/asm-i386/mach-default/setup_arch_post.h |   40 ------------
 include/asm-i386/mach-default/setup_arch_pre.h  |    5 -
 include/asm-i386/mach-visws/setup_arch.h        |    5 +
 include/asm-i386/mach-visws/setup_arch_post.h   |   49 ---------------
 include/asm-i386/mach-visws/setup_arch_pre.h    |    5 -
 include/asm-i386/mach-voyager/setup_arch.h      |   10 +++
 include/asm-i386/mach-voyager/setup_arch_post.h |   73 -----------------------
 include/asm-i386/mach-voyager/setup_arch_pre.h  |   10 ---
 include/asm-i386/setup.h                        |   15 ++++
 14 files changed, 206 insertions(+), 196 deletions(-)


diff -r 1b4d97a1b760 arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Jun 08 23:00:14 2006 +0000
+++ b/arch/i386/kernel/setup.c	Tue Jun 13 17:35:21 2006 -0700
@@ -60,7 +60,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
-#include "setup_arch_pre.h"
+#include <setup_arch.h>
 #include <bios_ebda.h>
 
 /* Forward Declaration. */
@@ -410,8 +410,8 @@ static void __init limit_regions(unsigne
 	}
 }
 
-static void __init add_memory_region(unsigned long long start,
-                                  unsigned long long size, int type)
+void __init add_memory_region(unsigned long long start,
+			      unsigned long long size, int type)
 {
 	int x;
 
@@ -474,7 +474,7 @@ static struct e820entry *overlap_list[E8
 static struct e820entry *overlap_list[E820MAX] __initdata;
 static struct e820entry new_bios[E820MAX] __initdata;
 
-static int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
+int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
 {
 	struct change_member *change_tmp;
 	unsigned long current_type, last_type;
@@ -643,7 +643,7 @@ static int __init sanitize_e820_map(stru
  * thinkpad 560x, for example, does not cooperate with the memory
  * detection code.)
  */
-static int __init copy_e820_map(struct e820entry * biosmap, int nr_map)
+int __init copy_e820_map(struct e820entry * biosmap, int nr_map)
 {
 	/* Only one memory region (or negative)? Ignore it */
 	if (nr_map < 2)
@@ -700,12 +700,6 @@ static inline void copy_edd(void)
 {
 }
 #endif
-
-/*
- * Do NOT EVER look at the BIOS memory size location.
- * It does not work on many machines.
- */
-#define LOWMEMSIZE()	(0x9f000)
 
 static void __init parse_cmdline_early (char ** cmdline_p)
 {
@@ -1423,8 +1417,6 @@ static void __init register_memory(void)
 		pci_mem_start, gapstart, gapsize);
 }
 
-static char * __init machine_specific_memory_setup(void);
-
 #ifdef CONFIG_MCA
 static void set_mca_bus(int x)
 {
@@ -1602,7 +1594,6 @@ static __init int add_pcspkr(void)
 }
 device_initcall(add_pcspkr);
 
-#include "setup_arch_post.h"
 /*
  * Local Variables:
  * mode:c
diff -r 1b4d97a1b760 arch/i386/mach-default/setup.c
--- a/arch/i386/mach-default/setup.c	Thu Jun 08 23:00:14 2006 +0000
+++ b/arch/i386/mach-default/setup.c	Tue Jun 13 17:35:21 2006 -0700
@@ -8,6 +8,8 @@
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
+#include <asm/e820.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
@@ -130,3 +132,44 @@ static int __init print_ipi_mode(void)
 }
 
 late_initcall(print_ipi_mode);
+
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+
+
+	who = "BIOS-e820";
+
+	/*
+	 * Try to copy the BIOS-supplied E820-map.
+	 *
+	 * Otherwise fake a memory map; one section from 0k->640k,
+	 * the next section from 1mb->appropriate_mem_k
+	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
+	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+		unsigned long mem_size;
+
+		/* compare results from other methods and take the greater */
+		if (ALT_MEM_K < EXT_MEM_K) {
+			mem_size = EXT_MEM_K;
+			who = "BIOS-88";
+		} else {
+			mem_size = ALT_MEM_K;
+			who = "BIOS-e801";
+		}
+
+		e820.nr_map = 0;
+		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+  	}
+	return who;
+}
diff -r 1b4d97a1b760 arch/i386/mach-visws/setup.c
--- a/arch/i386/mach-visws/setup.c	Thu Jun 08 23:00:14 2006 +0000
+++ b/arch/i386/mach-visws/setup.c	Tue Jun 13 17:35:21 2006 -0700
@@ -10,6 +10,8 @@
 #include <asm/fixmap.h>
 #include <asm/arch_hooks.h>
 #include <asm/io.h>
+#include <asm/e820.h>
+#include <asm/setup.h>
 #include "cobalt.h"
 #include "piix4.h"
 
@@ -133,3 +135,50 @@ void __init time_init_hook(void)
 	/* Wire cpu IDT entry to s/w handler (and Cobalt APIC to IDT) */
 	setup_irq(0, &irq0);
 }
+
+/* Hook for machine specific memory setup. */
+
+#define MB (1024 * 1024)
+
+static unsigned long sgivwfb_mem_phys;
+static unsigned long sgivwfb_mem_size;
+
+long long mem_size __initdata = 0;
+
+char * __init machine_specific_memory_setup(void)
+{
+	long long gfx_mem_size = 8 * MB;
+
+	mem_size = ALT_MEM_K;
+
+	if (!mem_size) {
+		printk(KERN_WARNING "Bootloader didn't set memory size, upgrade it !\n");
+		mem_size = 128 * MB;
+	}
+
+	/*
+	 * this hardcodes the graphics memory to 8 MB
+	 * it really should be sized dynamically (or at least
+	 * set as a boot param)
+	 */
+	if (!sgivwfb_mem_size) {
+		printk(KERN_WARNING "Defaulting to 8 MB framebuffer size\n");
+		sgivwfb_mem_size = 8 * MB;
+	}
+
+	/*
+	 * Trim to nearest MB
+	 */
+	sgivwfb_mem_size &= ~((1 << 20) - 1);
+	sgivwfb_mem_phys = mem_size - gfx_mem_size;
+
+	add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+	add_memory_region(HIGH_MEMORY, mem_size - sgivwfb_mem_size - HIGH_MEMORY, E820_RAM);
+	add_memory_region(sgivwfb_mem_phys, sgivwfb_mem_size, E820_RESERVED);
+
+	return "PROM";
+
+	/* Remove gcc warnings */
+	(void) sanitize_e820_map(NULL, NULL);
+	(void) copy_e820_map(NULL, 0);
+}
diff -r 1b4d97a1b760 arch/i386/mach-voyager/setup.c
--- a/arch/i386/mach-voyager/setup.c	Thu Jun 08 23:00:14 2006 +0000
+++ b/arch/i386/mach-voyager/setup.c	Tue Jun 13 17:35:21 2006 -0700
@@ -7,6 +7,9 @@
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
+#include <asm/voyager.h>
+#include <asm/e820.h>
+#include <asm/setup.h>
 
 void __init pre_intr_init_hook(void)
 {
@@ -45,3 +48,74 @@ void __init time_init_hook(void)
 {
 	setup_irq(0, &irq0);
 }
+
+/* Hook for machine specific memory setup. */
+
+char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+
+	who = "NOT VOYAGER";
+
+	if(voyager_level == 5) {
+		__u32 addr, length;
+		int i;
+
+		who = "Voyager-SUS";
+
+		e820.nr_map = 0;
+		for(i=0; voyager_memory_detect(i, &addr, &length); i++) {
+			add_memory_region(addr, length, E820_RAM);
+		}
+		return who;
+	} else if(voyager_level == 4) {
+		__u32 tom;
+		__u16 catbase = inb(VOYAGER_SSPB_RELOCATION_PORT)<<8;
+		/* select the DINO config space */
+		outb(VOYAGER_DINO, VOYAGER_CAT_CONFIG_PORT);
+		/* Read DINO top of memory register */
+		tom = ((inb(catbase + 0x4) & 0xf0) << 16)
+			+ ((inb(catbase + 0x5) & 0x7f) << 24);
+
+		if(inb(catbase) != VOYAGER_DINO) {
+			printk(KERN_ERR "Voyager: Failed to get DINO for L4, setting tom to EXT_MEM_K\n");
+			tom = (EXT_MEM_K)<<10;
+		}
+		who = "Voyager-TOM";
+		add_memory_region(0, 0x9f000, E820_RAM);
+		/* map from 1M to top of memory */
+		add_memory_region(1*1024*1024, tom - 1*1024*1024, E820_RAM);
+		/* FIXME: Should check the ASICs to see if I need to
+		 * take out the 8M window.  Just do it at the moment
+		 * */
+		add_memory_region(8*1024*1024, 8*1024*1024, E820_RESERVED);
+		return who;
+	}
+
+	who = "BIOS-e820";
+
+	/*
+	 * Try to copy the BIOS-supplied E820-map.
+	 *
+	 * Otherwise fake a memory map; one section from 0k->640k,
+	 * the next section from 1mb->appropriate_mem_k
+	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
+	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+		unsigned long mem_size;
+
+		/* compare results from other methods and take the greater */
+		if (ALT_MEM_K < EXT_MEM_K) {
+			mem_size = EXT_MEM_K;
+			who = "BIOS-88";
+		} else {
+			mem_size = ALT_MEM_K;
+			who = "BIOS-e801";
+		}
+
+		e820.nr_map = 0;
+		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+  	}
+	return who;
+}
diff -r 1b4d97a1b760 include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Thu Jun 08 23:00:14 2006 +0000
+++ b/include/asm-i386/setup.h	Tue Jun 13 17:35:21 2006 -0700
@@ -59,6 +59,21 @@ extern unsigned char boot_params[PARAM_S
 #define EDD_MBR_SIGNATURE ((unsigned int *) (PARAM+EDD_MBR_SIG_BUF))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 
+/*
+ * Do NOT EVER look at the BIOS memory size location.
+ * It does not work on many machines.
+ */
+#define LOWMEMSIZE()	(0x9f000)
+
+struct e820entry;
+
+char * __init machine_specific_memory_setup(void);
+
+int __init copy_e820_map(struct e820entry * biosmap, int nr_map);
+int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map);
+void __init add_memory_region(unsigned long long start,
+			      unsigned long long size, int type);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _i386_SETUP_H */
diff -r 1b4d97a1b760 include/asm-i386/mach-default/setup_arch.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/setup_arch.h	Tue Jun 13 17:35:21 2006 -0700
@@ -0,0 +1,5 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for generic */
+
+#define ARCH_SETUP
diff -r 1b4d97a1b760 include/asm-i386/mach-visws/setup_arch.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-visws/setup_arch.h	Tue Jun 13 17:35:21 2006 -0700
@@ -0,0 +1,5 @@
+/* Hook to call BIOS initialisation function */
+
+/* no action for visws */
+
+#define ARCH_SETUP
diff -r 1b4d97a1b760 include/asm-i386/mach-voyager/setup_arch.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-voyager/setup_arch.h	Tue Jun 13 17:35:21 2006 -0700
@@ -0,0 +1,10 @@
+#include <asm/voyager.h>
+#define VOYAGER_BIOS_INFO ((struct voyager_bios_info *)(PARAM+0x40))
+
+/* Hook to call BIOS initialisation function */
+
+/* for voyager, pass the voyager BIOS/SUS info area to the detection 
+ * routines */
+
+#define ARCH_SETUP	voyager_detect(VOYAGER_BIOS_INFO);
+
diff -r 1b4d97a1b760 include/asm-i386/mach-default/setup_arch_post.h
--- a/include/asm-i386/mach-default/setup_arch_post.h	Thu Jun 08 23:00:14 2006 +0000
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,40 +0,0 @@
-/**
- * machine_specific_memory_setup - Hook for machine specific memory setup.
- *
- * Description:
- *	This is included late in kernel/setup.c so that it can make
- *	use of all of the static functions.
- **/
-
-static char * __init machine_specific_memory_setup(void)
-{
-	char *who;
-
-
-	who = "BIOS-e820";
-
-	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
-	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
-}
diff -r 1b4d97a1b760 include/asm-i386/mach-visws/setup_arch_post.h
--- a/include/asm-i386/mach-visws/setup_arch_post.h	Thu Jun 08 23:00:14 2006 +0000
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,49 +0,0 @@
-/* Hook for machine specific memory setup.
- *
- * This is included late in kernel/setup.c so that it can make use of all of
- * the static functions. */
-
-#define MB (1024 * 1024)
-
-unsigned long sgivwfb_mem_phys;
-unsigned long sgivwfb_mem_size;
-
-long long mem_size __initdata = 0;
-
-static char * __init machine_specific_memory_setup(void)
-{
-	long long gfx_mem_size = 8 * MB;
-
-	mem_size = ALT_MEM_K;
-
-	if (!mem_size) {
-		printk(KERN_WARNING "Bootloader didn't set memory size, upgrade it !\n");
-		mem_size = 128 * MB;
-	}
-
-	/*
-	 * this hardcodes the graphics memory to 8 MB
-	 * it really should be sized dynamically (or at least
-	 * set as a boot param)
-	 */
-	if (!sgivwfb_mem_size) {
-		printk(KERN_WARNING "Defaulting to 8 MB framebuffer size\n");
-		sgivwfb_mem_size = 8 * MB;
-	}
-
-	/*
-	 * Trim to nearest MB
-	 */
-	sgivwfb_mem_size &= ~((1 << 20) - 1);
-	sgivwfb_mem_phys = mem_size - gfx_mem_size;
-
-	add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-	add_memory_region(HIGH_MEMORY, mem_size - sgivwfb_mem_size - HIGH_MEMORY, E820_RAM);
-	add_memory_region(sgivwfb_mem_phys, sgivwfb_mem_size, E820_RESERVED);
-
-	return "PROM";
-
-	/* Remove gcc warnings */
-	(void) sanitize_e820_map(NULL, NULL);
-	(void) copy_e820_map(NULL, 0);
-}
diff -r 1b4d97a1b760 include/asm-i386/mach-voyager/setup_arch_post.h
--- a/include/asm-i386/mach-voyager/setup_arch_post.h	Thu Jun 08 23:00:14 2006 +0000
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,73 +0,0 @@
-/* Hook for machine specific memory setup.
- *
- * This is included late in kernel/setup.c so that it can make use of all of
- * the static functions. */
-
-static char * __init machine_specific_memory_setup(void)
-{
-	char *who;
-
-	who = "NOT VOYAGER";
-
-	if(voyager_level == 5) {
-		__u32 addr, length;
-		int i;
-
-		who = "Voyager-SUS";
-
-		e820.nr_map = 0;
-		for(i=0; voyager_memory_detect(i, &addr, &length); i++) {
-			add_memory_region(addr, length, E820_RAM);
-		}
-		return who;
-	} else if(voyager_level == 4) {
-		__u32 tom;
-		__u16 catbase = inb(VOYAGER_SSPB_RELOCATION_PORT)<<8;
-		/* select the DINO config space */
-		outb(VOYAGER_DINO, VOYAGER_CAT_CONFIG_PORT);
-		/* Read DINO top of memory register */
-		tom = ((inb(catbase + 0x4) & 0xf0) << 16)
-			+ ((inb(catbase + 0x5) & 0x7f) << 24);
-
-		if(inb(catbase) != VOYAGER_DINO) {
-			printk(KERN_ERR "Voyager: Failed to get DINO for L4, setting tom to EXT_MEM_K\n");
-			tom = (EXT_MEM_K)<<10;
-		}
-		who = "Voyager-TOM";
-		add_memory_region(0, 0x9f000, E820_RAM);
-		/* map from 1M to top of memory */
-		add_memory_region(1*1024*1024, tom - 1*1024*1024, E820_RAM);
-		/* FIXME: Should check the ASICs to see if I need to
-		 * take out the 8M window.  Just do it at the moment
-		 * */
-		add_memory_region(8*1024*1024, 8*1024*1024, E820_RESERVED);
-		return who;
-	}
-
-	who = "BIOS-e820";
-
-	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
-	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
-}
diff -r 1b4d97a1b760 include/asm-i386/mach-default/setup_arch_pre.h
--- a/include/asm-i386/mach-default/setup_arch_pre.h	Thu Jun 08 23:00:14 2006 +0000
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,5 +0,0 @@
-/* Hook to call BIOS initialisation function */
-
-/* no action for generic */
-
-#define ARCH_SETUP
diff -r 1b4d97a1b760 include/asm-i386/mach-visws/setup_arch_pre.h
--- a/include/asm-i386/mach-visws/setup_arch_pre.h	Thu Jun 08 23:00:14 2006 +0000
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,5 +0,0 @@
-/* Hook to call BIOS initialisation function */
-
-/* no action for visws */
-
-#define ARCH_SETUP
diff -r 1b4d97a1b760 include/asm-i386/mach-voyager/setup_arch_pre.h
--- a/include/asm-i386/mach-voyager/setup_arch_pre.h	Thu Jun 08 23:00:14 2006 +0000
+++ /dev/null	Thu Jan 01 00:00:00 1970 +0000
@@ -1,10 +0,0 @@
-#include <asm/voyager.h>
-#define VOYAGER_BIOS_INFO ((struct voyager_bios_info *)(PARAM+0x40))
-
-/* Hook to call BIOS initialisation function */
-
-/* for voyager, pass the voyager BIOS/SUS info area to the detection 
- * routines */
-
-#define ARCH_SETUP	voyager_detect(VOYAGER_BIOS_INFO);
-


