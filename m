Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUKCQBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUKCQBC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKCQBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:01:02 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:49803 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261651AbUKCQAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:00:44 -0500
Date: Wed, 3 Nov 2004 17:00:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Horms <horms@verge.net.au>
cc: LKML <linux-kernel@vger.kernel.org>, Siep Kroonenberg <siepo@cybercomm.nl>,
       278068@bugs.debian.org
Subject: Re: chmod messes up permissions on hfs filesystem
In-Reply-To: <20041102035635.GA28481@verge.net.au>
Message-ID: <Pine.LNX.4.61.0411031639250.877@scrub.home>
References: <20041101043559.GA12500@verge.net.au> <Pine.LNX.4.61.0411011721560.877@scrub.home>
 <20041102035635.GA28481@verge.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2 Nov 2004, Horms wrote:

> Thanks for the patch, though the behaviour of the umask still seems
> rather odd. I would like to offer an updated patch which I believe
> makes the umask behave in the expected way. It also ensures
> that the write_lock bit is read from/written to disk correctly.

You apply the umask before updating the write bit, which is incorrect.

> @@ -196,6 +197,11 @@ struct inode *hfs_new_inode(struct inode
>  		HFS_I(inode)->cached_blocks = 0;
>  		memset(HFS_I(inode)->first_extents, 0, sizeof(hfs_extent_rec));
>  		memset(HFS_I(inode)->cached_extents, 0, sizeof(hfs_extent_rec));
> +		inode->i_mode = (mode & ~0777) | (~hsb->s_file_umask & 0777);
> +		if (mode & S_IWUSR)
> +			inode->i_mode |= S_IWUGO;
> +		else
> +			inode->i_mode &= ~S_IWUGO;
>  	}
>  	insert_inode_hash(inode);
>  	mark_inode_dirty(inode);

Thanks, for reminding me to fix hfs_new_inode here, but the above applies.

> ===== fs/hfs/super.c 1.32 vs edited =====
> --- 1.32/fs/hfs/super.c	2004-10-26 05:06:47 +09:00
> +++ edited/fs/hfs/super.c	2004-11-01 20:01:54 +09:00
> @@ -149,8 +149,8 @@ static int parse_options(char *options, 
>  	/* initialize the sb with defaults */
>  	hsb->s_uid = current->uid;
>  	hsb->s_gid = current->gid;
> -	hsb->s_file_umask = 0644;
> -	hsb->s_dir_umask = 0755;
> +	hsb->s_file_umask = 0111;
> +	hsb->s_dir_umask = 0000;
>  	hsb->s_type = hsb->s_creator = cpu_to_be32(0x3f3f3f3f);	/* == '????' */
>  	hsb->s_quiet = 0;
>  	hsb->part = -1;

This may be closer to the mac default, where everyone can access anything, 
but I'd rather keep a safe default.
Below is my updated patch.

bye, Roman

Index: fs/hfs/inode.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/fs/hfs/inode.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 inode.c
--- fs/hfs/inode.c	17 Jun 2004 08:39:32 -0000	1.1.1.5
+++ fs/hfs/inode.c	3 Nov 2004 15:51:43 -0000
@@ -172,14 +172,16 @@ struct inode *hfs_new_inode(struct inode
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
-	if (S_ISDIR(inode->i_mode)) {
+	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		HFS_SB(sb)->folder_count++;
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
-	} else if (S_ISREG(inode->i_mode)) {
+		inode->i_mode |= S_IRWXUGO;
+		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_dir_umask;
+	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		HFS_SB(sb)->file_count++;
 		if (dir->i_ino == HFS_ROOT_CNID)
@@ -187,6 +189,10 @@ struct inode *hfs_new_inode(struct inode
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
+		inode->i_mode |= S_IRUGO|S_IXUGO;
+		if (mode & S_IWUSR)
+			inode->i_mode |= S_IWUGO;
+		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_file_umask;
 		HFS_I(inode)->phys_size = 0;
 		HFS_I(inode)->alloc_blocks = 0;
 		HFS_I(inode)->first_blocks = 0;
@@ -313,7 +319,7 @@ int hfs_read_inode(struct inode *inode, 
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
-		inode->i_mode &= hsb->s_file_umask;
+		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
 				hfs_m_to_utime(rec->file.MdDat);
@@ -326,7 +332,7 @@ int hfs_read_inode(struct inode *inode, 
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_blocks = 0;
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
-		inode->i_mode = S_IFDIR | (S_IRWXUGO & hsb->s_dir_umask);
+		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
 		inode->i_ctime = inode->i_atime = inode->i_mtime =
 				hfs_m_to_utime(rec->file.MdDat);
 		inode->i_op = &hfs_dir_inode_operations;
Index: fs/hfs/super.c
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/fs/hfs/super.c,v
retrieving revision 1.1.1.5
diff -u -p -r1.1.1.5 super.c
--- fs/hfs/super.c	10 May 2004 15:02:37 -0000	1.1.1.5
+++ fs/hfs/super.c	1 Nov 2004 16:03:14 -0000
@@ -150,8 +150,8 @@ static int parse_options(char *options, 
 	/* initialize the sb with defaults */
 	hsb->s_uid = current->uid;
 	hsb->s_gid = current->gid;
-	hsb->s_file_umask = 0644;
-	hsb->s_dir_umask = 0755;
+	hsb->s_file_umask = 0133;
+	hsb->s_dir_umask = 0022;
 	hsb->s_type = 0x3f3f3f3f;	/* == '????' */
 	hsb->s_creator = 0x3f3f3f3f;	/* == '????' */
 	hsb->s_quiet = 0;
