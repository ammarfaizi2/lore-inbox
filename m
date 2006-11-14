Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966306AbWKNUKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966306AbWKNUKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966324AbWKNUJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25257 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966305AbWKNUJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:02 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 14/19] CacheFiles: Permit an inode's security ID to be obtained
Date: Tue, 14 Nov 2006 20:06:52 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200651.12943.12111.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Permit an inode's security ID to be obtained by the CacheFiles module.  This is
then used as the SID with which files and directories will be created in the
cache.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h |   13 +++++++++++++
 security/dummy.c         |    6 ++++++
 security/selinux/hooks.c |    8 ++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 63617e4..5913ae7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1259,6 +1259,7 @@ struct security_operations {
   	int (*inode_getsecurity)(const struct inode *inode, const char *name, void *buffer, size_t size, int err);
   	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
+	u32 (*inode_get_secid)(struct inode *inode);
 
 	int (*file_permission) (struct file * file, int mask);
 	int (*file_alloc_security) (struct file * file);
@@ -1821,6 +1822,13 @@ static inline int security_inode_listsec
 	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
 }
 
+static inline u32 security_inode_get_secid(struct inode *inode)
+{
+	if (unlikely(IS_PRIVATE(inode)))
+		return 0;
+	return security_ops->inode_get_secid(inode);
+}
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return security_ops->file_permission (file, mask);
@@ -2518,6 +2526,11 @@ static inline int security_inode_listsec
 	return 0;
 }
 
+static inline u32 security_inode_get_secid(struct inode *inode)
+{
+	return 0;
+}
+
 static inline int security_file_permission (struct file *file, int mask)
 {
 	return 0;
diff --git a/security/dummy.c b/security/dummy.c
index f7b47a9..3401ea3 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -392,6 +392,11 @@ static int dummy_inode_listsecurity(stru
 	return 0;
 }
 
+static u32 dummy_inode_get_secid(struct inode *inode)
+{
+	return 0;
+}
+
 static const char *dummy_inode_xattr_getsuffix(void)
 {
 	return NULL;
@@ -1039,6 +1044,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, inode_getsecurity);
 	set_to_dummy_if_null(ops, inode_setsecurity);
 	set_to_dummy_if_null(ops, inode_listsecurity);
+	set_to_dummy_if_null(ops, inode_get_secid);
 	set_to_dummy_if_null(ops, file_permission);
 	set_to_dummy_if_null(ops, file_alloc_security);
 	set_to_dummy_if_null(ops, file_free_security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 09def09..ddac1bc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2415,6 +2415,13 @@ static int selinux_inode_listsecurity(st
 	return len;
 }
 
+static u32 selinux_inode_get_secid(struct inode *inode)
+{
+	struct inode_security_struct *isec = inode->i_security;
+
+	return isec->sid;
+}
+
 /* file security operations */
 
 static int selinux_file_permission(struct file *file, int mask)
@@ -4690,6 +4697,7 @@ static struct security_operations selinu
 	.inode_getsecurity =            selinux_inode_getsecurity,
 	.inode_setsecurity =            selinux_inode_setsecurity,
 	.inode_listsecurity =           selinux_inode_listsecurity,
+	.inode_get_secid =		selinux_inode_get_secid,
 
 	.file_permission =		selinux_file_permission,
 	.file_alloc_security =		selinux_file_alloc_security,
