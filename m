Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWHIQTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWHIQTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHIQTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:19:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751127AbWHIQTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:19:02 -0400
Date: Wed, 9 Aug 2006 17:18:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, David Smith <dsmith@redhat.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060809161854.GA13622@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Smith <dsmith@redhat.com>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org, shemminger@osdl.org
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com> <20060809161039.GA30856@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809161039.GA30856@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:10:39PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 09, 2006 at 11:01:45AM -0500, David Smith wrote:
> > > +	if (p->symbol_name) {
> > > +		if (p->addr)
> > > +			return -EINVAL;
> > > +		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
> > > +	}
> > 
> > What if kprobe_lookup_name() fails
> 
> for that case we need the check in your snipplet below.
> 
> > or if CONFIG_KALLSYMS isn't set?
> 
> I think we should just disallow that case.  having kprobes without kallsyms
> is rather pointless.  I'll send a patch to add the dependency to the Kconfig
> files.

Here's an updated version of that patch that a) adds a KALLYMS dependency
and b) adds a check for p->addr.  Note that this check is outside the
if (p->symbol_name) block so it also returns EINVAL if the user didn't
specifcy either and address or a symbol name.


Index: linux-2.6/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kprobes.h	2006-08-09 13:44:39.000000000 +0200
+++ linux-2.6/include/asm-powerpc/kprobes.h	2006-08-09 13:44:57.000000000 +0200
@@ -44,6 +44,9 @@
 #define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
 #define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)
 
+#define kprobe_lookup_name(name) \
+	(*((kprobe_opcode_t **)kallsyms_lookup_name(name)))
+
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
 
 #define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
Index: linux-2.6/include/linux/kprobes.h
===================================================================
--- linux-2.6.orig/include/linux/kprobes.h	2006-08-09 13:44:39.000000000 +0200
+++ linux-2.6/include/linux/kprobes.h	2006-08-09 13:44:57.000000000 +0200
@@ -77,6 +77,12 @@
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
 
Index: linux-2.6/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/kernel/kprobes.c	2006-08-09 13:44:39.000000000 +0200
+++ linux-2.6/kernel/kprobes.c	2006-08-09 18:12:47.000000000 +0200
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
+#define kprobe_lookup_name(name) \
+	((kprobe_opcode_t *)(kallsyms_lookup_name(name))
+#endif
+
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 static atomic_t kprobe_count;
@@ -447,6 +458,21 @@
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
+		p->addr = kprobe_lookup_name(p->symbol_name);
+	}
+
+	if (!p->addr)
+		return -EINVAL;
+	p->addr += p->offset;
+
 	if ((!kernel_text_address((unsigned long) p->addr)) ||
 		in_kprobes_functions((unsigned long) p->addr))
 		return -EINVAL;
Index: linux-2.6/kernel/kallsyms.c
===================================================================
--- linux-2.6.orig/kernel/kallsyms.c	2006-08-09 13:44:39.000000000 +0200
+++ linux-2.6/kernel/kallsyms.c	2006-08-09 13:44:57.000000000 +0200
@@ -154,7 +154,6 @@
 	}
 	return module_kallsyms_lookup_name(name);
 }
-EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
 /*
  * Lookup an address
Index: linux-2.6/net/ipv4/tcp_probe.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp_probe.c	2006-08-09 13:44:39.000000000 +0200
+++ linux-2.6/net/ipv4/tcp_probe.c	2006-08-09 13:44:57.000000000 +0200
@@ -99,8 +99,10 @@
 }
 
 static struct jprobe tcp_send_probe = {
-	.kp = { .addr = (kprobe_opcode_t *) &tcp_sendmsg, },
-	.entry = (kprobe_opcode_t *) &jtcp_sendmsg,
+	.kp = {
+		.symbol_name	= "tcp_sendmsg",
+	},
+	.entry	= JPROBE_ENTRY(jtcp_sendmsg),
 };
 
 
Index: linux-2.6/arch/i386/Kconfig
===================================================================
--- linux-2.6.orig/arch/i386/Kconfig	2006-08-08 17:13:13.000000000 +0200
+++ linux-2.6/arch/i386/Kconfig	2006-08-09 18:13:59.000000000 +0200
@@ -1129,7 +1129,7 @@
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig	2006-08-08 17:13:13.000000000 +0200
+++ linux-2.6/arch/ia64/Kconfig	2006-08-09 18:14:13.000000000 +0200
@@ -510,7 +510,7 @@
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig	2006-08-08 17:13:13.000000000 +0200
+++ linux-2.6/arch/powerpc/Kconfig	2006-08-09 18:15:00.000000000 +0200
@@ -1045,7 +1045,7 @@
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on PPC64 && EXPERIMENTAL && MODULES
+	depends on PPC64 && KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.orig/arch/sparc64/Kconfig	2006-08-08 17:13:13.000000000 +0200
+++ linux-2.6/arch/sparc64/Kconfig	2006-08-09 18:14:42.000000000 +0200
@@ -416,7 +416,7 @@
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
Index: linux-2.6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86_64/Kconfig	2006-08-08 17:13:13.000000000 +0200
+++ linux-2.6/arch/x86_64/Kconfig	2006-08-09 18:14:27.000000000 +0200
@@ -639,7 +639,7 @@
 
 config KPROBES
 	bool "Kprobes (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && MODULES
+	depends on KALLSYMS && EXPERIMENTAL && MODULES
 	help
 	  Kprobes allows you to trap at almost any kernel address and
 	  execute a callback function.  register_kprobe() establishes
