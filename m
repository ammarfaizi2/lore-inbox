Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVG0O4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVG0O4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVG0O4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:56:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262100AbVG0O4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:56:08 -0400
Date: Wed, 27 Jul 2005 10:56:03 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Darrel Goeddel <dgoeddel@TrustedCS.com>
Subject: [PATCH] SELinux: default labeling of MLS field 
Message-ID: <Lynx.SEL.4.62.0507271045170.551@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below implements kernel labeling of the MLS (multilevel 
security) field of security contexts for files which have no existing MLS 
field.  This is to enable upgrades of a system from non-MLS to MLS without 
performing a full filesystem relabel including all of the mountpoints, 
which would be quite painful for users.

With this patch, with MLS enabled, if a file has no MLS field, the kernel 
internally adds an MLS field to the in-core inode (but not to the on-disk 
file).  This MLS field added is the default for the superblock, allowing 
per-mountpoint control over the values via fixed policy or mount options.

This patch has been tested by enabling MLS without relabeling its 
filesystem, and seems to be working correctly.

Please apply.


Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c            |    3 +
 security/selinux/include/security.h |    2 +
 security/selinux/ss/mls.c           |   71 ++++++++++++++++++++++++------------
 security/selinux/ss/mls.h           |    4 +-
 security/selinux/ss/services.c      |   55 +++++++++++++++++++++------
 5 files changed, 97 insertions(+), 38 deletions(-)

---

diff -purN -X dontdiff linux-2.6.13-rc3-mm1.o/security/selinux/hooks.c linux-2.6.13-rc3-mm1.w/security/selinux/hooks.c
--- linux-2.6.13-rc3-mm1.o/security/selinux/hooks.c	2005-07-26 23:47:12.000000000 -0400
+++ linux-2.6.13-rc3-mm1.w/security/selinux/hooks.c	2005-07-27 09:18:13.000000000 -0400
@@ -826,7 +826,8 @@ static int inode_doinit_with_dentry(stru
 			sid = sbsec->def_sid;
 			rc = 0;
 		} else {
-			rc = security_context_to_sid(context, rc, &sid);
+			rc = security_context_to_sid_default(context, rc, &sid,
+			                                     sbsec->def_sid);
 			if (rc) {
 				printk(KERN_WARNING "%s:  context_to_sid(%s) "
 				       "returned %d for dev=%s ino=%ld\n",
diff -purN -X dontdiff linux-2.6.13-rc3-mm1.o/security/selinux/include/security.h linux-2.6.13-rc3-mm1.w/security/selinux/include/security.h
--- linux-2.6.13-rc3-mm1.o/security/selinux/include/security.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc3-mm1.w/security/selinux/include/security.h	2005-07-27 09:18:13.000000000 -0400
@@ -65,6 +65,8 @@ int security_sid_to_context(u32 sid, cha
 int security_context_to_sid(char *scontext, u32 scontext_len,
 	u32 *out_sid);
 
+int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *out_sid, u32 def_sid);
+
 int security_get_user_sids(u32 callsid, char *username,
 			   u32 **sids, u32 *nel);
 
diff -purN -X dontdiff linux-2.6.13-rc3-mm1.o/security/selinux/ss/mls.c linux-2.6.13-rc3-mm1.w/security/selinux/ss/mls.c
--- linux-2.6.13-rc3-mm1.o/security/selinux/ss/mls.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc3-mm1.w/security/selinux/ss/mls.c	2005-07-27 09:18:52.000000000 -0400
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include "sidtab.h"
 #include "mls.h"
 #include "policydb.h"
 #include "services.h"
@@ -208,6 +209,26 @@ int mls_context_isvalid(struct policydb 
 }
 
 /*
+ * Copies the MLS range from `src' into `dst'.
+ */
+static inline int mls_copy_context(struct context *dst,
+				   struct context *src)
+{
+	int l, rc = 0;
+
+	/* Copy the MLS range from the source context */
+	for (l = 0; l < 2; l++) {
+		dst->range.level[l].sens = src->range.level[l].sens;
+		rc = ebitmap_cpy(&dst->range.level[l].cat,
+				 &src->range.level[l].cat);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+/*
  * Set the MLS fields in the security context structure
  * `context' based on the string representation in
  * the string `*scontext'.  Update `*scontext' to
@@ -216,10 +237,20 @@ int mls_context_isvalid(struct policydb 
  *
  * This function modifies the string in place, inserting
  * NULL characters to terminate the MLS fields.
+ *
+ * If a def_sid is provided and no MLS field is present,
+ * copy the MLS field of the associated default context.
+ * Used for upgraded to MLS systems where objects may lack
+ * MLS fields.
+ *
+ * Policy read-lock must be held for sidtab lookup.
+ *
  */
 int mls_context_to_sid(char oldc,
 		       char **scontext,
-		       struct context *context)
+		       struct context *context,
+		       struct sidtab *s,
+		       u32 def_sid)
 {
 
 	char delim;
@@ -231,9 +262,23 @@ int mls_context_to_sid(char oldc,
 	if (!selinux_mls_enabled)
 		return 0;
 
-	/* No MLS component to the security context. */
-	if (!oldc)
+	/*
+	 * No MLS component to the security context, try and map to
+	 * default if provided.
+	 */
+	if (!oldc) {
+		struct context *defcon;
+
+		if (def_sid == SECSID_NULL)
+			goto out;
+		
+		defcon = sidtab_search(s, def_sid);
+		if (!defcon)
+			goto out;
+
+		rc = mls_copy_context(context, defcon);
 		goto out;
+	}
 
 	/* Extract low sensitivity. */
 	scontextp = p = *scontext;
@@ -334,26 +379,6 @@ out:
 }
 
 /*
- * Copies the MLS range from `src' into `dst'.
- */
-static inline int mls_copy_context(struct context *dst,
-				   struct context *src)
-{
-	int l, rc = 0;
-
-	/* Copy the MLS range from the source context */
-	for (l = 0; l < 2; l++) {
-		dst->range.level[l].sens = src->range.level[l].sens;
-		rc = ebitmap_cpy(&dst->range.level[l].cat,
-				 &src->range.level[l].cat);
-		if (rc)
-			break;
-	}
-
-	return rc;
-}
-
-/*
  * Copies the effective MLS range from `src' into `dst'.
  */
 static inline int mls_scopy_context(struct context *dst,
diff -purN -X dontdiff linux-2.6.13-rc3-mm1.o/security/selinux/ss/mls.h linux-2.6.13-rc3-mm1.w/security/selinux/ss/mls.h
--- linux-2.6.13-rc3-mm1.o/security/selinux/ss/mls.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc3-mm1.w/security/selinux/ss/mls.h	2005-07-27 09:18:13.000000000 -0400
@@ -23,7 +23,9 @@ int mls_context_isvalid(struct policydb 
 
 int mls_context_to_sid(char oldc,
 	               char **scontext,
-		       struct context *context);
+		       struct context *context,
+		       struct sidtab *s,
+		       u32 def_sid);
 
 int mls_convert_context(struct policydb *oldp,
 			struct policydb *newp,
diff -purN -X dontdiff linux-2.6.13-rc3-mm1.o/security/selinux/ss/services.c linux-2.6.13-rc3-mm1.w/security/selinux/ss/services.c
--- linux-2.6.13-rc3-mm1.o/security/selinux/ss/services.c	2005-07-26 23:47:12.000000000 -0400
+++ linux-2.6.13-rc3-mm1.w/security/selinux/ss/services.c	2005-07-27 09:18:13.000000000 -0400
@@ -601,18 +601,7 @@ out:
 
 }
 
-/**
- * security_context_to_sid - Obtain a SID for a given security context.
- * @scontext: security context
- * @scontext_len: length in bytes
- * @sid: security identifier, SID
- *
- * Obtains a SID associated with the security context that
- * has the string representation specified by @scontext.
- * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
- * memory is available, or 0 on success.
- */
-int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
+static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
 {
 	char *scontext2;
 	struct context context;
@@ -703,7 +692,7 @@ int security_context_to_sid(char *sconte
 
 	context.type = typdatum->value;
 
-	rc = mls_context_to_sid(oldc, &p, &context);
+	rc = mls_context_to_sid(oldc, &p, &context, &sidtab, def_sid);
 	if (rc)
 		goto out_unlock;
 
@@ -727,6 +716,46 @@ out:
 	return rc;
 }
 
+/**
+ * security_context_to_sid - Obtain a SID for a given security context.
+ * @scontext: security context
+ * @scontext_len: length in bytes
+ * @sid: security identifier, SID
+ *
+ * Obtains a SID associated with the security context that
+ * has the string representation specified by @scontext.
+ * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
+ * memory is available, or 0 on success.
+ */
+int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
+{
+	return security_context_to_sid_core(scontext, scontext_len,
+	                                    sid, SECSID_NULL);
+}
+
+/**
+ * security_context_to_sid_default - Obtain a SID for a given security context,
+ * falling back to specified default if needed.
+ *
+ * @scontext: security context
+ * @scontext_len: length in bytes
+ * @sid: security identifier, SID
+ * @def_sid: default SID to assign on errror
+ *
+ * Obtains a SID associated with the security context that
+ * has the string representation specified by @scontext.
+ * The default SID is passed to the MLS layer to be used to allow
+ * kernel labeling of the MLS field if the MLS field is not present
+ * (for upgrading to MLS without full relabel).
+ * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
+ * memory is available, or 0 on success.
+ */
+int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
+{
+	return security_context_to_sid_core(scontext, scontext_len,
+	                                    sid, def_sid);
+}
+
 static int compute_sid_handle_invalid_context(
 	struct context *scontext,
 	struct context *tcontext,
