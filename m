Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUGCI1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUGCI1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 04:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUGCI04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 04:26:56 -0400
Received: from ozlabs.org ([203.10.76.45]:63196 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265054AbUGCIZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 04:25:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16614.28039.496598.178659@cargo.ozlabs.ibm.com>
Date: Sat, 3 Jul 2004 18:25:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 EEH fixes for POWER5 machines (2/2)
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linas Vepstas <linas@austin.ibm.com>

This patch fixes the usage of the slot-error-detail log buffer for 
the Power5 architecture.  The size of the error buffer is variable,
and the correct size to use should have been obtained from
firmware.  Failure to use the correct buffer sizes will result
in hard-to-debug system lockups deep in firmware.  This patch 
is based on an earlier patch from Ben Herrenschmidt, which 
essentially did the same thing.

This patch also tweaks some of the subroutine documentation.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.6/arch/ppc64/kernel/eeh.c test26/arch/ppc64/kernel/eeh.c
--- linux-2.6/arch/ppc64/kernel/eeh.c	2004-07-03 16:38:52.157964952 +1000
+++ test26/arch/ppc64/kernel/eeh.c	2004-07-03 18:05:17.154993616 +1000
@@ -45,12 +45,18 @@
 static int ibm_set_eeh_option;
 static int ibm_set_slot_reset;
 static int ibm_read_slot_reset_state;
+static int ibm_slot_error_detail;
 
 static int eeh_subsystem_enabled;
 #define EEH_MAX_OPTS 4096
 static char *eeh_opts;
 static int eeh_opts_last;
 
+/* Buffer for reporting slot-error-detail rtas calls */
+static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
+static spinlock_t slot_errbuf_lock = SPIN_LOCK_UNLOCKED;
+static int eeh_error_buf_size;
+
 /* System monitoring statistics */
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
@@ -368,9 +374,6 @@
 	struct device_node *dn;
 	int ret;
 	int rets[2];
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
-	/* dont want this on the stack */
-	static unsigned char slot_err_buf[RTAS_ERROR_LOG_MAX];
 	unsigned long flags;
 
 	__get_cpu_var(total_mmio_ffs)++;
@@ -414,23 +417,24 @@
 			BUID_LO(dn->phb->buid));
 
 	if (ret == 0 && rets[1] == 1 && rets[0] >= 2) {
-		int slot_err_ret;
+		int log_event;
+
+		spin_lock_irqsave(&slot_errbuf_lock, flags);
+		memset(slot_errbuf, 0, eeh_error_buf_size);
 
-		spin_lock_irqsave(&lock, flags);
-		memset(slot_err_buf, 0, RTAS_ERROR_LOG_MAX);
-		slot_err_ret = rtas_call(rtas_token("ibm,slot-error-detail"),
-					 8, 1, NULL, dn->eeh_config_addr,
-					 BUID_HI(dn->phb->buid),
-					 BUID_LO(dn->phb->buid), NULL, 0,
-					 __pa(slot_err_buf),
-					 RTAS_ERROR_LOG_MAX,
-					 2 /* Permanent Error */);
+		log_event = rtas_call(ibm_slot_error_detail,
+		                      8, 1, NULL, dn->eeh_config_addr,
+		                      BUID_HI(dn->phb->buid),
+		                      BUID_LO(dn->phb->buid), NULL, 0,
+		                      virt_to_phys(slot_errbuf),
+		                      eeh_error_buf_size,
+		                      2 /* Permanent Error */);
 
-		if (slot_err_ret == 0)
-			log_error(slot_err_buf, ERR_TYPE_RTAS_LOG,
+		if (log_event == 0)
+			log_error(slot_errbuf, ERR_TYPE_RTAS_LOG,
 				  1 /* Fatal */);
 
-		spin_unlock_irqrestore(&lock, flags);
+		spin_unlock_irqrestore(&slot_errbuf_lock, flags);
 
 		/*
 		 * XXX We should create a separate sysctl for this.
@@ -517,8 +521,7 @@
 	}
 
 	if (!enable || info->force_off) {
-		dn->eeh_mode = EEH_MODE_NOCHECK;
-		return NULL;
+		dn->eeh_mode |= EEH_MODE_NOCHECK;
 	}
 
 	/* This device may already have an EEH parent. */
@@ -562,14 +565,13 @@
  * As a side effect we can determine here if eeh is supported at all.
  * Note that we leave EEH on so failed config cycles won't cause a machine
  * check.  If a user turns off EEH for a particular adapter they are really
- * telling Linux to ignore errors.
- *
- * We should probably distinguish between "ignore errors" and "turn EEH off"
- * but for now disabling EEH for adapters is mostly to work around drivers that
- * directly access mmio space (without using the macros).
- *
- * The eeh-force-off option does literally what it says, so if Linux must
- * avoid enabling EEH this must be done.
+ * telling Linux to ignore errors.  Some hardware (e.g. POWER5) won't
+ * grant access to a slot if EEH isn't enabled, and so we always enable
+ * EEH for all slots/all devices.
+ *
+ * The eeh-force-off option disables EEH checking globally, for all slots.
+ * Even if force-off is set, the EEH hardware is still enabled, so that
+ * newer systems can boot.
  */
 void __init eeh_init(void)
 {
@@ -588,10 +590,21 @@
 	ibm_set_eeh_option = rtas_token("ibm,set-eeh-option");
 	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
+	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
 		return;
 
+	eeh_error_buf_size = rtas_token("rtas-error-log-max");
+	if (eeh_error_buf_size == RTAS_UNKNOWN_SERVICE) {
+		eeh_error_buf_size = 1024;
+	}
+	if (eeh_error_buf_size > RTAS_ERROR_LOG_MAX) {
+		printk(KERN_WARNING "EEH: rtas-error-log-max is bigger than allocated "
+		      "buffer ! (%d vs %d)", eeh_error_buf_size, RTAS_ERROR_LOG_MAX);
+		eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
+	}
+
 	info.force_off = 0;
 	if (eeh_force_off) {
 		printk(KERN_WARNING "EEH: WARNING: PCI Enhanced I/O Error "
