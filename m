Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUFSJhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUFSJhP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 05:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbUFSJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 05:37:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:40217 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265314AbUFSJhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 05:37:02 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [patch 2.6.7] bug_smp_call_function
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Jun 2004 19:36:48 +1000
Message-ID: <5328.1087637808@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sg.c has been fixed to no longer call vfree() with interrupts disabled.
Change smp_call_function() from WARN_ON to BUG_ON when interrupts are
disabled.  It was only set to WARN_ON because of sg.c.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: 2.6.7/arch/alpha/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/alpha/kernel/smp.c	2004-06-16 20:53:04.000000000 +1000
+++ 2.6.7/arch/alpha/kernel/smp.c	2004-06-19 19:25:23.000000000 +1000
@@ -821,7 +821,7 @@ smp_call_function_on_cpu (void (*func) (
 	int num_cpus_to_call;
 	
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/i386/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/i386/kernel/smp.c	2004-06-16 20:53:07.000000000 +1000
+++ 2.6.7/arch/i386/kernel/smp.c	2004-06-19 19:25:25.000000000 +1000
@@ -520,7 +520,7 @@ int smp_call_function (void (*func) (voi
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/ia64/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/ia64/kernel/smp.c	2004-06-16 20:53:09.000000000 +1000
+++ 2.6.7/arch/ia64/kernel/smp.c	2004-06-19 19:25:28.000000000 +1000
@@ -332,7 +332,7 @@ smp_call_function (void (*func) (void *i
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/mips/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/mips/kernel/smp.c	2004-06-16 20:53:13.000000000 +1000
+++ 2.6.7/arch/mips/kernel/smp.c	2004-06-19 19:25:30.000000000 +1000
@@ -152,7 +152,7 @@ int smp_call_function (void (*func) (voi
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/parisc/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/parisc/kernel/smp.c	2004-06-16 20:53:13.000000000 +1000
+++ 2.6.7/arch/parisc/kernel/smp.c	2004-06-19 19:25:32.000000000 +1000
@@ -326,7 +326,7 @@ smp_call_function (void (*func) (void *i
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 	
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/ppc/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/ppc/kernel/smp.c	2004-06-16 20:53:15.000000000 +1000
+++ 2.6.7/arch/ppc/kernel/smp.c	2004-06-19 19:25:42.000000000 +1000
@@ -212,7 +212,7 @@ int smp_call_function(void (*func) (void
 	if (num_online_cpus() <= 1)
 		return 0;
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 	return __smp_call_function(func, info, wait, MSG_ALL_BUT_SELF);
 }
 
Index: 2.6.7/arch/ppc64/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/ppc64/kernel/smp.c	2004-06-16 20:53:16.000000000 +1000
+++ 2.6.7/arch/ppc64/kernel/smp.c	2004-06-19 19:25:35.000000000 +1000
@@ -692,7 +692,7 @@ int smp_call_function (void (*func) (voi
 	unsigned long timeout;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/s390/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/s390/kernel/smp.c	2004-06-16 20:53:17.000000000 +1000
+++ 2.6.7/arch/s390/kernel/smp.c	2004-06-19 19:25:47.000000000 +1000
@@ -129,7 +129,7 @@ int smp_call_function (void (*func) (voi
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/sh/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/sh/kernel/smp.c	2004-06-16 20:53:17.000000000 +1000
+++ 2.6.7/arch/sh/kernel/smp.c	2004-06-19 19:25:50.000000000 +1000
@@ -182,7 +182,7 @@ int smp_call_function(void (*func)(void 
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	spin_lock(&smp_fn_call.lock);
 
Index: 2.6.7/arch/sparc64/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/sparc64/kernel/smp.c	2004-06-16 20:53:18.000000000 +1000
+++ 2.6.7/arch/sparc64/kernel/smp.c	2004-06-19 19:25:53.000000000 +1000
@@ -602,7 +602,7 @@ int smp_call_function(void (*func)(void 
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;
Index: 2.6.7/arch/um/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/um/kernel/smp.c	2004-06-16 20:53:19.000000000 +1000
+++ 2.6.7/arch/um/kernel/smp.c	2004-06-19 19:26:31.000000000 +1000
@@ -267,7 +267,7 @@ int smp_call_function(void (*_func)(void
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	spin_lock_bh(&call_lock);
 	atomic_set(&scf_started, 0);
Index: 2.6.7/arch/x86_64/kernel/smp.c
===================================================================
--- 2.6.7.orig/arch/x86_64/kernel/smp.c	2004-06-16 20:53:19.000000000 +1000
+++ 2.6.7/arch/x86_64/kernel/smp.c	2004-06-19 19:26:35.000000000 +1000
@@ -405,7 +405,7 @@ int smp_call_function (void (*func) (voi
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	BUG_ON(irqs_disabled());
 
 	data.func = func;
 	data.info = info;

