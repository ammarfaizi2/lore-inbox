Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUFCGeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUFCGeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUFCGeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:34:15 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:5776 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261210AbUFCGeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:34:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Changing SysRq - show registers handling
Date: Thu, 3 Jun 2004 01:34:01 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030134.04121.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently SysRq "show registers" command dumps registers and the call
trace from keyboard interrupt context when SysRq-P. For that struct pt_regs *
has to be dragged throughout entire input and USB systems. Other than passing
this pointer to SysRq handler these systems has no interest in it, it is
completely foreign piece of data for them and I would like to get rid of it.

I am suggesting slightly changing semantics of SysRq-P handling - instread
of dumping registers and call trace immediately it will simply post a request
for this information to be dumped. When next HW interrupt arrives and is
handled, before running softirqs then current stack trace will be printed.
This approach adds small overhead to the HW interrupt handling routine as the
condition has to be checked with every interrupt but I expect it to be
negligible as it is only check and conditional jump that is almost never
taken. The code should be hot in cache so branch prediction should work just
fine.

The patch below implements proposed changes in SysRq handler and adds
necessary changes to do_IRQ() on i386. If it is agreed upon I will adjust
other arches.

Please let me know what you think.
 
-- 
Dmitry

===== include/linux/sysrq.h 1.6 vs edited =====
--- 1.6/include/linux/sysrq.h	2004-05-15 01:11:58 -05:00
+++ edited/include/linux/sysrq.h	2004-06-01 00:29:09 -05:00
@@ -33,6 +33,17 @@
 void __handle_sysrq(int, struct pt_regs *, struct tty_struct *);
 
 /*
+ * Check whether register dump has been requested and print it
+ */
+extern unsigned int sysrq_register_dump_requested;
+void __sysrq_show_registers(struct pt_regs *);
+static inline void sysrq_show_registers(struct pt_regs *pt_regs)
+{
+	if (unlikely(sysrq_register_dump_requested != 0))
+		__sysrq_show_registers(pt_regs);
+}
+
+/*
  * Sysrq registration manipulation functions
  */
 
@@ -76,6 +87,10 @@
 }
 
 #else
+
+static inline void sysrq_show_registes(struct pt_regs *pt_regs)
+{
+}
 
 static inline int __reterr(void)
 {
===== drivers/char/sysrq.c 1.30 vs edited =====
--- 1.30/drivers/char/sysrq.c	2004-05-15 01:11:58 -05:00
+++ edited/drivers/char/sysrq.c	2004-06-01 00:29:08 -05:00
@@ -135,12 +135,33 @@
 
 
 /* SHOW SYSRQ HANDLERS BLOCK */
+unsigned int sysrq_register_dump_requested;
+static spinlock_t show_registers_lock = SPIN_LOCK_UNLOCKED;
+
+void __sysrq_show_registers(struct pt_regs *pt_regs)
+{
+	unsigned long flags;
+	int doit = 0;
+
+	spin_lock_irqsave(&show_registers_lock, flags);
+	if (sysrq_register_dump_requested) {
+		sysrq_register_dump_requested--;
+		doit = 1;
+	}
+	spin_unlock_irqrestore(&show_registers_lock, flags);
+
+	if (doit)
+		show_regs(pt_regs);
+}
 
 static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 
 {
-	if (pt_regs)
-		show_regs(pt_regs);
+	unsigned long flags;
+
+	spin_lock_irqsave(&show_registers_lock, flags);
+	sysrq_register_dump_requested++;
+	spin_unlock_irqrestore(&show_registers_lock, flags);
 }
 static struct sysrq_key_op sysrq_showregs_op = {
 	.handler	= sysrq_handle_showregs,
===== arch/i386/kernel/irq.c 1.53 vs edited =====
--- 1.53/arch/i386/kernel/irq.c	2004-05-29 02:26:35 -05:00
+++ edited/arch/i386/kernel/irq.c	2004-06-01 00:29:06 -05:00
@@ -34,6 +34,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/sysrq.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -567,6 +568,8 @@
 	 */
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
+
+	sysrq_show_registers(&regs);
 
 	irq_exit();
 
