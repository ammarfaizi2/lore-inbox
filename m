Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVGJDlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVGJDlk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 23:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGJDlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 23:41:40 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:39819 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261401AbVGJDlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 23:41:39 -0400
Date: Sat, 9 Jul 2005 23:39:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH 2.6.13-rc2] [RFD] Text section for "slow" code
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200507092341_MC3-1-A40A-8EA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I came up with this patch for moving slow code to its own section, but
some questions arose:

        1.  How to implement for each arch?

        2.  What name to use for the text section?

Patch for X86 and PPC follows, then a test patch for i386 to show it
boots and runs.


Index: 2.6.13-rc2a/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- 2.6.13-rc2a.orig/arch/i386/kernel/vmlinux.lds.S
+++ 2.6.13-rc2a/arch/i386/kernel/vmlinux.lds.S
@@ -23,6 +23,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x9090
 
Index: 2.6.13-rc2a/arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- 2.6.13-rc2a.orig/arch/ppc/kernel/vmlinux.lds.S
+++ 2.6.13-rc2a/arch/ppc/kernel/vmlinux.lds.S
@@ -34,6 +34,7 @@
     SCHED_TEXT
     LOCK_TEXT
     *(.fixup)
+    *(.slow.text)
     *(.got1)
     __got2_start = .;
     *(.got2)
Index: 2.6.13-rc2a/arch/ppc64/kernel/vmlinux.lds.S
===================================================================
--- 2.6.13-rc2a.orig/arch/ppc64/kernel/vmlinux.lds.S
+++ 2.6.13-rc2a/arch/ppc64/kernel/vmlinux.lds.S
@@ -16,6 +16,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	. = ALIGN(4096);
 	_etext = .;
 	}
Index: 2.6.13-rc2a/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- 2.6.13-rc2a.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ 2.6.13-rc2a/arch/x86_64/kernel/vmlinux.lds.S
@@ -22,6 +22,7 @@
 	SCHED_TEXT
 	LOCK_TEXT
 	*(.fixup)
+	*(.slow.text)
 	*(.gnu.warning)
 	} = 0x9090
   				/* out-of-line lock text */
Index: 2.6.13-rc2a/include/linux/compiler.h
===================================================================
--- 2.6.13-rc2a.orig/include/linux/compiler.h
+++ 2.6.13-rc2a/include/linux/compiler.h
@@ -48,6 +48,17 @@
 # error Sorry, your compiler is too old/not recognized.
 #endif
 
+/* Text section for code that is not speed-critical.
+ * Temporary hack includes arch-specific test in generic header.
+ */
+#if defined(CONFIG_X86) || defined(CONFIG_PPC)
+# define __slow		noinline __attribute__((__section__(".slow.text")))
+#endif
+
+#if !defined(__slow)
+# define __slow		noinline
+#endif
+
 /* Intel compiler defines __GNUC__. So we will overwrite implementations
  * coming from above header files here
  */

=======================================================================================

Test patch:

Index: 2.6.13-rc2a/arch/i386/kernel/irq.c
===================================================================
--- 2.6.13-rc2a.orig/arch/i386/kernel/irq.c
+++ 2.6.13-rc2a/arch/i386/kernel/irq.c
@@ -210,7 +210,7 @@
  * /proc/interrupts printing:
  */
 
-int show_interrupts(struct seq_file *p, void *v)
+int __slow show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
 	struct irqaction * action;


--
Chuck
