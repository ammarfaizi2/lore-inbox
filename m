Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVAWJYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVAWJYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVAWJYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:24:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21471 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261264AbVAWJYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:24:30 -0500
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based
	crashdumps.
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>
In-Reply-To: <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	 <1106294155.26219.26.camel@2fwv946.in.ibm.com>
	 <m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	 <1106305073.26219.46.camel@2fwv946.in.ibm.com>
	 <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/mixed; boundary="=-/NAU4xbRbszX3OkaAbZ6"
Organization: 
Message-Id: <1106475280.26219.125.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jan 2005 15:44:40 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/NAU4xbRbszX3OkaAbZ6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-01-21 at 16:43, Eric W. Biederman wrote:
> On deeper review your patch as it stands is incomplete.  In particular
> you don't provide a way to either hardcode or dynamically set
> the area you are attempt to reserve to hold the backup region.

Well. Here is the new patch. This one steals the 640k from top of memory
region reserved for crash kernel. 

A new command line parameter (crashbackup=) has been introduced for
crash dump kernels. This parameter specifies the location of backup
region from where to retrieve the backup data.

Thanks
Vivek



--=-/NAU4xbRbszX3OkaAbZ6
Content-Disposition: attachment; filename=crashdump-x86-reserve-640k-memory.patch
Content-Type: text/plain; name=crashdump-x86-reserve-640k-memory.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch adds support for reserving 640k memory as backup region as required
by crashdump kernel for x86. 
---

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.11-rc1-root/Documentation/kernel-parameters.txt |    5 ++
 linux-2.6.11-rc1-root/arch/i386/kernel/setup.c            |   26 ++++++++++++--
 linux-2.6.11-rc1-root/arch/i386/mm/discontig.c            |    8 ++++
 linux-2.6.11-rc1-root/include/linux/crash_dump.h          |    1 
 linux-2.6.11-rc1-root/include/linux/kexec.h               |    6 ++-
 linux-2.6.11-rc1-root/kernel/crash_dump.c                 |    3 +
 linux-2.6.11-rc1-root/kernel/kexec.c                      |    8 ++++
 7 files changed, 54 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/setup.c~crashdump-x86-reserve-640k-memory arch/i386/kernel/setup.c
--- linux-2.6.11-rc1/arch/i386/kernel/setup.c~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/arch/i386/kernel/setup.c	2005-01-22 14:22:41.000000000 +0530
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/edd.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 #include <video/edid.h>
 #include <asm/apic.h>
 #include <asm/e820.h>
@@ -51,7 +52,6 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
-#include <asm/crash_dump.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -852,7 +852,20 @@ static void __init parse_cmdline_early (
 			}
 		}
 #endif
-
+#ifdef CONFIG_CRASH_DUMP
+		/* crashbackup=size@addr specifies the location of backup
+		 * region where, crashed kernel has stored some backup data.
+		 */
+		else if (!memcmp(from, "crashbackup=", 12)) {
+			unsigned long size, base;
+			size = memparse(from+12, &from);
+			if (*from == '@') {
+				base = memparse(from+1, &from);
+				crashbackup_start = base;
+				crashbackup_end  = base + size - 1;
+			}
+		}
+#endif
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
@@ -1159,6 +1172,14 @@ static unsigned long __init setup_memory
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end) {
 		reserve_bootmem(crashk_res.start, crashk_res.end - crashk_res.start + 1);
+
+#define CRASHDUMP_BACKUP_SZ 0xa0000
+		/* Steal 640K from top of reserved region for crash kernel */
+		if ((crashk_res.end - crashk_res.start) > CRASHDUMP_BACKUP_SZ) {
+			crashdumpk_res.end = crashk_res.end;
+			crashk_res.end = crashk_res.end - CRASHDUMP_BACKUP_SZ;
+			crashdumpk_res.start = crashk_res.end + 1;
+		}
 	}
 #endif
 	return max_low_pfn;
@@ -1202,6 +1223,7 @@ legacy_init_iomem_resources(struct resou
 			request_resource(res, data_resource);
 #ifdef CONFIG_KEXEC
 			request_resource(res, &crashk_res);
+			request_resource(res, &crashdumpk_res);
 #endif
 		}
 	}
diff -puN arch/i386/mm/discontig.c~crashdump-x86-reserve-640k-memory arch/i386/mm/discontig.c
--- linux-2.6.11-rc1/arch/i386/mm/discontig.c~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/arch/i386/mm/discontig.c	2005-01-22 14:40:30.000000000 +0530
@@ -29,6 +29,7 @@
 #include <linux/highmem.h>
 #include <linux/initrd.h>
 #include <linux/nodemask.h>
+#include <linux/ioport.h>
 #include <linux/kexec.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
@@ -371,6 +372,13 @@ unsigned long __init setup_memory(void)
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end) {
 		reserve_bootmem(crashk_res.start, crashk_res.end - crashk_res.start + 1);
+#define CRASHDUMP_BACKUP_SZ 0xa0000
+		/* Steal 640K from top of reserved region for crash kernel */
+		if ((crashk_res.end - crashk_res.start) > CRASHDUMP_BACKUP_SZ) {
+			crashdumpk_res.end = crashk_res.end;
+			crashk_res.end = crashk_res.end - CRASHDUMP_BACKUP_SZ;
+			crashdumpk_res.start = crashk_res.end + 1;
+		}
 	}
 #endif
 	return system_max_low_pfn;
diff -puN Documentation/kernel-parameters.txt~crashdump-x86-reserve-640k-memory Documentation/kernel-parameters.txt
--- linux-2.6.11-rc1/Documentation/kernel-parameters.txt~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/Documentation/kernel-parameters.txt	2005-01-22 14:16:27.000000000 +0530
@@ -27,6 +27,7 @@ restrictions referred to are that the re
 	APM	Advanced Power Management support is enabled.
 	AX25	Appropriate AX.25 support is enabled.
 	CD	Appropriate CD support is enabled.
+	CRASHDUMP Crash Dump support is enabled.
 	DEVFS	devfs support is enabled. 
 	DRM	Direct Rendering Management support is enabled. 
 	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
@@ -345,6 +346,10 @@ running once the system is up.
 			[KNL] Reserve a chunk of physical memory to
 			hold a kernel to switch to with kexec on panic.
 
+	crashbackup=nn[KMG]@ss[KMG]
+			[KNL, CRASHDUMP] Specifies the location of crash data
+			backup region.
+
 	cs4232=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<dma2>,<mpuio>,<mpuirq>
 
diff -puN include/linux/crash_dump.h~crashdump-x86-reserve-640k-memory include/linux/crash_dump.h
--- linux-2.6.11-rc1/include/linux/crash_dump.h~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/include/linux/crash_dump.h	2005-01-22 14:16:27.000000000 +0530
@@ -15,6 +15,7 @@ extern void elf_kcore_store_hdr(char *, 
 #ifdef CONFIG_CRASH_DUMP
 extern struct file_operations proc_vmcore_operations;
 extern struct proc_dir_entry *proc_vmcore;
+extern unsigned long crashbackup_start, crashbackup_end;
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t, int);
 extern void crash_create_proc_entry(void);
diff -puN include/linux/kexec.h~crashdump-x86-reserve-640k-memory include/linux/kexec.h
--- linux-2.6.11-rc1/include/linux/kexec.h~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/include/linux/kexec.h	2005-01-22 14:16:27.000000000 +0530
@@ -79,7 +79,7 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	int type : 1;
+	unsigned int type : 1;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
 };
@@ -122,6 +122,10 @@ extern struct kimage *kexec_crash_image;
  */
 extern struct resource crashk_res;
 
+/* Location of backup region to hold the crashdump kernel data.
+ */
+extern struct resource crashdumpk_res;
+
 #else /* !CONFIG_KEXEC */
 static inline void crash_kexec(void) { }
 #endif /* CONFIG_KEXEC */
diff -puN kernel/crash_dump.c~crashdump-x86-reserve-640k-memory kernel/crash_dump.c
--- linux-2.6.11-rc1/kernel/crash_dump.c~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/kernel/crash_dump.c	2005-01-22 14:16:27.000000000 +0530
@@ -15,6 +15,9 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
+/* Location of crashdump backup region if there is one. */
+unsigned long crashbackup_start, crashbackup_end;
+
 /*
  * Copy a page from "oldmem". For this page, there is no pte mapped
  * in the current kernel. We stitch up a pte, similar to kmap_atomic.
diff -puN kernel/kexec.c~crashdump-x86-reserve-640k-memory kernel/kexec.c
--- linux-2.6.11-rc1/kernel/kexec.c~crashdump-x86-reserve-640k-memory	2005-01-22 14:16:27.000000000 +0530
+++ linux-2.6.11-rc1-root/kernel/kexec.c	2005-01-22 14:16:27.000000000 +0530
@@ -32,6 +32,14 @@ struct resource crashk_res = {
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
+/* Location of the backup area for the crash dump kernel */
+struct resource crashdumpk_res = {
+	.name  = "Crash Dump Backup",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
+};
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
_

--=-/NAU4xbRbszX3OkaAbZ6--

