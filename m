Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbVIMUhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbVIMUhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVIMUhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:37:53 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:62648 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932511AbVIMUhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:37:51 -0400
Date: Tue, 13 Sep 2005 16:37:49 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil
Subject: Re: [PATCH] SELinux - convert to kzalloc
In-Reply-To: <20050913120707.74a19800.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0509131636030.5124@excalibur.intercode>
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
 <20050913120707.74a19800.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Andrew Morton wrote:

> SELinux seems to do a lot of kzalloc(a * b, flags):
> 
>  +	mysids = kzalloc(maxnel*sizeof(*mysids), GFP_ATOMIC);
>  +	*names = (char**)kzalloc(sizeof(char*) * *len, GFP_ATOMIC);
>  +	mysids2 = kzalloc(maxnel*sizeof(*mysids2), GFP_ATOMIC);
> 
> Consider using kcalloc() here.

Ok, updated patch below (found four of them).

Signed-off-by: James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c          |   24 +++++------------
 security/selinux/netif.c          |    3 --
 security/selinux/selinuxfs.c      |   30 +++++++---------------
 security/selinux/ss/conditional.c |   12 ++------
 security/selinux/ss/ebitmap.c     |    9 ++----
 security/selinux/ss/hashtab.c     |    6 +---
 security/selinux/ss/policydb.c    |   51 ++++++++++++--------------------------
 security/selinux/ss/services.c    |   11 ++------
 8 files changed, 49 insertions(+), 97 deletions(-)

diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/hooks.c linux-2.6.13-mm2.w/security/selinux/hooks.c
--- linux-2.6.13-mm2.o/security/selinux/hooks.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/hooks.c	2005-09-13 16:23:44.000000000 -0400
@@ -122,11 +122,10 @@ static int task_alloc_security(struct ta
 {
 	struct task_security_struct *tsec;
 
-	tsec = kmalloc(sizeof(struct task_security_struct), GFP_KERNEL);
+	tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
 	if (!tsec)
 		return -ENOMEM;
 
-	memset(tsec, 0, sizeof(struct task_security_struct));
 	tsec->magic = SELINUX_MAGIC;
 	tsec->task = task;
 	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
@@ -151,11 +150,10 @@ static int inode_alloc_security(struct i
 	struct task_security_struct *tsec = current->security;
 	struct inode_security_struct *isec;
 
-	isec = kmalloc(sizeof(struct inode_security_struct), GFP_KERNEL);
+	isec = kzalloc(sizeof(struct inode_security_struct), GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;
 
-	memset(isec, 0, sizeof(struct inode_security_struct));
 	init_MUTEX(&isec->sem);
 	INIT_LIST_HEAD(&isec->list);
 	isec->magic = SELINUX_MAGIC;
@@ -193,11 +191,10 @@ static int file_alloc_security(struct fi
 	struct task_security_struct *tsec = current->security;
 	struct file_security_struct *fsec;
 
-	fsec = kmalloc(sizeof(struct file_security_struct), GFP_ATOMIC);
+	fsec = kzalloc(sizeof(struct file_security_struct), GFP_ATOMIC);
 	if (!fsec)
 		return -ENOMEM;
 
-	memset(fsec, 0, sizeof(struct file_security_struct));
 	fsec->magic = SELINUX_MAGIC;
 	fsec->file = file;
 	if (tsec && tsec->magic == SELINUX_MAGIC) {
@@ -227,11 +224,10 @@ static int superblock_alloc_security(str
 {
 	struct superblock_security_struct *sbsec;
 
-	sbsec = kmalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
+	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
 	if (!sbsec)
 		return -ENOMEM;
 
-	memset(sbsec, 0, sizeof(struct superblock_security_struct));
 	init_MUTEX(&sbsec->sem);
 	INIT_LIST_HEAD(&sbsec->list);
 	INIT_LIST_HEAD(&sbsec->isec_head);
@@ -269,11 +265,10 @@ static int sk_alloc_security(struct sock
 	if (family != PF_UNIX)
 		return 0;
 
-	ssec = kmalloc(sizeof(*ssec), priority);
+	ssec = kzalloc(sizeof(*ssec), priority);
 	if (!ssec)
 		return -ENOMEM;
 
-	memset(ssec, 0, sizeof(*ssec));
 	ssec->magic = SELINUX_MAGIC;
 	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
@@ -1467,11 +1462,10 @@ static int selinux_bprm_alloc_security(s
 {
 	struct bprm_security_struct *bsec;
 
-	bsec = kmalloc(sizeof(struct bprm_security_struct), GFP_KERNEL);
+	bsec = kzalloc(sizeof(struct bprm_security_struct), GFP_KERNEL);
 	if (!bsec)
 		return -ENOMEM;
 
-	memset(bsec, 0, sizeof *bsec);
 	bsec->magic = SELINUX_MAGIC;
 	bsec->bprm = bprm;
 	bsec->sid = SECINITSID_UNLABELED;
@@ -3581,11 +3575,10 @@ static int ipc_alloc_security(struct tas
 	struct task_security_struct *tsec = task->security;
 	struct ipc_security_struct *isec;
 
-	isec = kmalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
+	isec = kzalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;
 
-	memset(isec, 0, sizeof(struct ipc_security_struct));
 	isec->magic = SELINUX_MAGIC;
 	isec->sclass = sclass;
 	isec->ipc_perm = perm;
@@ -3613,11 +3606,10 @@ static int msg_msg_alloc_security(struct
 {
 	struct msg_security_struct *msec;
 
-	msec = kmalloc(sizeof(struct msg_security_struct), GFP_KERNEL);
+	msec = kzalloc(sizeof(struct msg_security_struct), GFP_KERNEL);
 	if (!msec)
 		return -ENOMEM;
 
-	memset(msec, 0, sizeof(struct msg_security_struct));
 	msec->magic = SELINUX_MAGIC;
 	msec->msg = msg;
 	msec->sid = SECINITSID_UNLABELED;
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/netif.c linux-2.6.13-mm2.w/security/selinux/netif.c
--- linux-2.6.13-mm2.o/security/selinux/netif.c	2005-03-02 02:38:09.000000000 -0500
+++ linux-2.6.13-mm2.w/security/selinux/netif.c	2005-09-13 16:23:44.000000000 -0400
@@ -114,13 +114,12 @@ static struct sel_netif *sel_netif_looku
 	if (likely(netif != NULL))
 		goto out;
 	
-	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
 	if (!new) {
 		netif = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 	
-	memset(new, 0, sizeof(*new));
 	nsec = &new->nsec;
 
 	ret = security_netif_sid(dev->name, &nsec->if_sid, &nsec->msg_sid);
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/selinuxfs.c linux-2.6.13-mm2.w/security/selinux/selinuxfs.c
--- linux-2.6.13-mm2.o/security/selinux/selinuxfs.c	2005-08-29 00:36:42.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/selinuxfs.c	2005-09-13 16:23:44.000000000 -0400
@@ -424,15 +424,13 @@ static ssize_t sel_write_access(struct f
 		return length;
 
 	length = -ENOMEM;
-	scon = kmalloc(size+1, GFP_KERNEL);
+	scon = kzalloc(size+1, GFP_KERNEL);
 	if (!scon)
 		return length;
-	memset(scon, 0, size+1);
 
-	tcon = kmalloc(size+1, GFP_KERNEL);
+	tcon = kzalloc(size+1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
-	memset(tcon, 0, size+1);
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
@@ -475,15 +473,13 @@ static ssize_t sel_write_create(struct f
 		return length;
 
 	length = -ENOMEM;
-	scon = kmalloc(size+1, GFP_KERNEL);
+	scon = kzalloc(size+1, GFP_KERNEL);
 	if (!scon)
 		return length;
-	memset(scon, 0, size+1);
 
-	tcon = kmalloc(size+1, GFP_KERNEL);
+	tcon = kzalloc(size+1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
-	memset(tcon, 0, size+1);
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
@@ -536,15 +532,13 @@ static ssize_t sel_write_relabel(struct 
 		return length;
 
 	length = -ENOMEM;
-	scon = kmalloc(size+1, GFP_KERNEL);
+	scon = kzalloc(size+1, GFP_KERNEL);
 	if (!scon)
 		return length;
-	memset(scon, 0, size+1);
 
-	tcon = kmalloc(size+1, GFP_KERNEL);
+	tcon = kzalloc(size+1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
-	memset(tcon, 0, size+1);
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
@@ -595,15 +589,13 @@ static ssize_t sel_write_user(struct fil
 		return length;
 
 	length = -ENOMEM;
-	con = kmalloc(size+1, GFP_KERNEL);
+	con = kzalloc(size+1, GFP_KERNEL);
 	if (!con)
 		return length;
-	memset(con, 0, size+1);
 
-	user = kmalloc(size+1, GFP_KERNEL);
+	user = kzalloc(size+1, GFP_KERNEL);
 	if (!user)
 		goto out;
-	memset(user, 0, size+1);
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s", con, user) != 2)
@@ -658,15 +650,13 @@ static ssize_t sel_write_member(struct f
 		return length;
 
 	length = -ENOMEM;
-	scon = kmalloc(size+1, GFP_KERNEL);
+	scon = kzalloc(size+1, GFP_KERNEL);
 	if (!scon)
 		return length;
-	memset(scon, 0, size+1);
 
-	tcon = kmalloc(size+1, GFP_KERNEL);
+	tcon = kzalloc(size+1, GFP_KERNEL);
 	if (!tcon)
 		goto out;
-	memset(tcon, 0, size+1);
 
 	length = -EINVAL;
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/ss/conditional.c linux-2.6.13-mm2.w/security/selinux/ss/conditional.c
--- linux-2.6.13-mm2.o/security/selinux/ss/conditional.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/ss/conditional.c	2005-09-13 16:23:44.000000000 -0400
@@ -220,10 +220,9 @@ int cond_read_bool(struct policydb *p, s
 	u32 len;
 	int rc;
 
-	booldatum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	booldatum = kzalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
 	if (!booldatum)
 		return -1;
-	memset(booldatum, 0, sizeof(struct cond_bool_datum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -321,10 +320,9 @@ static int cond_insertf(struct avtab *a,
 		goto err;
 	}
 
-	list = kmalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+	list = kzalloc(sizeof(struct cond_av_list), GFP_KERNEL);
 	if (!list)
 		goto err;
-	memset(list, 0, sizeof(*list));
 
 	list->node = node_ptr;
 	if (!data->head)
@@ -414,11 +412,10 @@ static int cond_read_node(struct policyd
 		if (rc < 0)
 			goto err;
 
-		expr = kmalloc(sizeof(struct cond_expr), GFP_KERNEL);
+		expr = kzalloc(sizeof(struct cond_expr), GFP_KERNEL);
 		if (!expr) {
 			goto err;
 		}
-		memset(expr, 0, sizeof(struct cond_expr));
 
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
@@ -460,10 +457,9 @@ int cond_read_list(struct policydb *p, v
 	len = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < len; i++) {
-		node = kmalloc(sizeof(struct cond_node), GFP_KERNEL);
+		node = kzalloc(sizeof(struct cond_node), GFP_KERNEL);
 		if (!node)
 			goto err;
-		memset(node, 0, sizeof(struct cond_node));
 
 		if (cond_read_node(p, node, fp) != 0)
 			goto err;
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/ss/ebitmap.c linux-2.6.13-mm2.w/security/selinux/ss/ebitmap.c
--- linux-2.6.13-mm2.o/security/selinux/ss/ebitmap.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/ss/ebitmap.c	2005-09-13 16:23:44.000000000 -0400
@@ -39,12 +39,11 @@ int ebitmap_cpy(struct ebitmap *dst, str
 	n = src->node;
 	prev = NULL;
 	while (n) {
-		new = kmalloc(sizeof(*new), GFP_ATOMIC);
+		new = kzalloc(sizeof(*new), GFP_ATOMIC);
 		if (!new) {
 			ebitmap_destroy(dst);
 			return -ENOMEM;
 		}
-		memset(new, 0, sizeof(*new));
 		new->startbit = n->startbit;
 		new->map = n->map;
 		new->next = NULL;
@@ -150,10 +149,9 @@ int ebitmap_set_bit(struct ebitmap *e, u
 	if (!value)
 		return 0;
 
-	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
 	if (!new)
 		return -ENOMEM;
-	memset(new, 0, sizeof(*new));
 
 	new->startbit = bit & ~(MAPSIZE - 1);
 	new->map = (MAPBIT << (bit - new->startbit));
@@ -232,13 +230,12 @@ int ebitmap_read(struct ebitmap *e, void
 			printk(KERN_ERR "security: ebitmap: truncated map\n");
 			goto bad;
 		}
-		n = kmalloc(sizeof(*n), GFP_KERNEL);
+		n = kzalloc(sizeof(*n), GFP_KERNEL);
 		if (!n) {
 			printk(KERN_ERR "security: ebitmap: out of memory\n");
 			rc = -ENOMEM;
 			goto bad;
 		}
-		memset(n, 0, sizeof(*n));
 
 		n->startbit = le32_to_cpu(buf[0]);
 
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/ss/hashtab.c linux-2.6.13-mm2.w/security/selinux/ss/hashtab.c
--- linux-2.6.13-mm2.o/security/selinux/ss/hashtab.c	2005-06-19 13:29:33.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/ss/hashtab.c	2005-09-13 16:23:44.000000000 -0400
@@ -15,11 +15,10 @@ struct hashtab *hashtab_create(u32 (*has
 	struct hashtab *p;
 	u32 i;
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p == NULL)
 		return p;
 
-	memset(p, 0, sizeof(*p));
 	p->size = size;
 	p->nel = 0;
 	p->hash_value = hash_value;
@@ -55,10 +54,9 @@ int hashtab_insert(struct hashtab *h, vo
 	if (cur && (h->keycmp(h, key, cur->key) == 0))
 		return -EEXIST;
 
-	newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);
+	newnode = kzalloc(sizeof(*newnode), GFP_KERNEL);
 	if (newnode == NULL)
 		return -ENOMEM;
-	memset(newnode, 0, sizeof(*newnode));
 	newnode->key = key;
 	newnode->datum = datum;
 	if (prev) {
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/ss/policydb.c linux-2.6.13-mm2.w/security/selinux/ss/policydb.c
--- linux-2.6.13-mm2.o/security/selinux/ss/policydb.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/ss/policydb.c	2005-09-13 16:23:44.000000000 -0400
@@ -121,12 +121,11 @@ static int roles_init(struct policydb *p
 	int rc;
 	struct role_datum *role;
 
-	role = kmalloc(sizeof(*role), GFP_KERNEL);
+	role = kzalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(role, 0, sizeof(*role));
 	role->value = ++p->p_roles.nprim;
 	if (role->value != OBJECT_R_VAL) {
 		rc = -EINVAL;
@@ -849,12 +848,11 @@ static int perm_read(struct policydb *p,
 	__le32 buf[2];
 	u32 len;
 
-	perdatum = kmalloc(sizeof(*perdatum), GFP_KERNEL);
+	perdatum = kzalloc(sizeof(*perdatum), GFP_KERNEL);
 	if (!perdatum) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(perdatum, 0, sizeof(*perdatum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -891,12 +889,11 @@ static int common_read(struct policydb *
 	u32 len, nel;
 	int i, rc;
 
-	comdatum = kmalloc(sizeof(*comdatum), GFP_KERNEL);
+	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
 	if (!comdatum) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(comdatum, 0, sizeof(*comdatum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -948,10 +945,9 @@ static int read_cons_helper(struct const
 
 	lc = NULL;
 	for (i = 0; i < ncons; i++) {
-		c = kmalloc(sizeof(*c), GFP_KERNEL);
+		c = kzalloc(sizeof(*c), GFP_KERNEL);
 		if (!c)
 			return -ENOMEM;
-		memset(c, 0, sizeof(*c));
 
 		if (lc) {
 			lc->next = c;
@@ -967,10 +963,9 @@ static int read_cons_helper(struct const
 		le = NULL;
 		depth = -1;
 		for (j = 0; j < nexpr; j++) {
-			e = kmalloc(sizeof(*e), GFP_KERNEL);
+			e = kzalloc(sizeof(*e), GFP_KERNEL);
 			if (!e)
 				return -ENOMEM;
-			memset(e, 0, sizeof(*e));
 
 			if (le) {
 				le->next = e;
@@ -1031,12 +1026,11 @@ static int class_read(struct policydb *p
 	u32 len, len2, ncons, nel;
 	int i, rc;
 
-	cladatum = kmalloc(sizeof(*cladatum), GFP_KERNEL);
+	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(cladatum, 0, sizeof(*cladatum));
 
 	rc = next_entry(buf, fp, sizeof(u32)*6);
 	if (rc < 0)
@@ -1125,12 +1119,11 @@ static int role_read(struct policydb *p,
 	__le32 buf[2];
 	u32 len;
 
-	role = kmalloc(sizeof(*role), GFP_KERNEL);
+	role = kzalloc(sizeof(*role), GFP_KERNEL);
 	if (!role) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(role, 0, sizeof(*role));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -1186,12 +1179,11 @@ static int type_read(struct policydb *p,
 	__le32 buf[3];
 	u32 len;
 
-	typdatum = kmalloc(sizeof(*typdatum),GFP_KERNEL);
+	typdatum = kzalloc(sizeof(*typdatum),GFP_KERNEL);
 	if (!typdatum) {
 		rc = -ENOMEM;
 		return rc;
 	}
-	memset(typdatum, 0, sizeof(*typdatum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -1259,12 +1251,11 @@ static int user_read(struct policydb *p,
 	__le32 buf[2];
 	u32 len;
 
-	usrdatum = kmalloc(sizeof(*usrdatum), GFP_KERNEL);
+	usrdatum = kzalloc(sizeof(*usrdatum), GFP_KERNEL);
 	if (!usrdatum) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(usrdatum, 0, sizeof(*usrdatum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -1314,12 +1305,11 @@ static int sens_read(struct policydb *p,
 	__le32 buf[2];
 	u32 len;
 
-	levdatum = kmalloc(sizeof(*levdatum), GFP_ATOMIC);
+	levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
 	if (!levdatum) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(levdatum, 0, sizeof(*levdatum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -1366,12 +1356,11 @@ static int cat_read(struct policydb *p, 
 	__le32 buf[3];
 	u32 len;
 
-	catdatum = kmalloc(sizeof(*catdatum), GFP_ATOMIC);
+	catdatum = kzalloc(sizeof(*catdatum), GFP_ATOMIC);
 	if (!catdatum) {
 		rc = -ENOMEM;
 		goto out;
 	}
-	memset(catdatum, 0, sizeof(*catdatum));
 
 	rc = next_entry(buf, fp, sizeof buf);
 	if (rc < 0)
@@ -1565,12 +1554,11 @@ int policydb_read(struct policydb *p, vo
 	nel = le32_to_cpu(buf[0]);
 	ltr = NULL;
 	for (i = 0; i < nel; i++) {
-		tr = kmalloc(sizeof(*tr), GFP_KERNEL);
+		tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 		if (!tr) {
 			rc = -ENOMEM;
 			goto bad;
 		}
-		memset(tr, 0, sizeof(*tr));
 		if (ltr) {
 			ltr->next = tr;
 		} else {
@@ -1591,12 +1579,11 @@ int policydb_read(struct policydb *p, vo
 	nel = le32_to_cpu(buf[0]);
 	lra = NULL;
 	for (i = 0; i < nel; i++) {
-		ra = kmalloc(sizeof(*ra), GFP_KERNEL);
+		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
 		if (!ra) {
 			rc = -ENOMEM;
 			goto bad;
 		}
-		memset(ra, 0, sizeof(*ra));
 		if (lra) {
 			lra->next = ra;
 		} else {
@@ -1625,12 +1612,11 @@ int policydb_read(struct policydb *p, vo
 		nel = le32_to_cpu(buf[0]);
 		l = NULL;
 		for (j = 0; j < nel; j++) {
-			c = kmalloc(sizeof(*c), GFP_KERNEL);
+			c = kzalloc(sizeof(*c), GFP_KERNEL);
 			if (!c) {
 				rc = -ENOMEM;
 				goto bad;
 			}
-			memset(c, 0, sizeof(*c));
 			if (l) {
 				l->next = c;
 			} else {
@@ -1741,12 +1727,11 @@ int policydb_read(struct policydb *p, vo
 		if (rc < 0)
 			goto bad;
 		len = le32_to_cpu(buf[0]);
-		newgenfs = kmalloc(sizeof(*newgenfs), GFP_KERNEL);
+		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
 		if (!newgenfs) {
 			rc = -ENOMEM;
 			goto bad;
 		}
-		memset(newgenfs, 0, sizeof(*newgenfs));
 
 		newgenfs->fstype = kmalloc(len + 1,GFP_KERNEL);
 		if (!newgenfs->fstype) {
@@ -1788,12 +1773,11 @@ int policydb_read(struct policydb *p, vo
 				goto bad;
 			len = le32_to_cpu(buf[0]);
 
-			newc = kmalloc(sizeof(*newc), GFP_KERNEL);
+			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
 			if (!newc) {
 				rc = -ENOMEM;
 				goto bad;
 			}
-			memset(newc, 0, sizeof(*newc));
 
 			newc->u.name = kmalloc(len + 1,GFP_KERNEL);
 			if (!newc->u.name) {
@@ -1841,12 +1825,11 @@ int policydb_read(struct policydb *p, vo
 		nel = le32_to_cpu(buf[0]);
 		lrt = NULL;
 		for (i = 0; i < nel; i++) {
-			rt = kmalloc(sizeof(*rt), GFP_KERNEL);
+			rt = kzalloc(sizeof(*rt), GFP_KERNEL);
 			if (!rt) {
 				rc = -ENOMEM;
 				goto bad;
 			}
-			memset(rt, 0, sizeof(*rt));
 			if (lrt)
 				lrt->next = rt;
 			else
diff -purN -X dontdiff linux-2.6.13-mm2.o/security/selinux/ss/services.c linux-2.6.13-mm2.w/security/selinux/ss/services.c
--- linux-2.6.13-mm2.o/security/selinux/ss/services.c	2005-09-12 11:28:57.000000000 -0400
+++ linux-2.6.13-mm2.w/security/selinux/ss/services.c	2005-09-13 16:26:11.000000000 -0400
@@ -1531,12 +1531,11 @@ int security_get_user_sids(u32 fromsid,
 	}
 	usercon.user = user->value;
 
-	mysids = kmalloc(maxnel*sizeof(*mysids), GFP_ATOMIC);
+	mysids = kcalloc(maxnel, sizeof(*mysids), GFP_ATOMIC);
 	if (!mysids) {
 		rc = -ENOMEM;
 		goto out_unlock;
 	}
-	memset(mysids, 0, maxnel*sizeof(*mysids));
 
 	ebitmap_for_each_bit(&user->roles, rnode, i) {
 		if (!ebitmap_node_get_bit(rnode, i))
@@ -1566,13 +1565,12 @@ int security_get_user_sids(u32 fromsid,
 				mysids[mynel++] = sid;
 			} else {
 				maxnel += SIDS_NEL;
-				mysids2 = kmalloc(maxnel*sizeof(*mysids2), GFP_ATOMIC);
+				mysids2 = kcalloc(maxnel, sizeof(*mysids2), GFP_ATOMIC);
 				if (!mysids2) {
 					rc = -ENOMEM;
 					kfree(mysids);
 					goto out_unlock;
 				}
-				memset(mysids2, 0, maxnel*sizeof(*mysids2));
 				memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
 				kfree(mysids);
 				mysids = mysids2;
@@ -1714,12 +1712,11 @@ int security_get_bools(int *len, char **
 		goto out;
 	}
 
-	*names = (char**)kmalloc(sizeof(char*) * *len, GFP_ATOMIC);
+	*names = (char**)kcalloc(*len, sizeof(char*), GFP_ATOMIC);
 	if (!*names)
 		goto err;
-	memset(*names, 0, sizeof(char*) * *len);
 
-	*values = (int*)kmalloc(sizeof(int) * *len, GFP_ATOMIC);
+	*values = (int*)kcalloc(*len, sizeof(int), GFP_ATOMIC);
 	if (!*values)
 		goto err;
 
