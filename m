Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVHKTei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVHKTei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHKTei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:34:38 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:414 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932370AbVHKTeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:34:37 -0400
Subject: [patch][-mm] selinux:  Reduce memory use by avtab
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 11 Aug 2005 15:32:24 -0400
Message-Id: <1123788744.7810.115.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves memory use by SELinux by both reducing the avtab
node size and reducing the number of avtab nodes.  The memory savings
are substantial, e.g. on a 64-bit system after boot, James Morris
reported the following data for the targeted and strict policies:

            #objs  objsize   kernmem
Targeted:
  Before:  237888       40     9.1MB
  After:    19968       24     468KB

Strict:
  Before:  571680       40   21.81MB
  After:   221052       24    5.06MB

The improvement in memory use comes at a cost in the speed of security
server computations of access vectors, but these computations are only
required on AVC cache misses, and performance measurements by James
Morris using a number of benchmarks have shown that the change does
not cause any significant degradation.

Note that a rebuilt policy via an updated policy toolchain
(libsepol/checkpolicy) is required in order to gain the full benefits
of this patch, although some memory savings benefits are immediately
applied even to older policies (in particular, the reduction in avtab
node size).  Sources for the updated toolchain are presently available
from the sourceforge CVS tree
(http://sourceforge.net/cvs/?group_id=21266), and tarballs are available
from http://www.flux.utah.edu/~sds.

Please add this patch to -mm for wider testing in preparation for
eventual merging for 2.6.14.  Thanks.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@namei.org>

---

 security/selinux/include/security.h |    3 
 security/selinux/ss/avtab.c         |  194 +++++++++++++++++++++-------------
 security/selinux/ss/avtab.h         |   37 +++---
 security/selinux/ss/conditional.c   |  205 ++++++++++++++++++++----------------
 security/selinux/ss/ebitmap.h       |   30 +++++
 security/selinux/ss/mls.c           |   42 ++++---
 security/selinux/ss/policydb.c      |   47 ++++++++
 security/selinux/ss/policydb.h      |    3 
 security/selinux/ss/services.c      |   76 +++++++------
 9 files changed, 401 insertions(+), 236 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/include/security.h linux-2.6.13-rc5-mm1-avtab/security/selinux/include/security.h
--- linux-2.6.13-rc5-mm1/security/selinux/include/security.h	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/include/security.h	2005-08-11 12:13:29.000000000 -0400
@@ -23,10 +23,11 @@
 #define POLICYDB_VERSION_NLCLASS	18
 #define POLICYDB_VERSION_VALIDATETRANS	19
 #define POLICYDB_VERSION_MLS		19
+#define POLICYDB_VERSION_AVTAB		20
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_MLS
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/avtab.c linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/avtab.c
--- linux-2.6.13-rc5-mm1/security/selinux/ss/avtab.c	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/avtab.c	2005-08-11 12:13:29.000000000 -0400
@@ -58,6 +58,7 @@ static int avtab_insert(struct avtab *h,
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return -EINVAL;
@@ -69,7 +70,7 @@ static int avtab_insert(struct avtab *h,
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (datum->specified & cur->datum.specified))
+		    (specified & cur->key.specified))
 			return -EEXIST;
 		if (key->source_type < cur->key.source_type)
 			break;
@@ -98,6 +99,7 @@ avtab_insert_nonunique(struct avtab * h,
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return NULL;
@@ -108,7 +110,7 @@ avtab_insert_nonunique(struct avtab * h,
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (datum->specified & cur->datum.specified))
+		    (specified & cur->key.specified))
 			break;
 		if (key->source_type < cur->key.source_type)
 			break;
@@ -125,10 +127,11 @@ avtab_insert_nonunique(struct avtab * h,
 	return newnode;
 }
 
-struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key, int specified)
+struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
 {
 	int hvalue;
 	struct avtab_node *cur;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return NULL;
@@ -138,7 +141,7 @@ struct avtab_datum *avtab_search(struct 
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (specified & cur->datum.specified))
+		    (specified & cur->key.specified))
 			return &cur->datum;
 
 		if (key->source_type < cur->key.source_type)
@@ -159,10 +162,11 @@ struct avtab_datum *avtab_search(struct 
  * conjunction with avtab_search_next_node()
  */
 struct avtab_node*
-avtab_search_node(struct avtab *h, struct avtab_key *key, int specified)
+avtab_search_node(struct avtab *h, struct avtab_key *key)
 {
 	int hvalue;
 	struct avtab_node *cur;
+	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h)
 		return NULL;
@@ -172,7 +176,7 @@ avtab_search_node(struct avtab *h, struc
 		if (key->source_type == cur->key.source_type &&
 		    key->target_type == cur->key.target_type &&
 		    key->target_class == cur->key.target_class &&
-		    (specified & cur->datum.specified))
+		    (specified & cur->key.specified))
 			return cur;
 
 		if (key->source_type < cur->key.source_type)
@@ -196,11 +200,12 @@ avtab_search_node_next(struct avtab_node
 	if (!node)
 		return NULL;
 
+	specified &= ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 	for (cur = node->next; cur; cur = cur->next) {
 		if (node->key.source_type == cur->key.source_type &&
 		    node->key.target_type == cur->key.target_type &&
 		    node->key.target_class == cur->key.target_class &&
-		    (specified & cur->datum.specified))
+		    (specified & cur->key.specified))
 			return cur;
 
 		if (node->key.source_type < cur->key.source_type)
@@ -278,75 +283,126 @@ void avtab_hash_eval(struct avtab *h, ch
 	       max_chain_len);
 }
 
-int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
-{
-	u32 buf[7];
-	u32 items, items2;
-	int rc;
+static uint16_t spec_order[] = {
+	AVTAB_ALLOWED,
+	AVTAB_AUDITDENY,
+	AVTAB_AUDITALLOW,
+	AVTAB_TRANSITION,
+	AVTAB_CHANGE,
+	AVTAB_MEMBER
+};
+
+int avtab_read_item(void *fp, u32 vers, struct avtab *a,
+	            int (*insertf)(struct avtab *a, struct avtab_key *k,
+				   struct avtab_datum *d, void *p),
+		    void *p)
+{
+	u16 buf16[4], enabled;
+	u32 buf32[7], items, items2, val;
+	struct avtab_key key;
+	struct avtab_datum datum;
+	int i, rc;
+
+	memset(&key, 0, sizeof(struct avtab_key));
+	memset(&datum, 0, sizeof(struct avtab_datum));
+
+	if (vers < POLICYDB_VERSION_AVTAB) {
+		rc = next_entry(buf32, fp, sizeof(u32));
+		if (rc < 0) {
+			printk(KERN_ERR "security: avtab: truncated entry\n");
+			return -1;
+		}
+		items2 = le32_to_cpu(buf32[0]);
+		if (items2 > ARRAY_SIZE(buf32)) {
+			printk(KERN_ERR "security: avtab: entry overflow\n");
+			return -1;
 
-	memset(avkey, 0, sizeof(struct avtab_key));
-	memset(avdatum, 0, sizeof(struct avtab_datum));
+		}
+		rc = next_entry(buf32, fp, sizeof(u32)*items2);
+		if (rc < 0) {
+			printk(KERN_ERR "security: avtab: truncated entry\n");
+			return -1;
+		}
+		items = 0;
 
-	rc = next_entry(buf, fp, sizeof(u32));
-	if (rc < 0) {
-		printk(KERN_ERR "security: avtab: truncated entry\n");
-		goto bad;
-	}
-	items2 = le32_to_cpu(buf[0]);
-	if (items2 > ARRAY_SIZE(buf)) {
-		printk(KERN_ERR "security: avtab: entry overflow\n");
-		goto bad;
+		val = le32_to_cpu(buf32[items++]);
+		key.source_type = (u16)val;
+		if (key.source_type != val) {
+			printk("security: avtab: truncated source type\n");
+			return -1;
+		}
+		val = le32_to_cpu(buf32[items++]);
+		key.target_type = (u16)val;
+		if (key.target_type != val) {
+			printk("security: avtab: truncated target type\n");
+			return -1;
+		}
+		val = le32_to_cpu(buf32[items++]);
+		key.target_class = (u16)val;
+		if (key.target_class != val) {
+			printk("security: avtab: truncated target class\n");
+			return -1;
+		}
+
+		val = le32_to_cpu(buf32[items++]);
+		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
+
+		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
+			printk("security: avtab: null entry\n");
+			return -1;
+		}
+		if ((val & AVTAB_AV) &&
+		    (val & AVTAB_TYPE)) {
+			printk("security: avtab: entry has both access vectors and types\n");
+			return -1;
+		}
+
+		for (i = 0; i < sizeof(spec_order)/sizeof(u16); i++) {
+			if (val & spec_order[i]) {
+				key.specified = spec_order[i] | enabled;
+				datum.data = le32_to_cpu(buf32[items++]);
+				rc = insertf(a, &key, &datum, p);
+				if (rc) return rc;
+			}
+		}
+
+		if (items != items2) {
+			printk("security: avtab: entry only had %d items, expected %d\n", items2, items);
+			return -1;
+		}
+		return 0;
 	}
-	rc = next_entry(buf, fp, sizeof(u32)*items2);
+
+	rc = next_entry(buf16, fp, sizeof(u16)*4);
 	if (rc < 0) {
-		printk(KERN_ERR "security: avtab: truncated entry\n");
-		goto bad;
+		printk("security: avtab: truncated entry\n");
+		return -1;
 	}
+
 	items = 0;
-	avkey->source_type = le32_to_cpu(buf[items++]);
-	avkey->target_type = le32_to_cpu(buf[items++]);
-	avkey->target_class = le32_to_cpu(buf[items++]);
-	avdatum->specified = le32_to_cpu(buf[items++]);
-	if (!(avdatum->specified & (AVTAB_AV | AVTAB_TYPE))) {
-		printk(KERN_ERR "security: avtab: null entry\n");
-		goto bad;
-	}
-	if ((avdatum->specified & AVTAB_AV) &&
-	    (avdatum->specified & AVTAB_TYPE)) {
-		printk(KERN_ERR "security: avtab: entry has both access vectors and types\n");
-		goto bad;
-	}
-	if (avdatum->specified & AVTAB_AV) {
-		if (avdatum->specified & AVTAB_ALLOWED)
-			avtab_allowed(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_AUDITDENY)
-			avtab_auditdeny(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_AUDITALLOW)
-			avtab_auditallow(avdatum) = le32_to_cpu(buf[items++]);
-	} else {
-		if (avdatum->specified & AVTAB_TRANSITION)
-			avtab_transition(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_CHANGE)
-			avtab_change(avdatum) = le32_to_cpu(buf[items++]);
-		if (avdatum->specified & AVTAB_MEMBER)
-			avtab_member(avdatum) = le32_to_cpu(buf[items++]);
-	}
-	if (items != items2) {
-		printk(KERN_ERR "security: avtab: entry only had %d items, expected %d\n",
-		       items2, items);
-		goto bad;
+	key.source_type = le16_to_cpu(buf16[items++]);
+	key.target_type = le16_to_cpu(buf16[items++]);
+	key.target_class = le16_to_cpu(buf16[items++]);
+	key.specified = le16_to_cpu(buf16[items++]);
+
+	rc = next_entry(buf32, fp, sizeof(u32));
+	if (rc < 0) {
+		printk("security: avtab: truncated entry\n");
+		return -1;
 	}
+	datum.data = le32_to_cpu(*buf32);
+	return insertf(a, &key, &datum, p);
+}
 
-	return 0;
-bad:
-	return -1;
+static int avtab_insertf(struct avtab *a, struct avtab_key *k,
+			 struct avtab_datum *d, void *p)
+{
+	return avtab_insert(a, k, d);
 }
 
-int avtab_read(struct avtab *a, void *fp, u32 config)
+int avtab_read(struct avtab *a, void *fp, u32 vers)
 {
 	int rc;
-	struct avtab_key avkey;
-	struct avtab_datum avdatum;
 	u32 buf[1];
 	u32 nel, i;
 
@@ -363,16 +419,14 @@ int avtab_read(struct avtab *a, void *fp
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
-		if (avtab_read_item(fp, &avdatum, &avkey)) {
-			rc = -EINVAL;
-			goto bad;
-		}
-		rc = avtab_insert(a, &avkey, &avdatum);
+		rc = avtab_read_item(fp,vers, a, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
 				printk(KERN_ERR "security: avtab: out of memory\n");
-			if (rc == -EEXIST)
+			else if (rc == -EEXIST)
 				printk(KERN_ERR "security: avtab: duplicate entry\n");
+			else
+				rc = -EINVAL;
 			goto bad;
 		}
 	}
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/avtab.h linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/avtab.h
--- linux-2.6.13-rc5-mm1/security/selinux/ss/avtab.h	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/avtab.h	2005-08-11 12:13:29.000000000 -0400
@@ -21,12 +21,9 @@
 #define _SS_AVTAB_H_
 
 struct avtab_key {
-	u32 source_type;	/* source type */
-	u32 target_type;	/* target type */
-	u32 target_class;	/* target object class */
-};
-
-struct avtab_datum {
+	u16 source_type;	/* source type */
+	u16 target_type;	/* target type */
+	u16 target_class;	/* target object class */
 #define AVTAB_ALLOWED     1
 #define AVTAB_AUDITALLOW  2
 #define AVTAB_AUDITDENY   4
@@ -35,15 +32,13 @@ struct avtab_datum {
 #define AVTAB_MEMBER     32
 #define AVTAB_CHANGE     64
 #define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
-#define AVTAB_ENABLED    0x80000000 /* reserved for used in cond_avtab */
-	u32 specified;	/* what fields are specified */
-	u32 data[3];	/* access vectors or types */
-#define avtab_allowed(x) (x)->data[0]
-#define avtab_auditdeny(x) (x)->data[1]
-#define avtab_auditallow(x) (x)->data[2]
-#define avtab_transition(x) (x)->data[0]
-#define avtab_change(x) (x)->data[1]
-#define avtab_member(x) (x)->data[2]
+#define AVTAB_ENABLED_OLD    0x80000000 /* reserved for used in cond_avtab */
+#define AVTAB_ENABLED    0x8000 /* reserved for used in cond_avtab */
+	u16 specified;	/* what field is specified */
+};
+
+struct avtab_datum {
+	u32 data; /* access vector or type value */
 };
 
 struct avtab_node {
@@ -58,17 +53,21 @@ struct avtab {
 };
 
 int avtab_init(struct avtab *);
-struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k, int specified);
+struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
 
-int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey);
-int avtab_read(struct avtab *a, void *fp, u32 config);
+int avtab_read_item(void *fp, uint32_t vers, struct avtab *a,
+		    int (*insert)(struct avtab *a, struct avtab_key *k,
+				  struct avtab_datum *d, void *p),
+		    void *p);
+
+int avtab_read(struct avtab *a, void *fp, u32 vers);
 
 struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
 					  struct avtab_datum *datum);
 
-struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key, int specified);
+struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key);
 
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/conditional.c linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/conditional.c
--- linux-2.6.13-rc5-mm1/security/selinux/ss/conditional.c	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/conditional.c	2005-08-11 12:13:29.000000000 -0400
@@ -100,18 +100,18 @@ int evaluate_cond_node(struct policydb *
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur != NULL; cur = cur->next) {
 			if (new_state <= 0) {
-				cur->node->datum.specified &= ~AVTAB_ENABLED;
+				cur->node->key.specified &= ~AVTAB_ENABLED;
 			} else {
-				cur->node->datum.specified |= AVTAB_ENABLED;
+				cur->node->key.specified |= AVTAB_ENABLED;
 			}
 		}
 
 		for (cur = node->false_list; cur != NULL; cur = cur->next) {
 			/* -1 or 1 */
 			if (new_state) {
-				cur->node->datum.specified &= ~AVTAB_ENABLED;
+				cur->node->key.specified &= ~AVTAB_ENABLED;
 			} else {
-				cur->node->datum.specified |= AVTAB_ENABLED;
+				cur->node->key.specified |= AVTAB_ENABLED;
 			}
 		}
 	}
@@ -252,104 +252,126 @@ err:
 	return -1;
 }
 
-static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list,
-			     struct cond_av_list *other)
+struct cond_insertf_data
 {
-	struct cond_av_list *list, *last = NULL, *cur;
-	struct avtab_key key;
-	struct avtab_datum datum;
+	struct policydb *p;
+	struct cond_av_list *other;
+	struct cond_av_list *head;
+	struct cond_av_list *tail;
+};
+
+static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
+{
+	struct cond_insertf_data *data = ptr;
+	struct policydb *p = data->p;
+	struct cond_av_list *other = data->other, *list, *cur;
 	struct avtab_node *node_ptr;
-	int rc;
-	u32 buf[1], i, len;
 	u8 found;
 
-	*ret_list = NULL;
-
-	len = 0;
-	rc = next_entry(buf, fp, sizeof buf);
-	if (rc < 0)
-		return -1;
-
-	len = le32_to_cpu(buf[0]);
-	if (len == 0) {
-		return 0;
-	}
 
-	for (i = 0; i < len; i++) {
-		if (avtab_read_item(fp, &datum, &key))
+	/*
+	 * For type rules we have to make certain there aren't any
+	 * conflicting rules by searching the te_avtab and the
+	 * cond_te_avtab.
+	 */
+	if (k->specified & AVTAB_TYPE) {
+		if (avtab_search(&p->te_avtab, k)) {
+			printk("security: type rule already exists outside of a conditional.");
 			goto err;
-
+		}
 		/*
-		 * For type rules we have to make certain there aren't any
-		 * conflicting rules by searching the te_avtab and the
-		 * cond_te_avtab.
+		 * If we are reading the false list other will be a pointer to
+		 * the true list. We can have duplicate entries if there is only
+		 * 1 other entry and it is in our true list.
+		 *
+		 * If we are reading the true list (other == NULL) there shouldn't
+		 * be any other entries.
 		 */
-		if (datum.specified & AVTAB_TYPE) {
-			if (avtab_search(&p->te_avtab, &key, AVTAB_TYPE)) {
-				printk("security: type rule already exists outside of a conditional.");
-				goto err;
-			}
-			/*
-			 * If we are reading the false list other will be a pointer to
-			 * the true list. We can have duplicate entries if there is only
-			 * 1 other entry and it is in our true list.
-			 *
-			 * If we are reading the true list (other == NULL) there shouldn't
-			 * be any other entries.
-			 */
-			if (other) {
-				node_ptr = avtab_search_node(&p->te_cond_avtab, &key, AVTAB_TYPE);
-				if (node_ptr) {
-					if (avtab_search_node_next(node_ptr, AVTAB_TYPE)) {
-						printk("security: too many conflicting type rules.");
-						goto err;
-					}
-					found = 0;
-					for (cur = other; cur != NULL; cur = cur->next) {
-						if (cur->node == node_ptr) {
-							found = 1;
-							break;
-						}
-					}
-					if (!found) {
-						printk("security: conflicting type rules.");
-						goto err;
+		if (other) {
+			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
+			if (node_ptr) {
+				if (avtab_search_node_next(node_ptr, k->specified)) {
+					printk("security: too many conflicting type rules.");
+					goto err;
+				}
+				found = 0;
+				for (cur = other; cur != NULL; cur = cur->next) {
+					if (cur->node == node_ptr) {
+						found = 1;
+						break;
 					}
 				}
-			} else {
-				if (avtab_search(&p->te_cond_avtab, &key, AVTAB_TYPE)) {
-					printk("security: conflicting type rules when adding type rule for true.");
+				if (!found) {
+					printk("security: conflicting type rules.\n");
 					goto err;
 				}
 			}
+		} else {
+			if (avtab_search(&p->te_cond_avtab, k)) {
+				printk("security: conflicting type rules when adding type rule for true.\n");
+				goto err;
+			}
 		}
-		node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, &key, &datum);
-		if (!node_ptr) {
-			printk("security: could not insert rule.");
-			goto err;
-		}
-
-		list = kmalloc(sizeof(struct cond_av_list), GFP_KERNEL);
-		if (!list)
-			goto err;
-		memset(list, 0, sizeof(struct cond_av_list));
-
-		list->node = node_ptr;
-		if (i == 0)
-			*ret_list = list;
-		else
-			last->next = list;
-		last = list;
+	}
 
+	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
+	if (!node_ptr) {
+		printk("security: could not insert rule.");
+		goto err;
 	}
 
+	list = kmalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+	if (!list)
+		goto err;
+	memset(list, 0, sizeof(*list));
+
+	list->node = node_ptr;
+	if (!data->head)
+		data->head = list;
+	else
+		data->tail->next = list;
+	data->tail = list;
 	return 0;
+
 err:
-	cond_av_list_destroy(*ret_list);
-	*ret_list = NULL;
+	cond_av_list_destroy(data->head);
+	data->head = NULL;
 	return -1;
 }
 
+static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
+{
+	int i, rc;
+	u32 buf[1], len;
+	struct cond_insertf_data data;
+
+	*ret_list = NULL;
+
+	len = 0;
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc < 0)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+	if (len == 0) {
+		return 0;
+	}
+
+	data.p = p;
+	data.other = other;
+	data.head = NULL;
+	data.tail = NULL;
+	for (i = 0; i < len; i++) {
+		rc = avtab_read_item(fp, p->policyvers, &p->te_cond_avtab, cond_insertf, &data);
+		if (rc)
+			return rc;
+
+	}
+
+	*ret_list = data.head;
+	return 0;
+}
+
 static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
@@ -452,6 +474,7 @@ int cond_read_list(struct policydb *p, v
 	return 0;
 err:
 	cond_list_destroy(p->cond_list);
+	p->cond_list = NULL;
 	return -1;
 }
 
@@ -465,22 +488,22 @@ void cond_compute_av(struct avtab *ctab,
 	if(!ctab || !key || !avd)
 		return;
 
-	for(node = avtab_search_node(ctab, key, AVTAB_AV); node != NULL;
-				node = avtab_search_node_next(node, AVTAB_AV)) {
-		if ( (__u32) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
-		     (node->datum.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
-			avd->allowed |= avtab_allowed(&node->datum);
-		if ( (__u32) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
-		     (node->datum.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+	for(node = avtab_search_node(ctab, key); node != NULL;
+				node = avtab_search_node_next(node, key->specified)) {
+		if ( (u16) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
+		     (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+			avd->allowed |= node->datum.data;
+		if ( (u16) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
+		     (node->key.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
 			/* Since a '0' in an auditdeny mask represents a
 			 * permission we do NOT want to audit (dontaudit), we use
 			 * the '&' operand to ensure that all '0's in the mask
 			 * are retained (much unlike the allow and auditallow cases).
 			 */
-			avd->auditdeny &= avtab_auditdeny(&node->datum);
-		if ( (__u32) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
-		     (node->datum.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
-			avd->auditallow |= avtab_auditallow(&node->datum);
+			avd->auditdeny &= node->datum.data;
+		if ( (u16) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
+		     (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+			avd->auditallow |= node->datum.data;
 	}
 	return;
 }
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/ebitmap.h linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/ebitmap.h
--- linux-2.6.13-rc5-mm1/security/selinux/ss/ebitmap.h	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/ebitmap.h	2005-08-11 12:13:29.000000000 -0400
@@ -32,11 +32,41 @@ struct ebitmap {
 #define ebitmap_length(e) ((e)->highbit)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 
+static inline unsigned int ebitmap_start(struct ebitmap *e,
+					 struct ebitmap_node **n)
+{
+	*n = e->node;
+	return ebitmap_startbit(e);
+}
+
 static inline void ebitmap_init(struct ebitmap *e)
 {
 	memset(e, 0, sizeof(*e));
 }
 
+static inline unsigned int ebitmap_next(struct ebitmap_node **n,
+					unsigned int bit)
+{
+	if ((bit == ((*n)->startbit + MAPSIZE - 1)) &&
+	    (*n)->next) {
+		*n = (*n)->next;
+		return (*n)->startbit;
+	}
+
+	return (bit+1);
+}
+
+static inline int ebitmap_node_get_bit(struct ebitmap_node * n,
+				       unsigned int bit)
+{
+	if (n->map & (MAPBIT << (bit - n->startbit)))
+		return 1;
+	return 0;
+}
+
+#define ebitmap_for_each_bit(e, n, bit) \
+	for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
+
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2);
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/mls.c linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/mls.c
--- linux-2.6.13-rc5-mm1/security/selinux/ss/mls.c	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/mls.c	2005-08-11 12:13:29.000000000 -0400
@@ -27,6 +27,7 @@
 int mls_compute_context_len(struct context * context)
 {
 	int i, l, len, range;
+	struct ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
 		return 0;
@@ -36,24 +37,24 @@ int mls_compute_context_len(struct conte
 		range = 0;
 		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 
-		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				if (range) {
 					range++;
 					continue;
 				}
 
-				len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
+				len += strlen(policydb.p_cat_val_to_name[i]) + 1;
 				range++;
 			} else {
 				if (range > 1)
-					len += strlen(policydb.p_cat_val_to_name[i - 2]) + 1;
+					len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
 				range = 0;
 			}
 		}
 		/* Handle case where last category is the end of range */
 		if (range > 1)
-			len += strlen(policydb.p_cat_val_to_name[i - 2]) + 1;
+			len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
 
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
@@ -77,6 +78,7 @@ void mls_sid_to_context(struct context *
 {
 	char *scontextp;
 	int i, l, range, wrote_sep;
+	struct ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
 		return;
@@ -94,8 +96,8 @@ void mls_sid_to_context(struct context *
 		scontextp += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 
 		/* categories */
-		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				if (range) {
 					range++;
 					continue;
@@ -106,8 +108,8 @@ void mls_sid_to_context(struct context *
 					wrote_sep = 1;
 				} else
 					*scontextp++ = ',';
-				strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
-				scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
+				strcpy(scontextp, policydb.p_cat_val_to_name[i]);
+				scontextp += strlen(policydb.p_cat_val_to_name[i]);
 				range++;
 			} else {
 				if (range > 1) {
@@ -116,8 +118,8 @@ void mls_sid_to_context(struct context *
 					else
 						*scontextp++ = ',';
 
-					strcpy(scontextp, policydb.p_cat_val_to_name[i - 2]);
-					scontextp += strlen(policydb.p_cat_val_to_name[i - 2]);
+					strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
+					scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
 				}
 				range = 0;
 			}
@@ -130,8 +132,8 @@ void mls_sid_to_context(struct context *
 			else
 				*scontextp++ = ',';
 
-			strcpy(scontextp, policydb.p_cat_val_to_name[i - 2]);
-			scontextp += strlen(policydb.p_cat_val_to_name[i - 2]);
+			strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
+			scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
 		}
 
 		if (l == 0) {
@@ -157,6 +159,7 @@ int mls_context_isvalid(struct policydb 
 {
 	struct level_datum *levdatum;
 	struct user_datum *usrdatum;
+	struct ebitmap_node *node;
 	int i, l;
 
 	if (!selinux_mls_enabled)
@@ -179,11 +182,11 @@ int mls_context_isvalid(struct policydb 
 		if (!levdatum)
 			return 0;
 
-		for (i = 1; i <= ebitmap_length(&c->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&c->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				if (i > p->p_cats.nprim)
 					return 0;
-				if (!ebitmap_get_bit(&levdatum->level->cat, i - 1))
+				if (!ebitmap_get_bit(&levdatum->level->cat, i))
 					/*
 					 * Category may not be associated with
 					 * sensitivity in low level.
@@ -468,6 +471,7 @@ int mls_convert_context(struct policydb 
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum;
 	struct ebitmap bitmap;
+	struct ebitmap_node *node;
 	int l, i;
 
 	if (!selinux_mls_enabled)
@@ -482,12 +486,12 @@ int mls_convert_context(struct policydb 
 		c->range.level[l].sens = levdatum->level->sens;
 
 		ebitmap_init(&bitmap);
-		for (i = 1; i <= ebitmap_length(&c->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&c->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				int rc;
 
 				catdatum = hashtab_search(newp->p_cats.table,
-				         	oldp->p_cat_val_to_name[i - 1]);
+				         	oldp->p_cat_val_to_name[i]);
 				if (!catdatum)
 					return -EINVAL;
 				rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/policydb.c linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/policydb.c
--- linux-2.6.13-rc5-mm1/security/selinux/ss/policydb.c	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/policydb.c	2005-08-11 12:13:29.000000000 -0400
@@ -91,6 +91,11 @@ static struct policydb_compat_info polic
 		.sym_num        = SYM_NUM,
 		.ocon_num       = OCON_NUM,
 	},
+	{
+		.version        = POLICYDB_VERSION_AVTAB,
+		.sym_num        = SYM_NUM,
+		.ocon_num       = OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -584,6 +589,9 @@ void policydb_destroy(struct policydb *p
 	struct ocontext *c, *ctmp;
 	struct genfs *g, *gtmp;
 	int i;
+	struct role_allow *ra, *lra = NULL;
+	struct role_trans *tr, *ltr = NULL;
+	struct range_trans *rt, *lrt = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
@@ -624,6 +632,28 @@ void policydb_destroy(struct policydb *p
 
 	cond_policydb_destroy(p);
 
+	for (tr = p->role_tr; tr; tr = tr->next) {
+		if (ltr) kfree(ltr);
+		ltr = tr;
+	}
+	if (ltr) kfree(ltr);
+
+	for (ra = p->role_allow; ra; ra = ra -> next) {
+		if (lra) kfree(lra);
+		lra = ra;
+	}
+	if (lra) kfree(lra);
+
+	for (rt = p->range_tr; rt; rt = rt -> next) {
+		if (lrt) kfree(lrt);
+		lrt = rt;
+	}
+	if (lrt) kfree(lrt);
+
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_destroy(&p->type_attr_map[i]);
+	kfree(p->type_attr_map);
+
 	return;
 }
 
@@ -1511,7 +1541,7 @@ int policydb_read(struct policydb *p, vo
 		p->symtab[i].nprim = nprim;
 	}
 
-	rc = avtab_read(&p->te_avtab, fp, config);
+	rc = avtab_read(&p->te_avtab, fp, p->policyvers);
 	if (rc)
 		goto bad;
 
@@ -1825,6 +1855,21 @@ int policydb_read(struct policydb *p, vo
 		}
 	}
 
+	p->type_attr_map = kmalloc(p->p_types.nprim*sizeof(struct ebitmap), GFP_KERNEL);
+	if (!p->type_attr_map)
+		goto bad;
+
+	for (i = 0; i < p->p_types.nprim; i++) {
+		ebitmap_init(&p->type_attr_map[i]);
+		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
+			if (ebitmap_read(&p->type_attr_map[i], fp))
+				goto bad;
+		}
+		/* add the type itself as the degenerate case */
+		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
+				goto bad;
+	}
+
 	rc = 0;
 out:
 	return rc;
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/policydb.h linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/policydb.h
--- linux-2.6.13-rc5-mm1/security/selinux/ss/policydb.h	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/policydb.h	2005-08-11 12:13:29.000000000 -0400
@@ -237,6 +237,9 @@ struct policydb {
 	/* range transitions */
 	struct range_trans *range_tr;
 
+	/* type -> attribute reverse mapping */
+	struct ebitmap *type_attr_map;
+
 	unsigned int policyvers;
 };
 
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1/security/selinux/ss/services.c linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/services.c
--- linux-2.6.13-rc5-mm1/security/selinux/ss/services.c	2005-08-11 13:20:28.000000000 -0400
+++ linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/services.c	2005-08-11 12:13:29.000000000 -0400
@@ -266,8 +266,11 @@ static int context_struct_compute_av(str
 	struct constraint_node *constraint;
 	struct role_allow *ra;
 	struct avtab_key avkey;
-	struct avtab_datum *avdatum;
+	struct avtab_node *node;
 	struct class_datum *tclass_datum;
+	struct ebitmap *sattr, *tattr;
+	struct ebitmap_node *snode, *tnode;
+	unsigned int i, j;
 
 	/*
 	 * Remap extended Netlink classes for old policy versions.
@@ -300,21 +303,34 @@ static int context_struct_compute_av(str
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
-	avkey.source_type = scontext->type;
-	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
-	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_AV);
-	if (avdatum) {
-		if (avdatum->specified & AVTAB_ALLOWED)
-			avd->allowed = avtab_allowed(avdatum);
-		if (avdatum->specified & AVTAB_AUDITDENY)
-			avd->auditdeny = avtab_auditdeny(avdatum);
-		if (avdatum->specified & AVTAB_AUDITALLOW)
-			avd->auditallow = avtab_auditallow(avdatum);
-	}
+	avkey.specified = AVTAB_AV;
+	sattr = &policydb.type_attr_map[scontext->type - 1];
+	tattr = &policydb.type_attr_map[tcontext->type - 1];
+	ebitmap_for_each_bit(sattr, snode, i) {
+		if (!ebitmap_node_get_bit(snode, i))
+			continue;
+		ebitmap_for_each_bit(tattr, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
+				continue;
+			avkey.source_type = i + 1;
+			avkey.target_type = j + 1;
+			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
+			     node != NULL;
+			     node = avtab_search_node_next(node, avkey.specified)) {
+				if (node->key.specified == AVTAB_ALLOWED)
+					avd->allowed |= node->datum.data;
+				else if (node->key.specified == AVTAB_AUDITALLOW)
+					avd->auditallow |= node->datum.data;
+				else if (node->key.specified == AVTAB_AUDITDENY)
+					avd->auditdeny &= node->datum.data;
+			}
 
-	/* Check conditional av table for additional permissions */
-	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+			/* Check conditional av table for additional permissions */
+			cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+
+		}
+	}
 
 	/*
 	 * Remove any permissions prohibited by a constraint (this includes
@@ -797,7 +813,6 @@ static int security_compute_sid(u32 ssid
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
 	struct avtab_node *node;
-	unsigned int type_change = 0;
 	int rc = 0;
 
 	if (!ss_initialized) {
@@ -862,33 +877,23 @@ static int security_compute_sid(u32 ssid
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
-	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_TYPE);
+	avkey.specified = specified;
+	avdatum = avtab_search(&policydb.te_avtab, &avkey);
 
 	/* If no permanent rule, also check for enabled conditional rules */
 	if(!avdatum) {
-		node = avtab_search_node(&policydb.te_cond_avtab, &avkey, specified);
+		node = avtab_search_node(&policydb.te_cond_avtab, &avkey);
 		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
-			if (node->datum.specified & AVTAB_ENABLED) {
+			if (node->key.specified & AVTAB_ENABLED) {
 				avdatum = &node->datum;
 				break;
 			}
 		}
 	}
 
-	type_change = (avdatum && (avdatum->specified & specified));
-	if (type_change) {
+	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
-		switch (specified) {
-		case AVTAB_TRANSITION:
-			newcontext.type = avtab_transition(avdatum);
-			break;
-		case AVTAB_MEMBER:
-			newcontext.type = avtab_member(avdatum);
-			break;
-		case AVTAB_CHANGE:
-			newcontext.type = avtab_change(avdatum);
-			break;
-		}
+		newcontext.type = avdatum->data;
 	}
 
 	/* Check for class-specific changes. */
@@ -1502,6 +1507,7 @@ int security_get_user_sids(u32 fromsid,
 	struct user_datum *user;
 	struct role_datum *role;
 	struct av_decision avd;
+	struct ebitmap_node *rnode, *tnode;
 	int rc = 0, i, j;
 
 	if (!ss_initialized) {
@@ -1532,13 +1538,13 @@ int security_get_user_sids(u32 fromsid,
 	}
 	memset(mysids, 0, maxnel*sizeof(*mysids));
 
-	for (i = ebitmap_startbit(&user->roles); i < ebitmap_length(&user->roles); i++) {
-		if (!ebitmap_get_bit(&user->roles, i))
+	ebitmap_for_each_bit(&user->roles, rnode, i) {
+		if (!ebitmap_node_get_bit(rnode, i))
 			continue;
 		role = policydb.role_val_to_struct[i];
 		usercon.role = i+1;
-		for (j = ebitmap_startbit(&role->types); j < ebitmap_length(&role->types); j++) {
-			if (!ebitmap_get_bit(&role->types, j))
+		ebitmap_for_each_bit(&role->types, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
 			usercon.type = j+1;
 

-- 
Stephen Smalley
National Security Agency

