Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWFVLQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWFVLQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWFVLQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:16:15 -0400
Received: from mx1.actcom.co.il ([192.114.47.64]:59520 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S1161059AbWFVLQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:16:14 -0400
Message-ID: <449A7BEB.1000709@codefidence.com>
Date: Thu, 22 Jun 2006 14:15:55 +0300
From: Gilad Ben-Yossef <gilad@codefidence.com>
Organization: Codefidence Ltd.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Atal Shargorodsky <atal@codefidence.com>,
       Gilad Ben-Yossef <gilad@codefidence.com>
Subject: [PATCH]  tmpfs: add export_operations to allow export via NFS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atal Shargorodsky <atal@codefidence.com>

This patch adds  export_operations callbacks to tmpfs to allow
exporting tmpfs mounts via knfsd.

Signed-off-by: Atal Shargorodsky <atal@codefidence.com>
Signed-off-by: Gilad Ben-Yossef <gilad@codefidence.com>

---

Caveats
~~~~~~~

Due to the lack of backing device, the use of the 'fsid' export option
is required for this to work.

The question of whether two different mounts of tmpfs exported at the same
path are considered exports of the same volume (e.g.: export /tmp,
reboot, export /tmp again) has been left to the user: if you think they
are different, assign  a different 'fsid', if you think they are not,
re-use the same 'fsid'.

Support for exporting a tmpfs volume with a large numbers of files will
require switching to a more scalable way to traverse the inode list then
the current linked list.

Tested on i386 and PowerPC, uniproccesors only.

Thank you goes to Muli Ben-Yehuda for his help in proof reading the
original patch.

--- linux-2.6.17.1/mm/shmem.c.orig	2006-06-20 12:31:55.000000000 +0300
+++ linux-2.6.17.1/mm/shmem.c	2006-06-22 14:09:48.000000000 +0300
@@ -74,6 +74,84 @@
  /* Pretend that each entry is of this size in directory's i_size */
  #define BOGO_DIRENT_SIZE 20

+#define TMPFS_EXPORT_MAGIC 102
+#define TMPFS_ROOT_INO 1
+static unsigned long shmem_export_ino_seq; /* not atomic_t because of using
+						lock anyway */
+static spinlock_t shmem_export_spin_lock;  /* because the need to update ino
+						and generation as atomic operation */
+static __u32 shmem_export_curr_generation; /* remember current generation */
+
+struct dentry * shmem_export_get_parent(struct dentry *child)
+{
+/* We don't want this function to succeed. because it's only
+called in situations that should not be handled by tmpfs.
+Reboot , just like umount/mount, creates NEW filesystem, so
+previously holded filehandlers are irrelevant */
+	return ERR_PTR(-ESTALE);
+}
+
+struct dentry * shmem_export_get_dentry(struct super_block *sb, void *fh)
+{
+	struct inode * inode = NULL;
+	struct inode * found_inode = NULL;
+	struct dentry * result;
+	unsigned long ino  = * (unsigned long *) fh;
+	__u32 generation  = * (__u32 *) (fh + sizeof(ino));
+	spin_lock(&inode_lock);	
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		if ((inode->i_ino == ino) &&
+			(inode->i_generation == generation)){
+			found_inode = inode;
+			break;
+		}
+	}
+  spin_unlock(&inode_lock);
+	if (!found_inode)
+		return ERR_PTR(-ESTALE);
+	result = d_find_alias(inode);
+	if (result == NULL)
+		return ERR_PTR(-ESTALE);
+	result->d_op = sb->s_root->d_op;
+	return result;
+}
+
+int shmem_export_encode_fh(struct dentry * dentry, __u32 *fh,int *lenp,
+			int connectable)
+{
+	struct inode *inode = dentry->d_inode;
+	char * raw = (char *)fh;
+	int room = sizeof (inode->i_ino) + sizeof (inode->i_generation);
+	if (*lenp < room + 1)
+		return 255; /* no room */
+	* (unsigned long *)(raw)=inode->i_ino;
+	* (__u32 *)(raw + sizeof(inode->i_ino)) =
+		inode->i_generation;
+	raw[room] = TMPFS_EXPORT_MAGIC;
+	*lenp=room+1;
+	return *lenp;
+}
+
+struct dentry *shmem_export_decode_fh(struct super_block *sb,
+			__u32 *data, int len, int fhtype,
+			int (*acceptable)(void *context, struct dentry * de),
+			void *context)
+{
+	char * raw = (char *)data;
+	int room = sizeof (unsigned long) + sizeof (__u32);
+	if (len < room+1 || raw[room] != TMPFS_EXPORT_MAGIC)
+		return ERR_PTR(-ESTALE);
+	return sb->s_export_op->find_exported_dentry(sb,data,NULL,
+		acceptable,context);
+}
+
+static struct export_operations shmem_export_ops = {
+	.get_parent = shmem_export_get_parent,
+	.get_dentry = shmem_export_get_dentry,
+	.encode_fh = shmem_export_encode_fh,
+	.decode_fh = shmem_export_decode_fh,
+};
+
  /* Flag allocation requirements to shmem_getpage and shmem_swp_alloc */
  enum sgp_type {
  	SGP_QUICK,	/* don't try more than file page cache lookup */
@@ -1357,6 +1435,14 @@ shmem_get_inode(struct super_block *sb,

  	inode = new_inode(sb);
  	if (inode) {
+		spin_lock(&shmem_export_spin_lock);
+		inode->i_ino = ++shmem_export_ino_seq;
+		if (!inode->i_ino){
+			inode->i_ino = TMPFS_ROOT_INO + 1;
+			shmem_export_curr_generation++;
+		}
+		inode->i_generation = shmem_export_curr_generation;
+		spin_unlock(&shmem_export_spin_lock);
  		inode->i_mode = mode;
  		inode->i_uid = current->fsuid;
  		inode->i_gid = current->fsgid;
@@ -2103,6 +2189,7 @@ static int shmem_fill_super(struct super
  	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
  	sb->s_magic = TMPFS_MAGIC;
  	sb->s_op = &shmem_ops;
+	sb->s_export_op = &shmem_export_ops;
  	sb->s_time_gran = 1;

  	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
@@ -2110,6 +2197,11 @@ static int shmem_fill_super(struct super
  		goto failed;
  	inode->i_uid = uid;
  	inode->i_gid = gid;
+	spin_lock(&shmem_export_spin_lock);
+	shmem_export_ino_seq = TMPFS_ROOT_INO;
+	inode->i_ino = TMPFS_ROOT_INO;
+	inode->i_generation = ++shmem_export_curr_generation;
+	spin_unlock(&shmem_export_spin_lock);
  	root = d_alloc_root(inode);
  	if (!root)
  		goto failed_iput;
@@ -2251,6 +2343,7 @@ static int __init init_tmpfs(void)
  {
  	int error;

+	spin_lock_init(&shmem_export_spin_lock);
  	error = init_inodecache();
  	if (error)
  		goto out3;


-- 
Gilad Ben-Yossef <gilad@codefidence.com>
Codefidence. A name you can trust(tm)
Web: http://codefidence.com  | SIP: gilad@pbx.codefidence.com
IL: +972.3.7515563 ext. 201  | Fax:            +972.3.7515503
US: +1.212.2026643 ext. 201  | Cel:           +972.52.8260388

	The journey of a thousand miles begins with a single "oy."

