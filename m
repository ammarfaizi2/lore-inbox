Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWEDVc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWEDVc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEDVc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:32:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:3981 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751338AbWEDVc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:32:28 -0400
Date: Thu, 4 May 2006 16:28:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: Please pull from 'for_paulus' branch of powerpc
Message-ID: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/kernel/setup-common.c |   17 +++++++++++++++++
 arch/powerpc/kernel/setup_32.c     |    4 ++++
 arch/powerpc/kernel/setup_64.c     |   17 ++---------------
 3 files changed, 23 insertions(+), 15 deletions(-)

Kumar Gala:
      powerpc: provide ppc_md.panic() for both ppc32 & ppc64

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 684ab1d..7a6a883 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -524,3 +524,20 @@ int check_legacy_ioport(unsigned long ba
 	return ppc_md.check_legacy_ioport(base_port);
 }
 EXPORT_SYMBOL(check_legacy_ioport);
+
+static int ppc_panic_event(struct notifier_block *this,
+                             unsigned long event, void *ptr)
+{
+	ppc_md.panic((char *)ptr);  /* May not return */
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ppc_panic_block = {
+	.notifier_call = ppc_panic_event,
+	.priority = INT_MIN /* may not return; must be done last */
+};
+
+void __init setup_panic(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
+}
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 69ac257..9d55234 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -236,6 +236,7 @@ arch_initcall(ppc_init);
 void __init setup_arch(char **cmdline_p)
 {
 	extern void do_init_bootmem(void);
+	extern void setup_panic(void);
 
 	/* so udelay does something sensible, assume <= 1000 bogomips */
 	loops_per_jiffy = 500000000 / HZ;
@@ -285,6 +286,9 @@ #endif
 	/* reboot on panic */
 	panic_timeout = 180;
 
+	if (ppc_md.panic)
+		setup_panic();
+
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4467c49..ff6726f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -100,12 +100,6 @@ unsigned long SYSRQ_KEY;
 #endif /* CONFIG_MAGIC_SYSRQ */
 
 
-static int ppc64_panic_event(struct notifier_block *, unsigned long, void *);
-static struct notifier_block ppc64_panic_block = {
-	.notifier_call = ppc64_panic_event,
-	.priority = INT_MIN /* may not return; must be done last */
-};
-
 #ifdef CONFIG_SMP
 
 static int smt_enabled_cmdline;
@@ -456,13 +450,6 @@ #endif
 	DBG(" <- setup_system()\n");
 }
 
-static int ppc64_panic_event(struct notifier_block *this,
-                             unsigned long event, void *ptr)
-{
-	ppc_md.panic((char *)ptr);  /* May not return */
-	return NOTIFY_DONE;
-}
-
 #ifdef CONFIG_IRQSTACKS
 static void __init irqstack_early_init(void)
 {
@@ -518,6 +505,7 @@ static void __init emergency_stack_init(
 void __init setup_arch(char **cmdline_p)
 {
 	extern void do_init_bootmem(void);
+	extern void setup_panic(void);
 
 	ppc64_boot_msg(0x12, "Setup Arch");
 
@@ -535,8 +523,7 @@ void __init setup_arch(char **cmdline_p)
 	panic_timeout = 180;
 
 	if (ppc_md.panic)
-		atomic_notifier_chain_register(&panic_notifier_list,
-				&ppc64_panic_block);
+		setup_panic();
 
 	init_mm.start_code = PAGE_OFFSET;
 	init_mm.end_code = (unsigned long) _etext;

