Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751889AbWITQsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbWITQsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWITQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:48:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:53704 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751917AbWITQsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:48:53 -0400
Subject: [PATCH] slim: handle failure to register
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Serge Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, Dave Safford <safford@us.ibm.com>,
       sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:48:43 -0700
Message-Id: <1158770924.16727.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Stephen Smalley for pointing out that we need to securely
handle a failure to register with the LSM security hooks.  This patch
adds a panic in the event that the module is unable to register.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
security/slim/slm_main.c |    6 +++++-
1 files changed, 5 insertions(+), 1 deletion(-) 
--- linux-2.6.18-rc6-orig/security/slim/slm_main.c	2006-09-18 16:41:51.000000000 -0500
+++ linux-2.6.18-rc6/security/slim/slm_main.c	2006-09-19 12:48:42.000000000 -0500
@@ -1644,9 +1644,13 @@ int slim_enabled = 1;
 #endif
 static int __init init_slm(void)
 {
+	int rc;
 	if (!slim_enabled)
 		return 0;
 	slm_task_init_alloc_security(current);
-	return register_security(&slm_security_ops);
+	rc = register_security(&slm_security_ops);
+	if (rc != 0)
+		panic("SLIM: Unable to register with kernel\n");
+	return rc;
 }
 security_initcall(init_slm);


