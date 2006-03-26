Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWCZBmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWCZBmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 20:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWCZBmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 20:42:37 -0500
Received: from ozlabs.org ([203.10.76.45]:19884 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751225AbWCZBmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 20:42:36 -0500
Date: Sun, 26 Mar 2006 12:37:38 +1100
From: Anton Blanchard <anton@samba.org>
To: levon@movementarian.org, akpm@osdl.org, bcr6@cornell.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add oprofile_add_ext_sample
Message-ID: <20060326013738.GC29975@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Brian Rogan <bcr6@cornell.edu>

On ppc64 we look at a profiling register to work out the sample address
and if it was in userspace or kernel.

The backtrace interface oprofile_add_sample does not allow this. Create
oprofile_add_ext_sample and make oprofile_add_sample use it too.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/drivers/oprofile/cpu_buffer.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/cpu_buffer.c	2006-01-19 12:30:04.000000000 +1100
+++ linux-2.6/drivers/oprofile/cpu_buffer.c	2006-03-26 12:13:07.000000000 +1100
@@ -218,11 +218,10 @@ static void oprofile_end_trace(struct op
 	cpu_buf->tracing = 0;
 }
 
-void oprofile_add_sample(struct pt_regs * const regs, unsigned long event)
+void oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs, 
+				unsigned long event, int is_kernel)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
-	unsigned long pc = profile_pc(regs);
-	int is_kernel = !user_mode(regs);
 
 	if (!backtrace_depth) {
 		log_sample(cpu_buf, pc, is_kernel, event);
@@ -239,6 +238,14 @@ void oprofile_add_sample(struct pt_regs 
 	oprofile_end_trace(cpu_buf);
 }
 
+void oprofile_add_sample(struct pt_regs * const regs, unsigned long event) 
+{
+	int is_kernel = !user_mode(regs);
+	unsigned long pc = profile_pc(regs);
+
+	oprofile_add_ext_sample(pc, regs, event, is_kernel);
+}
+
 void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
Index: linux-2.6/include/linux/oprofile.h
===================================================================
--- linux-2.6.orig/include/linux/oprofile.h	2005-09-10 08:24:35.000000000 +1000
+++ linux-2.6/include/linux/oprofile.h	2006-03-26 12:13:07.000000000 +1100
@@ -61,6 +61,16 @@ void oprofile_arch_exit(void);
  */
 void oprofile_add_sample(struct pt_regs * const regs, unsigned long event);
 
+/**
+ * Add an extended sample.  Use this when the PC is not from the regs, and 
+ * we cannot determine if we're in kernel mode from the regs.
+ *
+ * This function does perform a backtrace.
+ *
+ */
+void oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs, 
+				unsigned long event, int is_kernel);
+
 /* Use this instead when the PC value is not from the regs. Doesn't
  * backtrace. */
 void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event);
