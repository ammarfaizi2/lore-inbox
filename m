Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263211AbVFXT01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbVFXT01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbVFXT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:26:26 -0400
Received: from fmr23.intel.com ([143.183.121.15]:63432 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S263209AbVFXTYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:24:05 -0400
Date: Fri, 24 Jun 2005 12:23:33 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: davidm@hpl.hp.com
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, akpm@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux IA64 <linux-ia64@vger.kernel.org>
Subject: [patch][ia64]Refuse kprobe on ivt code- take 2
Message-ID: <20050624122333.A5213@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050623172832.B26121@unix-os.sc.intel.com> <17083.25625.991516.736507@napali.hpl.hp.com> <20050624114545.A4826@unix-os.sc.intel.com> <17084.23214.237084.224128@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <17084.23214.237084.224128@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Fri, Jun 24, 2005 at 12:10:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 12:10:38PM -0700, David Mosberger wrote:
> >>>>> On Fri, 24 Jun 2005 11:45:46 -0700, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> said:
> Surely you meant to use the declaration from sections.h instead?

Take 1: This patch is based on review comments from David Mosberger,
now checking based on .text.ivt
Take 2: now including sections.h :-)

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

===============================================
 arch/ia64/kernel/kprobes.c     |   14 ++++++++++++++
 arch/ia64/kernel/vmlinux.lds.S |    7 ++++++-
 include/asm-ia64/sections.h    |    1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

Index: linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
@@ -34,6 +34,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
+#include <asm/sections.h>
 
 extern void jprobe_inst_return(void);
 
@@ -263,6 +264,13 @@ static inline void get_kprobe_inst(bundl
 	}
 }
 
+/* Returns non-zero if the addr is in the Interrupt Vector Table */
+static inline int in_ivt_functions(unsigned long addr)
+{
+	return (addr >= (unsigned long)__start_ivt_text
+		&& addr < (unsigned long)__end_ivt_text);
+}
+
 static int valid_kprobe_addr(int template, int slot, unsigned long addr)
 {
 	if ((slot > 2) || ((bundle_encoding[template][1] == L) && slot > 1)) {
@@ -271,6 +279,12 @@ static int valid_kprobe_addr(int templat
 		return -EINVAL;
 	}
 
+ 	if (in_ivt_functions(addr)) {
+ 		printk(KERN_WARNING "Kprobes can't be inserted inside "
+				"IVT functions at 0x%lx\n", addr);
+ 		return -EINVAL;
+ 	}
+
 	if (slot == 1) {
 		printk(KERN_WARNING "Inserting kprobes on slot #1 "
 		       "is not supported\n");
Index: linux-2.6.12-mm1/arch/ia64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/kernel/vmlinux.lds.S
+++ linux-2.6.12-mm1/arch/ia64/kernel/vmlinux.lds.S
@@ -8,6 +8,11 @@
 #define LOAD_OFFSET	(KERNEL_START - KERNEL_TR_PAGE_SIZE)
 #include <asm-generic/vmlinux.lds.h>
 
+#define IVT_TEXT							\
+		VMLINUX_SYMBOL(__start_ivt_text) = .;			\
+		*(.text.ivt)						\
+		VMLINUX_SYMBOL(__end_ivt_text) = .;
+
 OUTPUT_FORMAT("elf64-ia64-little")
 OUTPUT_ARCH(ia64)
 ENTRY(phys_start)
@@ -39,7 +44,7 @@ SECTIONS
 
   .text : AT(ADDR(.text) - LOAD_OFFSET)
     {
-	*(.text.ivt)
+	IVT_TEXT
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
Index: linux-2.6.12-mm1/include/asm-ia64/sections.h
===================================================================
--- linux-2.6.12-mm1.orig/include/asm-ia64/sections.h
+++ linux-2.6.12-mm1/include/asm-ia64/sections.h
@@ -17,6 +17,7 @@ extern char __start_gate_vtop_patchlist[
 extern char __start_gate_fsyscall_patchlist[], __end_gate_fsyscall_patchlist[];
 extern char __start_gate_brl_fsys_bubble_down_patchlist[], __end_gate_brl_fsys_bubble_down_patchlist[];
 extern char __start_unwind[], __end_unwind[];
+extern char __start_ivt_text[], __end_ivt_text[];
 
 #endif /* _ASM_IA64_SECTIONS_H */
 
