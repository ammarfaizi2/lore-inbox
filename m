Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWIRSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWIRSKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWIRSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:10:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:56030 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750838AbWIRSKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:10:02 -0400
Subject: [PATCH] slim: fix security issue with the task_post_setuid hook
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       sds@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 18 Sep 2006 11:09:53 -0700
Message-Id: <1158602993.16727.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Much thanks to Stephen Smalley for finding this security hole opened by
not calling the dummy_ops function in the task_post_setuid hook of the
SLIM LSM.  This patch fixes that as well as resolves an existing issue
where we should have been handling all LSM_SETID types.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 security/slim/slm_main.c |   77 ++++++++++++++++++++-----------------
 1 files changed, 42 insertions(+), 35 deletions(-)

Index: linux-2.6.18-rc6-mm2/security/slim/slm_main.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/security/slim/slm_main.c
+++ linux-2.6.18-rc6-mm2/security/slim/slm_main.c
@@ -29,6 +29,8 @@
 
 #include "slim.h"
 
+extern struct security_operations dummy_security_ops;
+
 unsigned int slm_debug = SLM_BASE;
 #define XATTR_NAME "security.slim.level"
 
@@ -1196,43 +1199,48 @@ static int slm_task_post_setuid(uid_t ol
 				uid_t old_suid, int flags)
 {
 	struct slm_tsec_data *cur_tsec = current->security;
+	int rc;
 
-	if (cur_tsec && flags == LSM_SETID_ID) {
-		/*set process to USER level integrity for everything but root */
-		dprintk(SLM_VERBOSE, "ruid %d euid %d suid %d "
-			"cur: uid %d euid %d suid %d\n",
+	/*set process to USER level integrity for everything but root */
+	dprintk(SLM_VERBOSE, "ruid %d euid %d suid %d "
+			"cur: uid %d euid %d suid %d "
+			"permitted %x effective %x\n",
 			old_ruid, old_euid, old_suid,
-			current->uid, current->euid, current->suid);
-		spin_lock(&cur_tsec->lock);
-		if ((cur_tsec->iac_r == cur_tsec->iac_wx)
-		    && (cur_tsec->iac_r == SLM_IAC_UNTRUSTED)) {
-			dprintk(SLM_INTEGRITY,
-				"Integrity: pid %d iac_r %d "
-				" iac_wx %d remains UNTRUSTED\n",
-				current->pid, cur_tsec->iac_r,
-				cur_tsec->iac_wx);
-		} else if (current->suid != 0) {
-			dprintk(SLM_INTEGRITY, "setting: pid %d iac_r %d "
-				" iac_wx %d to USER\n",
-				current->pid, cur_tsec->iac_r,
-				cur_tsec->iac_wx);
-			cur_tsec->iac_r = SLM_IAC_USER;
-			cur_tsec->iac_wx = SLM_IAC_USER;
-		} else if ((current->uid == 0) && (old_ruid != 0)) {
-			dprintk(SLM_INTEGRITY, "setting: pid %d iac_r %d "
-				" iac_wx %d to SYSTEM\n",
-				current->pid, cur_tsec->iac_r,
-				cur_tsec->iac_wx);
-			cur_tsec->iac_r = SLM_IAC_SYSTEM;
-			cur_tsec->iac_wx = SLM_IAC_SYSTEM;
-		} else
-			dprintk(SLM_INTEGRITY, "%s: pid %d iac_r %d "
-				" iac_wx %d \n", __FUNCTION__,
-				current->pid, cur_tsec->iac_r,
-				cur_tsec->iac_wx);
-		spin_unlock(&cur_tsec->lock);
-	}
-	return 0;
+			current->uid, current->euid, current->suid,
+			current->cap_permitted, current->cap_effective);
+	rc = dummy_security_ops.task_post_setuid(old_ruid, old_euid,
+						 old_suid, flags);
+	spin_lock(&cur_tsec->lock);
+	if ((cur_tsec->iac_r == cur_tsec->iac_wx)
+	    && (cur_tsec->iac_r == SLM_IAC_UNTRUSTED)) {
+		dprintk(SLM_INTEGRITY,
+			"Integrity: pid %d iac_r %d "
+			" iac_wx %d remains UNTRUSTED\n",
+			current->pid, cur_tsec->iac_r,
+			cur_tsec->iac_wx);
+		current->cap_permitted = 0;
+		current->cap_effective = 0;
+	} else if (current->suid != 0) {
+		dprintk(SLM_INTEGRITY, "setting: pid %d iac_r %d "
+			" iac_wx %d to USER\n",
+			current->pid, cur_tsec->iac_r,
+			cur_tsec->iac_wx);
+		cur_tsec->iac_r = SLM_IAC_USER;
+		cur_tsec->iac_wx = SLM_IAC_USER;
+	} else if ((current->uid == 0) && (old_ruid != 0)) {
+		dprintk(SLM_INTEGRITY, "setting: pid %d iac_r %d "
+			" iac_wx %d to SYSTEM\n",
+			current->pid, cur_tsec->iac_r,
+			cur_tsec->iac_wx);
+		cur_tsec->iac_r = SLM_IAC_SYSTEM;
+		cur_tsec->iac_wx = SLM_IAC_SYSTEM;
+	} else
+		dprintk(SLM_INTEGRITY, "%s: pid %d iac_r %d "
+			" iac_wx %d \n", __FUNCTION__,
+			current->pid, cur_tsec->iac_r,
+			cur_tsec->iac_wx);
+	spin_unlock(&cur_tsec->lock);
+	return rc;
 }
 
 static inline int slm_setprocattr(struct task_struct *tsk,


