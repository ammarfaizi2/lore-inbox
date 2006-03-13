Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWCMSmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWCMSmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWCMSmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:42:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15253 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750743AbWCMSmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:42:10 -0500
Message-ID: <4415BC45.1010601@nc.rr.com>
Date: Mon, 13 Mar 2006 13:39:01 -0500
From: William Cohen <wcohen@nc.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [Perfctr-devel] 2.6.16-rc5 perfmon2 new code base + libpfm with
 Montecito support
References: <20060308155311.GD13168@frankl.hpl.hp.com>
In-Reply-To: <20060308155311.GD13168@frankl.hpl.hp.com>
Content-Type: multipart/mixed;
 boundary="------------020605020905090608030800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605020905090608030800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephane,

I have been looking through the perfmon2 code to see how it is going to 
work with OProfile. It looks like the ia64 oprofile support has not been 
modified to work with the changes in perfmon2. Has the ia64 kernel been 
built with perfmon2 and oprofile support? I don't have easy access to an 
ia64, so I haven't been able to verify that the attached patch works. 
However, I expect that the changes in the patch will be required for 
OProfile to function with perfmon2.

-Will


--------------020605020905090608030800
Content-Type: text/x-patch;
 name="perfmon2ia64_oprof.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="perfmon2ia64_oprof.diff"

--- linux-2.6.16-rc5-perfop/arch/ia64/oprofile/perfmon.c.ia64chg	2006-03-13 10:56:30.000000000 -0500
+++ linux-2.6.16-rc5-perfop/arch/ia64/oprofile/perfmon.c	2006-03-13 12:31:48.000000000 -0500
@@ -8,22 +8,27 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/oprofile.h>
 #include <linux/sched.h>
-#include <asm/perfmon.h>
+#include <linux/perfmon.h>
 #include <asm/ptrace.h>
 #include <asm/errno.h>
 
 static int allow_ints;
 
 static int
-perfmon_handler(struct task_struct *task, void *buf, pfm_ovfl_arg_t *arg,
-                struct pt_regs *regs, unsigned long stamp)
+perfmon_handler(void *buf, struct pfm_ovfl_arg *arg,
+                unsigned long ip, u64 stamp, void *data)
 {
 	int event = arg->pmd_eventid;
  
-	arg->ovfl_ctrl.bits.reset_ovfl_pmds = 1;
+	/* FIXME: oprofile_add_sample expect to have
+	   struct pt_regs * const regs */
+	struct pt_regs * const regs = (struct pt_regs *) data;
+
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_RESET;
 
 	/* the owner of the oprofile event buffer may have exited
 	 * without perfmon being shutdown (e.g. SIGSEGV)
@@ -54,6 +59,7 @@
  	.fmt_name 	    = "oprofile_format",
  	.fmt_uuid	    = OPROFILE_FMT_UUID,
  	.fmt_handler	    = perfmon_handler,
+	.owner		    = THIS_MODULE,
 };
 
 
@@ -76,9 +82,9 @@
 
 static int using_perfmon;
 
-int perfmon_init(struct oprofile_operations * ops)
+int __init op_perfmon_init(struct oprofile_operations * ops)
 {
-	int ret = pfm_register_buffer_fmt(&oprofile_fmt);
+	int ret = pfm_register_smpl_fmt(&oprofile_fmt);
 	if (ret)
 		return -ENODEV;
 
@@ -91,10 +97,10 @@
 }
 
 
-void perfmon_exit(void)
+void __exit op_perfmon_exit(void)
 {
 	if (!using_perfmon)
 		return;
 
-	pfm_unregister_buffer_fmt(oprofile_fmt.fmt_uuid);
+	pfm_unregister_smpl_fmt(oprofile_fmt.fmt_uuid);
 }
--- linux-2.6.16-rc5-perfop/arch/ia64/oprofile/init.c.ia64chg	2006-03-13 11:02:19.000000000 -0500
+++ linux-2.6.16-rc5-perfop/arch/ia64/oprofile/init.c	2006-03-13 11:03:09.000000000 -0500
@@ -12,8 +12,8 @@
 #include <linux/init.h>
 #include <linux/errno.h>
  
-extern int perfmon_init(struct oprofile_operations * ops);
-extern void perfmon_exit(void);
+extern int op_perfmon_init(struct oprofile_operations * ops);
+extern void op_perfmon_exit(void);
 extern void ia64_backtrace(struct pt_regs * const regs, unsigned int depth);
 
 int __init oprofile_arch_init(struct oprofile_operations * ops)
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_PERFMON
 	/* perfmon_init() can fail, but we have no way to report it */
-	ret = perfmon_init(ops);
+	ret = op_perfmon_init(ops);
 #endif
 	ops->backtrace = ia64_backtrace;
 
@@ -33,6 +33,6 @@
 void oprofile_arch_exit(void)
 {
 #ifdef CONFIG_PERFMON
-	perfmon_exit();
+	op_perfmon_exit();
 #endif
 }

--------------020605020905090608030800--
