Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293539AbSCCJ6W>; Sun, 3 Mar 2002 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293540AbSCCJ5h>; Sun, 3 Mar 2002 04:57:37 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:41228 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S293545AbSCCJ46>; Sun, 3 Mar 2002 04:56:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 10
Date: Sun, 3 Mar 2002 04:57:16 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095640Z293047-31620+5@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the tenth of 13 patches.


	This changes the type variable to be an int instead of a short.


diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sun Mar  3 03:24:09 2002
+++ linux-2.5/fs/dquot.c	Sun Mar  3 03:28:52 2002
@@ -173,7 +173,7 @@
 	dquot->dq_dup_ref--;
 }
 
-static inline int const hashfn(struct super_block *sb, unsigned int id, 
short type)
+static inline int const hashfn(struct super_block *sb, unsigned int id, int 
type)
 {
 	return((HASHDEV(sb->s_dev) ^ id) * (MAXQUOTAS - type)) % NR_DQHASH;
 }
@@ -190,7 +190,7 @@
 	INIT_LIST_HEAD(&dquot->dq_hash);
 }
 
-static inline struct dquot *find_dquot(unsigned int hashent, struct 
super_block *sb, unsigned int id, short type)
+static inline struct dquot *find_dquot(unsigned int hashent, struct 
super_block *sb, unsigned int id, int type)
 {
 	struct list_head *head;
 	struct dquot *dquot;
@@ -339,7 +339,7 @@
 /* Invalidate all dquots on the list, wait for all users. Note that this 
function is called
  * after quota is disabled so no new quota might be created. As we only 
insert to the end of
  * inuse list, we don't have to restart searching... */
-static void invalidate_dquots(struct super_block *sb, short type)
+static void invalidate_dquots(struct super_block *sb, int type)
 {
 	struct dquot *dquot;
 	struct list_head *head;
@@ -368,7 +368,7 @@
 	}
 }
 
-int sync_dquots(struct super_block *sb, short type)
+int sync_dquots(struct super_block *sb, int type)
 {
 	struct list_head *head;
 	struct dquot *dquot;
@@ -516,7 +516,7 @@
 	return dquot;
 }
 
-static struct dquot *dqget(struct super_block *sb, unsigned int id, short 
type)
+static struct dquot *dqget(struct super_block *sb, unsigned int id, int type)
 {
 	unsigned int hashent = hashfn(sb, id, type);
 	struct dquot *dquot, *empty = NODQUOT;
@@ -594,7 +594,7 @@
 	dqstats.drops++;
 }
 
-static int dqinit_needed(struct inode *inode, short type)
+static int dqinit_needed(struct inode *inode, int type)
 {
 	int cnt;
 
@@ -608,7 +608,7 @@
 	return 0;
 }
 
-static void add_dquot_ref(struct super_block *sb, short type)
+static void add_dquot_ref(struct super_block *sb, int type)
 {
 	struct list_head *p;
 
@@ -642,7 +642,7 @@
 }
 
 /* Remove references to dquots from inode - add dquot to list for freeing if 
needed */
-int remove_inode_dquot_ref(struct inode *inode, short type, struct list_head 
*tofree_head)
+int remove_inode_dquot_ref(struct inode *inode, int type, struct list_head 
*tofree_head)
 {
 	struct dquot *dquot = inode->i_dquot[type];
 	int cnt;
@@ -876,11 +876,11 @@
  *
  * Note: this is a blocking operation.
  */
-void dquot_initialize(struct inode *inode, short type)
+void dquot_initialize(struct inode *inode, int type)
 {
 	struct dquot *dquot[MAXQUOTAS];
 	unsigned int id = 0;
-	short cnt;
+	int cnt;
 
 	if (IS_NOQUOTA(inode))
 		return;
@@ -926,7 +926,7 @@
 void dquot_drop(struct inode *inode)
 {
 	struct dquot *dquot;
-	short cnt;
+	int cnt;
 
 	inode->i_flags &= ~S_QUOTA;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
@@ -1021,7 +1021,7 @@
  */
 void dquot_free_space(struct inode *inode, qsize_t number)
 {
-	unsigned short cnt;
+	unsigned int cnt;
 	struct dquot *dquot;
 
 	/* NOBLOCK Start */
@@ -1043,7 +1043,7 @@
  */
 void dquot_free_inode(const struct inode *inode, unsigned long number)
 {
-	unsigned short cnt;
+	unsigned int cnt;
 	struct dquot *dquot;
 
 	/* NOBLOCK Start */
@@ -1162,7 +1162,7 @@
 	dquot_transfer
 };
 
-static inline void set_enable_flags(struct quota_info *dqopt, short type)
+static inline void set_enable_flags(struct quota_info *dqopt, int type)
 {
 	switch (type) {
 		case USRQUOTA:
@@ -1174,7 +1174,7 @@
 	}
 }
 
-static inline void reset_enable_flags(struct quota_info *dqopt, short type)
+static inline void reset_enable_flags(struct quota_info *dqopt, int type)
 {
 	switch (type) {
 		case USRQUOTA:
@@ -1187,7 +1187,7 @@
 }
 
 /* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(struct super_block *, short);
+extern void remove_dquot_ref(struct super_block *, int);
 
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
@@ -1448,7 +1448,7 @@
 }
 #endif
 
-struct quotactl_ops vfs_quotactl_ops {
+struct quotactl_ops vfs_quotactl_ops = {
 	quota_on:	vfs_quota_on,
 	quota_off:	vfs_quota_off,
 	quota_sync:	vfs_quota_sync,
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/inode.c linux-2.5/fs/inode.c
--- linux-2.5-linus/fs/inode.c	Sun Mar  3 03:07:56 2002
+++ linux-2.5/fs/inode.c	Sun Mar  3 03:27:22 2002
@@ -1207,9 +1207,9 @@
 
 /* Functions back in dquot.c */
 void put_dquot_list(struct list_head *);
-int remove_inode_dquot_ref(struct inode *, short, struct list_head *);
+int remove_inode_dquot_ref(struct inode *, int, struct list_head *);
 
-void remove_dquot_ref(struct super_block *sb, short type)
+void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
 	struct list_head *act_head;
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sun Mar  3 03:30:20 2002
+++ linux-2.5/include/linux/quota.h	Sun Mar  3 03:27:22 2002
@@ -248,7 +248,7 @@
 
 /* Operations working with dquots */
 struct dquot_operations {
-	void (*initialize) (struct inode *, short);
+	void (*initialize) (struct inode *, int);
 	void (*drop) (struct inode *);
 	int (*alloc_space) (struct inode *, qsize_t, int);
 	int (*alloc_inode) (const struct inode *, unsigned long);
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaops.h 
linux-2.5/include/linux/quotaops.h
--- linux-2.5-linus/include/linux/quotaops.h	Sun Mar  3 03:17:15 2002
+++ linux-2.5/include/linux/quotaops.h	Sun Mar  3 03:29:56 2002
@@ -40,9 +40,9 @@
  * declaration of quota_function calls in kernel.
  */
 /* Al this will be changed as soon as I release the first patch */
-extern int sync_dquots(kdev_t dev, short type);
+extern int sync_dquots(struct super_block *sb, int type);
 
-extern void dquot_initialize(struct inode *inode, short type);
+extern void dquot_initialize(struct inode *inode, int type);
 extern void dquot_drop(struct inode *inode);
 
 extern int  dquot_alloc_space(struct inode *inode, qsize_t number, int 
prealloc);
