Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271568AbRIBPbp>; Sun, 2 Sep 2001 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271634AbRIBPb0>; Sun, 2 Sep 2001 11:31:26 -0400
Received: from ns.caldera.de ([212.34.180.1]:46495 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271635AbRIBPbV>;
	Sun, 2 Sep 2001 11:31:21 -0400
Date: Sun, 2 Sep 2001 17:31:02 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VxFS update
Message-ID: <20010902173102.B11520@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the appended patch updates the VxFS driver to the latest version as
found in Alan's tree.  The patch contains:

 o fix memory leaks for failed mounts (partially from aeb)
 o allow mounting of filesystem with different blocksizes

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_bmap.c linux/fs/freevxfs/vxfs_bmap.c
--- ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_bmap.c	Thu Jun 28 02:10:55 2001
+++ linux/fs/freevxfs/vxfs_bmap.c	Sun Sep  2 17:04:50 2001
@@ -27,7 +27,7 @@
  * SUCH DAMAGE.
  */
 
-#ident "$Id: vxfs_bmap.c,v 1.22 2001/05/26 22:41:23 hch Exp hch $"
+#ident "$Id: vxfs_bmap.c,v 1.23 2001/07/05 19:48:03 hch Exp hch $"
 
 /*
  * Veritas filesystem driver - filesystem to disk block mapping.
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_extern.h linux/fs/freevxfs/vxfs_extern.h
--- ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_extern.h	Mon May 21 21:31:06 2001
+++ linux/fs/freevxfs/vxfs_extern.h	Sun Sep  2 17:04:50 2001
@@ -30,7 +30,7 @@
 #ifndef _VXFS_EXTERN_H_
 #define _VXFS_EXTERN_H_
 
-#ident "$Id: vxfs_extern.h,v 1.20 2001/04/26 22:48:44 hch Exp hch $"
+#ident "$Id: vxfs_extern.h,v 1.21 2001/08/07 16:13:30 hch Exp hch $"
 
 /*
  * Veritas filesystem driver - external prototypes.
@@ -55,8 +55,9 @@
 /* vxfs_inode.c */
 extern struct kmem_cache_s	*vxfs_inode_cachep;
 extern void			vxfs_dumpi(struct vxfs_inode_info *, ino_t);
-extern struct inode *		vxfs_fake_inode(struct super_block *,
+extern struct inode *		vxfs_get_fake_inode(struct super_block *,
 					struct vxfs_inode_info *);
+extern void			vxfs_put_fake_inode(struct inode *);
 extern struct vxfs_inode_info *	vxfs_blkiget(struct super_block *, u_long, ino_t);
 extern struct vxfs_inode_info *	vxfs_stiget(struct super_block *, ino_t);
 extern void			vxfs_read_inode(struct inode *);
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_fshead.c linux/fs/freevxfs/vxfs_fshead.c
--- ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_fshead.c	Mon May 21 21:31:06 2001
+++ linux/fs/freevxfs/vxfs_fshead.c	Sun Sep  2 17:04:50 2001
@@ -27,7 +27,7 @@
  * SUCH DAMAGE.
  */
 
-#ident "$Id: vxfs_fshead.c,v 1.18 2001/04/25 18:11:23 hch Exp $"
+#ident "$Id: vxfs_fshead.c,v 1.19 2001/08/07 16:14:10 hch Exp hch $"
 
 /*
  * Veritas filesystem driver - fileset header routines.
@@ -124,7 +124,7 @@
 	vxfs_dumpi(vip, infp->vsi_fshino);
 #endif
 
-	if (!(infp->vsi_fship = vxfs_fake_inode(sbp, vip))) {
+	if (!(infp->vsi_fship = vxfs_get_fake_inode(sbp, vip))) {
 		printk(KERN_ERR "vxfs: unabled to get fsh inode\n");
 		return -EINVAL;
 	}
@@ -148,7 +148,7 @@
 #endif
 
 	tip = vxfs_blkiget(sbp, infp->vsi_iext, sfp->fsh_ilistino[0]);
-	if (!tip || ((infp->vsi_stilist = vxfs_fake_inode(sbp, tip)) == NULL)) {
+	if (!tip || ((infp->vsi_stilist = vxfs_get_fake_inode(sbp, tip)) == NULL)) {
 		printk(KERN_ERR "vxfs: unabled to get structual list inode\n");
 		return -EINVAL;
 	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_stilist))) {
@@ -158,7 +158,7 @@
 	}
 
 	tip = vxfs_stiget(sbp, pfp->fsh_ilistino[0]);
-	if (!tip || ((infp->vsi_ilist = vxfs_fake_inode(sbp, tip)) == NULL)) {
+	if (!tip || ((infp->vsi_ilist = vxfs_get_fake_inode(sbp, tip)) == NULL)) {
 		printk(KERN_ERR "vxfs: unabled to get inode list inode\n");
 		return -EINVAL;
 	} else if (!VXFS_ISILT(VXFS_INO(infp->vsi_ilist))) {
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_inode.c linux/fs/freevxfs/vxfs_inode.c
--- ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_inode.c	Thu Jun 28 23:44:10 2001
+++ linux/fs/freevxfs/vxfs_inode.c	Sun Sep  2 17:04:50 2001
@@ -27,7 +27,7 @@
  * SUCH DAMAGE.
  */
 
-#ident "$Id: vxfs_inode.c,v 1.36 2001/05/26 22:28:02 hch Exp hch $"
+#ident "$Id: vxfs_inode.c,v 1.37 2001/08/07 16:13:30 hch Exp hch $"
 
 /*
  * Veritas filesystem driver - inode routines.
@@ -47,6 +47,7 @@
 extern struct inode_operations vxfs_immed_symlink_iops;
 
 static struct file_operations vxfs_file_operations = {
+	.llseek =		generic_file_llseek,
 	.read =			generic_file_read,
 	.mmap =			generic_file_mmap,
 };
@@ -93,7 +94,7 @@
  * NOTE:
  *  While __vxfs_iget uses the pagecache vxfs_blkiget uses the
  *  buffercache.  This function should not be used outside the
- *  read_super() method, othwerwise the data may be incoherent.
+ *  read_super() method, otherwise the data may be incoherent.
  */
 struct vxfs_inode_info *
 vxfs_blkiget(struct super_block *sbp, u_long extent, ino_t ino)
@@ -251,7 +252,7 @@
 }
 
 /**
- * vxfs_fake_inode - get fake inode structure
+ * vxfs_get_fake_inode - get fake inode structure
  * @sbp:		filesystem superblock
  * @vip:		fspriv inode
  *
@@ -261,7 +262,7 @@
  *  Returns the filled VFS inode.
  */
 struct inode *
-vxfs_fake_inode(struct super_block *sbp, struct vxfs_inode_info *vip)
+vxfs_get_fake_inode(struct super_block *sbp, struct vxfs_inode_info *vip)
 {
 	struct inode			*ip = NULL;
 
@@ -273,6 +274,19 @@
 }
 
 /**
+ * vxfs_put_fake_inode - free faked inode
+ * *ip:			VFS inode
+ *
+ * Description:
+ *  vxfs_put_fake_inode frees all data asssociated with @ip.
+ */
+void
+vxfs_put_fake_inode(struct inode *ip)
+{
+	iput(ip);
+}
+
+/**
  * vxfs_read_inode - fill in inode information
  * @ip:		inode pointer to fill
  *
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_olt.c linux/fs/freevxfs/vxfs_olt.c
--- ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_olt.c	Mon May 21 21:31:06 2001
+++ linux/fs/freevxfs/vxfs_olt.c	Sun Sep  2 17:04:50 2001
@@ -27,7 +27,7 @@
  * SUCH DAMAGE.
  */
 
-#ident "$Id: vxfs_olt.c,v 1.8 2001/04/25 18:11:23 hch Exp hch $"
+#ident "$Id: vxfs_olt.c,v 1.9 2001/08/07 16:14:45 hch Exp hch $"
 
 /* 
  * Veritas filesystem driver - object location table support.
@@ -56,11 +56,11 @@
 }
 
 static __inline__ u_long
-vxfs_oblock(daddr_t oblock, u_long bsize)
+vxfs_oblock(struct super_block *sbp, daddr_t block, u_long bsize)
 {
-	if ((oblock * BLOCK_SIZE) % bsize)
+	if (sbp->s_blocksize % bsize)
 		BUG();
-	return ((oblock * BLOCK_SIZE) / bsize);
+	return (block * (sbp->s_blocksize / bsize));
 }
 
 
@@ -85,7 +85,8 @@
 	char			*oaddr, *eaddr;
 
 
-	bp = bread(sbp->s_dev, vxfs_oblock(infp->vsi_oltext, bsize), bsize);
+	bp = bread(sbp->s_dev,
+			vxfs_oblock(sbp, infp->vsi_oltext, bsize), bsize);
 	if (!bp || !bp->b_data)
 		goto fail;
 
diff -uNr -Xdontdiff ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_super.c linux/fs/freevxfs/vxfs_super.c
--- ../master/linux-2.4.10-pre3/fs/freevxfs/vxfs_super.c	Thu Jun 28 02:10:55 2001
+++ linux/fs/freevxfs/vxfs_super.c	Sun Sep  2 17:04:50 2001
@@ -27,7 +27,7 @@
  * SUCH DAMAGE.
  */
 
-#ident "$Id: vxfs_super.c,v 1.25 2001/05/25 18:25:55 hch Exp hch $"
+#ident "$Id: vxfs_super.c,v 1.26 2001/08/07 16:13:30 hch Exp hch $"
 
 /*
  * Veritas filesystem driver - superblock related routines.
@@ -54,7 +54,6 @@
 static void		vxfs_put_super(struct super_block *);
 static int		vxfs_statfs(struct super_block *, struct statfs *);
 
-
 static struct super_operations vxfs_super_ops = {
 	.read_inode =		vxfs_read_inode,
 	.put_inode =		vxfs_put_inode,
@@ -83,14 +82,15 @@
  *   vxfs_put_super frees all resources allocated for @sbp
  *   after the last instance of the filesystem is unmounted.
  */
+
 static void
 vxfs_put_super(struct super_block *sbp)
 {
 	struct vxfs_sb_info	*infp = VXFS_SBI(sbp);
 
-	vxfs_put_inode(infp->vsi_fship);
-	vxfs_put_inode(infp->vsi_ilist);
-	vxfs_put_inode(infp->vsi_stilist);
+	vxfs_put_fake_inode(infp->vsi_fship);
+	vxfs_put_fake_inode(infp->vsi_ilist);
+	vxfs_put_fake_inode(infp->vsi_stilist);
 
 	brelse(infp->vsi_bp);
 	kfree(infp);
@@ -135,7 +135,7 @@
  * vxfs_read_super - read superblock into memory and initalize filesystem
  * @sbp:		VFS superblock (to fill)
  * @dp:			fs private mount data
- * @silent:		???
+ * @silent:		do not complain loudly when sth is wrong
  *
  * Description:
  *   We are called on the first mount of a filesystem to read the
@@ -167,18 +167,23 @@
 
 	bp = bread(dev, 1, bsize);
 	if (!bp) {
-		printk(KERN_WARNING "vxfs: unable to read disk superblock\n");
+		if (!silent) {
+			printk(KERN_WARNING
+				"vxfs: unable to read disk superblock\n");
+		}
 		goto out;
 	}
 
 	rsbp = (struct vxfs_sb *)bp->b_data;
 	if (rsbp->vs_magic != VXFS_SUPER_MAGIC) {
-		printk(KERN_NOTICE "vxfs: WRONG superblock magic\n");
+		if (!silent)
+			printk(KERN_NOTICE "vxfs: WRONG superblock magic\n");
 		goto out;
 	}
 
-	if (rsbp->vs_version < 2 || rsbp->vs_version > 4) {
-		printk(KERN_NOTICE "vxfs: unsupported VxFS version (%d)\n", rsbp->vs_version);
+	if ((rsbp->vs_version < 2 || rsbp->vs_version > 4) && !silent) {
+		printk(KERN_NOTICE "vxfs: unsupported VxFS version (%d)\n",
+		       rsbp->vs_version);
 		goto out;
 	}
 
@@ -188,6 +193,7 @@
 #endif
 
 	sbp->s_magic = rsbp->vs_magic;
+	sbp->s_blocksize = rsbp->vs_bsize;
 	sbp->u.generic_sbp = (void *)infp;
 
 	infp->vsi_raw = rsbp;
@@ -195,7 +201,6 @@
 	infp->vsi_oltext = rsbp->vs_oltext[0];
 	infp->vsi_oltsize = rsbp->vs_oltsize;
 	
-	sbp->s_blocksize = rsbp->vs_bsize;
 
 	switch (rsbp->vs_bsize) {
 	case 1024:
@@ -208,8 +213,11 @@
 		sbp->s_blocksize_bits = 12;
 		break;
 	default:
-		printk(KERN_WARNING "vxfs: unsupported blocksise: %d\n",
+		if (!silent) {
+			printk(KERN_WARNING
+				"vxfs: unsupported blocksise: %d\n",
 				rsbp->vs_bsize);
+		}
 		goto out;
 	}
 
@@ -220,20 +228,28 @@
 
 	if (vxfs_read_fshead(sbp)) {
 		printk(KERN_WARNING "vxfs: unable to read fshead\n");
-		return NULL;
+		goto out;
 	}
 
 	sbp->s_op = &vxfs_super_ops;
-	if ((sbp->s_root = d_alloc_root(iget(sbp, VXFS_ROOT_INO))))
-		return (sbp);
+	sbp->s_root = d_alloc_root(iget(sbp, VXFS_ROOT_INO));
+	if (!sbp->s_root) {
+		printk(KERN_WARNING "vxfs: unable to get root dentry.\n");
+		goto out_free_ilist;
+	}
+
+	return (sbp);
 	
-	printk(KERN_WARNING "vxfs: unable to get root dentry.\n");
+out_free_ilist:
+	vxfs_put_fake_inode(infp->vsi_fship);
+	vxfs_put_fake_inode(infp->vsi_ilist);
+	vxfs_put_fake_inode(infp->vsi_stilist);
 out:
+	brelse(bp);
 	kfree(infp);
 	return NULL;
 }
 
-
 /*
  * The usual module blurb.
  */
@@ -246,7 +262,7 @@
 			sizeof(struct vxfs_inode_info), 0, 0, NULL, NULL);
 	if (vxfs_inode_cachep)
 		return (register_filesystem(&vxfs_fs_type));
-	return 0;
+	return -ENOMEM;
 }
 
 static void __exit
