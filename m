Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUB0ENY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 23:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUB0ENY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 23:13:24 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:42373 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261318AbUB0ENU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 23:13:20 -0500
Date: Fri, 27 Feb 2004 13:13:13 +0900
From: Norihiko Mukouyama <norihiko_m@jp.fujitsu.com>
Subject: [RFC] Add notifier_call_chain before sync in panic
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Message-id: <FLEBKJHLJPMMOPBNJGELAEPJCKAA.norihiko_m@jp.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain;	charset="iso-2022-jp"
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I made a patch that add notifier_call_chain() before sys_sync() in  panic().
I also added notifier_call_chain() in die() because of being processed
Oops similar to kernel panic.

In recent kernel structure,  clean up routine be hooked to existing 
notifier_call_chain() after sys_sync() in panic().
But, there are some cases that clean up should be called prior to sys_sync() in
my opinion. 

Clean up routine often has to wait for a long time to finish sys_sync().
Furthermore,if file system is broken (sys_sync() seldom ends), clean-up often
fails to be invoked.


My patch enables the invocation of clean up before falling into long wait 
or stalling.
There are also some other merits by my patch. For example, clustering system
can use this hook to tell failure to other machine.

Could you apply attached patch?

Thanks.

Norihiko Nukouyama

diff -uNr linux-2.6.3.org/arch/i386/kernel/traps.c linux-2.6.3/arch/i386/kernel/traps.c
--- linux-2.6.3.org/arch/i386/kernel/traps.c	2004-02-18 12:57:17.000000000 +0900
+++ linux-2.6.3/arch/i386/kernel/traps.c	2004-02-27 08:42:10.000000000 +0900
@@ -54,6 +54,10 @@
 
 #include "mach_traps.h"
 
+#include<linux/notifier.h>
+struct notifier_block *trap_notifier_list;
+EXPORT_SYMBOL(trap_notifier_list);
+
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
@@ -262,6 +266,7 @@
 	handle_BUG(regs);
 	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 	show_registers(regs);
+	notifier_call_chain(&trap_notifier_list , 0 , NULL);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
 	if (in_interrupt())
diff -uNr linux-2.6.3.org/include/linux/kernel.h linux-2.6.3/include/linux/kernel.h
--- linux-2.6.3.org/include/linux/kernel.h	2004-02-18 12:57:11.000000000 +0900
+++ linux-2.6.3/include/linux/kernel.h	2004-02-27 08:44:15.000000000 +0900
@@ -55,6 +55,8 @@
 #endif
 
 extern struct notifier_block *panic_notifier_list;
+extern struct notifier_block *prepanic_notifier_list;
+extern struct notifier_block *trap_notifier_list;
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
 asmlinkage NORET_TYPE void do_exit(long error_code)
diff -uNr linux-2.6.3.org/kernel/panic.c linux-2.6.3/kernel/panic.c
--- linux-2.6.3.org/kernel/panic.c	2004-02-18 12:59:34.000000000 +0900
+++ linux-2.6.3/kernel/panic.c	2004-02-27 08:38:43.000000000 +0900
@@ -28,8 +28,10 @@
 EXPORT_SYMBOL(panic_timeout);
 
 struct notifier_block *panic_notifier_list;
+struct notifier_block *prepanic_notifier_list;
 
 EXPORT_SYMBOL(panic_notifier_list);
+EXPORT_SYMBOL(prepanic_notifier_list);
 
 static int __init panic_setup(char *str)
 {
@@ -61,6 +63,7 @@
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic: %s\n",buf);
+	notifier_call_chain(&prepanic_notifier_list , 0 , NULL);
 	if (in_interrupt())
 		printk(KERN_EMERG "In interrupt handler - not syncing\n");
 	else if (!current->pid)
