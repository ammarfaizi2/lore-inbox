Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSGEFRf>; Fri, 5 Jul 2002 01:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSGEFRe>; Fri, 5 Jul 2002 01:17:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57014 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315417AbSGEFRd>;
	Fri, 5 Jul 2002 01:17:33 -0400
Date: Fri, 5 Jul 2002 01:20:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ex_dev switched to dev_t
Message-ID: <Pine.GSO.4.21.0207050117540.14718-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* svc_export ->ex_dev turned into dev_t.  It's a pure search
key and all places that set it actually do to_kdev_t(some_dev_t_expression).

diff -urN C24-0/fs/nfsd/export.c C24-current/fs/nfsd/export.c
--- C24-0/fs/nfsd/export.c	Thu Jun 20 13:37:05 2002
+++ C24-current/fs/nfsd/export.c	Sat Jun 29 23:27:42 2002
@@ -68,17 +68,17 @@
  * Find the client's export entry matching xdev/xino.
  */
 svc_export *
-exp_get(svc_client *clp, kdev_t dev, ino_t ino)
+exp_get(svc_client *clp, dev_t dev, ino_t ino)
 {
 	struct list_head *head, *p;
 	
 	if (!clp)
 		return NULL;
 
-	head = &clp->cl_export[EXPORT_HASH(kdev_t_to_nr(dev))];
+	head = &clp->cl_export[EXPORT_HASH(dev)];
 	list_for_each(p, head) {
 		svc_export *exp = list_entry(p, svc_export, ex_hash);
-		if (exp->ex_ino == ino && kdev_same(exp->ex_dev, dev))
+		if (exp->ex_ino == ino && exp->ex_dev ==  dev)
 			return exp;
 	}
 	return NULL;
@@ -250,7 +250,7 @@
 	struct nameidata nd;
 	struct inode	*inode = NULL;
 	int		err;
-	kdev_t		dev;
+	dev_t		dev;
 	ino_t		ino;
 
 	/* Consistency check */
@@ -276,7 +276,7 @@
 	if (err)
 		goto out_unlock;
 	inode = nd.dentry->d_inode;
-	dev = inode->i_dev;
+	dev = inode->i_sb->s_dev;
 	ino = inode->i_ino;
 	err = -EINVAL;
 
@@ -364,7 +364,7 @@
 	if (parent)
 		exp_change_parents(clp, parent, exp);
 
-	list_add(&exp->ex_hash, clp->cl_export + EXPORT_HASH(kdev_t_to_nr(dev)));
+	list_add(&exp->ex_hash, clp->cl_export + EXPORT_HASH(dev));
 	list_add_tail(&exp->ex_list, &clp->cl_list);
 
 	exp_fsid_hash(clp, exp);
@@ -398,7 +398,7 @@
 	dentry = unexp->ex_dentry;
 	mnt = unexp->ex_mnt;
 	inode = dentry->d_inode;
-	if (!kdev_same(unexp->ex_dev, inode->i_dev) || unexp->ex_ino != inode->i_ino)
+	if (unexp->ex_dev != inode->i_sb->s_dev || unexp->ex_ino != inode->i_ino)
 		printk(KERN_WARNING "nfsd: bad dentry in unexport!\n");
 	dput(dentry);
 	mntput(mnt);
@@ -440,8 +440,7 @@
 	err = -EINVAL;
 	clp = exp_getclientbyname(nxp->ex_client);
 	if (clp) {
-		kdev_t ex_dev = to_kdev_t(nxp->ex_dev);
-		svc_export *exp = exp_get(clp, ex_dev, nxp->ex_ino);
+		svc_export *exp = exp_get(clp, nxp->ex_dev, nxp->ex_ino);
 		if (exp) {
 			exp_do_unexport(exp);
 			err = 0;
diff -urN C24-0/fs/nfsd/nfsfh.c C24-current/fs/nfsd/nfsfh.c
--- C24-0/fs/nfsd/nfsfh.c	Sat May 25 01:41:04 2002
+++ C24-current/fs/nfsd/nfsfh.c	Sat Jun 29 23:26:49 2002
@@ -97,7 +97,7 @@
 	rqstp->rq_reffh = fh;
 
 	if (!fhp->fh_dentry) {
-		kdev_t xdev = NODEV;
+		dev_t xdev = 0;
 		ino_t xino = 0;
 		__u32 *datap=NULL;
 		__u32 tfh[3];		/* filehandle fragment for oldstyle filehandles */
@@ -122,7 +122,7 @@
 			case 0:
 				if ((data_left-=2)<0) goto out;
 				nfsdev = ntohl(*datap++);
-				xdev = mk_kdev(nfsdev>>16, nfsdev&0xFFFF);
+				xdev = MKDEV(nfsdev>>16, nfsdev&0xFFFF);
 				xino = *datap++;
 				break;
 			case 1:
@@ -136,7 +136,7 @@
 			if (fh->fh_size != NFS_FHSIZE)
 				goto out;
 			/* assume old filehandle format */
-			xdev = u32_to_kdev_t(fh->ofh_xdev);
+			xdev = u32_to_dev_t(fh->ofh_xdev);
 			xino = u32_to_ino_t(fh->ofh_xino);
 		}
 
@@ -308,7 +308,7 @@
 	__u32 *datap;
 
 	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %s/%s, ino=%ld)\n",
-		major(exp->ex_dev), minor(exp->ex_dev), (long) exp->ex_ino,
+		MAJOR(exp->ex_dev), MINOR(exp->ex_dev), (long) exp->ex_ino,
 		parent->d_name.name, dentry->d_name.name,
 		(inode ? inode->i_ino : 0));
 
@@ -329,7 +329,7 @@
 		memset(&fhp->fh_handle.fh_base, 0, NFS_FHSIZE);
 		fhp->fh_handle.fh_size = NFS_FHSIZE;
 		fhp->fh_handle.ofh_dcookie = 0xfeebbaca;
-		fhp->fh_handle.ofh_dev =  htonl((major(exp->ex_dev)<<16)| minor(exp->ex_dev));
+		fhp->fh_handle.ofh_dev =  htonl((MAJOR(exp->ex_dev)<<16)| MINOR(exp->ex_dev));
 		fhp->fh_handle.ofh_xdev = fhp->fh_handle.ofh_dev;
 		fhp->fh_handle.ofh_xino = ino_t_to_u32(exp->ex_ino);
 		fhp->fh_handle.ofh_dirino = ino_t_to_u32(parent_ino(dentry));
@@ -348,7 +348,7 @@
 		} else {
 			fhp->fh_handle.fh_fsid_type = 0;
 			/* fsid_type 0 == 2byte major, 2byte minor, 4byte inode */
-			*datap++ = htonl((major(exp->ex_dev)<<16)| minor(exp->ex_dev));
+			*datap++ = htonl((MAJOR(exp->ex_dev)<<16)| MINOR(exp->ex_dev));
 			*datap++ = ino_t_to_u32(exp->ex_ino);
 			fhp->fh_handle.fh_size = 3*4;
 		}
diff -urN C24-0/include/linux/nfsd/export.h C24-current/include/linux/nfsd/export.h
--- C24-0/include/linux/nfsd/export.h	Wed Mar 20 15:02:00 2002
+++ C24-current/include/linux/nfsd/export.h	Sat Jun 29 23:27:06 2002
@@ -70,7 +70,7 @@
 	int			ex_flags;
 	struct vfsmount *	ex_mnt;
 	struct dentry *		ex_dentry;
-	kdev_t			ex_dev;
+	dev_t			ex_dev;
 	ino_t			ex_ino;
 	uid_t			ex_anon_uid;
 	gid_t			ex_anon_gid;
@@ -94,7 +94,7 @@
 void			exp_readunlock(void);
 struct svc_client *	exp_getclient(struct sockaddr_in *sin);
 void			exp_putclient(struct svc_client *clp);
-struct svc_export *	exp_get(struct svc_client *clp, kdev_t dev, ino_t ino);
+struct svc_export *	exp_get(struct svc_client *clp, dev_t dev, ino_t ino);
 struct svc_export *	exp_get_fsid(struct svc_client *clp, int fsid);
 struct svc_export *	exp_get_by_name(struct svc_client *clp,
 					struct vfsmount *mnt,
diff -urN C24-0/include/linux/nfsd/nfsfh.h C24-current/include/linux/nfsd/nfsfh.h
--- C24-0/include/linux/nfsd/nfsfh.h	Sun Jan 20 10:21:14 2002
+++ C24-current/include/linux/nfsd/nfsfh.h	Sat Jun 29 23:22:42 2002
@@ -143,13 +143,13 @@
 	return udev;
 }
 
-static inline kdev_t u32_to_kdev_t(__u32 udev)
+static inline dev_t u32_to_dev_t(__u32 udev)
 {
 	unsigned int minor, major;
 
 	minor = (udev & 0xff) | ((udev >> 8) & 0xfff00);
 	major = ((udev >> 8) & 0xff) | ((udev >> 20) & 0xf00);
-	return mk_kdev(major, minor);
+	return MKDEV(major, minor);
 }
 
 static inline __u32 ino_t_to_u32(ino_t ino)

