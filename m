Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWANWwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWANWwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWANWwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:52:46 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:64130 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751338AbWANWwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:52:45 -0500
Date: Sun, 15 Jan 2006 00:52:44 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] sh: kexec() support.
Message-ID: <20060114225244.GE4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: kogiidena <kogiidena@eggplant.ddo.jp>

This adds kexec() support for SH.

Signed-off-by: kogiidena <kogiidena@eggplant.ddo.jp>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/Makefile          |    4 -
 arch/sh/kernel/machine_kexec.c   |  112 +++++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/process.c         |   10 +++
 arch/sh/kernel/relocate_kernel.S |  102 +++++++++++++++++++++++++++++++++++
 include/asm-sh/kexec.h           |   33 +++++++++++
 include/linux/kexec.h            |    1 
 6 files changed, 259 insertions(+), 3 deletions(-)

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/Makefile sh-2.6.15/arch/sh/kernel/Makefile
--- linux-2.6.15/arch/sh/kernel/Makefile	2004-10-25 13:03:28.000000000 +0300
+++ sh-2.6.15/arch/sh/kernel/Makefile	2006-01-04 00:15:27.000000000 +0200
@@ -17,6 +17,4 @@
 obj-$(CONFIG_SH_CPU_FREQ)	+= cpufreq.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
-
-USE_STANDARD_AS_RULE := true
-
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/machine_kexec.c sh-2.6.15/arch/sh/kernel/machine_kexec.c
--- linux-2.6.15/arch/sh/kernel/machine_kexec.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/machine_kexec.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,112 @@
+/*
+ * machine_kexec.c - handle transition of Linux booting another kernel
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * GameCube/ppc32 port Copyright (C) 2004 Albert Herranz
+ * LANDISK/sh4 supported by kogiidena
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/mm.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/mmu_context.h>
+#include <asm/io.h>
+#include <asm/cacheflush.h>
+
+typedef NORET_TYPE void (*relocate_new_kernel_t)(
+				unsigned long indirection_page,
+				unsigned long reboot_code_buffer,
+				unsigned long start_address,
+				unsigned long vbr_reg) ATTRIB_NORET;
+
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned int relocate_new_kernel_size;
+extern void *gdb_vbr_vector;
+
+/*
+ * Provide a dummy crash_notes definition while crash dump arrives to ppc.
+ * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
+ */
+void *crash_notes = NULL;
+
+void machine_shutdown(void)
+{
+}
+
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+}
+
+/*
+ * Do what every setup is needed on image and the
+ * reboot code buffer to allow us to avoid allocations
+ * later.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+}
+
+static void kexec_info(struct kimage *image)
+{
+        int i;
+	printk("kexec information\n");
+	for (i = 0; i < image->nr_segments; i++) {
+	        printk("  segment[%d]: 0x%08x - 0x%08x (0x%08x)\n",
+		       i,
+		       (unsigned int)image->segment[i].mem,
+		       (unsigned int)image->segment[i].mem + image->segment[i].memsz,
+		       (unsigned int)image->segment[i].memsz);
+ 	}
+	printk("  start     : 0x%08x\n\n", (unsigned int)image->start);
+}
+
+
+/*
+ * Do not allocate memory (or fail in any way) in machine_kexec().
+ * We are past the point of no return, committed to rebooting now.
+ */
+NORET_TYPE void machine_kexec(struct kimage *image)
+{
+
+	unsigned long page_list;
+	unsigned long reboot_code_buffer;
+	unsigned long vbr_reg;
+	relocate_new_kernel_t rnk;
+
+#if defined(CONFIG_SH_STANDARD_BIOS)
+	vbr_reg = ((unsigned long )gdb_vbr_vector) - 0x100;
+#else
+	vbr_reg = 0x80000000;  // dummy
+#endif
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	page_list = image->head;
+
+	/* we need both effective and real address here */
+	reboot_code_buffer =
+			(unsigned long)page_address(image->control_code_page);
+
+	/* copy our kernel relocation code to the control code page */
+	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
+						relocate_new_kernel_size);
+
+        kexec_info(image);
+	flush_cache_all();
+
+	/* now call it */
+	rnk = (relocate_new_kernel_t) reboot_code_buffer;
+       	(*rnk)(page_list, reboot_code_buffer, image->start, vbr_reg);
+}
+

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/relocate_kernel.S sh-2.6.15/arch/sh/kernel/relocate_kernel.S
--- linux-2.6.15/arch/sh/kernel/relocate_kernel.S	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/relocate_kernel.S	2006-01-04 00:15:28.000000000 +0200
@@ -0,0 +1,102 @@
+/*
+ * relocate_kernel.S - put the kernel image in place to boot
+ * 2005.9.17 kogiidena@eggplant.ddo.jp
+ *
+ * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+
+#define PAGE_SIZE      4096 /* must be same value as in <asm/page.h> */
+	
+	
+		.globl relocate_new_kernel
+relocate_new_kernel:
+	/* r4 = indirection_page   */
+	/* r5 = reboot_code_buffer */
+	/* r6 = start_address      */
+	/* r7 = vbr_reg            */
+
+	mov.l	10f,r8	  /* 4096 */
+	mov.l	11f,r9    /* 0xa0000000 */
+
+	/*  stack setting */
+	add	r8,r5
+	mov	r5,r15
+
+	bra	1f
+	mov	r4,r0	  /* cmd = indirection_page */
+0:	
+	mov.l	@r4+,r0	  /* cmd = *ind++ */
+
+1:	/* addr = (cmd | 0xa0000000) & 0xfffffff0 */
+	mov	r0,r2
+	or	r9,r2
+	mov	#-16,r1
+	and	r1,r2	
+
+	/* if(cmd & IND_DESTINATION) dst = addr  */
+	tst	#1,r0	
+	bt	2f
+	bra	0b	
+	mov	r2,r5	
+
+2:	/* else if(cmd & IND_INDIRECTION) ind = addr  */
+	tst	#2,r0
+	bt	3f
+	bra	0b	
+	mov	r2,r4
+
+3:	/* else if(cmd & IND_DONE) goto 6  */
+	tst	#4,r0
+	bt	4f
+	bra	6f
+	nop
+
+4:	/* else if(cmd & IND_SOURCE) memcpy(dst,addr,PAGE_SIZE) */
+	tst	#8,r0
+	bt	0b
+
+	mov	r8,r3
+	shlr2	r3	
+	shlr2	r3	
+5:	
+	dt	r3
+	mov.l	@r2+,r1   /*  16n+0 */
+	mov.l	r1,@r5
+	add	#4,r5
+	mov.l	@r2+,r1	  /*  16n+4 */
+	mov.l	r1,@r5
+	add	#4,r5
+	mov.l	@r2+,r1   /*  16n+8 */
+	mov.l	r1,@r5
+	add	#4,r5
+	mov.l	@r2+,r1   /*  16n+12 */
+	mov.l	r1,@r5
+	add	#4,r5
+	bf	5b
+	
+	bra	0b
+	nop
+6:
+#ifdef CONFIG_SH_STANDARD_BIOS
+	ldc   r7, vbr
+#endif
+	jmp @r6
+	nop
+
+	.align 2
+10:
+	.long	PAGE_SIZE
+11:
+	.long	0xa0000000
+
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.long relocate_new_kernel_end - relocate_new_kernel

diff -urN -X exclude linux-2.6.15/include/asm-sh/kexec.h sh-2.6.15/include/asm-sh/kexec.h
--- linux-2.6.15/include/asm-sh/kexec.h	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/include/asm-sh/kexec.h	2006-01-04 00:15:29.000000000 +0200
@@ -0,0 +1,33 @@
+#ifndef _SH_KEXEC_H
+#define _SH_KEXEC_H
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+/* Maximum address we can reach in physical address mode */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+/* Maximum address we can use for the control code buffer */
+#define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
+
+#define KEXEC_CONTROL_CODE_SIZE	4096
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_SH
+
+#ifndef __ASSEMBLY__
+
+extern void machine_shutdown(void);
+extern void *crash_notes;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _SH_KEXEC_H */

diff -urN -X exclude linux-2.6.15/include/linux/kexec.h sh-2.6.15/include/linux/kexec.h
--- linux-2.6.15/include/linux/kexec.h	2005-09-01 00:20:33.000000000 +0300
+++ sh-2.6.15/include/linux/kexec.h	2006-01-04 00:15:30.000000000 +0200
@@ -119,6 +119,7 @@
 #define KEXEC_ARCH_PPC64   (21 << 16)
 #define KEXEC_ARCH_IA_64   (50 << 16)
 #define KEXEC_ARCH_S390    (22 << 16)
+#define KEXEC_ARCH_SH      (42 << 16)
 
 #define KEXEC_FLAGS    (KEXEC_ON_CRASH)  /* List of defined/legal kexec flags */

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/process.c sh-2.6.15/arch/sh/kernel/process.c
--- linux-2.6.15/arch/sh/kernel/process.c	2006-01-04 14:19:57.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/process.c	2006-01-04 00:26:10.000000000 +0200
@@ -71,6 +81,16 @@
 
 void machine_restart(char * __unused)
 {
+
+#ifdef CONFIG_KEXEC
+	struct kimage *image;
+	image = xchg(&kexec_image, 0);
+	if (image) {
+		machine_shutdown();
+		machine_kexec(image);
+	}
+#endif
+
 	/* SR.BL=1 and invoke address error to let CPU reset (manual reset) */
 	asm volatile("ldc %0, sr\n\t"
 		     "mov.l @%1, %0" : : "r" (0x10000000), "r" (0x80000001));
