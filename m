Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263557AbUECCjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUECCjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUECCjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:39:51 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:26423 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263557AbUECCjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:39:44 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.6-rc3 Warn when smp_call_function() is called with interrupts disabled
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 May 2004 12:39:39 +1000
Message-ID: <3620.1083551979@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost every architecture has a comment above smp_call_function()

 * You must not call this function with disabled interrupts or from a
 * hardware interrupt handler or from a bottom half handler.

I have not seen any problems with calling smp_call_function() from a
bottom half handler, but calling it with interrupts disabled can
definitely deadlock.  This bug is hard to reproduce and even harder to
debug.

CPU A                               CPU B
Disable interrupts
                                    smp_call_function()
                                    Take call_lock
                                    Send IPIs
                                    Wait for all cpus to acknowledge IPI
                                    CPU A has not responded, spin waiting
                                    for cpu A to respond, holding call_lock
smp_call_function()
Spin waiting for call_lock
Deadlock                            Deadlock

Change all smp_call_function() to WARN_ON(irqs_disabled()).  It should
be BUG_ON() but some buggy code like SCSI sg will break with BUG_ON, so
just warn for now.  Change it to BUG_ON after the buggy code has been
fixed.

Tested on ia64 and i386.  It was even tested on UP, just for akpm ;)

Index: 2.6.6-rc3-warn-smp_call_function/arch/alpha/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/alpha/kernel/smp.c	Mon Apr  5 11:02:50 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/alpha/kernel/smp.c	Mon May  3 11:35:44 2004
@@ -820,6 +820,9 @@
 	unsigned long timeout;
 	int num_cpus_to_call;
 	
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	data.wait = wait;
Index: 2.6.6-rc3-warn-smp_call_function/arch/i386/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/i386/kernel/smp.c	Thu Mar 11 16:13:40 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/i386/kernel/smp.c	Mon May  3 11:36:18 2004
@@ -519,6 +519,9 @@
 	if (!cpus)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/i386/mach-voyager/voyager_smp.c	Wed Apr 28 13:19:20 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/i386/mach-voyager/voyager_smp.c	Mon May  3 11:41:41 2004
@@ -1106,6 +1106,9 @@
 	if (!mask)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	data.started = mask;
Index: 2.6.6-rc3-warn-smp_call_function/arch/ia64/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/ia64/kernel/smp.c	Mon Apr  5 11:02:53 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/ia64/kernel/smp.c	Mon May  3 12:22:03 2004
@@ -308,6 +308,9 @@
 	if (!cpus)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/mips/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/mips/kernel/smp.c	Thu Mar 11 16:13:42 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/mips/kernel/smp.c	Mon May  3 11:37:14 2004
@@ -151,6 +151,9 @@
 	if (!cpus)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/parisc/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/parisc/kernel/smp.c	Mon Apr  5 11:02:55 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/parisc/kernel/smp.c	Mon May  3 11:37:23 2004
@@ -327,6 +327,9 @@
 	struct smp_call_struct data;
 	unsigned long timeout;
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
 	
 	data.func = func;
 	data.info = info;
Index: 2.6.6-rc3-warn-smp_call_function/arch/ppc/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/ppc/kernel/smp.c	Mon Apr  5 11:02:56 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/ppc/kernel/smp.c	Mon May  3 11:37:51 2004
@@ -211,6 +211,8 @@
            bitmask. --RR */
 	if (num_online_cpus() <= 1)
 		return 0;
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
 	return __smp_call_function(func, info, wait, MSG_ALL_BUT_SELF);
 }
 
Index: 2.6.6-rc3-warn-smp_call_function/arch/ppc64/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/ppc64/kernel/smp.c	Wed Apr 28 13:19:38 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/ppc64/kernel/smp.c	Mon May  3 11:37:58 2004
@@ -692,6 +692,9 @@
 	int ret = -1, cpus;
 	unsigned long timeout;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/s390/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/s390/kernel/smp.c	Wed Apr 28 13:19:40 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/s390/kernel/smp.c	Mon May  3 11:38:13 2004
@@ -127,6 +127,9 @@
 	if (cpus <= 0)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/sh/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/sh/kernel/smp.c	Thu Feb  5 10:12:07 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/sh/kernel/smp.c	Mon May  3 11:38:20 2004
@@ -181,6 +181,9 @@
 	if (nr_cpus < 2)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	spin_lock(&smp_fn_call.lock);
 
 	atomic_set(&smp_fn_call.finished, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/sparc64/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/sparc64/kernel/smp.c	Wed Apr 28 13:19:41 2004
+++ 2.6.6-rc3-warn-smp_call_function/arch/sparc64/kernel/smp.c	Mon May  3 11:38:29 2004
@@ -598,6 +598,9 @@
 	if (!cpus)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.finished, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/um/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/um/kernel/smp.c	Thu Dec 18 13:58:28 2003
+++ 2.6.6-rc3-warn-smp_call_function/arch/um/kernel/smp.c	Mon May  3 11:38:41 2004
@@ -266,6 +266,9 @@
 	if (!cpus)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	spin_lock_bh(&call_lock);
 	atomic_set(&scf_started, 0);
 	atomic_set(&scf_finished, 0);
Index: 2.6.6-rc3-warn-smp_call_function/arch/x86_64/kernel/smp.c
===================================================================
--- 2.6.6-rc3-warn-smp_call_function.orig/arch/x86_64/kernel/smp.c	Thu Dec 18 13:58:28 2003
+++ 2.6.6-rc3-warn-smp_call_function/arch/x86_64/kernel/smp.c	Mon May  3 11:38:53 2004
@@ -404,6 +404,9 @@
 	if (!cpus)
 		return 0;
 
+	/* Can deadlock when called with interrupts disabled */
+	WARN_ON(irqs_disabled());
+
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);

