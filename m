Return-Path: <linux-kernel-owner+w=401wt.eu-S1426167AbWLHTi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426167AbWLHTi3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426162AbWLHTi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:38:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:58341 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426165AbWLHTi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:38:28 -0500
Date: Fri, 8 Dec 2006 13:38:25 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH 1/2] file capabilities: don't do file caps if MNT_NOSUID
Message-ID: <20061208193825.GC18566@sergelap.austin.ibm.com>
References: <20061208193657.GB18566@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208193657.GB18566@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/2] file capabilities: don't do file caps if MNT_NOSUID

A file system mounted NOSUID is likely a removable filesystem.
Allowing file capabilities from such an fs is an easy attack
vector, so don't honor file capabilities for a NOSUID
filesystem.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/commoncap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index ce91d9f..fde9695 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -23,6 +23,7 @@ #include <linux/netlink.h>
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
+#include <linux/mount.h>
 
 int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
@@ -152,6 +153,9 @@ static int set_file_caps(struct linux_bi
 	struct inode *inode;
 	int err;
 
+	if (bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)
+		return 0;
+
 	dentry = dget(bprm->file->f_dentry);
 	inode = dentry->d_inode;
 	if (!inode->i_op || !inode->i_op->getxattr) {
-- 
1.4.1

