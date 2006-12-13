Return-Path: <linux-kernel-owner+w=401wt.eu-S964928AbWLMNGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWLMNGj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWLMNGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:06:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2425 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964928AbWLMNGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:06:38 -0500
Date: Wed, 13 Dec 2006 14:06:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
       chrisw@sous-sol.org, linux-security-module@vger.kernel.org
Subject: [-mm patch] slm_set_taskperm(): remove horrible error handling code
Message-ID: <20061213130646.GE3851@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error handling:
Pass something you memset'ed to 0 to functions that never change it but 
dereference it in dprintk()'s.

This patch removes this broken code - plain Oops'es aren't worse.

As a bonus, this function no longer wastes more than 2 kB stack space.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 security/slim/slm_main.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- linux-2.6.19-mm1/security/slim/slm_main.c.old	2006-12-13 02:58:34.000000000 +0100
+++ linux-2.6.19-mm1/security/slim/slm_main.c	2006-12-13 03:00:06.000000000 +0100
@@ -608,34 +608,21 @@
 			     struct slm_tsec_data *parent_tsec)
 {
 	return enforce_integrity_write(level, name, parent_tsk, parent_tsec);
 }
 
 static int slm_set_taskperm(int mask, struct slm_file_xattr *level,
 			    const unsigned char *name)
 {
-	struct task_struct *parent_tsk = current->parent, new_tsk;
-	struct slm_tsec_data *parent_tsec = NULL, new_tsec;
+	struct task_struct *parent_tsk = current->parent;
+	struct slm_tsec_data *parent_tsec;
 	int rc = 0;
 
-	if (parent_tsk)
-		parent_tsec = parent_tsk->security;
-	else {
-		printk(KERN_INFO
-		       "%s: current pid %d: parent_tsk is null\n",
-		       __FUNCTION__, current->pid);
-		memset(&new_tsk, 0, sizeof(struct task_struct));
-		parent_tsk = &new_tsk;
-	}
-
-	if (!parent_tsec) {
-		memset(&new_tsec, 0, sizeof(struct slm_tsec_data));
-		parent_tsec = &new_tsec;
-	}
+	parent_tsec = parent_tsk->security;
 
 	if (mask & MAY_READ)
 		rc = do_task_may_read(level, name, parent_tsk, parent_tsec);
 	if ((mask & MAY_WRITE) || (mask & MAY_APPEND))
 		rc |= do_task_may_write(level, name, parent_tsk, parent_tsec);
 
 	return rc;
 }

