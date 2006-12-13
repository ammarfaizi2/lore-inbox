Return-Path: <linux-kernel-owner+w=401wt.eu-S965009AbWLMQW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWLMQW6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWLMQW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:22:58 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:59057 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965009AbWLMQWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:22:55 -0500
Message-ID: <458028DB.4010604@de.ibm.com>
Date: Wed, 13 Dec 2006 17:22:51 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reply-To: gerald.schaefer@de.ibm.com
User-Agent: Thunderbird 1.5.0.8 (X11/20061105)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Martin Schwidefsky <martin.schwidefsky@de.ibm.com>
Subject: [RFC][Patch] s390: noexec protection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC][Patch] s390: noexec protection

This provides a noexec protection on s390 hardware. Our hardware does
not have any bits left in the pte for a hw noexec bit, so this is a
different approach using shadow page tables and a special addressing
mode that allows separate address spaces for code and data.

As a special feature of our "secondary-space" addressing mode, separate
page tables can be specified for the translation of data addresses
(storage operands) and instruction addresses. The shadow page table is
used for the instruction addresses and the standard page table for the
data addresses.
The shadow page table is linked to the standard page table by a pointer
in page->lru.next of the struct page corresponding to the page that
contains the standard page table (since page->private is not really
private with the pte_lock and the page table pages are not in the LRU
list).
Depending on the software bits of a pte, it is either inserted into
both page tables or just into the standard (data) page table. Pages of
a vma that does not have the VM_EXEC bit set get mapped only in the
data address space. Any try to execute code on such a page will cause a
page translation exception. The standard reaction to this is a SIGSEGV
with two exceptions: the two system call opcodes 0x0a77 (sys_sigreturn)
and 0x0aad (sys_rt_sigreturn) are allowed. They are stored by the
kernel to the signal stack frame. Unfortunately, the signal return
mechanism cannot be modified to use an SA_RESTORER because the
exception unwinding code depends on the system call opcode stored
behind the signal stack frame.

This feature requires that user space is executed in secondary-space
mode and the kernel in home-space mode, which means that the addressing
modes need to be switched and that the noexec protection only works
for user space.
After switching the addressing modes, we cannot use the mvcp/mvcs
instructions anymore to copy between kernel and user space. A new
mvcos instruction has been added to the z9 EC/BC hardware which allows
to copy between arbitrary address spaces, but on older hardware the
page tables need to be walked manually.

Comments and suggestions are always welcome.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>

---

  arch/s390/Kconfig                |   25 +++
  arch/s390/defconfig              |    2
  arch/s390/kernel/compat_linux.c  |    6
  arch/s390/kernel/compat_linux.h  |   31 ---
  arch/s390/kernel/compat_signal.c |    2
  arch/s390/kernel/ipl.c           |    2
  arch/s390/kernel/process.c       |    4
  arch/s390/kernel/ptrace.c        |   10 -
  arch/s390/kernel/setup.c         |   98 +++++++++++-
  arch/s390/kernel/signal.c        |    2
  arch/s390/kernel/smp.c           |    2
  arch/s390/lib/uaccess_mvcos.c    |   55 ++++++
  arch/s390/lib/uaccess_pt.c       |  318 ++++++++++++++++++++++++++++++++++++++-
  arch/s390/mm/fault.c             |   88 ++++++++++
  arch/s390/mm/init.c              |    6
  arch/s390/mm/vmem.c              |   14 -
  include/asm-s390/compat.h        |   28 +++
  include/asm-s390/lowcore.h       |    6
  include/asm-s390/mmu_context.h   |   50 ++++--
  include/asm-s390/pgalloc.h       |   87 +++++++++-
  include/asm-s390/pgtable.h       |  146 +++++++++++++++--
  include/asm-s390/processor.h     |    6
  include/asm-s390/ptrace.h        |   11 -
  include/asm-s390/setup.h         |   12 +
  include/asm-s390/smp.h           |    2
  include/asm-s390/system.h        |    4
  include/asm-s390/tlbflush.h      |    9 +
  include/asm-s390/uaccess.h       |    2
  28 files changed, 913 insertions(+), 115 deletions(-)

diff -pruN linux-2.6.19/arch/s390/defconfig linux-2.6.19xxx/arch/s390/defconfig
--- linux-2.6.19/arch/s390/defconfig	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/defconfig	2006-12-13 17:11:04.000000000 +0100
@@ -106,6 +106,8 @@ CONFIG_DEFAULT_MIGRATION_COST=1000000
  CONFIG_COMPAT=y
  CONFIG_SYSVIPC_COMPAT=y
  CONFIG_AUDIT_ARCH=y
+CONFIG_S390_SWITCH_AMODE=y
+CONFIG_S390_EXEC_PROTECT=y

  #
  # Code generation options
diff -pruN linux-2.6.19/arch/s390/Kconfig linux-2.6.19xxx/arch/s390/Kconfig
--- linux-2.6.19/arch/s390/Kconfig	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/Kconfig	2006-12-13 17:11:04.000000000 +0100
@@ -134,6 +134,31 @@ config AUDIT_ARCH
  	bool
  	default y

+config S390_SWITCH_AMODE
+	bool "Switch kernel/user addressing modes"
+	help
+	  This option allows to switch the addressing modes of kernel and user
+	  space. The kernel parameter switch_amode=on will enable this feature,
+	  default is disabled. Enabling this (via kernel parameter) on machines
+	  earlier than IBM System z9-109 EC/BC will reduce system performance.
+
+	  Note that this option will also be selected by selecting the execute
+	  protection option below. Enabling the execute protection via the
+	  noexec kernel parameter will also switch the addressing modes,
+	  independent of the switch_amode kernel parameter.
+
+
+config S390_EXEC_PROTECT
+	bool "Data execute protection"
+	select S390_SWITCH_AMODE
+	help
+	  This option allows to enable a buffer overflow protection for user
+	  space programs and it also selects the addressing mode option above.
+	  The kernel parameter noexec=on will enable this feature and also
+	  switch the addressing modes, default is disabled. Enabling this (via
+	  kernel parameter) on machines earlier than IBM System z9-109 EC/BC
+	  will reduce system performance.
+
  comment "Code generation options"

  choice
diff -pruN linux-2.6.19/arch/s390/kernel/compat_linux.c linux-2.6.19xxx/arch/s390/kernel/compat_linux.c
--- linux-2.6.19/arch/s390/kernel/compat_linux.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/compat_linux.c	2006-12-13 17:11:04.000000000 +0100
@@ -69,6 +69,12 @@

  #include "compat_linux.h"

+long psw_user32_bits	= (PSW_BASE32_BITS | PSW_MASK_DAT | PSW_ASC_HOME |
+			   PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK |
+			   PSW_MASK_PSTATE | PSW_DEFAULT_KEY);
+long psw32_user_bits	= (PSW32_BASE_BITS | PSW32_MASK_DAT | PSW32_ASC_HOME |
+			   PSW32_MASK_IO | PSW32_MASK_EXT | PSW32_MASK_MCHECK |
+			   PSW32_MASK_PSTATE);

  /* For this source file, we want overflow handling. */

diff -pruN linux-2.6.19/arch/s390/kernel/compat_linux.h linux-2.6.19xxx/arch/s390/kernel/compat_linux.h
--- linux-2.6.19/arch/s390/kernel/compat_linux.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/compat_linux.h	2006-12-13 17:11:04.000000000 +0100
@@ -115,37 +115,6 @@ typedef struct
          __u32	addr;
  } _psw_t32 __attribute__ ((aligned(8)));

-#define PSW32_MASK_PER		0x40000000UL
-#define PSW32_MASK_DAT		0x04000000UL
-#define PSW32_MASK_IO		0x02000000UL
-#define PSW32_MASK_EXT		0x01000000UL
-#define PSW32_MASK_KEY		0x00F00000UL
-#define PSW32_MASK_MCHECK	0x00040000UL
-#define PSW32_MASK_WAIT		0x00020000UL
-#define PSW32_MASK_PSTATE	0x00010000UL
-#define PSW32_MASK_ASC		0x0000C000UL
-#define PSW32_MASK_CC		0x00003000UL
-#define PSW32_MASK_PM		0x00000f00UL
-
-#define PSW32_ADDR_AMODE31	0x80000000UL
-#define PSW32_ADDR_INSN		0x7FFFFFFFUL
-
-#define PSW32_BASE_BITS		0x00080000UL
-
-#define PSW32_ASC_PRIMARY	0x00000000UL
-#define PSW32_ASC_ACCREG	0x00004000UL
-#define PSW32_ASC_SECONDARY	0x00008000UL
-#define PSW32_ASC_HOME		0x0000C000UL
-
-#define PSW32_USER_BITS	(PSW32_BASE_BITS | PSW32_MASK_DAT | PSW32_ASC_HOME | \
-			 PSW32_MASK_IO | PSW32_MASK_EXT | PSW32_MASK_MCHECK | \
-			 PSW32_MASK_PSTATE)
-
-#define PSW32_MASK_MERGE(CURRENT,NEW) \
-        (((CURRENT) & ~(PSW32_MASK_CC|PSW32_MASK_PM)) | \
-         ((NEW) & (PSW32_MASK_CC|PSW32_MASK_PM)))
-
-
  typedef struct
  {
  	_psw_t32	psw;
diff -pruN linux-2.6.19/arch/s390/kernel/compat_signal.c linux-2.6.19xxx/arch/s390/kernel/compat_signal.c
--- linux-2.6.19/arch/s390/kernel/compat_signal.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/compat_signal.c	2006-12-13 17:11:04.000000000 +0100
@@ -298,7 +298,7 @@ static int save_sigregs32(struct pt_regs
  	_s390_regs_common32 regs32;
  	int err, i;

-	regs32.psw.mask = PSW32_MASK_MERGE(PSW32_USER_BITS,
+	regs32.psw.mask = PSW32_MASK_MERGE(psw32_user_bits,
  					   (__u32)(regs->psw.mask >> 32));
  	regs32.psw.addr = PSW32_ADDR_AMODE31 | (__u32) regs->psw.addr;
  	for (i = 0; i < NUM_GPRS; i++)
diff -pruN linux-2.6.19/arch/s390/kernel/ipl.c linux-2.6.19xxx/arch/s390/kernel/ipl.c
--- linux-2.6.19/arch/s390/kernel/ipl.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/ipl.c	2006-12-13 17:11:04.000000000 +0100
@@ -1053,7 +1053,7 @@ void s390_reset_system(void)
  	__ctl_clear_bit(0,28);

  	/* Set new machine check handler */
-	S390_lowcore.mcck_new_psw.mask = PSW_KERNEL_BITS & ~PSW_MASK_MCHECK;
+	S390_lowcore.mcck_new_psw.mask = psw_kernel_bits & ~PSW_MASK_MCHECK;
  	S390_lowcore.mcck_new_psw.addr =
  		PSW_ADDR_AMODE | (unsigned long) &reset_mcck_handler;
  	do_reset_calls();
diff -pruN linux-2.6.19/arch/s390/kernel/process.c linux-2.6.19xxx/arch/s390/kernel/process.c
--- linux-2.6.19/arch/s390/kernel/process.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/process.c	2006-12-13 17:11:04.000000000 +0100
@@ -144,7 +144,7 @@ static void default_idle(void)

  	trace_hardirqs_on();
  	/* Wait for external, I/O or machine check interrupt. */
-	__load_psw_mask(PSW_KERNEL_BITS | PSW_MASK_WAIT |
+	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
  			PSW_MASK_IO | PSW_MASK_EXT);
  }

@@ -190,7 +190,7 @@ int kernel_thread(int (*fn)(void *), voi
  	struct pt_regs regs;

  	memset(&regs, 0, sizeof(regs));
-	regs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_EXT;
+	regs.psw.mask = psw_kernel_bits | PSW_MASK_IO | PSW_MASK_EXT;
  	regs.psw.addr = (unsigned long) kernel_thread_starter | PSW_ADDR_AMODE;
  	regs.gprs[9] = (unsigned long) fn;
  	regs.gprs[10] = (unsigned long) arg;
diff -pruN linux-2.6.19/arch/s390/kernel/ptrace.c linux-2.6.19xxx/arch/s390/kernel/ptrace.c
--- linux-2.6.19/arch/s390/kernel/ptrace.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/ptrace.c	2006-12-13 17:11:04.000000000 +0100
@@ -232,9 +232,9 @@ poke_user(struct task_struct *child, add
  		 */
  		if (addr == (addr_t) &dummy->regs.psw.mask &&
  #ifdef CONFIG_COMPAT
-		    data != PSW_MASK_MERGE(PSW_USER32_BITS, data) &&
+		    data != PSW_MASK_MERGE(psw_user32_bits, data) &&
  #endif
-		    data != PSW_MASK_MERGE(PSW_USER_BITS, data))
+		    data != PSW_MASK_MERGE(psw_user_bits, data))
  			/* Invalid psw mask. */
  			return -EINVAL;
  #ifndef CONFIG_64BIT
@@ -394,7 +394,7 @@ peek_user_emu31(struct task_struct *chil
  		if (addr == (addr_t) &dummy32->regs.psw.mask) {
  			/* Fake a 31 bit psw mask. */
  			tmp = (__u32)(task_pt_regs(child)->psw.mask >> 32);
-			tmp = PSW32_MASK_MERGE(PSW32_USER_BITS, tmp);
+			tmp = PSW32_MASK_MERGE(psw32_user_bits, tmp);
  		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
  			/* Fake a 31 bit psw address. */
  			tmp = (__u32) task_pt_regs(child)->psw.addr |
@@ -469,11 +469,11 @@ poke_user_emu31(struct task_struct *chil
  		 */
  		if (addr == (addr_t) &dummy32->regs.psw.mask) {
  			/* Build a 64 bit psw mask from 31 bit mask. */
-			if (tmp != PSW32_MASK_MERGE(PSW32_USER_BITS, tmp))
+			if (tmp != PSW32_MASK_MERGE(psw32_user_bits, tmp))
  				/* Invalid psw mask. */
  				return -EINVAL;
  			task_pt_regs(child)->psw.mask =
-				PSW_MASK_MERGE(PSW_USER32_BITS, (__u64) tmp << 32);
+				PSW_MASK_MERGE(psw_user32_bits, (__u64) tmp << 32);
  		} else if (addr == (addr_t) &dummy32->regs.psw.addr) {
  			/* Build a 64 bit psw address from 31 bit address. */
  			task_pt_regs(child)->psw.addr =
diff -pruN linux-2.6.19/arch/s390/kernel/setup.c linux-2.6.19xxx/arch/s390/kernel/setup.c
--- linux-2.6.19/arch/s390/kernel/setup.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/setup.c	2006-12-13 17:11:45.000000000 +0100
@@ -49,6 +49,13 @@
  #include <asm/page.h>
  #include <asm/ptrace.h>
  #include <asm/sections.h>
+#include <asm/compat.h>
+
+long psw_kernel_bits	= (PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY |
+			   PSW_MASK_MCHECK | PSW_DEFAULT_KEY);
+long psw_user_bits	= (PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME |
+			   PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK |
+			   PSW_MASK_PSTATE | PSW_DEFAULT_KEY);

  /*
   * User copy operations.
@@ -386,6 +393,84 @@ static int __init early_parse_ipldelay(c
  }
  early_param("ipldelay", early_parse_ipldelay);

+#ifdef CONFIG_S390_SWITCH_AMODE
+unsigned int switch_amode = 0;
+EXPORT_SYMBOL_GPL(switch_amode);
+
+static inline void set_amode_and_uaccess(unsigned long user_amode,
+					 unsigned long user32_amode)
+{
+	psw_user_bits = PSW_BASE_BITS | PSW_MASK_DAT | user_amode |
+			PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK |
+			PSW_MASK_PSTATE | PSW_DEFAULT_KEY;
+#ifdef CONFIG_COMPAT
+	psw_user32_bits = PSW_BASE32_BITS | PSW_MASK_DAT | user_amode |
+			  PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK |
+			  PSW_MASK_PSTATE | PSW_DEFAULT_KEY;
+	psw32_user_bits = PSW32_BASE_BITS | PSW32_MASK_DAT | user32_amode |
+			  PSW32_MASK_IO | PSW32_MASK_EXT | PSW32_MASK_MCHECK |
+			  PSW32_MASK_PSTATE;
+#endif
+	psw_kernel_bits = PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME |
+			  PSW_MASK_MCHECK | PSW_DEFAULT_KEY;
+
+	if (MACHINE_HAS_MVCOS) {
+		printk("mvcos available.\n");
+		memcpy(&uaccess, &uaccess_mvcos_switch, sizeof(uaccess));
+	} else {
+		printk("mvcos not available.\n");
+		memcpy(&uaccess, &uaccess_pt, sizeof(uaccess));
+	}
+}
+
+/*
+ * Switch kernel/user addressing modes?
+ */
+static int __init early_parse_switch_amode(char *p)
+{
+	switch_amode = 1;
+	return 0;
+}
+early_param("switch_amode", early_parse_switch_amode);
+
+#else /* CONFIG_S390_SWITCH_AMODE */
+static inline void set_amode_and_uaccess(unsigned long user_amode,
+					 unsigned long user32_amode)
+{
+}
+#endif /* CONFIG_S390_SWITCH_AMODE */
+
+#ifdef CONFIG_S390_EXEC_PROTECT
+unsigned int s390_noexec = 0;
+EXPORT_SYMBOL_GPL(s390_noexec);
+
+/*
+ * Enable execute protection?
+ */
+static int __init early_parse_noexec(char *p)
+{
+	if (!strncmp(p, "off", 3))
+		return 0;
+	switch_amode = 1;
+	s390_noexec = 1;
+	return 0;
+}
+early_param("noexec", early_parse_noexec);
+#endif /* CONFIG_S390_EXEC_PROTECT */
+
+static void setup_addressing_mode(void)
+{
+	if (s390_noexec) {
+		printk("S390 execute protection active, ");
+		set_amode_and_uaccess(PSW_ASC_SECONDARY, PSW32_ASC_SECONDARY);
+		return;
+	}
+	if (switch_amode) {
+		printk("S390 address spaces switched, ");
+		set_amode_and_uaccess(PSW_ASC_PRIMARY, PSW32_ASC_PRIMARY);
+	}
+}
+
  static void __init
  setup_lowcore(void)
  {
@@ -402,19 +487,21 @@ setup_lowcore(void)
  	lc->restart_psw.mask = PSW_BASE_BITS | PSW_DEFAULT_KEY;
  	lc->restart_psw.addr =
  		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
-	lc->external_new_psw.mask = PSW_KERNEL_BITS;
+	if (switch_amode)
+		lc->restart_psw.mask |= PSW_ASC_HOME;
+	lc->external_new_psw.mask = psw_kernel_bits;
  	lc->external_new_psw.addr =
  		PSW_ADDR_AMODE | (unsigned long) ext_int_handler;
-	lc->svc_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_EXT;
+	lc->svc_new_psw.mask = psw_kernel_bits | PSW_MASK_IO | PSW_MASK_EXT;
  	lc->svc_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) system_call;
-	lc->program_new_psw.mask = PSW_KERNEL_BITS;
+	lc->program_new_psw.mask = psw_kernel_bits;
  	lc->program_new_psw.addr =
  		PSW_ADDR_AMODE | (unsigned long)pgm_check_handler;
  	lc->mcck_new_psw.mask =
-		PSW_KERNEL_BITS & ~PSW_MASK_MCHECK & ~PSW_MASK_DAT;
+		psw_kernel_bits & ~PSW_MASK_MCHECK & ~PSW_MASK_DAT;
  	lc->mcck_new_psw.addr =
  		PSW_ADDR_AMODE | (unsigned long) mcck_int_handler;
-	lc->io_new_psw.mask = PSW_KERNEL_BITS;
+	lc->io_new_psw.mask = psw_kernel_bits;
  	lc->io_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) io_int_handler;
  	lc->ipl_device = S390_lowcore.ipl_device;
  	lc->jiffy_timer = -1LL;
@@ -651,6 +738,7 @@ setup_arch(char **cmdline_p)
  	parse_early_param();

  	setup_memory_end();
+	setup_addressing_mode();
  	setup_memory();
  	setup_resources();
  	setup_lowcore();
diff -pruN linux-2.6.19/arch/s390/kernel/signal.c linux-2.6.19xxx/arch/s390/kernel/signal.c
--- linux-2.6.19/arch/s390/kernel/signal.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/signal.c	2006-12-13 17:11:04.000000000 +0100
@@ -119,7 +119,7 @@ static int save_sigregs(struct pt_regs *

  	/* Copy a 'clean' PSW mask to the user to avoid leaking
  	   information about whether PER is currently on.  */
-	user_sregs.regs.psw.mask = PSW_MASK_MERGE(PSW_USER_BITS, regs->psw.mask);
+	user_sregs.regs.psw.mask = PSW_MASK_MERGE(psw_user_bits, regs->psw.mask);
  	user_sregs.regs.psw.addr = regs->psw.addr;
  	memcpy(&user_sregs.regs.gprs, &regs->gprs, sizeof(sregs->regs.gprs));
  	memcpy(&user_sregs.regs.acrs, current->thread.acrs,
diff -pruN linux-2.6.19/arch/s390/kernel/smp.c linux-2.6.19xxx/arch/s390/kernel/smp.c
--- linux-2.6.19/arch/s390/kernel/smp.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/kernel/smp.c	2006-12-13 17:11:04.000000000 +0100
@@ -250,7 +250,7 @@ static inline void do_wait_for_stop(void
  void smp_send_stop(void)
  {
  	/* Disable all interrupts/machine checks */
-	__load_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK);
+	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);

          /* write magic number to zero page (absolute 0) */
  	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
diff -pruN linux-2.6.19/arch/s390/lib/uaccess_mvcos.c linux-2.6.19xxx/arch/s390/lib/uaccess_mvcos.c
--- linux-2.6.19/arch/s390/lib/uaccess_mvcos.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/lib/uaccess_mvcos.c	2006-12-13 17:11:04.000000000 +0100
@@ -162,6 +162,43 @@ size_t clear_user_mvcos(size_t size, voi
  	return size;
  }

+size_t strnlen_user_mvcos(size_t count, const char __user *src)
+{
+	char buf[256];
+	int rc;
+	size_t done, len, len_str;
+
+	done = 0;
+	do {
+		len = min(count - done, (size_t) 256);
+		rc = uaccess.copy_from_user(len, src + done, buf);
+		if (unlikely(rc == len))
+			return 0;
+		len -= rc;
+		len_str = strnlen(buf, len);
+		done += len_str;
+	} while ((len_str == len) && (done < count));
+	return done + 1;
+}
+
+size_t strncpy_from_user_mvcos(size_t count, const char __user *src, char *dst)
+{
+	int rc;
+	size_t done, len, len_str;
+
+	done = 0;
+	do {
+		len = min(count - done, (size_t) 4096);
+		rc = uaccess.copy_from_user(len, src + done, dst);
+		if (unlikely(rc == len))
+			return -EFAULT;
+		len -= rc;
+		len_str = strnlen(dst, len);
+		done += len_str;
+	} while ((len_str == len) && (done < count));
+	return done;
+}
+
  extern size_t strnlen_user_std(size_t, const char __user *);
  extern size_t strncpy_from_user_std(size_t, const char __user *, char *);
  extern int futex_atomic_op(int, int __user *, int, int *);
@@ -179,3 +216,21 @@ struct uaccess_ops uaccess_mvcos = {
  	.futex_atomic_op = futex_atomic_op,
  	.futex_atomic_cmpxchg = futex_atomic_cmpxchg,
  };
+
+#ifdef CONFIG_S390_SWITCH_AMODE
+extern int futex_atomic_op_pt(int op, int __user *uaddr, int oparg, int *old);
+extern int futex_atomic_cmpxchg_pt(int __user *uaddr, int oldval, int newval);
+
+struct uaccess_ops uaccess_mvcos_switch = {
+	.copy_from_user = copy_from_user_mvcos,
+	.copy_from_user_small = copy_from_user_mvcos,
+	.copy_to_user = copy_to_user_mvcos,
+	.copy_to_user_small = copy_to_user_mvcos,
+	.copy_in_user = copy_in_user_mvcos,
+	.clear_user = clear_user_mvcos,
+	.strnlen_user = strnlen_user_mvcos,
+	.strncpy_from_user = strncpy_from_user_mvcos,
+	.futex_atomic_op = futex_atomic_op_pt,
+	.futex_atomic_cmpxchg = futex_atomic_cmpxchg_pt,
+};
+#endif
diff -pruN linux-2.6.19/arch/s390/lib/uaccess_pt.c linux-2.6.19xxx/arch/s390/lib/uaccess_pt.c
--- linux-2.6.19/arch/s390/lib/uaccess_pt.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/lib/uaccess_pt.c	2006-12-13 17:11:04.000000000 +0100
@@ -1,7 +1,8 @@
  /*
   *  arch/s390/lib/uaccess_pt.c
   *
- *  User access functions based on page table walks.
+ *  User access functions based on page table walks for enhanced
+ *  system layout without hardware support.
   *
   *    Copyright IBM Corp. 2006
   *    Author(s): Gerald Schaefer (gerald.schaefer@de.ibm.com)
@@ -130,6 +131,47 @@ fault:
  	goto retry;
  }

+/*
+ * Do DAT for user address by page table walk, return kernel address.
+ * This function needs to be called with current->mm->page_table_lock held.
+ */
+static inline unsigned long __dat_user_addr(unsigned long uaddr)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long pfn, ret;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	ret = 0;
+retry:
+	pgd = pgd_offset(mm, uaddr);
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		goto fault;
+
+	pmd = pmd_offset(pgd, uaddr);
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		goto fault;
+
+	pte = pte_offset_map(pmd, uaddr);
+	if (!pte || !pte_present(*pte))
+		goto fault;
+
+	pfn = pte_pfn(*pte);
+	if (!pfn_valid(pfn))
+		goto out;
+
+	ret = (pfn << PAGE_SHIFT) + (uaddr & (PAGE_SIZE - 1));
+out:
+	return ret;
+fault:
+	spin_unlock(&mm->page_table_lock);
+	if (__handle_fault(mm, uaddr, 0))
+		return 0;
+	spin_lock(&mm->page_table_lock);
+	goto retry;
+}
+
  size_t copy_from_user_pt(size_t n, const void __user *from, void *to)
  {
  	size_t rc;
@@ -152,3 +194,277 @@ size_t copy_to_user_pt(size_t n, void __
  	}
  	return __user_copy_pt((unsigned long) to, (void *) from, n, 1);
  }
+
+static size_t clear_user_pt(size_t n, void __user *to)
+{
+	long done, size, ret;
+
+	if (segment_eq(get_fs(), KERNEL_DS)) {
+		memset((void __kernel __force *) to, 0, n);
+		return 0;
+	}
+	done = 0;
+	do {
+		if (n - done > PAGE_SIZE)
+			size = PAGE_SIZE;
+		else
+			size = n - done;
+		ret = __user_copy_pt((unsigned long) to + done,
+				      &empty_zero_page, size, 1);
+		done += size;
+		if (ret)
+			return ret + n - done;
+	} while (done < n);
+	return 0;
+}
+
+static size_t strnlen_user_pt(size_t count, const char __user *src)
+{
+	char *addr;
+	unsigned long uaddr = (unsigned long) src;
+	struct mm_struct *mm = current->mm;
+	unsigned long offset, pfn, done, len;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	size_t len_str;
+
+	if (segment_eq(get_fs(), KERNEL_DS))
+		return strnlen((const char __kernel __force *) src, count) + 1;
+	done = 0;
+retry:
+	spin_lock(&mm->page_table_lock);
+	do {
+		pgd = pgd_offset(mm, uaddr);
+		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+			goto fault;
+
+		pmd = pmd_offset(pgd, uaddr);
+		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+			goto fault;
+
+		pte = pte_offset_map(pmd, uaddr);
+		if (!pte || !pte_present(*pte))
+			goto fault;
+
+		pfn = pte_pfn(*pte);
+		if (!pfn_valid(pfn)) {
+			done = -1;
+			goto out;
+		}
+
+		offset = uaddr & (PAGE_SIZE-1);
+		addr = (char *)(pfn << PAGE_SHIFT) + offset;
+		len = min(count - done, PAGE_SIZE - offset);
+		len_str = strnlen(addr, len);
+		done += len_str;
+		uaddr += len_str;
+	} while ((len_str == len) && (done < count));
+out:
+	spin_unlock(&mm->page_table_lock);
+	return done + 1;
+fault:
+	spin_unlock(&mm->page_table_lock);
+	if (__handle_fault(mm, uaddr, 0)) {
+		return 0;
+	}
+	goto retry;
+}
+
+static size_t strncpy_from_user_pt(size_t count, const char __user *src,
+				   char *dst)
+{
+	size_t n = strnlen_user_pt(count, src);
+
+	if (!n)
+		return -EFAULT;
+	if (n > count)
+		n = count;
+	if (segment_eq(get_fs(), KERNEL_DS)) {
+		memcpy(dst, (const char __kernel __force *) src, n);
+		if (dst[n-1] == '\0')
+			return n-1;
+		else
+			return n;
+	}
+	if (__user_copy_pt((unsigned long) src, dst, n, 0))
+		return -EFAULT;
+	if (dst[n-1] == '\0')
+		return n-1;
+	else
+		return n;
+}
+
+static size_t copy_in_user_pt(size_t n, void __user *to,
+			      const void __user *from)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long offset_from, offset_to, offset_max, pfn_from, pfn_to,
+		      uaddr, done, size;
+	unsigned long uaddr_from = (unsigned long) from;
+	unsigned long uaddr_to = (unsigned long) to;
+	pgd_t *pgd_from, *pgd_to;
+	pmd_t *pmd_from, *pmd_to;
+	pte_t *pte_from, *pte_to;
+	int write_user;
+
+	done = 0;
+retry:
+	spin_lock(&mm->page_table_lock);
+	do {
+		pgd_from = pgd_offset(mm, uaddr_from);
+		if (pgd_none(*pgd_from) || unlikely(pgd_bad(*pgd_from))) {
+			uaddr = uaddr_from;
+			write_user = 0;
+			goto fault;
+		}
+		pgd_to = pgd_offset(mm, uaddr_to);
+		if (pgd_none(*pgd_to) || unlikely(pgd_bad(*pgd_to))) {
+			uaddr = uaddr_to;
+			write_user = 1;
+			goto fault;
+		}
+
+		pmd_from = pmd_offset(pgd_from, uaddr_from);
+		if (pmd_none(*pmd_from) || unlikely(pmd_bad(*pmd_from))) {
+			uaddr = uaddr_from;
+			write_user = 0;
+			goto fault;
+		}
+		pmd_to = pmd_offset(pgd_to, uaddr_to);
+		if (pmd_none(*pmd_to) || unlikely(pmd_bad(*pmd_to))) {
+			uaddr = uaddr_to;
+			write_user = 1;
+			goto fault;
+		}
+
+		pte_from = pte_offset_map(pmd_from, uaddr_from);
+		if (!pte_from || !pte_present(*pte_from)) {
+			uaddr = uaddr_from;
+			write_user = 0;
+			goto fault;
+		}
+		pte_to = pte_offset_map(pmd_to, uaddr_to);
+		if (!pte_to || !pte_present(*pte_to) || !pte_write(*pte_to)) {
+			uaddr = uaddr_to;
+			write_user = 1;
+			goto fault;
+		}
+
+		pfn_from = pte_pfn(*pte_from);
+		if (!pfn_valid(pfn_from))
+			goto out;
+		pfn_to = pte_pfn(*pte_to);
+		if (!pfn_valid(pfn_to))
+			goto out;
+
+		offset_from = uaddr_from & (PAGE_SIZE-1);
+		offset_to = uaddr_from & (PAGE_SIZE-1);
+		offset_max = max(offset_from, offset_to);
+		size = min(n - done, PAGE_SIZE - offset_max);
+
+		memcpy((void *)(pfn_to << PAGE_SHIFT) + offset_to,
+		       (void *)(pfn_from << PAGE_SHIFT) + offset_from, size);
+		done += size;
+		uaddr_from += size;
+		uaddr_to += size;
+	} while (done < n);
+out:
+	spin_unlock(&mm->page_table_lock);
+	return n - done;
+fault:
+	spin_unlock(&mm->page_table_lock);
+	if (__handle_fault(mm, uaddr, write_user))
+		return n - done;
+	goto retry;
+}
+
+#define __futex_atomic_op(insn, ret, oldval, newval, uaddr, oparg)	\
+	asm volatile("0: l   %1,0(%6)\n"				\
+		     "1: " insn						\
+		     "2: cs  %1,%2,0(%6)\n"				\
+		     "3: jl  1b\n"					\
+		     "   lhi %0,0\n"					\
+		     "4:\n"						\
+		     EX_TABLE(0b,4b) EX_TABLE(2b,4b) EX_TABLE(3b,4b)	\
+		     : "=d" (ret), "=&d" (oldval), "=&d" (newval),	\
+		       "=m" (*uaddr)					\
+		     : "0" (-EFAULT), "d" (oparg), "a" (uaddr),		\
+		       "m" (*uaddr) : "cc" );
+
+int futex_atomic_op_pt(int op, int __user *uaddr, int oparg, int *old)
+{
+	int oldval = 0, newval, ret;
+
+	spin_lock(&current->mm->page_table_lock);
+	uaddr = (int __user *) __dat_user_addr((unsigned long) uaddr);
+	if (!uaddr) {
+		spin_unlock(&current->mm->page_table_lock);
+		return -EFAULT;
+	}
+	get_page(virt_to_page(uaddr));
+	spin_unlock(&current->mm->page_table_lock);
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("lr %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("lr %2,%1\nar %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("lr %2,%1\nor %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("lr %2,%1\nnr %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("lr %2,%1\nxr %2,%5\n",
+				  ret, oldval, newval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+	put_page(virt_to_page(uaddr));
+	*old = oldval;
+	return ret;
+}
+
+int futex_atomic_cmpxchg_pt(int __user *uaddr, int oldval, int newval)
+{
+	int ret;
+
+	spin_lock(&current->mm->page_table_lock);
+	uaddr = (int __user *) __dat_user_addr((unsigned long) uaddr);
+	if (!uaddr) {
+		spin_unlock(&current->mm->page_table_lock);
+		return -EFAULT;
+	}
+	get_page(virt_to_page(uaddr));
+	spin_unlock(&current->mm->page_table_lock);
+	asm volatile("   cs   %1,%4,0(%5)\n"
+		     "0: lr   %0,%1\n"
+		     "1:\n"
+		     EX_TABLE(0b,1b)
+		     : "=d" (ret), "+d" (oldval), "=m" (*uaddr)
+		     : "0" (-EFAULT), "d" (newval), "a" (uaddr), "m" (*uaddr)
+		     : "cc", "memory" );
+	put_page(virt_to_page(uaddr));
+	return ret;
+}
+
+struct uaccess_ops uaccess_pt = {
+	.copy_from_user		= copy_from_user_pt,
+	.copy_from_user_small	= copy_from_user_pt,
+	.copy_to_user		= copy_to_user_pt,
+	.copy_to_user_small	= copy_to_user_pt,
+	.copy_in_user		= copy_in_user_pt,
+	.clear_user		= clear_user_pt,
+	.strnlen_user		= strnlen_user_pt,
+	.strncpy_from_user	= strncpy_from_user_pt,
+	.futex_atomic_op	= futex_atomic_op_pt,
+	.futex_atomic_cmpxchg	= futex_atomic_cmpxchg_pt,
+};
diff -pruN linux-2.6.19/arch/s390/mm/fault.c linux-2.6.19xxx/arch/s390/mm/fault.c
--- linux-2.6.19/arch/s390/mm/fault.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/mm/fault.c	2006-12-13 17:11:04.000000000 +0100
@@ -137,7 +137,9 @@ static int __check_access_register(struc

  /*
   * Check which address space the address belongs to.
- * Returns 1 for user space and 0 for kernel space.
+ * May return 1 or 2 for user space and 0 for kernel space.
+ * Returns 2 for user space in primary addressing mode with
+ * CONFIG_S390_EXEC_PROTECT on and kernel parameter noexec=on.
   */
  static inline int check_user_space(struct pt_regs *regs, int error_code)
  {
@@ -154,7 +156,7 @@ static inline int check_user_space(struc
  		return __check_access_register(regs, error_code);
  	if (descriptor == 2)
  		return current->thread.mm_segment.ar4;
-	return descriptor != 0;
+	return ((descriptor != 0) ^ (switch_amode)) << s390_noexec;
  }

  /*
@@ -183,6 +185,77 @@ static void do_sigsegv(struct pt_regs *r
  	force_sig_info(SIGSEGV, &si, current);
  }

+#ifdef CONFIG_S390_EXEC_PROTECT
+extern long sys_sigreturn(struct pt_regs *regs);
+extern long sys_rt_sigreturn(struct pt_regs *regs);
+extern long sys32_sigreturn(struct pt_regs *regs);
+extern long sys32_rt_sigreturn(struct pt_regs *regs);
+
+static inline void do_sigreturn(struct mm_struct *mm, struct pt_regs *regs,
+				int rt)
+{
+	up_read(&mm->mmap_sem);
+	clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
+#ifdef CONFIG_COMPAT
+	if (test_tsk_thread_flag(current, TIF_31BIT)) {
+		if (rt)
+			sys32_rt_sigreturn(regs);
+		else
+			sys32_sigreturn(regs);
+		return;
+	}
+#endif /* CONFIG_COMPAT */
+	if (rt)
+		sys_rt_sigreturn(regs);
+	else
+		sys_sigreturn(regs);
+	return;
+}
+
+static int signal_return(struct mm_struct *mm, struct pt_regs *regs,
+			 unsigned long address, unsigned long error_code)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	u16 *instruction;
+	unsigned long pfn, uaddr = regs->psw.addr;
+
+	spin_lock(&mm->page_table_lock);
+	pgd = pgd_offset(mm, uaddr);
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		goto out_fault;
+	pmd = pmd_offset(pgd, uaddr);
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		goto out_fault;
+	pte = pte_offset_map(pmd_offset(pgd_offset(mm, uaddr), uaddr), uaddr);
+	if (!pte || !pte_present(*pte))
+		goto out_fault;
+	pfn = pte_pfn(*pte);
+	if (!pfn_valid(pfn))
+		goto out_fault;
+	spin_unlock(&mm->page_table_lock);
+
+	instruction = (u16 *) ((pfn << PAGE_SHIFT) + (uaddr & (PAGE_SIZE-1)));
+	if (*instruction == 0x0a77)
+		do_sigreturn(mm, regs, 0);
+	else if (*instruction == 0x0aad)
+		do_sigreturn(mm, regs, 1);
+	else {
+		printk("- XXX - do_exception: task = %s, primary, NO EXEC "
+		       "-> SIGSEGV\n", current->comm);
+		up_read(&mm->mmap_sem);
+		current->thread.prot_addr = address;
+		current->thread.trap_no = error_code;
+		do_sigsegv(regs, error_code, SEGV_MAPERR, address);
+	}
+	return 0;
+out_fault:
+	spin_unlock(&mm->page_table_lock);
+	return -EFAULT;
+}
+#endif /* CONFIG_S390_EXEC_PROTECT */
+
  /*
   * This routine handles page faults.  It determines the address,
   * and the problem, and then passes it off to one of the appropriate
@@ -260,6 +333,17 @@ do_exception(struct pt_regs *regs, unsig
          vma = find_vma(mm, address);
          if (!vma)
                  goto bad_area;
+
+#ifdef CONFIG_S390_EXEC_PROTECT
+	if (unlikely((user_address == 2) && !(vma->vm_flags & VM_EXEC)))
+		if (!signal_return(mm, regs, address, error_code))
+			/*
+			 * signal_return() has done an up_read(&mm->mmap_sem)
+			 * if it returns 0.
+			 */
+			return;
+#endif
+
          if (vma->vm_start <= address)
                  goto good_area;
          if (!(vma->vm_flags & VM_GROWSDOWN))
diff -pruN linux-2.6.19/arch/s390/mm/init.c linux-2.6.19xxx/arch/s390/mm/init.c
--- linux-2.6.19/arch/s390/mm/init.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/mm/init.c	2006-12-13 17:11:04.000000000 +0100
@@ -103,7 +103,7 @@ static void __init setup_ro_region(void)
  		pmd = pmd_offset(pgd, address);
  		pte = pte_offset_kernel(pmd, address);
  		new_pte = mk_pte_phys(address, __pgprot(_PAGE_RO));
-		set_pte(pte, new_pte);
+		*pte = new_pte;
  	}
  }

@@ -125,11 +125,11 @@ void __init paging_init(void)
  #ifdef CONFIG_64BIT
  	pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERN_REGION_TABLE;
  	for (i = 0; i < PTRS_PER_PGD; i++)
-		pgd_clear(pg_dir + i);
+		pgd_clear_kernel(pg_dir + i);
  #else
  	pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
  	for (i = 0; i < PTRS_PER_PGD; i++)
-		pmd_clear((pmd_t *)(pg_dir + i));
+		pmd_clear_kernel((pmd_t *)(pg_dir + i));
  #endif
  	vmem_map_init();
  	setup_ro_region();
diff -pruN linux-2.6.19/arch/s390/mm/vmem.c linux-2.6.19xxx/arch/s390/mm/vmem.c
--- linux-2.6.19/arch/s390/mm/vmem.c	2006-12-12 17:31:17.000000000 +0100
+++ linux-2.6.19xxx/arch/s390/mm/vmem.c	2006-12-13 17:11:04.000000000 +0100
@@ -81,7 +81,7 @@ static inline pmd_t *vmem_pmd_alloc(void
  	if (!pmd)
  		return NULL;
  	for (i = 0; i < PTRS_PER_PMD; i++)
-		pmd_clear(pmd + i);
+		pmd_clear_kernel(pmd + i);
  	return pmd;
  }

@@ -96,7 +96,7 @@ static inline pte_t *vmem_pte_alloc(void
  		return NULL;
  	pte_val(empty_pte) = _PAGE_TYPE_EMPTY;
  	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(pte + i, empty_pte);
+		pte[i] = empty_pte;
  	return pte;
  }

@@ -118,7 +118,7 @@ static int vmem_add_range(unsigned long
  			pm_dir = vmem_pmd_alloc();
  			if (!pm_dir)
  				goto out;
-			pgd_populate(&init_mm, pg_dir, pm_dir);
+			pgd_populate_kernel(&init_mm, pg_dir, pm_dir);
  		}

  		pm_dir = pmd_offset(pg_dir, address);
@@ -131,7 +131,7 @@ static int vmem_add_range(unsigned long

  		pt_dir = pte_offset_kernel(pm_dir, address);
  		pte = pfn_pte(address >> PAGE_SHIFT, PAGE_KERNEL);
-		set_pte(pt_dir, pte);
+		*pt_dir = pte;
  	}
  	ret = 0;
  out:
@@ -160,7 +160,7 @@ static void vmem_remove_range(unsigned l
  		if (pmd_none(*pm_dir))
  			continue;
  		pt_dir = pte_offset_kernel(pm_dir, address);
-		set_pte(pt_dir, pte);
+		*pt_dir = pte;
  	}
  	flush_tlb_kernel_range(start, start + size);
  }
@@ -190,7 +190,7 @@ static int vmem_add_mem_map(unsigned lon
  			pm_dir = vmem_pmd_alloc();
  			if (!pm_dir)
  				goto out;
-			pgd_populate(&init_mm, pg_dir, pm_dir);
+			pgd_populate_kernel(&init_mm, pg_dir, pm_dir);
  		}

  		pm_dir = pmd_offset(pg_dir, address);
@@ -209,7 +209,7 @@ static int vmem_add_mem_map(unsigned lon
  			if (!new_page)
  				goto out;
  			pte = pfn_pte(new_page >> PAGE_SHIFT, PAGE_KERNEL);
-			set_pte(pt_dir, pte);
+			*pt_dir = pte;
  		}
  	}
  	ret = 0;
diff -pruN linux-2.6.19/include/asm-s390/compat.h linux-2.6.19xxx/include/asm-s390/compat.h
--- linux-2.6.19/include/asm-s390/compat.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/compat.h	2006-12-13 17:11:04.000000000 +0100
@@ -6,6 +6,34 @@
  #include <linux/types.h>
  #include <linux/sched.h>

+#define PSW32_MASK_PER		0x40000000UL
+#define PSW32_MASK_DAT		0x04000000UL
+#define PSW32_MASK_IO		0x02000000UL
+#define PSW32_MASK_EXT		0x01000000UL
+#define PSW32_MASK_KEY		0x00F00000UL
+#define PSW32_MASK_MCHECK	0x00040000UL
+#define PSW32_MASK_WAIT		0x00020000UL
+#define PSW32_MASK_PSTATE	0x00010000UL
+#define PSW32_MASK_ASC		0x0000C000UL
+#define PSW32_MASK_CC		0x00003000UL
+#define PSW32_MASK_PM		0x00000f00UL
+
+#define PSW32_ADDR_AMODE31	0x80000000UL
+#define PSW32_ADDR_INSN		0x7FFFFFFFUL
+
+#define PSW32_BASE_BITS		0x00080000UL
+
+#define PSW32_ASC_PRIMARY	0x00000000UL
+#define PSW32_ASC_ACCREG	0x00004000UL
+#define PSW32_ASC_SECONDARY	0x00008000UL
+#define PSW32_ASC_HOME		0x0000C000UL
+
+#define PSW32_MASK_MERGE(CURRENT,NEW) \
+	(((CURRENT) & ~(PSW32_MASK_CC|PSW32_MASK_PM)) | \
+	 ((NEW) & (PSW32_MASK_CC|PSW32_MASK_PM)))
+
+extern long psw32_user_bits;
+
  #define COMPAT_USER_HZ	100

  typedef u32		compat_size_t;
diff -pruN linux-2.6.19/include/asm-s390/lowcore.h linux-2.6.19xxx/include/asm-s390/lowcore.h
--- linux-2.6.19/include/asm-s390/lowcore.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/lowcore.h	2006-12-13 17:11:04.000000000 +0100
@@ -220,7 +220,8 @@ struct _lowcore
  	__u32        kernel_asce;              /* 0xc4c */
  	__u32        user_asce;                /* 0xc50 */
  	__u32        panic_stack;              /* 0xc54 */
-	__u8         pad10[0xc60-0xc58];       /* 0xc58 */
+	__u32	     user_exec_asce;	       /* 0xc58 */
+	__u8	     pad10[0xc60-0xc5c];       /* 0xc5c */
  	/* entry.S sensitive area start */
  	struct       cpuinfo_S390 cpu_data;    /* 0xc60 */
  	__u32        ipl_device;               /* 0xc7c */
@@ -310,7 +311,8 @@ struct _lowcore
  	__u64        kernel_asce;              /* 0xd58 */
  	__u64        user_asce;                /* 0xd60 */
  	__u64        panic_stack;              /* 0xd68 */
-	__u8         pad10[0xd80-0xd70];       /* 0xd70 */
+	__u64	     user_exec_asce;	       /* 0xd70 */
+	__u8	     pad10[0xd80-0xd78];       /* 0xd78 */
  	/* entry.S sensitive area start */
  	struct       cpuinfo_S390 cpu_data;    /* 0xd80 */
  	__u32        ipl_device;               /* 0xdb8 */
diff -pruN linux-2.6.19/include/asm-s390/mmu_context.h linux-2.6.19xxx/include/asm-s390/mmu_context.h
--- linux-2.6.19/include/asm-s390/mmu_context.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/mmu_context.h	2006-12-13 17:11:04.000000000 +0100
@@ -9,6 +9,7 @@
  #ifndef __S390_MMU_CONTEXT_H
  #define __S390_MMU_CONTEXT_H

+#include <asm/pgalloc.h>
  /*
   * get a new mmu context.. S390 don't know about contexts.
   */
@@ -16,29 +17,44 @@

  #define destroy_context(mm)             do { } while (0)

+#ifndef __s390x__
+#define LCTL_OPCODE "lctl"
+#define PGTABLE_BITS (_SEGMENT_TABLE|USER_STD_MASK)
+#else
+#define LCTL_OPCODE "lctlg"
+#define PGTABLE_BITS (_REGION_TABLE|USER_STD_MASK)
+#endif
+
  static inline void enter_lazy_tlb(struct mm_struct *mm,
                                    struct task_struct *tsk)
  {
  }

  static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-                             struct task_struct *tsk)
+			     struct task_struct *tsk)
  {
-        if (prev != next) {
-#ifndef __s390x__
-	        S390_lowcore.user_asce = (__pa(next->pgd)&PAGE_MASK) |
-                      (_SEGMENT_TABLE|USER_STD_MASK);
-                /* Load home space page table origin. */
-                asm volatile("lctl  13,13,%0"
-			     : : "m" (S390_lowcore.user_asce) );
-#else /* __s390x__ */
-                S390_lowcore.user_asce = (__pa(next->pgd) & PAGE_MASK) |
-			(_REGION_TABLE|USER_STD_MASK);
-		/* Load home space page table origin. */
-		asm volatile("lctlg  13,13,%0"
-			     : : "m" (S390_lowcore.user_asce) );
-#endif /* __s390x__ */
-        }
+	pgd_t *shadow_pgd = get_shadow_pgd(next->pgd);
+
+	if (prev != next) {
+		S390_lowcore.user_asce = (__pa(next->pgd) & PAGE_MASK) |
+					 PGTABLE_BITS;
+		if (shadow_pgd) {
+			/* Load primary/secondary space page table origin. */
+			S390_lowcore.user_exec_asce =
+				(__pa(shadow_pgd) & PAGE_MASK) | PGTABLE_BITS;
+			asm volatile(LCTL_OPCODE" 1,1,%0\n"
+				     LCTL_OPCODE" 7,7,%1"
+				     : : "m" (S390_lowcore.user_exec_asce),
+					 "m" (S390_lowcore.user_asce) );
+		} else if (switch_amode) {
+			/* Load primary space page table origin. */
+			asm volatile(LCTL_OPCODE" 1,1,%0"
+				     : : "m" (S390_lowcore.user_asce) );
+		} else
+			/* Load home space page table origin. */
+			asm volatile(LCTL_OPCODE" 13,13,%0"
+				     : : "m" (S390_lowcore.user_asce) );
+	}
  	cpu_set(smp_processor_id(), next->cpu_vm_mask);
  }

@@ -51,4 +67,4 @@ static inline void activate_mm(struct mm
  	set_fs(current->thread.mm_segment);
  }

-#endif
+#endif /* __S390_MMU_CONTEXT_H */
diff -pruN linux-2.6.19/include/asm-s390/pgalloc.h linux-2.6.19xxx/include/asm-s390/pgalloc.h
--- linux-2.6.19/include/asm-s390/pgalloc.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/pgalloc.h	2006-12-13 17:11:04.000000000 +0100
@@ -47,6 +47,17 @@ static inline pgd_t *pgd_alloc(struct mm

  	if (!pgd)
  		return NULL;
+	if (s390_noexec) {
+		pgd_t *shadow_pgd = (pgd_t *)
+			__get_free_pages(GFP_KERNEL, PGD_ALLOC_ORDER);
+		struct page *page = virt_to_page(pgd);
+
+		if (!shadow_pgd) {
+			free_pages((unsigned long) pgd, PGD_ALLOC_ORDER);
+			return NULL;
+		}
+		page->lru.next = (void *) shadow_pgd;
+	}
  	for (i = 0; i < PTRS_PER_PGD; i++)
  #ifndef __s390x__
  		pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
@@ -58,6 +69,10 @@ static inline pgd_t *pgd_alloc(struct mm

  static inline void pgd_free(pgd_t *pgd)
  {
+	pgd_t *shadow_pgd = get_shadow_pgd(pgd);
+
+	if (shadow_pgd)
+		free_pages((unsigned long) shadow_pgd, PGD_ALLOC_ORDER);
  	free_pages((unsigned long) pgd, PGD_ALLOC_ORDER);
  }

@@ -71,6 +86,7 @@ static inline void pgd_free(pgd_t *pgd)
  #define pmd_free(x)                     do { } while (0)
  #define __pmd_free_tlb(tlb,x)		do { } while (0)
  #define pgd_populate(mm, pmd, pte)      BUG()
+#define pgd_populate_kernel(mm, pmd, pte)	BUG()
  #else /* __s390x__ */
  static inline pmd_t * pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
  {
@@ -79,6 +95,17 @@ static inline pmd_t * pmd_alloc_one(stru

  	if (!pmd)
  		return NULL;
+	if (s390_noexec) {
+		pmd_t *shadow_pmd = (pmd_t *)
+			__get_free_pages(GFP_KERNEL, PMD_ALLOC_ORDER);
+		struct page *page = virt_to_page(pmd);
+
+		if (!shadow_pmd) {
+			free_pages((unsigned long) pmd, PMD_ALLOC_ORDER);
+			return NULL;
+		}
+		page->lru.next = (void *) shadow_pmd;
+	}
  	for (i=0; i < PTRS_PER_PMD; i++)
  		pmd_clear(pmd + i);
  	return pmd;
@@ -86,6 +113,10 @@ static inline pmd_t * pmd_alloc_one(stru

  static inline void pmd_free (pmd_t *pmd)
  {
+	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
+
+	if (shadow_pmd)
+		free_pages((unsigned long) shadow_pmd, PMD_ALLOC_ORDER);
  	free_pages((unsigned long) pmd, PMD_ALLOC_ORDER);
  }

@@ -95,11 +126,22 @@ static inline void pmd_free (pmd_t *pmd)
  		pmd_free(pmd);			\
  	 } while (0)

-static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+static inline void
+pgd_populate_kernel(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
  {
  	pgd_val(*pgd) = _PGD_ENTRY | __pa(pmd);
  }

+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+{
+	pgd_t *shadow_pgd = get_shadow_pgd(pgd);
+	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
+
+	if (shadow_pgd && shadow_pmd)
+		pgd_populate_kernel(mm, shadow_pgd, shadow_pmd);
+	pgd_populate_kernel(mm, pgd, pmd);
+}
+
  #endif /* __s390x__ */

  static inline void
@@ -119,7 +161,13 @@ pmd_populate_kernel(struct mm_struct *mm
  static inline void
  pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct page *page)
  {
-	pmd_populate_kernel(mm, pmd, (pte_t *)page_to_phys(page));
+	pte_t *pte = (pte_t *)page_to_phys(page);
+	pmd_t *shadow_pmd = get_shadow_pmd(pmd);
+	pte_t *shadow_pte = get_shadow_pte(pte);
+
+	pmd_populate_kernel(mm, pmd, pte);
+	if (shadow_pmd && shadow_pte)
+		pmd_populate_kernel(mm, shadow_pmd, shadow_pte);
  }

  /*
@@ -133,6 +181,17 @@ pte_alloc_one_kernel(struct mm_struct *m

  	if (!pte)
  		return NULL;
+	if (s390_noexec) {
+		pte_t *shadow_pte = (pte_t *)
+			__get_free_page(GFP_KERNEL|__GFP_REPEAT);
+		struct page *page = virt_to_page(pte);
+
+		if (!shadow_pte) {
+			free_page((unsigned long) pte);
+			return NULL;
+		}
+		page->lru.next = (void *) shadow_pte;
+	}
  	for (i=0; i < PTRS_PER_PTE; i++) {
  		pte_clear(mm, vmaddr, pte + i);
  		vmaddr += PAGE_SIZE;
@@ -151,14 +210,30 @@ pte_alloc_one(struct mm_struct *mm, unsi

  static inline void pte_free_kernel(pte_t *pte)
  {
-        free_page((unsigned long) pte);
+	pte_t *shadow_pte = get_shadow_pte(pte);
+
+	if (shadow_pte)
+		free_page((unsigned long) shadow_pte);
+	free_page((unsigned long) pte);
  }

  static inline void pte_free(struct page *pte)
  {
-        __free_page(pte);
-}
+	struct page *shadow_page = get_shadow_page(pte);

-#define __pte_free_tlb(tlb,pte) tlb_remove_page(tlb,pte)
+	if (shadow_page)
+		__free_page(shadow_page);
+	__free_page(pte);
+}
+
+#define __pte_free_tlb(tlb, pte)					\
+({									\
+	struct mmu_gather *__tlb = (tlb);				\
+	struct page *__pte = (pte);					\
+	struct page *shadow_page = get_shadow_page(__pte);		\
+	if (shadow_page)						\
+		tlb_remove_page(__tlb, shadow_page);			\
+	tlb_remove_page(__tlb, __pte);					\
+})

  #endif /* _S390_PGALLOC_H */
diff -pruN linux-2.6.19/include/asm-s390/pgtable.h linux-2.6.19xxx/include/asm-s390/pgtable.h
--- linux-2.6.19/include/asm-s390/pgtable.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/pgtable.h	2006-12-13 17:11:04.000000000 +0100
@@ -223,6 +223,8 @@ extern unsigned long vmalloc_end;
  #define _PAGE_TYPE_FILE		0x601	/* bit 0x002 is used for offset !! */
  #define _PAGE_TYPE_RO		0x200
  #define _PAGE_TYPE_RW		0x000
+#define _PAGE_TYPE_EX_RO	0x202
+#define _PAGE_TYPE_EX_RW	0x002

  /*
   * PTE type bits are rather complicated. handle_pte_fault uses pte_present,
@@ -243,11 +245,13 @@ extern unsigned long vmalloc_end;
   * _PAGE_TYPE_FILE	11?1   ->   11?1
   * _PAGE_TYPE_RO	0100   ->   1100
   * _PAGE_TYPE_RW	0000   ->   1000
+ * _PAGE_TYPE_EX_RO	0110   ->   1110
+ * _PAGE_TYPE_EX_RW	0010   ->   1010
   *
- * pte_none is true for bits combinations 1000, 1100
+ * pte_none is true for bits combinations 1000, 1010, 1100, 1110
   * pte_present is true for bits combinations 0000, 0010, 0100, 0110, 1001
   * pte_file is true for bits combinations 1101, 1111
- * swap pte is 1011 and 0001, 0011, 0101, 0111, 1010 and 1110 are invalid.
+ * swap pte is 1011 and 0001, 0011, 0101, 0111 are invalid.
   */

  #ifndef __s390x__
@@ -312,33 +316,100 @@ extern unsigned long vmalloc_end;
  #define PAGE_NONE	__pgprot(_PAGE_TYPE_NONE)
  #define PAGE_RO		__pgprot(_PAGE_TYPE_RO)
  #define PAGE_RW		__pgprot(_PAGE_TYPE_RW)
+#define PAGE_EX_RO	__pgprot(_PAGE_TYPE_EX_RO)
+#define PAGE_EX_RW	__pgprot(_PAGE_TYPE_EX_RW)

  #define PAGE_KERNEL	PAGE_RW
  #define PAGE_COPY	PAGE_RO

  /*
- * The S390 can't do page protection for execute, and considers that the
- * same are read. Also, write permissions imply read permissions. This is
- * the closest we can get..
+ * Dependent on the EXEC_PROTECT option s390 can do execute protection.
+ * Write permission always implies read permission. In theory with a
+ * primary/secondary page table execute only can be implemented but
+ * it would cost an additional bit in the pte to distinguish all the
+ * different pte types. To avoid that execute permission currently
+ * implies read permission as well.
   */
           /*xwr*/
  #define __P000	PAGE_NONE
  #define __P001	PAGE_RO
  #define __P010	PAGE_RO
  #define __P011	PAGE_RO
-#define __P100	PAGE_RO
-#define __P101	PAGE_RO
-#define __P110	PAGE_RO
-#define __P111	PAGE_RO
+#define __P100	PAGE_EX_RO
+#define __P101	PAGE_EX_RO
+#define __P110	PAGE_EX_RO
+#define __P111	PAGE_EX_RO

  #define __S000	PAGE_NONE
  #define __S001	PAGE_RO
  #define __S010	PAGE_RW
  #define __S011	PAGE_RW
-#define __S100	PAGE_RO
-#define __S101	PAGE_RO
-#define __S110	PAGE_RW
-#define __S111	PAGE_RW
+#define __S100	PAGE_EX_RO
+#define __S101	PAGE_EX_RO
+#define __S110	PAGE_EX_RW
+#define __S111	PAGE_EX_RW
+
+#ifndef __s390x__
+# define PMD_SHADOW_SHIFT	1
+# define PGD_SHADOW_SHIFT	1
+#else /* __s390x__ */
+# define PMD_SHADOW_SHIFT	2
+# define PGD_SHADOW_SHIFT	2
+#endif /* __s390x__ */
+
+static inline struct page *get_shadow_page(struct page *page)
+{
+	if (s390_noexec && !list_empty(&page->lru))
+		return virt_to_page(page->lru.next);
+	return NULL;
+}
+
+static inline pte_t *get_shadow_pte(pte_t *ptep)
+{
+	unsigned long pteptr = (unsigned long) (ptep);
+
+	if (s390_noexec) {
+		unsigned long offset = pteptr & (PAGE_SIZE - 1);
+		void *addr = (void *) (pteptr ^ offset);
+		struct page *page = virt_to_page(addr);
+		if (!list_empty(&page->lru))
+			return (pte_t *) ((unsigned long) page->lru.next |
+								offset);
+	}
+	return NULL;
+}
+
+static inline pmd_t *get_shadow_pmd(pmd_t *pmdp)
+{
+	unsigned long pmdptr = (unsigned long) (pmdp);
+
+	if (s390_noexec) {
+		unsigned long offset = pmdptr &
+				((PAGE_SIZE << PMD_SHADOW_SHIFT) - 1);
+		void *addr = (void *) (pmdptr ^ offset);
+		struct page *page = virt_to_page(addr);
+		if (!list_empty(&page->lru))
+			return (pmd_t *) ((unsigned long) page->lru.next |
+								offset);
+	}
+	return NULL;
+}
+
+static inline pgd_t *get_shadow_pgd(pgd_t *pgdp)
+{
+	unsigned long pgdptr = (unsigned long) (pgdp);
+
+	if (s390_noexec) {
+		unsigned long offset = pgdptr &
+				((PAGE_SIZE << PGD_SHADOW_SHIFT) - 1);
+		void *addr = (void *) (pgdptr ^ offset);
+		struct page *page = virt_to_page(addr);
+		if (!list_empty(&page->lru))
+			return (pgd_t *) ((unsigned long) page->lru.next |
+								offset);
+	}
+	return NULL;
+}

  /*
   * Certain architectures need to do special things when PTEs
@@ -347,7 +418,16 @@ extern unsigned long vmalloc_end;
   */
  static inline void set_pte(pte_t *pteptr, pte_t pteval)
  {
+	pte_t *shadow_pte = get_shadow_pte(pteptr);
+
  	*pteptr = pteval;
+	if (shadow_pte) {
+		if (!(pte_val(pteval) & _PAGE_INVALID) &&
+		    (pte_val(pteval) & _PAGE_SWX))
+			pte_val(*shadow_pte) = pte_val(pteval) | _PAGE_RO;
+		else
+			pte_val(*shadow_pte) = _PAGE_TYPE_EMPTY;
+	}
  }
  #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)

@@ -465,7 +545,7 @@ static inline int pte_read(pte_t pte)

  static inline void pgd_clear(pgd_t * pgdp)      { }

-static inline void pmd_clear(pmd_t * pmdp)
+static inline void pmd_clear_kernel(pmd_t * pmdp)
  {
  	pmd_val(pmdp[0]) = _PAGE_TABLE_INV;
  	pmd_val(pmdp[1]) = _PAGE_TABLE_INV;
@@ -473,24 +553,55 @@ static inline void pmd_clear(pmd_t * pmd
  	pmd_val(pmdp[3]) = _PAGE_TABLE_INV;
  }

+static inline void pmd_clear(pmd_t * pmdp)
+{
+	pmd_t *shadow_pmd = get_shadow_pmd(pmdp);
+
+	pmd_clear_kernel(pmdp);
+	if (shadow_pmd)
+		pmd_clear_kernel(shadow_pmd);
+}
+
  #else /* __s390x__ */

-static inline void pgd_clear(pgd_t * pgdp)
+static inline void pgd_clear_kernel(pgd_t * pgdp)
  {
  	pgd_val(*pgdp) = _PGD_ENTRY_INV | _PGD_ENTRY;
  }

-static inline void pmd_clear(pmd_t * pmdp)
+static inline void pgd_clear(pgd_t * pgdp)
+{
+	pgd_t *shadow_pgd = get_shadow_pgd(pgdp);
+
+	pgd_clear_kernel(pgdp);
+	if (shadow_pgd)
+		pgd_clear_kernel(shadow_pgd);
+}
+
+static inline void pmd_clear_kernel(pmd_t * pmdp)
  {
  	pmd_val(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
  	pmd_val1(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
  }

+static inline void pmd_clear(pmd_t * pmdp)
+{
+	pmd_t *shadow_pmd = get_shadow_pmd(pmdp);
+
+	pmd_clear_kernel(pmdp);
+	if (shadow_pmd)
+		pmd_clear_kernel(shadow_pmd);
+}
+
  #endif /* __s390x__ */

  static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
  {
+	pte_t *shadow_pte = get_shadow_pte(ptep);
+
  	pte_val(*ptep) = _PAGE_TYPE_EMPTY;
+	if (shadow_pte)
+		pte_val(*shadow_pte) = _PAGE_TYPE_EMPTY;
  }

  /*
@@ -608,8 +719,11 @@ ptep_clear_flush(struct vm_area_struct *
  		 unsigned long address, pte_t *ptep)
  {
  	pte_t pte = *ptep;
+	pte_t *shadow_pte = get_shadow_pte(ptep);

  	__ptep_ipte(address, ptep);
+	if (shadow_pte)
+		__ptep_ipte(address, shadow_pte);
  	return pte;
  }

diff -pruN linux-2.6.19/include/asm-s390/processor.h linux-2.6.19xxx/include/asm-s390/processor.h
--- linux-2.6.19/include/asm-s390/processor.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/processor.h	2006-12-13 17:11:04.000000000 +0100
@@ -144,7 +144,7 @@ struct stack_frame {
  #ifndef __s390x__

  #define start_thread(regs, new_psw, new_stackp) do {            \
-        regs->psw.mask  = PSW_USER_BITS;                        \
+	regs->psw.mask	= psw_user_bits;			\
          regs->psw.addr  = new_psw | PSW_ADDR_AMODE;             \
          regs->gprs[15]  = new_stackp ;                          \
  } while (0)
@@ -152,13 +152,13 @@ struct stack_frame {
  #else /* __s390x__ */

  #define start_thread(regs, new_psw, new_stackp) do {            \
-        regs->psw.mask  = PSW_USER_BITS;                        \
+	regs->psw.mask	= psw_user_bits;			\
          regs->psw.addr  = new_psw;                              \
          regs->gprs[15]  = new_stackp;                           \
  } while (0)

  #define start_thread31(regs, new_psw, new_stackp) do {          \
-	regs->psw.mask  = PSW_USER32_BITS;			\
+	regs->psw.mask	= psw_user32_bits;			\
          regs->psw.addr  = new_psw;                              \
          regs->gprs[15]  = new_stackp;                           \
  } while (0)
diff -pruN linux-2.6.19/include/asm-s390/ptrace.h linux-2.6.19xxx/include/asm-s390/ptrace.h
--- linux-2.6.19/include/asm-s390/ptrace.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/ptrace.h	2006-12-13 17:11:04.000000000 +0100
@@ -266,17 +266,12 @@ typedef struct
  #define PSW_ASC_SECONDARY	0x0000800000000000UL
  #define PSW_ASC_HOME		0x0000C00000000000UL

-#define PSW_USER32_BITS (PSW_BASE32_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
-			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
-			 PSW_MASK_PSTATE | PSW_DEFAULT_KEY)
+extern long psw_user32_bits;

  #endif /* __s390x__ */

-#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY | \
-			 PSW_MASK_MCHECK | PSW_DEFAULT_KEY)
-#define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
-			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
-			 PSW_MASK_PSTATE | PSW_DEFAULT_KEY)
+extern long psw_kernel_bits;
+extern long psw_user_bits;

  /* This macro merges a NEW PSW mask specified by the user into
     the currently active PSW mask CURRENT, modifying only those
diff -pruN linux-2.6.19/include/asm-s390/setup.h linux-2.6.19xxx/include/asm-s390/setup.h
--- linux-2.6.19/include/asm-s390/setup.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/setup.h	2006-12-13 17:11:04.000000000 +0100
@@ -42,6 +42,18 @@ struct mem_chunk {

  extern struct mem_chunk memory_chunk[];

+#ifdef CONFIG_S390_SWITCH_AMODE
+extern unsigned int switch_amode;
+#else
+#define switch_amode	(0)
+#endif
+
+#ifdef CONFIG_S390_EXEC_PROTECT
+extern unsigned int s390_noexec;
+#else
+#define s390_noexec	(0)
+#endif
+
  /*
   * Machine features detected in head.S
   */
diff -pruN linux-2.6.19/include/asm-s390/smp.h linux-2.6.19xxx/include/asm-s390/smp.h
--- linux-2.6.19/include/asm-s390/smp.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/smp.h	2006-12-13 17:11:04.000000000 +0100
@@ -106,7 +106,7 @@ smp_call_function_on(void (*func) (void
  static inline void smp_send_stop(void)
  {
  	/* Disable all interrupts/machine checks */
-	__load_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK);
+	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
  }

  #define smp_cpu_not_running(cpu)	1
diff -pruN linux-2.6.19/include/asm-s390/system.h linux-2.6.19xxx/include/asm-s390/system.h
--- linux-2.6.19/include/asm-s390/system.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/system.h	2006-12-13 17:11:04.000000000 +0100
@@ -373,8 +373,8 @@ __set_psw_mask(unsigned long mask)
  	__load_psw_mask(mask | (__raw_local_irq_stosm(0x00) & ~(-1UL >> 8)));
  }

-#define local_mcck_enable()  __set_psw_mask(PSW_KERNEL_BITS)
-#define local_mcck_disable() __set_psw_mask(PSW_KERNEL_BITS & ~PSW_MASK_MCHECK)
+#define local_mcck_enable()  __set_psw_mask(psw_kernel_bits)
+#define local_mcck_disable() __set_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK)

  #ifdef CONFIG_SMP

diff -pruN linux-2.6.19/include/asm-s390/tlbflush.h linux-2.6.19xxx/include/asm-s390/tlbflush.h
--- linux-2.6.19/include/asm-s390/tlbflush.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/tlbflush.h	2006-12-13 17:11:04.000000000 +0100
@@ -3,6 +3,7 @@

  #include <linux/mm.h>
  #include <asm/processor.h>
+#include <asm/pgalloc.h>

  /*
   * TLB flushing:
@@ -102,6 +103,14 @@ static inline void __flush_tlb_mm(struct
  	if (unlikely(cpus_empty(mm->cpu_vm_mask)))
  		return;
  	if (MACHINE_HAS_IDTE) {
+		pgd_t *shadow_pgd = get_shadow_pgd(mm->pgd);
+
+		if (shadow_pgd) {
+			asm volatile(
+				"	.insn	rrf,0xb98e0000,0,%0,%1,0"
+				: : "a" (2049),
+				"a" (__pa(shadow_pgd) & PAGE_MASK) : "cc" );
+		}
  		asm volatile(
  			"	.insn	rrf,0xb98e0000,0,%0,%1,0"
  			: : "a" (2048), "a" (__pa(mm->pgd)&PAGE_MASK) : "cc");
diff -pruN linux-2.6.19/include/asm-s390/uaccess.h linux-2.6.19xxx/include/asm-s390/uaccess.h
--- linux-2.6.19/include/asm-s390/uaccess.h	2006-12-12 17:31:20.000000000 +0100
+++ linux-2.6.19xxx/include/asm-s390/uaccess.h	2006-12-13 17:11:04.000000000 +0100
@@ -90,6 +90,8 @@ struct uaccess_ops {
  extern struct uaccess_ops uaccess;
  extern struct uaccess_ops uaccess_std;
  extern struct uaccess_ops uaccess_mvcos;
+extern struct uaccess_ops uaccess_mvcos_switch;
+extern struct uaccess_ops uaccess_pt;

  static inline int __put_user_fn(size_t size, void __user *ptr, void *x)
  {
