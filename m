Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUEDPBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUEDPBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbUEDPBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:01:47 -0400
Received: from ns.suse.de ([195.135.220.2]:42887 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264426AbUEDPB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:01:26 -0400
Subject: [PATCH] Invalid notify_change(symlink, [ATTR_MODE]) in nfsd
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Olaf Kirch <okir@suse.de>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083682588.1444.24.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 04 May 2004 16:56:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

notify_change() gets called with at most the ATTR_MODE flag set for
symlinks, but it should be called with the ATTR_MODE flag cleared.
This triggers a bug in fs/reiserfs/xattr_acl.c (reiserfs plus acl
patches), and perhaps on other file systems, too. (On ext2/ext3 symlinks
have no ->setattr, there the bug does not trigger.)

	int
	reiserfs_acl_chmod (struct inode *inode)
	{
        	struct posix_acl *acl, *clone;
	        int error;

==>	        if (S_ISLNK(inode->i_mode))
==>	                return -EOPNOTSUPP;


This is the fix -- please apply.

Index: linux-2.6.6-rc3/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.6-rc3.orig/fs/nfsd/vfs.c
+++ linux-2.6.6-rc3/fs/nfsd/vfs.c
@@ -1212,7 +1212,7 @@ nfsd_symlink(struct svc_rqst *rqstp, str
 		if (EX_ISSYNC(fhp->fh_export))
 			nfsd_sync_dir(dentry);
 		if (iap) {
-			iap->ia_valid &= ATTR_MODE /* ~(ATTR_MODE|ATTR_UID|ATTR_GID)*/;
+			iap->ia_valid &= ~ATTR_MODE;
 			if (iap->ia_valid) {
 				iap->ia_valid |= ATTR_CTIME;
 				iap->ia_mode = (iap->ia_mode&S_IALLUGO)


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

