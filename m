Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWADWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWADWQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWADWQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:16:53 -0500
Received: from linux.us.dell.com ([143.166.224.162]:39034 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S1750910AbWADWQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:16:51 -0500
Date: Wed, 4 Jan 2006 16:16:27 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
Message-ID: <20060104221627.GA26064@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen has a patch in his x86_64 tree which enables the use of
i386 dmi_scan.c on x86_64.  dmi_scan.c functions are being used by the
drivers/char/ipmi/ipmi_si_intf.c driver for autodetecting the ports or
memory spaces where the IPMI controllers may be found.

This patch adds equivalent changes for ia64 as to what is in the
x86_64 tree.

Tested on ia64 with 2.6.15, plus the 'dmi' patch from
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt which Andi has queued for
submission for 2.6.16, plus a patch to ipmi_si_intf.c which will
follow separately.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 199eeaf..e4c7988 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -5,6 +5,10 @@
 
 mainmenu "IA-64 Linux Kernel Configuration"
 
+config DMI
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 307514f..6fc59ed 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y	:= head.o init_task.o vmlinux.ld
 obj-y := acpi.o entry.o efi.o efi_stub.o gate-data.o fsys.o ia64_ksyms.o irq.o irq_ia64.o	\
 	 irq_lsapic.o ivt.o machvec.o pal.o patch.o process.o perfmon.o ptrace.o sal.o		\
 	 salinfo.o semaphore.o setup.o signal.o sys_ia64.o time.o traps.o unaligned.o \
-	 unwind.o mca.o mca_asm.o topology.o
+	 unwind.o mca.o mca_asm.o topology.o dmi_scan.o
 
 obj-$(CONFIG_IA64_BRL_EMU)	+= brl_emu.o
 obj-$(CONFIG_IA64_GENERIC)	+= acpi-ext.o
@@ -25,6 +25,7 @@ obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_r
 obj-$(CONFIG_KPROBES)		+= kprobes.o jprobes.o
 obj-$(CONFIG_IA64_UNCACHED_ALLOCATOR)	+= uncached.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
+dmi_scan-y			+= ../../i386/kernel/dmi_scan.o
 
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index 5add0bc..03e0c60 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <linux/initrd.h>
 #include <linux/platform.h>
 #include <linux/pm.h>
+#include <linux/dmi.h>
 
 #include <asm/ia32.h>
 #include <asm/machvec.h>
@@ -870,3 +871,10 @@ check_bugs (void)
 	ia64_patch_mckinley_e9((unsigned long) __start___mckinley_e9_bundles,
 			       (unsigned long) __end___mckinley_e9_bundles);
 }
+
+static int __init run_dmi_scan(void)
+{
+	dmi_scan_machine();
+	return 0;
+}
+core_initcall(run_dmi_scan);
diff --git a/include/asm-ia64/io.h b/include/asm-ia64/io.h
index cf772a6..54f7457 100644
--- a/include/asm-ia64/io.h
+++ b/include/asm-ia64/io.h
@@ -434,6 +434,11 @@ iounmap (volatile void __iomem *addr)
 
 #define ioremap_nocache(o,s)	ioremap(o,s)
 
+/* Use normal IO mappings for DMI */
+#define dmi_ioremap ioremap
+#define dmi_iounmap(x,l) iounmap(x)
+#define dmi_alloc(l) kmalloc(l, GFP_ATOMIC)
+
 # ifdef __KERNEL__
 
 /*
