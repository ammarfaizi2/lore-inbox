Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbULHO0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbULHO0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbULHO0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:26:08 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9354 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261164AbULHOYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:24:31 -0500
Subject: [PATCH] Eliminate unaligned accesses by SELinux policy loading code
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Prarit Bhargava <prarit@sgi.com>, Jason Baron <jbaron@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102515550.26951.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Dec 2004 09:19:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.10-rc3 rewrites the SELinux next_entry()
function and all callers to copy entry data from the binary policy
into properly aligned buffers, eliminating unaligned accesses.  This
patch is in response to a bug report from Prarit Bhargava for SELinux
and ia64, and he has confirmed that this patch eliminates the
unaligned access warnings.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/ss/avtab.c       |   28 ++--
 security/selinux/ss/conditional.c |   48 +++---
 security/selinux/ss/ebitmap.c     |   15 +-
 security/selinux/ss/mls.c         |   89 ++++++------
 security/selinux/ss/policydb.c    |  261 +++++++++++++++-----------------------
 security/selinux/ss/policydb.h    |   10 -
 6 files changed, 201 insertions(+), 250 deletions(-)

Index: linux-2.6/security/selinux/ss/avtab.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/avtab.c,v
retrieving revision 1.21
diff -u -p -r1.21 avtab.c
--- linux-2.6/security/selinux/ss/avtab.c	22 Nov 2004 18:07:35 -0000	1.21
+++ linux-2.6/security/selinux/ss/avtab.c	6 Dec 2004 19:20:14 -0000
@@ -303,20 +303,25 @@ void avtab_hash_eval(struct avtab *h, ch
 
 int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
 {
-	__u32 *buf;
-	__u32 items, items2;
+	u32 buf[7];
+	u32 items, items2;
+	int rc;
 
 	memset(avkey, 0, sizeof(struct avtab_key));
 	memset(avdatum, 0, sizeof(struct avtab_datum));
 
-	buf = next_entry(fp, sizeof(__u32));
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0) {
 		printk(KERN_ERR "security: avtab: truncated entry\n");
 		goto bad;
 	}
 	items2 = le32_to_cpu(buf[0]);
-	buf = next_entry(fp, sizeof(__u32)*items2);
-	if (!buf) {
+	if (items2 > ARRAY_SIZE(buf)) {
+		printk(KERN_ERR "security: avtab: entry overflow\n");
+		goto bad;
+	}
+	rc = next_entry(buf, fp, sizeof(u32)*items2);
+	if (rc < 0) {
 		printk(KERN_ERR "security: avtab: truncated entry\n");
 		goto bad;
 	}
@@ -362,21 +367,22 @@ bad:
 
 int avtab_read(struct avtab *a, void *fp, u32 config)
 {
-	int i, rc = -EINVAL;
+	int rc;
 	struct avtab_key avkey;
 	struct avtab_datum avdatum;
-	u32 *buf;
-	u32 nel;
+	u32 buf[1];
+	u32 nel, i;
 
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0) {
 		printk(KERN_ERR "security: avtab: truncated table\n");
 		goto bad;
 	}
 	nel = le32_to_cpu(buf[0]);
 	if (!nel) {
 		printk(KERN_ERR "security: avtab: table is empty\n");
+		rc = -EINVAL;
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
Index: linux-2.6/security/selinux/ss/conditional.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/conditional.c,v
retrieving revision 1.4
diff -u -p -r1.4 conditional.c
--- linux-2.6/security/selinux/ss/conditional.c	7 Jul 2004 19:01:40 -0000	1.4
+++ linux-2.6/security/selinux/ss/conditional.c	6 Dec 2004 19:14:18 -0000
@@ -219,15 +219,16 @@ int cond_read_bool(struct policydb *p, s
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
-	__u32 *buf, len;
+	u32 buf[3], len;
+	int rc;
 
 	booldatum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
 	if (!booldatum)
 		return -1;
 	memset(booldatum, 0, sizeof(struct cond_bool_datum));
 
-	buf = next_entry(fp, sizeof(__u32) * 3);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto err;
 
 	booldatum->value = le32_to_cpu(buf[0]);
@@ -238,13 +239,12 @@ int cond_read_bool(struct policydb *p, s
 
 	len = le32_to_cpu(buf[2]);
 
-	buf = next_entry(fp, len);
-	if (!buf)
-		goto err;
 	key = kmalloc(len + 1, GFP_KERNEL);
 	if (!key)
 		goto err;
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto err;
 	key[len] = 0;
 	if (hashtab_insert(h, key, booldatum))
 		goto err;
@@ -262,15 +262,15 @@ static int cond_read_av_list(struct poli
 	struct avtab_key key;
 	struct avtab_datum datum;
 	struct avtab_node *node_ptr;
-	int len, i;
-	__u32 *buf;
-	__u8 found;
+	int rc;
+	u32 buf[1], i, len;
+	u8 found;
 
 	*ret_list = NULL;
 
 	len = 0;
-	buf = next_entry(fp, sizeof(__u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		return -1;
 
 	len = le32_to_cpu(buf[0]);
@@ -369,27 +369,27 @@ static int expr_isvalid(struct policydb 
 
 static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 {
-	__u32 *buf;
-	int len, i;
+	u32 buf[2], len, i;
+	int rc;
 	struct cond_expr *expr = NULL, *last = NULL;
 
-	buf = next_entry(fp, sizeof(__u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
 		return -1;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
 	len = 0;
-	buf = next_entry(fp, sizeof(__u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
 		return -1;
 
 	/* expr */
 	len = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < len; i++ ) {
-		buf = next_entry(fp, sizeof(__u32) * 2);
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(u32) * 2);
+		if (rc < 0)
 			goto err;
 
 		expr = kmalloc(sizeof(struct cond_expr), GFP_KERNEL);
@@ -425,11 +425,11 @@ err:
 int cond_read_list(struct policydb *p, void *fp)
 {
 	struct cond_node *node, *last = NULL;
-	__u32 *buf;
-	int i, len;
+	u32 buf[1], i, len;
+	int rc;
 
-	buf = next_entry(fp, sizeof(__u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		return -1;
 
 	len = le32_to_cpu(buf[0]);
Index: linux-2.6/security/selinux/ss/ebitmap.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/ebitmap.c,v
retrieving revision 1.14
diff -u -p -r1.14 ebitmap.c
--- linux-2.6/security/selinux/ss/ebitmap.c	7 Jul 2004 19:01:40 -0000	1.14
+++ linux-2.6/security/selinux/ss/ebitmap.c	6 Dec 2004 19:03:42 -0000
@@ -239,13 +239,13 @@ int ebitmap_read(struct ebitmap *e, void
 {
 	int rc = -EINVAL;
 	struct ebitmap_node *n, *l;
-	u32 *buf, mapsize, count, i;
+	u32 buf[3], mapsize, count, i;
 	u64 map;
 
 	ebitmap_init(e);
 
-	buf = next_entry(fp, sizeof(u32)*3);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto out;
 
 	mapsize = le32_to_cpu(buf[0]);
@@ -269,8 +269,8 @@ int ebitmap_read(struct ebitmap *e, void
 	}
 	l = NULL;
 	for (i = 0; i < count; i++) {
-		buf = next_entry(fp, sizeof(u32));
-		if (!buf) {
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc < 0) {
 			printk(KERN_ERR "security: ebitmap: truncated map\n");
 			goto bad;
 		}
@@ -296,12 +296,11 @@ int ebitmap_read(struct ebitmap *e, void
 			       n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
-		buf = next_entry(fp, sizeof(u64));
-		if (!buf) {
+		rc = next_entry(&map, fp, sizeof(u64));
+		if (rc < 0) {
 			printk(KERN_ERR "security: ebitmap: truncated map\n");
 			goto bad_free;
 		}
-		memcpy(&map, buf, sizeof(u64));
 		n->map = le64_to_cpu(map);
 
 		if (!n->map) {
Index: linux-2.6/security/selinux/ss/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/mls.c,v
retrieving revision 1.20
diff -u -p -r1.20 mls.c
--- linux-2.6/security/selinux/ss/mls.c	7 Jul 2004 19:01:40 -0000	1.20
+++ linux-2.6/security/selinux/ss/mls.c	6 Dec 2004 19:17:09 -0000
@@ -402,10 +402,11 @@ void mls_user_destroy(struct user_datum 
 
 int mls_read_perm(struct perm_datum *perdatum, void *fp)
 {
-	u32 *buf;
+	u32 buf[1];
+	int rc;
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		return -EINVAL;
 	perdatum->base_perms = le32_to_cpu(buf[0]);
 	return 0;
@@ -418,7 +419,8 @@ int mls_read_perm(struct perm_datum *per
 struct mls_level *mls_read_level(void *fp)
 {
 	struct mls_level *l;
-	u32 *buf;
+	u32 buf[1];
+	int rc;
 
 	l = kmalloc(sizeof(*l), GFP_ATOMIC);
 	if (!l) {
@@ -427,8 +429,8 @@ struct mls_level *mls_read_level(void *f
 	}
 	memset(l, 0, sizeof(*l));
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0) {
 		printk(KERN_ERR "security: mls: truncated level\n");
 		goto bad;
 	}
@@ -453,16 +455,21 @@ bad:
  */
 static int mls_read_range_helper(struct mls_range *r, void *fp)
 {
-	u32 *buf;
-	int items, rc = -EINVAL;
+	u32 buf[2], items;
+	int rc;
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
 		goto out;
 
 	items = le32_to_cpu(buf[0]);
-	buf = next_entry(fp, sizeof(u32) * items);
-	if (!buf) {
+	if (items > ARRAY_SIZE(buf)) {
+		printk(KERN_ERR "security: mls:  range overflow\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = next_entry(buf, fp, sizeof(u32) * items);
+	if (rc < 0) {
 		printk(KERN_ERR "security: mls:  truncated range\n");
 		goto out;
 	}
@@ -515,10 +522,11 @@ int mls_read_range(struct context *c, vo
 int mls_read_class(struct class_datum *cladatum, void *fp)
 {
 	struct mls_perms *p = &cladatum->mlsperms;
-	u32 *buf;
+	u32 buf[4];
+	int rc;
 
-	buf = next_entry(fp, sizeof(u32)*4);
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0) {
 		printk(KERN_ERR "security: mls:  truncated mls permissions\n");
 		return -EINVAL;
 	}
@@ -532,15 +540,13 @@ int mls_read_class(struct class_datum *c
 int mls_read_user(struct user_datum *usrdatum, void *fp)
 {
 	struct mls_range_list *r, *l;
-	int rc = 0;
+	int rc;
 	u32 nel, i;
-	u32 *buf;
+	u32 buf[1];
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto out;
-	}
 	nel = le32_to_cpu(buf[0]);
 	l = NULL;
 	for (i = 0; i < nel; i++) {
@@ -569,10 +575,11 @@ out:
 
 int mls_read_nlevels(struct policydb *p, void *fp)
 {
-	u32 *buf;
+	u32 buf[1];
+	int rc;
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		return -EINVAL;
 	p->nlevels = le32_to_cpu(buf[0]);
 	return 0;
@@ -657,7 +664,7 @@ int sens_read(struct policydb *p, struct
 	char *key = NULL;
 	struct level_datum *levdatum;
 	int rc;
-	u32 *buf, len;
+	u32 buf[2], len;
 
 	levdatum = kmalloc(sizeof(*levdatum), GFP_ATOMIC);
 	if (!levdatum) {
@@ -666,26 +673,21 @@ int sens_read(struct policydb *p, struct
 	}
 	memset(levdatum, 0, sizeof(*levdatum));
 
-	buf = next_entry(fp, sizeof(u32)*2);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_ATOMIC);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	levdatum->level = mls_read_level(fp);
@@ -710,7 +712,7 @@ int cat_read(struct policydb *p, struct 
 	char *key = NULL;
 	struct cat_datum *catdatum;
 	int rc;
-	u32 *buf, len;
+	u32 buf[3], len;
 
 	catdatum = kmalloc(sizeof(*catdatum), GFP_ATOMIC);
 	if (!catdatum) {
@@ -719,27 +721,22 @@ int cat_read(struct policydb *p, struct 
 	}
 	memset(catdatum, 0, sizeof(*catdatum));
 
-	buf = next_entry(fp, sizeof(u32)*3);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	catdatum->value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_ATOMIC);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	rc = hashtab_insert(h, key, catdatum);
Index: linux-2.6/security/selinux/ss/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/policydb.c,v
retrieving revision 1.33
diff -u -p -r1.33 policydb.c
--- linux-2.6/security/selinux/ss/policydb.c	7 Jul 2004 19:01:40 -0000	1.33
+++ linux-2.6/security/selinux/ss/policydb.c	6 Dec 2004 18:52:25 -0000
@@ -633,13 +633,12 @@ static int context_read_and_validate(str
 				     struct policydb *p,
 				     void *fp)
 {
-	u32 *buf;
-	int rc = 0;
+	u32 buf[3];
+	int rc;
 
-	buf = next_entry(fp, sizeof(u32)*3);
-	if (!buf) {
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0) {
 		printk(KERN_ERR "security: context truncated\n");
-		rc = -EINVAL;
 		goto out;
 	}
 	c->user = le32_to_cpu(buf[0]);
@@ -672,7 +671,7 @@ static int perm_read(struct policydb *p,
 	char *key = NULL;
 	struct perm_datum *perdatum;
 	int rc;
-	u32 *buf, len;
+	u32 buf[2], len;
 
 	perdatum = kmalloc(sizeof(*perdatum), GFP_KERNEL);
 	if (!perdatum) {
@@ -681,11 +680,9 @@ static int perm_read(struct policydb *p,
 	}
 	memset(perdatum, 0, sizeof(*perdatum));
 
-	buf = next_entry(fp, sizeof(u32)*2);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
@@ -693,17 +690,14 @@ static int perm_read(struct policydb *p,
 	if (rc)
 		goto bad;
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	rc = hashtab_insert(h, key, perdatum);
@@ -720,7 +714,7 @@ static int common_read(struct policydb *
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
-	u32 *buf, len, nel;
+	u32 buf[4], len, nel;
 	int i, rc;
 
 	comdatum = kmalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -730,11 +724,9 @@ static int common_read(struct policydb *
 	}
 	memset(comdatum, 0, sizeof(*comdatum));
 
-	buf = next_entry(fp, sizeof(u32)*4);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
@@ -745,17 +737,14 @@ static int common_read(struct policydb *
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[3]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	for (i = 0; i < nel; i++) {
@@ -780,7 +769,7 @@ static int class_read(struct policydb *p
 	struct class_datum *cladatum;
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
-	u32 *buf, len, len2, ncons, nexpr, nel;
+	u32 buf[6], len, len2, ncons, nexpr, nel;
 	int i, j, depth, rc;
 
 	cladatum = kmalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -790,11 +779,9 @@ static int class_read(struct policydb *p
 	}
 	memset(cladatum, 0, sizeof(*cladatum));
 
-	buf = next_entry(fp, sizeof(u32)*6);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof(u32)*6);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
@@ -808,17 +795,14 @@ static int class_read(struct policydb *p
 
 	ncons = le32_to_cpu(buf[5]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	if (len2) {
@@ -827,12 +811,9 @@ static int class_read(struct policydb *p
 			rc = -ENOMEM;
 			goto bad;
 		}
-		buf = next_entry(fp, len2);
-		if (!buf) {
-			rc = -EINVAL;
+		rc = next_entry(cladatum->comkey, fp, len2);
+		if (rc < 0)
 			goto bad;
-		}
-		memcpy(cladatum->comkey, buf, len2);
 		cladatum->comkey[len2] = 0;
 
 		cladatum->comdatum = hashtab_search(p->p_commons.table,
@@ -866,8 +847,8 @@ static int class_read(struct policydb *p
 			cladatum->constraints = c;
 		}
 
-		buf = next_entry(fp, sizeof(u32)*2);
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(u32)*2);
+		if (rc < 0)
 			goto bad;
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
@@ -887,8 +868,8 @@ static int class_read(struct policydb *p
 				c->expr = e;
 			}
 
-			buf = next_entry(fp, sizeof(u32)*3);
-			if (!buf)
+			rc = next_entry(buf, fp, sizeof(u32)*3);
+			if (rc < 0)
 				goto bad;
 			e->expr_type = le32_to_cpu(buf[0]);
 			e->attr = le32_to_cpu(buf[1]);
@@ -946,7 +927,7 @@ static int role_read(struct policydb *p,
 	char *key = NULL;
 	struct role_datum *role;
 	int rc;
-	u32 *buf, len;
+	u32 buf[2], len;
 
 	role = kmalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
@@ -955,26 +936,21 @@ static int role_read(struct policydb *p,
 	}
 	memset(role, 0, sizeof(*role));
 
-	buf = next_entry(fp, sizeof(u32)*2);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	role->value = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	rc = ebitmap_read(&role->dominates, fp);
@@ -1011,7 +987,7 @@ static int type_read(struct policydb *p,
 	char *key = NULL;
 	struct type_datum *typdatum;
 	int rc;
-	u32 *buf, len;
+	u32 buf[3], len;
 
 	typdatum = kmalloc(sizeof(*typdatum),GFP_KERNEL);
 	if (!typdatum) {
@@ -1020,27 +996,22 @@ static int type_read(struct policydb *p,
 	}
 	memset(typdatum, 0, sizeof(*typdatum));
 
-	buf = next_entry(fp, sizeof(u32)*3);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	typdatum->value = le32_to_cpu(buf[1]);
 	typdatum->primary = le32_to_cpu(buf[2]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	rc = hashtab_insert(h, key, typdatum);
@@ -1058,7 +1029,7 @@ static int user_read(struct policydb *p,
 	char *key = NULL;
 	struct user_datum *usrdatum;
 	int rc;
-	u32 *buf, len;
+	u32 buf[2], len;
 
 
 	usrdatum = kmalloc(sizeof(*usrdatum), GFP_KERNEL);
@@ -1068,26 +1039,21 @@ static int user_read(struct policydb *p,
 	}
 	memset(usrdatum, 0, sizeof(*usrdatum));
 
-	buf = next_entry(fp, sizeof(u32)*2);
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof buf);
+	if (rc < 0)
 		goto bad;
-	}
 
 	len = le32_to_cpu(buf[0]);
 	usrdatum->value = le32_to_cpu(buf[1]);
 
-	buf = next_entry(fp, len);
-	if (!buf) {
-		rc = -EINVAL;
-		goto bad;
-	}
 	key = kmalloc(len + 1,GFP_KERNEL);
 	if (!key) {
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(key, buf, len);
+	rc = next_entry(key, fp, len);
+	if (rc < 0)
+		goto bad;
 	key[len] = 0;
 
 	rc = ebitmap_read(&usrdatum->roles, fp);
@@ -1133,7 +1099,7 @@ int policydb_read(struct policydb *p, vo
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc, r_policyvers = 0;
-	u32 *buf, len, len2, config, nprim, nel, nel2;
+	u32 buf[8], len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
 
@@ -1146,8 +1112,8 @@ int policydb_read(struct policydb *p, vo
 
 	rc = -EINVAL;
 	/* Read the magic number and string length. */
-	buf = next_entry(fp, sizeof(u32)* 2);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(u32)* 2);
+	if (rc < 0)
 		goto bad;
 
 	for (i = 0; i < 2; i++)
@@ -1167,11 +1133,6 @@ int policydb_read(struct policydb *p, vo
 		       len, strlen(POLICYDB_STRING));
 		goto bad;
 	}
-	buf = next_entry(fp, len);
-	if (!buf) {
-		printk(KERN_ERR "security:  truncated policydb string identifier\n");
-		goto bad;
-	}
 	policydb_str = kmalloc(len + 1,GFP_KERNEL);
 	if (!policydb_str) {
 		printk(KERN_ERR "security:  unable to allocate memory for policydb "
@@ -1179,7 +1140,12 @@ int policydb_read(struct policydb *p, vo
 		rc = -ENOMEM;
 		goto bad;
 	}
-	memcpy(policydb_str, buf, len);
+	rc = next_entry(policydb_str, fp, len);
+	if (rc < 0) {
+		printk(KERN_ERR "security:  truncated policydb string identifier\n");
+		kfree(policydb_str);
+		goto bad;
+	}
 	policydb_str[len] = 0;
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		printk(KERN_ERR "security:  policydb string %s does not match "
@@ -1192,8 +1158,8 @@ int policydb_read(struct policydb *p, vo
 	policydb_str = NULL;
 
 	/* Read the version, config, and table sizes. */
-	buf = next_entry(fp, sizeof(u32)*4);
-	if (!buf)
+	rc = next_entry(buf, fp, sizeof(u32)*4);
+	if (rc < 0)
 		goto bad;
 	for (i = 0; i < 4; i++)
 		buf[i] = le32_to_cpu(buf[i]);
@@ -1235,11 +1201,9 @@ int policydb_read(struct policydb *p, vo
 		goto bad;
 
 	for (i = 0; i < info->sym_num; i++) {
-		buf = next_entry(fp, sizeof(u32)*2);
-		if (!buf) {
-			rc = -EINVAL;
+		rc = next_entry(buf, fp, sizeof(u32)*2);
+		if (rc < 0)
 			goto bad;
-		}
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
 		for (j = 0; j < nel; j++) {
@@ -1261,11 +1225,9 @@ int policydb_read(struct policydb *p, vo
 			goto bad;
 	}
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
 		goto bad;
-	}
 	nel = le32_to_cpu(buf[0]);
 	ltr = NULL;
 	for (i = 0; i < nel; i++) {
@@ -1280,22 +1242,18 @@ int policydb_read(struct policydb *p, vo
 		} else {
 			p->role_tr = tr;
 		}
-		buf = next_entry(fp, sizeof(u32)*3);
-		if (!buf) {
-			rc = -EINVAL;
+		rc = next_entry(buf, fp, sizeof(u32)*3);
+		if (rc < 0)
 			goto bad;
-		}
 		tr->role = le32_to_cpu(buf[0]);
 		tr->type = le32_to_cpu(buf[1]);
 		tr->new_role = le32_to_cpu(buf[2]);
 		ltr = tr;
 	}
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
 		goto bad;
-	}
 	nel = le32_to_cpu(buf[0]);
 	lra = NULL;
 	for (i = 0; i < nel; i++) {
@@ -1310,11 +1268,9 @@ int policydb_read(struct policydb *p, vo
 		} else {
 			p->role_allow = ra;
 		}
-		buf = next_entry(fp, sizeof(u32)*2);
-		if (!buf) {
-			rc = -EINVAL;
+		rc = next_entry(buf, fp, sizeof(u32)*2);
+		if (rc < 0)
 			goto bad;
-		}
 		ra->role = le32_to_cpu(buf[0]);
 		ra->new_role = le32_to_cpu(buf[1]);
 		lra = ra;
@@ -1329,11 +1285,9 @@ int policydb_read(struct policydb *p, vo
 		goto bad;
 
 	for (i = 0; i < info->ocon_num; i++) {
-		buf = next_entry(fp, sizeof(u32));
-		if (!buf) {
-			rc = -EINVAL;
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc < 0)
 			goto bad;
-		}
 		nel = le32_to_cpu(buf[0]);
 		l = NULL;
 		for (j = 0; j < nel; j++) {
@@ -1352,8 +1306,8 @@ int policydb_read(struct policydb *p, vo
 			rc = -EINVAL;
 			switch (i) {
 			case OCON_ISID:
-				buf = next_entry(fp, sizeof(u32));
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(u32));
+				if (rc < 0)
 					goto bad;
 				c->sid[0] = le32_to_cpu(buf[0]);
 				rc = context_read_and_validate(&c->context[0], p, fp);
@@ -1362,19 +1316,18 @@ int policydb_read(struct policydb *p, vo
 				break;
 			case OCON_FS:
 			case OCON_NETIF:
-				buf = next_entry(fp, sizeof(u32));
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(u32));
+				if (rc < 0)
 					goto bad;
 				len = le32_to_cpu(buf[0]);
-				buf = next_entry(fp, len);
-				if (!buf)
-					goto bad;
 				c->u.name = kmalloc(len + 1,GFP_KERNEL);
 				if (!c->u.name) {
 					rc = -ENOMEM;
 					goto bad;
 				}
-				memcpy(c->u.name, buf, len);
+				rc = next_entry(c->u.name, fp, len);
+				if (rc < 0)
+					goto bad;
 				c->u.name[len] = 0;
 				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
@@ -1384,8 +1337,8 @@ int policydb_read(struct policydb *p, vo
 					goto bad;
 				break;
 			case OCON_PORT:
-				buf = next_entry(fp, sizeof(u32)*3);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(u32)*3);
+				if (rc < 0)
 					goto bad;
 				c->u.port.protocol = le32_to_cpu(buf[0]);
 				c->u.port.low_port = le32_to_cpu(buf[1]);
@@ -1395,8 +1348,8 @@ int policydb_read(struct policydb *p, vo
 					goto bad;
 				break;
 			case OCON_NODE:
-				buf = next_entry(fp, sizeof(u32)* 2);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(u32)* 2);
+				if (rc < 0)
 					goto bad;
 				c->u.node.addr = le32_to_cpu(buf[0]);
 				c->u.node.mask = le32_to_cpu(buf[1]);
@@ -1405,22 +1358,21 @@ int policydb_read(struct policydb *p, vo
 					goto bad;
 				break;
 			case OCON_FSUSE:
-				buf = next_entry(fp, sizeof(u32)*2);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(u32)*2);
+				if (rc < 0)
 					goto bad;
 				c->v.behavior = le32_to_cpu(buf[0]);
 				if (c->v.behavior > SECURITY_FS_USE_NONE)
 					goto bad;
 				len = le32_to_cpu(buf[1]);
-				buf = next_entry(fp, len);
-				if (!buf)
-					goto bad;
 				c->u.name = kmalloc(len + 1,GFP_KERNEL);
 				if (!c->u.name) {
 					rc = -ENOMEM;
 					goto bad;
 				}
-				memcpy(c->u.name, buf, len);
+				rc = next_entry(c->u.name, fp, len);
+				if (rc < 0)
+					goto bad;
 				c->u.name[len] = 0;
 				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
@@ -1429,8 +1381,8 @@ int policydb_read(struct policydb *p, vo
 			case OCON_NODE6: {
 				int k;
 
-				buf = next_entry(fp, sizeof(u32) * 8);
-				if (!buf)
+				rc = next_entry(buf, fp, sizeof(u32) * 8);
+				if (rc < 0)
 					goto bad;
 				for (k = 0; k < 4; k++)
 					c->u.node6.addr[k] = le32_to_cpu(buf[k]);
@@ -1444,22 +1396,17 @@ int policydb_read(struct policydb *p, vo
 		}
 	}
 
-	buf = next_entry(fp, sizeof(u32));
-	if (!buf) {
-		rc = -EINVAL;
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
 		goto bad;
-	}
 	nel = le32_to_cpu(buf[0]);
 	genfs_p = NULL;
 	rc = -EINVAL;
 	for (i = 0; i < nel; i++) {
-		buf = next_entry(fp, sizeof(u32));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc < 0)
 			goto bad;
 		len = le32_to_cpu(buf[0]);
-		buf = next_entry(fp, len);
-		if (!buf)
-			goto bad;
 		newgenfs = kmalloc(sizeof(*newgenfs), GFP_KERNEL);
 		if (!newgenfs) {
 			rc = -ENOMEM;
@@ -1473,7 +1420,12 @@ int policydb_read(struct policydb *p, vo
 			kfree(newgenfs);
 			goto bad;
 		}
-		memcpy(newgenfs->fstype, buf, len);
+		rc = next_entry(newgenfs->fstype, fp, len);
+		if (rc < 0) {
+			kfree(newgenfs->fstype);
+			kfree(newgenfs);
+			goto bad;
+		}
 		newgenfs->fstype[len] = 0;
 		for (genfs_p = NULL, genfs = p->genfs; genfs;
 		     genfs_p = genfs, genfs = genfs->next) {
@@ -1492,18 +1444,15 @@ int policydb_read(struct policydb *p, vo
 			genfs_p->next = newgenfs;
 		else
 			p->genfs = newgenfs;
-		buf = next_entry(fp, sizeof(u32));
-		if (!buf)
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc < 0)
 			goto bad;
 		nel2 = le32_to_cpu(buf[0]);
 		for (j = 0; j < nel2; j++) {
-			buf = next_entry(fp, sizeof(u32));
-			if (!buf)
+			rc = next_entry(buf, fp, sizeof(u32));
+			if (rc < 0)
 				goto bad;
 			len = le32_to_cpu(buf[0]);
-			buf = next_entry(fp, len);
-			if (!buf)
-				goto bad;
 
 			newc = kmalloc(sizeof(*newc), GFP_KERNEL);
 			if (!newc) {
@@ -1517,10 +1466,12 @@ int policydb_read(struct policydb *p, vo
 				rc = -ENOMEM;
 				goto bad_newc;
 			}
-			memcpy(newc->u.name, buf, len);
+			rc = next_entry(newc->u.name, fp, len);
+			if (rc < 0)
+				goto bad_newc;
 			newc->u.name[len] = 0;
-			buf = next_entry(fp, sizeof(u32));
-			if (!buf)
+			rc = next_entry(buf, fp, sizeof(u32));
+			if (rc < 0)
 				goto bad_newc;
 			newc->v.sclass = le32_to_cpu(buf[0]);
 			if (context_read_and_validate(&newc->context[0], p, fp))
Index: linux-2.6/security/selinux/ss/policydb.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/policydb.h,v
retrieving revision 1.21
diff -u -p -r1.21 policydb.h
--- linux-2.6/security/selinux/ss/policydb.h	19 Oct 2004 13:26:41 -0000	1.21
+++ linux-2.6/security/selinux/ss/policydb.h	6 Dec 2004 17:41:08 -0000
@@ -271,17 +271,15 @@ struct policy_file {
 	size_t len;
 };
 
-static inline void *next_entry(struct policy_file *fp, size_t bytes)
+static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 {
-	void *buf;
-
 	if (bytes > fp->len)
-		return NULL;
+		return -EINVAL;
 
-	buf = fp->data;
+	memcpy(buf, fp->data, bytes);
 	fp->data += bytes;
 	fp->len -= bytes;
-	return buf;
+	return 0;
 }
 
 #endif	/* _SS_POLICYDB_H_ */

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

