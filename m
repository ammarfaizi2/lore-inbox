Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUJTQVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUJTQVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUJTQPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:15:46 -0400
Received: from [144.51.25.10] ([144.51.25.10]:31228 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S268048AbUJTQOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:14:06 -0400
Subject: [PATCH][SELINUX] Add DAC check for setxattr(security.selinux)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1098288630.672.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 20 Oct 2004 12:10:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.9 adds a DAC ownership check to the existing MAC
permission checks when setting the security.selinux attribute via
setxattr.  In the past, the MAC permission checks were viewed as
sufficient for controlling relabeling operations, but experience in the
Fedora SELinux integration has shown that a DAC check is also
appropriate here, particularly under targeted policy.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.9/security/selinux/hooks.c.orig	2004-10-20 10:32:18.653598056 -0400
+++ linux-2.6.9/security/selinux/hooks.c	2004-10-20 10:32:39.712396632 -0400
@@ -2243,6 +2243,9 @@ static int selinux_inode_setxattr(struct
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
 
+	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		return -EPERM;
+
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


