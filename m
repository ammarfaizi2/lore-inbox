Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCGRyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCGRyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCGRyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:54:40 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:38345 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261195AbVCGRut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:50:49 -0500
Subject: [PATCH][SELINUX] Enhanced MLS support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Darrel Goeddel <dgoeddel@trustedcs.com>, Chris Wright <chrisw@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 07 Mar 2005 12:42:58 -0500
Message-Id: <1110217378.2778.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-mm1 replaces the original experimental Multi-Level
Security (MLS) implementation in SELinux with an enhanced MLS implementation
contributed by Trusted Computer Solutions (TCS).  The enhanced MLS 
implementation replaces the hardcoded MLS logic with a flexible 
constraint-based system and replaces the compile-time option for MLS support
with a policy load-time enable based on whether MLS support was enabled in
the policy when it was built.  The latter change allows a single kernel and 
policy toolchain to support both MLS and non-MLS policies.  Compatibility is 
still provided as usual for existing policies.  Please apply.

Author:  Darrel Goeddel <dgoeddel@trustedcs.com>
Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/Kconfig            |    9 
 security/selinux/hooks.c            |    7 
 security/selinux/include/security.h |   13 
 security/selinux/ss/Makefile        |    4 
 security/selinux/ss/constraint.h    |    7 
 security/selinux/ss/context.h       |   30 -
 security/selinux/ss/mls.c           |  726 ++++++++++++------------------------
 security/selinux/ss/mls.h           |   79 ---
 security/selinux/ss/mls_types.h     |   76 +--
 security/selinux/ss/policydb.c      |  575 ++++++++++++++++++++++------
 security/selinux/ss/policydb.h      |   58 +-
 security/selinux/ss/services.c      |  268 ++++++++++---
 12 files changed, 1014 insertions(+), 838 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/hooks.c linux-2.6.11-mm1-mls/security/selinux/hooks.c
--- linux-2.6.11-mm1/security/selinux/hooks.c	2005-03-07 11:21:12.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/hooks.c	2005-03-07 11:13:56.000000000 -0500
@@ -10,6 +10,8 @@
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ *                          <dgoeddel@trustedcs.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
@@ -2210,6 +2212,11 @@ static int selinux_inode_setxattr(struct
 	if (rc)
 		return rc;
 
+	rc = security_validate_transition(isec->sid, newsid, tsec->sid,
+	                                  isec->sclass);
+	if (rc)
+		return rc;
+
 	return avc_has_perm(newsid,
 			    sbsec->sid,
 			    SECCLASS_FILESYSTEM,
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/include/security.h linux-2.6.11-mm1-mls/security/selinux/include/security.h
--- linux-2.6.11-mm1/security/selinux/include/security.h	2005-03-02 02:37:47.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/include/security.h	2005-03-07 11:13:56.000000000 -0500
@@ -21,10 +21,12 @@
 #define POLICYDB_VERSION_BOOL		16
 #define POLICYDB_VERSION_IPV6		17
 #define POLICYDB_VERSION_NLCLASS	18
+#define POLICYDB_VERSION_VALIDATETRANS	19
+#define POLICYDB_VERSION_MLS		19
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_NLCLASS
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_MLS
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
@@ -32,11 +34,7 @@ extern int selinux_enabled;
 #define selinux_enabled 1
 #endif
 
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-#define selinux_mls_enabled 1
-#else
-#define selinux_mls_enabled 0
-#endif
+extern int selinux_mls_enabled;
 
 int security_load_policy(void * data, size_t len);
 
@@ -79,6 +77,9 @@ int security_netif_sid(char *name, u32 *
 int security_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
 
+int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
+                                 u16 tclass);
+
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
 #define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/Kconfig linux-2.6.11-mm1-mls/security/selinux/Kconfig
--- linux-2.6.11-mm1/security/selinux/Kconfig	2005-03-02 02:37:48.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/Kconfig	2005-03-07 11:13:56.000000000 -0500
@@ -76,12 +76,3 @@ config SECURITY_SELINUX_AVC_STATS
 	  /selinux/avc/cache_stats, which may be monitored via
 	  tools such as avcstat.
 
-config SECURITY_SELINUX_MLS
-	bool "NSA SELinux MLS policy (EXPERIMENTAL)"
-	depends on SECURITY_SELINUX && EXPERIMENTAL
-	default n
-	help
-	  This enables the NSA SELinux Multi-Level Security (MLS) policy in
-	  addition to the default RBAC/TE policy.  This policy is
-	  experimental and has not been configured for use.  Unless you
-	  specifically want to experiment with MLS, say N.
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/constraint.h linux-2.6.11-mm1-mls/security/selinux/ss/constraint.h
--- linux-2.6.11-mm1/security/selinux/ss/constraint.h	2005-03-02 02:38:10.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/constraint.h	2005-03-07 11:13:56.000000000 -0500
@@ -31,6 +31,13 @@ struct constraint_expr {
 #define CEXPR_ROLE 2		/* role */
 #define CEXPR_TYPE 4		/* type */
 #define CEXPR_TARGET 8		/* target if set, source otherwise */
+#define CEXPR_XTARGET 16	/* special 3rd target for validatetrans rule */
+#define CEXPR_L1L2 32		/* low level 1 vs. low level 2 */
+#define CEXPR_L1H2 64		/* low level 1 vs. high level 2 */
+#define CEXPR_H1L2 128		/* high level 1 vs. low level 2 */
+#define CEXPR_H1H2 256		/* high level 1 vs. high level 2 */
+#define CEXPR_L1H1 512		/* low level 1 vs. high level 1 */
+#define CEXPR_L2H2 1024		/* low level 2 vs. high level 2 */
 	u32 attr;		/* attribute */
 
 #define CEXPR_EQ     1		/* == or eq */
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/context.h linux-2.6.11-mm1-mls/security/selinux/ss/context.h
--- linux-2.6.11-mm1/security/selinux/ss/context.h	2005-03-02 02:38:25.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/context.h	2005-03-07 11:13:56.000000000 -0500
@@ -17,6 +17,7 @@
 
 #include "ebitmap.h"
 #include "mls_types.h"
+#include "security.h"
 
 /*
  * A security context consists of an authenticated user
@@ -26,13 +27,9 @@ struct context {
 	u32 user;
 	u32 role;
 	u32 type;
-#ifdef CONFIG_SECURITY_SELINUX_MLS
 	struct mls_range range;
-#endif
 };
 
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-
 static inline void mls_context_init(struct context *c)
 {
 	memset(&c->range, 0, sizeof(c->range));
@@ -42,6 +39,9 @@ static inline int mls_context_cpy(struct
 {
 	int rc;
 
+	if (!selinux_mls_enabled)
+		return 0;
+
 	dst->range.level[0].sens = src->range.level[0].sens;
 	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
 	if (rc)
@@ -57,6 +57,9 @@ out:
 
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
+	if (!selinux_mls_enabled)
+		return 1;
+
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
 		ebitmap_cmp(&c1->range.level[0].cat,&c2->range.level[0].cat) &&
 		(c1->range.level[1].sens == c2->range.level[1].sens) &&
@@ -65,27 +68,14 @@ static inline int mls_context_cmp(struct
 
 static inline void mls_context_destroy(struct context *c)
 {
+	if (!selinux_mls_enabled)
+		return;
+
 	ebitmap_destroy(&c->range.level[0].cat);
 	ebitmap_destroy(&c->range.level[1].cat);
 	mls_context_init(c);
 }
 
-#else
-
-static inline void mls_context_init(struct context *c)
-{ }
-
-static inline int mls_context_cpy(struct context *dst, struct context *src)
-{ return 0; }
-
-static inline int mls_context_cmp(struct context *c1, struct context *c2)
-{ return 1; }
-
-static inline void mls_context_destroy(struct context *c)
-{ }
-
-#endif
-
 static inline void context_init(struct context *c)
 {
 	memset(c, 0, sizeof(*c));
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/Makefile linux-2.6.11-mm1-mls/security/selinux/ss/Makefile
--- linux-2.6.11-mm1/security/selinux/ss/Makefile	2005-03-02 02:37:31.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/Makefile	2005-03-07 11:13:56.000000000 -0500
@@ -5,7 +5,5 @@
 EXTRA_CFLAGS += -Isecurity/selinux/include
 obj-y := ss.o
 
-ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o
-
-ss-$(CONFIG_SECURITY_SELINUX_MLS) += mls.o
+ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/mls.c linux-2.6.11-mm1-mls/security/selinux/ss/mls.c
--- linux-2.6.11-mm1/security/selinux/ss/mls.c	2005-03-02 02:38:37.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/mls.c	2005-03-07 11:17:14.000000000 -0500
@@ -3,6 +3,14 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+/*
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *
+ *	Support for enhanced MLS infrastructure.
+ *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -12,79 +20,47 @@
 #include "services.h"
 
 /*
- * Remove any permissions from `allowed' that are
- * denied by the MLS policy.
- */
-void mls_compute_av(struct context *scontext,
-		    struct context *tcontext,
-		    struct class_datum *tclass,
-		    u32 *allowed)
-{
-	unsigned int rel[2];
-	int l;
-
-	for (l = 0; l < 2; l++)
-		rel[l] = mls_level_relation(scontext->range.level[l],
-					    tcontext->range.level[l]);
-
-	if (rel[1] != MLS_RELATION_EQ) {
-		if (rel[1] != MLS_RELATION_DOM &&
-		    !ebitmap_get_bit(&policydb.trustedreaders, scontext->type - 1) &&
-		    !ebitmap_get_bit(&policydb.trustedobjects, tcontext->type - 1)) {
-			/* read(s,t) = (s.high >= t.high) = False */
-			*allowed = (*allowed) & ~(tclass->mlsperms.read);
-		}
-		if (rel[1] != MLS_RELATION_DOMBY &&
-		    !ebitmap_get_bit(&policydb.trustedreaders, tcontext->type - 1) &&
-		    !ebitmap_get_bit(&policydb.trustedobjects, scontext->type - 1)) {
-			/* readby(s,t) = read(t,s) = False */
-			*allowed = (*allowed) & ~(tclass->mlsperms.readby);
-		}
-	}
-	if (((rel[0] != MLS_RELATION_DOMBY && rel[0] != MLS_RELATION_EQ) ||
-	    ((!mls_level_eq(tcontext->range.level[0],
-			    tcontext->range.level[1])) &&
-	     (rel[1] != MLS_RELATION_DOM && rel[1] != MLS_RELATION_EQ))) &&
-	    !ebitmap_get_bit(&policydb.trustedwriters, scontext->type - 1) &&
-	    !ebitmap_get_bit(&policydb.trustedobjects, tcontext->type - 1)) {
-		/*
-		 * write(s,t) = ((s.low <= t.low = t.high) or (s.low
-		 * <= t.low <= t.high <= s.high)) = False
-		 */
-		*allowed = (*allowed) & ~(tclass->mlsperms.write);
-	}
-
-	if (((rel[0] != MLS_RELATION_DOM && rel[0] != MLS_RELATION_EQ) ||
-	    ((!mls_level_eq(scontext->range.level[0],
-			    scontext->range.level[1])) &&
-	     (rel[1] != MLS_RELATION_DOMBY && rel[1] != MLS_RELATION_EQ))) &&
-	    !ebitmap_get_bit(&policydb.trustedwriters, tcontext->type - 1) &&
-	    !ebitmap_get_bit(&policydb.trustedobjects, scontext->type - 1)) {
-		/* writeby(s,t) = write(t,s) = False */
-		*allowed = (*allowed) & ~(tclass->mlsperms.writeby);
-	}
-}
-
-/*
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
  */
 int mls_compute_context_len(struct context * context)
 {
-	int i, l, len;
+	int i, l, len, range;
 
+	if (!selinux_mls_enabled)
+		return 0;
 
-	len = 0;
+	len = 1; /* for the beginning ":" */
 	for (l = 0; l < 2; l++) {
-		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]) + 1;
+		range = 0;
+		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 
-		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++)
-			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1))
-				len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
+		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++) {
+			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
+				if (range) {
+					range++;
+					continue;
+				}
 
-		if (mls_level_relation(context->range.level[0], context->range.level[1])
-				== MLS_RELATION_EQ)
-			break;
+				len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
+				range++;
+			} else {
+				if (range > 1)
+					len += strlen(policydb.p_cat_val_to_name[i - 2]) + 1;
+				range = 0;
+			}
+		}
+		/* Handle case where last category is the end of range */
+		if (range > 1)
+			len += strlen(policydb.p_cat_val_to_name[i - 2]) + 1;
+
+		if (l == 0) {
+			if (mls_level_eq(&context->range.level[0],
+			                 &context->range.level[1]))
+				break;
+			else
+				len++;
+		}
 	}
 
 	return len;
@@ -95,40 +71,81 @@ int mls_compute_context_len(struct conte
  * the MLS fields of `context' into the string `*scontext'.
  * Update `*scontext' to point to the end of the MLS fields.
  */
-int mls_sid_to_context(struct context *context,
-		       char **scontext)
+void mls_sid_to_context(struct context *context,
+                        char **scontext)
 {
 	char *scontextp;
-	int i, l;
+	int i, l, range, wrote_sep;
+
+	if (!selinux_mls_enabled)
+		return;
 
 	scontextp = *scontext;
 
+	*scontextp = ':';
+	scontextp++;
+
 	for (l = 0; l < 2; l++) {
+		range = 0;
+		wrote_sep = 0;
 		strcpy(scontextp,
 		       policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 		scontextp += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
-		*scontextp = ':';
-		scontextp++;
-		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++)
+
+		/* categories */
+		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++) {
 			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
+				if (range) {
+					range++;
+					continue;
+				}
+
+				if (!wrote_sep) {
+					*scontextp++ = ':';
+					wrote_sep = 1;
+				} else
+					*scontextp++ = ',';
 				strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
 				scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
-				*scontextp = ',';
-				scontextp++;
+				range++;
+			} else {
+				if (range > 1) {
+					if (range > 2)
+						*scontextp++ = '.';
+					else
+						*scontextp++ = ',';
+
+					strcpy(scontextp, policydb.p_cat_val_to_name[i - 2]);
+					scontextp += strlen(policydb.p_cat_val_to_name[i - 2]);
+				}
+				range = 0;
 			}
-		if (mls_level_relation(context->range.level[0], context->range.level[1])
-				!= MLS_RELATION_EQ) {
-			scontextp--;
-			sprintf(scontextp, "-");
-			scontextp++;
+		}
 
-		} else {
-			break;
+		/* Handle case where last category is the end of range */
+		if (range > 1) {
+			if (range > 2)
+				*scontextp++ = '.';
+			else
+				*scontextp++ = ',';
+
+			strcpy(scontextp, policydb.p_cat_val_to_name[i - 2]);
+			scontextp += strlen(policydb.p_cat_val_to_name[i - 2]);
+		}
+
+		if (l == 0) {
+			if (mls_level_eq(&context->range.level[0],
+			                 &context->range.level[1]))
+				break;
+			else {
+				*scontextp = '-';
+				scontextp++;
+			}
 		}
 	}
 
 	*scontext = scontextp;
-	return 0;
+	return;
 }
 
 /*
@@ -137,20 +154,19 @@ int mls_sid_to_context(struct context *c
  */
 int mls_context_isvalid(struct policydb *p, struct context *c)
 {
-	unsigned int relation;
 	struct level_datum *levdatum;
 	struct user_datum *usrdatum;
-	struct mls_range_list *rnode;
 	int i, l;
 
+	if (!selinux_mls_enabled)
+		return 1;
+
 	/*
 	 * MLS range validity checks: high must dominate low, low level must
 	 * be valid (category set <-> sensitivity check), and high level must
 	 * be valid (category set <-> sensitivity check)
 	 */
-	relation = mls_level_relation(c->range.level[1],
-				      c->range.level[0]);
-	if (!(relation & (MLS_RELATION_DOM | MLS_RELATION_EQ)))
+	if (!mls_level_dom(&c->range.level[1], &c->range.level[0]))
 		/* High does not dominate low. */
 		return 0;
 
@@ -185,18 +201,12 @@ int mls_context_isvalid(struct policydb 
 	if (!c->user || c->user > p->p_users.nprim)
 		return 0;
 	usrdatum = p->user_val_to_struct[c->user - 1];
-	for (rnode = usrdatum->ranges; rnode; rnode = rnode->next) {
-		if (mls_range_contains(rnode->range, c->range))
-			break;
-	}
-	if (!rnode)
-		/* user may not be associated with range */
-		return 0;
+	if (!mls_range_contains(usrdatum->range, c->range))
+		return 0; /* user may not be associated with range */
 
 	return 1;
 }
 
-
 /*
  * Set the MLS fields in the security context structure
  * `context' based on the string representation in
@@ -213,23 +223,17 @@ int mls_context_to_sid(char oldc,
 {
 
 	char delim;
-	char *scontextp, *p;
+	char *scontextp, *p, *rngptr;
 	struct level_datum *levdatum;
-	struct cat_datum *catdatum;
+	struct cat_datum *catdatum, *rngdatum;
 	int l, rc = -EINVAL;
 
-	if (!oldc) {
-		/* No MLS component to the security context.  Try
-		   to use a default 'unclassified' value. */
-		levdatum = hashtab_search(policydb.p_levels.table,
-		                          "unclassified");
-		if (!levdatum)
-			goto out;
-		context->range.level[0].sens = levdatum->level->sens;
-		context->range.level[1].sens = context->range.level[0].sens;
-		rc = 0;
+	if (!selinux_mls_enabled)
+		return 0;
+
+	/* No MLS component to the security context. */
+	if (!oldc)
 		goto out;
-	}
 
 	/* Extract low sensitivity. */
 	scontextp = p = *scontext;
@@ -242,13 +246,15 @@ int mls_context_to_sid(char oldc,
 
 	for (l = 0; l < 2; l++) {
 		levdatum = hashtab_search(policydb.p_levels.table, scontextp);
-		if (!levdatum)
+		if (!levdatum) {
+			rc = -EINVAL;
 			goto out;
+		}
 
 		context->range.level[l].sens = levdatum->level->sens;
 
 		if (delim == ':') {
-			/* Extract low category set. */
+			/* Extract category set. */
 			while (1) {
 				scontextp = p;
 				while (*p && *p != ',' && *p != '-')
@@ -257,15 +263,46 @@ int mls_context_to_sid(char oldc,
 				if (delim != 0)
 					*p++ = 0;
 
+				/* Separate into range if exists */
+				if ((rngptr = strchr(scontextp, '.')) != NULL) {
+					/* Remove '.' */
+					*rngptr++ = 0;
+				}
+
 				catdatum = hashtab_search(policydb.p_cats.table,
 				                          scontextp);
-				if (!catdatum)
+				if (!catdatum) {
+					rc = -EINVAL;
 					goto out;
+				}
 
 				rc = ebitmap_set_bit(&context->range.level[l].cat,
 				                     catdatum->value - 1, 1);
 				if (rc)
 					goto out;
+				
+				/* If range, set all categories in range */
+				if (rngptr) {
+					int i;
+
+					rngdatum = hashtab_search(policydb.p_cats.table, rngptr);
+					if (!rngdatum) {
+						rc = -EINVAL;
+						goto out;
+					}
+
+					if (catdatum->value >= rngdatum->value) {
+						rc = -EINVAL;
+						goto out;
+					}
+
+					for (i = catdatum->value; i < rngdatum->value; i++) {
+						rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
+						if (rc)
+							goto out;
+					}
+				}
+
 				if (delim != ',')
 					break;
 			}
@@ -306,7 +343,6 @@ static inline int mls_copy_context(struc
 
 	/* Copy the MLS range from the source context */
 	for (l = 0; l < 2; l++) {
-
 		dst->range.level[l].sens = src->range.level[l].sens;
 		rc = ebitmap_cpy(&dst->range.level[l].cat,
 				 &src->range.level[l].cat);
@@ -318,6 +354,84 @@ static inline int mls_copy_context(struc
 }
 
 /*
+ * Copies the effective MLS range from `src' into `dst'.
+ */
+static inline int mls_scopy_context(struct context *dst,
+                                    struct context *src)
+{
+	int l, rc = 0;
+
+	/* Copy the MLS range from the source context */
+	for (l = 0; l < 2; l++) {
+		dst->range.level[l].sens = src->range.level[0].sens;
+		rc = ebitmap_cpy(&dst->range.level[l].cat,
+				 &src->range.level[0].cat);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+/*
+ * Copies the MLS range `range' into `context'.
+ */
+static inline int mls_range_set(struct context *context,
+                                struct mls_range *range)
+{
+	int l, rc = 0;
+
+	/* Copy the MLS range into the  context */
+	for (l = 0; l < 2; l++) {
+		context->range.level[l].sens = range->level[l].sens;
+		rc = ebitmap_cpy(&context->range.level[l].cat,
+				 &range->level[l].cat);
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
+                         struct context *usercon)
+{
+	if (selinux_mls_enabled) {
+		struct mls_level *fromcon_sen = &(fromcon->range.level[0]);
+		struct mls_level *fromcon_clr = &(fromcon->range.level[1]);
+		struct mls_level *user_low = &(user->range.level[0]);
+		struct mls_level *user_clr = &(user->range.level[1]);
+		struct mls_level *user_def = &(user->dfltlevel);
+		struct mls_level *usercon_sen = &(usercon->range.level[0]);
+		struct mls_level *usercon_clr = &(usercon->range.level[1]);
+
+		/* Honor the user's default level if we can */
+		if (mls_level_between(user_def, fromcon_sen, fromcon_clr)) {
+			*usercon_sen = *user_def;
+		} else if (mls_level_between(fromcon_sen, user_def, user_clr)) {
+			*usercon_sen = *fromcon_sen;
+		} else if (mls_level_between(fromcon_clr, user_low, user_def)) {
+			*usercon_sen = *user_low;
+		} else
+			return -EINVAL;
+
+		/* Lower the clearance of available contexts
+		   if the clearance of "fromcon" is lower than
+		   that of the user's default clearance (but
+		   only if the "fromcon" clearance dominates
+		   the user's computed sensitivity level) */
+		if (mls_level_dom(user_clr, fromcon_clr)) {
+			*usercon_clr = *fromcon_clr;
+		} else if (mls_level_dom(fromcon_clr, user_clr)) {
+			*usercon_clr = *user_clr;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
  * Convert the MLS fields in the security context
  * structure `c' from the values specified in the
  * policy `oldp' to the values specified in the policy `newp'.
@@ -331,6 +445,9 @@ int mls_convert_context(struct policydb 
 	struct ebitmap bitmap;
 	int l, i;
 
+	if (!selinux_mls_enabled)
+		return 0;
+
 	for (l = 0; l < 2; l++) {
 		levdatum = hashtab_search(newp->p_levels.table,
 			oldp->p_sens_val_to_name[c->range.level[l].sens - 1]);
@@ -366,17 +483,38 @@ int mls_compute_sid(struct context *scon
 		    u32 specified,
 		    struct context *newcontext)
 {
+	if (!selinux_mls_enabled)
+		return 0;
+
 	switch (specified) {
 	case AVTAB_TRANSITION:
+		if (tclass == SECCLASS_PROCESS) {
+			struct range_trans *rangetr;
+			/* Look for a range transition rule. */
+			for (rangetr = policydb.range_tr; rangetr;
+			     rangetr = rangetr->next) {
+				if (rangetr->dom == scontext->type &&
+				    rangetr->type == tcontext->type) {
+					/* Set the range from the rule */
+					return mls_range_set(newcontext,
+					                     &rangetr->range);
+				}
+			}
+		}
+		/* Fallthrough */
 	case AVTAB_CHANGE:
-		/* Use the process MLS attributes. */
-		return mls_copy_context(newcontext, scontext);
+		if (tclass == SECCLASS_PROCESS)
+			/* Use the process MLS attributes. */
+			return mls_copy_context(newcontext, scontext);
+		else
+			/* Use the process effective MLS attributes. */
+			return mls_scopy_context(newcontext, scontext);
 	case AVTAB_MEMBER:
 		/* Only polyinstantiate the MLS attributes if
 		   the type is being polyinstantiated */
 		if (newcontext->type != tcontext->type) {
-			/* Use the process MLS attributes. */
-			return mls_copy_context(newcontext, scontext);
+			/* Use the process effective MLS attributes. */
+			return mls_scopy_context(newcontext, scontext);
 		} else {
 			/* Use the related object MLS attributes. */
 			return mls_copy_context(newcontext, tcontext);
@@ -387,365 +525,3 @@ int mls_compute_sid(struct context *scon
 	return -EINVAL;
 }
 
-void mls_user_destroy(struct user_datum *usrdatum)
-{
-	struct mls_range_list *rnode, *rtmp;
-	rnode = usrdatum->ranges;
-	while (rnode) {
-		rtmp = rnode;
-		rnode = rnode->next;
-		ebitmap_destroy(&rtmp->range.level[0].cat);
-		ebitmap_destroy(&rtmp->range.level[1].cat);
-		kfree(rtmp);
-	}
-}
-
-int mls_read_perm(struct perm_datum *perdatum, void *fp)
-{
-	u32 buf[1];
-	int rc;
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		return -EINVAL;
-	perdatum->base_perms = le32_to_cpu(buf[0]);
-	return 0;
-}
-
-/*
- * Read a MLS level structure from a policydb binary
- * representation file.
- */
-struct mls_level *mls_read_level(void *fp)
-{
-	struct mls_level *l;
-	u32 buf[1];
-	int rc;
-
-	l = kmalloc(sizeof(*l), GFP_ATOMIC);
-	if (!l) {
-		printk(KERN_ERR "security: mls: out of memory\n");
-		return NULL;
-	}
-	memset(l, 0, sizeof(*l));
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0) {
-		printk(KERN_ERR "security: mls: truncated level\n");
-		goto bad;
-	}
-	l->sens = cpu_to_le32(buf[0]);
-
-	if (ebitmap_read(&l->cat, fp)) {
-		printk(KERN_ERR "security: mls:  error reading level "
-		       "categories\n");
-		goto bad;
-	}
-	return l;
-
-bad:
-	kfree(l);
-	return NULL;
-}
-
-
-/*
- * Read a MLS range structure from a policydb binary
- * representation file.
- */
-static int mls_read_range_helper(struct mls_range *r, void *fp)
-{
-	u32 buf[2], items;
-	int rc;
-
-	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0)
-		goto out;
-
-	items = le32_to_cpu(buf[0]);
-	if (items > ARRAY_SIZE(buf)) {
-		printk(KERN_ERR "security: mls:  range overflow\n");
-		rc = -EINVAL;
-		goto out;
-	}
-	rc = next_entry(buf, fp, sizeof(u32) * items);
-	if (rc < 0) {
-		printk(KERN_ERR "security: mls:  truncated range\n");
-		goto out;
-	}
-	r->level[0].sens = le32_to_cpu(buf[0]);
-	if (items > 1) {
-		r->level[1].sens = le32_to_cpu(buf[1]);
-	} else {
-		r->level[1].sens = r->level[0].sens;
-	}
-
-	rc = ebitmap_read(&r->level[0].cat, fp);
-	if (rc) {
-		printk(KERN_ERR "security: mls:  error reading low "
-		       "categories\n");
-		goto out;
-	}
-	if (items > 1) {
-		rc = ebitmap_read(&r->level[1].cat, fp);
-		if (rc) {
-			printk(KERN_ERR "security: mls:  error reading high "
-			       "categories\n");
-			goto bad_high;
-		}
-	} else {
-		rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
-		if (rc) {
-			printk(KERN_ERR "security: mls:  out of memory\n");
-			goto bad_high;
-		}
-	}
-
-	rc = 0;
-out:
-	return rc;
-bad_high:
-	ebitmap_destroy(&r->level[0].cat);
-	goto out;
-}
-
-int mls_read_range(struct context *c, void *fp)
-{
-	return mls_read_range_helper(&c->range, fp);
-}
-
-
-/*
- * Read a MLS perms structure from a policydb binary
- * representation file.
- */
-int mls_read_class(struct class_datum *cladatum, void *fp)
-{
-	struct mls_perms *p = &cladatum->mlsperms;
-	u32 buf[4];
-	int rc;
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0) {
-		printk(KERN_ERR "security: mls:  truncated mls permissions\n");
-		return -EINVAL;
-	}
-	p->read = le32_to_cpu(buf[0]);
-	p->readby = le32_to_cpu(buf[1]);
-	p->write = le32_to_cpu(buf[2]);
-	p->writeby = le32_to_cpu(buf[3]);
-	return 0;
-}
-
-int mls_read_user(struct user_datum *usrdatum, void *fp)
-{
-	struct mls_range_list *r, *l;
-	int rc;
-	u32 nel, i;
-	u32 buf[1];
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		goto out;
-	nel = le32_to_cpu(buf[0]);
-	l = NULL;
-	for (i = 0; i < nel; i++) {
-		r = kmalloc(sizeof(*r), GFP_ATOMIC);
-		if (!r) {
-			rc = -ENOMEM;
-			goto out;
-		}
-		memset(r, 0, sizeof(*r));
-
-		rc = mls_read_range_helper(&r->range, fp);
-		if (rc) {
-			kfree(r);
-			goto out;
-		}
-
-		if (l)
-			l->next = r;
-		else
-			usrdatum->ranges = r;
-		l = r;
-	}
-out:
-	return rc;
-}
-
-int mls_read_nlevels(struct policydb *p, void *fp)
-{
-	u32 buf[1];
-	int rc;
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		return -EINVAL;
-	p->nlevels = le32_to_cpu(buf[0]);
-	return 0;
-}
-
-int mls_read_trusted(struct policydb *p, void *fp)
-{
-	int rc = 0;
-
-	rc = ebitmap_read(&p->trustedreaders, fp);
-	if (rc)
-		goto out;
-	rc = ebitmap_read(&p->trustedwriters, fp);
-	if (rc)
-		goto bad;
-	rc = ebitmap_read(&p->trustedobjects, fp);
-	if (rc)
-		goto bad2;
-out:
-	return rc;
-bad2:
-	ebitmap_destroy(&p->trustedwriters);
-bad:
-	ebitmap_destroy(&p->trustedreaders);
-	goto out;
-}
-
-int sens_index(void *key, void *datum, void *datap)
-{
-	struct policydb *p;
-	struct level_datum *levdatum;
-
-
-	levdatum = datum;
-	p = datap;
-
-	if (!levdatum->isalias)
-		p->p_sens_val_to_name[levdatum->level->sens - 1] = key;
-
-	return 0;
-}
-
-int cat_index(void *key, void *datum, void *datap)
-{
-	struct policydb *p;
-	struct cat_datum *catdatum;
-
-
-	catdatum = datum;
-	p = datap;
-
-
-	if (!catdatum->isalias)
-		p->p_cat_val_to_name[catdatum->value - 1] = key;
-
-	return 0;
-}
-
-int sens_destroy(void *key, void *datum, void *p)
-{
-	struct level_datum *levdatum;
-
-	kfree(key);
-	levdatum = datum;
-	if (!levdatum->isalias) {
-		ebitmap_destroy(&levdatum->level->cat);
-		kfree(levdatum->level);
-	}
-	kfree(datum);
-	return 0;
-}
-
-int cat_destroy(void *key, void *datum, void *p)
-{
-	kfree(key);
-	kfree(datum);
-	return 0;
-}
-
-int sens_read(struct policydb *p, struct hashtab *h, void *fp)
-{
-	char *key = NULL;
-	struct level_datum *levdatum;
-	int rc;
-	u32 buf[2], len;
-
-	levdatum = kmalloc(sizeof(*levdatum), GFP_ATOMIC);
-	if (!levdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	memset(levdatum, 0, sizeof(*levdatum));
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		goto bad;
-
-	len = le32_to_cpu(buf[0]);
-	levdatum->isalias = le32_to_cpu(buf[1]);
-
-	key = kmalloc(len + 1,GFP_ATOMIC);
-	if (!key) {
-		rc = -ENOMEM;
-		goto bad;
-	}
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
-	levdatum->level = mls_read_level(fp);
-	if (!levdatum->level) {
-		rc = -EINVAL;
-		goto bad;
-	}
-
-	rc = hashtab_insert(h, key, levdatum);
-	if (rc)
-		goto bad;
-out:
-	return rc;
-bad:
-	sens_destroy(key, levdatum, NULL);
-	goto out;
-}
-
-
-int cat_read(struct policydb *p, struct hashtab *h, void *fp)
-{
-	char *key = NULL;
-	struct cat_datum *catdatum;
-	int rc;
-	u32 buf[3], len;
-
-	catdatum = kmalloc(sizeof(*catdatum), GFP_ATOMIC);
-	if (!catdatum) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	memset(catdatum, 0, sizeof(*catdatum));
-
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		goto bad;
-
-	len = le32_to_cpu(buf[0]);
-	catdatum->value = le32_to_cpu(buf[1]);
-	catdatum->isalias = le32_to_cpu(buf[2]);
-
-	key = kmalloc(len + 1,GFP_ATOMIC);
-	if (!key) {
-		rc = -ENOMEM;
-		goto bad;
-	}
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
-	rc = hashtab_insert(h, key, catdatum);
-	if (rc)
-		goto bad;
-out:
-	return rc;
-
-bad:
-	cat_destroy(key, catdatum, NULL);
-	goto out;
-}
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/mls.h linux-2.6.11-mm1-mls/security/selinux/ss/mls.h
--- linux-2.6.11-mm1/security/selinux/ss/mls.h	2005-03-02 02:37:50.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/mls.h	2005-03-07 11:17:14.000000000 -0500
@@ -3,21 +3,22 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+/*
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *
+ *	Support for enhanced MLS infrastructure.
+ *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ */
+
 #ifndef _SS_MLS_H_
 #define _SS_MLS_H_
 
 #include "context.h"
 #include "policydb.h"
 
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-
-void mls_compute_av(struct context *scontext,
-		    struct context *tcontext,
-		    struct class_datum *tclass,
-		    u32 *allowed);
-
 int mls_compute_context_len(struct context *context);
-int mls_sid_to_context(struct context *context, char **scontext);
+void mls_sid_to_context(struct context *context, char **scontext);
 int mls_context_isvalid(struct policydb *p, struct context *c);
 
 int mls_context_to_sid(char oldc,
@@ -34,66 +35,8 @@ int mls_compute_sid(struct context *scon
 		    u32 specified,
 		    struct context *newcontext);
 
-int sens_index(void *key, void *datum, void *datap);
-int cat_index(void *key, void *datum, void *datap);
-int sens_destroy(void *key, void *datum, void *p);
-int cat_destroy(void *key, void *datum, void *p);
-int sens_read(struct policydb *p, struct hashtab *h, void *fp);
-int cat_read(struct policydb *p, struct hashtab *h, void *fp);
-
-#define mls_for_user_ranges(user, usercon) { \
-struct mls_range_list *__ranges; \
-for (__ranges = user->ranges; __ranges; __ranges = __ranges->next) { \
-usercon.range = __ranges->range;
-
-#define mls_end_user_ranges } }
-
-#define mls_symtab_names  "levels", "categories",
-#define mls_symtab_sizes  16, 16,
-#define mls_index_f sens_index, cat_index,
-#define mls_destroy_f sens_destroy, cat_destroy,
-#define mls_read_f sens_read, cat_read,
-#define mls_write_f sens_write, cat_write,
-#define mls_policydb_index_others(p) printk(", %d levels", p->nlevels);
-
-#define mls_set_config(config) config |= POLICYDB_CONFIG_MLS
-
-void mls_user_destroy(struct user_datum *usrdatum);
-int mls_read_range(struct context *c, void *fp);
-int mls_read_perm(struct perm_datum *perdatum, void *fp);
-int mls_read_class(struct class_datum *cladatum,  void *fp);
-int mls_read_user(struct user_datum *usrdatum, void *fp);
-int mls_read_nlevels(struct policydb *p, void *fp);
-int mls_read_trusted(struct policydb *p, void *fp);
-
-#else
-
-#define	mls_compute_av(scontext, tcontext, tclass_datum, allowed)
-#define mls_compute_context_len(context) 0
-#define	mls_sid_to_context(context, scontextpp)
-#define mls_context_isvalid(p, c) 1
-#define	mls_context_to_sid(oldc, context_str, context) 0
-#define mls_convert_context(oldp, newp, c) 0
-#define mls_compute_sid(scontext, tcontext, tclass, specified, newcontextp) 0
-#define mls_for_user_ranges(user, usercon)
-#define mls_end_user_ranges
-#define mls_symtab_names
-#define mls_symtab_sizes
-#define mls_index_f
-#define mls_destroy_f
-#define mls_read_f
-#define mls_write_f
-#define mls_policydb_index_others(p)
-#define mls_set_config(config)
-#define mls_user_destroy(usrdatum)
-#define mls_read_range(c, fp) 0
-#define mls_read_perm(p, fp) 0
-#define mls_read_class(c, fp) 0
-#define mls_read_user(u, fp) 0
-#define mls_read_nlevels(p, fp) 0
-#define mls_read_trusted(p, fp) 0
-
-#endif
+int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
+                         struct context *usercon);
 
 #endif	/* _SS_MLS_H */
 
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/mls_types.h linux-2.6.11-mm1-mls/security/selinux/ss/mls_types.h
--- linux-2.6.11-mm1/security/selinux/ss/mls_types.h	2005-03-02 02:38:09.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/mls_types.h	2005-03-07 11:13:56.000000000 -0500
@@ -3,9 +3,19 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+/*
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *
+ *	Support for enhanced MLS infrastructure.
+ *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ */
+
 #ifndef _SS_MLS_TYPES_H_
 #define _SS_MLS_TYPES_H_
 
+#include "security.h"
+
 struct mls_level {
 	u32 sens;		/* sensitivity */
 	struct ebitmap cat;	/* category set */
@@ -15,44 +25,32 @@ struct mls_range {
 	struct mls_level level[2]; /* low == level[0], high == level[1] */
 };
 
-struct mls_range_list {
-	struct mls_range range;
-	struct mls_range_list *next;
-};
-
-#define MLS_RELATION_DOM	1 /* source dominates */
-#define MLS_RELATION_DOMBY	2 /* target dominates */
-#define MLS_RELATION_EQ		4 /* source and target are equivalent */
-#define MLS_RELATION_INCOMP	8 /* source and target are incomparable */
-
-#define mls_level_eq(l1,l2) \
-(((l1).sens == (l2).sens) && ebitmap_cmp(&(l1).cat,&(l2).cat))
-
-#define mls_level_relation(l1,l2) ( \
-(((l1).sens == (l2).sens) && ebitmap_cmp(&(l1).cat,&(l2).cat)) ? \
-				    MLS_RELATION_EQ : \
-(((l1).sens >= (l2).sens) && ebitmap_contains(&(l1).cat, &(l2).cat)) ? \
-				    MLS_RELATION_DOM : \
-(((l2).sens >= (l1).sens) && ebitmap_contains(&(l2).cat, &(l1).cat)) ? \
-				    MLS_RELATION_DOMBY : \
-				    MLS_RELATION_INCOMP )
-
-#define mls_range_contains(r1,r2) \
-((mls_level_relation((r1).level[0], (r2).level[0]) & \
-	  (MLS_RELATION_EQ | MLS_RELATION_DOMBY)) && \
-	 (mls_level_relation((r1).level[1], (r2).level[1]) & \
-	  (MLS_RELATION_EQ | MLS_RELATION_DOM)))
-
-/*
- * Every access vector permission is mapped to a set of MLS base
- * permissions, based on the flow properties of the corresponding
- * operation.
- */
-struct mls_perms {
-	u32 read;     /* permissions that map to `read' */
-	u32 readby;   /* permissions that map to `readby' */
-	u32 write;    /* permissions that map to `write' */
-	u32 writeby;  /* permissions that map to `writeby' */
-};
+static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
+{
+	if (!selinux_mls_enabled)
+		return 1;
+
+	return ((l1->sens == l2->sens) &&
+	        ebitmap_cmp(&l1->cat, &l2->cat));
+}
+
+static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
+{
+	if (!selinux_mls_enabled)
+		return 1;
+
+	return ((l1->sens >= l2->sens) &&
+	        ebitmap_contains(&l1->cat, &l2->cat));
+}
+
+#define mls_level_incomp(l1, l2) \
+(!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
+
+#define mls_level_between(l1, l2, l3) \
+(mls_level_dom((l1), (l2)) && mls_level_dom((l3), (l1)))
+
+#define mls_range_contains(r1, r2) \
+(mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
+ mls_level_dom(&(r1).level[1], &(r2).level[1]))
 
 #endif	/* _SS_MLS_TYPES_H_ */
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/policydb.c linux-2.6.11-mm1-mls/security/selinux/ss/policydb.c
--- linux-2.6.11-mm1/security/selinux/ss/policydb.c	2005-03-02 02:38:07.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/policydb.c	2005-03-07 11:17:14.000000000 -0500
@@ -4,10 +4,16 @@
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
 
-/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+/*
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *
+ *	Support for enhanced MLS infrastructure.
+ *
+ * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
  * 	Added conditional policy language extensions
  *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
@@ -33,19 +39,23 @@ static char *symtab_name[SYM_NUM] = {
 	"roles",
 	"types",
 	"users",
-	mls_symtab_names
-	"bools"
+	"bools",
+	"levels",
+	"categories",
 };
 #endif
 
+int selinux_mls_enabled = 0;
+
 static unsigned int symtab_sizes[SYM_NUM] = {
 	2,
 	32,
 	16,
 	512,
 	128,
-	mls_symtab_sizes
-	16
+	16,
+	16,
+	16,
 };
 
 struct policydb_compat_info {
@@ -58,21 +68,26 @@ struct policydb_compat_info {
 static struct policydb_compat_info policydb_compat[] = {
 	{
 		.version        = POLICYDB_VERSION_BASE,
-		.sym_num        = SYM_NUM - 1,
+		.sym_num        = SYM_NUM - 3,
 		.ocon_num       = OCON_NUM - 1,
 	},
 	{
 		.version        = POLICYDB_VERSION_BOOL,
-		.sym_num        = SYM_NUM,
+		.sym_num        = SYM_NUM - 2,
 		.ocon_num       = OCON_NUM - 1,
 	},
 	{
 		.version        = POLICYDB_VERSION_IPV6,
-		.sym_num        = SYM_NUM,
+		.sym_num        = SYM_NUM - 2,
 		.ocon_num       = OCON_NUM,
 	},
 	{
 		.version        = POLICYDB_VERSION_NLCLASS,
+		.sym_num        = SYM_NUM - 2,
+		.ocon_num       = OCON_NUM,
+	},
+	{
+		.version        = POLICYDB_VERSION_MLS,
 		.sym_num        = SYM_NUM,
 		.ocon_num       = OCON_NUM,
 	},
@@ -252,6 +267,41 @@ static int user_index(void *key, void *d
 	return 0;
 }
 
+static int sens_index(void *key, void *datum, void *datap)
+{
+	struct policydb *p;
+	struct level_datum *levdatum;
+
+	levdatum = datum;
+	p = datap;
+
+	if (!levdatum->isalias) {
+		if (!levdatum->level->sens ||
+		    levdatum->level->sens > p->p_levels.nprim)
+			return -EINVAL;
+		p->p_sens_val_to_name[levdatum->level->sens - 1] = key;
+	}
+
+	return 0;
+}
+
+static int cat_index(void *key, void *datum, void *datap)
+{
+	struct policydb *p;
+	struct cat_datum *catdatum;
+
+	catdatum = datum;
+	p = datap;
+
+	if (!catdatum->isalias) {
+		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+			return -EINVAL;
+		p->p_cat_val_to_name[catdatum->value - 1] = key;
+	}
+
+	return 0;
+}
+
 static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 {
 	common_index,
@@ -259,8 +309,9 @@ static int (*index_f[SYM_NUM]) (void *ke
 	role_index,
 	type_index,
 	user_index,
-	mls_index_f
-	cond_index_bool
+	cond_index_bool,
+	sens_index,
+	cat_index,
 };
 
 /*
@@ -333,7 +384,9 @@ int policydb_index_others(struct policyd
 
 	printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
 	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
-	mls_policydb_index_others(p);
+	if (selinux_mls_enabled)
+		printk(", %d sens, %d cats", p->p_levels.nprim,
+		       p->p_cats.nprim);
 	printk("\n");
 
 	printk(KERN_INFO "security:  %d classes, %d rules\n",
@@ -429,6 +482,21 @@ static int class_destroy(void *key, void
 		constraint = constraint->next;
 		kfree(ctemp);
 	}
+
+	constraint = cladatum->validatetrans;
+	while (constraint) {
+		e = constraint->expr;
+		while (e) {
+			ebitmap_destroy(&e->names);
+			etmp = e;
+			e = e->next;
+			kfree(etmp);
+		}
+		ctemp = constraint;
+		constraint = constraint->next;
+		kfree(ctemp);
+	}
+
 	kfree(cladatum->comkey);
 	kfree(datum);
 	return 0;
@@ -460,7 +528,28 @@ static int user_destroy(void *key, void 
 	kfree(key);
 	usrdatum = datum;
 	ebitmap_destroy(&usrdatum->roles);
-	mls_user_destroy(usrdatum);
+	ebitmap_destroy(&usrdatum->range.level[0].cat);
+	ebitmap_destroy(&usrdatum->range.level[1].cat);
+	ebitmap_destroy(&usrdatum->dfltlevel.cat);
+	kfree(datum);
+	return 0;
+}
+
+static int sens_destroy(void *key, void *datum, void *p)
+{
+	struct level_datum *levdatum;
+
+	kfree(key);
+	levdatum = datum;
+	ebitmap_destroy(&levdatum->level->cat);
+	kfree(levdatum->level);
+	kfree(datum);
+	return 0;
+}
+
+static int cat_destroy(void *key, void *datum, void *p)
+{
+	kfree(key);
 	kfree(datum);
 	return 0;
 }
@@ -472,8 +561,9 @@ static int (*destroy_f[SYM_NUM]) (void *
 	role_destroy,
 	type_destroy,
 	user_destroy,
-	mls_destroy_f
-	cond_destroy_bool
+	cond_destroy_bool,
+	sens_destroy,
+	cat_destroy,
 };
 
 void ocontext_destroy(struct ocontext *c, int i)
@@ -624,6 +714,65 @@ int policydb_context_isvalid(struct poli
 }
 
 /*
+ * Read a MLS range structure from a policydb binary
+ * representation file.
+ */
+static int mls_read_range_helper(struct mls_range *r, void *fp)
+{
+	u32 buf[2], items;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
+		goto out;
+
+	items = le32_to_cpu(buf[0]);
+	if (items > ARRAY_SIZE(buf)) {
+		printk(KERN_ERR "security: mls:  range overflow\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = next_entry(buf, fp, sizeof(u32) * items);
+	if (rc < 0) {
+		printk(KERN_ERR "security: mls:  truncated range\n");
+		goto out;
+	}
+	r->level[0].sens = le32_to_cpu(buf[0]);
+	if (items > 1)
+		r->level[1].sens = le32_to_cpu(buf[1]);
+	else
+		r->level[1].sens = r->level[0].sens;
+
+	rc = ebitmap_read(&r->level[0].cat, fp);
+	if (rc) {
+		printk(KERN_ERR "security: mls:  error reading low "
+		       "categories\n");
+		goto out;
+	}
+	if (items > 1) {
+		rc = ebitmap_read(&r->level[1].cat, fp);
+		if (rc) {
+			printk(KERN_ERR "security: mls:  error reading high "
+			       "categories\n");
+			goto bad_high;
+		}
+	} else {
+		rc = ebitmap_cpy(&r->level[1].cat, &r->level[0].cat);
+		if (rc) {
+			printk(KERN_ERR "security: mls:  out of memory\n");
+			goto bad_high;
+		}
+	}
+
+	rc = 0;
+out:
+	return rc;
+bad_high:
+	ebitmap_destroy(&r->level[0].cat);
+	goto out;
+}
+
+/*
  * Read and validate a security context structure
  * from a policydb binary representation file.
  */
@@ -642,11 +791,13 @@ static int context_read_and_validate(str
 	c->user = le32_to_cpu(buf[0]);
 	c->role = le32_to_cpu(buf[1]);
 	c->type = le32_to_cpu(buf[2]);
-	if (mls_read_range(c, fp)) {
-		printk(KERN_ERR "security: error reading MLS range of "
-		       "context\n");
-		rc = -EINVAL;
-		goto out;
+	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+		if (mls_read_range_helper(&c->range, fp)) {
+			printk(KERN_ERR "security: error reading MLS range of "
+			       "context\n");
+			rc = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (!policydb_context_isvalid(p, c)) {
@@ -684,9 +835,6 @@ static int perm_read(struct policydb *p,
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
-	rc = mls_read_perm(perdatum, fp);
-	if (rc)
-		goto bad;
 
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
@@ -761,14 +909,97 @@ bad:
 	goto out;
 }
 
+static int read_cons_helper(struct constraint_node **nodep, int ncons,
+                            int allowxtarget, void *fp)
+{
+	struct constraint_node *c, *lc;
+	struct constraint_expr *e, *le;
+	u32 buf[3], nexpr;
+	int rc, i, j, depth;
+
+	lc = NULL;
+	for (i = 0; i < ncons; i++) {
+		c = kmalloc(sizeof(*c), GFP_KERNEL);
+		if (!c)
+			return -ENOMEM;
+		memset(c, 0, sizeof(*c));
+
+		if (lc) {
+			lc->next = c;
+		} else {
+			*nodep = c;
+		}
+
+		rc = next_entry(buf, fp, (sizeof(u32) * 2));
+		if (rc < 0)
+			return rc;
+		c->permissions = le32_to_cpu(buf[0]);
+		nexpr = le32_to_cpu(buf[1]);
+		le = NULL;
+		depth = -1;
+		for (j = 0; j < nexpr; j++) {
+			e = kmalloc(sizeof(*e), GFP_KERNEL);
+			if (!e)
+				return -ENOMEM;
+			memset(e, 0, sizeof(*e));
+
+			if (le) {
+				le->next = e;
+			} else {
+				c->expr = e;
+			}
+
+			rc = next_entry(buf, fp, (sizeof(u32) * 3));
+			if (rc < 0)
+				return rc;
+			e->expr_type = le32_to_cpu(buf[0]);
+			e->attr = le32_to_cpu(buf[1]);
+			e->op = le32_to_cpu(buf[2]);
+
+			switch (e->expr_type) {
+			case CEXPR_NOT:
+				if (depth < 0)
+					return -EINVAL;
+				break;
+			case CEXPR_AND:
+			case CEXPR_OR:
+				if (depth < 1)
+					return -EINVAL;
+				depth--;
+				break;
+			case CEXPR_ATTR:
+				if (depth == (CEXPR_MAXDEPTH - 1))
+					return -EINVAL;
+				depth++;
+				break;
+			case CEXPR_NAMES:
+				if (!allowxtarget && (e->attr & CEXPR_XTARGET))
+					return -EINVAL;
+				if (depth == (CEXPR_MAXDEPTH - 1))
+					return -EINVAL;
+				depth++;
+				if (ebitmap_read(&e->names, fp))
+					return -EINVAL;
+				break;
+			default:
+				return -EINVAL;
+			}
+			le = e;
+		}
+		if (depth != 0)
+			return -EINVAL;
+		lc = c;
+	}
+
+	return 0;
+}
+
 static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
-	struct constraint_node *c, *lc;
-	struct constraint_expr *e, *le;
-	u32 buf[6], len, len2, ncons, nexpr, nel;
-	int i, j, depth, rc;
+	u32 buf[6], len, len2, ncons, nel;
+	int i, rc;
 
 	cladatum = kmalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum) {
@@ -829,87 +1060,21 @@ static int class_read(struct policydb *p
 			goto bad;
 	}
 
-	lc = NULL;
-	for (i = 0; i < ncons; i++) {
-		c = kmalloc(sizeof(*c), GFP_KERNEL);
-		if (!c) {
-			rc = -ENOMEM;
-			goto bad;
-		}
-		memset(c, 0, sizeof(*c));
-
-		if (lc) {
-			lc->next = c;
-		} else {
-			cladatum->constraints = c;
-		}
+	rc = read_cons_helper(&cladatum->constraints, ncons, 0, fp);
+	if (rc)
+		goto bad;
 
-		rc = next_entry(buf, fp, sizeof(u32)*2);
+	if (p->policyvers >= POLICYDB_VERSION_VALIDATETRANS) {
+		/* grab the validatetrans rules */
+		rc = next_entry(buf, fp, sizeof(u32));
 		if (rc < 0)
 			goto bad;
-		c->permissions = le32_to_cpu(buf[0]);
-		nexpr = le32_to_cpu(buf[1]);
-		le = NULL;
-		depth = -1;
-		for (j = 0; j < nexpr; j++) {
-			e = kmalloc(sizeof(*e), GFP_KERNEL);
-			if (!e) {
-				rc = -ENOMEM;
-				goto bad;
-			}
-			memset(e, 0, sizeof(*e));
-
-			if (le) {
-				le->next = e;
-			} else {
-				c->expr = e;
-			}
-
-			rc = next_entry(buf, fp, sizeof(u32)*3);
-			if (rc < 0)
-				goto bad;
-			e->expr_type = le32_to_cpu(buf[0]);
-			e->attr = le32_to_cpu(buf[1]);
-			e->op = le32_to_cpu(buf[2]);
-
-			rc = -EINVAL;
-			switch (e->expr_type) {
-			case CEXPR_NOT:
-				if (depth < 0)
-					goto bad;
-				break;
-			case CEXPR_AND:
-			case CEXPR_OR:
-				if (depth < 1)
-					goto bad;
-				depth--;
-				break;
-			case CEXPR_ATTR:
-				if (depth == (CEXPR_MAXDEPTH-1))
-					goto bad;
-				depth++;
-				break;
-			case CEXPR_NAMES:
-				if (depth == (CEXPR_MAXDEPTH-1))
-					goto bad;
-				depth++;
-				if (ebitmap_read(&e->names, fp))
-					goto bad;
-				break;
-			default:
-				goto bad;
-			}
-			le = e;
-		}
-		if (depth != 0)
+		ncons = le32_to_cpu(buf[0]);
+		rc = read_cons_helper(&cladatum->validatetrans, ncons, 1, fp);
+		if (rc)
 			goto bad;
-		lc = c;
 	}
 
-	rc = mls_read_class(cladatum, fp);
-	if (rc)
-		goto bad;
-
 	rc = hashtab_insert(h, key, cladatum);
 	if (rc)
 		goto bad;
@@ -1024,6 +1189,36 @@ bad:
 	goto out;
 }
 
+
+/*
+ * Read a MLS level structure from a policydb binary
+ * representation file.
+ */
+static int mls_read_level(struct mls_level *lp, void *fp)
+{
+	u32 buf[1];
+	int rc;
+
+	memset(lp, 0, sizeof(*lp));
+
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0) {
+		printk(KERN_ERR "security: mls: truncated level\n");
+		goto bad;
+	}
+	lp->sens = le32_to_cpu(buf[0]);
+
+	if (ebitmap_read(&lp->cat, fp)) {
+		printk(KERN_ERR "security: mls:  error reading level "
+		       "categories\n");
+		goto bad;
+	}
+	return 0;
+
+bad:
+	return -EINVAL;
+}
+
 static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 {
 	char *key = NULL;
@@ -1031,7 +1226,6 @@ static int user_read(struct policydb *p,
 	int rc;
 	u32 buf[2], len;
 
-
 	usrdatum = kmalloc(sizeof(*usrdatum), GFP_KERNEL);
 	if (!usrdatum) {
 		rc = -ENOMEM;
@@ -1060,9 +1254,14 @@ static int user_read(struct policydb *p,
 	if (rc)
 		goto bad;
 
-	rc = mls_read_user(usrdatum, fp);
-	if (rc)
-		goto bad;
+	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+		rc = mls_read_range_helper(&usrdatum->range, fp);
+		if (rc)
+			goto bad;
+		rc = mls_read_level(&usrdatum->dfltlevel, fp);
+		if (rc)
+			goto bad;
+	}
 
 	rc = hashtab_insert(h, key, usrdatum);
 	if (rc)
@@ -1074,6 +1273,100 @@ bad:
 	goto out;
 }
 
+static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
+{
+	char *key = NULL;
+	struct level_datum *levdatum;
+	int rc;
+	u32 buf[2], len;
+
+	levdatum = kmalloc(sizeof(*levdatum), GFP_ATOMIC);
+	if (!levdatum) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(levdatum, 0, sizeof(*levdatum));
+
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
+		goto bad;
+
+	len = le32_to_cpu(buf[0]);
+	levdatum->isalias = le32_to_cpu(buf[1]);
+
+	key = kmalloc(len + 1,GFP_ATOMIC);
+	if (!key) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
+	key[len] = 0;
+
+	levdatum->level = kmalloc(sizeof(struct mls_level), GFP_ATOMIC);
+	if (!levdatum->level) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+	if (mls_read_level(levdatum->level, fp)) {
+		rc = -EINVAL;
+		goto bad;
+	}
+
+	rc = hashtab_insert(h, key, levdatum);
+	if (rc)
+		goto bad;
+out:
+	return rc;
+bad:
+	sens_destroy(key, levdatum, NULL);
+	goto out;
+}
+
+static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
+{
+	char *key = NULL;
+	struct cat_datum *catdatum;
+	int rc;
+	u32 buf[3], len;
+
+	catdatum = kmalloc(sizeof(*catdatum), GFP_ATOMIC);
+	if (!catdatum) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	memset(catdatum, 0, sizeof(*catdatum));
+
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
+		goto bad;
+
+	len = le32_to_cpu(buf[0]);
+	catdatum->value = le32_to_cpu(buf[1]);
+	catdatum->isalias = le32_to_cpu(buf[2]);
+
+	key = kmalloc(len + 1,GFP_ATOMIC);
+	if (!key) {
+		rc = -ENOMEM;
+		goto bad;
+	}
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
+	key[len] = 0;
+
+	rc = hashtab_insert(h, key, catdatum);
+	if (rc)
+		goto bad;
+out:
+	return rc;
+
+bad:
+	cat_destroy(key, catdatum, NULL);
+	goto out;
+}
+
 static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp) =
 {
 	common_read,
@@ -1081,12 +1374,12 @@ static int (*read_f[SYM_NUM]) (struct po
 	role_read,
 	type_read,
 	user_read,
-	mls_read_f
-	cond_read_bool
+	cond_read_bool,
+	sens_read,
+	cat_read,
 };
 
-#define mls_config(x) \
-       ((x) & POLICYDB_CONFIG_MLS) ? "mls" : "no_mls"
+extern int ss_initialized;
 
 /*
  * Read the configuration data from a policy database binary
@@ -1102,9 +1395,9 @@ int policydb_read(struct policydb *p, vo
 	u32 buf[8], len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
+	struct range_trans *rt, *lrt;
 
 	config = 0;
-	mls_set_config(config);
 
 	rc = policydb_init(p);
 	if (rc)
@@ -1172,14 +1465,27 @@ int policydb_read(struct policydb *p, vo
 	    	goto bad;
 	}
 
-	if (buf[1] != config) {
-		printk(KERN_ERR "security:  policydb configuration (%s) does "
-		       "not match my configuration (%s)\n",
-		       mls_config(buf[1]),
-		       mls_config(config));
-		goto bad;
-	}
+	if ((buf[1] & POLICYDB_CONFIG_MLS)) {
+		if (ss_initialized && !selinux_mls_enabled) {
+			printk(KERN_ERR "Cannot switch between non-MLS and MLS "
+			       "policies\n");
+			goto bad;
+		}
+		selinux_mls_enabled = 1;
+		config |= POLICYDB_CONFIG_MLS;
 
+		if (p->policyvers < POLICYDB_VERSION_MLS) {
+			printk(KERN_ERR "security policydb version %d (MLS) "
+			       "not backwards compatible\n", p->policyvers);
+			goto bad;
+		}
+	} else {
+		if (ss_initialized && selinux_mls_enabled) {
+			printk(KERN_ERR "Cannot switch between MLS and non-MLS "
+			       "policies\n");
+			goto bad;
+		}
+	}
 
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
@@ -1195,10 +1501,6 @@ int policydb_read(struct policydb *p, vo
 		goto bad;
 	}
 
-	rc = mls_read_nlevels(p, fp);
-	if (rc)
-		goto bad;
-
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(u32)*2);
 		if (rc < 0)
@@ -1499,9 +1801,34 @@ int policydb_read(struct policydb *p, vo
 		}
 	}
 
-	rc = mls_read_trusted(p, fp);
-	if (rc)
-		goto bad;
+	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc < 0)
+			goto bad;
+		nel = le32_to_cpu(buf[0]);
+		lrt = NULL;
+		for (i = 0; i < nel; i++) {
+			rt = kmalloc(sizeof(*rt), GFP_KERNEL);
+			if (!rt) {
+				rc = -ENOMEM;
+				goto bad;
+			}
+			memset(rt, 0, sizeof(*rt));
+			if (lrt)
+				lrt->next = rt;
+			else
+				p->range_tr = rt;
+			rc = next_entry(buf, fp, (sizeof(u32) * 2));
+			if (rc < 0)
+				goto bad;
+			rt->dom = le32_to_cpu(buf[0]);
+			rt->type = le32_to_cpu(buf[1]);
+			rc = mls_read_range_helper(&rt->range, fp);
+			if (rc)
+				goto bad;
+			lrt = rt;
+		}
+	}
 
 	rc = 0;
 out:
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/policydb.h linux-2.6.11-mm1-mls/security/selinux/ss/policydb.h
--- linux-2.6.11-mm1/security/selinux/ss/policydb.h	2005-03-02 02:38:17.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/policydb.h	2005-03-07 11:17:14.000000000 -0500
@@ -5,10 +5,16 @@
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
 
-/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+/*
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
+ *
+ *	Support for enhanced MLS infrastructure.
+ *
+ * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
  * 	Added conditional policy language extensions
  *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
@@ -34,13 +40,6 @@
 /* Permission attributes */
 struct perm_datum {
 	u32 value;		/* permission bit + 1 */
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-#define MLS_BASE_READ    1	/* MLS base permission `read' */
-#define MLS_BASE_WRITE   2	/* MLS base permission `write' */
-#define MLS_BASE_READBY  4	/* MLS base permission `readby' */
-#define MLS_BASE_WRITEBY 8	/* MLS base permission `writeby' */
-	u32 base_perms;		/* MLS base permission mask */
-#endif
 };
 
 /* Attributes of a common prefix for access vectors */
@@ -56,9 +55,7 @@ struct class_datum {
 	struct common_datum *comdatum;	/* common datum */
 	struct symtab permissions;	/* class-specific permission symbol table */
 	struct constraint_node *constraints;	/* constraints on class permissions */
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-	struct mls_perms mlsperms;	/* MLS base permission masks */
-#endif
+	struct constraint_node *validatetrans;	/* special transition rules */
 };
 
 /* Role attributes */
@@ -91,13 +88,11 @@ struct type_datum {
 struct user_datum {
 	u32 value;			/* internal user value */
 	struct ebitmap roles;		/* set of authorized roles for user */
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-	struct mls_range_list *ranges;	/* list of authorized MLS ranges for user */
-#endif
+	struct mls_range range;		/* MLS range (min - max) for user */
+	struct mls_level dfltlevel;	/* default login MLS level for user */
 };
 
 
-#ifdef CONFIG_SECURITY_SELINUX_MLS
 /* Sensitivity attributes */
 struct level_datum {
 	struct mls_level *level;	/* sensitivity and associated categories */
@@ -109,7 +104,13 @@ struct cat_datum {
 	u32 value;		/* internal category bit + 1 */
 	unsigned char isalias;  /* is this category an alias for another? */
 };
-#endif
+
+struct range_trans {
+	u32 dom;			/* current process domain */
+	u32 type;			/* program executable type */
+	struct mls_range range;		/* new range */
+	struct range_trans *next;
+};
 
 /* Boolean data type */
 struct cond_bool_datum {
@@ -164,15 +165,10 @@ struct genfs {
 #define SYM_ROLES   2
 #define SYM_TYPES   3
 #define SYM_USERS   4
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-#define SYM_LEVELS  5
-#define SYM_CATS    6
-#define SYM_BOOLS   7
-#define SYM_NUM     8
-#else
 #define SYM_BOOLS   5
-#define SYM_NUM     6
-#endif
+#define SYM_LEVELS  6
+#define SYM_CATS    7
+#define SYM_NUM     8
 
 /* object context array indices */
 #define OCON_ISID  0	/* initial SIDs */
@@ -193,9 +189,9 @@ struct policydb {
 #define p_roles symtab[SYM_ROLES]
 #define p_types symtab[SYM_TYPES]
 #define p_users symtab[SYM_USERS]
+#define p_bools symtab[SYM_BOOLS]
 #define p_levels symtab[SYM_LEVELS]
 #define p_cats symtab[SYM_CATS]
-#define p_bools symtab[SYM_BOOLS]
 
 	/* symbol names indexed by (value - 1) */
 	char **sym_val_to_name[SYM_NUM];
@@ -204,9 +200,9 @@ struct policydb {
 #define p_role_val_to_name sym_val_to_name[SYM_ROLES]
 #define p_type_val_to_name sym_val_to_name[SYM_TYPES]
 #define p_user_val_to_name sym_val_to_name[SYM_USERS]
+#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]
 #define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]
 #define p_cat_val_to_name sym_val_to_name[SYM_CATS]
-#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	struct class_datum **class_val_to_struct;
@@ -238,14 +234,8 @@ struct policydb {
 	   fixed labeling behavior. */
   	struct genfs *genfs;
 
-#ifdef CONFIG_SECURITY_SELINUX_MLS
-	/* number of legitimate MLS levels */
-	u32 nlevels;
-
-	struct ebitmap trustedreaders;
-	struct ebitmap trustedwriters;
-	struct ebitmap trustedobjects;
-#endif
+	/* range transitions */
+	struct range_trans *range_tr;
 
 	unsigned int policyvers;
 };
diff -X /home/sds/dontdiff -rup linux-2.6.11-mm1/security/selinux/ss/services.c linux-2.6.11-mm1-mls/security/selinux/ss/services.c
--- linux-2.6.11-mm1/security/selinux/ss/services.c	2005-03-02 02:38:26.000000000 -0500
+++ linux-2.6.11-mm1-mls/security/selinux/ss/services.c	2005-03-07 11:17:14.000000000 -0500
@@ -4,17 +4,17 @@
  * Authors : Stephen Smalley, <sds@epoch.ncsc.mil>
  *           James Morris <jmorris@redhat.com>
  *
- *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License version 2,
- *      as published by the Free Software Foundation.
+ *	Support for enhanced MLS infrastructure.
  *
  * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
  * 	Added conditional policy language extensions
  *
+ * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
  *  	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
@@ -64,18 +64,30 @@ int ss_initialized = 0;
  */
 static u32 latest_granting = 0;
 
+/* Forward declarations. */
+int context_struct_to_string(struct context *context, char **scontext,
+                             u32 *scontext_len);
+
 /*
  * Return the boolean value of a constraint expression
  * when it is applied to the specified source and target
  * security contexts.
- */
-static int constraint_expr_eval(struct context *scontext,
-				struct context *tcontext,
-				struct constraint_expr *cexpr)
+ *
+ * xcontext is a special beast...  It is used by the validatetrans rules
+ * only.  For these rules, scontext is the context before the transition,
+ * tcontext is the context after the transition, and xcontext is the context
+ * of the process performing the transition.  All other callers of
+ * constraint_expr_eval should pass in NULL for xcontext.
+ */
+int constraint_expr_eval(struct context *scontext,
+                         struct context *tcontext,
+                         struct context *xcontext,
+                         struct constraint_expr *cexpr)
 {
 	u32 val1, val2;
 	struct context *c;
 	struct role_datum *r1, *r2;
+	struct mls_level *l1, *l2;
 	struct constraint_expr *e;
 	int s[CEXPR_MAXDEPTH];
 	int sp = -1;
@@ -132,6 +144,52 @@ static int constraint_expr_eval(struct c
 					break;
 				}
 				break;
+			case CEXPR_L1L2:
+				l1 = &(scontext->range.level[0]);
+				l2 = &(tcontext->range.level[0]);
+				goto mls_ops;
+			case CEXPR_L1H2:
+				l1 = &(scontext->range.level[0]);
+				l2 = &(tcontext->range.level[1]);
+				goto mls_ops;
+			case CEXPR_H1L2:
+				l1 = &(scontext->range.level[1]);
+				l2 = &(tcontext->range.level[0]);
+				goto mls_ops;
+			case CEXPR_H1H2:
+				l1 = &(scontext->range.level[1]);
+				l2 = &(tcontext->range.level[1]);
+				goto mls_ops;
+			case CEXPR_L1H1:
+				l1 = &(scontext->range.level[0]);
+				l2 = &(scontext->range.level[1]);
+				goto mls_ops;
+			case CEXPR_L2H2:
+				l1 = &(tcontext->range.level[0]);
+				l2 = &(tcontext->range.level[1]);
+				goto mls_ops;
+mls_ops:
+			switch (e->op) {
+			case CEXPR_EQ:
+				s[++sp] = mls_level_eq(l1, l2);
+				continue;
+			case CEXPR_NEQ:
+				s[++sp] = !mls_level_eq(l1, l2);
+				continue;
+			case CEXPR_DOM:
+				s[++sp] = mls_level_dom(l1, l2);
+				continue;
+			case CEXPR_DOMBY:
+				s[++sp] = mls_level_dom(l2, l1);
+				continue;
+			case CEXPR_INCOMP:
+				s[++sp] = mls_level_incomp(l2, l1);
+				continue;
+			default:
+				BUG();
+				return 0;
+			}
+			break;
 			default:
 				BUG();
 				return 0;
@@ -155,6 +213,13 @@ static int constraint_expr_eval(struct c
 			c = scontext;
 			if (e->attr & CEXPR_TARGET)
 				c = tcontext;
+			else if (e->attr & CEXPR_XTARGET) {
+				c = xcontext;
+				if (!c) {
+					BUG();
+					return 0;
+				}
+			}
 			if (e->attr & CEXPR_USER)
 				val1 = c->user;
 			else if (e->attr & CEXPR_ROLE)
@@ -252,17 +317,13 @@ static int context_struct_compute_av(str
 	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
 
 	/*
-	 * Remove any permissions prohibited by the MLS policy.
-	 */
-	mls_compute_av(scontext, tcontext, tclass_datum, &avd->allowed);
-
-	/*
-	 * Remove any permissions prohibited by a constraint.
+	 * Remove any permissions prohibited by a constraint (this includes
+	 * the MLS policy).
 	 */
 	constraint = tclass_datum->constraints;
 	while (constraint) {
 		if ((constraint->permissions & (avd->allowed)) &&
-		    !constraint_expr_eval(scontext, tcontext,
+		    !constraint_expr_eval(scontext, tcontext, NULL,
 					  constraint->expr)) {
 			avd->allowed = (avd->allowed) & ~(constraint->permissions);
 		}
@@ -290,6 +351,108 @@ static int context_struct_compute_av(str
 	return 0;
 }
 
+static int security_validtrans_handle_fail(struct context *ocontext,
+                                           struct context *ncontext,
+                                           struct context *tcontext,
+                                           u16 tclass)
+{
+	char *o = NULL, *n = NULL, *t = NULL;
+	u32 olen, nlen, tlen;
+
+	if (context_struct_to_string(ocontext, &o, &olen) < 0)
+		goto out;
+	if (context_struct_to_string(ncontext, &n, &nlen) < 0)
+		goto out;
+	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
+		goto out;
+	audit_log(current->audit_context,
+	          "security_validate_transition:  denied for"
+	          " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
+	          o, n, t, policydb.p_class_val_to_name[tclass-1]);
+out:
+	kfree(o);
+	kfree(n);
+	kfree(t);
+
+	if (!selinux_enforcing)
+		return 0;
+	return -EPERM;
+}
+
+int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
+                                 u16 tclass)
+{
+	struct context *ocontext;
+	struct context *ncontext;
+	struct context *tcontext;
+	struct class_datum *tclass_datum;
+	struct constraint_node *constraint;
+	int rc = 0;
+
+	if (!ss_initialized)
+		return 0;
+
+	POLICY_RDLOCK;
+
+	/*
+	 * Remap extended Netlink classes for old policy versions.
+	 * Do this here rather than socket_type_to_security_class()
+	 * in case a newer policy version is loaded, allowing sockets
+	 * to remain in the correct class.
+	 */
+	if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
+		if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
+		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
+			tclass = SECCLASS_NETLINK_SOCKET;
+
+	if (!tclass || tclass > policydb.p_classes.nprim) {
+		printk(KERN_ERR "security_validate_transition:  "
+		       "unrecognized class %d\n", tclass);
+		rc = -EINVAL;
+		goto out;
+	}
+	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+
+	ocontext = sidtab_search(&sidtab, oldsid);
+	if (!ocontext) {
+		printk(KERN_ERR "security_validate_transition: "
+		       " unrecognized SID %d\n", oldsid);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	ncontext = sidtab_search(&sidtab, newsid);
+	if (!ncontext) {
+		printk(KERN_ERR "security_validate_transition: "
+		       " unrecognized SID %d\n", newsid);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	tcontext = sidtab_search(&sidtab, tasksid);
+	if (!tcontext) {
+		printk(KERN_ERR "security_validate_transition: "
+		       " unrecognized SID %d\n", tasksid);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	constraint = tclass_datum->validatetrans;
+	while (constraint) {
+		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
+		                          constraint->expr)) {
+			rc = security_validtrans_handle_fail(ocontext, ncontext,
+			                                     tcontext, tclass);
+			goto out;
+		}
+		constraint = constraint->next;
+	}
+
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+}
+
 /**
  * security_compute_av - Compute access vector decisions.
  * @ssid: source security identifier
@@ -366,7 +529,7 @@ int context_struct_to_string(struct cont
 	*scontext_len += mls_compute_context_len(context);
 
 	/* Allocate space for the context; caller must free this space. */
-	scontextp = kmalloc(*scontext_len+1,GFP_ATOMIC);
+	scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
 	if (!scontextp) {
 		return -ENOMEM;
 	}
@@ -375,17 +538,16 @@ int context_struct_to_string(struct cont
 	/*
 	 * Copy the user name, role name and type name into the context.
 	 */
-	sprintf(scontextp, "%s:%s:%s:",
+	sprintf(scontextp, "%s:%s:%s",
 		policydb.p_user_val_to_name[context->user - 1],
 		policydb.p_role_val_to_name[context->role - 1],
 		policydb.p_type_val_to_name[context->type - 1]);
 	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
 	             1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
-	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
+	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
 
 	mls_sid_to_context(context, &scontextp);
 
-	scontextp--;
 	*scontextp = 0;
 
 	return 0;
@@ -715,23 +877,8 @@ static int security_compute_sid(u32 ssid
 				}
 			}
 		}
-
-		if (!type_change && !roletr) {
-			/* No change in process role or type. */
-			*out_sid = ssid;
-			goto out_unlock;
-
-		}
 		break;
 	default:
-		if (!type_change &&
-		    (newcontext.user == tcontext->user) &&
-		    mls_context_cmp(scontext, tcontext)) {
-                        /* No change in object type, owner,
-			   or MLS attributes. */
-			*out_sid = tsid;
-			goto out_unlock;
-		}
 		break;
 	}
 
@@ -1363,36 +1510,37 @@ int security_get_user_sids(u32 fromsid,
 			if (!ebitmap_get_bit(&role->types, j))
 				continue;
 			usercon.type = j+1;
-			mls_for_user_ranges(user,usercon) {
-				rc = context_struct_compute_av(fromcon, &usercon,
-							       SECCLASS_PROCESS,
-							       PROCESS__TRANSITION,
-							       &avd);
-				if (rc ||  !(avd.allowed & PROCESS__TRANSITION))
-					continue;
-				rc = sidtab_context_to_sid(&sidtab, &usercon, &sid);
-				if (rc) {
+
+			if (mls_setup_user_range(fromcon, user, &usercon))
+				continue;
+
+			rc = context_struct_compute_av(fromcon, &usercon,
+						       SECCLASS_PROCESS,
+						       PROCESS__TRANSITION,
+						       &avd);
+			if (rc ||  !(avd.allowed & PROCESS__TRANSITION))
+				continue;
+			rc = sidtab_context_to_sid(&sidtab, &usercon, &sid);
+			if (rc) {
+				kfree(mysids);
+				goto out_unlock;
+			}
+			if (mynel < maxnel) {
+				mysids[mynel++] = sid;
+			} else {
+				maxnel += SIDS_NEL;
+				mysids2 = kmalloc(maxnel*sizeof(*mysids2), GFP_ATOMIC);
+				if (!mysids2) {
+					rc = -ENOMEM;
 					kfree(mysids);
 					goto out_unlock;
 				}
-				if (mynel < maxnel) {
-					mysids[mynel++] = sid;
-				} else {
-					maxnel += SIDS_NEL;
-					mysids2 = kmalloc(maxnel*sizeof(*mysids2), GFP_ATOMIC);
-					if (!mysids2) {
-						rc = -ENOMEM;
-						kfree(mysids);
-						goto out_unlock;
-					}
-					memset(mysids2, 0, maxnel*sizeof(*mysids2));
-					memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
-					kfree(mysids);
-					mysids = mysids2;
-					mysids[mynel++] = sid;
-				}
+				memset(mysids2, 0, maxnel*sizeof(*mysids2));
+				memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
+				kfree(mysids);
+				mysids = mysids2;
+				mysids[mynel++] = sid;
 			}
-			mls_end_user_ranges;
 		}
 	}
 

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

