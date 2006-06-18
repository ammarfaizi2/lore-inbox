Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWFRISU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWFRISU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 04:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWFRISU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 04:18:20 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:7136 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932155AbWFRIST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 04:18:19 -0400
Date: Sun, 18 Jun 2006 04:13:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.16-rc6-mm2] x86: add NUMA to oops messages
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <200606180415_MC3-1-C2C5-AF7A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add "NUMA" to x86 oops printouts to help with debugging.  Use vermagic.h
defines to clean up the code, suggested by Arjan van de Ven.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/traps.c   |   15 ++++-----------
 arch/x86_64/kernel/traps.c |   13 +++----------
 include/linux/vermagic.h   |   15 ++++++++++++++-
 3 files changed, 21 insertions(+), 22 deletions(-)

--- 2.6.17-rc6-mm2-32.orig/arch/i386/kernel/traps.c
+++ 2.6.17-rc6-mm2-32/arch/i386/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/kprobes.h>
 #include <linux/kexec.h>
 #include <linux/unwind.h>
+#include <linux/vermagic.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -391,17 +392,9 @@ void die(const char * str, struct pt_reg
 		handle_BUG(regs);
 		printk(KERN_EMERG "%s: %04lx [#%d]\n", str, err & 0xffff,
 				++die_counter);
-		printk(KERN_EMERG "%dK_STACKS ", THREAD_SIZE / 1024);
-#ifdef CONFIG_PREEMPT
-		printk("PREEMPT ");
-#endif
-#ifdef CONFIG_SMP
-		printk("SMP ");
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-		printk("DEBUG_PAGEALLOC");
-#endif
-		printk("\n");
+		printk(KERN_EMERG MODULE_VERMAGIC_PREEMPT MODULE_VERMAGIC_SMP
+		       VERMAGIC_NUMA VERMAGIC_DEBUG_PAGEALLOC);
+		printk("%dK_STACKS\n", THREAD_SIZE / 1024);
 		sysfs_printk_last_file();
 		if (notify_die(DIE_OOPS, str, regs, err,
 			    current->thread.trap_no, SIGSEGV) != NOTIFY_STOP) {
--- 2.6.17-rc6-mm2-32.orig/arch/x86_64/kernel/traps.c
+++ 2.6.17-rc6-mm2-32/arch/x86_64/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <linux/kprobes.h>
 #include <linux/kexec.h>
 #include <linux/unwind.h>
+#include <linux/vermagic.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -528,16 +529,8 @@ void __kprobes __die(const char * str, s
 {
 	static int die_counter;
 	printk(KERN_EMERG "%s: %04lx [%u] ", str, err & 0xffff,++die_counter);
-#ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
-#endif
-#ifdef CONFIG_SMP
-	printk("SMP ");
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC");
-#endif
-	printk("\n");
+	printk(MODULE_VERMAGIC_PREEMPT MODULE_VERMAGIC_SMP
+	       VERMAGIC_NUMA VERMAGIC_DEBUG_PAGEALLOC "\n");
 	sysfs_printk_last_file();
 	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);
 	show_registers(regs);
--- 2.6.17-rc6-mm2-32.orig/include/linux/vermagic.h
+++ 2.6.17-rc6-mm2-32/include/linux/vermagic.h
@@ -8,7 +8,7 @@
 #define MODULE_VERMAGIC_SMP ""
 #endif
 #ifdef CONFIG_PREEMPT
-#define MODULE_VERMAGIC_PREEMPT "preempt "
+#define MODULE_VERMAGIC_PREEMPT "PREEMPT "
 #else
 #define MODULE_VERMAGIC_PREEMPT ""
 #endif
@@ -26,3 +26,16 @@
 	MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT 			\
 	MODULE_VERMAGIC_MODULE_UNLOAD MODULE_ARCH_VERMAGIC 		\
 	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)
+
+/* for printing in debug routines */
+#ifdef CONFIG_DEBUG_PAGEALLOC
+#define VERMAGIC_DEBUG_PAGEALLOC "DEBUG_PAGEALLOC "
+#else
+#define VERMAGIC_DEBUG_PAGEALLOC ""
+#endif
+
+#ifdef CONFIG_NUMA
+#define VERMAGIC_NUMA "NUMA "
+#else
+#define VERMAGIC_NUMA ""
+#endif
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
