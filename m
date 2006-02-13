Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWBMQMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWBMQMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWBMQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:12:38 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:30566 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750809AbWBMQMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:12:38 -0500
Date: Mon, 13 Feb 2006 11:12:36 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ReiserFS List <reiserfs-list@namesys.com>
Subject: [PATCH] reiserfs: fix potential (unlikely) oops in reiserfs_get_acl
Message-ID: <20060213161234.GA8931@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch fixes a potential oops if there is an error reported by
 posix_acl_from_disk(). This is mostly theoretical due to the use of 
 magics and checksums in xattrs, but is still possible.

 fs/reiserfs/xattr_acl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX ../dontdiff linux-2.6.15-staging1/fs/reiserfs/xattr_acl.c linux-2.6.15-staging2/fs/reiserfs/xattr_acl.c
--- linux-2.6.15-staging1/fs/reiserfs/xattr_acl.c	2006-02-10 16:27:18.000000000 -0500
+++ linux-2.6.15-staging2/fs/reiserfs/xattr_acl.c	2006-02-10 16:40:56.000000000 -0500
@@ -228,7 +228,8 @@ struct posix_acl *reiserfs_get_acl(struc
 		acl = ERR_PTR(retval);
 	} else {
 		acl = posix_acl_from_disk(value, retval);
-		*p_acl = posix_acl_dup(acl);
+		if (!IS_ERR(acl))
+			*p_acl = posix_acl_dup(acl);
 	}
 
 	kfree(value);
-- 
Jeff Mahoney
SuSE Labs
