Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSGMJJB>; Sat, 13 Jul 2002 05:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318132AbSGMJI7>; Sat, 13 Jul 2002 05:08:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37590 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318131AbSGMJI4>;
	Sat, 13 Jul 2002 05:08:56 -0400
Date: Sat, 13 Jul 2002 05:11:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rearranging struct dentry for cache affinity
In-Reply-To: <E17T7BT-0006zT-00@pmenage-dt.ensim.com>
Message-ID: <Pine.GSO.4.21.0207130455530.13648-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2002, Paul Menage wrote:

> -	tmp = d_alloc(NULL, &(const struct qstr) {"",0,0});
> +	tmp = d_alloc(NULL, &(const struct qstr) { });

Ugh.  That changes behaviour and I'm less than sure that it's correct.
>  	if (!tmp)
>  		return NULL;
>  
> @@ -883,7 +883,10 @@
>  			if (memcmp(dentry->d_name.name, str, len))
>  				continue;
>  		}
> -		dentry->d_vfs_flags |= DCACHE_REFERENCED;
> +#ifdef CONFIG_SMP
> +		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED))
> +#endif
> +			dentry->d_vfs_flags |= DCACHE_REFERENCED;
>  		return dentry;

Absolutely no way.  If anything, lose that CONFIG_SMP - it's too fscking
ugly.  But I suspect that moving that line to final dput() (see previous
posting) would work better.

 diff -X /mnt/elbrus/home/pmenage/dontdiff -Naur linux-2.5.25/kernel/futex.c linux-2.5.25-dentry/kernel/futex.c
> --- linux-2.5.25/kernel/futex.c	Wed Jun 26 01:07:20 2002
> +++ linux-2.5.25-dentry/kernel/futex.c	Fri Jul 12 13:01:34 2002
[snip]

Eeek....

futex.c is seriously b0rken.

diff -urN C25/kernel/futex.c C25-current/kernel/futex.c
--- C25/kernel/futex.c	Thu Jun 20 20:28:00 2002
+++ C25-current/kernel/futex.c	Sat Jul 13 05:07:24 2002
@@ -48,7 +48,7 @@
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
 /* Everyone needs a dentry and inode */
-static struct dentry *futex_dentry;
+static struct vfsmount *futex_mnt;
 
 /* We use this instead of a normal wait_queue_t, so we can wake only
    the relevent ones (hashed queues may be shared) */
@@ -272,7 +272,8 @@
 		return -ENFILE;
 	}
 	filp->f_op = &futex_fops;
-	filp->f_dentry = dget(futex_dentry);
+	filp->f_vfsmnt = mntget(futex_mnt);
+	filp->f_dentry = dget(futex_mnt->mnt_root);
 
 	if (signal) {
 		filp->f_owner.pid = current->pid;
@@ -348,46 +349,16 @@
 	return ret;
 }
 
-/* FIXME: Oh yeah, makes sense to write a filesystem... */
-static struct super_operations futexfs_ops = { statfs: simple_statfs };
-
-/* Don't check error returns: we're dead if they happen */
-static int futexfs_fill_super(struct super_block *sb, void *data, int silent)
-{
-	struct inode *root;
-
-	sb->s_blocksize = 1024;
-	sb->s_blocksize_bits = 10;
-	sb->s_magic = 0xBAD1DEA;
-	sb->s_op = &futexfs_ops;
-
-	root = new_inode(sb);
-	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_uid = root->i_gid = 0;
-	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
-
-	sb->s_root = d_alloc(NULL, &(const struct qstr) { "futex", 5, 0 });
-	sb->s_root->d_sb = sb;
-	sb->s_root->d_parent = sb->s_root;
-	d_instantiate(sb->s_root, root);
-
-	/* We never let this drop to zero. */
-	futex_dentry = dget(sb->s_root);
-
-	return 0;
-}
-
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
 	       int flags, char *dev_name, void *data)
 {
-	return get_sb_nodev(fs_type, flags, data, futexfs_fill_super);
+	return get_sb_pseudo(fs_type, "futex", NULL, 0xBAD1DEA);
 }
 
 static struct file_system_type futex_fs_type = {
 	name:		"futexfs",
 	get_sb:		futexfs_get_sb,
-	kill_sb:	kill_anon_super,
 };
 
 static int __init init(void)
@@ -395,7 +366,7 @@
 	unsigned int i;
 
 	register_filesystem(&futex_fs_type);
-	kern_mount(&futex_fs_type);
+	futex_mnt = kern_mount(&futex_fs_type);
 
 	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
 		INIT_LIST_HEAD(&futex_queues[i]);

