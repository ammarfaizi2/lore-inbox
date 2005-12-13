Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVLMNpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVLMNpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLMNnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:18061 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932227AbVLMNnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:22 -0500
Subject: [PATCH -mm 6/9] unshare system call : allow unsharing of fs
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481309.25431.189.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:43:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 6/9] unshare system call: allow unsharing of fs

 fork.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)
 
 
diff -Naurp 2.6.15-rc5-mm2+patch/kernel/fork.c 2.6.15-rc5-mm2+patch6/kernel/fork.c
--- 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-12 19:31:48.000000000 +0000
+++ 2.6.15-rc5-mm2+patch6/kernel/fork.c	2005-12-12 21:12:36.000000000 +0000
@@ -1378,15 +1378,19 @@ static int unshare_thread(unsigned long 
 }
 
 /*
- * Unsharing of fs info for tasks created with CLONE_FS is not supported yet
+ * Unshare the filesystem structure if it is being shared
  */
 static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs = current->fs, *new_fs;
 
 	if ((unshare_flags & CLONE_FS) &&
-	    (fs && atomic_read(&fs->count) > 1))
-		return -EINVAL;
+	    (fs && atomic_read(&fs->count) > 1)) {
+		new_fs = __copy_fs_struct(current->fs);
+		if (!new_fs)
+			return -ENOMEM;
+		*new_fsp = new_fs;
+	}
 
 	return 0;
 }


