Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWALEQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWALEQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWALEQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:16:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:25828 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965019AbWALEPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:25 -0500
Subject: [PATCH -mm 3/10] unshare system call -v5 : unshare filesystem info
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137038994.7488.208.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 3/10] unshare system call: allow unsharing of filesystem info

If filesystem structure is being shared, allocate a new one and
copy information from the current, shared, structure.

Changes since -v4 of this patch submitted on 12/13/05:
        - none

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 fork.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -Naurp 2.6.15-mm3+unsh-base/kernel/fork.c 2.6.15-mm3+unsh-fs/kernel/fork.c
--- 2.6.15-mm3+unsh-base/kernel/fork.c	2006-01-11 22:46:49.000000000 +0000
+++ 2.6.15-mm3+unsh-fs/kernel/fork.c	2006-01-12 00:26:46.000000000 +0000
@@ -1371,15 +1371,18 @@ static int unshare_thread(unsigned long 
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


