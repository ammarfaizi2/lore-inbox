Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSCCJ6W>; Sun, 3 Mar 2002 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293539AbSCCJ5d>; Sun, 3 Mar 2002 04:57:33 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:41228 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S293540AbSCCJ45>; Sun, 3 Mar 2002 04:56:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 3
Date: Sun, 3 Mar 2002 04:56:56 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095625Z293043-31668+16@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The is the third of 13 patches.

	This patch registers and makes use of the new quota format types.  It also 
changes the filep handleing inside of the dquot code.






diff -urN -X txt/diff-exclude linux-2.5-linus/fs/Makefile 
linux-2.5/fs/Makefile
--- linux-2.5-linus/fs/Makefile	Sat Mar  2 16:40:20 2002
+++ linux-2.5/fs/Makefile	Sat Mar  2 19:15:18 2002
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o dquot.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sat Mar  2 19:16:53 2002
+++ linux-2.5/fs/dquot.c	Sat Mar  2 19:14:09 2002
@@ -69,10 +69,36 @@
 int nr_dquots, nr_free_dquots;
 
 static char *quotatypes[] = INITQFNAMES;
+static struct quota_format_type *quota_formats;	/* List of registered 
formats */
 
-static inline struct quota_info *sb_dqopt(struct super_block *sb)
+int register_quota_format(struct quota_format_type *fmt)
 {
-	return &sb->s_dquot;
+	lock_kernel();
+	fmt->qf_next = quota_formats;
+	quota_formats = fmt;
+	unlock_kernel();
+	return 0;
+}
+
+void unregister_quota_format(struct quota_format_type *fmt)
+{
+	struct quota_format_type **actqf;
+
+	lock_kernel();
+	for (actqf = &quota_formats; *actqf && *actqf != fmt; actqf = 
&(*actqf)->qf_next);
+	if (*actqf)
+		*actqf = (*actqf)->qf_next;
+	unlock_kernel();
+}
+
+static struct quota_format_type *find_quota_format(int id)
+{
+	struct quota_format_type *actqf;
+
+	lock_kernel();
+	for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = 
actqf->qf_next);
+	unlock_kernel();
+	return actqf;
 }
 
 /*
@@ -1224,6 +1250,8 @@
 		invalidate_dquots(sb, cnt);
                 if (info_dirty(&dqopt->info[cnt]))
                         dqopt->ops[cnt]->write_file_info(sb, cnt);
+		if (dqopt->ops[cnt]->free_file_info)
+			dqopt->ops[cnt]->free_file_info(sb, cnt);
 
 		filp = dqopt->files[cnt];
 		dqopt->files[cnt] = (struct file *)NULL;
@@ -1239,30 +1267,27 @@
 	return 0;
 }
 
-static int quota_on(struct super_block *sb, short type, char *path)
+static int quota_on(struct super_block *sb, int type, int format_id, char 
*path)
 {
 	struct file *f;
 	struct inode *inode;
-	struct dquot *dquot;
 	struct quota_info *dqopt = sb_dqopt(sb);
-	char *tmp;
+	struct quota_format_type *fmt = find_quota_format(format_id);
 	int error;
 
+	if (!fmt)
+		return -EINVAL;
 	if (is_enabled(dqopt, type))
 		return -EBUSY;
 
 	down(&dqopt->dqoff_sem);
-	tmp = getname(path);
-	error = PTR_ERR(tmp);
-	if (IS_ERR(tmp))
-		goto out_lock;
 
-	f = filp_open(tmp, O_RDWR, 0600);
-	putname(tmp);
+	f = filp_open(path, O_RDWR, 0600);
 
 	error = PTR_ERR(f);
 	if (IS_ERR(f))
 		goto out_lock;
+	dqopt->files[type] = f;
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
@@ -1271,13 +1296,16 @@
 	if (!S_ISREG(inode->i_mode))
 		goto out_f;
 	error = -EINVAL;
-	if (!check_quota_file(sb, type))
+	if (!fmt->qf_ops->check_quota_file(sb, type))
 		goto out_f;
 	/* We don't want quota on quota files */
 	dquot_drop(inode);
 	inode->i_flags |= S_NOQUOTA;
 
-	dqopt->files[type] = f;
+	dqopt->ops[type] = fmt->qf_ops;
+	dqopt->info[type].dqi_format = format_id;
+	if ((error = dqopt->ops[type]->read_file_info(sb, type)) < 0)
+		goto out_f;
 	sb->dq_op = &dquot_operations;
 	set_enable_flags(dqopt, type);
 
@@ -1288,6 +1316,7 @@
 
 out_f:
 	filp_close(f, NULL);
+	dqopt->files[type] = NULL;
 out_lock:
 	up(&dqopt->dqoff_sem);
 
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sat Mar  2 19:16:55 2002
+++ linux-2.5/include/linux/quota.h	Sat Mar  2 19:14:09 2002
@@ -42,9 +42,6 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
-#define __DQUOT_VERSION__	"dquot_6.5.1"
-#define __DQUOT_NUM_VERSION__	6*10000+5*100+1
-
 typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
 
 /*
@@ -116,7 +113,10 @@
 /*
  * Data for one quotafile kept in memory
  */
+struct quota_format_type;
+
 struct mem_dqinfo {
+	struct quota_format_type *dqi_format;
 	int dqi_flags;
 	unsigned int dqi_bgrace;
 	unsigned int dqi_igrace;
@@ -157,7 +157,6 @@
 #ifdef __KERNEL__
 
 extern int nr_dquots, nr_free_dquots;
-extern int dquot_root_squash;
 
 struct dqstats {
 	__u32 lookups;
@@ -170,6 +169,8 @@
 	__u32 syncs;
 };
 
+extern struct dqstats dqstats;
+
 #define NR_DQHASH 43            /* Just an arbitrary number */
 
 #define DQ_LOCKED     0x01	/* dquot under IO */
@@ -218,6 +219,12 @@
 	int (*free_file_info)(struct super_block *sb, int type);	/* Called on 
quotaoff() */
 	int (*read_dqblk)(struct dquot *dquot);		/* Read structure for one user */
 	int (*commit_dqblk)(struct dquot *dquot);	/* Write (or delete) structure 
for one user */
+};
+
+struct quota_format_type {
+	int qf_fmt_id;	/* Quota format id */
+	struct quota_format_ops *qf_ops;	/* Operations of format */
+	struct quota_format_type *qf_next;
 };
 
 #else
