Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293543AbSCCJ4q>; Sun, 3 Mar 2002 04:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293540AbSCCJ4j>; Sun, 3 Mar 2002 04:56:39 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:41228 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S293536AbSCCJ41>; Sun, 3 Mar 2002 04:56:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 2
Date: Sun, 3 Mar 2002 04:56:52 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095610Z293042-31667+10@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the second of 13 patches.

	This patch adds a new format for quota options and the associated 
functionality to manage these formats in the code.


diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sat Mar  2 18:47:41 2002
+++ linux-2.5/fs/dquot.c	Sat Mar  2 18:54:39 2002
@@ -70,7 +70,7 @@
 
 static char *quotatypes[] = INITQFNAMES;
 
-static inline struct quota_mount_options *sb_dqopt(struct super_block *sb)
+static inline struct quota_info *sb_dqopt(struct super_block *sb)
 {
 	return &sb->s_dquot;
 }
@@ -120,7 +120,7 @@
 static void dqput(struct dquot *);
 static struct dquot *dqduplicate(struct dquot *);
 
-static inline char is_enabled(struct quota_mount_options *dqopt, short type)
+static inline char is_enabled(struct quota_info *dqopt, short type)
 {
 	switch (type) {
 		case USRQUOTA:
@@ -295,73 +295,28 @@
 	current->state = TASK_RUNNING;
 }
 
-/*
- *	We don't have to be afraid of deadlocks as we never have quotas on quota 
files...
- */
-static void write_dquot(struct dquot *dquot)
+stati int read_dqblk(struct dquot *dquot)
 {
-	short type = dquot->dq_type;
-	struct file *filp;
-	mm_segment_t fs;
-	loff_t offset;
-	ssize_t ret;
-	struct semaphore *sem = &dquot->dq_sb->s_dquot.dqio_sem;
-	struct dqblk dqbuf;
-
-	down(sem);
-	filp = dquot->dq_sb->s_dquot.files[type];
-	offset = dqoff(dquot->dq_id);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
+	int ret;
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
-	/*
-	 * Note: clear the DQ_MOD flag unconditionally,
-	 * so we don't loop forever on failure.
-	 */
-	memcpy(&dqbuf, &dquot->dq_dqb, sizeof(struct dqblk));
-	dquot->dq_flags &= ~DQ_MOD;
-	ret = 0;
-	if (filp)
-		ret = filp->f_op->write(filp, (char *)&dqbuf, 
-					sizeof(struct dqblk), &offset);
-	if (ret != sizeof(struct dqblk))
-		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n",
-			dquot->dq_sb->s_id);
-
-	set_fs(fs);
-	up(sem);
-	dqstats.writes++;
+	lock_dquot(dquot);
+	down(&dqopt->dqio_sem);
+	ret = dqopt->ops[dquot->dq_type]->read_dqblk(dquot);
+	up(&dqopt->dqio_sem);
+	unlock_dquot(dquot);
+	return ret;
 }
 
-static void read_dquot(struct dquot *dquot)
+static int commit_dqblk(struct dquot *dquot)
 {
-	short type = dquot->dq_type;
-	struct file *filp;
-	mm_segment_t fs;
-	loff_t offset;
+	int ret;
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 
-	filp = dquot->dq_sb->s_dquot.files[type];
-	if (filp == (struct file *)NULL)
-		return;
-
-	lock_dquot(dquot);
-	if (!dquot->dq_sb)	/* Invalidated quota? */
-		goto out_lock;
-	/* Now we are sure filp is valid - the dquot isn't invalidated */
-	down(&dquot->dq_sb->s_dquot.dqio_sem);
-	offset = dqoff(dquot->dq_id);
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	filp->f_op->read(filp, (char *)&dquot->dq_dqb, sizeof(struct dqblk), 
&offset);
-	up(&dquot->dq_sb->s_dquot.dqio_sem);
-	set_fs(fs);
-
-	if (dquot->dq_bhardlimit == 0 && dquot->dq_bsoftlimit == 0 &&
-	    dquot->dq_ihardlimit == 0 && dquot->dq_isoftlimit == 0)
-		dquot->dq_flags |= DQ_FAKE;
-	dqstats.reads++;
-out_lock:
-	unlock_dquot(dquot);
+	down(&dqopt->dqio_sem);
+	ret = dqopt->ops[dquot->dq_type]->commit_dqblk(dquot);
+	up(&dqopt->dqio_sem);
+	return ret;
 }
 
 /* Invalidate all dquots on the list, wait for all users. Note that this 
function is called
@@ -411,7 +366,7 @@
 			continue;
 		if (!dquot->dq_sb)	/* Invalidated? */
 			continue;
-		if (!(dquot->dq_flags & (DQ_MOD | DQ_LOCKED)))
+		if (!dquot_dirty(dquot) && !(dquot->dq_flags & DQ_LOCKED))
 			continue;
 		/* Get reference to quota so it won't be invalidated. get_dquot_ref()
 		 * is enough since if dquot is locked/modified it can't be
@@ -419,8 +374,8 @@
 		get_dquot_ref(dquot);
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
-		if (dquot->dq_flags & DQ_MOD)
-			write_dquot(dquot);
+		if (dquot_dirty(dquot))
+			commit_dqblk(dquot);
 		dqput(dquot);
 		goto restart;
 	}
@@ -501,8 +456,8 @@
 		put_dquot_ref(dquot);
 		return;
 	}
-	if (dquot->dq_flags & DQ_MOD) {
-		write_dquot(dquot);
+	if (dquot_dirty(dquot)) {
+		commit_dqblk(dquot);
 		goto we_slept;
 	}
 
@@ -519,7 +474,7 @@
 	wake_up(&dquot->dq_wait_free);
 }
 
-static struct dquot *get_empty_dquot(void)
+static struct dquot *get_empty_dquot(struct super_block *sb, int type)
 {
 	struct dquot *dquot;
 
@@ -533,6 +488,9 @@
 	INIT_LIST_HEAD(&dquot->dq_free);
 	INIT_LIST_HEAD(&dquot->dq_inuse);
 	INIT_LIST_HEAD(&dquot->dq_hash);
+	dquot->dq_sb = sb;
+	dquot->dq_dev = sb->s_dev;
+	dquot->dq_type = type;
 	dquot->dq_count = 1;
 	/* all dquots go on the inuse_list */
 	put_inuse(dquot);
@@ -544,7 +502,7 @@
 {
 	unsigned int hashent = hashfn(sb, id, type);
 	struct dquot *dquot, *empty = NODQUOT;
-	struct quota_mount_options *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = sb_dqopt(sb);
 
 we_slept:
         if (!is_enabled(dqopt, type)) {
@@ -555,17 +513,15 @@
 
 	if ((dquot = find_dquot(hashent, sb, id, type)) == NODQUOT) {
 		if (empty == NODQUOT) {
-			if ((empty = get_empty_dquot()) == NODQUOT)
+			if ((empty = get_empty_dquot(sb, type)) == NODQUOT)
 				schedule();	/* Try to wait for a moment... */
 			goto we_slept;
 		}
 		dquot = empty;
         	dquot->dq_id = id;
-        	dquot->dq_type = type;
-        	dquot->dq_sb = sb;
 		/* hash it first so it can be found */
 		insert_dquot_hash(dquot);
-        	read_dquot(dquot);
+        	read_dqblk(dquot);
 	} else {
 		if (!dquot->dq_count)
 			remove_free_dquot(dquot);
@@ -719,13 +675,13 @@
 static inline void dquot_incr_inodes(struct dquot *dquot, unsigned long 
number)
 {
 	dquot->dq_curinodes += number;
-	dquot->dq_flags |= DQ_MOD;
+	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_incr_blocks(struct dquot *dquot, unsigned long 
number)
 {
 	dquot->dq_curblocks += number;
-	dquot->dq_flags |= DQ_MOD;
+	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_decr_inodes(struct dquot *dquot, unsigned long 
number)
@@ -737,7 +693,7 @@
 	if (dquot->dq_curinodes < dquot->dq_isoftlimit)
 		dquot->dq_itime = (time_t) 0;
 	dquot->dq_flags &= ~DQ_INODES;
-	dquot->dq_flags |= DQ_MOD;
+	mark_dquot_dirty(dquot);
 }
 
 static inline void dquot_decr_blocks(struct dquot *dquot, unsigned long 
number)
@@ -749,7 +705,7 @@
 	if (dquot->dq_curblocks < dquot->dq_bsoftlimit)
 		dquot->dq_btime = (time_t) 0;
 	dquot->dq_flags &= ~DQ_BLKS;
-	dquot->dq_flags |= DQ_MOD;
+	mark_dquot_dirty(dquot);
 }
 
 static inline int need_print_warning(struct dquot *dquot, int flag)
@@ -822,7 +778,7 @@
 
 static inline char ignore_hardlimit(struct dquot *dquot)
 {
-	return capable(CAP_SYS_RESOURCE) && 
!dquot->dq_sb->s_dquot.rsquash[dquot->dq_type];
+	return capable(CAP_SYS_RESOURCE);
 }
 
 static int check_idq(struct dquot *dquot, ulong inodes, char *warntype)
@@ -850,7 +806,7 @@
 	   (dquot->dq_curinodes + inodes) > dquot->dq_isoftlimit &&
 	    dquot->dq_itime == 0) {
 		*warntype = ISOFTWARN;
-		dquot->dq_itime = CURRENT_TIME + 
dquot->dq_sb->s_dquot.inode_expire[dquot->dq_type];
+		dquot->dq_itime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_igrace;
 	}
 
 	return QUOTA_OK;
@@ -884,7 +840,7 @@
 	    dquot->dq_btime == 0) {
 		if (!prealloc) {
 			*warntype = BSOFTWARN;
-			dquot->dq_btime = CURRENT_TIME + 
dquot->dq_sb->s_dquot.block_expire[dquot->dq_type];
+			dquot->dq_btime = CURRENT_TIME + 
sb_dqopt(dquot->dq_sb)->info[dquot->dq_type].dqi_bgrace;
 		}
 		else
 			/*
@@ -897,83 +853,6 @@
 	return QUOTA_OK;
 }
 
-/*
- * Initialize a dquot-struct with new quota info. This is used by the
- * system call interface functions.
- */ 
-static int set_dqblk(struct super_block *sb, int id, short type, int flags, 
struct dqblk *dqblk)
-{
-	struct dquot *dquot;
-	int error = -EFAULT;
-	struct dqblk dq_dqblk;
-
-	if (copy_from_user(&dq_dqblk, dqblk, sizeof(struct dqblk)))
-		return error;
-
-	if (sb && (dquot = dqget(sb, id, type)) != NODQUOT) {
-		/* We can't block while changing quota structure... */
-		if (id > 0 && ((flags & SET_QUOTA) || (flags & SET_QLIMIT))) {
-			dquot->dq_bhardlimit = dq_dqblk.dqb_bhardlimit;
-			dquot->dq_bsoftlimit = dq_dqblk.dqb_bsoftlimit;
-			dquot->dq_ihardlimit = dq_dqblk.dqb_ihardlimit;
-			dquot->dq_isoftlimit = dq_dqblk.dqb_isoftlimit;
-		}
-
-		if ((flags & SET_QUOTA) || (flags & SET_USE)) {
-			if (dquot->dq_isoftlimit &&
-			    dquot->dq_curinodes < dquot->dq_isoftlimit &&
-			    dq_dqblk.dqb_curinodes >= dquot->dq_isoftlimit)
-				dquot->dq_itime = CURRENT_TIME + 
dquot->dq_sb->s_dquot.inode_expire[type];
-			dquot->dq_curinodes = dq_dqblk.dqb_curinodes;
-			if (dquot->dq_curinodes < dquot->dq_isoftlimit)
-				dquot->dq_flags &= ~DQ_INODES;
-			if (dquot->dq_bsoftlimit &&
-			    dquot->dq_curblocks < dquot->dq_bsoftlimit &&
-			    dq_dqblk.dqb_curblocks >= dquot->dq_bsoftlimit)
-				dquot->dq_btime = CURRENT_TIME + 
dquot->dq_sb->s_dquot.block_expire[type];
-			dquot->dq_curblocks = dq_dqblk.dqb_curblocks;
-			if (dquot->dq_curblocks < dquot->dq_bsoftlimit)
-				dquot->dq_flags &= ~DQ_BLKS;
-		}
-
-		if (id == 0) {
-			dquot->dq_sb->s_dquot.block_expire[type] = dquot->dq_btime = 
dq_dqblk.dqb_btime;
-			dquot->dq_sb->s_dquot.inode_expire[type] = dquot->dq_itime = 
dq_dqblk.dqb_itime;
-		}
-
-		if (dq_dqblk.dqb_bhardlimit == 0 && dq_dqblk.dqb_bsoftlimit == 0 &&
-		    dq_dqblk.dqb_ihardlimit == 0 && dq_dqblk.dqb_isoftlimit == 0)
-			dquot->dq_flags |= DQ_FAKE;
-		else
-			dquot->dq_flags &= ~DQ_FAKE;
-
-		dquot->dq_flags |= DQ_MOD;
-		dqput(dquot);
-	}
-	return 0;
-}
-
-static int get_quota(struct super_block *sb, int id, short type, struct 
dqblk *dqblk)
-{
-	struct dquot *dquot;
-	struct dqblk data;
-	int error = -ESRCH;
-
-	if (!sb || !sb_has_quota_enabled(sb, type))
-		goto out;
-	dquot = dqget(sb, id, type);
-	if (dquot == NODQUOT)
-		goto out;
-
-	memcpy(&data, &dquot->dq_dqb, sizeof(struct dqblk));        /* We copy data 
to preserve them from changing */
-	dqput(dquot);
-	error = -EFAULT;
-	if (dqblk && !copy_to_user(dqblk, &data, sizeof(struct dqblk)))
-		error = 0;
-out:
-	return error;
-}
-
 static int get_stats(caddr_t addr)
 {
 	int error = -EFAULT;
@@ -989,47 +868,6 @@
 	return error;
 }
 
-static int quota_root_squash(struct super_block *sb, short type, int *addr)
-{
-	int new_value, error;
-
-	if (!sb)
-		return(-ENODEV);
-
-	error = -EFAULT;
-	if (!copy_from_user(&new_value, addr, sizeof(int))) {
-		sb_dqopt(sb)->rsquash[type] = new_value;
-		error = 0;
-	}
-	return error;
-}
-
-#if 0	/* We are not going to support filesystems without i_blocks... */
-/*
- * This is a simple algorithm that calculates the size of a file in blocks.
- * This is only used on filesystems that do not have an i_blocks count.
- */
-static u_long isize_to_blocks(loff_t isize, size_t blksize_bits)
-{
-	u_long blocks;
-	u_long indirect;
-
-	if (!blksize_bits)
-		blksize_bits = BLOCK_SIZE_BITS;
-	blocks = (isize >> blksize_bits) + ((isize & ~((1 << blksize_bits)-1)) ? 1 
: 0);
-	if (blocks > 10) {
-		indirect = ((blocks - 11) >> 8) + 1; /* single indirect blocks */
-		if (blocks > (10 + 256)) {
-			indirect += ((blocks - 267) >> 16) + 1; /* double indirect blocks */
-			if (blocks > (10 + 256 + (256 << 8)))
-				indirect++; /* triple indirect blocks */
-		}
-		blocks += indirect;
-	}
-	return blocks;
-}
-#endif
-
 /*
  * Externally referenced functions through dquot_operations in inode.
  *
@@ -1332,7 +1170,7 @@
 	dquot_transfer
 };
 
-static inline void set_enable_flags(struct quota_mount_options *dqopt, short 
type)
+static inline void set_enable_flags(struct quota_info *dqopt, short type)
 {
 	switch (type) {
 		case USRQUOTA:
@@ -1344,7 +1182,7 @@
 	}
 }
 
-static inline void reset_enable_flags(struct quota_mount_options *dqopt, 
short type)
+static inline void reset_enable_flags(struct quota_info *dqopt, short type)
 {
 	switch (type) {
 		case USRQUOTA:
@@ -1366,7 +1204,7 @@
 {
 	struct file *filp;
 	short cnt;
-	struct quota_mount_options *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = sb_dqopt(sb);
 
 	lock_kernel();
 	if (!sb)
@@ -1384,11 +1222,15 @@
 		/* Note: these are blocking operations */
 		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb, cnt);
+                if (info_dirty(&dqopt->info[cnt]))
+                        dqopt->ops[cnt]->write_file_info(sb, cnt);
 
 		filp = dqopt->files[cnt];
 		dqopt->files[cnt] = (struct file *)NULL;
-		dqopt->inode_expire[cnt] = 0;
-		dqopt->block_expire[cnt] = 0;
+		dqopt->info[cnt].dqi_flags = 0;
+		dqopt->info[cnt].dqi_igrace = 0;
+		dqopt->info[cnt].dqi_bgrace = 0;
+		dqopt->ops[cnt] = NULL;
 		fput(filp);
 	}	
 	up(&dqopt->dqoff_sem);
@@ -1397,20 +1239,12 @@
 	return 0;
 }
 
-static inline int check_quotafile_size(loff_t size)
-{
-	ulong blocks = size >> BLOCK_SIZE_BITS;
-	size_t off = size & (BLOCK_SIZE - 1);
-
-	return !(((blocks % sizeof(struct dqblk)) * BLOCK_SIZE + off % 
sizeof(struct dqblk)) % sizeof(struct dqblk));
-}
-
 static int quota_on(struct super_block *sb, short type, char *path)
 {
 	struct file *f;
 	struct inode *inode;
 	struct dquot *dquot;
-	struct quota_mount_options *dqopt = sb_dqopt(sb);
+	struct quota_info *dqopt = sb_dqopt(sb);
 	char *tmp;
 	int error;
 
@@ -1437,7 +1271,7 @@
 	if (!S_ISREG(inode->i_mode))
 		goto out_f;
 	error = -EINVAL;
-	if (inode->i_size == 0 || !check_quotafile_size(inode->i_size))
+	if (!check_quota_file(sb, type))
 		goto out_f;
 	/* We don't want quota on quota files */
 	dquot_drop(inode);
@@ -1446,11 +1280,6 @@
 	dqopt->files[type] = f;
 	sb->dq_op = &dquot_operations;
 	set_enable_flags(dqopt, type);
-
-	dquot = dqget(sb, 0, type);
-	dqopt->inode_expire[type] = (dquot != NODQUOT) ? dquot->dq_itime : 
MAX_IQ_TIME;
-	dqopt->block_expire[type] = (dquot != NODQUOT) ? dquot->dq_btime : 
MAX_DQ_TIME;
-	dqput(dquot);
 
 	add_dquot_ref(sb, type);
 
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/fs.h 
linux-2.5/include/linux/fs.h
--- linux-2.5-linus/include/linux/fs.h	Sat Mar  2 16:40:37 2002
+++ linux-2.5/include/linux/fs.h	Sat Mar  2 18:48:10 2002
@@ -630,15 +630,13 @@
 #define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
 #define DQUOT_GRP_ENABLED	0x02		/* Group diskquotas enabled */
 
-struct quota_mount_options
-{
+struct quota_info {
 	unsigned int flags;			/* Flags for diskquotas on this device */
 	struct semaphore dqio_sem;		/* lock device while I/O in progress */
 	struct semaphore dqoff_sem;		/* serialize quota_off() and quota_on() on 
device */
 	struct file *files[MAXQUOTAS];		/* fp's to quotafiles */
-	time_t inode_expire[MAXQUOTAS];		/* expiretime for inode-quota */
-	time_t block_expire[MAXQUOTAS];		/* expiretime for block-quota */
-	char rsquash[MAXQUOTAS];		/* for quotas threat root as any other user */
+	struct mem_dqinfo info[MAXQUOTAS];	/* Information for each quota type */
+	struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each format */
 };
 
 /*
@@ -701,7 +699,7 @@
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
-	struct quota_mount_options s_dquot;	/* Diskquota specific options */
+	struct quota_info	s_dquot;	/* Diskquota specific options */
 
 	char s_id[32];				/* Informational name */
 
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sat Mar  2 18:47:42 2002
+++ linux-2.5/include/linux/quota.h	Sat Mar  2 18:48:10 2002
@@ -40,10 +40,13 @@
 #define _LINUX_QUOTA_
 
 #include <linux/errno.h>
+#include <linux/types.h>
 
 #define __DQUOT_VERSION__	"dquot_6.5.1"
 #define __DQUOT_NUM_VERSION__	6*10000+5*100+1
 
+typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
+
 /*
  * Convert diskblocks to blocks and the other way around.
  */
@@ -94,33 +97,50 @@
 #define SUBCMDSHIFT 8
 #define QCMD(cmd, type)  (((cmd) << SUBCMDSHIFT) | ((type) & SUBCMDMASK))
 
-#define Q_QUOTAON  0x0100	/* enable quotas */
-#define Q_QUOTAOFF 0x0200	/* disable quotas */
-#define Q_GETQUOTA 0x0300	/* get limits and usage */
-#define Q_SETQUOTA 0x0400	/* set limits and usage */
-#define Q_SETUSE   0x0500	/* set usage */
 #define Q_SYNC     0x0600	/* sync disk copy of a filesystems quotas */
-#define Q_SETQLIM  0x0700	/* set limits */
-#define Q_GETSTATS 0x0800	/* get collected stats */
-#define Q_RSQUASH  0x1000	/* set root_squash option */
 
 /*
- * The following structure defines the format of the disk quota file
- * (as it appears on disk) - the file is an array of these structures
- * indexed by user or group number.
+ * Data for one user/group kept in memory
  */
-struct dqblk {
+struct mem_dqblk {
 	__u32 dqb_bhardlimit;	/* absolute limit on disk blks alloc */
 	__u32 dqb_bsoftlimit;	/* preferred limit on disk blks */
 	__u32 dqb_curblocks;	/* current block count */
 	__u32 dqb_ihardlimit;	/* absolute limit on allocated inodes */
 	__u32 dqb_isoftlimit;	/* preferred inode limit */
 	__u32 dqb_curinodes;	/* current # allocated inodes */
-	time_t dqb_btime;		/* time limit for excessive disk use */
-	time_t dqb_itime;		/* time limit for excessive inode use */
+	time_t dqb_btime;	/* time limit for excessive disk use */
+	time_t dqb_itime;	/* time limit for excessive inode use */
 };
 
 /*
+ * Data for one quotafile kept in memory
+ */
+struct mem_dqinfo {
+	int dqi_flags;
+	unsigned int dqi_bgrace;
+	unsigned int dqi_igrace;
+	union {
+	} u;
+};
+
+#ifdef __KERNEL__
+
+#define DQF_MASK 0xffff		/* Mask for format specific flags */
+#define DQF_INFO_DIRTY 0x10000  /* Is info dirty? */
+
+extern inline void mark_info_dirty(struct mem_dqinfo *info)
+{
+	info->dqi_flags |= DQF_INFO_DIRTY;
+}
+
+#define info_dirty(info) ((info)->dqi_flags & DQF_INFO_DIRTY)
+
+#define sb_dqopt(sb) (&(sb)->s_dquot)
+
+#endif  /* __KERNEL__ */
+
+/*
  * Shorthand notation.
  */
 #define	dq_bhardlimit	dq_dqb.dqb_bhardlimit
@@ -134,6 +154,11 @@
 
 #define dqoff(UID)      ((loff_t)((UID) * sizeof (struct dqblk)))
 
+#ifdef __KERNEL__
+
+extern int nr_dquots, nr_free_dquots;
+extern int dquot_root_squash;
+
 struct dqstats {
 	__u32 lookups;
 	__u32 drops;
@@ -145,11 +170,6 @@
 	__u32 syncs;
 };
 
-#ifdef __KERNEL__
-
-extern int nr_dquots, nr_free_dquots;
-extern int dquot_root_squash;
-
 #define NR_DQHASH 43            /* Just an arbitrary number */
 
 #define DQ_LOCKED     0x01	/* dquot under IO */
@@ -175,20 +195,30 @@
 	short dq_flags;			/* See DQ_* */
 	unsigned long dq_referenced;	/* Number of times this dquot was 
 					   referenced during its lifetime */
-	struct dqblk dq_dqb;		/* Diskquota usage */
+	struct mem_dqblk dq_dqb;	/* Diskquota usage */
 };
 
-#define NODQUOT (struct dquot *)NULL
+extern inline void mark_dquot_dirty(struct dquot *dquot)
+{
+	dquot->dq_flags |= DQ_MOD;
+}
 
-/*
- * Flags used for set_dqblk.
- */
-#define SET_QUOTA         0x02
-#define SET_USE           0x04
-#define SET_QLIMIT        0x08
+#define dquot_dirty(dquot) ((dquot)->dq_flags & DQ_MOD)
+
+#define NODQUOT (struct dquot *)NULL
 
 #define QUOTA_OK          0
 #define NO_QUOTA          1
+
+/* Operations which must be implemented by each quota format */
+struct quota_format_ops {
+	int (*check_quota_file)(struct super_block *sb, int type);	/* Detect 
whether file is in our format */
+	int (*read_file_info)(struct super_block *sb, int type);	/* Read main info 
about file */
+	int (*write_file_info)(struct super_block *sb, int type);	/* Write main 
info about file */
+	int (*free_file_info)(struct super_block *sb, int type);	/* Called on 
quotaoff() */
+	int (*read_dqblk)(struct dquot *dquot);		/* Read structure for one user */
+	int (*commit_dqblk)(struct dquot *dquot);	/* Write (or delete) structure 
for one user */
+};
 
 #else
 
