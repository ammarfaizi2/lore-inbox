Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263417AbVBDSUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbVBDSUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbVBDSPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:15:44 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:55977 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S264427AbVBDSGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:06:22 -0500
Subject: [PATCH][SELINUX] Fix selinux_inode_setattr hook
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1107539956.8078.109.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Feb 2005 12:59:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-rc3 fixes the selinux_inode_setattr hook
function to honor the ATTR_FORCE flag, skipping any permission checking
in that case.  Otherwise, it is possible though unlikely for a denial
from the hook to prevent proper updating, e.g. for remove_suid upon
writing to a file.  This would only occur if the process had write
permission to a suid file but lacked setattr permission to it.  Please
apply.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.150
diff -u -p -r1.150 hooks.c
--- linux-2.6/security/selinux/hooks.c	26 Jan 2005 21:20:59 -0000	1.150
+++ linux-2.6/security/selinux/hooks.c	4 Feb 2005 16:39:23 -0000
@@ -2142,6 +2142,9 @@ static int selinux_inode_setattr(struct 
 	if (rc)
 		return rc;
 
+	if (iattr->ia_valid & ATTR_FORCE)
+		return 0;
+
 	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
 			       ATTR_ATIME_SET | ATTR_MTIME_SET))
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);


-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

