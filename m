Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUCAFdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 00:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUCAFdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 00:33:00 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:57999 "EHLO
	mwinf0202.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262246AbUCAFc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 00:32:57 -0500
Date: Mon, 1 Mar 2004 06:33:01 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile, fix P4 HT msr sharing
Message-ID: <20040301063301.GA461@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

When I debugged P4 ht oprofile a few month ago I noticed that but though
it wasn't a problem... The fix I propose is not completely clean.


With P4 HT we split msr in two subset, one for each logical processor.
The msrs subset used in op_model_p4.c at save and setup point of view
are distinct (*), it means we must serialize setup and save operation
else a logical processor can save some msr value already setup by the
other thread then when oprofile shutdown we restore wrong msrs values.

Nobody noticed the problem because after restoring the msrs we call
enable_lapic_nmi_watchdog() -> setup_p4_watchdog() wich clear all the
msrs but it's a bit fragile. If nmi watchdog is not enabled nothing
bad occurs because the LVTPC remains disabled.


(*) this is done in this way because it allows a lot of simplification
in op_model_p4.c, yes it isn't clean but it's not fixable w/o rewriting
75% of op_model_p4.c and I think the code will be bigger and more complex.

Any comments ?

regards,
phil


--- linux-2.6.0-incr/arch/i386/oprofile/nmi_int.c	2003-12-30 13:57:39.000000000 +0000
+++ linux-2.6.0/arch/i386/oprofile/nmi_int.c	2004-03-01 04:13:54.000000000 +0000
@@ -88,7 +88,7 @@ static int nmi_callback(struct pt_regs *
 }
  
  
-static void nmi_save_registers(struct op_msrs * msrs)
+static void nmi_cpu_save_registers(struct op_msrs * msrs)
 {
 	unsigned int const nr_ctrs = model->num_counters;
 	unsigned int const nr_ctrls = model->num_controls; 
@@ -110,6 +110,15 @@ static void nmi_save_registers(struct op
 }
 
 
+static void nmi_save_registers(void * dummy)
+{
+	int cpu = smp_processor_id();
+	struct op_msrs * msrs = &cpu_msrs[cpu];
+	model->fill_in_addresses(msrs);
+	nmi_cpu_save_registers(msrs);
+}
+
+
 static void free_msrs(void)
 {
 	int i;
@@ -156,8 +165,6 @@ static void nmi_cpu_setup(void * dummy)
 {
 	int cpu = smp_processor_id();
 	struct op_msrs * msrs = &cpu_msrs[cpu];
-	model->fill_in_addresses(msrs);
-	nmi_save_registers(msrs);
 	spin_lock(&oprofilefs_lock);
 	model->setup_ctrs(msrs);
 	spin_unlock(&oprofilefs_lock);
@@ -177,6 +184,10 @@ static int nmi_setup(void)
 	 * break the core code horrifically.
 	 */
 	disable_lapic_nmi_watchdog();
+	/* We need to serialize save and setup for HT because the subset
+	 * of msrs are distinct for save and setup operations
+	 */
+	on_each_cpu(nmi_save_registers, NULL, 0, 1);
 	on_each_cpu(nmi_cpu_setup, NULL, 0, 1);
 	set_nmi_callback(nmi_callback);
 	nmi_enabled = 1;
