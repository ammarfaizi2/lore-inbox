Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVANMtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVANMtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVANMtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:49:04 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:21389 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261979AbVANMri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:47:38 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE - don't check against zero fsuid
Message-Id: <E1CpQrL-0000RH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Jan 2005 13:47:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch replaces check for zero fsuid with a capability check.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -rup linux-2.6.11-rc1-mm1/fs/fuse/dir.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/dir.c
--- linux-2.6.11-rc1-mm1/fs/fuse/dir.c	2005-01-14 12:30:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/dir.c	2005-01-14 12:44:36.000000000 +0100
@@ -422,7 +422,7 @@ static int fuse_revalidate(struct dentry
 		if (!(fc->flags & FUSE_ALLOW_OTHER) &&
 		    current->fsuid != fc->user_id &&
 		    (!(fc->flags & FUSE_ALLOW_ROOT) ||
-		     current->fsuid != 0))
+		     !capable(CAP_DAC_OVERRIDE)))
 			return -EACCES;
 	} else if (time_before_eq(jiffies, fi->i_time))
 		return 0;
@@ -435,7 +435,7 @@ static int fuse_permission(struct inode 
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id &&
-	    (!(fc->flags & FUSE_ALLOW_ROOT) || current->fsuid != 0))
+	    (!(fc->flags & FUSE_ALLOW_ROOT) || !capable(CAP_DAC_OVERRIDE)))
 		return -EACCES;
 	else if (fc->flags & FUSE_DEFAULT_PERMISSIONS) {
 		int err = generic_permission(inode, mask, NULL);
