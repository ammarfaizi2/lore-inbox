Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbWHWTsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbWHWTsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWHWTsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:48:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61833 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965156AbWHWTsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:48:07 -0400
Subject: [PATCH] SELinux: 1/3 eliminate inode_security_set_security
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:50:31 -0400
Message-Id: <1156362631.6662.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inode_security_set_sid is only called by security_inode_init_security,
which is called when a new file is being created and needs to have its
incore security state initialized and its security xattr set.  This
helper used to be called in other places in the past, but now only has
the one.  So this patch rolls inode_security_set_sid directly back into
security_inode_init_security.  There also is no need to hold the
isec->sem while doing this, as the inode is not available to other
threads at this point in time.

This is being targeted for 2.6.19

Signed-off-by: Eric Paris <eparis@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

 security/selinux/hooks.c |   28 ++++++++--------------------
 1 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a91c961..a8ff26c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1364,25 +1364,6 @@ static inline u32 file_to_av(struct file
 	return av;
 }
 
-/* Set an inode's SID to a specified value. */
-static int inode_security_set_sid(struct inode *inode, u32 sid)
-{
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
-
-	if (!sbsec->initialized) {
-		/* Defer initialization to selinux_complete_init. */
-		return 0;
-	}
-
-	down(&isec->sem);
-	isec->sclass = inode_mode_to_security_class(inode->i_mode);
-	isec->sid = sid;
-	isec->initialized = 1;
-	up(&isec->sem);
-	return 0;
-}
-
 /* Hook functions begin here. */
 
 static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
@@ -2091,7 +2073,13 @@ static int selinux_inode_init_security(s
 		}
 	}
 
-	inode_security_set_sid(inode, newsid);
+	/* Possibly defer initialization to selinux_complete_init. */
+	if (sbsec->initialized) {
+		struct inode_security_struct *isec = inode->i_security;
+		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+		isec->sid = newsid;
+		isec->initialized = 1;
+	}
 
 	if (!ss_initialized || sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;



