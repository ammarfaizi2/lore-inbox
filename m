Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVA0XFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVA0XFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVA0XFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:05:01 -0500
Received: from news.suse.de ([195.135.220.2]:23982 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261268AbVA0XDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:03:21 -0500
Subject: Re: 2.6.11-rc2-mm1: kernel bad access while booting diskless client
From: Andreas Gruenbacher <agruen@suse.de>
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1106866256.7616.50.camel@winden.suse.de>
References: <20050127215619.56535.qmail@web52309.mail.yahoo.com>
	 <20050127142333.0ba81907.akpm@osdl.org>
	 <1106866256.7616.50.camel@winden.suse.de>
Content-Type: multipart/mixed; boundary="=-VzZBfKrScoz6T9mSuTa4"
Organization: SUSE Labs
Message-Id: <1106866999.7616.57.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 28 Jan 2005 00:03:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VzZBfKrScoz6T9mSuTa4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello again,

this looks like a good candidate. Could you please try if it fixes the
problem?

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-VzZBfKrScoz6T9mSuTa4
Content-Disposition: attachment; filename=nfsacl-iop-NULL-fix.diff
Content-Type: message/rfc822; name=nfsacl-iop-NULL-fix.diff

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Must not initialize inode->i_op to NULL
Date: Fri, 28 Jan 2005 00:01:46 +0100
Message-Id: <1106866906.7616.55.camel@winden.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

This pattern from 2.4 times doesn't work very well anymore :(

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-latest/fs/nfs/inode.c
===================================================================
--- linux-2.6.11-latest.orig/fs/nfs/inode.c
+++ linux-2.6.11-latest/fs/nfs/inode.c
@@ -688,7 +688,7 @@ nfs_init_locked(struct inode *inode, voi
 #define NFS_LIMIT_READDIRPLUS (8*PAGE_SIZE)
 
 #ifdef CONFIG_NFS_ACL
-static struct inode_operations nfs_special_inode_operations[] = {{
+static struct inode_operations nfs_special_inode_operations = {
 	.permission =	nfs_permission,
 	.getattr =	nfs_getattr,
 	.setattr =	nfs_setattr,
@@ -696,9 +696,7 @@ static struct inode_operations nfs_speci
 	.getxattr =	nfs_getxattr,
 	.setxattr =	nfs_setxattr,
 	.removexattr =	nfs_removexattr,
-}};
-#else
-#define nfs_special_inode_operations NULL
+};
 #endif  /* CONFIG_NFS_ACL */
 
 /*
@@ -755,7 +753,9 @@ nfs_fhget(struct super_block *sb, struct
 		} else if (S_ISLNK(inode->i_mode))
 			inode->i_op = &nfs_symlink_inode_operations;
 		else {
-			inode->i_op = nfs_special_inode_operations;
+#ifdef CONFIG_NFS_ACL
+			inode->i_op = &nfs_special_inode_operations;
+#endif
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
 		}
 

--=-VzZBfKrScoz6T9mSuTa4--

