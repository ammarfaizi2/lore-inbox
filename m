Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUKIKpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUKIKpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUKIKo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:44:58 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7637 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261483AbUKIKjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:39:32 -0500
Subject: [PATCH 5/11] oprofile: update alpha for api changes
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-tbreY5W+yZ7YjFalGD26"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996757.1985.789.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:39:17 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tbreY5W+yZ7YjFalGD26
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-tbreY5W+yZ7YjFalGD26
Content-Disposition: attachment; filename=oprofile-callgraph-alpha
Content-Type: text/plain; name=oprofile-callgraph-alpha; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile alpha arch updates, including some internal
API changes.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/alpha/oprofile/common.c        |   27 ++++++++++-----------------
 arch/alpha/oprofile/op_model_ev4.c  |    3 +--
 arch/alpha/oprofile/op_model_ev5.c  |    3 +--
 arch/alpha/oprofile/op_model_ev6.c  |    3 +--
 arch/alpha/oprofile/op_model_ev67.c |    8 +++-----
 5 files changed, 16 insertions(+), 28 deletions(-)


Index: linux/arch/alpha/oprofile/op_model_ev4.c
===================================================================
--- linux.orig/arch/alpha/oprofile/op_model_ev4.c	2004-10-19 07:53:51.%N +1000
+++ linux/arch/alpha/oprofile/op_model_ev4.c	2004-11-06 01:20:07.%N +1100
@@ -101,8 +101,7 @@ ev4_handle_interrupt(unsigned long which
 		return;
 
 	/* Record the sample.  */
-	oprofile_add_sample(regs->pc, !user_mode(regs),
-			    which, smp_processor_id());
+	oprofile_add_sample(regs, which);
 }
 
 
Index: linux/arch/alpha/oprofile/op_model_ev5.c
===================================================================
--- linux.orig/arch/alpha/oprofile/op_model_ev5.c	2004-10-19 07:53:51.%N +1000
+++ linux/arch/alpha/oprofile/op_model_ev5.c	2004-11-06 01:20:07.%N +1100
@@ -186,8 +186,7 @@ ev5_handle_interrupt(unsigned long which
 		     struct op_counter_config *ctr)
 {
 	/* Record the sample.  */
-	oprofile_add_sample(regs->pc, !user_mode(regs),
-			    which, smp_processor_id());
+	oprofile_add_sample(regs, which);
 }
 
 
Index: linux/arch/alpha/oprofile/op_model_ev6.c
===================================================================
--- linux.orig/arch/alpha/oprofile/op_model_ev6.c	2004-10-19 07:54:32.%N +1000
+++ linux/arch/alpha/oprofile/op_model_ev6.c	2004-11-06 01:20:07.%N +1100
@@ -88,8 +88,7 @@ ev6_handle_interrupt(unsigned long which
 		     struct op_counter_config *ctr)
 {
 	/* Record the sample.  */
-	oprofile_add_sample(regs->pc, !user_mode(regs),
-			    which, smp_processor_id());
+	oprofile_add_sample(regs, which);
 }
 
 
Index: linux/arch/alpha/oprofile/op_model_ev67.c
===================================================================
--- linux.orig/arch/alpha/oprofile/op_model_ev67.c	2004-10-19 07:55:28.%N +1000
+++ linux/arch/alpha/oprofile/op_model_ev67.c	2004-11-06 01:20:07.%N +1100
@@ -138,8 +138,7 @@ op_add_pm(unsigned long pc, int kern, un
 	if (counter == 1)
 		fake_counter += PM_NUM_COUNTERS;
 	if (ctr[fake_counter].enabled)
-		oprofile_add_sample(pc, kern, fake_counter,
-				    smp_processor_id());
+		oprofile_add_pc(pc, kern, fake_counter);
 }
 
 static void
@@ -197,8 +196,7 @@ ev67_handle_interrupt(unsigned long whic
 			   to PALcode. Recognize ITB miss by PALcode
 			   offset address, and get actual PC from
 			   EXC_ADDR.  */
-			oprofile_add_sample(regs->pc, kern, which,
-					    smp_processor_id());
+			oprofile_add_pc(regs->pc, kern, which);
 			if ((pmpc & ((1 << 15) - 1)) ==  581)
 				op_add_pm(regs->pc, kern, which,
 					  ctr, PM_ITB_MISS);
@@ -241,7 +239,7 @@ ev67_handle_interrupt(unsigned long whic
 		}
 	}
 
-	oprofile_add_sample(pmpc, kern, which, smp_processor_id());
+	oprofile_add_pc(pmpc, kern, which);
 
 	pctr_ctl = wrperfmon(5, 0);
 	if (pctr_ctl & (1UL << 27))
Index: linux/arch/alpha/oprofile/common.c
===================================================================
--- linux.orig/arch/alpha/oprofile/common.c	2004-10-19 07:53:13.%N +1000
+++ linux/arch/alpha/oprofile/common.c	2004-11-06 01:20:07.%N +1100
@@ -138,17 +138,8 @@ op_axp_create_files(struct super_block *
 	return 0;
 }
 
-static struct oprofile_operations oprof_axp_ops = {
-	.create_files	= op_axp_create_files,
-	.setup		= op_axp_setup,
-	.shutdown	= op_axp_shutdown,
-	.start		= op_axp_start,
-	.stop		= op_axp_stop,
-	.cpu_type	= NULL		/* To be filled in below.  */
-};
-
-int __init
-oprofile_arch_init(struct oprofile_operations **ops)
+void __init
+oprofile_arch_init(struct oprofile_operations *ops)
 {
 	struct op_axp_model *lmodel = NULL;
 
@@ -175,16 +166,18 @@ oprofile_arch_init(struct oprofile_opera
 	}
 
 	if (!lmodel)
-		return -ENODEV;
+		return;
 	model = lmodel;
 
-	oprof_axp_ops.cpu_type = lmodel->cpu_type;
-	*ops = &oprof_axp_ops;
-
+	ops->create_files = op_axp_create_files;
+	ops->setup = op_axp_setup;
+	ops->shutdown = op_axp_shutdown;
+	ops->start = op_axp_start;
+	ops->stop = op_axp_stop;
+	ops->cpu_type = lmodel->cpu_type;
+	
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       lmodel->cpu_type);
-
-	return 0;
 }
 
 

--=-tbreY5W+yZ7YjFalGD26--

