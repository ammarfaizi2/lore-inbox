Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVC2Cph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVC2Cph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVC2Cpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:45:36 -0500
Received: from unknown.xeex.net ([216.152.252.175]:36100 "EHLO
	mail.intworks.biz") by vger.kernel.org with ESMTP id S262159AbVC2CpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:45:09 -0500
Date: Mon, 28 Mar 2005 18:44:57 -0800
From: jayalk@intworks.biz
Message-Id: <200503290244.j2T2ivjs014386@intworks.biz>
To: hpa@zytor.com
Subject: [RFC/PATCH 2.6.11.2 1/1] x86 reboot: Add reboot fixup for gx1/cs5530a
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riley, Dave, Peter, i386 boot/workaround maintainers,

This patch incorporates the suggestions from the previous thread.
ie: add header, use dummy macro, describe safety in help.

Please let me know if it's okay.

Thanks,
Jaya Kumar

--- 

I ran into a problem getting reboot working with 2.6.11 on an embedded
board. The board has a Geode GX1 with a CS5530A companion. What I observe on
reboot is the "Restarting system" printk, and then a cpu stall/hang. I think
the problem arises because the keyboard controller is disabled by the BIOS,
so the traditional mach_reboot()'s output to port 0x64 is ignored. Then the
386 triple fault issued after mach_reboot() results in a shutdown (because
the hardware doesn't have to detect the triple fault and issue a reset).
That then gives the end result of a stalled cpu/hang. 

I found that the CS5530A in question has a "issue system wide reset" bit.
The reboot works cleanly if I write that bit rather than do mach_reboot().
So the following patch is my attempt to incorporate that change into 2.6.11
by adding a X86_REBOOTFIXUPS option. In order to keep reboot.c free of hw
specific fixups, I put it in another file, reboot_fixups.c. I tried to make
it a bit generic so that if there are other reboot related fixups for other
chipsets/boards, there'd be a clean place to put it. Please let me know what
you think.

Thanks,
Jaya Kumar

---

Signed-off-by:  Jaya Kumar      <jayalk@intworks.biz>

diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/Kconfig linux-2.6.11.2/arch/i386/Kconfig
--- linux-2.6.11.2-vanilla/arch/i386/Kconfig	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/Kconfig	2005-03-29 09:44:58.053898616 +0800
@@ -645,6 +645,24 @@ config I8K
 	  Say Y if you intend to run this kernel on a Dell Inspiron 8000.
 	  Say N otherwise.
 
+config X86_REBOOTFIXUPS
+	bool "Enable X86 Board Specific Fixups for Reboot"
+	depends on X86 
+	default n
+	---help---
+	  This enables chipset and/or board specific fixups to be done
+	  in order to get reboot to work correctly. This is only needed on
+	  some combinations of hardware and BIOS. The symptom, for which 
+	  this config is intended, is when reboot ends with a stalled/hung 
+	  system. 
+
+	  Currently, the only fixup is for the Geode GX1/CS5530A/TROM2.1. 
+	  combination.
+
+	  Say Y if you want to enable the fixup. Currently, it's safe to
+	  enable this option even if you don't need it.
+	  Say N otherwise.
+
 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
 	---help---
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/kernel/Makefile linux-2.6.11.2/arch/i386/kernel/Makefile
--- linux-2.6.11.2-vanilla/arch/i386/kernel/Makefile	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/kernel/Makefile	2005-03-28 15:56:31.000000000 +0800
@@ -23,6 +23,7 @@ obj-$(CONFIG_X86_TRAMPOLINE)	+= trampoli
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_X86_REBOOTFIXUPS)	+= reboot_fixups.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/kernel/reboot.c linux-2.6.11.2/arch/i386/kernel/reboot.c
--- linux-2.6.11.2-vanilla/arch/i386/kernel/reboot.c	2005-03-10 16:31:25.000000000 +0800
+++ linux-2.6.11.2/arch/i386/kernel/reboot.c	2005-03-29 09:35:19.858797632 +0800
@@ -13,6 +13,7 @@
 #include <asm/uaccess.h>
 #include <asm/apic.h>
 #include "mach_reboot.h"
+#include <linux/reboot_fixups.h>
 
 /*
  * Power off function, if any
@@ -348,6 +349,7 @@ void machine_restart(char * __unused)
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
 		for (;;) {
+			mach_reboot_fixups(); /* for board specific fixups */
 			mach_reboot();
 			/* That didn't work - force a triple fault.. */
 			__asm__ __volatile__("lidt %0": :"m" (no_idt));
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/arch/i386/kernel/reboot_fixups.c linux-2.6.11.2/arch/i386/kernel/reboot_fixups.c
--- linux-2.6.11.2-vanilla/arch/i386/kernel/reboot_fixups.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.11.2/arch/i386/kernel/reboot_fixups.c	2005-03-29 09:34:06.404964312 +0800
@@ -0,0 +1,53 @@
+/*
+ * linux/arch/i386/kernel/reboot_fixups.c
+ * 
+ * This is a good place to put board specific reboot fixups.
+ *
+ */
+
+#include <asm/delay.h>
+#include <linux/pci.h>
+
+void cs5530a_warm_reset(struct pci_dev *dev)
+{
+	/* writing 1 to the reset control register, 0x44 causes the 
+	cs5530a to perform a system warm reset */
+	pci_write_config_byte(dev, 0x44, 0x1);
+	udelay(50); /* shouldn't get here but be safe and spin-a-while */
+	return; 
+}
+
+struct device_fixup {
+	unsigned int vendor;
+	unsigned int device;
+	void (*reboot_fixup)(struct pci_dev *);
+};
+
+struct device_fixup fixups_table[] = {
+	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_LEGACY, cs5530a_warm_reset },
+};
+
+/*
+ * we see if any fixup is available for our current hardware. if there
+ * is a fixup, we call it and we expect to never return from it. if we
+ * do return, we keep looking and then eventually fall back to the
+ * standard mach_reboot on return.
+ */
+void mach_reboot_fixups(void)
+{
+	struct device_fixup *cur;
+	struct pci_dev *dev;
+	int i;
+
+	for (i=0; i < (sizeof(fixups_table)/sizeof(fixups_table[0])); i++) {
+		cur = &(fixups_table[i]);
+		dev = pci_find_device(cur->vendor, cur->device, 0);
+		if (!dev) 
+			continue;
+
+		cur->reboot_fixup(dev);
+	}
+	
+	printk(KERN_WARNING "No reboot fixup found for your hardware\n");
+}
+
diff -uprN -X dontdiff linux-2.6.11.2-vanilla/include/linux/reboot_fixups.h linux-2.6.11.2/include/linux/reboot_fixups.h
--- linux-2.6.11.2-vanilla/include/linux/reboot_fixups.h	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.11.2/include/linux/reboot_fixups.h	2005-03-29 10:05:17.000000000 +0800
@@ -0,0 +1,10 @@
+#ifndef _LINUX_REBOOT_FIXUPS_H
+#define _LINUX_REBOOT_FIXUPS_H
+
+#ifdef CONFIG_X86_REBOOTFIXUPS
+extern void mach_reboot_fixups(void);
+#else
+#define mach_reboot_fixups(x) do {} while (0)
+#endif
+
+#endif /* _LINUX_REBOOT_FIXUPS_H */
