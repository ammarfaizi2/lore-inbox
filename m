Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVAEAIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVAEAIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVADVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:34:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:47059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262135AbVADVdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:33:14 -0500
Date: Tue, 4 Jan 2005 13:33:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] track capabilities in default dummy security module code
Message-ID: <20050104133313.D469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch dummy logic around to set cap_* bits during exec and set*uid based
on basic uid check.  Then check cap_* bits during capable() (rather than
doing basic uid check).  This ensures that capability bits are properly
initialized in case the capability module is later loaded.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/dummy.c 1.49 vs edited =====
--- 1.49/security/dummy.c	2005-01-03 15:49:14 -08:00
+++ edited/security/dummy.c	2005-01-04 13:14:10 -08:00
@@ -74,11 +74,8 @@ static int dummy_acct (struct file *file
 
 static int dummy_capable (struct task_struct *tsk, int cap)
 {
-	if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
-		/* capability granted */
+	if (cap_raised (tsk->cap_effective, cap))
 		return 0;
-
-	/* capability denied */
 	return -EPERM;
 }
 
@@ -183,6 +180,7 @@ static int dummy_bprm_alloc_security (st
 
 static void dummy_bprm_free_security (struct linux_binprm *bprm)
 {
+	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
 	return;
 }
 
@@ -558,6 +556,7 @@ static int dummy_task_setuid (uid_t id0,
 
 static int dummy_task_post_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
 {
+	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
 	return 0;
 }
 
