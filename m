Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293540AbSCCJ6W>; Sun, 3 Mar 2002 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293545AbSCCJ5x>; Sun, 3 Mar 2002 04:57:53 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:41228 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S293546AbSCCJ46>; Sun, 3 Mar 2002 04:56:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 9
Date: Sun, 3 Mar 2002 04:57:14 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095640Z293046-31622+7@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the ninth of 13 patches.

	This code adds the new style quota code to the file quota_v2.c and also a 
configuration option.




diff -urN -X txt/diff-exclude linux-2.5-linus/fs/Config.help 
linux-2.5/fs/Config.help
--- linux-2.5-linus/fs/Config.help	Sun Mar  3 03:24:07 2002
+++ linux-2.5/fs/Config.help	Sun Mar  3 03:22:36 2002
@@ -1,8 +1,10 @@
 CONFIG_QUOTA
   If you say Y here, you will be able to set per user limits for disk
-  usage (also called disk quotas). Currently, it works only for the
-  ext2 file system. You need additional software in order to use quota
-  support; for details, read the Quota mini-HOWTO, available from
+  usage (also called disk quotas). Currently, it works for the
+  ext2, ext3, and reiserfs file system. You need additional software
+  in order to use quota support (you can download sources from
+  <http://www.sf.net/projects/linuxquota/>). For further details, read
+  the Quota mini-HOWTO, available from
   <http://www.linuxdoc.org/docs.html#howto>. Probably the quota
   support is only useful for multi user systems. If unsure, say N.
 
@@ -10,6 +12,12 @@
   This quota format was (is) used by kernels earlier than 2.4.16. If
   you have quota working and you don't want to convert to new quota
   format say Y here.
+
+VFS v0 quota format support
+CONFIG_QFMT_V2
+  This quota format allows using quotas with 32-bit UIDs/GIDs. If you
+  need this functionality say Y here. Note that you will need latest
+  quota utilities for new quota format with this kernel.
 
 CONFIG_MINIX_FS
   Minix is a simple operating system used in many classes about OS's.
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/Config.in 
linux-2.5/fs/Config.in
--- linux-2.5-linus/fs/Config.in	Sun Mar  3 03:24:09 2002
+++ linux-2.5/fs/Config.in	Sun Mar  3 03:21:20 2002
@@ -6,6 +6,7 @@
 
 bool 'Quota support' CONFIG_QUOTA
 dep_tristate '  Old quota format support' CONFIG_QFMT_V1 $CONFIG_QUOTA
+dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' 
CONFIG_AUTOFS4_FS
 
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/Makefile 
linux-2.5/fs/Makefile
--- linux-2.5-linus/fs/Makefile	Sun Mar  3 03:24:09 2002
+++ linux-2.5/fs/Makefile	Sun Mar  3 03:21:20 2002
@@ -19,6 +19,7 @@
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
 obj-$(CONFIG_QFMT_V1) += quota_v1.o
+obj-$(CONFIG_QFMT_V2) += quota_v2.o
 endif
 
 subdir-$(CONFIG_PROC_FS)	+= proc
diff -urN -X txt/diff-exclude linux-2.5-linus/fs/quota_v2.c 
linux-2.5/fs/quota_v2.c
--- linux-2.5-linus/fs/quota_v2.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5/fs/quota_v2.c	Sun Mar  3 03:21:20 2002
@@ -0,0 +1,690 @@
+/*
+ *	vfsv0 quota IO operations on file
+ */
+
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/dqblk_v2.h>
+#include <linux/quotaio_v2.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <asm/byteorder.h>
+#include <asm/uaccess.h>
+
+#define __QUOTA_V2_PARANOIA
+
+typedef char *dqbuf_t;
+
+#define GETIDINDEX(id, depth) (((id) >> ((V2_DQTREEDEPTH-(depth)-1)*8)) & 
0xff)
+#define GETENTRIES(buf) ((struct v2_disk_dqblk *)(((char 
*)buf)+sizeof(struct v2_disk_dqdbheader)))
+
+/* Check whether given file is really vfsv0 quotafile */
+static int v2_check_quota_file(struct super_block *sb, int type)
+{
+	struct v2_disk_dqheader dqhead;
+	struct file *f = sb_dqopt(sb)->files[type];
+	mm_segment_t fs;
+	ssize_t size;
+	loff_t offset = 0;
+	static const uint quota_magics[] = V2_INITQMAGICS;
+	static const uint quota_versions[] = V2_INITQVERSIONS;
+ 
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	size = f->f_op->read(f, (char *)&dqhead, sizeof(struct v2_disk_dqheader), 
&offset);
+	set_fs(fs);
+	if (size != sizeof(struct v2_disk_dqheader))
+		return 0;
+	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type] ||
+	    le32_to_cpu(dqhead.dqh_version) != quota_versions[type])
+		return 0;
+	return 1;
+}
+
+/* Read information header from quota file */
+static int v2_read_file_info(struct super_block *sb, int type)
+{
+	mm_segment_t fs;
+	struct v2_disk_dqinfo dinfo;
+	struct mem_dqinfo *info = sb_dqopt(sb)->info+type;
+	struct file *f = sb_dqopt(sb)->files[type];
+	ssize_t size;
+	loff_t offset = V2_DQINFOOFF;
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	size = f->f_op->read(f, (char *)&dinfo, sizeof(struct v2_disk_dqinfo), 
&offset);
+	set_fs(fs);
+	if (size != sizeof(struct v2_disk_dqinfo)) {
+		printk(KERN_WARNING "Can't read info structure on device %s.\n",
+			kdevname(f->f_dentry->d_sb->s_dev));
+		return -1;
+	}
+	info->dqi_bgrace = le32_to_cpu(dinfo.dqi_bgrace);
+	info->dqi_igrace = le32_to_cpu(dinfo.dqi_igrace);
+	info->dqi_flags = le32_to_cpu(dinfo.dqi_flags);
+	info->u.v2_i.dqi_blocks = le32_to_cpu(dinfo.dqi_blocks);
+	info->u.v2_i.dqi_free_blk = le32_to_cpu(dinfo.dqi_free_blk);
+	info->u.v2_i.dqi_free_entry = le32_to_cpu(dinfo.dqi_free_entry);
+	return 0;
+}
+
+/* Write information header to quota file */
+static int v2_write_file_info(struct super_block *sb, int type)
+{
+	mm_segment_t fs;
+	struct v2_disk_dqinfo dinfo;
+	struct mem_dqinfo *info = sb_dqopt(sb)->info+type;
+	struct file *f = sb_dqopt(sb)->files[type];
+	ssize_t size;
+	loff_t offset = V2_DQINFOOFF;
+
+	info->dqi_flags &= ~DQF_INFO_DIRTY;
+	dinfo.dqi_bgrace = cpu_to_le32(info->dqi_bgrace);
+	dinfo.dqi_igrace = cpu_to_le32(info->dqi_igrace);
+	dinfo.dqi_flags = cpu_to_le32(info->dqi_flags & DQF_MASK);
+	dinfo.dqi_blocks = cpu_to_le32(info->u.v2_i.dqi_blocks);
+	dinfo.dqi_free_blk = cpu_to_le32(info->u.v2_i.dqi_free_blk);
+	dinfo.dqi_free_entry = cpu_to_le32(info->u.v2_i.dqi_free_entry);
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	size = f->f_op->write(f, (char *)&dinfo, sizeof(struct v2_disk_dqinfo), 
&offset);
+	set_fs(fs);
+	if (size != sizeof(struct v2_disk_dqinfo)) {
+		printk(KERN_WARNING "Can't write info structure on device %s.\n",
+			kdevname(f->f_dentry->d_sb->s_dev));
+		return -1;
+	}
+	return 0;
+}
+
+static void disk2memdqb(struct mem_dqblk *m, struct v2_disk_dqblk *d)
+{
+	m->dqb_ihardlimit = le32_to_cpu(d->dqb_ihardlimit);
+	m->dqb_isoftlimit = le32_to_cpu(d->dqb_isoftlimit);
+	m->dqb_curinodes = le32_to_cpu(d->dqb_curinodes);
+	m->dqb_itime = le64_to_cpu(d->dqb_itime);
+	m->dqb_bhardlimit = le32_to_cpu(d->dqb_bhardlimit);
+	m->dqb_bsoftlimit = le32_to_cpu(d->dqb_bsoftlimit);
+	m->dqb_curspace = le64_to_cpu(d->dqb_curspace);
+	m->dqb_btime = le64_to_cpu(d->dqb_btime);
+}
+
+static void mem2diskdqb(struct v2_disk_dqblk *d, struct mem_dqblk *m, qid_t 
id)
+{
+	d->dqb_ihardlimit = cpu_to_le32(m->dqb_ihardlimit);
+	d->dqb_isoftlimit = cpu_to_le32(m->dqb_isoftlimit);
+	d->dqb_curinodes = cpu_to_le32(m->dqb_curinodes);
+	d->dqb_itime = cpu_to_le64(m->dqb_itime);
+	d->dqb_bhardlimit = cpu_to_le32(m->dqb_bhardlimit);
+	d->dqb_bsoftlimit = cpu_to_le32(m->dqb_bsoftlimit);
+	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
+	d->dqb_btime = cpu_to_le64(m->dqb_btime);
+	d->dqb_id = cpu_to_le32(id);
+}
+
+static dqbuf_t getdqbuf(void)
+{
+	dqbuf_t buf = kmalloc(V2_DQBLKSIZE, GFP_KERNEL);
+	if (!buf)
+		printk(KERN_WARNING "VFS: Not enough memory for quota buffers.\n");
+	return buf;
+}
+
+static inline void freedqbuf(dqbuf_t buf)
+{
+	kfree(buf);
+}
+
+static ssize_t read_blk(struct file *filp, uint blk, dqbuf_t buf)
+{
+	mm_segment_t fs;
+	ssize_t ret;
+	loff_t offset = blk<<V2_DQBLKSIZE_BITS;
+
+	memset(buf, 0, V2_DQBLKSIZE);
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = filp->f_op->read(filp, (char *)buf, V2_DQBLKSIZE, &offset);
+	set_fs(fs);
+	return ret;
+}
+
+static ssize_t write_blk(struct file *filp, uint blk, dqbuf_t buf)
+{
+	mm_segment_t fs;
+	ssize_t ret;
+	loff_t offset = blk<<V2_DQBLKSIZE_BITS;
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = filp->f_op->write(filp, (char *)buf, V2_DQBLKSIZE, &offset);
+	set_fs(fs);
+	return ret;
+
+}
+
+/* Remove empty block from list and return it */
+static int get_free_dqblk(struct file *filp, struct mem_dqinfo *info)
+{
+	dqbuf_t buf = getdqbuf();
+	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
+	int ret, blk;
+
+	if (!buf)
+		return -ENOMEM;
+	if (info->u.v2_i.dqi_free_blk) {
+		blk = info->u.v2_i.dqi_free_blk;
+		if ((ret = read_blk(filp, blk, buf)) < 0)
+			goto out_buf;
+		info->u.v2_i.dqi_free_blk = le32_to_cpu(dh->dqdh_next_free);
+	}
+	else {
+		memset(buf, 0, V2_DQBLKSIZE);
+		if ((ret = write_blk(filp, info->u.v2_i.dqi_blocks, buf)) < 0)	/* Assure 
block allocation... */
+			goto out_buf;
+		blk = info->u.v2_i.dqi_blocks++;
+	}
+	mark_info_dirty(info);
+	ret = blk;
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Insert empty block to the list */
+static int put_free_dqblk(struct file *filp, struct mem_dqinfo *info, 
dqbuf_t buf, uint blk)
+{
+	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
+	int err;
+
+	dh->dqdh_next_free = cpu_to_le32(info->u.v2_i.dqi_free_blk);
+	dh->dqdh_prev_free = cpu_to_le32(0);
+	dh->dqdh_entries = cpu_to_le16(0);
+	info->u.v2_i.dqi_free_blk = blk;
+	mark_info_dirty(info);
+	if ((err = write_blk(filp, blk, buf)) < 0)	/* Some strange block. We had 
better leave it... */
+		return err;
+	return 0;
+}
+
+/* Remove given block from the list of blocks with free entries */
+static int remove_free_dqentry(struct file *filp, struct mem_dqinfo *info, 
dqbuf_t buf, uint blk)
+{
+	dqbuf_t tmpbuf = getdqbuf();
+	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
+	uint nextblk = le32_to_cpu(dh->dqdh_next_free), prevblk = 
le32_to_cpu(dh->dqdh_prev_free);
+	int err;
+
+	if (!tmpbuf)
+		return -ENOMEM;
+	if (nextblk) {
+		if ((err = read_blk(filp, nextblk, tmpbuf)) < 0)
+			goto out_buf;
+		((struct v2_disk_dqdbheader *)tmpbuf)->dqdh_prev_free = dh->dqdh_prev_free;
+		if ((err = write_blk(filp, nextblk, tmpbuf)) < 0)
+			goto out_buf;
+	}
+	if (prevblk) {
+		if ((err = read_blk(filp, prevblk, tmpbuf)) < 0)
+			goto out_buf;
+		((struct v2_disk_dqdbheader *)tmpbuf)->dqdh_next_free = dh->dqdh_next_free;
+		if ((err = write_blk(filp, prevblk, tmpbuf)) < 0)
+			goto out_buf;
+	}
+	else {
+		info->u.v2_i.dqi_free_entry = nextblk;
+		mark_info_dirty(info);
+	}
+	freedqbuf(tmpbuf);
+	dh->dqdh_next_free = dh->dqdh_prev_free = cpu_to_le32(0);
+	if (write_blk(filp, blk, buf) < 0)	/* No matter whether write succeeds 
block is out of list */
+		printk(KERN_ERR "VFS: Can't write block (%u) with free entries.\n", blk);
+	return 0;
+out_buf:
+	freedqbuf(tmpbuf);
+	return err;
+}
+
+/* Insert given block to the beginning of list with free entries */
+static int insert_free_dqentry(struct file *filp, struct mem_dqinfo *info, 
dqbuf_t buf, uint blk)
+{
+	dqbuf_t tmpbuf = getdqbuf();
+	struct v2_disk_dqdbheader *dh = (struct v2_disk_dqdbheader *)buf;
+	int err;
+
+	if (!tmpbuf)
+		return -ENOMEM;
+	dh->dqdh_next_free = cpu_to_le32(info->u.v2_i.dqi_free_entry);
+	dh->dqdh_prev_free = cpu_to_le32(0);
+	if ((err = write_blk(filp, blk, buf)) < 0)
+		goto out_buf;
+	if (info->u.v2_i.dqi_free_entry) {
+		if ((err = read_blk(filp, info->u.v2_i.dqi_free_entry, tmpbuf)) < 0)
+			goto out_buf;
+		((struct v2_disk_dqdbheader *)tmpbuf)->dqdh_prev_free = cpu_to_le32(blk);
+		if ((err = write_blk(filp, info->u.v2_i.dqi_free_entry, tmpbuf)) < 0)
+			goto out_buf;
+	}
+	freedqbuf(tmpbuf);
+	info->u.v2_i.dqi_free_entry = blk;
+	mark_info_dirty(info);
+	return 0;
+out_buf:
+	freedqbuf(tmpbuf);
+	return err;
+}
+
+/* Find space for dquot */
+static uint find_free_dqentry(struct dquot *dquot, int *err)
+{
+	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info+dquot->dq_type;
+	uint blk, i;
+	struct v2_disk_dqdbheader *dh;
+	struct v2_disk_dqblk *ddquot;
+	struct v2_disk_dqblk fakedquot;
+	dqbuf_t buf;
+
+	*err = 0;
+	if (!(buf = getdqbuf())) {
+		*err = -ENOMEM;
+		return 0;
+	}
+	dh = (struct v2_disk_dqdbheader *)buf;
+	ddquot = GETENTRIES(buf);
+	if (info->u.v2_i.dqi_free_entry) {
+		blk = info->u.v2_i.dqi_free_entry;
+		if ((*err = read_blk(filp, blk, buf)) < 0)
+			goto out_buf;
+	}
+	else {
+		blk = get_free_dqblk(filp, info);
+		if ((int)blk < 0) {
+			*err = blk;
+			return 0;
+		}
+		memset(buf, 0, V2_DQBLKSIZE);
+		info->u.v2_i.dqi_free_entry = blk;	/* This is enough as block is already 
zeroed and entry list is empty... */
+		mark_info_dirty(info);
+	}
+	if (le16_to_cpu(dh->dqdh_entries)+1 >= V2_DQSTRINBLK)	/* Block will be 
full? */
+		if ((*err = remove_free_dqentry(filp, info, buf, blk)) < 0) {
+			printk(KERN_ERR "VFS: find_free_dqentry(): Can't remove block (%u) from 
entry free list.\n", blk);
+			goto out_buf;
+		}
+	dh->dqdh_entries = cpu_to_le16(le16_to_cpu(dh->dqdh_entries)+1);
+	memset(&fakedquot, 0, sizeof(struct v2_disk_dqblk));
+	/* Find free structure in block */
+	for (i = 0; i < V2_DQSTRINBLK && memcmp(&fakedquot, ddquot+i, sizeof(struct 
v2_disk_dqblk)); i++);
+#ifdef __QUOTA_V2_PARANOIA
+	if (i == V2_DQSTRINBLK) {
+		printk(KERN_ERR "VFS: find_free_dqentry(): Data block full but it 
shouldn't.\n");
+		*err = -EIO;
+		goto out_buf;
+	}
+#endif
+	if ((*err = write_blk(filp, blk, buf)) < 0) {
+		printk(KERN_ERR "VFS: find_free_dqentry(): Can't write quota data block 
%u.\n", blk);
+		goto out_buf;
+	}
+	dquot->dq_off = (blk<<V2_DQBLKSIZE_BITS)+sizeof(struct 
v2_disk_dqdbheader)+i*sizeof(struct v2_disk_dqblk);
+	freedqbuf(buf);
+	return blk;
+out_buf:
+	freedqbuf(buf);
+	return 0;
+}
+
+/* Insert reference to structure into the trie */
+static int do_insert_tree(struct dquot *dquot, uint *treeblk, int depth)
+{
+	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
+	dqbuf_t buf;
+	int ret = 0, newson = 0, newact = 0;
+	u32 *ref;
+	uint newblk;
+
+	if (!(buf = getdqbuf()))
+		return -ENOMEM;
+	if (!*treeblk) {
+		ret = get_free_dqblk(filp, info);
+		if (ret < 0)
+			goto out_buf;
+		*treeblk = ret;
+		memset(buf, 0, V2_DQBLKSIZE);
+		newact = 1;
+	}
+	else {
+		if ((ret = read_blk(filp, *treeblk, buf)) < 0) {
+			printk(KERN_ERR "VFS: Can't read tree quota block %u.\n", *treeblk);
+			goto out_buf;
+		}
+	}
+	ref = (u32 *)buf;
+	newblk = le32_to_cpu(ref[GETIDINDEX(dquot->dq_id, depth)]);
+	if (!newblk)
+		newson = 1;
+	if (depth == V2_DQTREEDEPTH-1) {
+#ifdef __QUOTA_V2_PARANOIA
+		if (newblk) {
+			printk(KERN_ERR "VFS: Inserting already present quota entry (block 
%u).\n", ref[GETIDINDEX(dquot->dq_id, depth)]);
+			ret = -EIO;
+			goto out_buf;
+		}
+#endif
+		newblk = find_free_dqentry(dquot, &ret);
+	}
+	else
+		ret = do_insert_tree(dquot, &newblk, depth+1);
+	if (newson && ret >= 0) {
+		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(newblk);
+		ret = write_blk(filp, *treeblk, buf);
+	}
+	else if (newact && ret < 0)
+		put_free_dqblk(filp, info, buf, *treeblk);
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Wrapper for inserting quota structure into tree */
+static inline int dq_insert_tree(struct dquot *dquot)
+{
+	int tmp = V2_DQTREEOFF;
+	return do_insert_tree(dquot, &tmp, 0);
+}
+
+/*
+ *	We don't have to be afraid of deadlocks as we never have quotas on quota 
files...
+ */
+static int v2_write_dquot(struct dquot *dquot)
+{
+	int type = dquot->dq_type;
+	struct file *filp;
+	mm_segment_t fs;
+	loff_t offset;
+	ssize_t ret;
+	struct v2_disk_dqblk ddquot;
+
+	if (!dquot->dq_off)
+		if ((ret = dq_insert_tree(dquot)) < 0) {
+			printk(KERN_ERR "VFS: Error %d occured while creating quota.\n", ret);
+			return ret;
+		}
+	filp = sb_dqopt(dquot->dq_sb)->files[type];
+	offset = dquot->dq_off;
+	mem2diskdqb(&ddquot, &dquot->dq_dqb, dquot->dq_id);
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = filp->f_op->write(filp, (char *)&ddquot, sizeof(struct 
v2_disk_dqblk), &offset);
+	set_fs(fs);
+	if (ret != sizeof(struct v2_disk_dqblk)) {
+		printk(KERN_WARNING "VFS: dquota write failed on dev %s\n", 
kdevname(dquot->dq_dev));
+		if (ret >= 0)
+			ret = -ENOSPC;
+	}
+	else
+		ret = 0;
+	dqstats.writes++;
+	return ret;
+}
+
+/* Free dquot entry in data block */
+static int free_dqentry(struct dquot *dquot, uint blk)
+{
+	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
+	struct v2_disk_dqdbheader *dh;
+	dqbuf_t buf = getdqbuf();
+	int ret = 0;
+
+	if (!buf)
+		return -ENOMEM;
+	if (dquot->dq_off >> V2_DQBLKSIZE_BITS != blk) {
+		printk(KERN_ERR "VFS: Quota structure has offset to other block (%u) than 
it should (%u).\n", blk, (uint)(dquot->dq_off >> V2_DQBLKSIZE_BITS));
+		goto out_buf;
+	}
+	if ((ret = read_blk(filp, blk, buf)) < 0) {
+		printk(KERN_ERR "VFS: Can't read quota data block %u\n", blk);
+		goto out_buf;
+	}
+	dh = (struct v2_disk_dqdbheader *)buf;
+	dh->dqdh_entries = cpu_to_le16(le16_to_cpu(dh->dqdh_entries)-1);
+	if (!le16_to_cpu(dh->dqdh_entries)) {	/* Block got free? */
+		if ((ret = remove_free_dqentry(filp, info, buf, blk)) < 0 ||
+		    (ret = put_free_dqblk(filp, info, buf, blk)) < 0) {
+			printk(KERN_ERR "VFS: Can't move quota data block (%u) to free list.\n", 
blk);
+			goto out_buf;
+		}
+	}
+	else {
+		memset(buf+(dquot->dq_off & ((1 << V2_DQBLKSIZE_BITS)-1)), 0, 
sizeof(struct v2_disk_dqblk));
+		if (le16_to_cpu(dh->dqdh_entries) == V2_DQSTRINBLK-1) {
+			/* Insert will write block itself */
+			if ((ret = insert_free_dqentry(filp, info, buf, blk)) < 0) {
+				printk(KERN_ERR "VFS: Can't insert quota data block (%u) to free entry 
list.\n", blk);
+				goto out_buf;
+			}
+		}
+		else
+			if ((ret = write_blk(filp, blk, buf)) < 0) {
+				printk(KERN_ERR "VFS: Can't write quota data block %u\n", blk);
+				goto out_buf;
+			}
+	}
+	dquot->dq_off = 0;	/* Quota is now unattached */
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Remove reference to dquot from tree */
+static int remove_tree(struct dquot *dquot, uint *blk, int depth)
+{
+	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	struct mem_dqinfo *info = sb_dqopt(dquot->dq_sb)->info + dquot->dq_type;
+	dqbuf_t buf = getdqbuf();
+	int ret = 0;
+	uint newblk;
+	u32 *ref = (u32 *)buf;
+	
+	if (!buf)
+		return -ENOMEM;
+	if ((ret = read_blk(filp, *blk, buf)) < 0) {
+		printk(KERN_ERR "VFS: Can't read quota data block %u\n", *blk);
+		goto out_buf;
+	}
+	newblk = le32_to_cpu(ref[GETIDINDEX(dquot->dq_id, depth)]);
+	if (depth == V2_DQTREEDEPTH-1) {
+		ret = free_dqentry(dquot, newblk);
+		newblk = 0;
+	}
+	else
+		ret = remove_tree(dquot, &newblk, depth+1);
+	if (ret >= 0 && !newblk) {
+		int i;
+		ref[GETIDINDEX(dquot->dq_id, depth)] = cpu_to_le32(0);
+		for (i = 0; i < V2_DQBLKSIZE && !buf[i]; i++);	/* Block got empty? */
+		if (i == V2_DQBLKSIZE) {
+			put_free_dqblk(filp, info, buf, *blk);
+			*blk = 0;
+		}
+		else
+			if ((ret = write_blk(filp, *blk, buf)) < 0)
+				printk(KERN_ERR "VFS: Can't write quota tree block %u.\n", *blk);
+	}
+out_buf:
+	freedqbuf(buf);
+	return ret;	
+}
+
+/* Delete dquot from tree */
+static int v2_delete_dquot(struct dquot *dquot)
+{
+	uint tmp = V2_DQTREEOFF;
+
+	if (!dquot->dq_off)	/* Even not allocated? */
+		return 0;
+	return remove_tree(dquot, &tmp, 0);
+}
+
+/* Find entry in block */
+static loff_t find_block_dqentry(struct dquot *dquot, uint blk)
+{
+	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	dqbuf_t buf = getdqbuf();
+	loff_t ret = 0;
+	int i;
+	struct v2_disk_dqblk *ddquot = GETENTRIES(buf);
+
+	if (!buf)
+		return -ENOMEM;
+	if ((ret = read_blk(filp, blk, buf)) < 0) {
+		printk(KERN_ERR "VFS: Can't read quota tree block %u.\n", blk);
+		goto out_buf;
+	}
+	if (dquot->dq_id)
+		for (i = 0; i < V2_DQSTRINBLK && le32_to_cpu(ddquot[i].dqb_id) != 
dquot->dq_id; i++);
+	else {	/* ID 0 as a bit more complicated searching... */
+		struct v2_disk_dqblk fakedquot;
+
+		memset(&fakedquot, 0, sizeof(struct v2_disk_dqblk));
+		for (i = 0; i < V2_DQSTRINBLK; i++)
+			if (!le32_to_cpu(ddquot[i].dqb_id) && memcmp(&fakedquot, ddquot+i, 
sizeof(struct v2_disk_dqblk)))
+				break;
+	}
+	if (i == V2_DQSTRINBLK) {
+		printk(KERN_ERR "VFS: Quota for id %u referenced but not present.\n", 
dquot->dq_id);
+		ret = -EIO;
+		goto out_buf;
+	}
+	else
+		ret = (blk << V2_DQBLKSIZE_BITS) + sizeof(struct v2_disk_dqdbheader) + i * 
sizeof(struct v2_disk_dqblk);
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Find entry for given id in the tree */
+static loff_t find_tree_dqentry(struct dquot *dquot, uint blk, int depth)
+{
+	struct file *filp = sb_dqopt(dquot->dq_sb)->files[dquot->dq_type];
+	dqbuf_t buf = getdqbuf();
+	loff_t ret = 0;
+	u32 *ref = (u32 *)buf;
+
+	if (!buf)
+		return -ENOMEM;
+	if ((ret = read_blk(filp, blk, buf)) < 0) {
+		printk(KERN_ERR "VFS: Can't read quota tree block %u.\n", blk);
+		goto out_buf;
+	}
+	ret = 0;
+	blk = le32_to_cpu(ref[GETIDINDEX(dquot->dq_id, depth)]);
+	if (!blk)	/* No reference? */
+		goto out_buf;
+	if (depth < V2_DQTREEDEPTH-1)
+		ret = find_tree_dqentry(dquot, blk, depth+1);
+	else
+		ret = find_block_dqentry(dquot, blk);
+out_buf:
+	freedqbuf(buf);
+	return ret;
+}
+
+/* Find entry for given id in the tree - wrapper function */
+static inline loff_t find_dqentry(struct dquot *dquot)
+{
+	return find_tree_dqentry(dquot, V2_DQTREEOFF, 0);
+}
+
+static int v2_read_dquot(struct dquot *dquot)
+{
+	int type = dquot->dq_type;
+	struct file *filp;
+	mm_segment_t fs;
+	loff_t offset;
+	struct v2_disk_dqblk ddquot;
+	int ret = 0;
+
+	filp = sb_dqopt(dquot->dq_sb)->files[type];
+
+#ifdef __QUOTA_V2_PARANOIA
+	if (!filp || !dquot->dq_sb) {	/* Invalidated quota? */
+		printk(KERN_ERR "VFS: Quota invalidated while reading!\n");
+		return -EIO;
+	}
+#endif
+	offset = find_dqentry(dquot);
+	if (offset <= 0) {	/* Entry not present? */
+		if (offset < 0)
+			printk(KERN_ERR "VFS: Can't read quota structure for id %u.\n", 
dquot->dq_id);
+		dquot->dq_off = 0;
+		dquot->dq_flags |= DQ_FAKE;
+		memset(&dquot->dq_dqb, 0, sizeof(struct mem_dqblk));
+		ret = offset;
+	}
+	else {
+		dquot->dq_off = offset;
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+		if ((ret = filp->f_op->read(filp, (char *)&ddquot, sizeof(struct 
v2_disk_dqblk), &offset)) != sizeof(struct v2_disk_dqblk)) {
+			if (ret >= 0)
+				ret = -EIO;
+			printk(KERN_ERR "VFS: Error while reading quota structure for id %u.\n", 
dquot->dq_id);
+			memset(&ddquot, 0, sizeof(struct v2_disk_dqblk));
+		}
+		else
+			ret = 0;
+		set_fs(fs);
+		disk2memdqb(&dquot->dq_dqb, &ddquot);
+	}
+	dqstats.reads++;
+	return ret;
+}
+
+/* Commit changes of dquot to disk - it might also mean deleting it when 
quota became fake one and user has no blocks... */
+static int v2_commit_dquot(struct dquot *dquot)
+{
+	/* We clear the flag everytime so we don't loop when there was an IO 
error... */
+	dquot->dq_flags &= ~DQ_MOD;
+	if (dquot->dq_flags & DQ_FAKE && !(dquot->dq_dqb.dqb_curinodes | 
dquot->dq_dqb.dqb_curspace))
+		return v2_delete_dquot(dquot);
+	else
+		return v2_write_dquot(dquot);
+}
+
+static struct quota_format_ops v2_format_ops = {
+	check_quota_file:	v2_check_quota_file,
+	read_file_info:		v2_read_file_info,
+	write_file_info:	v2_write_file_info,
+	free_file_info:		NULL,
+	read_dqblk:		v2_read_dquot,
+	commit_dqblk:		v2_commit_dquot,
+};
+
+static struct quota_format_type v2_quota_format = {
+	qf_fmt_id:	QFMT_VFS_V0,
+	qf_ops:		&v2_format_ops,
+	qf_owner:	THIS_MODULE
+};
+
+static int __init init_v2_quota_format(void)
+{
+	return register_quota_format(&v2_quota_format);
+}
+
+static void __exit exit_v2_quota_format(void)
+{
+	unregister_quota_format(&v2_quota_format);
+}
+
+EXPORT_NO_SYMBOLS;
+
+module_init(init_v2_quota_format);
+module_exit(exit_v2_quota_format);
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/dqblk_v2.h 
linux-2.5/include/linux/dqblk_v2.h
--- linux-2.5-linus/include/linux/dqblk_v2.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5/include/linux/dqblk_v2.h	Sun Mar  3 03:21:20 2002
@@ -0,0 +1,20 @@
+/*
+ *	Definitions of structures for vfsv0 quota format
+ */
+
+#ifndef _LINUX_DQBLK_V2_H
+#define _LINUX_DQBLK_V2_H
+
+#include <linux/types.h>
+
+/* id numbers of quota format */
+#define QFMT_VFS_V0 2
+
+/* Inmemory copy of version specific information */
+struct v2_mem_dqinfo {
+	unsigned int dqi_blocks;
+	unsigned int dqi_free_blk;
+	unsigned int dqi_free_entry;
+};
+
+#endif /* _LINUX_DQBLK_V2_H */
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sun Mar  3 03:24:09 2002
+++ linux-2.5/include/linux/quota.h	Sun Mar  3 03:23:41 2002
@@ -136,6 +136,7 @@
 
 #include <linux/xqm.h>
 #include <linux/dqblk_v1.h>
+#include <linux/dqblk_v2.h>
 
 /*
  * Data for one user/group kept in memory
@@ -163,6 +164,7 @@
 	unsigned int dqi_igrace;
 	union {
 		struct v1_mem_dqinfo v1_i;
+		struct v2_mem_dqinfo v2_i;
 	} u;
 };
 
@@ -214,6 +216,7 @@
 	/* fields after this point are cleared when invalidating */
 	struct super_block *dq_sb;	/* superblock this applies to */
 	unsigned int dq_id;		/* ID this applies to (uid, gid) */
+	loff_t dq_off;			/* Offset of dquot on disk */
 	short dq_type;			/* Type of quota */
 	short dq_flags;			/* See DQ_* */
 	unsigned long dq_referenced;	/* Number of times this dquot was 
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaio_v2.h 
linux-2.5/include/linux/quotaio_v2.h
--- linux-2.5-linus/include/linux/quotaio_v2.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5/include/linux/quotaio_v2.h	Sun Mar  3 03:21:20 2002
@@ -0,0 +1,79 @@
+/*
+ *	Definitions of structures for vfsv0 quota format
+ */
+
+#ifndef _LINUX_QUOTAIO_V2_H
+#define _LINUX_QUOTAIO_V2_H
+
+#include <linux/types.h>
+#include <linux/quota.h>
+
+/*
+ * Definitions of magics and versions of current quota files
+ */
+#define V2_INITQMAGICS {\
+	0xd9c01f11,	/* USRQUOTA */\
+	0xd9c01927	/* GRPQUOTA */\
+}
+
+#define V2_INITQVERSIONS {\
+	0,		/* USRQUOTA */\
+	0		/* GRPQUOTA */\
+}
+
+/*
+ * The following structure defines the format of the disk quota file
+ * (as it appears on disk) - the file is a radix tree whose leaves point
+ * to blocks of these structures.
+ */
+struct v2_disk_dqblk {
+	__u32 dqb_id;		/* id this quota applies to */
+	__u32 dqb_ihardlimit;	/* absolute limit on allocated inodes */
+	__u32 dqb_isoftlimit;	/* preferred inode limit */
+	__u32 dqb_curinodes;	/* current # allocated inodes */
+	__u32 dqb_bhardlimit;	/* absolute limit on disk space (in QUOTABLOCK_SIZE) 
*/
+	__u32 dqb_bsoftlimit;	/* preferred limit on disk space (in QUOTABLOCK_SIZE) 
*/
+	__u64 dqb_curspace;	/* current space occupied (in bytes) */
+	__u64 dqb_btime;	/* time limit for excessive disk use */
+	__u64 dqb_itime;	/* time limit for excessive inode use */
+};
+
+/*
+ * Here are header structures as written on disk and their in-memory copies
+ */
+/* First generic header */
+struct v2_disk_dqheader {
+	__u32 dqh_magic;	/* Magic number identifying file */
+	__u32 dqh_version;	/* File version */
+};
+
+/* Header with type and version specific information */
+struct v2_disk_dqinfo {
+	__u32 dqi_bgrace;	/* Time before block soft limit becomes hard limit */
+	__u32 dqi_igrace;	/* Time before inode soft limit becomes hard limit */
+	__u32 dqi_flags;	/* Flags for quotafile (DQF_*) */
+	__u32 dqi_blocks;	/* Number of blocks in file */
+	__u32 dqi_free_blk;	/* Number of first free block in the list */
+	__u32 dqi_free_entry;	/* Number of block with at least one free entry */
+};
+
+/*
+ *  Structure of header of block with quota structures. It is padded to 16 
bytes so
+ *  there will be space for exactly 18 quota-entries in a block
+ */
+struct v2_disk_dqdbheader {
+	__u32 dqdh_next_free;	/* Number of next block with free entry */
+	__u32 dqdh_prev_free;	/* Number of previous block with free entry */
+	__u16 dqdh_entries;	/* Number of valid entries in block */
+	__u16 dqdh_pad1;
+	__u32 dqdh_pad2;
+};
+
+#define V2_DQINFOOFF	sizeof(struct v2_disk_dqheader)	/* Offset of info 
header in file */
+#define V2_DQBLKSIZE_BITS	10
+#define V2_DQBLKSIZE	(1 << V2_DQBLKSIZE_BITS)	/* Size of block with quota 
structures */
+#define V2_DQTREEOFF	1		/* Offset of tree in file in blocks */
+#define V2_DQTREEDEPTH	4		/* Depth of quota tree */
+#define V2_DQSTRINBLK	((V2_DQBLKSIZE - sizeof(struct v2_disk_dqdbheader)) / 
sizeof(struct v2_disk_dqblk))	/* Number of entries in one blocks */
+
+#endif /* _LINUX_QUOTAIO_V2_H */
