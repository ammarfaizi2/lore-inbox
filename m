Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbULHJag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbULHJag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULHJag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:30:36 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:65533 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261165AbULHJaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:30:16 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: phil.el@wanadoo.fr
Subject: [mm patch] oprofile: backtrace operation does not initialized 
Date: Wed, 8 Dec 2004 18:30:51 +0900
User-Agent: KMail/1.5.4
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412081830.51607.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

When I forced the oprofile to use timer interrupt with specifying
"timer=1" module parameter. "oprofile_operations->backtrace" did
not initialized on i386.

Please apply this patch, or make oprofile initialize the backtrace
operation in case of using timer interrupt in your preferable way.

---

Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>

 arch/alpha/oprofile/common.c |    3 +++
 arch/arm/oprofile/init.c     |    3 +++
 arch/i386/oprofile/init.c    |    5 ++++-
 arch/ia64/oprofile/init.c    |    5 ++++-
 arch/ppc64/oprofile/common.c |    3 +++
 drivers/oprofile/oprof.c     |    4 ++--
 include/linux/oprofile.h     |    2 ++
 7 files changed, 21 insertions(+), 4 deletions(-)

diff -Nurp 2.6-mm.orig/arch/alpha/oprofile/common.c 2.6-mm/arch/alpha/oprofile/common.c
--- 2.6-mm.orig/arch/alpha/oprofile/common.c	2004-12-07 00:11:29.000000000 +0900
+++ 2.6-mm/arch/alpha/oprofile/common.c	2004-12-07 23:35:48.000000000 +0900
@@ -143,6 +143,9 @@ oprofile_arch_init(struct oprofile_opera
 {
 	struct op_axp_model *lmodel = NULL;
 
+	if (ops->force_timer)
+		return;
+
 	switch (implver()) {
 	case IMPLVER_EV4:
 		lmodel = &op_model_ev4;
diff -Nurp 2.6-mm.orig/arch/arm/oprofile/init.c 2.6-mm/arch/arm/oprofile/init.c
--- 2.6-mm.orig/arch/arm/oprofile/init.c	2004-12-07 00:11:32.000000000 +0900
+++ 2.6-mm/arch/arm/oprofile/init.c	2004-12-07 23:37:26.000000000 +0900
@@ -14,6 +14,9 @@
 
 void __init oprofile_arch_init(struct oprofile_operations *ops)
 {
+	if (ops->force_timer)
+		return;
+
 #ifdef CONFIG_CPU_XSCALE
 	pmu_init(ops, &op_xscale_spec);
 #endif
diff -Nurp 2.6-mm.orig/arch/i386/oprofile/init.c 2.6-mm/arch/i386/oprofile/init.c
--- 2.6-mm.orig/arch/i386/oprofile/init.c	2004-12-07 00:11:15.000000000 +0900
+++ 2.6-mm/arch/i386/oprofile/init.c	2004-12-07 23:29:31.000000000 +0900
@@ -25,6 +25,10 @@ void __init oprofile_arch_init(struct op
 {
 	int ret __attribute_used__ = -ENODEV;
 
+	ops->backtrace = x86_backtrace;
+	if (ops->force_timer)
+		return;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	ret = nmi_init(ops);
 #endif
@@ -32,7 +36,6 @@ void __init oprofile_arch_init(struct op
 	if (ret < 0)
 		ret = nmi_timer_init(ops);
 #endif
-	ops->backtrace = x86_backtrace;
 }
 
 
diff -Nurp 2.6-mm.orig/arch/ia64/oprofile/init.c 2.6-mm/arch/ia64/oprofile/init.c
--- 2.6-mm.orig/arch/ia64/oprofile/init.c	2004-12-07 00:11:29.000000000 +0900
+++ 2.6-mm/arch/ia64/oprofile/init.c	2004-12-07 23:35:02.000000000 +0900
@@ -18,11 +18,14 @@ extern void ia64_backtrace(struct pt_reg
 
 void __init oprofile_arch_init(struct oprofile_operations * ops)
 {
+	ops->backtrace = ia64_backtrace;
+	if (ops->force_timer)
+		return;
+
 #ifdef CONFIG_PERFMON
 	/* perfmon_init() can fail, but we have no way to report it */
 	perfmon_init(ops);
 #endif
-	ops->backtrace = ia64_backtrace;
 }
 
 
diff -Nurp 2.6-mm.orig/arch/ppc64/oprofile/common.c 2.6-mm/arch/ppc64/oprofile/common.c
--- 2.6-mm.orig/arch/ppc64/oprofile/common.c	2004-12-07 00:11:30.000000000 +0900
+++ 2.6-mm/arch/ppc64/oprofile/common.c	2004-12-07 23:36:59.000000000 +0900
@@ -129,6 +129,9 @@ void __init oprofile_arch_init(struct op
 {
 	unsigned int pvr;
 
+	if (ops->force_timer)
+		return;
+
 	pvr = mfspr(SPRN_PVR);
 
 	switch (PVR_VER(pvr)) {
diff -Nurp 2.6-mm.orig/drivers/oprofile/oprof.c 2.6-mm/drivers/oprofile/oprof.c
--- 2.6-mm.orig/drivers/oprofile/oprof.c	2004-12-07 00:12:07.000000000 +0900
+++ 2.6-mm/drivers/oprofile/oprof.c	2004-12-07 22:51:21.000000000 +0900
@@ -159,10 +159,10 @@ static int __init oprofile_init(void)
 	oprofile_timer_init(&oprofile_ops);
 
 	if (timer) {
+		oprofile_ops.force_timer = 1;
 		printk(KERN_INFO "oprofile: using timer interrupt.\n");
-	} else {
-		oprofile_arch_init(&oprofile_ops);
 	}
+	oprofile_arch_init(&oprofile_ops);
 
 	err = oprofilefs_register();
 	if (err)
diff -Nurp 2.6-mm.orig/include/linux/oprofile.h 2.6-mm/include/linux/oprofile.h
--- 2.6-mm.orig/include/linux/oprofile.h	2004-12-07 00:12:32.000000000 +0900
+++ 2.6-mm/include/linux/oprofile.h	2004-12-07 22:50:07.000000000 +0900
@@ -39,6 +39,8 @@ struct oprofile_operations {
 	void (*backtrace)(struct pt_regs * const regs, unsigned int depth);
 	/* CPU identification string. */
 	char * cpu_type;
+	/* Force use of timer interrupt */
+	int force_timer;
 };
 
 /**


