Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755270AbWKMRE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbWKMRE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755280AbWKMRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:04:28 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:17642 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755248AbWKMRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:04:26 -0500
Date: Mon, 13 Nov 2006 12:04:24 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chad Sellers <csellers@tresys.com>
Subject: [PATCH 4/4] SELinux: validate kernel object classes and permissions
In-Reply-To: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
Message-ID: <XMMS.LNX.4.64.0611131203460.6437@d.namei>
References: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chad Sellers <csellers@tresys.com>

This is a new object class and permission validation scheme that validates
against the defined kernel headers. This scheme allows extra classes
and permissions that do not conflict with the kernel definitions to be
added to the policy. This validation is now done for all policy loads,
not just subsequent loads after the first policy load.

The implementation walks the three structrures containing the defined
object class and permission values and ensures their values are the
same in the policy being loaded. This includes verifying the object
classes themselves, the permissions they contain, and the permissions
they inherit from commons. Classes or permissions that are present in the
kernel but missing from the policy cause a warning (printed to KERN_INFO)
to be printed, but do not stop the policy from loading, emulating current
behavior. Any other inconsistencies cause the load to fail.

Signed-off-by: Chad Sellers <csellers@tresys.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/ss/services.c |  138 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 33ae102..4088204 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -17,9 +17,13 @@
  *
  *      Added support for NetLabel
  *
+ * Updated: Chad Sellers <csellers@tresys.com>
+ *
+ *  Added validation of kernel classes and permissions
+ *
  * Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
@@ -53,6 +57,11 @@ #include "selinux_netlabel.h"
 extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
 
+/*
+ * This is declared in avc.c
+ */
+extern const struct selinux_class_perm selinux_class_perm;
+
 static DEFINE_RWLOCK(policy_rwlock);
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
 #define POLICY_WRLOCK write_lock_irq(&policy_rwlock)
@@ -1018,6 +1027,115 @@ int security_change_sid(u32 ssid,
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
 }
 
+/*
+ * Verify that each kernel class that is defined in the
+ * policy is correct
+ */
+static int validate_classes(struct policydb *p)
+{
+	int i, j;
+	struct class_datum *cladatum;
+	struct perm_datum *perdatum;
+	u32 nprim, tmp, common_pts_len, perm_val, pol_val;
+	u16 class_val;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
+	const char *def_class, *def_perm, *pol_class;
+	struct symtab *perms;
+
+	for (i = 1; i < kdefs->cts_len; i++) {
+		def_class = kdefs->class_to_string[i];
+		if (i > p->p_classes.nprim) {
+			printk(KERN_INFO
+			       "security:  class %s not defined in policy\n",
+			       def_class);
+			continue;
+		}
+		pol_class = p->p_class_val_to_name[i-1];
+		if (strcmp(pol_class, def_class)) {
+			printk(KERN_ERR
+			       "security:  class %d is incorrect, found %s but should be %s\n",
+			       i, pol_class, def_class);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < kdefs->av_pts_len; i++) {
+		class_val = kdefs->av_perm_to_string[i].tclass;
+		perm_val = kdefs->av_perm_to_string[i].value;
+		def_perm = kdefs->av_perm_to_string[i].name;
+		if (class_val > p->p_classes.nprim)
+			continue;
+		pol_class = p->p_class_val_to_name[class_val-1];
+		cladatum = hashtab_search(p->p_classes.table, pol_class);
+		BUG_ON(!cladatum);
+		perms = &cladatum->permissions;
+		nprim = 1 << (perms->nprim - 1);
+		if (perm_val > nprim) {
+			printk(KERN_INFO
+			       "security:  permission %s in class %s not defined in policy\n",
+			       def_perm, pol_class);
+			continue;
+		}
+		perdatum = hashtab_search(perms->table, def_perm);
+		if (perdatum == NULL) {
+			printk(KERN_ERR
+			       "security:  permission %s in class %s not found in policy\n",
+			       def_perm, pol_class);
+			return -EINVAL;
+		}
+		pol_val = 1 << (perdatum->value - 1);
+		if (pol_val != perm_val) {
+			printk(KERN_ERR
+			       "security:  permission %s in class %s has incorrect value\n",
+			       def_perm, pol_class);
+			return -EINVAL;
+		}
+	}
+	for (i = 0; i < kdefs->av_inherit_len; i++) {
+		class_val = kdefs->av_inherit[i].tclass;
+		if (class_val > p->p_classes.nprim)
+			continue;
+		pol_class = p->p_class_val_to_name[class_val-1];
+		cladatum = hashtab_search(p->p_classes.table, pol_class);
+		BUG_ON(!cladatum);
+		if (!cladatum->comdatum) {
+			printk(KERN_ERR
+			       "security:  class %s should have an inherits clause but does not\n",
+			       pol_class);
+			return -EINVAL;
+		}
+		tmp = kdefs->av_inherit[i].common_base;
+		common_pts_len = 0;
+		while (!(tmp & 0x01)) {
+			common_pts_len++;
+			tmp >>= 1;
+		}
+		perms = &cladatum->comdatum->permissions;
+		for (j = 0; j < common_pts_len; j++) {
+			def_perm = kdefs->av_inherit[i].common_pts[j];
+			if (j >= perms->nprim) {
+				printk(KERN_INFO
+				       "security:  permission %s in class %s not defined in policy\n",
+				       def_perm, pol_class);
+				continue;
+			}
+			perdatum = hashtab_search(perms->table, def_perm);
+			if (perdatum == NULL) {
+				printk(KERN_ERR
+				       "security:  permission %s in class %s not found in policy\n",
+				       def_perm, pol_class);
+				return -EINVAL;
+			}
+			if (perdatum->value != j + 1) {
+				printk(KERN_ERR
+				       "security:  permission %s in class %s has incorrect value\n",
+				       def_perm, pol_class);
+				return -EINVAL;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Clone the SID into the new SID table. */
 static int clone_sid(u32 sid,
 		     struct context *context,
@@ -1160,6 +1278,16 @@ int security_load_policy(void *data, siz
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
+		/* Verify that the kernel defined classes are correct. */
+		if (validate_classes(&policydb)) {
+			printk(KERN_ERR
+			       "security:  the definition of a class is incorrect\n");
+			LOAD_UNLOCK;
+			sidtab_destroy(&sidtab);
+			policydb_destroy(&policydb);
+			avtab_cache_destroy();
+			return -EINVAL;
+		}
 		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
@@ -1182,6 +1310,14 @@ #endif
 
 	sidtab_init(&newsidtab);
 
+	/* Verify that the kernel defined classes are correct. */
+	if (validate_classes(&newpolicydb)) {
+		printk(KERN_ERR
+		       "security:  the definition of a class is incorrect\n");
+		rc = -EINVAL;
+		goto err;
+	}
+
 	/* Clone the SID table. */
 	sidtab_shutdown(&sidtab);
 	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
-- 
1.4.2.1

