Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVAJLpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVAJLpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVAJLps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:45:48 -0500
Received: from ozlabs.org ([203.10.76.45]:42904 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262214AbVAJLpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:45:38 -0500
Date: Mon, 10 Jan 2005 22:44:54 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: make xmon print BUG() warnings
Message-ID: <20050110114454.GR14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ive had to explain to a number of people that a 0x700 exception is often
a BUG(). Make this crystal clear by printing the BUG information in the
xmon exception printout.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/traps.c~xmon_catch_bug arch/ppc64/kernel/traps.c
--- foobar2/arch/ppc64/kernel/traps.c~xmon_catch_bug	2005-01-10 20:49:11.211206318 +1100
+++ foobar2-anton/arch/ppc64/kernel/traps.c	2005-01-10 20:49:11.246203663 +1100
@@ -344,7 +344,7 @@ extern struct bug_entry __start___bug_ta
 #define module_find_bug(x)	NULL
 #endif
 
-static struct bug_entry *find_bug(unsigned long bugaddr)
+struct bug_entry *find_bug(unsigned long bugaddr)
 {
 	struct bug_entry *bug;
 
@@ -354,7 +354,7 @@ static struct bug_entry *find_bug(unsign
 	return module_find_bug(bugaddr);
 }
 
-int
+static int
 check_bug_trap(struct pt_regs *regs)
 {
 	struct bug_entry *bug;
diff -puN arch/ppc64/xmon/xmon.c~xmon_catch_bug arch/ppc64/xmon/xmon.c
--- foobar2/arch/ppc64/xmon/xmon.c~xmon_catch_bug	2005-01-10 20:49:11.215206014 +1100
+++ foobar2-anton/arch/ppc64/xmon/xmon.c	2005-01-10 20:49:11.244203814 +1100
@@ -31,6 +31,7 @@
 #include <asm/cputable.h>
 #include <asm/rtas.h>
 #include <asm/sstep.h>
+#include <asm/bug.h>
 
 #include "nonstdio.h"
 #include "privinst.h"
@@ -1319,6 +1320,26 @@ static void backtrace(struct pt_regs *ex
 	scannl();
 }
 
+static void print_bug_trap(struct pt_regs *regs)
+{
+	struct bug_entry *bug;
+	unsigned long addr;
+
+	if (regs->msr & MSR_PR)
+		return;		/* not in kernel */
+	addr = regs->nip;	/* address of trap instruction */
+	if (addr < PAGE_OFFSET)
+		return;
+	bug = find_bug(regs->nip);
+	if (bug == NULL)
+		return;
+	if (bug->line & BUG_WARNING_TRAP)
+		return;
+
+	printf("kernel BUG in %s at %s:%d!\n",
+	       bug->function, bug->file, (unsigned int)bug->line);
+}
+
 void excprint(struct pt_regs *fp)
 {
 	unsigned long trap;
@@ -1350,6 +1371,9 @@ void excprint(struct pt_regs *fp)
 		printf("    pid   = %ld, comm = %s\n",
 		       current->pid, current->comm);
 	}
+
+	if (trap == 0x700)
+		print_bug_trap(fp);
 }
 
 void prregs(struct pt_regs *fp)
diff -puN include/asm-ppc64/bug.h~xmon_catch_bug include/asm-ppc64/bug.h
--- foobar2/include/asm-ppc64/bug.h~xmon_catch_bug	2005-01-10 20:49:11.221205559 +1100
+++ foobar2-anton/include/asm-ppc64/bug.h	2005-01-10 20:49:11.247203587 +1100
@@ -18,6 +18,8 @@ struct bug_entry {
 	const char	*function;
 };
 
+struct bug_entry *find_bug(unsigned long bugaddr);
+
 /*
  * If this bit is set in the line number it means that the trap
  * is for WARN_ON rather than BUG or BUG_ON.
_
