Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbVLMW4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbVLMW4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVLMWzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:55:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62636 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030340AbVLMWzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:55:04 -0500
Subject: [PATCH -mm 6/9] unshare system call: allow unsharing of filesystem
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134514166.11972.201.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 17:54:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 6/9] unshare system call: allow unsharing of filesystem

If filesystem structure is being shared, allocate a new one and
copy information from the current, shared, structure.

Changes since the first submission of this patch on 12/12/05:
	- Removed an unnecessary local variable (12/13/05)
 
Signed-off-by: Janak Desai <janak@us.ibm.com>
 
---
 
 fork.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
 
diff -Naurp 2.6.15-rc5-mm2+patch/kernel/fork.c 2.6.15-rc5-mm2+patch6/kernel/fork.c
--- 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-13 18:38:26.000000000 +0000
+++ 2.6.15-rc5-mm2+patch6/kernel/fork.c	2005-12-13 19:38:03.000000000 +0000
@@ -1378,15 +1378,18 @@ static int unshare_thread(unsigned long 
 }
 
 /*
- * Unsharing of fs info for tasks created with CLONE_FS is not supported yet
+ * Unshare the filesystem structure if it is being shared
  */
 static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 {
 	struct fs_struct *fs = current->fs;
 
 	if ((unshare_flags & CLONE_FS) &&
-	    (fs && atomic_read(&fs->count) > 1))
-		return -EINVAL;
+	    (fs && atomic_read(&fs->count) > 1)) {
+		*new_fsp = __copy_fs_struct(current->fs);
+		if (!*new_fsp)
+			return -ENOMEM;
+	}
 
 	return 0;
 }


