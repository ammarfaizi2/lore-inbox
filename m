Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUBYVuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUBYVsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:48:54 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:11931 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S261616AbUBYVno
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:43:44 -0500
Date: Wed, 25 Feb 2004 14:43:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
Message-ID: <20040225214343.GG1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225213626.GF1052@smtp.west.cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following adds, and then makes use of kgdb_process_breakpoint /
kgdb_schedule_breakpoint.  Using it i kgdb_8250.c isn't strictly needed,
but it isn't wrong either.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1663  -> 1.1664 
#	arch/i386/kernel/irq.c	1.48    -> 1.49   
#	drivers/net/kgdb_eth.c	1.2     -> 1.3    
#	arch/x86_64/kernel/irq.c	1.21    -> 1.22   
#	drivers/serial/kgdb_8250.c	1.3     -> 1.4    
#	       kernel/kgdb.c	1.3     -> 1.4    
#	arch/ppc/kernel/irq.c	1.36    -> 1.37   
#	include/linux/kgdb.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/25	trini@kernel.crashing.org	1.1664
# process_breakpoint/schedule_breakpoint.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Wed Feb 25 14:21:32 2004
+++ b/arch/i386/kernel/irq.c	Wed Feb 25 14:21:32 2004
@@ -34,6 +34,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/kgdb.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -507,6 +508,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	kgdb_process_breakpoint();
 
 	return 1;
 }
diff -Nru a/arch/ppc/kernel/irq.c b/arch/ppc/kernel/irq.c
--- a/arch/ppc/kernel/irq.c	Wed Feb 25 14:21:32 2004
+++ b/arch/ppc/kernel/irq.c	Wed Feb 25 14:21:32 2004
@@ -46,6 +46,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
+#include <linux/kgdb.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -536,7 +537,9 @@
 	if (irq != -2 && first)
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
-        irq_exit();
+	irq_exit();
+
+	kgdb_process_breakpoint();
 }
 
 unsigned long probe_irq_on (void)
diff -Nru a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	Wed Feb 25 14:21:32 2004
+++ b/arch/x86_64/kernel/irq.c	Wed Feb 25 14:21:32 2004
@@ -405,6 +405,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	kgdb_process_breakpoint();
 	return 1;
 }
 
diff -Nru a/drivers/net/kgdb_eth.c b/drivers/net/kgdb_eth.c
--- a/drivers/net/kgdb_eth.c	Wed Feb 25 14:21:32 2004
+++ b/drivers/net/kgdb_eth.c	Wed Feb 25 14:21:32 2004
@@ -60,7 +60,6 @@
 static atomic_t in_count;
 int kgdboe = 0;			/* Default to tty mode */
 
-extern void breakpoint(void);
 static void rx_hook(struct netpoll *np, int port, char *msg, int len);
 
 static struct netpoll np = {
@@ -106,14 +105,12 @@
 
 	np->remote_port = port;
 
-	/* Is this gdb trying to attach? */
-	if (!netpoll_trap() && len == 8 && !strncmp(msg, "$Hc-1#09", 8))
-		breakpoint();
+	/* Is this gdb trying to attach (!kgdb_connected) or break in
+	 * (msg[0] == 3) ? */
+	if (!netpoll_trap() && (!kgdb_connected || msg[0] == 3))
+		 kgdb_schedule_breakpoint();
 
 	for (i = 0; i < len; i++) {
-		if (msg[i] == 3)
-			breakpoint();
-
 		if (atomic_read(&in_count) >= IN_BUF_SIZE) {
 			/* buffer overflow, clear it */
 			in_head = in_tail = 0;
diff -Nru a/drivers/serial/kgdb_8250.c b/drivers/serial/kgdb_8250.c
--- a/drivers/serial/kgdb_8250.c	Wed Feb 25 14:21:32 2004
+++ b/drivers/serial/kgdb_8250.c	Wed Feb 25 14:21:32 2004
@@ -248,7 +248,7 @@
 
 	/* If we get an interrupt, then KGDB is trying to connect. */
 	if (!kgdb_connected) {
-		breakpoint();
+		kgdb_schedule_breakpoint();
 		return IRQ_HANDLED;
 	}
 
diff -Nru a/include/linux/kgdb.h b/include/linux/kgdb.h
--- a/include/linux/kgdb.h	Wed Feb 25 14:21:32 2004
+++ b/include/linux/kgdb.h	Wed Feb 25 14:21:32 2004
@@ -11,8 +11,22 @@
 #include <asm/atomic.h>
 #include <linux/debugger.h>
 
+/*
+ * This file should not include ANY others.  This makes it usable
+ * most anywhere without the fear of include order or inclusion.
+ * TODO: Make it so!
+ *
+ * This file may be included all the time.  It is only active if
+ * CONFIG_KGDB is defined, otherwise it stubs out all the macros
+ * and entry points.
+ */
+
+#if defined(CONFIG_KGDB) && !defined(__ASSEMBLY__)
 /* To enter the debugger explicitly. */
-void breakpoint(void);
+extern void breakpoint(void);
+extern void kgdb_schedule_breakpoint(void);
+extern void kgdb_process_breakpoint(void);
+extern volatile int kgdb_connected;
 
 #ifndef KGDB_MAX_NO_CPUS
 #if CONFIG_NR_CPUS > 8
@@ -112,4 +126,7 @@
 char *kgdb_hex2mem(char *buf, char *mem, int count);
 int kgdb_get_mem(char *addr, unsigned char *buf, int count);
 
+#else
+#define kgdb_process_breakpoint()      do {} while(0)
+#endif /* KGDB && !__ASSEMBLY__ */
 #endif				/* _KGDB_H_ */
diff -Nru a/kernel/kgdb.c b/kernel/kgdb.c
--- a/kernel/kgdb.c	Wed Feb 25 14:21:32 2004
+++ b/kernel/kgdb.c	Wed Feb 25 14:21:32 2004
@@ -1169,6 +1169,29 @@
 	printk("Connected.\n");
 }
 
+/*
+ * Sometimes we need to schedule a breakpoint because we can't break
+ * right where we are.
+ */
+static int kgdb_need_breakpoint[NR_CPUS];
+
+void kgdb_schedule_breakpoint(void)
+{
+	kgdb_need_breakpoint[smp_processor_id()] = 1;
+}
+
+void kgdb_process_breakpoint(void)
+{
+	/*
+	 * Handle a breakpoint queued from inside network driver code
+	  * to avoid reentrancy issues
+	 */
+	if (kgdb_need_breakpoint[smp_processor_id()]) {
+		 kgdb_need_breakpoint[smp_processor_id()] = 0;
+		 breakpoint();
+	}
+}
+
 #ifdef CONFIG_KGDB_CONSOLE
 char kgdbconbuf[BUFMAX];
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
