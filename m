Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVC1UGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVC1UGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVC1UGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:06:43 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:23317 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262038AbVC1UGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:06:18 -0500
Date: Mon, 28 Mar 2005 15:06:17 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] vfs: namei operations should pass nameidata when available
Message-ID: <20050328200617.GA13280@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.111.19-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch replaces calls to lookup_hash with calls to __lookup_hash at the
vfs level where complete paths (struct nameidata) are available.=20

AF_UNIX sockets also open a complete path terminated with a lookup_hash. Si=
nce
it's conceivable for modules to do the same, I've exported __lookup_hash and
made lookup_hash a static inline.

The reason for the change is that I recently reworked subfs to eliminate
rather questionable behavior, such as walking the vfsmount tree lockless and
then caching a pointer. Since the mountpoint is still required to mount the
sub-filesystem, I chose to use nameidata->nd_mnt at ->open or ->lookup. This
led to quick oopsen when any create/remove/rename operation was performed w=
ith
the sub-filesystem umounted. This patch supplies the needed data.

This change shouldn't have any effect on the call paths, since the lookup p=
ath
for each filesystem is already passed valid nameidata from open_namei in the
existing code.=20

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

Index: linux-2.6.11/fs/namei.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.11.orig/fs/namei.c
+++ linux-2.6.11/fs/namei.c
@@ -992,7 +992,7 @@ int fastcall path_lookup(const char *nam
  * needs parent already locked. Doesn't follow mounts.
  * SMP-safe.
  */
-static struct dentry * __lookup_hash(struct qstr *name, struct dentry * ba=
se, struct nameidata *nd)
+struct dentry * __lookup_hash(struct qstr *name, struct dentry * base, str=
uct nameidata *nd)
 {
 	struct dentry * dentry;
 	struct inode *inode;
@@ -1031,11 +1031,6 @@ out:
 	return dentry;
 }
=20
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
-{
-	return __lookup_hash(name, base, NULL);
-}
-
 /* SMP-safe */
 struct dentry * lookup_one_len(const char * name, struct dentry * base, in=
t len)
 {
@@ -1519,7 +1519,7 @@ struct dentry *lookup_create(struct name
 	if (nd->last_type !=3D LAST_NORM)
 		goto fail;
 	nd->flags &=3D ~LOOKUP_PARENT;
-	dentry =3D lookup_hash(&nd->last, nd->dentry);
+	dentry =3D __lookup_hash(&nd->last, nd->dentry, nd);
 	if (IS_ERR(dentry))
 		goto fail;
 	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
@@ -1760,7 +1755,7 @@ asmlinkage long sys_rmdir(const char __u
 			goto exit1;
 	}
 	down(&nd.dentry->d_inode->i_sem);
-	dentry =3D lookup_hash(&nd.last, nd.dentry);
+	dentry =3D __lookup_hash(&nd.last, nd.dentry, &nd);
 	error =3D PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		error =3D vfs_rmdir(nd.dentry->d_inode, dentry);
@@ -1829,7 +1824,7 @@ asmlinkage long sys_unlink(const char __
 	if (nd.last_type !=3D LAST_NORM)
 		goto exit1;
 	down(&nd.dentry->d_inode->i_sem);
-	dentry =3D lookup_hash(&nd.last, nd.dentry);
+	dentry =3D __lookup_hash(&nd.last, nd.dentry, &nd);
 	error =3D PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		/* Why not before? Because we want correct error value */
@@ -2178,7 +2173,7 @@ static inline int do_rename(const char *
=20
 	trap =3D lock_rename(new_dir, old_dir);
=20
-	old_dentry =3D lookup_hash(&oldnd.last, old_dir);
+	old_dentry =3D __lookup_hash(&oldnd.last, old_dir, &oldnd);
 	error =3D PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -2198,7 +2193,7 @@ static inline int do_rename(const char *
 	error =3D -EINVAL;
 	if (old_dentry =3D=3D trap)
 		goto exit4;
-	new_dentry =3D lookup_hash(&newnd.last, new_dir);
+	new_dentry =3D __lookup_hash(&newnd.last, new_dir, &oldnd);
 	error =3D PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
@@ -2391,7 +2386,7 @@ EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_hash);
+EXPORT_SYMBOL(__lookup_hash);
 EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);
Index: linux-2.6.11/include/linux/namei.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.11.orig/include/linux/namei.h
+++ linux-2.6.11/include/linux/namei.h
@@ -64,7 +64,11 @@ extern void path_release(struct nameidat
 extern void path_release_on_umount(struct nameidata *);
=20
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
-extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
+extern struct dentry * __lookup_hash(struct qstr *, struct dentry *, struc=
t nameidata *);
+static inline struct dentry * lookup_hash(struct qstr *name, struct dentry=
 *base)
+{
+	return __lookup_hash(name, base, NULL);
+}
=20
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
Index: linux-2.6.11/net/unix/af_unix.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.11.orig/net/unix/af_unix.c
+++ linux-2.6.11/net/unix/af_unix.c
@@ -776,7 +776,7 @@ static int unix_bind(struct socket *sock
 		/*
 		 * Do the final lookup.
 		 */
-		dentry =3D lookup_hash(&nd.last, nd.dentry);
+		dentry =3D __lookup_hash(&nd.last, nd.dentry, &nd);
 		err =3D PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_mknod_unlock;
--=20
Jeff Mahoney
SuSE Labs

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCSGO4LPWxlyuTD7IRAoWLAJ9o8C7eb8pt6F8ecYCjwE/3h6XdPgCgpKav
DAMc16WNwTndah1V6KVBra0=
=Jj0D
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
