Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVAJLPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVAJLPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVAJLPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:15:37 -0500
Received: from ozlabs.org ([203.10.76.45]:1176 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262205AbVAJLPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:15:22 -0500
Date: Mon, 10 Jan 2005 22:13:37 +1100
From: Anton Blanchard <anton@samba.org>
To: kaos@ocs.com.au, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: kallsyms gate page patch breaks module lookups
Message-ID: <20050110111337.GM14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Keith,

Your recent patch looks to break module kallsyms lookups. On ppc64
current -bk shows this in an oops:

Oops: Exception in kernel mode, sig: 5 [#1]
...
NIP [d000000000036028] __bss_stop+0xfffffffff84f368/0x340
LR [d000000000036024] __bss_stop+0xfffffffff84f364/0x340
Call Trace:
[c00000000231fd10] [d000000000036024] __bss_stop+0xfffffffff84f364/0x340 (unreliable)
[c00000000231fd90] [c000000000078750] .sys_init_module+0x2fc/0x4d8
[c00000000231fe30] [c00000000000d500] syscall_exit+0x0/0x18

Backing out the patch below, things work as expected:

Oops: Exception in kernel mode, sig: 5 [#1]
...
NIP [d000000000036028] .myinit+0x28/0x44 [mod]
LR [d000000000036024] .myinit+0x24/0x44 [mod]
Call Trace:
[c000000002313d10] [d000000000036024] .myinit+0x24/0x44 [mod] (unreliable)
[c000000002313d90] [c000000000078750] .sys_init_module+0x2fc/0x4d8
[c000000002313e30] [c00000000000d500] syscall_exit+0x0/0x18

It looks like if CONFIG_KALLSYMS_ALL is set then we never look up module
addresses.

Anton

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/28 22:16:26+01:00 kaos@ocs.com.au 
#   kallsyms: gate page is part of the kernel, honour CONFIG_KALLSYMS_ALL
#   
#   * Treat the gate page as part of the kernel, to improve kernel backtraces.
#   
#   * Honour CONFIG_KALLSYMS_ALL, all symbols are valid, not just text.
#   
#   Signed-off-by: Keith Owens <kaos@ocs.com.au>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# kernel/kallsyms.c
#   2004/11/28 04:42:24+01:00 kaos@ocs.com.au +11 -4
#   kallsyms: gate page is part of the kernel, honour CONFIG_KALLSYMS_ALL
# 
diff -Nru a/kernel/kallsyms.c b/kernel/kallsyms.c
--- a/kernel/kallsyms.c	2005-01-10 22:01:10 +11:00
+++ b/kernel/kallsyms.c	2005-01-10 22:01:10 +11:00
@@ -18,6 +18,13 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/mm.h>
+
+#ifdef CONFIG_KALLSYMS_ALL
+#define all_var 1
+#else
+#define all_var 0
+#endif
 
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[] __attribute__((weak));
@@ -30,7 +37,7 @@
 extern unsigned long kallsyms_markers[] __attribute__((weak));
 
 /* Defined by the linker script. */
-extern char _stext[], _etext[], _sinittext[], _einittext[];
+extern char _stext[], _etext[], _sinittext[], _einittext[], _end[];
 
 static inline int is_kernel_inittext(unsigned long addr)
 {
@@ -44,7 +51,7 @@
 {
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext)
 		return 1;
-	return 0;
+	return in_gate_area_no_task(addr);
 }
 
 /* expand a compressed symbol data into the resulting uncompressed string,
@@ -147,7 +154,7 @@
 	namebuf[KSYM_NAME_LEN] = 0;
 	namebuf[0] = 0;
 
-	if (is_kernel_text(addr) || is_kernel_inittext(addr)) {
+	if (all_var || is_kernel_text(addr) || is_kernel_inittext(addr)) {
 		unsigned long symbol_end=0;
 
 		/* do a binary search on the sorted kallsyms_addresses array */
@@ -181,7 +188,7 @@
 			if (is_kernel_inittext(addr))
 				symbol_end = (unsigned long)_einittext;
 			else
-				symbol_end = (unsigned long)_etext;
+				symbol_end = all_var ? (unsigned long)_end : (unsigned long)_etext;
 		}
 
 		*symbolsize = symbol_end - kallsyms_addresses[low];
