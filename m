Return-Path: <linux-kernel-owner+willy=40w.ods.org-S518467AbUKBD5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S518467AbUKBD5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S518698AbUKBD5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:57:53 -0500
Received: from koto.vergenet.net ([210.128.90.7]:22217 "HELO koto.vergenet.net")
	by vger.kernel.org with SMTP id S518638AbUKBD5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 22:57:06 -0500
Date: Tue, 2 Nov 2004 12:56:35 +0900
From: Horms <horms@verge.net.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Siep Kroonenberg <siepo@cybercomm.nl>,
       278068@bugs.debian.org
Subject: Re: chmod messes up permissions on hfs filesystem
Message-ID: <20041102035635.GA28481@verge.net.au>
References: <20041101043559.GA12500@verge.net.au> <Pine.LNX.4.61.0411011721560.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411011721560.877@scrub.home>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 05:27:47PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 1 Nov 2004, Horms wrote:
> 
> > -rw-r--r--
> > after chmod g+w:
> > -rw-rw-rw-
> 
> No, this command will do nothing, as only the owner write bit is checked  
> and the owner bit is mirrored in the other parts (minus umask).
> Below is a patch which should fix the original problem.

Hi,

Thanks for the patch, though the behaviour of the umask still seems
rather odd. I would like to offer an updated patch which I believe
makes the umask behave in the expected way. It also ensures
that the write_lock bit is read from/written to disk correctly.

-- 
Horms


===== fs/hfs/inode.c 1.24 vs edited =====
--- 1.24/fs/hfs/inode.c	2004-10-26 05:06:48 +09:00
+++ edited/fs/hfs/inode.c	2004-11-01 20:56:45 +09:00
@@ -158,6 +158,7 @@ struct inode *hfs_new_inode(struct inode
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = new_inode(sb);
+	struct hfs_sb_info *hsb = HFS_SB(dir->i_sb);
 	if (!inode)
 		return NULL;
 
@@ -165,7 +166,6 @@ struct inode *hfs_new_inode(struct inode
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	hfs_cat_build_key((btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	inode->i_ino = HFS_SB(sb)->next_id++;
-	inode->i_mode = mode;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 	inode->i_nlink = 1;
@@ -174,14 +174,15 @@ struct inode *hfs_new_inode(struct inode
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
-	if (S_ISDIR(inode->i_mode)) {
+	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		HFS_SB(sb)->folder_count++;
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
-	} else if (S_ISREG(inode->i_mode)) {
+		inode->i_mode = (mode & ~0777) | (~hsb->s_dir_umask & 0777);
+	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		HFS_SB(sb)->file_count++;
 		if (dir->i_ino == HFS_ROOT_CNID)
@@ -196,6 +197,11 @@ struct inode *hfs_new_inode(struct inode
 		HFS_I(inode)->cached_blocks = 0;
 		memset(HFS_I(inode)->first_extents, 0, sizeof(hfs_extent_rec));
 		memset(HFS_I(inode)->cached_extents, 0, sizeof(hfs_extent_rec));
+		inode->i_mode = (mode & ~0777) | (~hsb->s_file_umask & 0777);
+		if (mode & S_IWUSR)
+			inode->i_mode |= S_IWUGO;
+		else
+			inode->i_mode &= ~S_IWUGO;
 	}
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
@@ -314,10 +320,11 @@ int hfs_read_inode(struct inode *inode, 
 		}
 
 		inode->i_ino = be32_to_cpu(rec->file.FlNum);
-		inode->i_mode = S_IRUGO | S_IXUGO;
+		inode->i_mode = S_IRWXUGO & ~hsb->s_file_umask;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
-		inode->i_mode &= hsb->s_file_umask;
+		else
+			inode->i_mode &= ~S_IWUGO;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
 				hfs_m_to_utime(rec->file.MdDat);
@@ -329,7 +336,7 @@ int hfs_read_inode(struct inode *inode, 
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
-		inode->i_mode = S_IFDIR | (S_IRWXUGO & hsb->s_dir_umask);
+		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
 				hfs_m_to_utime(rec->dir.MdDat);
 		inode->i_op = &hfs_dir_inode_operations;
@@ -601,7 +608,6 @@ int hfs_inode_setattr(struct dentry *den
 			attr->ia_mode = inode->i_mode | S_IWUGO;
 		else
 			attr->ia_mode = inode->i_mode & ~S_IWUGO;
-		attr->ia_mode &= S_ISDIR(inode->i_mode) ? ~hsb->s_dir_umask: ~hsb->s_file_umask;
 	}
 	error = inode_setattr(inode, attr);
 	if (error)
===== fs/hfs/super.c 1.32 vs edited =====
--- 1.32/fs/hfs/super.c	2004-10-26 05:06:47 +09:00
+++ edited/fs/hfs/super.c	2004-11-01 20:01:54 +09:00
@@ -149,8 +149,8 @@ static int parse_options(char *options, 
 	/* initialize the sb with defaults */
 	hsb->s_uid = current->uid;
 	hsb->s_gid = current->gid;
-	hsb->s_file_umask = 0644;
-	hsb->s_dir_umask = 0755;
+	hsb->s_file_umask = 0111;
+	hsb->s_dir_umask = 0000;
 	hsb->s_type = hsb->s_creator = cpu_to_be32(0x3f3f3f3f);	/* == '????' */
 	hsb->s_quiet = 0;
 	hsb->part = -1;
