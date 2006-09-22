Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWIVXNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWIVXNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWIVXNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:13:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:33438 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964909AbWIVXNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:13:32 -0400
Subject: [PATCH] slim: fix bug with mm_users usage
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Mimi Zohar <zohar@us.ibm.com>,
       Dave Safford <safford@us.ibm.com>, Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 16:13:17 -0700
Message-Id: <1158966797.20493.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a NULL pointer dereference possible that was introduced in the
last round of modifications to the demotion code before merging.
current->mm should be checked for existence before it is dereferenced to
check the value of the mm_users field.  This patch fixes all instances
of this bug.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 security/slim/slm_main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc6-orig/security/slim/slm_main.c	2006-09-18 16:41:51.000000000 -0500
+++ linux-2.6.18-rc6/security/slim/slm_main.c	2006-09-22 13:58:35.000000000 -0500
@@ -529,7 +519,7 @@ static int enforce_integrity_read(struct
 	spin_lock(&cur_tsec->lock);
 	if (!is_iac_less_than_or_exempt(level, cur_tsec->iac_r)) {
 		rc = has_file_wperm(level);
-		if (atomic_read(&current->mm->mm_users) != 1)
+		if (current->mm && atomic_read(&current->mm->mm_users) != 1)
 			rc = 1;
 		if (rc) {
 			dprintk(SLM_BASE, "ppid %d(%s p=%d-%s) "
@@ -1100,7 +1092,7 @@ int slm_socket_create(int family, int ty
 			memset(&level, 0, sizeof(struct slm_file_xattr));
 			level.iac_level = SLM_IAC_UNTRUSTED;
 			rc = has_file_wperm(&level);
-			if (atomic_read(&current->mm->mm_users) != 1)
+			if (current->mm && atomic_read(&current->mm->mm_users) != 1)
 				rc = 1;
 			if (rc) {
 				dprintk(SLM_BASE,
@@ -1306,7 +1298,7 @@ static int enforce_integrity_execute(str
 		cur_tsec->iac_r = cur_tsec->iac_wx;
 	} else {
 		rc = has_file_wperm(level);
-		if (atomic_read(&current->mm->mm_users) != 1)
+		if (current->mm && atomic_read(&current->mm->mm_users) != 1)
 			rc = 1;
 		if (rc) {
 			dprintk(SLM_BASE,


