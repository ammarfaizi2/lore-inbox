Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTHZN6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTHZN5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:57:10 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:26287 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262690AbTHZN4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:56:21 -0400
Subject: [PATCH] Rework SELinux binprm hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061906171.23880.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2003 09:56:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the SELinux binprm hook functions to use a security
structure for the linux_binprm rather than directly stuffing the
security identifier into the void* security field.  It also performs
some cleanup of the SELinux binprm hook functions, and one miscellaneous fix.

 security/selinux/hooks.c          |   61 ++++++++++++++++----------------------
 security/selinux/include/objsec.h |    8 ++++
 2 files changed, 34 insertions(+), 35 deletions(-)

Index: linux-2.5/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.5/security/selinux/hooks.c,v
retrieving revision 1.70
diff -u -r1.70 hooks.c
--- linux-2.5/security/selinux/hooks.c	26 Aug 2003 13:08:31 -0000	1.70
+++ linux-2.5/security/selinux/hooks.c	26 Aug 2003 13:31:59 -0000
@@ -1332,31 +1332,19 @@
 
 static int selinux_bprm_alloc_security(struct linux_binprm *bprm)
 {
-	int rc;
+	struct bprm_security_struct *bsec;
 
-	/* Make sure that the secondary module doesn't use the
-	   bprm->security field, since we do not yet support chaining
-	   of multiple security structures on the field.  Neither
-	   the dummy nor the capability module use the field.  The owlsm
-	   module uses the field if CONFIG_OWLSM_FD is enabled. */
-	rc = secondary_ops->bprm_alloc_security(bprm);
-	if (rc)
-		return rc;
-	if (bprm->security) {
-		printk(KERN_WARNING "%s: no support yet for chaining on the "
-		       "security field by secondary modules.\n", __FUNCTION__);
-		/* Release the secondary module's security object. */
-		secondary_ops->bprm_free_security(bprm);
-		/* Unregister the secondary module to prevent problems
-		   with subsequent binprm hooks. This will revert to the
-		   original (dummy) module for the secondary operations. */
-		rc = security_ops->unregister_security("unknown", secondary_ops);
-		if (rc)
-			return rc;
-		printk(KERN_WARNING "%s: Unregistered the secondary security "
-		       "module.\n", __FUNCTION__);
-	}
-	bprm->security = NULL;
+	bsec = kmalloc(sizeof(struct bprm_security_struct), GFP_KERNEL);
+	if (!bsec)
+		return -ENOMEM;
+
+	memset(bsec, 0, sizeof *bsec);
+	bsec->magic = SELINUX_MAGIC;
+	bsec->bprm = bprm;
+	bsec->sid = SECINITSID_UNLABELED;
+	bsec->set = 0;
+
+	bprm->security = bsec;
 	return 0;
 }
 
@@ -1365,6 +1353,7 @@
 	struct task_security_struct *tsec;
 	struct inode *inode = bprm->file->f_dentry->d_inode;
 	struct inode_security_struct *isec;
+	struct bprm_security_struct *bsec;
 	u32 newsid;
 	struct avc_audit_data ad;
 	int rc;
@@ -1373,15 +1362,16 @@
 	if (rc)
 		return rc;
 
-	if (bprm->sh_bang || bprm->security)
-		/* The security field should already be set properly. */
+	bsec = bprm->security;
+
+	if (bsec->set)
 		return 0;
 
 	tsec = current->security;
 	isec = inode->i_security;
 
 	/* Default to the current task SID. */
-	bprm->security = (void *)tsec->sid;
+	bsec->sid = tsec->sid;
 
 	/* Reset create SID on execve. */
 	tsec->create_sid = 0;
@@ -1427,9 +1417,10 @@
 			return rc;
 
 		/* Set the security field to the new SID. */
-		bprm->security = (void*) newsid;
+		bsec->sid = newsid;
 	}
 
+	bsec->set = 1;
 	return 0;
 }
 
@@ -1463,8 +1454,9 @@
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
 {
-	/* Nothing to do - not dynamically allocated. */
-	return;
+	struct bprm_security_struct *bsec = bprm->security;
+	bprm->security = NULL;
+	kfree(bsec);
 }
 
 /* Derived from fs/exec.c:flush_old_files. */
@@ -1509,6 +1501,7 @@
 static void selinux_bprm_compute_creds(struct linux_binprm *bprm)
 {
 	struct task_security_struct *tsec, *psec;
+	struct bprm_security_struct *bsec;
 	u32 sid;
 	struct av_decision avd;
 	int rc;
@@ -1517,9 +1510,8 @@
 
 	tsec = current->security;
 
-	sid = (u32)bprm->security;
-	if (!sid)
-		sid = tsec->sid;
+	bsec = bprm->security;
+	sid = bsec->sid;
 
 	tsec->osid = tsec->sid;
 	if (tsec->sid != sid) {
@@ -3114,9 +3106,8 @@
 			       char *name, void *value, size_t size)
 {
 	struct task_security_struct *tsec;
-	u32 sid;
+	u32 sid, len;
 	char *context;
-	size_t len;
 	int error;
 
 	if (current != p) {
Index: linux-2.5/security/selinux/include/objsec.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.5/security/selinux/include/objsec.h,v
retrieving revision 1.10
diff -u -r1.10 objsec.h
--- linux-2.5/security/selinux/include/objsec.h	13 Aug 2003 18:12:23 -0000	1.10
+++ linux-2.5/security/selinux/include/objsec.h	26 Aug 2003 13:31:59 -0000
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/binfmts.h>
 #include <linux/in.h>
 #include "flask.h"
 #include "avc.h"
@@ -83,6 +84,13 @@
 	u16 sclass;	/* security class of this object */
 	u32 sid;              /* SID of IPC resource */
         struct avc_entry_ref avcr;	/* reference to permissions */
+};
+
+struct bprm_security_struct {
+	unsigned long magic;           /* magic number for this module */
+	struct linux_binprm *bprm;     /* back pointer to bprm object */
+	u32 sid;                       /* SID for transformed process */
+	unsigned char set;             
 };
 
 extern int inode_security_set_sid(struct inode *inode, u32 sid);


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

