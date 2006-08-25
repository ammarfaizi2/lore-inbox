Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWHYHH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWHYHH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHYHH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:07:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33171 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750767AbWHYHH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:07:56 -0400
Date: Fri, 25 Aug 2006 12:35:18 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: hch@infradead.org, Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, davem@davemloft.net
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable (updated)
Message-ID: <20060825070518.GA10977@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060822052448.GA26279@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822052448.GA26279@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 10:54:48AM +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> In an effort to make kprobe modules more portable, here is a patch that:
> 
> o Introduces the "symbol_name" field to struct kprobe.
>   The symbol->address resolution now happens in the kernel in an
>   architecture agnostic manner. 64-bit powerpc users no longer have
>   to specify the ".symbols"
> o Introduces the "offset" field to struct kprobe to allow a user to
>   specify an offset into a symbol.
> o The legacy mechanism of specifying the kprobe.addr is still supported.
>   However, if both the kprobe.addr and kprobe.symbol_name are specified,
>   probe registration fails with an -EINVAL.
> o The symbol resolution code uses kallsyms_lookup_name(). So
>   CONFIG_KPROBES now depends on CONFIG_KALLSYMS
> o Apparantly kprobe modules were the only legitimate out-of-tree user of
>   the kallsyms_lookup_name() EXPORT. Now that the symbol resolution
>   happens in-kernel, remove the EXPORT as suggested by Christoph Hellwig
> o Modify tcp_probe.c that uses the kprobe interface so as to make it
>   work on multiple platforms (in its earlier form, the code wouldn't
>   work, say, on powerpc)

Andrew,

Anil discovered that this patch has a case where, on powerpc, we potentially
end up dereferencing a NULL pointer. I have fixed that part and updated
the patch.

Please drop kprobes-make-kprobe-modules-more-portable.patch that is in
-mm currently. Please use this patch instead.

Thanks
Ananth
---

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

In an effort to make kprobe modules more portable, here is a patch that:

o Introduces the "symbol_name" field to struct kprobe.
  The symbol->address resolution now happens in the kernel in an
  architecture agnostic manner.
o Introduces the "offset" field to struct kprobe to allow a user to
  specify an offset into a symbol.
o The legacy mechanism of specifying the kprobe.addr is still supported.
  However, if both the kprobe.addr and kprobe.symbol_name are specified,
  probe registration fails with an -EINVAL.
o The symbol resolution code uses kallsyms_lookup_name(). So
  CONFIG_KPROBES now depends on CONFIG_KALLSYMS
o Apparantly kprobe modules were the only legitimate out-of-tree user of
  the kallsyms_lookup_name() EXPORT. Now that the symbol resolution
  happens in-kernel, remove the EXPORT as suggested by Christoph Hellwig
o Modify tcp_probe.c that uses the kprobe interface so as to make it
  work on multiple platforms (in its earlier form, the code wouldn't
  work, say, on powerpc)

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

---
 arch/i386/Kconfig             |    2 +-
 arch/ia64/Kconfig             |    2 +-
 arch/powerpc/Kconfig          |    2 +-
 arch/sparc64/Kconfig          |    2 +-
 arch/x86_64/Kconfig           |    2 +-
 include/asm-powerpc/kprobes.h |   15 +++++++++++++++
 include/linux/kprobes.h       |    6 ++++++
 kernel/kallsyms.c             |    1 -
 kernel/kprobes.c              |   26 ++++++++++++++++++++++++++
 net/ipv4/tcp_probe.c          |    6 ++++--
 10 files changed, 56 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc4/arch/i386/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/Kconfig
+++ linux-2.6.18-rc4/arch/i386/Kconfig
@@ -1129,7 +1129,7 @@ source "arch/i386/oprofile/Kconfig"
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6.18-rc4/arch/ia64/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/ia64/Kconfig
+++ linux-2.6.18-rc4/arch/ia64/Kconfig
@@ -510,7 +510,7 @@ source "arch/ia64/oprofile/Kconfig"
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6.18-rc4/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/powerpc/Kconfig
+++ linux-2.6.18-rc4/arch/powerpc/Kconfig
@@ -1045,7 +1045,7 @@ source "arch/powerpc/oprofile/Kconfig"
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on PPC64 && EXPERIMENTAL && MODULES
+	depends on PPC64 && KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6.18-rc4/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/sparc64/Kconfig
+++ linux-2.6.18-rc4/arch/sparc64/Kconfig
@@ -416,7 +416,7 @@ source "arch/sparc64/oprofile/Kconfig"
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6.18-rc4/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.18-rc4.orig/arch/x86_64/Kconfig
+++ linux-2.6.18-rc4/arch/x86_64/Kconfig
@@ -639,7 +639,7 @@ source "arch/x86_64/oprofile/Kconfig"
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6.18-rc4/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.18-rc4/include/asm-powerpc/kprobes.h
@@ -44,6 +44,21 @@ typedef unsigned int kprobe_opcode_t;
 #define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
 #define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
 
+/*
+ * 64bit powerpc uses function descriptors.
+ * Handle cases where:
+ * 		- User passes a <.symbol>
+ * 		- User passes a <symbol>
+ * 		- User passes a non-existant symbol, kallsyms_lookup_name
+ * 		  returns 0. Don't deref the NULL pointer in that case
+ */
+#define kprobe_lookup_name(name, addr)					\
+{									\
+	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);		\
+	if (!(name[0] == '.') && addr)					\
+		addr = *(kprobe_opcode_t **)addr;			\
+}
+
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
 #define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
Index: linux-2.6.18-rc4/include/linux/kprobes.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/kprobes.h
+++ linux-2.6.18-rc4/include/linux/kprobes.h
@@ -77,6 +77,12 @@ struct kprobe {
 	/* location of the probe point */
 	kprobe_opcode_t *addr;
 
+	/* Allow user to indicate symbol name of the probe point */
+	char *symbol_name;
+
+	/* Offset into the symbol */
+	unsigned int offset;
+
 	/* Called before addr is executed. */
 	kprobe_pre_handler_t pre_handler;
 
Index: linux-2.6.18-rc4/kernel/kallsyms.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/kallsyms.c
+++ linux-2.6.18-rc4/kernel/kallsyms.c
@@ -154,7 +154,6 @@ unsigned long kallsyms_lookup_name(const
 	}
 	return module_kallsyms_lookup_name(name);
 }
-EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
 /*
  * Lookup an address
Index: linux-2.6.18-rc4/kernel/kprobes.c
===================================================================
--- linux-2.6.18-rc4.orig/kernel/kprobes.c
+++ linux-2.6.18-rc4/kernel/kprobes.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
+#include <linux/kallsyms.h>
 #include <asm-generic/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
@@ -45,6 +46,16 @@
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
+
+/*
+ * Some oddball architectures like 64bit powerpc have function descriptors
+ * so this must be overridable.
+ */
+#ifndef kprobe_lookup_name
+#define kprobe_lookup_name(name, addr) \
+	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)))
+#endif
+
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 static atomic_t kprobe_count;
@@ -447,6 +458,21 @@ static int __kprobes __register_kprobe(s
 	struct kprobe *old_p;
 	struct module *probed_mod;
 
+	/*
+	 * If we have a symbol_name argument look it up,
+	 * and add it to the address.  That way the addr
+	 * field can either be global or relative to a symbol.
+	 */
+	if (p->symbol_name) {
+		if (p->addr)
+			return -EINVAL;
+		kprobe_lookup_name(p->symbol_name, p->addr);
+	}
+
+	if (!p->addr)
+		return -EINVAL;
+	p->addr = (kprobe_opcode_t *)(((char *)p->addr)+ p->offset);
+
 	if ((!kernel_text_address((unsigned long) p->addr)) ||
 		in_kprobes_functions((unsigned long) p->addr))
 		return -EINVAL;
Index: linux-2.6.18-rc4/net/ipv4/tcp_probe.c
===================================================================
--- linux-2.6.18-rc4.orig/net/ipv4/tcp_probe.c
+++ linux-2.6.18-rc4/net/ipv4/tcp_probe.c
@@ -99,8 +99,10 @@ static int jtcp_sendmsg(struct kiocb *io
 }
 
 static struct jprobe tcp_send_probe = {
-	.kp = { .addr = (kprobe_opcode_t *) &tcp_sendmsg, },
-	.entry = (kprobe_opcode_t *) &jtcp_sendmsg,
+	.kp = {
+		.symbol_name	= "tcp_sendmsg",
+	},
+	.entry	= JPROBE_ENTRY(jtcp_sendmsg),
 };
 
 
