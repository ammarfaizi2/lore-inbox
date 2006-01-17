Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWAQG1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWAQG1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWAQG1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:27:22 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:49373 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751201AbWAQG1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:27:21 -0500
Date: Tue, 17 Jan 2006 01:23:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.15-current] i386: multi-column stack backtraces
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Akinobu Mita <mita@miraclelinux.com>
Message-ID: <200601170126_MC3-1-B602-EFCB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print stack backtraces in multiple columns, saving screen space.
Number of columns is configurable and defaults to one so 
behavior is backwards-compatible.

Also removes the brackets around addresses when printing more
that one entry per line so they print as:
    <address>
instead of:
    [<address>]
This helps multiple entries fit better on one line.

Original idea by Dave Jones, taken from x86_64.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/Kconfig.debug  |    9 +++++++++
 arch/i386/kernel/traps.c |   32 +++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 5 deletions(-)

--- 2.6.15a.orig/arch/i386/kernel/traps.c
+++ 2.6.15a/arch/i386/kernel/traps.c
@@ -112,12 +112,30 @@ static inline int valid_stack_ptr(struct
 		p < (void *)tinfo + THREAD_SIZE - 3;
 }
 
-static inline void print_addr_and_symbol(unsigned long addr, char *log_lvl)
+/*
+ * Print CONFIG_STACK_BACKTRACE_COLS address/symbol entries per line.
+ */
+static inline int print_addr_and_symbol(unsigned long addr, char *log_lvl,
+					int printed)
 {
-	printk(log_lvl);
+	if (!printed)
+		printk(log_lvl);
+
+#if CONFIG_STACK_BACKTRACE_COLS == 1
 	printk(" [<%08lx>] ", addr);
+#else
+	printk(" <%08lx> ", addr);
+#endif
 	print_symbol("%s", addr);
-	printk("\n");
+
+	printed = (printed + 1) % CONFIG_STACK_BACKTRACE_COLS;
+
+	if (printed)
+		printk("  ");
+	else
+		printk("\n");
+
+	return printed;
 }
 
 static inline unsigned long print_context_stack(struct thread_info *tinfo,
@@ -125,20 +143,24 @@ static inline unsigned long print_contex
 				char *log_lvl)
 {
 	unsigned long addr;
+	int printed = 0; /* nr of entries already printed on current line */
 
 #ifdef	CONFIG_FRAME_POINTER
 	while (valid_stack_ptr(tinfo, (void *)ebp)) {
 		addr = *(unsigned long *)(ebp + 4);
-		print_addr_and_symbol(addr, log_lvl);
+		printed = print_addr_and_symbol(addr, log_lvl, printed);
 		ebp = *(unsigned long *)ebp;
 	}
 #else
 	while (valid_stack_ptr(tinfo, stack)) {
 		addr = *stack++;
 		if (__kernel_text_address(addr))
-			print_addr_and_symbol(addr, log_lvl);
+			printed = print_addr_and_symbol(addr, log_lvl, printed);
 	}
 #endif
+	if (printed)
+		printk("\n");
+
 	return ebp;
 }
 
--- 2.6.15a.orig/arch/i386/Kconfig.debug
+++ 2.6.15a/arch/i386/Kconfig.debug
@@ -31,6 +31,15 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config STACK_BACKTRACE_COLS
+	int "Stack backtraces per line" if DEBUG_KERNEL
+	range 1 3
+	default 1
+	help
+	  Selects how many stack backtrace entries per line to display.
+
+	  This can save screen space when displaying traces.
+
 comment "Page alloc debug is incompatible with Software Suspend on i386"
 	depends on DEBUG_KERNEL && SOFTWARE_SUSPEND
 
-- 
Chuck
Currently reading: _Einstein's Bridge_ by John Cramer
