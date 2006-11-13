Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755228AbWKMRCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbWKMRCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbWKMRCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:02:13 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:10403 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755228AbWKMRCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:02:10 -0500
Date: Mon, 13 Nov 2006 12:02:07 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chad Sellers <csellers@tresys.com>
Subject: [PATCH 1/4] SELinux: remove current object class and permission
 validation mechanism
In-Reply-To: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
Message-ID: <XMMS.LNX.4.64.0611131201230.6437@d.namei>
References: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the current SELinux object class and permission validation code,
as the current code makes it impossible to change or remove object classes
and permissions on a running system. Additionally, the current code does
not actually validate that the classes and permissions are correct, but
instead merely validates that they do not change between policy reloads.

Signed-off-by: Chad Sellers <csellers@tresys.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/ss/services.c |   91 ----------------------------------------
 1 files changed, 0 insertions(+), 91 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index bfe1227..33ae102 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1018,89 +1018,6 @@ int security_change_sid(u32 ssid,
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
 }
 
-/*
- * Verify that each permission that is defined under the
- * existing policy is still defined with the same value
- * in the new policy.
- */
-static int validate_perm(void *key, void *datum, void *p)
-{
-	struct hashtab *h;
-	struct perm_datum *perdatum, *perdatum2;
-	int rc = 0;
-
-
-	h = p;
-	perdatum = datum;
-
-	perdatum2 = hashtab_search(h, key);
-	if (!perdatum2) {
-		printk(KERN_ERR "security:  permission %s disappeared",
-		       (char *)key);
-		rc = -ENOENT;
-		goto out;
-	}
-	if (perdatum->value != perdatum2->value) {
-		printk(KERN_ERR "security:  the value of permission %s changed",
-		       (char *)key);
-		rc = -EINVAL;
-	}
-out:
-	return rc;
-}
-
-/*
- * Verify that each class that is defined under the
- * existing policy is still defined with the same
- * attributes in the new policy.
- */
-static int validate_class(void *key, void *datum, void *p)
-{
-	struct policydb *newp;
-	struct class_datum *cladatum, *cladatum2;
-	int rc;
-
-	newp = p;
-	cladatum = datum;
-
-	cladatum2 = hashtab_search(newp->p_classes.table, key);
-	if (!cladatum2) {
-		printk(KERN_ERR "security:  class %s disappeared\n",
-		       (char *)key);
-		rc = -ENOENT;
-		goto out;
-	}
-	if (cladatum->value != cladatum2->value) {
-		printk(KERN_ERR "security:  the value of class %s changed\n",
-		       (char *)key);
-		rc = -EINVAL;
-		goto out;
-	}
-	if ((cladatum->comdatum && !cladatum2->comdatum) ||
-	    (!cladatum->comdatum && cladatum2->comdatum)) {
-		printk(KERN_ERR "security:  the inherits clause for the access "
-		       "vector definition for class %s changed\n", (char *)key);
-		rc = -EINVAL;
-		goto out;
-	}
-	if (cladatum->comdatum) {
-		rc = hashtab_map(cladatum->comdatum->permissions.table, validate_perm,
-		                 cladatum2->comdatum->permissions.table);
-		if (rc) {
-			printk(" in the access vector definition for class "
-			       "%s\n", (char *)key);
-			goto out;
-		}
-	}
-	rc = hashtab_map(cladatum->permissions.table, validate_perm,
-	                 cladatum2->permissions.table);
-	if (rc)
-		printk(" in access vector definition for class %s\n",
-		       (char *)key);
-out:
-	return rc;
-}
-
 /* Clone the SID into the new SID table. */
 static int clone_sid(u32 sid,
 		     struct context *context,
@@ -1265,14 +1182,6 @@ #endif
 
 	sidtab_init(&newsidtab);
 
-	/* Verify that the existing classes did not change. */
-	if (hashtab_map(policydb.p_classes.table, validate_class, &newpolicydb)) {
-		printk(KERN_ERR "security:  the definition of an existing "
-		       "class changed\n");
-		rc = -EINVAL;
-		goto err;
-	}
-
 	/* Clone the SID table. */
 	sidtab_shutdown(&sidtab);
 	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
-- 
1.4.2.1

