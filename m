Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWAFWjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWAFWjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWAFWjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:39:47 -0500
Received: from lists.us.dell.com ([143.166.224.162]:52927 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S964783AbWAFWjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:39:45 -0500
Date: Fri, 6 Jan 2006 16:39:32 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-ID: <20060106223932.GB9230@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <20060106172140.GB19605@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106172140.GB19605@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DMI table parsing on ia64.

This consolidates the two dmi_scan_machine() functions of the previous
version of the patch into one function, and eliminates the #ifdef
CONFIG_EFI test, as suggested by Matt Tolentino.

Andi Kleen has a patch in his x86_64 tree which enables the use of
i386 dmi_scan.c on x86_64.  dmi_scan.c functions are being used by the
drivers/char/ipmi/ipmi_si_intf.c driver for autodetecting the ports or
memory spaces where the IPMI controllers may be found.
 
This patch adds equivalent changes for ia64 as to what is in the
x86_64 tree.  In addition, I reworked the DMI detection, such that on
EFI-capable systems, it uses the efi.smbios pointer to find the table,
rather than brute-force searching from 0xF0000.  On non-EFI systems,
it continues the brute-force search.

My test system, an Intel S870BN4 'Tiger4', aka Dell PowerEdge 7250,
with latest BIOS, does not list the IPMI controller in the ACPI
namespace, nor does it have an ACPI SPMI table.  Also note, currently
shipping Dell x8xx EM64T servers don't have these either, so DMI is
the only method for obtaining the address of the IPMI controller.

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

diff --git a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
index 6a93d75..2764eab 100644
--- a/arch/i386/kernel/dmi_scan.c
+++ b/arch/i386/kernel/dmi_scan.c
@@ -5,6 +5,7 @@
 #include <linux/dmi.h>
 #include <linux/bootmem.h>
 #include <linux/slab.h>
+#include <linux/efi.h>
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
@@ -184,46 +185,71 @@ static void __init dmi_decode(struct dmi
 	}
 }
 
-void __init dmi_scan_machine(void)
+static int __init dmi_present(char __iomem *p)
 {
 	u8 buf[15];
-	char __iomem *p, *q;
+	memcpy_fromio(buf, p, 15);
+	if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
+		u16 num = (buf[13] << 8) | buf[12];
+		u16 len = (buf[7] << 8) | buf[6];
+		u32 base = (buf[11] << 24) | (buf[10] << 16) |
+			(buf[9] << 8) | buf[8];
 
-	/*
-	 * no iounmap() for that ioremap(); it would be a no-op, but it's
-	 * so early in setup that sucker gets confused into doing what
-	 * it shouldn't if we actually call it.
-	 */
-	p = ioremap(0xF0000, 0x10000);
-	if (p == NULL)
-		goto out;
+		/*
+		 * DMI version 0.0 means that the real version is taken from
+		 * the SMBIOS version, which we don't know at this point.
+		 */
+		if (buf[14] != 0)
+			printk(KERN_INFO "DMI %d.%d present.\n",
+			       buf[14] >> 4, buf[14] & 0xF);
+		else
+			printk(KERN_INFO "DMI present.\n");
+		if (dmi_table(base,len, num, dmi_decode) == 0)
+			return 0;
+	}
+	return 1;
+}
 
-	for (q = p; q < p + 0x10000; q += 16) {
-		memcpy_fromio(buf, q, 15);
-		if ((memcmp(buf, "_DMI_", 5) == 0) && dmi_checksum(buf)) {
-			u16 num = (buf[13] << 8) | buf[12];
-			u16 len = (buf[7] << 8) | buf[6];
-			u32 base = (buf[11] << 24) | (buf[10] << 16) |
-				   (buf[9] << 8) | buf[8];
-
-			/*
-			 * DMI version 0.0 means that the real version is taken from
-			 * the SMBIOS version, which we don't know at this point.
-			 */
-			if (buf[14] != 0)
-				printk(KERN_INFO "DMI %d.%d present.\n",
-					buf[14] >> 4, buf[14] & 0xF);
-			else
-				printk(KERN_INFO "DMI present.\n");
+void __init dmi_scan_machine(void)
+{
+	char __iomem *p, *q;
+	int rc;
 
-			if (dmi_table(base,len, num, dmi_decode) == 0)
+	if (efi_enabled) {
+		if (!efi.smbios)
+			goto out;
+
+               /* This is called as a core_initcall() because it isn't
+                * needed during early boot.  This also means we can
+                * iounmap the space when we're done with it.
+		*/
+		p = ioremap((unsigned long)efi.smbios, 0x10000);
+		if (p == NULL)
+			goto out;
+
+		rc = dmi_present(p + 0x10); /* offset of _DMI_ string */
+		iounmap(p);
+		if (!rc)
+			return;
+	}
+	else {
+		/*
+		 * no iounmap() for that ioremap(); it would be a no-op, but it's
+		 * so early in setup that sucker gets confused into doing what
+		 * it shouldn't if we actually call it.
+		 */
+		p = ioremap(0xF0000, 0x10000);
+		if (p == NULL)
+			goto out;
+
+		for (q = p; q < p + 0x10000; q += 16) {
+			rc = dmi_present(q);
+			if (!rc)
 				return;
 		}
 	}
-
-out:	printk(KERN_INFO "DMI not present or invalid.\n");
+ out:	printk(KERN_INFO "DMI not present or invalid.\n");
 }
-
 
 /**
  *	dmi_check_system - check system DMI data
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 199eeaf..51ac4e0 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -42,6 +42,10 @@ config TIME_INTERPOLATION
 	bool
 	default y
 
+config DMI
+	bool
+	default y
+
 config EFI
 	bool
 	default y
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

