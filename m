Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWIFXUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWIFXUx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWIFXUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:20:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59371 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030194AbWIFXUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:20:51 -0400
Date: Wed, 6 Sep 2006 18:20:45 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir
Message-ID: <20060906232045.GA9744@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060904225419.GA4367@us.ibm.com> <20060830211203.GA12953@us.ibm.com> <20060825221615.GA11613@us.ibm.com> <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> <27154.1156546746@warthog.cambridge.redhat.com> <10689.1157020231@warthog.cambridge.redhat.com> <8777.1157535885@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <8777.1157535885@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2006 at 10:44:45AM +0100, David Howells wrote:
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > +int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_ino=
de)
> > +{
> > +	if (ecryptfs_inode_to_private(inode) &&=20
>=20
> Is this part of the condition actually necessary?  Can you not
> guarantee that this will always be true?

This check is not needed, as far as I can tell. I think I am going to
go the conservative route and convert the check to a BUG_ON() for now.

> > +	ecryptfs_set_inode_lower(inode, igrab((struct inode *)lower_inode));
>=20
> igrab() might fail.  I would recommend doing it before calling
> iget5_unlocked() and drop the extraneous reference to lower_inode
> afterwards if the eCryptFS inode returned is already set up.
<snip>
> > +static void ecryptfs_read_inode(struct inode *inode) { }
>=20
> You shouldn't need that any more.  Just leave the read_inode op
> pointer unset.  The NULL pointer exception handler will let you know
> if anyone tries to access it (which they shouldn't - only *you*
> should call iget*() on your own inodes).
>=20
> Looks good otherwise.  Just the igrab() thing is a real problem.

How's this?

---

Modify inode number generation to account for differences in the inode
number data type sizes in lower filesystems.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    3 +++
 fs/ecryptfs/inode.c           |   16 ++++++++++++++++
 fs/ecryptfs/main.c            |   29 +++++++++++++----------------
 fs/ecryptfs/super.c           |   18 ++++++++++--------
 4 files changed, 42 insertions(+), 24 deletions(-)

f260d0b3dad0dadcb8a70b9f3e251a5aae1360f0
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 349ce2a..85660da 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -474,5 +474,8 @@ int ecryptfs_truncate(struct dentry *den
 int
 ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_t=
fm,
 			char *cipher_name, size_t key_size);
+int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode);
+int ecryptfs_inode_set(struct inode *inode, void *lower_inode);
+void ecryptfs_init_inode(struct inode *inode, struct inode *lower_inode);
=20
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d8659ff..96b05a6 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1024,6 +1024,22 @@ out:
 	return rc;
 }
=20
+int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode)
+{
+	BUG_ON(!ecryptfs_inode_to_private(inode));
+	if ((ecryptfs_inode_to_lower(inode)
+	     =3D=3D (struct inode *)candidate_lower_inode))
+		return 1;
+	else
+		return 0;
+}
+
+int ecryptfs_inode_set(struct inode *inode, void *lower_inode)
+{
+	ecryptfs_init_inode(inode, (struct inode *)lower_inode);
+	return 0;
+}
+
 struct inode_operations ecryptfs_symlink_iops =3D {
 	.readlink =3D ecryptfs_readlink,
 	.follow_link =3D ecryptfs_follow_link,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index f7ea912..ecf9faf 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -68,39 +68,36 @@ void __ecryptfs_printk(const char *fmt,=20
  *
  * Interposes upper and lower dentries.
  *
- * This function will allocate an ecryptfs_inode through the call to
- * iget(sb, lower_inode->i_ino).
- *
  * Returns zero on success; non-zero otherwise
  */
 int ecryptfs_interpose(struct dentry *lower_dentry, struct dentry *dentry,
 		       struct super_block *sb, int flag)
 {
 	struct inode *lower_inode;
-	int rc =3D 0;
 	struct inode *inode;
+	int rc =3D 0;
=20
 	lower_inode =3D lower_dentry->d_inode;
 	if (lower_inode->i_sb !=3D ecryptfs_superblock_to_lower(sb)) {
 		rc =3D -EXDEV;
 		goto out;
 	}
-	inode =3D iget(sb, lower_inode->i_ino);
-	if (!inode) {
-		rc =3D -EACCES;
+	if (!igrab(lower_inode)) {
+		rc =3D -ESTALE;
 		goto out;
 	}
-	/* This check is required here because if we failed to allocated the
-	 * required space for an inode_info_cache struct, then the only way
-	 * we know we failed, is by the pointer being NULL */
-	if (!ecryptfs_inode_to_private(inode)) {
-		ecryptfs_printk(KERN_ERR, "Out of memory. Failure to "
-				"allocate memory in ecryptfs_read_inode.\n");
-		rc =3D -ENOMEM;
+	inode =3D iget5_locked(sb, (unsigned long)lower_inode,
+			     ecryptfs_inode_test, ecryptfs_inode_set,
+			     lower_inode);
+	if (!inode) {
+		rc =3D -EACCES;
+		iput(lower_inode);
 		goto out;
 	}
-	if (!ecryptfs_inode_to_lower(inode))
-		ecryptfs_set_inode_lower(inode, igrab(lower_inode));
+	if (inode->i_state & I_NEW)
+		unlock_new_inode(inode);
+	else
+		iput(lower_inode);
 	if (S_ISLNK(lower_inode->i_mode))
 		inode->i_op =3D &ecryptfs_symlink_iops;
 	else if (S_ISDIR(lower_inode->i_mode))
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index f4f06ea..9edadac 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -78,19 +78,22 @@ static void ecryptfs_destroy_inode(struc
 }
=20
 /**
- * ecryptfs_read_inode
+ * ecryptfs_init_inode
  * @inode: The ecryptfs inode
  *
  * Set up the ecryptfs inode.
  */
-static void ecryptfs_read_inode(struct inode *inode)
+void ecryptfs_init_inode(struct inode *inode, struct inode *lower_inode)
 {
-	/* This is where we setup the self-reference in the vfs_inode's
-	 * i_private. That way we don't have to walk the list again. */
+	/* This is where we setup the self-reference in the
+	 * vfs_inode's i_private. That way we don't have to walk the
+	 * list again. */
 	ecryptfs_set_inode_private(inode,
-				   list_entry(inode, struct ecryptfs_inode_info,
-					      vfs_inode));
-	ecryptfs_set_inode_lower(inode, NULL);
+				   container_of(inode,
+						struct ecryptfs_inode_info,
+						vfs_inode));
+	ecryptfs_set_inode_lower(inode, lower_inode);
+	inode->i_ino =3D lower_inode->i_ino;
 	inode->i_version++;
 	inode->i_op =3D &ecryptfs_main_iops;
 	inode->i_fop =3D &ecryptfs_main_fops;
@@ -192,7 +195,6 @@ out:
 struct super_operations ecryptfs_sops =3D {
 	.alloc_inode =3D ecryptfs_alloc_inode,
 	.destroy_inode =3D ecryptfs_destroy_inode,
-	.read_inode =3D ecryptfs_read_inode,
 	.drop_inode =3D generic_delete_inode,
 	.put_super =3D ecryptfs_put_super,
 	.statfs =3D ecryptfs_statfs,
--=20
1.3.3


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUBRP9XzdtAhTFtyodpAQLIYggAsG0k+4hFxaveO1OCu0//jGf5M6hfF3Wx
CXpMO45S6jLqZZWJAMDClE7I9dXThlYxokTZQJ5dLkcAUFsO7m8zGTMeDeB4mcFK
DDdf/WBeqsRH0f8FVCmsJEl2gJ4PozQ8Lw5gJDjB1JcH9J/yiOY23sv0Umy0Argu
8JTxX/VXU/LwdH+/lXgSQQ3PJG42U2hTr59SJdN95Jz9NGX2wD+YslpDRMX+gAvo
iSuMJsPNQib4mjrSRCHWAzTor/ZBNzA0KO0I+T1wpcH5PItBW36qn7fYg4aWXbgo
PAw/AsqDfR5E4c8cl9Uh4dmWZlI7RmQx/3Wb9DIi0TQ4nY0+E+HuHw==
=+iAP
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
