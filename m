Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVA1TQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVA1TQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVA1TKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:10:07 -0500
Received: from fsmlabs.com ([168.103.115.128]:37831 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262683AbVA1TFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:05:31 -0500
Date: Fri, 28 Jan 2005 12:05:48 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@osdl.org>,
       paul.mundt@nokia.com
Subject: [PATCH] OProfile: Use profile_pc in oprofile_add_sample
Message-ID: <Pine.LNX.4.61.0501281143000.22859@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should be using profile_pc in oprofile_add_sample so that lock 
contention is attibuted to the correct function in profile output. Also 
fix SH7750 support.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

===== drivers/oprofile/cpu_buffer.c 1.17 vs edited =====
--- 1.17/drivers/oprofile/cpu_buffer.c	2005-01-04 19:48:24 -07:00
+++ edited/drivers/oprofile/cpu_buffer.c	2005-01-28 11:08:37 -07:00
@@ -233,7 +233,7 @@ static void oprofile_end_trace(struct op
 void oprofile_add_sample(struct pt_regs * const regs, unsigned long event)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
-	unsigned long pc = instruction_pointer(regs);
+	unsigned long pc = profile_pc(regs);
 	int is_kernel = !user_mode(regs);
 
 	if (!backtrace_depth) {
===== arch/sh/oprofile/op_model_sh7750.c 1.1 vs edited =====
--- 1.1/arch/sh/oprofile/op_model_sh7750.c	2004-10-18 23:26:43 -06:00
+++ edited/arch/sh/oprofile/op_model_sh7750.c	2005-01-28 11:16:54 -07:00
@@ -112,14 +112,9 @@ static struct op_counter_config ctr[NR_C
  */
 
 static int sh7750_timer_notify(struct notifier_block *self,
-			       unsigned long val, void *data)
+			       unsigned long val, void *regs)
 {
-	struct pt_regs *regs = data;
-	unsigned long pc;
-
-	pc = instruction_pointer(regs);
-	oprofile_add_sample(pc, !user_mode(regs), 0, smp_processor_id());
-
+	oprofile_add_sample((struct pt_regs *)regs, 0);
 	return 0;
 }
 
