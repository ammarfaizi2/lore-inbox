Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWGMUYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWGMUYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWGMUYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:24:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11684 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030365AbWGMUYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:24:35 -0400
Subject: [PATCH] Fix security check for joint context= and fscontext= mount
	options
From: Eric Paris <eparis@parisplace.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 13 Jul 2006 16:24:27 -0400
Message-Id: <1152822267.2669.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some discussion on the actual meaning of the filesystem class
security check in try context mount it was determined that the checks
for the context= mount options were not correct if fscontext mount
option had already been used.  When labeling the superblock we should be
checking relabel_from and relabel_to.  But if the superblock has already
been labeled (with fscontext) then context= is actually labeling the
inodes, and so we should be checking relabel_from and associate.  This
patch fixes which checks are called depending on the mount options.

This is issue is in 2.6.8-rc1-git4 and should probably be fixed before
2.6.18 releases.

Signed-off-by: Eric Paris <eparis@redhat.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: James Morris <jmorris@namei.org>

 security/selinux/hooks.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -523,12 +523,16 @@ static int try_context_mount(struct supe
 			goto out_free;
 		}
 
-		rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
-		if (rc)
-			goto out_free;
-
-		if (!fscontext)
+		if (!fscontext) {
+			rc = may_context_mount_sb_relabel(sid, sbsec, tsec);
+			if (rc)
+				goto out_free;
 			sbsec->sid = sid;
+		} else {
+			rc = may_context_mount_inode_relabel(sid, sbsec, tsec);
+			if (rc)
+				goto out_free;
+		}
 		sbsec->mntpoint_sid = sid;
 
 		sbsec->behavior = SECURITY_FS_USE_MNTPOINT;

