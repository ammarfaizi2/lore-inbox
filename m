Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWHHQYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWHHQYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWHHQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:24:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10957 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964913AbWHHQYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:24:25 -0400
Date: Tue, 8 Aug 2006 17:24:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060808162421.GA28647@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org, shemminger@osdl.org
References: <20060807115537.GA15253@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807115537.GA15253@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 05:25:37PM +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> This patch introduces KPROBE_ADDR, a macro that abstracts out the
> architecture-specific artefacts of getting the correct text address
> given a symbol. While we are at it, also introduce the symbol_name field
> in struct kprobe to allow for users to just specify the address to be
> probed in terms of the kernel symbol. In-kernel kprobes infrastructure
> decodes the actual text address to probe. The symbol resolution happens
> only if the kprobe.addr isn't explicitly specified.

This looks good.  A few issues are left:

 - the KPROBE_ADDR macro is all uppercase and not exactly very descriptive.
 - the symbol name variant should be the default, and no one outside
   kprobes.c should know about the KPROBE_ADDR macro
 - we should return EINVAL instead of silently discarding things if people
   specify a symbol and an address.
 - we should have and offset into the symbol specified

The updated patch below does that, aswell as updating the only inkernel
kprobes user (tcp_probe.c) to the new interface (*) and removing the now
obsolete kallsysms_lookup_name export.

(*) tcp_probe.c shows very well how horrible the old interface was, as it's
    not portable to ppc64 as-is

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/kprobes.h	2006-08-08 17:47:22.000000000 +0200
+++ linux-2.6/include/asm-powerpc/kprobes.h	2006-08-08 18:13:57.000000000 +0200
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
--- linux-2.6.orig/include/linux/kprobes.h	2006-08-08 17:47:22.000000000 +0200
+++ linux-2.6/include/linux/kprobes.h	2006-08-08 17:47:31.000000000 +0200
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
--- linux-2.6.orig/kernel/kprobes.c	2006-08-08 17:47:22.000000000 +0200
+++ linux-2.6/kernel/kprobes.c	2006-08-08 17:47:31.000000000 +0200
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
@@ -447,6 +458,17 @@
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
+		p->addr = kprobe_lookup_name(p->symbol_name) + p->offset;
+	}
+
 	if ((!kernel_text_address((unsigned long) p->addr)) ||
 		in_kprobes_functions((unsigned long) p->addr))
 		return -EINVAL;
Index: linux-2.6/kernel/kallsyms.c
===================================================================
--- linux-2.6.orig/kernel/kallsyms.c	2006-08-08 17:13:14.000000000 +0200
+++ linux-2.6/kernel/kallsyms.c	2006-08-08 17:47:39.000000000 +0200
@@ -154,7 +154,6 @@
 	}
 	return module_kallsyms_lookup_name(name);
 }
-EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
 
 /*
  * Lookup an address
Index: linux-2.6/net/ipv4/tcp_probe.c
===================================================================
--- linux-2.6.orig/net/ipv4/tcp_probe.c	2006-08-08 18:13:55.000000000 +0200
+++ linux-2.6/net/ipv4/tcp_probe.c	2006-08-08 18:14:28.000000000 +0200
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
 
 
