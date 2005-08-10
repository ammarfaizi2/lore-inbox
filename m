Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVHJEwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVHJEwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 00:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVHJEwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 00:52:51 -0400
Received: from ozlabs.org ([203.10.76.45]:27792 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964962AbVHJEwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 00:52:50 -0400
To: Andrew Morton <akpm@osdl.org>
CC: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] Fix function/macro name collision on i386 oprofile
Message-Id: <20050810045249.610AC67FDA@ozlabs.org>
Date: Wed, 10 Aug 2005 14:52:49 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

The i386 OProfile code has a function named nmi_exit(), which collides
with the nmi_exit() macro in linux/hardirq.h.  At the moment, we get
away with it, because hardirq.h isn't included in the oprofile code.
I hit this as a bug when working with a patch which (indirectly) adds
a #include of hardirq.h to oprofile.

Regardless, the name collision is probably not a good idea, so this
patch fixes it, renaming the oprofile function to op_nmi_exit().  It
also renames the nmi_init() and nmi_timer_init() functions similarly,
for consistency.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/i386/oprofile/init.c          |   12 ++++++------
 arch/i386/oprofile/nmi_int.c       |    4 ++--
 arch/i386/oprofile/nmi_timer_int.c |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

Index: working-2.6/arch/i386/oprofile/nmi_int.c
===================================================================
--- working-2.6.orig/arch/i386/oprofile/nmi_int.c	2005-07-15 15:27:53.000000000 +1000
+++ working-2.6/arch/i386/oprofile/nmi_int.c	2005-08-10 14:28:28.000000000 +1000
@@ -355,7 +355,7 @@
 /* in order to get driverfs right */
 static int using_nmi;
 
-int __init nmi_init(struct oprofile_operations *ops)
+int __init op_nmi_init(struct oprofile_operations *ops)
 {
 	__u8 vendor = boot_cpu_data.x86_vendor;
 	__u8 family = boot_cpu_data.x86;
@@ -420,7 +420,7 @@
 }
 
 
-void nmi_exit(void)
+void op_nmi_exit(void)
 {
 	if (using_nmi)
 		exit_driverfs();
Index: working-2.6/arch/i386/oprofile/nmi_timer_int.c
===================================================================
--- working-2.6.orig/arch/i386/oprofile/nmi_timer_int.c	2005-07-15 15:27:53.000000000 +1000
+++ working-2.6/arch/i386/oprofile/nmi_timer_int.c	2005-08-10 14:28:42.000000000 +1000
@@ -40,7 +40,7 @@
 }
 
 
-int __init nmi_timer_init(struct oprofile_operations * ops)
+int __init op_nmi_timer_init(struct oprofile_operations * ops)
 {
 	extern int nmi_active;
 
Index: working-2.6/arch/i386/oprofile/init.c
===================================================================
--- working-2.6.orig/arch/i386/oprofile/init.c	2005-07-15 15:27:53.000000000 +1000
+++ working-2.6/arch/i386/oprofile/init.c	2005-08-10 14:28:09.000000000 +1000
@@ -15,9 +15,9 @@
  * with the NMI mode driver.
  */
  
-extern int nmi_init(struct oprofile_operations * ops);
-extern int nmi_timer_init(struct oprofile_operations * ops);
-extern void nmi_exit(void);
+extern int op_nmi_init(struct oprofile_operations * ops);
+extern int op_nmi_timer_init(struct oprofile_operations * ops);
+extern void op_nmi_exit(void);
 extern void x86_backtrace(struct pt_regs * const regs, unsigned int depth);
 
 
@@ -28,11 +28,11 @@
 	ret = -ENODEV;
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	ret = nmi_init(ops);
+	ret = op_nmi_init(ops);
 #endif
 #ifdef CONFIG_X86_IO_APIC
 	if (ret < 0)
-		ret = nmi_timer_init(ops);
+		ret = op_nmi_timer_init(ops);
 #endif
 	ops->backtrace = x86_backtrace;
 
@@ -43,6 +43,6 @@
 void oprofile_arch_exit(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
-	nmi_exit();
+	op_nmi_exit();
 #endif
 }
