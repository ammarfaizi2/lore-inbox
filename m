Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTLSQSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTLSQSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:18:39 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:25793 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263448AbTLSQSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:18:37 -0500
Subject: [PATCH] Remove use of nameidata by selinux_inode_permission
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1071850702.10242.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 19 Dec 2003 11:18:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0 removes the use of nameidata by
selinux_inode_permission, as this appears to be unsafe in certain cases
(e.g. path_walk call from rpc_lookup_parent), leading to an Oops if
d_path is subsequently called by avc_audit on the (mnt,dentry) pair to
generate a pathname for an audit message.  The change does not affect
the ability of SELinux to perform its permission check (which only
requires the inode), only the set of information that is available for
audit messages.  We'll investigate better approaches for the SELinux
audit generation in the future.  Please apply, or let me know if you
would like me to resubmit later.

 security/selinux/hooks.c |    4 ----
 1 files changed, 4 deletions(-)

--- linux-2.6.0/security/selinux/hooks.c	2003-12-17 21:59:41.000000000 -0500
+++ linux-2.6.0-respin/security/selinux/hooks.c	2003-12-19 10:42:20.000000000 -0500
@@ -1738,10 +1738,6 @@
 		return 0;
 	}
 
-	if (nd && nd->dentry)
-		return dentry_has_perm(current, nd->mnt, nd->dentry,
-				       file_mask_to_av(inode->i_mode, mask));
-
 	return inode_has_perm(current, inode,
 			       file_mask_to_av(inode->i_mode, mask), NULL, NULL);
 }




-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

