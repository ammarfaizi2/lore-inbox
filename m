Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVAEFlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVAEFlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAEFlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:41:13 -0500
Received: from ozlabs.org ([203.10.76.45]:36039 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262252AbVAEFfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:35:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16859.31879.564599.547605@cargo.ozlabs.ibm.com>
Date: Wed, 5 Jan 2005 16:35:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Jake Moilanen <moilanen@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (3/3) Clean up trap handling in head.S
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Jake Moilanen <moilanen@austin.ibm.com>.

Log machine check errors to error log and NVRAM.

Signed-off-by: Dave Altobelli <dalto@austin.ibm.com>
Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/ras.c~machine-check-logging arch/ppc64/kernel/ras.c
--- linux-2.6-bk/arch/ppc64/kernel/ras.c~machine-check-logging	Wed Dec 15 15:46:42 2004
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/ras.c	Wed Dec 15 15:52:46 2004
@@ -55,9 +55,13 @@
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static spinlock_t ras_log_buf_lock = SPIN_LOCK_UNLOCKED;
 
+char mce_data_buf[RTAS_ERROR_LOG_MAX]
+;
 /* This is true if we are using the firmware NMI handler (typically LPAR) */
 extern int fwnmi_active;
 
+extern void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr);
+
 static int ras_get_sensor_state_token;
 static int ras_check_exception_token;
 
@@ -242,6 +246,13 @@ ras_error_interrupt(int irq, void *dev_i
  * FWNMI vectors.  The pt_regs' r3 will be updated to reflect
  * the actual r3 if possible, and a ptr to the error log entry
  * will be returned if found.
+ *
+ * The mce_data_buf does not have any locks or protection around it,
+ * if a second machine check comes in, or a system reset is done
+ * before we have logged the error, then we will get corruption in the
+ * error log.  This is preferable over holding off on calling
+ * ibm,nmi-interlock which would result in us checkstopping if a
+ * second machine check did come in.
  */
 static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
 {
@@ -253,7 +264,9 @@ static struct rtas_error_log *fwnmi_get_
 	    (errdata >= rtas.base && errdata < rtas.base + rtas.size - 16)) {
 		savep = __va(errdata);
 		regs->gpr[3] = savep[0];	/* restore original r3 */
-		errhdr = (struct rtas_error_log *)(savep + 1);
+		memset(mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
+		memcpy(mce_data_buf, (char *)(savep + 1), RTAS_ERROR_LOG_MAX);
+		errhdr = (struct rtas_error_log *)mce_data_buf;
 	} else {
 		printk("FWNMI: corrupt r3\n");
 	}
@@ -291,26 +304,31 @@ void pSeries_system_reset_exception(stru
  * Return 1 if corrected (or delivered a signal).
  * Return 0 if there is nothing we can do.
  */
-static int recover_mce(struct pt_regs *regs, struct rtas_error_log err)
+static int recover_mce(struct pt_regs *regs, struct rtas_error_log * err)
 {
-	if (err.disposition == RTAS_DISP_FULLY_RECOVERED) {
+	int nonfatal = 0;
+
+	if (err->disposition == RTAS_DISP_FULLY_RECOVERED) {
 		/* Platform corrected itself */
-		return 1;
+		nonfatal = 1;
 	} else if ((regs->msr & MSR_RI) &&
 		   user_mode(regs) &&
-		   err.severity == RTAS_SEVERITY_ERROR_SYNC &&
-		   err.disposition == RTAS_DISP_NOT_RECOVERED &&
-		   err.target == RTAS_TARGET_MEMORY &&
-		   err.type == RTAS_TYPE_ECC_UNCORR &&
+		   err->severity == RTAS_SEVERITY_ERROR_SYNC &&
+		   err->disposition == RTAS_DISP_NOT_RECOVERED &&
+		   err->target == RTAS_TARGET_MEMORY &&
+		   err->type == RTAS_TYPE_ECC_UNCORR &&
 		   !(current->pid == 0 || current->pid == 1)) {
 		/* Kill off a user process with an ECC error */
 		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
 		       current->pid);
 		/* XXX something better for ECC error? */
 		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
-		return 1;
+		nonfatal = 1;
 	}
-	return 0;
+
+ 	log_error((char *)err, ERR_TYPE_RTAS_LOG, !nonfatal);
+
+	return nonfatal;
 }
 
 /*
@@ -325,14 +343,12 @@ static int recover_mce(struct pt_regs *r
  */
 int pSeries_machine_check_exception(struct pt_regs *regs)
 {
-	struct rtas_error_log err, *errp;
+	struct rtas_error_log *errp;
 
 	if (fwnmi_active) {
 		errp = fwnmi_get_errinfo(regs);
-		if (errp)
-			err = *errp;
-		fwnmi_release_errinfo();	/* frees errp */
-		if (errp && recover_mce(regs, err))
+		fwnmi_release_errinfo();
+		if (errp && recover_mce(regs, errp))
 			return 1;
 	}
 
