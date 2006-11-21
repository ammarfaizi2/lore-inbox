Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934398AbWKUPqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934398AbWKUPqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934400AbWKUPqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:46:52 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2567 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S934398AbWKUPqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:46:51 -0500
X-AuthUser: hirofumi@parknet.jp
To: The Peach <smartart@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 22 Nov 2006 00:46:43 +0900
In-Reply-To: <20061120184912.5e1b1cac@localhost> (The Peach's message of "Mon\, 20 Nov 2006 18\:49\:12 +0100")
Message-ID: <87mz6kajks.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

The Peach <smartart@tiscali.it> writes:

> On Tue, 21 Nov 2006 02:32:43 +0900
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> I couldn't reproduce this for now. Could you tell mount options which
>> you used? and after mount, "cat /proc/mounts", please.
>
> # mount | grep vfat 
> /dev/sdb1 on /mnt/iomega type vfat (rw,uid=1000,gid=100,codepage=850,iocharset=iso8859-15) 
>
> it seems only related to those kind of files, but I don't know how to inspect the "file properties" and why these files behave like this.
> As you can see and with a strace made on cp, the files _seems_ to be copied with the correct case, whilst it isn't, as seen with "ls". This and other things let me think is a vfat problem.

Hmm... This may be the dentry cache handling problem of fat.

Can you try the attached debug patch? And if you comment-in the
following parts, does this problem fix?

@@ -787,6 +830,9 @@ static int vfat_rmdir(struct inode *dir,
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
+	/* need to revalidate for next create */
+	table = (sbi->options.name_check == 's') ? 3 : 1;
+//	dentry->d_op = &vfat_dentry_ops[table];
@@ -811,6 +858,9 @@ static int vfat_unlink(struct inode *dir
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
+	/* need to revalidate for next create */
+	table = (sbi->options.name_check == 's') ? 3 : 1;
+//	dentry->d_op = &vfat_dentry_ops[table];
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=vfat-debug.patch



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff -puN fs/vfat/namei.c~vfat-debug fs/vfat/namei.c
--- linux-2.6/fs/vfat/namei.c~vfat-debug	2006-11-21 23:23:38.000000000 +0900
+++ linux-2.6-hirofumi/fs/vfat/namei.c	2006-11-22 00:36:50.000000000 +0900
@@ -29,6 +29,8 @@ static int vfat_revalidate(struct dentry
 {
 	int ret = 1;
 
+	printk("%s: name %s, nd %p, flags %08x\n", __FUNCTION__,
+	       dentry->d_name.name, nd, nd ? nd->flags : 0);
 	if (!dentry->d_inode &&
 	    nd && !(nd->flags & LOOKUP_CONTINUE) && (nd->flags & LOOKUP_CREATE))
 		/*
@@ -83,6 +85,10 @@ static int vfat_hashi(struct dentry *den
 
 	name = qstr->name;
 	len = vfat_striptail_len(qstr);
+	printk("%s: parent %p, parent->d_op %p\n",
+	       __FUNCTION__, dentry, dentry->d_op);
+	printk("%s: parent %s, name %s\n", __FUNCTION__,
+	       dentry->d_name.name, name);
 
 	hash = init_name_hash();
 	while (len--)
@@ -100,6 +106,9 @@ static int vfat_cmpi(struct dentry *dent
 	struct nls_table *t = MSDOS_SB(dentry->d_inode->i_sb)->nls_io;
 	unsigned int alen, blen;
 
+	printk("%s: parent %p, parent->d_op %p\n",
+	       __FUNCTION__, dentry, dentry->d_op);
+	printk("%s: a %s, b %s\n", __FUNCTION__, a->name, b->name);
 	/* A filename cannot end in '.' or we treat it like it has none */
 	alen = vfat_striptail_len(a);
 	blen = vfat_striptail_len(b);
@@ -659,6 +668,34 @@ static int vfat_add_entry(struct inode *
 	if (err)
 		goto cleanup;
 
+{
+	int i;
+	for (i = nr_slots - 1; i >= 0; i--) {
+		if (i == (nr_slots - 1)) {
+			struct msdos_dir_entry *de =
+				(struct msdos_dir_entry *)&slots[i];
+			printk("%s: %d: %c%c%c%c%c%c%c%c, %c%c%c\n",
+			       __FUNCTION__,
+			       nr_slots - 1 - i,
+			       de->name[0], de->name[1], de->name[2],
+			       de->name[3], de->name[4], de->name[5],
+			       de->name[6], de->name[7],
+			       de->ext[0], de->ext[1], de->ext[2]);
+			continue;
+		}
+		printk("%s: %d: %c%c%c%c%c, %c%c%c%c%c%c, %c%c",
+		       __FUNCTION__,
+		       nr_slots - 1 - i,
+		       slots[i].name0_4[0], slots[i].name0_4[2],
+		       slots[i].name0_4[4], slots[i].name0_4[6],
+		       slots[i].name0_4[8],
+		       slots[i].name5_10[0], slots[i].name5_10[2],
+		       slots[i].name5_10[4], slots[i].name5_10[6],
+		       slots[i].name5_10[8], slots[i].name5_10[10],
+		       slots[i].name11_12[0], slots[i].name11_12[2]);
+		printk("\n");
+	}
+}
 	err = fat_add_entries(dir, slots, nr_slots, sinfo);
 	if (err)
 		goto cleanup;
@@ -692,6 +729,7 @@ static struct dentry *vfat_lookup(struct
 	struct dentry *alias;
 	int err, table;
 
+	printk("%s: name %s\n", __FUNCTION__, dentry->d_name.name);
 	lock_kernel();
 	table = (MSDOS_SB(sb)->options.name_check == 's') ? 2 : 0;
 	dentry->d_op = &vfat_dentry_ops[table];
@@ -714,6 +752,7 @@ static struct dentry *vfat_lookup(struct
 		else {
 			iput(inode);
 			unlock_kernel();
+			printk("%s: d_op %p\n", __FUNCTION__, alias->d_op);
 			return alias;
 		}
 
@@ -726,6 +765,7 @@ error:
 	if (dentry) {
 		dentry->d_op = &vfat_dentry_ops[table];
 		dentry->d_time = dentry->d_parent->d_inode->i_version;
+		printk("%s: d_op %p\n", __FUNCTION__, dentry->d_op);
 	}
 	return dentry;
 }
@@ -742,6 +782,7 @@ static int vfat_create(struct inode *dir
 	lock_kernel();
 
 	ts = CURRENT_TIME_SEC;
+	printk("%s: name %s\n", __FUNCTION__, dentry->d_name.name);
 	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
 	if (err)
 		goto out;
@@ -761,14 +802,16 @@ static int vfat_create(struct inode *dir
 	d_instantiate(dentry, inode);
 out:
 	unlock_kernel();
+	printk("%s: err %d\n", __FUNCTION__, err);
 	return err;
 }
 
 static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	struct fat_slot_info sinfo;
-	int err;
+	int err, table;
 
 	lock_kernel();
 
@@ -787,6 +830,9 @@ static int vfat_rmdir(struct inode *dir,
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
+	/* need to revalidate for next create */
+	table = (sbi->options.name_check == 's') ? 3 : 1;
+//	dentry->d_op = &vfat_dentry_ops[table];
 out:
 	unlock_kernel();
 
@@ -796,8 +842,9 @@ out:
 static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
 	struct fat_slot_info sinfo;
-	int err;
+	int err, table;
 
 	lock_kernel();
 
@@ -811,6 +858,9 @@ static int vfat_unlink(struct inode *dir
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
 	fat_detach(inode);
+	/* need to revalidate for next create */
+	table = (sbi->options.name_check == 's') ? 3 : 1;
+//	dentry->d_op = &vfat_dentry_ops[table];
 out:
 	unlock_kernel();
 
@@ -1019,6 +1069,8 @@ static int vfat_fill_super(struct super_
 		sb->s_root->d_op = &vfat_dentry_ops[0];
 	else
 		sb->s_root->d_op = &vfat_dentry_ops[2];
+	printk("%s: s_root %p, d_op %p\n", __FUNCTION__,
+	       sb->s_root, sb->s_root->d_op);
 
 	return 0;
 }
_

--=-=-=--
