Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275376AbTHNT3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275385AbTHNT3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:29:50 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:4520 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S275376AbTHNT3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:29:48 -0400
Subject: [PATCH] SELinux check behavior value
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1060889173.13964.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Aug 2003 15:26:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0-test3-bk fixes a bug in the SELinux module
by adding a check of the filesystem labeling behavior value
obtained from the policy.

 security/selinux/hooks.c       |   12 +++++++++---
 security/selinux/ss/policydb.c |    2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6/security/selinux/ss/policydb.c
diff -u linux-2.6/security/selinux/ss/policydb.c:1.1.1.1 linux-2.6/security/selinux/ss/policydb.c:1.23
--- linux-2.6/security/selinux/ss/policydb.c:1.1.1.1	Tue Aug 12 09:05:06 2003
+++ linux-2.6/security/selinux/ss/policydb.c	Wed Aug 13 09:57:03 2003
@@ -1301,6 +1301,8 @@
 				if (!buf)
 					goto bad;
 				c->v.behavior = le32_to_cpu(buf[0]);
+				if (c->v.behavior > SECURITY_FS_USE_NONE)
+					goto bad;
 				len = le32_to_cpu(buf[1]);
 				buf = next_entry(fp, len);
 				if (!buf)
Index: linux-2.6/security/selinux/hooks.c
diff -u linux-2.6/security/selinux/hooks.c:1.66 linux-2.6/security/selinux/hooks.c:1.67
--- linux-2.6/security/selinux/hooks.c:1.66	Thu Jul 17 07:33:31 2003
+++ linux-2.6/security/selinux/hooks.c	Tue Aug 12 14:29:53 2003
@@ -313,9 +313,15 @@
 
 	sbsec->initialized = 1;
 
-	printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
-	       sb->s_id, sb->s_type->name,
-	       labeling_behaviors[sbsec->behavior-1]);
+	if (sbsec->behavior > ARRAY_SIZE(labeling_behaviors)) { 
+		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), unknown behavior\n",
+		       sb->s_id, sb->s_type->name);
+	} 
+	else {
+		printk(KERN_INFO "SELinux: initialized (dev %s, type %s), %s\n",
+		       sb->s_id, sb->s_type->name,
+		       labeling_behaviors[sbsec->behavior-1]);
+	}
 
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(sb->s_root->d_inode, sb->s_root);



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

