Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267755AbUHPQa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267755AbUHPQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHPQa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:30:26 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:16883 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S267755AbUHPQaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:30:16 -0400
Subject: [PATCH][SELINUX] Defer inode security initialization
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092673738.16631.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 12:28:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defers setting the inode security state for newly created inodes
until after policy has been loaded.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c |    6 ++++++
 1 files changed, 6 insertions(+)

diff -X /home/sds/dontdiff -ru linux-2.6.8.old/security/selinux/hooks.c linux-2.6.8/security/selinux/hooks.c
--- linux-2.6.8.old/security/selinux/hooks.c	2004-08-06 12:52:26.000000000 -0400
+++ linux-2.6.8/security/selinux/hooks.c	2004-08-06 12:54:11.356171296 -0400
@@ -1266,6 +1266,12 @@
 int inode_security_set_sid(struct inode *inode, u32 sid)
 {
 	struct inode_security_struct *isec = inode->i_security;
+	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+
+	if (!sbsec->initialized) {
+		/* Defer initialization to selinux_complete_init. */
+		return 0;
+	}
 
 	down(&isec->sem);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

