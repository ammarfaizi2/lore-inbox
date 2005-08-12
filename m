Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVHLVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVHLVGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVHLVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:06:42 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:42147 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750856AbVHLVGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:06:41 -0400
Subject: [patch][-mm] selinux: endian notations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050811203455.GA16409@mipter.zuzino.mipt.ru>
References: <1123788744.7810.115.camel@moss-spartans.epoch.ncsc.mil>
	 <20050811203455.GA16409@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 12 Aug 2005 17:04:36 -0400
Message-Id: <1123880676.23483.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds endian notations to the SELinux code.
It is relative to my prior patch, and is just an updated version of
Alexey's original patch (I hope) adjusted for the new code.

Please add it to -mm as well.  Thanks.

From:  Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/avc.c            |    4 +-
 security/selinux/ss/avtab.c       |    8 +++--
 security/selinux/ss/conditional.c |   12 +++++--
 security/selinux/ss/ebitmap.c     |    5 +--
 security/selinux/ss/policydb.c    |   60 +++++++++++++++++++++-----------------
 5 files changed, 52 insertions(+), 37 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1-avtab/security/selinux/avc.c linux-2.6.13-rc5-endian/security/selinux/avc.c
--- linux-2.6.13-rc5-mm1-avtab/security/selinux/avc.c	2005-08-12 09:07:42.000000000 -0400
+++ linux-2.6.13-rc5-endian/security/selinux/avc.c	2005-08-12 09:04:48.000000000 -0400
@@ -490,7 +490,7 @@ out:
 }
 
 static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
-				       struct in6_addr *addr, u16 port,
+				       struct in6_addr *addr, __be16 port,
 				       char *name1, char *name2)
 {
 	if (!ipv6_addr_any(addr))
@@ -501,7 +501,7 @@ static inline void avc_print_ipv6_addr(s
 }
 
 static inline void avc_print_ipv4_addr(struct audit_buffer *ab, u32 addr,
-				       u16 port, char *name1, char *name2)
+				       __be16 port, char *name1, char *name2)
 {
 	if (addr)
 		audit_log_format(ab, " %s=%d.%d.%d.%d", name1, NIPQUAD(addr));
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/avtab.c linux-2.6.13-rc5-endian/security/selinux/ss/avtab.c
--- linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/avtab.c	2005-08-12 09:15:51.000000000 -0400
+++ linux-2.6.13-rc5-endian/security/selinux/ss/avtab.c	2005-08-12 09:02:56.000000000 -0400
@@ -297,8 +297,10 @@ int avtab_read_item(void *fp, u32 vers, 
 				   struct avtab_datum *d, void *p),
 		    void *p)
 {
-	u16 buf16[4], enabled;
-	u32 buf32[7], items, items2, val;
+	__le16 buf16[4];
+	u16 enabled;
+	__le32 buf32[7];
+	u32 items, items2, val;
 	struct avtab_key key;
 	struct avtab_datum datum;
 	int i, rc;
@@ -403,7 +405,7 @@ static int avtab_insertf(struct avtab *a
 int avtab_read(struct avtab *a, void *fp, u32 vers)
 {
 	int rc;
-	u32 buf[1];
+	__le32 buf[1];
 	u32 nel, i;
 
 
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/conditional.c linux-2.6.13-rc5-endian/security/selinux/ss/conditional.c
--- linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/conditional.c	2005-08-12 09:15:51.000000000 -0400
+++ linux-2.6.13-rc5-endian/security/selinux/ss/conditional.c	2005-08-12 09:08:27.000000000 -0400
@@ -216,7 +216,8 @@ int cond_read_bool(struct policydb *p, s
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 	int rc;
 
 	booldatum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
@@ -342,7 +343,8 @@ err:
 static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
 {
 	int i, rc;
-	u32 buf[1], len;
+	__le32 buf[1];
+	u32 len;
 	struct cond_insertf_data data;
 
 	*ret_list = NULL;
@@ -388,7 +390,8 @@ static int expr_isvalid(struct policydb 
 
 static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 {
-	u32 buf[2], len, i;
+	__le32 buf[2];
+	u32 len, i;
 	int rc;
 	struct cond_expr *expr = NULL, *last = NULL;
 
@@ -446,7 +449,8 @@ err:
 int cond_read_list(struct policydb *p, void *fp)
 {
 	struct cond_node *node, *last = NULL;
-	u32 buf[1], i, len;
+	__le32 buf[1];
+	u32 i, len;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/ebitmap.c linux-2.6.13-rc5-endian/security/selinux/ss/ebitmap.c
--- linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/ebitmap.c	2005-08-12 09:07:42.000000000 -0400
+++ linux-2.6.13-rc5-endian/security/selinux/ss/ebitmap.c	2005-08-12 08:43:33.000000000 -0400
@@ -196,8 +196,9 @@ int ebitmap_read(struct ebitmap *e, void
 {
 	int rc;
 	struct ebitmap_node *n, *l;
-	u32 buf[3], mapsize, count, i;
-	u64 map;
+	__le32 buf[3];
+	u32 mapsize, count, i;
+	__le64 map;
 
 	ebitmap_init(e);
 
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/policydb.c linux-2.6.13-rc5-endian/security/selinux/ss/policydb.c
--- linux-2.6.13-rc5-mm1-avtab/security/selinux/ss/policydb.c	2005-08-12 09:15:51.000000000 -0400
+++ linux-2.6.13-rc5-endian/security/selinux/ss/policydb.c	2005-08-12 16:35:31.000000000 -0400
@@ -744,7 +744,8 @@ int policydb_context_isvalid(struct poli
  */
 static int mls_read_range_helper(struct mls_range *r, void *fp)
 {
-	u32 buf[2], items;
+	__le32 buf[2];
+	u32 items;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(u32));
@@ -805,7 +806,7 @@ static int context_read_and_validate(str
 				     struct policydb *p,
 				     void *fp)
 {
-	u32 buf[3];
+	__le32 buf[3];
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof buf);
@@ -845,7 +846,8 @@ static int perm_read(struct policydb *p,
 	char *key = NULL;
 	struct perm_datum *perdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	perdatum = kmalloc(sizeof(*perdatum), GFP_KERNEL);
 	if (!perdatum) {
@@ -885,7 +887,8 @@ static int common_read(struct policydb *
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
-	u32 buf[4], len, nel;
+	__le32 buf[4];
+	u32 len, nel;
 	int i, rc;
 
 	comdatum = kmalloc(sizeof(*comdatum), GFP_KERNEL);
@@ -939,7 +942,8 @@ static int read_cons_helper(struct const
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
-	u32 buf[3], nexpr;
+	__le32 buf[3];
+	u32 nexpr;
 	int rc, i, j, depth;
 
 	lc = NULL;
@@ -1023,7 +1027,8 @@ static int class_read(struct policydb *p
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
-	u32 buf[6], len, len2, ncons, nel;
+	__le32 buf[6];
+	u32 len, len2, ncons, nel;
 	int i, rc;
 
 	cladatum = kmalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1117,7 +1122,8 @@ static int role_read(struct policydb *p,
 	char *key = NULL;
 	struct role_datum *role;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	role = kmalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
@@ -1177,7 +1183,8 @@ static int type_read(struct policydb *p,
 	char *key = NULL;
 	struct type_datum *typdatum;
 	int rc;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 
 	typdatum = kmalloc(sizeof(*typdatum),GFP_KERNEL);
 	if (!typdatum) {
@@ -1221,7 +1228,7 @@ bad:
  */
 static int mls_read_level(struct mls_level *lp, void *fp)
 {
-	u32 buf[1];
+	__le32 buf[1];
 	int rc;
 
 	memset(lp, 0, sizeof(*lp));
@@ -1249,7 +1256,8 @@ static int user_read(struct policydb *p,
 	char *key = NULL;
 	struct user_datum *usrdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	usrdatum = kmalloc(sizeof(*usrdatum), GFP_KERNEL);
 	if (!usrdatum) {
@@ -1303,7 +1311,8 @@ static int sens_read(struct policydb *p,
 	char *key = NULL;
 	struct level_datum *levdatum;
 	int rc;
-	u32 buf[2], len;
+	__le32 buf[2];
+	u32 len;
 
 	levdatum = kmalloc(sizeof(*levdatum), GFP_ATOMIC);
 	if (!levdatum) {
@@ -1354,7 +1363,8 @@ static int cat_read(struct policydb *p, 
 	char *key = NULL;
 	struct cat_datum *catdatum;
 	int rc;
-	u32 buf[3], len;
+	__le32 buf[3];
+	u32 len;
 
 	catdatum = kmalloc(sizeof(*catdatum), GFP_ATOMIC);
 	if (!catdatum) {
@@ -1417,7 +1427,8 @@ int policydb_read(struct policydb *p, vo
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc;
-	u32 buf[8], len, len2, config, nprim, nel, nel2;
+	__le32 buf[8];
+	u32 len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
 	struct range_trans *rt, *lrt;
@@ -1433,17 +1444,14 @@ int policydb_read(struct policydb *p, vo
 	if (rc < 0)
 		goto bad;
 
-	for (i = 0; i < 2; i++)
-		buf[i] = le32_to_cpu(buf[i]);
-
-	if (buf[0] != POLICYDB_MAGIC) {
+	if (le32_to_cpu(buf[0]) != POLICYDB_MAGIC) {
 		printk(KERN_ERR "security:  policydb magic number 0x%x does "
 		       "not match expected magic number 0x%x\n",
-		       buf[0], POLICYDB_MAGIC);
+		       le32_to_cpu(buf[0]), POLICYDB_MAGIC);
 		goto bad;
 	}
 
-	len = buf[1];
+	len = le32_to_cpu(buf[1]);
 	if (len != strlen(POLICYDB_STRING)) {
 		printk(KERN_ERR "security:  policydb string length %d does not "
 		       "match expected length %Zu\n",
@@ -1478,19 +1486,17 @@ int policydb_read(struct policydb *p, vo
 	rc = next_entry(buf, fp, sizeof(u32)*4);
 	if (rc < 0)
 		goto bad;
-	for (i = 0; i < 4; i++)
-		buf[i] = le32_to_cpu(buf[i]);
 
-	p->policyvers = buf[0];
+	p->policyvers = le32_to_cpu(buf[0]);
 	if (p->policyvers < POLICYDB_VERSION_MIN ||
 	    p->policyvers > POLICYDB_VERSION_MAX) {
 	    	printk(KERN_ERR "security:  policydb version %d does not match "
 	    	       "my version range %d-%d\n",
-	    	       buf[0], POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+	    	       le32_to_cpu(buf[0]), POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	    	goto bad;
 	}
 
-	if ((buf[1] & POLICYDB_CONFIG_MLS)) {
+	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
 		if (ss_initialized && !selinux_mls_enabled) {
 			printk(KERN_ERR "Cannot switch between non-MLS and MLS "
 			       "policies\n");
@@ -1519,9 +1525,11 @@ int policydb_read(struct policydb *p, vo
 		goto bad;
 	}
 
-	if (buf[2] != info->sym_num || buf[3] != info->ocon_num) {
+	if (le32_to_cpu(buf[2]) != info->sym_num || 
+		le32_to_cpu(buf[3]) != info->ocon_num) {
 		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
-		       "not match mine (%d,%d)\n", buf[2], buf[3],
+		       "not match mine (%d,%d)\n", le32_to_cpu(buf[2]), 
+			le32_to_cpu(buf[3]),
 		       info->sym_num, info->ocon_num);
 		goto bad;
 	}


-- 
Stephen Smalley
National Security Agency

