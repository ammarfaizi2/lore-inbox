Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWI2DLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWI2DLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWI2DLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:11:41 -0400
Received: from ns2.suse.de ([195.135.220.15]:10425 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161291AbWI2DJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:09:19 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:09:13 +1000
Message-Id: <1060929030913.24108@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 8] knfsd: nfsd4: fslocations data structures
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Manoj Naik <manoj@almaden.ibm.com>

Define FS locations structures, some functions to manipulate them, and add
code to parse FS locations in downcall and add to the exports structure.

Signed-off-by: Manoj Naik <manoj@almaden.ibm.com>
Signed-off-by: Fred Isaman <iisaman@citi.umich.edu>
Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c            |  118 ++++++++++++++++++++++++++++++++++++++++--
 ./include/linux/nfsd/export.h |   17 ++++++
 2 files changed, 131 insertions(+), 4 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-09-29 12:57:47.000000000 +1000
+++ ./fs/nfsd/export.c	2006-09-29 13:02:13.000000000 +1000
@@ -319,6 +319,17 @@ svc_expkey_update(struct svc_expkey *new
 
 static struct cache_head *export_table[EXPORT_HASHMAX];
 
+static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
+{
+	int i;
+
+	for (i = 0; i < fsloc->locations_count; i++) {
+		kfree(fsloc->locations[i].path);
+		kfree(fsloc->locations[i].hosts);
+	}
+	kfree(fsloc->locations);
+}
+
 static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
@@ -326,6 +337,7 @@ static void svc_export_put(struct kref *
 	mntput(exp->ex_mnt);
 	auth_domain_put(exp->ex_client);
 	kfree(exp->ex_path);
+	nfsd4_fslocs_free(&exp->ex_fslocs);
 	kfree(exp);
 }
 
@@ -387,6 +399,69 @@ static int check_export(struct inode *in
 
 }
 
+#ifdef CONFIG_NFSD_V4
+
+static int
+fsloc_parse(char **mesg, char *buf, struct nfsd4_fs_locations *fsloc)
+{
+	int len;
+	int migrated, i, err;
+
+	len = qword_get(mesg, buf, PAGE_SIZE);
+	if (len != 5 || memcmp(buf, "fsloc", 5))
+		return 0;
+
+	/* listsize */
+	err = get_int(mesg, &fsloc->locations_count);
+	if (err)
+		return err;
+	if (fsloc->locations_count < 0)
+		return -EINVAL;
+	if (fsloc->locations_count == 0)
+		return 0;
+
+	fsloc->locations = kzalloc(fsloc->locations_count
+			* sizeof(struct nfsd4_fs_location), GFP_KERNEL);
+	if (!fsloc->locations)
+		return -ENOMEM;
+	for (i=0; i < fsloc->locations_count; i++) {
+		/* colon separated host list */
+		err = -EINVAL;
+		len = qword_get(mesg, buf, PAGE_SIZE);
+		if (len <= 0)
+			goto out_free_all;
+		err = -ENOMEM;
+		fsloc->locations[i].hosts = kstrdup(buf, GFP_KERNEL);
+		if (!fsloc->locations[i].hosts)
+			goto out_free_all;
+		err = -EINVAL;
+		/* slash separated path component list */
+		len = qword_get(mesg, buf, PAGE_SIZE);
+		if (len <= 0)
+			goto out_free_all;
+		err = -ENOMEM;
+		fsloc->locations[i].path = kstrdup(buf, GFP_KERNEL);
+		if (!fsloc->locations[i].path)
+			goto out_free_all;
+	}
+	/* migrated */
+	err = get_int(mesg, &migrated);
+	if (err)
+		goto out_free_all;
+	err = -EINVAL;
+	if (migrated < 0 || migrated > 1)
+		goto out_free_all;
+	fsloc->migrated = migrated;
+	return 0;
+out_free_all:
+	nfsd4_fslocs_free(fsloc);
+	return err;
+}
+
+#else /* CONFIG_NFSD_V4 */
+static int fsloc_parse(char **, char *, struct svc_export *) { return 0; }
+#endif
+
 static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 {
 	/* client path expiry [flags anonuid anongid fsid] */
@@ -441,6 +516,11 @@ static int svc_export_parse(struct cache
 	if (exp.h.expiry_time == 0)
 		goto out;
 
+	/* fs locations */
+	exp.ex_fslocs.locations = NULL;
+	exp.ex_fslocs.locations_count = 0;
+	exp.ex_fslocs.migrated = 0;
+
 	/* flags */
 	err = get_int(&mesg, &an_int);
 	if (err == -ENOENT)
@@ -466,6 +546,10 @@ static int svc_export_parse(struct cache
 
 		err = check_export(nd.dentry->d_inode, exp.ex_flags);
 		if (err) goto out;
+
+		err = fsloc_parse(&mesg, buf, &exp.ex_fslocs);
+		if (err)
+			goto out;
 	}
 
 	expp = svc_export_lookup(&exp);
@@ -489,7 +573,8 @@ static int svc_export_parse(struct cache
 	return err;
 }
 
-static void exp_flags(struct seq_file *m, int flag, int fsid, uid_t anonu, uid_t anong);
+static void exp_flags(struct seq_file *m, int flag, int fsid,
+		uid_t anonu, uid_t anong, struct nfsd4_fs_locations *fslocs);
 
 static int svc_export_show(struct seq_file *m,
 			   struct cache_detail *cd,
@@ -508,8 +593,8 @@ static int svc_export_show(struct seq_fi
 	seq_putc(m, '(');
 	if (test_bit(CACHE_VALID, &h->flags) && 
 	    !test_bit(CACHE_NEGATIVE, &h->flags))
-		exp_flags(m, exp->ex_flags, exp->ex_fsid, 
-			  exp->ex_anon_uid, exp->ex_anon_gid);
+		exp_flags(m, exp->ex_flags, exp->ex_fsid,
+			  exp->ex_anon_uid, exp->ex_anon_gid, &exp->ex_fslocs);
 	seq_puts(m, ")\n");
 	return 0;
 }
@@ -532,6 +617,9 @@ static void svc_export_init(struct cache
 	new->ex_dentry = dget(item->ex_dentry);
 	new->ex_mnt = mntget(item->ex_mnt);
 	new->ex_path = NULL;
+	new->ex_fslocs.locations = NULL;
+	new->ex_fslocs.locations_count = 0;
+	new->ex_fslocs.migrated = 0;
 }
 
 static void export_update(struct cache_head *cnew, struct cache_head *citem)
@@ -545,6 +633,12 @@ static void export_update(struct cache_h
 	new->ex_fsid = item->ex_fsid;
 	new->ex_path = item->ex_path;
 	item->ex_path = NULL;
+	new->ex_fslocs.locations = item->ex_fslocs.locations;
+	item->ex_fslocs.locations = NULL;
+	new->ex_fslocs.locations_count = item->ex_fslocs.locations_count;
+	item->ex_fslocs.locations_count = 0;
+	new->ex_fslocs.migrated = item->ex_fslocs.migrated;
+	item->ex_fslocs.migrated = 0;
 }
 
 static struct cache_head *svc_export_alloc(void)
@@ -1159,7 +1253,8 @@ static struct flags {
 	{ 0, {"", ""}}
 };
 
-static void exp_flags(struct seq_file *m, int flag, int fsid, uid_t anonu, uid_t anong)
+static void exp_flags(struct seq_file *m, int flag, int fsid,
+		uid_t anonu, uid_t anong, struct nfsd4_fs_locations *fsloc)
 {
 	int first = 0;
 	struct flags *flg;
@@ -1175,6 +1270,21 @@ static void exp_flags(struct seq_file *m
 		seq_printf(m, "%sanonuid=%d", first++?",":"", anonu);
 	if (anong != (gid_t)-2 && anong != (0x10000-2))
 		seq_printf(m, "%sanongid=%d", first++?",":"", anong);
+	if (fsloc && fsloc->locations_count > 0) {
+		char *loctype = (fsloc->migrated) ? "refer" : "replicas";
+		int i;
+
+		seq_printf(m, "%s%s=", first++?",":"", loctype);
+		seq_escape(m, fsloc->locations[0].path, ",;@ \t\n\\");
+		seq_putc(m, '@');
+		seq_escape(m, fsloc->locations[0].hosts, ",;@ \t\n\\");
+		for (i = 1; i < fsloc->locations_count; i++) {
+			seq_putc(m, ';');
+			seq_escape(m, fsloc->locations[i].path, ",;@ \t\n\\");
+			seq_putc(m, '@');
+			seq_escape(m, fsloc->locations[i].hosts, ",;@ \t\n\\");
+		}
+	}
 }
 
 static int e_show(struct seq_file *m, void *p)

diff .prev/include/linux/nfsd/export.h ./include/linux/nfsd/export.h
--- .prev/include/linux/nfsd/export.h	2006-09-29 12:57:47.000000000 +1000
+++ ./include/linux/nfsd/export.h	2006-09-29 12:59:01.000000000 +1000
@@ -45,6 +45,22 @@
 
 #ifdef __KERNEL__
 
+/*
+ * FS Locations
+ */
+struct nfsd4_fs_location {
+	char *hosts; /* colon separated list of hosts */
+	char *path;  /* slash separated list of path components */
+};
+
+struct nfsd4_fs_locations {
+	uint32_t locations_count;
+	struct nfsd4_fs_location *locations;
+/* If we're not actually serving this data ourselves (only providing a
+ * list of replicas that do serve it) then we set "migrated": */
+	int migrated;
+};
+
 struct svc_export {
 	struct cache_head	h;
 	struct auth_domain *	ex_client;
@@ -55,6 +71,7 @@ struct svc_export {
 	uid_t			ex_anon_uid;
 	gid_t			ex_anon_gid;
 	int			ex_fsid;
+	struct nfsd4_fs_locations ex_fslocs;
 };
 
 /* an "export key" (expkey) maps a filehandlefragement to an
