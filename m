Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbULAXcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbULAXcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbULAXcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:32:33 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:49747 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261490AbULAXcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:32:04 -0500
Date: Wed, 1 Dec 2004 18:32:03 -0500
From: Jeffrey Mahoney <jeffm@suse.com>
To: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>
Cc: mason@suse.com
Subject: Re: 2.6.10-rc2-mm4
Message-ID: <20041201233203.GA22773@locomotive.unixthugs.org>
References: <20041130095045.090de5ea.akpm@osdl.org> <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil> <20041130112903.C2357@build.pdx.osdl.net> <20041130194328.GA28126@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20041130194328.GA28126@infradead.org>
X-Operating-System: Linux 2.6.5-7.111-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2004 at 07:43:28PM +0000, Christoph Hellwig wrote:
> On Tue, Nov 30, 2004 at 11:29:03AM -0800, Chris Wright wrote:
> > My concerns are that the check has to be duplicated in any module,
> > and that thus far we've tried to keep out fs -> module communication,
> > letting vfs do it.  This could at least be fs -> vfs communication,
> > and then either vfs or security framework could check flags and never
> > call into module on fs private objects.
>=20
> (1) an inode beeing private could have much more uses even outside LSM
> (2) it's an awfull lot of code where having a flag is really little code
> (3) there 's lots of room in the inode flags
>=20
> I can't find anything that speaks for the messy current implementation

I took some more time to find a more optimal solution. Since ReiserFS is
currently the only filesystem that cares about this, it's far easier to keep
the whole mess internal to ReiserFS. The issue isn't about the treating of
"private" files in reiserfs, but rather just to avoid the looping of xattr
calls that selinux would create.

Here's a new patch that replaces the ones being debated.

Since I'm not that familiar with the inner workings of selinux, might someo=
ne
more familiar verify that the behavior won't break anything? I've done some
preliminary testing (creating a filesystem, creating a directory tree,
verifying that the appropriate security attributes were created)

-Jeff

---------------------------------------------------------------------------=
--

Since selinux will call xattr operations on any file accessed, it will atte=
mpt
to call into the xattr subsystem while accessing the xattr files. This caus=
es
a locking loop which will lock the filesystem.

As part of the reiserfs xattr subsystem initialization process, this patch
copies the existing inode_operations structs and NULLs out the xattr
operations.

When selinux tries to access an internal file, it will see the ->{get,set}x=
attr
operation is NULL and assign a default SID rather than calling into the
filesystem again.

reiserfs_mark_inode_private is responsible for the assignment. This happens
as part of reiserfs_new_inode, as part of reiserfs_inherit_default_acl or
explicitly. As such the assignments of the inode_operations for various typ=
es
have been moved into reiserfs_new_inode, rather than the create,mknod,mkdir=
,etc
functions. The effective assignment order is unchanged.

Signed-off-by: Jeffrey Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/inode.c linux-2.6.9.noxattr/fs=
/reiserfs/inode.c
--- linux-2.6.9/fs/reiserfs/inode.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.noxattr/fs/reiserfs/inode.c	2004-12-01 17:31:51.000000000 -=
0500
@@ -1792,6 +1792,21 @@ int reiserfs_new_inode (struct reiserfs_
 	goto out_inserted_sd;
     }
=20
+    if (S_ISREG (inode->i_mode)) {
+	inode->i_op =3D &reiserfs_file_inode_operations;
+	inode->i_fop =3D &reiserfs_file_operations;
+	inode->i_mapping->a_ops =3D &reiserfs_address_space_operations ;
+    } else if (S_ISDIR (inode->i_mode)) {
+	inode->i_op =3D &reiserfs_dir_inode_operations;
+	inode->i_fop =3D &reiserfs_dir_operations;
+    } else if (S_ISLNK (inode->i_mode)) {
+	inode->i_op =3D &reiserfs_symlink_inode_operations;
+	inode->i_mapping->a_ops =3D &reiserfs_address_space_operations;
+    } else {
+	inode->i_blocks =3D 0;
+	inode->i_op =3D &reiserfs_special_inode_operations;
+    }
+
     /* XXX CHECK THIS */
     if (reiserfs_posixacl (inode->i_sb)) {
         retval =3D reiserfs_inherit_default_acl (dir, dentry, inode);
@@ -1801,9 +1816,13 @@ int reiserfs_new_inode (struct reiserfs_
             journal_end(th, th->t_super, th->t_blocks_allocated);
             goto out_inserted_sd;
         }
-    } else if (inode->i_sb->s_flags & MS_POSIXACL) {
-	reiserfs_warning (inode->i_sb, "ACLs aren't enabled in the fs, "
-			  "but vfs thinks they are!");
+    } else {
+        if (inode->i_sb->s_flags & MS_POSIXACL) {
+	    reiserfs_warning (inode->i_sb, "ACLs aren't enabled in the fs, "
+			      "but vfs thinks they are!");
+        }
+	if (is_reiserfs_priv_object (dir))
+	    reiserfs_mark_inode_private (inode);
     }
=20
     insert_inode_hash (inode);
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/namei.c linux-2.6.9.noxattr/fs=
/reiserfs/namei.c
--- linux-2.6.9/fs/reiserfs/namei.c	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.9.noxattr/fs/reiserfs/namei.c	2004-12-01 17:52:32.000000000 -=
0500
@@ -352,7 +352,7 @@ static struct dentry * reiserfs_lookup (
=20
 	/* Propogate the priv_object flag so we know we're in the priv tree */
 	if (is_reiserfs_priv_object (dir))
-	    REISERFS_I(inode)->i_flags |=3D i_priv_object;
+	    reiserfs_mark_inode_private (inode);
     }
     reiserfs_write_unlock(dir->i_sb);
     if ( retval =3D=3D IO_ERROR ) {
@@ -616,10 +616,6 @@ static int reiserfs_create (struct inode
         goto out_failed;
     }
 =09
-    inode->i_op =3D &reiserfs_file_inode_operations;
-    inode->i_fop =3D &reiserfs_file_operations;
-    inode->i_mapping->a_ops =3D &reiserfs_address_space_operations ;
-
     retval =3D reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->=
d_name.len,=20
 				inode, 1/*visible*/);
     if (retval) {
@@ -677,7 +673,6 @@ static int reiserfs_mknod (struct inode=20
         goto out_failed;
     }
=20
-    inode->i_op =3D &reiserfs_special_inode_operations;
     init_special_inode(inode, inode->i_mode, rdev) ;
=20
     //FIXME: needed for block and char devices only
@@ -751,9 +746,6 @@ static int reiserfs_mkdir (struct inode=20
     reiserfs_update_inode_transaction(inode) ;
     reiserfs_update_inode_transaction(dir) ;
=20
-    inode->i_op =3D &reiserfs_dir_inode_operations;
-    inode->i_fop =3D &reiserfs_dir_operations;
-
     // note, _this_ add_entry will not update dir's stat data
     retval =3D reiserfs_add_entry (&th, dir, dentry->d_name.name, dentry->=
d_name.len,=20
 				inode, 1/*visible*/);
@@ -1001,9 +993,6 @@ static int reiserfs_symlink (struct inod
     reiserfs_update_inode_transaction(inode) ;
     reiserfs_update_inode_transaction(parent_dir) ;
=20
-    inode->i_op =3D &reiserfs_symlink_inode_operations;
-    inode->i_mapping->a_ops =3D &reiserfs_address_space_operations;
-
     // must be sure this inode is written with this transaction
     //
     //reiserfs_update_sd (&th, inode, READ_BLOCKS);
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr_acl.c linux-2.6.9.noxatt=
r/fs/reiserfs/xattr_acl.c
--- linux-2.6.9/fs/reiserfs/xattr_acl.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.noxattr/fs/reiserfs/xattr_acl.c	2004-12-01 17:03:55.0000000=
00 -0500
@@ -337,7 +337,7 @@ reiserfs_inherit_default_acl (struct ino
      * would be useless since permissions are ignored, and a pain because
      * it introduces locking cycles */
     if (is_reiserfs_priv_object (dir)) {
-        REISERFS_I(inode)->i_flags |=3D i_priv_object;
+        reiserfs_mark_inode_private (inode);
         goto apply_umask;
     }
=20
diff -ruNpX dontdiff linux-2.6.9/fs/reiserfs/xattr.c linux-2.6.9.noxattr/fs=
/reiserfs/xattr.c
--- linux-2.6.9/fs/reiserfs/xattr.c	2004-11-19 14:40:53.000000000 -0500
+++ linux-2.6.9.noxattr/fs/reiserfs/xattr.c	2004-12-01 17:11:35.000000000 -=
0500
@@ -181,8 +181,6 @@ open_xa_dir (const struct inode *inode,=20
             dput (xadir);
             return ERR_PTR (-ENODATA);
         }
-        /* Newly created object.. Need to mark it private */
-        REISERFS_I(xadir->d_inode)->i_flags |=3D i_priv_object;
     }
=20
     dput (xaroot);
@@ -230,8 +228,6 @@ get_xa_file_dentry (const struct inode *
             dput (xafile);
             goto out;
         }
-        /* Newly created object.. Need to mark it private */
-        REISERFS_I(xafile->d_inode)->i_flags |=3D i_priv_object;
     }
=20
 out:
@@ -1261,6 +1257,32 @@ static struct dentry_operations xattr_lo
     .d_compare =3D xattr_lookup_poison,
 };
=20
+struct inode_operations reiserfs_priv_file_inode_operations;
+struct inode_operations reiserfs_priv_dir_inode_operations;
+struct inode_operations reiserfs_priv_symlink_inode_operations;
+struct inode_operations reiserfs_priv_special_inode_operations;
+
+#define __init_priv_operation(op) 					\
+do {									\
+	memcpy (&reiserfs_priv_##op##_inode_operations,			\
+		&reiserfs_##op##_inode_operations,			\
+                sizeof (struct inode_operations));			\
+        reiserfs_priv_##op##_inode_operations.getxattr =3D NULL;		\
+        reiserfs_priv_##op##_inode_operations.setxattr =3D NULL;		\
+        reiserfs_priv_##op##_inode_operations.listxattr =3D NULL;		\
+        reiserfs_priv_##op##_inode_operations.removexattr =3D NULL;	\
+} while (0)
+
+static void
+init_priv_operations (void)
+{
+    __init_priv_operation(file);
+    __init_priv_operation(dir);
+
+    /* Technically these never get used, but no harm done */
+    __init_priv_operation(symlink);
+    __init_priv_operation(special);
+}
=20
 /* We need to take a copy of the mount flags since things like
  * MS_RDONLY don't get set until *after* we're called.
@@ -1315,8 +1337,9 @@ reiserfs_xattr_init (struct super_block=20
         err =3D PTR_ERR (dentry);
=20
       if (!err && dentry) {
+          init_priv_operations();
           s->s_root->d_op =3D &xattr_lookup_poison_ops;
-          REISERFS_I(dentry->d_inode)->i_flags |=3D i_priv_object;
+          reiserfs_mark_inode_private (dentry->d_inode);
           REISERFS_SB(s)->priv_root =3D dentry;
       } else if (!(mount_flags & MS_RDONLY)) { /* xattrs are unavailable */
           /* If we're read-only it just means that the dir hasn't been
diff -ruNpX dontdiff linux-2.6.9/include/linux/reiserfs_xattr.h linux-2.6.9=
=2Enoxattr/include/linux/reiserfs_xattr.h
--- linux-2.6.9/include/linux/reiserfs_xattr.h	2004-08-14 01:38:11.00000000=
0 -0400
+++ linux-2.6.9.noxattr/include/linux/reiserfs_xattr.h	2004-12-01 16:37:06.=
000000000 -0500
@@ -103,9 +103,30 @@ reiserfs_read_unlock_xattr_i(struct inod
     up_read (&REISERFS_I(inode)->xattr_sem);
 }
=20
+extern struct inode_operations reiserfs_priv_file_inode_operations;
+extern struct inode_operations reiserfs_priv_dir_inode_operations;
+extern struct inode_operations reiserfs_priv_symlink_inode_operations;
+extern struct inode_operations reiserfs_priv_special_inode_operations;
+
+static inline void
+reiserfs_mark_inode_private(struct inode *inode)
+{
+    if (S_ISREG (inode->i_mode))
+        inode->i_op =3D &reiserfs_priv_file_inode_operations;
+    else if (S_ISDIR (inode->i_mode))
+        inode->i_op =3D &reiserfs_priv_dir_inode_operations;
+    else if (S_ISLNK (inode->i_mode))
+        inode->i_op =3D &reiserfs_priv_symlink_inode_operations;
+    else
+        inode->i_op =3D &reiserfs_priv_special_inode_operations;
+
+    REISERFS_I(inode)->i_flags |=3D i_priv_object;
+}
+
 #else
=20
 #define is_reiserfs_priv_object(inode) 0
+#define reiserfs_mark_inode_private(inode)
 #define reiserfs_getxattr NULL
 #define reiserfs_setxattr NULL
 #define reiserfs_listxattr NULL
--=20
Jeff Mahoney
SuSE Labs

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBrlRyLPWxlyuTD7IRAqBBAJ9mJHNMWRYqHXUOnss0SNaPMYZxCACfbPEq
B8oyqiQbGwFBkniZlIeRvI8=
=D/xs
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
