Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVASHh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVASHh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVASHh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:37:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48831 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261614AbVASHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:11 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 21/29] kexec-ppc-support
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tweaked this patch slightly to handle an empty list
of pages to relocate passed to relocate_new_kernel.  And
I have added ppc_md.machine_crash_shutdown.  To keep up with
the changes in the generic kexec infrastructure.

From: Albert Herranz <albert_herranz@yahoo.es>

The following patch adds support for kexec on the ppc32 platform.

Non-OpenFirmware based platforms are likely to work directly without
additional changes on the kernel side.  The kexec-tools userland package
may need to be slightly updated, though.

For OpenFirmware based machines, additional work is still needed on the
kernel side before kexec support is ready.  Benjamin Herrenschmidt is
kindly working on that part.

In order for a ppc platform to use the kexec kernel services it must
implement some ppc_md hooks.  Otherwise, kexec will be explicitly disabled,
as suggested by benh.

There are 3+1 new ppc_md hooks that a platform supporting kexec may
implement.  Two of them are mandatory for kexec to work.  See
include/asm-ppc/machdep.h for details.

- machine_kexec_prepare(image)

  This function is called to make any arrangements to the image before it
  is loaded.

  This hook _MUST_ be provided by a platform in order to activate kexec
  support for that platform.  Otherwise, the platform is considered to not
  support kexec and the kexec_load system call will fail (that makes all
  existing platforms by default non-kexec'able).

- machine_kexec_cleanup(image)

  This function is called to make any cleanups on image after the loaded
  image data it is freed.  This hook is optional.  A platform may or may
  not provide this hook.

- machine_kexec(image)

  This function is called to perform the _actual_ kexec.  This hook
  _MUST_ be provided by a platform in order to activate kexec support for
  that platform.

  If a platform provides machine_kexec_prepare but forgets to provide
  machine_kexec, a kexec will fall back to a reboot.

  A ready-to-use machine_kexec_simple() generic function is provided to,
  hopefully, simplify kexec adoption for embedded platforms.  A platform
  may call this function from its specific machine_kexec hook, like this:

void myplatform_kexec(struct kimage *image)
{
        machine_kexec_simple(image);
}

- machine_shutdown()

  This function is called to perform any machine specific shutdowns, not
  already done by drivers.  This hook is optional.  A platform may or may
  not provide this hook.  

An example (trimmed) platform specific module for a platform supporting
kexec through the existing machine_kexec_simple follows:

/* ... */

#ifdef CONFIG_KEXEC
int myplatform_kexec_prepare(struct kimage *image)
{
        /* here, we can place additional preparations
*/
        return 0; /* yes, we support kexec */
}
                                                      
                         
void myplatform_kexec(struct kimage *image)
{
        machine_kexec_simple(image);
}
#endif /* CONFIG_KEXEC */

/* ... */

void __init
platform_init(unsigned long r3, unsigned long r4,
unsigned long r5,
              unsigned long r6, unsigned long r7)
{

/* ... */

#ifdef CONFIG_KEXEC
        ppc_md.machine_kexec_prepare =
myplatform_kexec_prepare;
        ppc_md.machine_kexec         =
myplatform_kexec;
#endif /* CONFIG_KEXEC */

/* ... */

}

The kexec ppc kernel support has been heavily tested on the GameCube Linux
port, and, as reported in the fastboot mailing list, it has been tested too
on a Moto 82xx ppc by Rick Richardson.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/ppc/Kconfig                  |   20 ++++++
 arch/ppc/kernel/Makefile          |    1 
 arch/ppc/kernel/machine_kexec.c   |  121 +++++++++++++++++++++++++++++++++++++
 arch/ppc/kernel/misc.S            |    2 
 arch/ppc/kernel/relocate_kernel.S |  123 ++++++++++++++++++++++++++++++++++++++
 include/asm-ppc/kexec.h           |   38 +++++++++++
 include/asm-ppc/machdep.h         |   31 +++++++++
 7 files changed, 335 insertions(+), 1 deletion(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/Kconfig linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/Kconfig
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/Kconfig	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/Kconfig	Tue Jan 18 23:15:00 2005
@@ -198,6 +198,26 @@
 	  here.  Saying Y here will not hurt performance (on any machine) but
 	  will increase the size of the kernel.
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similiarity to the exec system call.
+
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
+	  In the GameCube implementation, kexec allows you to load and
+	  run DOL files, including kernel and homebrew DOLs.
+
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_PMAC
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/Makefile linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/Makefile
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/Makefile	Fri Jan 14 04:28:31 2005
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/Makefile	Tue Jan 18 23:15:00 2005
@@ -25,6 +25,7 @@
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_FSL_BOOKE)		+= perfmon_fsl_booke.o
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 
 ifndef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/machine_kexec.c linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/machine_kexec.c
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/machine_kexec.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/machine_kexec.c	Tue Jan 18 23:15:00 2005
@@ -0,0 +1,121 @@
+/*
+ * machine_kexec.c - handle transition of Linux booting another kernel
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * GameCube/ppc32 port Copyright (C) 2004 Albert Herranz
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
+#include <asm/hw_irq.h>
+#include <asm/cacheflush.h>
+#include <asm/machdep.h>
+
+typedef NORET_TYPE void (*relocate_new_kernel_t)(
+	unsigned long indirection_page, unsigned long reboot_code_buffer,
+	unsigned long start_address) ATTRIB_NORET;
+
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned int relocate_new_kernel_size;
+
+void machine_shutdown(void)
+{
+	if (ppc_md.machine_shutdown) {
+		ppc_md.machine_shutdown();
+	}
+}
+
+void machine_crash_shutdown(void)
+{
+	if (ppc_md.machine_crash_shutdown) {
+		ppc_md.machine_crash_shutdown();
+	}
+}
+
+/*
+ * Do what every setup is needed on image and the
+ * reboot code buffer to allow us to avoid allocations
+ * later.
+ */
+int machine_kexec_prepare(struct kimage *image)
+{
+	if (ppc_md.machine_kexec_prepare) {
+		return ppc_md.machine_kexec_prepare(image);
+	}
+	/*
+	 * Fail if platform doesn't provide its own machine_kexec_prepare
+	 * implementation.
+	 */
+	return -ENOSYS;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	if (ppc_md.machine_kexec_cleanup) {
+		ppc_md.machine_kexec_cleanup(image);
+	}
+}
+
+/*
+ * Do not allocate memory (or fail in any way) in machine_kexec().
+ * We are past the point of no return, committed to rebooting now.
+ */
+void machine_kexec(struct kimage *image)
+{
+	if (ppc_md.machine_kexec) {
+		ppc_md.machine_kexec(image);
+	} else {
+		/*
+		 * Fall back to normal restart if platform doesn't provide
+		 * its own kexec function, and user insist to kexec...
+		 */
+		machine_restart(NULL);
+	}
+}
+
+
+/*
+ * This is a generic machine_kexec function suitable at least for
+ * non-OpenFirmware embedded platforms.
+ * It merely copies the image relocation code to the control page and
+ * jumps to it.
+ * A platform specific function may just call this one.
+ */
+NORET_TYPE void machine_kexec_simple(struct kimage *image)
+{
+	unsigned long page_list;
+	unsigned long reboot_code_buffer, reboot_code_buffer_phys;
+	relocate_new_kernel_t rnk;
+
+	/* Interrupts aren't acceptable while we reboot */
+	local_irq_disable();
+
+	page_list = image->head;
+
+	/* we need both effective and real address here */
+	reboot_code_buffer =
+		(unsigned long)page_address(image->control_code_page);
+	reboot_code_buffer_phys = virt_to_phys((void *)reboot_code_buffer);
+
+	/* copy our kernel relocation code to the control code page */
+	memcpy((void *)reboot_code_buffer,
+		relocate_new_kernel, relocate_new_kernel_size);
+
+	flush_icache_range(reboot_code_buffer,
+		reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+	printk(KERN_INFO "Bye!\n");
+
+	/* now call it */
+	rnk = (relocate_new_kernel_t) reboot_code_buffer;
+	(*rnk)(page_list, reboot_code_buffer_phys, image->start);
+}
+
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/misc.S linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/misc.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/misc.S	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/misc.S	Tue Jan 18 23:15:00 2005
@@ -1450,7 +1450,7 @@
 	.long sys_mq_timedreceive	/* 265 */
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
-	.long sys_ni_syscall		/* 268 reserved for sys_kexec_load */
+	.long sys_kexec_load
 	.long sys_add_key
 	.long sys_request_key		/* 270 */
 	.long sys_keyctl
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/relocate_kernel.S linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/relocate_kernel.S
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/arch/ppc/kernel/relocate_kernel.S	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/arch/ppc/kernel/relocate_kernel.S	Tue Jan 18 23:15:00 2005
@@ -0,0 +1,123 @@
+/*
+ * relocate_kernel.S - put the kernel image in place to boot
+ * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
+ *
+ * GameCube/ppc32 port Copyright (C) 2004 Albert Herranz
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/processor.h>
+
+#include <asm/kexec.h>
+
+#define PAGE_SIZE      4096 /* must be same value as in <asm/page.h> */
+
+	/*
+	 * Must be relocatable PIC code callable as a C function.
+	 */
+	.globl relocate_new_kernel
+relocate_new_kernel:
+	/* r3 = page_list   */
+	/* r4 = reboot_code_buffer */
+	/* r5 = start_address      */
+
+	li	r0, 0
+
+	/*
+	 * Set Machine Status Register to a known status,
+	 * switch the MMU off and jump to 1: in a single step.
+	 */
+
+	mr	r8, r0
+	ori     r8, r8, MSR_RI|MSR_ME
+	mtspr	SRR1, r8
+	addi	r8, r4, 1f - relocate_new_kernel
+	mtspr	SRR0, r8
+	sync
+	rfi
+
+1:
+	/* from this point address translation is turned off */
+	/* and interrupts are disabled */
+
+	/* set a new stack at the bottom of our page... */
+	/* (not really needed now) */
+	addi	r1, r4, KEXEC_CONTROL_CODE_SIZE - 8 /* for LR Save+Back Chain */
+	stw	r0, 0(r1)
+
+	/* Do the copies */
+	li	r6, 0 /* checksum */
+	mr	r0, r3 
+	b	1f
+
+0:	/* top, read another word for the indirection page */
+	lwzu	r0, 4(r3)
+
+1:	
+	/* is it a destination page? (r8) */
+	rlwinm.	r7, r0, 0, 31, 31 /* IND_DESTINATION (1<<0) */
+	beq	2f
+
+	rlwinm	r8, r0, 0, 0, 19 /* clear kexec flags, page align */
+	b	0b
+
+2:	/* is it an indirection page? (r3) */
+	rlwinm.	r7, r0, 0, 30, 30 /* IND_INDIRECTION (1<<1) */
+	beq	2f
+
+	rlwinm	r3, r0, 0, 0, 19 /* clear kexec flags, page align */
+	subi	r3, r3, 4
+	b	0b
+
+2:	/* are we done? */
+	rlwinm.	r7, r0, 0, 29, 29 /* IND_DONE (1<<2) */
+	beq	2f
+	b	3f
+
+2:	/* is it a source page? (r9) */
+	rlwinm.	r7, r0, 0, 28, 28 /* IND_SOURCE (1<<3) */
+	beq	0b
+
+	rlwinm	r9, r0, 0, 0, 19 /* clear kexec flags, page align */
+
+	li	r7, PAGE_SIZE / 4
+	mtctr   r7
+	subi    r9, r9, 4
+	subi    r8, r8, 4
+9:
+	lwzu    r0, 4(r9)  /* do the copy */
+	xor	r6, r6, r0
+	stwu    r0, 4(r8)
+	dcbst	0, r8
+	sync
+	icbi	0, r8
+	bdnz    9b
+
+	addi    r9, r9, 4
+	addi    r8, r8, 4
+	b	0b
+
+3:
+
+	/* To be certain of avoiding problems with self-modifying code
+	 * execute a serializing instruction here.
+	 */
+	isync
+	sync
+
+	/* jump to the entry point, usually the setup routine */
+	mtlr	r5
+	blrl
+
+1:	b	1b
+
+relocate_new_kernel_end:
+
+	.globl relocate_new_kernel_size
+relocate_new_kernel_size:
+	.long relocate_new_kernel_end - relocate_new_kernel
+
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/include/asm-ppc/kexec.h linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/include/asm-ppc/kexec.h
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/include/asm-ppc/kexec.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/include/asm-ppc/kexec.h	Tue Jan 18 23:15:00 2005
@@ -0,0 +1,38 @@
+#ifndef _PPC_KEXEC_H
+#define _PPC_KEXEC_H
+
+#ifdef CONFIG_KEXEC
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
+#define KEXEC_ARCH KEXEC_ARCH_PPC
+
+#ifndef __ASSEMBLY__
+
+struct kimage;
+
+extern void machine_kexec_simple(struct kimage *image);
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_KEXEC */
+
+#endif /* _PPC_KEXEC_H */
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/include/asm-ppc/machdep.h linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/include/asm-ppc/machdep.h
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-crashkernel/include/asm-ppc/machdep.h	Fri Jan  7 12:54:15 2005
+++ linux-2.6.11-rc1-mm1-nokexec-kexec-ppc-support/include/asm-ppc/machdep.h	Tue Jan 18 23:15:00 2005
@@ -4,6 +4,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/kexec.h>
 
 #include <asm/setup.h>
 
@@ -106,6 +107,36 @@
 	/* functions for dealing with other cpus */
 	struct smp_ops_t *smp_ops;
 #endif /* CONFIG_SMP */
+
+#ifdef CONFIG_KEXEC
+	/* Called to shutdown machine specific hardware not already controlled
+	 * by other drivers.
+	 * XXX Should we move this one out of kexec scope?
+	 */
+	void (*machine_shutdown)(void);
+
+	/* Called to do the minimal shutdown needed to run a kexec'd kernel
+	 * to run successfully.
+	 * XXX Should we move this one out of kexec scope?
+	 */
+	void (*machine_crash_shutdown)(void);
+
+	/* Called to do what every setup is needed on image and the
+	 * reboot code buffer. Returns 0 on success.
+	 * Provide your own (maybe dummy) implementation if your platform
+	 * claims to support kexec.
+	 */
+	int (*machine_kexec_prepare)(struct kimage *image);
+
+	/* Called to handle any machine specific cleanup on image */
+	void (*machine_kexec_cleanup)(struct kimage *image);
+
+	/* Called to perform the _real_ kexec.
+	 * Do NOT allocate memory or fail here. We are past the point of
+	 * no return.
+	 */
+	void (*machine_kexec)(struct kimage *image);
+#endif /* CONFIG_KEXEC */
 };
 
 extern struct machdep_calls ppc_md;
