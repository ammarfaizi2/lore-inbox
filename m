Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUKSKRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUKSKRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUKSKRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:17:18 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:14245 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261305AbUKSKQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:16:05 -0500
Date: Fri, 19 Nov 2004 03:16:00 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: tridge@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
Message-ID: <20041119101600.GM1974@schnapps.adilger.int>
Mail-Followup-To: tridge@samba.org, linux-kernel@vger.kernel.org
References: <1098383538.987.359.camel@new.localdomain> <16797.41728.984065.479474@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline
In-Reply-To: <16797.41728.984065.479474@samba.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cVp8NMj01v+Em8Se
Content-Type: multipart/mixed; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 19, 2004  18:38 +1100, tridge@samba.org wrote:
> I started some simple benchmarking today using the BENCH-NBENCH
> smbtorture benchmark, with 10 simulated clients and loopback
> networking on a dual Xeon server with 2G ram and a 50G scsi partition.
> I used a 2.6.10-rc2 kernel. This benchmark only involves a
> user.DosAttrib xattr of size 44 on every file (that will be the most
> common situation in production use).
>=20
> ext3                67 MB/sec
> ext3+xattr          58 MB/sec
>=20
> xfs                 62 MB/sec
> xfs+xattr           40 MB/sec
> xfs+2Kinode         63 MB/sec
> xfs+xattr+2Kinode   58 MB/sec

Also, we (CFS) have developed patches for ext3 + e2fsprogs to support
"fast" EAs stored in larger inodes on disk, and this can improve
performance dramatically in the case where you are accessing a large
number of inodes with EAs just.  Otherwise you are storing the
EAs in an external block which requires another seek + read to access,
while the large inode EA is already in cache after you read the inode.
Also, the fact that you have to read a 4kB EA block into memory for
(in our case) a relatively small amount of data really kills the cache.

You can select inode sizes from 128..4096 in power-of-two sizes.


This patch also provides the infrastructure on disk for storing e.g.
nsecond and create timestamps in the ext3 large inodes, but the actual
implementation to save/load these isn't there yet.  If that were
available, would you use it instead of explicitly storing the NTTIME in
an EA?  I believe the 2.6 stat interface will support nsecond timestamps,
but I don't think there is any API to get the create time to userspace
though we could hook this up to a pseudo EA.  The benefit of storing
these common fields in the inode instead of EAs is less overhead.

> To get the ext2/ext3 results I needed to add "return NULL;" at the
> start of ext3_xattr_cache_find() to avoid a bug in the xattr sharing
> code that causes a oops (I've reported the oops separately).

I would just configure out the xattr sharing code entirely since it will
likely do nothing but increase overhead if any of the EAs on an inode
are unique (this is the most common case, except for POSIX-ACL-only setups).

I've attached this patch here.  I believe all of the ext3 developers
agree it should go into the kernel, just nobody has made a push to do
so.  If this helps your performance (or even if not ;-) we'd be happy
to get it into the kernel proper.  The e2fsprogs support for same can be
found at http://cvs.lustre.org:5000/ though it is mixed in with a lot of
other changesets you probably don't care about.  Relevant ones are
1.1347.1.2 (Apr 23, 2004) and 1.1421 (Sept 03, 2004).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3-ea-in-inode-2.6-suse.patch"
Content-Transfer-Encoding: quoted-printable

%patch
Index: linux-2.6.0/fs/ext3/ialloc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.0.orig/fs/ext3/ialloc.c	2004-01-14 18:54:11.000000000 +0300
+++ linux-2.6.0/fs/ext3/ialloc.c	2004-01-14 18:54:12.000000000 +0300
@@ -627,6 +627,11 @@
 	inode->i_generation =3D EXT3_SB(sb)->s_next_generation++;
=20
 	ei->i_state =3D EXT3_STATE_NEW;
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE) {
+		ei->i_extra_isize =3D sizeof(__u16)	/* i_extra_isize */
+				+ sizeof(__u16);	/* i_pad1 */
+	} else
+		ei->i_extra_isize =3D 0;
=20
 	ret =3D inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
Index: linux-2.6.0/fs/ext3/inode.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.0.orig/fs/ext3/inode.c	2004-01-14 18:54:12.000000000 +0300
+++ linux-2.6.0/fs/ext3/inode.c	2004-01-14 19:09:46.000000000 +0300
@@ -2339,7 +2339,7 @@
  * trying to determine the inode's location on-disk and no read need be
  * performed.
  */
-static int ext3_get_inode_loc(struct inode *inode,
+int ext3_get_inode_loc(struct inode *inode,
 				struct ext3_iloc *iloc, int in_mem)
 {
 	unsigned long block;
@@ -2547,6 +2547,11 @@
 		ei->i_data[block] =3D raw_inode->i_block[block];
 	INIT_LIST_HEAD(&ei->i_orphan);
=20
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
+		ei->i_extra_isize =3D le16_to_cpu(raw_inode->i_extra_isize);
+	else
+		ei->i_extra_isize =3D 0;
+
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op =3D &ext3_file_inode_operations;
 		inode->i_fop =3D &ext3_file_operations;
@@ -2682,6 +2687,9 @@
 	} else for (block =3D 0; block < EXT3_N_BLOCKS; block++)
 		raw_inode->i_block[block] =3D ei->i_data[block];
=20
+	if (EXT3_INODE_SIZE(inode->i_sb) > EXT3_GOOD_OLD_INODE_SIZE)
+		raw_inode->i_extra_isize =3D cpu_to_le16(ei->i_extra_isize);
+
 	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 	rc =3D ext3_journal_dirty_metadata(handle, bh);
 	if (!err)
Index: linux-2.6.0/fs/ext3/xattr.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.0.orig/fs/ext3/xattr.c	2003-12-30 08:33:13.000000000 +0300
+++ linux-2.6.0/fs/ext3/xattr.c	2004-01-14 18:54:12.000000000 +0300
@@ -246,17 +246,12 @@
 }
=20
 /*
- * ext3_xattr_get()
- *
- * Copy an extended attribute into the buffer
- * provided, or compute the buffer size required.
- * Buffer is NULL to compute the size of the buffer required.
+ * ext3_xattr_block_get()
  *
- * Returns a negative error number on failure, or the number of bytes
- * used / required on success.
+ * routine looks for attribute in EA block and returns it's value and size
  */
 int
-ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+ext3_xattr_block_get(struct inode *inode, int name_index, const char *name,
 	       void *buffer, size_t buffer_size)
 {
 	struct buffer_head *bh =3D NULL;
@@ -270,7 +265,6 @@
=20
 	if (name =3D=3D NULL)
 		return -EINVAL;
-	down_read(&EXT3_I(inode)->xattr_sem);
 	error =3D -ENODATA;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
@@ -343,15 +337,87 @@
=20
 cleanup:
 	brelse(bh);
-	up_read(&EXT3_I(inode)->xattr_sem);
=20
 	return error;
 }
=20
 /*
- * ext3_xattr_list()
+ * ext3_xattr_ibode_get()
  *
- * Copy a list of attribute names into the buffer
+ * routine looks for attribute in inode body and returns it's value and si=
ze
+ */
+int
+ext3_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	int size, name_len =3D strlen(name), storage_size;
+	struct ext3_xattr_entry *last;
+	struct ext3_inode *raw_inode;
+	struct ext3_iloc iloc;
+	char *start, *end;
+	int ret =3D -ENOENT;
+=09
+	if (EXT3_SB(inode->i_sb)->s_inode_size <=3D EXT3_GOOD_OLD_INODE_SIZE)
+		return -ENOENT;
+
+	ret =3D ext3_get_inode_loc(inode, &iloc, 1);
+	if (ret)
+		return ret;
+	raw_inode =3D ext3_raw_inode(&iloc);
+
+	storage_size =3D EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	start =3D (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if (le32_to_cpu((*(__u32*) start)) !=3D EXT3_XATTR_MAGIC) {
+		brelse(iloc.bh);
+		return -ENOENT;
+	}
+	start +=3D sizeof(__u32);
+	end =3D (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+
+	last =3D (struct ext3_xattr_entry *) start;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next =3D EXT3_XATTR_NEXT(last);
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >=3D end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_get",
+				"inode %ld", inode->i_ino);
+			brelse(iloc.bh);
+			return -EIO;
+		}
+		if (name_index =3D=3D last->e_name_index &&
+		    name_len =3D=3D last->e_name_len &&
+		    !memcmp(name, last->e_name, name_len))
+			goto found;
+		last =3D next;
+	}
+
+	/* can't find EA */
+	brelse(iloc.bh);
+	return -ENOENT;
+=09
+found:
+	size =3D le32_to_cpu(last->e_value_size);
+	if (buffer) {
+		ret =3D -ERANGE;
+		if (buffer_size >=3D size) {
+			memcpy(buffer, start + le16_to_cpu(last->e_value_offs),
+				size);
+			ret =3D size;
+		}
+	} else
+		ret =3D size;
+	brelse(iloc.bh);
+	return ret;
+}
+
+/*
+ * ext3_xattr_get()
+ *
+ * Copy an extended attribute into the buffer
  * provided, or compute the buffer size required.
  * Buffer is NULL to compute the size of the buffer required.
  *
@@ -359,7 +425,31 @@
  * used / required on success.
  */
 int
-ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+ext3_xattr_get(struct inode *inode, int name_index, const char *name,
+	       void *buffer, size_t buffer_size)
+{
+	int err;
+
+	down_read(&EXT3_I(inode)->xattr_sem);
+
+	/* try to find attribute in inode body */
+	err =3D ext3_xattr_ibody_get(inode, name_index, name,
+					buffer, buffer_size);
+	if (err < 0)
+		/* search was unsuccessful, try to find EA in dedicated block */
+		err =3D ext3_xattr_block_get(inode, name_index, name,
+				buffer, buffer_size);
+	up_read(&EXT3_I(inode)->xattr_sem);
+
+	return err;
+}
+
+/* ext3_xattr_ibody_list()
+ *
+ * generate list of attributes stored in EA block
+ */
+int
+ext3_xattr_block_list(struct inode *inode, char *buffer, size_t buffer_siz=
e)
 {
 	struct buffer_head *bh =3D NULL;
 	struct ext3_xattr_entry *entry;
@@ -370,7 +460,6 @@
 	ea_idebug(inode, "buffer=3D%p, buffer_size=3D%ld",
 		  buffer, (long)buffer_size);
=20
-	down_read(&EXT3_I(inode)->xattr_sem);
 	error =3D 0;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
@@ -431,11 +520,138 @@
=20
 cleanup:
 	brelse(bh);
-	up_read(&EXT3_I(inode)->xattr_sem);
=20
 	return error;
 }
=20
+/* ext3_xattr_ibody_list()
+ *
+ * generate list of attributes stored in inode body
+ */
+int
+ext3_xattr_ibody_list(struct inode *inode, char *buffer, size_t buffer_siz=
e)
+{
+	struct ext3_xattr_entry *last;
+	struct ext3_inode *raw_inode;
+	char *start, *end, *buf;
+	struct ext3_iloc iloc;
+	int storage_size;
+	int ret;
+	int size =3D 0;
+=09
+	if (EXT3_SB(inode->i_sb)->s_inode_size <=3D EXT3_GOOD_OLD_INODE_SIZE)
+		return 0;
+
+	ret =3D ext3_get_inode_loc(inode, &iloc, 1);
+	if (ret)
+		return ret;
+	raw_inode =3D ext3_raw_inode(&iloc);
+
+	storage_size =3D EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	start =3D (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if (le32_to_cpu((*(__u32*) start)) !=3D EXT3_XATTR_MAGIC) {
+		brelse(iloc.bh);
+		return 0;
+	}
+	start +=3D sizeof(__u32);
+	end =3D (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+
+	last =3D (struct ext3_xattr_entry *) start;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next =3D EXT3_XATTR_NEXT(last);
+		struct ext3_xattr_handler *handler;
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >=3D end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_list",
+				"inode %ld", inode->i_ino);
+			brelse(iloc.bh);
+			return -EIO;
+		}
+		handler =3D ext3_xattr_handler(last->e_name_index);
+		if (handler)
+			size +=3D handler->list(NULL, inode, last->e_name,
+					      last->e_name_len);
+		last =3D next;
+	}
+
+	if (!buffer) {
+		ret =3D size;
+		goto cleanup;
+	} else {
+		ret =3D -ERANGE;
+		if (size > buffer_size)
+			goto cleanup;
+	}
+
+	last =3D (struct ext3_xattr_entry *) start;
+	buf =3D buffer;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next =3D EXT3_XATTR_NEXT(last);
+		struct ext3_xattr_handler *handler;
+		handler =3D ext3_xattr_handler(last->e_name_index);
+		if (handler)
+			buf +=3D handler->list(buf, inode, last->e_name,
+					      last->e_name_len);
+		last =3D next;
+	}
+	ret =3D size;
+cleanup:
+	brelse(iloc.bh);
+	return ret;
+}
+
+/*
+ * ext3_xattr_list()
+ *
+ * Copy a list of attribute names into the buffer
+ * provided, or compute the buffer size required.
+ * Buffer is NULL to compute the size of the buffer required.
+ *
+ * Returns a negative error number on failure, or the number of bytes
+ * used / required on success.
+ */
+int
+ext3_xattr_list(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	int error;
+	int size =3D buffer_size;
+
+	down_read(&EXT3_I(inode)->xattr_sem);
+
+	/* get list of attributes stored in inode body */
+	error =3D ext3_xattr_ibody_list(inode, buffer, buffer_size);
+	if (error < 0) {
+		/* some error occured while collecting
+		 * attributes in inode body */
+		size =3D 0;
+		goto cleanup;
+	}
+	size =3D error;
+
+	/* get list of attributes stored in dedicated block */
+	if (buffer) {
+		buffer_size -=3D error;
+		if (buffer_size <=3D 0) {
+			buffer =3D NULL;
+			buffer_size =3D 0;
+		} else
+			buffer +=3D error;
+	}
+
+	error =3D ext3_xattr_block_list(inode, buffer, buffer_size);
+	if (error < 0)
+		/* listing was successful, so we return len */
+		size =3D 0;
+
+cleanup:
+	up_read(&EXT3_I(inode)->xattr_sem);
+	return error + size;
+}
+
 /*
  * If the EXT3_FEATURE_COMPAT_EXT_ATTR feature of this file system is
  * not set, set it.
@@ -457,6 +673,279 @@
 }
=20
 /*
+ * ext3_xattr_ibody_find()
+ *
+ * search attribute and calculate free space in inode body
+ * NOTE: free space includes space our attribute hold
+ */
+int
+ext3_xattr_ibody_find(struct inode *inode, int name_index,
+		const char *name, struct ext3_xattr_entry *rentry, int *free)
+{
+	struct ext3_xattr_entry *last;
+	struct ext3_inode *raw_inode;
+	int name_len =3D strlen(name);
+	int err, storage_size;
+	struct ext3_iloc iloc;
+	char *start, *end;
+	int ret =3D -ENOENT;
+=09
+	if (EXT3_SB(inode->i_sb)->s_inode_size <=3D EXT3_GOOD_OLD_INODE_SIZE)
+		return ret;
+
+	err =3D ext3_get_inode_loc(inode, &iloc, 1);
+	if (err)
+		return -EIO;
+	raw_inode =3D ext3_raw_inode(&iloc);
+
+	storage_size =3D EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	*free =3D storage_size - sizeof(__u32);
+	start =3D (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if (le32_to_cpu((*(__u32*) start)) !=3D EXT3_XATTR_MAGIC) {
+		brelse(iloc.bh);
+		return -ENOENT;
+	}
+	start +=3D sizeof(__u32);
+	end =3D (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+
+	last =3D (struct ext3_xattr_entry *) start;
+	while (!IS_LAST_ENTRY(last)) {
+		struct ext3_xattr_entry *next =3D EXT3_XATTR_NEXT(last);
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >=3D end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_find",
+				"inode %ld", inode->i_ino);
+			brelse(iloc.bh);
+			return -EIO;
+		}
+
+		if (name_index =3D=3D last->e_name_index &&
+		    name_len =3D=3D last->e_name_len &&
+		    !memcmp(name, last->e_name, name_len)) {
+			memcpy(rentry, last, sizeof(struct ext3_xattr_entry));
+			ret =3D 0;
+		} else {
+			*free -=3D EXT3_XATTR_LEN(last->e_name_len);
+			*free -=3D le32_to_cpu(last->e_value_size);
+		}
+		last =3D next;
+	}
+=09
+	brelse(iloc.bh);
+	return ret;
+}
+
+/*
+ * ext3_xattr_block_find()
+ *
+ * search attribute and calculate free space in EA block (if it allocated)
+ * NOTE: free space includes space our attribute hold
+ */
+int
+ext3_xattr_block_find(struct inode *inode, int name_index, const char *nam=
e,
+	       struct ext3_xattr_entry *rentry, int *free)
+{
+	struct buffer_head *bh =3D NULL;
+	struct ext3_xattr_entry *entry;
+	char *end;
+	int name_len, error =3D -ENOENT;
+
+	if (!EXT3_I(inode)->i_file_acl) {
+		*free =3D inode->i_sb->s_blocksize -
+			sizeof(struct ext3_xattr_header) -
+			sizeof(__u32);
+		return -ENOENT;
+	}
+	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
+	bh =3D sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
+	if (!bh)
+		return -EIO;
+	ea_bdebug(bh, "b_count=3D%d, refcount=3D%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
+	end =3D bh->b_data + bh->b_size;
+	if (HDR(bh)->h_magic !=3D cpu_to_le32(EXT3_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks !=3D cpu_to_le32(1)) {
+bad_block:	ext3_error(inode->i_sb, "ext3_xattr_get",
+			"inode %ld: bad block %d", inode->i_ino,
+			EXT3_I(inode)->i_file_acl);
+		brelse(bh);
+		return -EIO;
+	}
+	/* find named attribute */
+	name_len =3D strlen(name);
+	*free =3D bh->b_size - sizeof(__u32);
+
+	entry =3D FIRST_ENTRY(bh);
+	while (!IS_LAST_ENTRY(entry)) {
+		struct ext3_xattr_entry *next =3D
+			EXT3_XATTR_NEXT(entry);
+		if ((char *)next >=3D end)
+			goto bad_block;
+		if (name_index =3D=3D entry->e_name_index &&
+		    name_len =3D=3D entry->e_name_len &&
+		    memcmp(name, entry->e_name, name_len) =3D=3D 0) {
+			memcpy(rentry, entry, sizeof(struct ext3_xattr_entry));
+			error =3D 0;
+		} else {
+			*free -=3D EXT3_XATTR_LEN(entry->e_name_len);
+			*free -=3D le32_to_cpu(entry->e_value_size);
+		}
+		entry =3D next;
+	}
+	brelse(bh);
+
+	return error;
+}
+
+/*
+ * ext3_xattr_inode_set()
+ *
+ * this routine add/remove/replace attribute in inode body
+ */
+int
+ext3_xattr_ibody_set(handle_t *handle, struct inode *inode, int name_index,
+		      const char *name, const void *value, size_t value_len,
+		      int flags)
+{
+	struct ext3_xattr_entry *last, *next, *here =3D NULL;
+	struct ext3_inode *raw_inode;
+	int name_len =3D strlen(name);
+	int esize =3D EXT3_XATTR_LEN(name_len);
+	struct buffer_head *bh;
+	int err, storage_size;
+	struct ext3_iloc iloc;
+	int free, min_offs;
+	char *start, *end;
+=09
+	if (EXT3_SB(inode->i_sb)->s_inode_size <=3D EXT3_GOOD_OLD_INODE_SIZE)
+		return -ENOSPC;
+
+	err =3D ext3_get_inode_loc(inode, &iloc, 1);
+	if (err)
+		return err;
+	raw_inode =3D ext3_raw_inode(&iloc);
+	bh =3D iloc.bh;
+
+	storage_size =3D EXT3_SB(inode->i_sb)->s_inode_size -
+				EXT3_GOOD_OLD_INODE_SIZE -
+				EXT3_I(inode)->i_extra_isize -
+				sizeof(__u32);
+	start =3D (char *) raw_inode + EXT3_GOOD_OLD_INODE_SIZE +
+			EXT3_I(inode)->i_extra_isize;
+	if ((*(__u32*) start) !=3D EXT3_XATTR_MAGIC) {
+		/* inode had no attributes before */
+		*((__u32*) start) =3D cpu_to_le32(EXT3_XATTR_MAGIC);
+	}
+	start +=3D sizeof(__u32);
+	end =3D (char *) raw_inode + EXT3_SB(inode->i_sb)->s_inode_size;
+	min_offs =3D storage_size;
+	free =3D storage_size - sizeof(__u32);
+
+	last =3D (struct ext3_xattr_entry *) start;=09
+	while (!IS_LAST_ENTRY(last)) {
+		next =3D EXT3_XATTR_NEXT(last);
+		if (le32_to_cpu(last->e_value_size) > storage_size ||
+				(char *) next >=3D end) {
+			ext3_error(inode->i_sb, "ext3_xattr_ibody_set",
+				"inode %ld", inode->i_ino);
+			brelse(bh);
+			return -EIO;
+		}
+	=09
+		if (last->e_value_size) {
+			int offs =3D le16_to_cpu(last->e_value_offs);
+			if (offs < min_offs)
+				min_offs =3D offs;
+		}
+		if (name_index =3D=3D last->e_name_index &&
+			name_len =3D=3D last->e_name_len &&
+			!memcmp(name, last->e_name, name_len))
+			here =3D last;
+		else {
+			/* we calculate all but our attribute
+			 * because it will be removed before changing */
+			free -=3D EXT3_XATTR_LEN(last->e_name_len);
+			free -=3D le32_to_cpu(last->e_value_size);
+		}
+		last =3D next;
+	}
+
+	if (value && (esize + value_len > free)) {
+		brelse(bh);
+		return -ENOSPC;
+	}
+=09
+	err =3D ext3_reserve_inode_write(handle, inode, &iloc);
+	if (err) {
+		brelse(bh);=09
+		return err;
+	}
+
+	if (here) {
+		/* time to remove old value */
+		struct ext3_xattr_entry *e;
+		int size =3D le32_to_cpu(here->e_value_size);
+		int border =3D le16_to_cpu(here->e_value_offs);
+		char *src;
+
+		/* move tail */
+		memmove(start + min_offs + size, start + min_offs,
+				border - min_offs);
+
+		/* recalculate offsets */
+		e =3D (struct ext3_xattr_entry *) start;
+		while (!IS_LAST_ENTRY(e)) {
+			struct ext3_xattr_entry *next =3D EXT3_XATTR_NEXT(e);
+			int offs =3D le16_to_cpu(e->e_value_offs);
+			if (offs < border)
+				e->e_value_offs =3D
+					cpu_to_le16(offs + size);
+			e =3D next;
+		}
+		min_offs +=3D size;
+
+		/* remove entry */
+		border =3D EXT3_XATTR_LEN(here->e_name_len);
+		src =3D (char *) here + EXT3_XATTR_LEN(here->e_name_len);
+		size =3D (char *) last - src;
+		if ((char *) here + size > end)
+			printk("ALERT at %s:%d: 0x%p + %d > 0x%p\n",
+					__FILE__, __LINE__, here, size, end);
+		memmove(here, src, size);
+		last =3D (struct ext3_xattr_entry *) ((char *) last - border);
+		*((__u32 *) last) =3D 0;
+	}
+=09
+	if (value) {
+		int offs =3D min_offs - value_len;
+		/* use last to create new entry */
+		last->e_name_len =3D strlen(name);
+		last->e_name_index =3D name_index;
+		last->e_value_offs =3D cpu_to_le16(offs);
+		last->e_value_size =3D cpu_to_le32(value_len);
+		last->e_hash =3D last->e_value_block =3D 0;
+		memset(last->e_name, 0, esize);
+		memcpy(last->e_name, name, last->e_name_len);
+		if (start + offs + value_len > end)
+			printk("ALERT at %s:%d: 0x%p + %d + %d > 0x%p\n",
+					__FILE__, __LINE__, start, offs,
+					value_len, end);
+		memcpy(start + offs, value, value_len);
+		last =3D EXT3_XATTR_NEXT(last);
+		*((__u32 *) last) =3D 0;
+	}
+=09
+	ext3_mark_iloc_dirty(handle, inode, &iloc);
+	brelse(bh);
+
+	return 0;
+}
+
+/*
  * ext3_xattr_set_handle()
  *
  * Create, replace or remove an extended attribute for this inode. Buffer
@@ -470,6 +959,104 @@
  */
 int
 ext3_xattr_set_handle(handle_t *handle, struct inode *inode, int name_inde=
x,
+		const char *name, const void *value, size_t value_len,
+		int flags)
+{
+	struct ext3_xattr_entry entry;
+	int err, where =3D 0, found =3D 0, total;
+	int free1 =3D -1, free2 =3D -1;
+	int name_len;
+=09
+	ea_idebug(inode, "name=3D%d.%s, value=3D%p, value_len=3D%ld",
+		  name_index, name, value, (long)value_len);
+
+	if (IS_RDONLY(inode))
+		return -EROFS;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		return -EPERM;
+	if (value =3D=3D NULL)
+		value_len =3D 0;
+	if (name =3D=3D NULL)
+		return -EINVAL;
+	name_len =3D strlen(name);
+	if (name_len > 255 || value_len > inode->i_sb->s_blocksize)
+		return -ERANGE;
+	down_write(&EXT3_I(inode)->xattr_sem);
+
+	/* try to find attribute in inode body */
+	err =3D ext3_xattr_ibody_find(inode, name_index, name, &entry, &free1);
+	if (err =3D=3D 0) {
+		/* found EA in inode */
+		found =3D 1;
+		where =3D 0;
+	} else if (err =3D=3D -ENOENT) {
+		/* there is no such attribute in inode body */
+		/* try to find attribute in dedicated block */
+		err =3D ext3_xattr_block_find(inode, name_index, name,
+						&entry, &free2);
+		if (err !=3D 0 && err !=3D -ENOENT) {
+			/* not found EA in block */
+			goto finish;=09
+		} else if (err =3D=3D 0) {
+			/* found EA in block */
+			where =3D 1;
+			found =3D 1;
+		}
+	} else
+		goto finish;
+
+	/* check flags: may replace? may create ? */
+	if (found && (flags & XATTR_CREATE)) {
+		err =3D -EEXIST;
+		goto finish;
+	} else if (!found && (flags & XATTR_REPLACE)) {
+		err =3D -ENODATA;
+		goto finish;
+	}
+
+	/* check if we have enough space to store attribute */
+	total =3D EXT3_XATTR_LEN(strlen(name)) + value_len;
+	if (free1 >=3D 0 && total > free1 && free2 >=3D 0 && total > free2) {
+		/* have no enough space */
+		err =3D -ENOSPC;
+		goto finish;
+	}
+=09
+	/* time to remove attribute */
+	if (found) {
+		if (where =3D=3D 0) {
+			/* EA is stored in inode body */
+			ext3_xattr_ibody_set(handle, inode, name_index, name,
+					NULL, 0, flags);
+		} else {
+			/* EA is stored in separated block */
+			ext3_xattr_block_set(handle, inode, name_index, name,
+					NULL, 0, flags);
+		}
+	}
+
+	/* try to store EA in inode body */
+	err =3D ext3_xattr_ibody_set(handle, inode, name_index, name,
+				value, value_len, flags);
+	if (err) {
+		/* can't store EA in inode body */
+		/* try to store in block */
+		err =3D ext3_xattr_block_set(handle, inode, name_index,
+					name, value, value_len, flags);=09
+	}
+
+finish:=09
+	up_write(&EXT3_I(inode)->xattr_sem);
+	return err;
+}
+
+/*
+ * ext3_xattr_block_set()
+ *
+ * this routine add/remove/replace attribute in EA block
+ */
+int
+ext3_xattr_block_set(handle_t *handle, struct inode *inode, int name_index,
 		      const char *name, const void *value, size_t value_len,
 		      int flags)
 {
@@ -492,22 +1078,7 @@
 	 *             towards the end of the block).
 	 * end -- Points right after the block pointed to by header.
 	 */
-
-	ea_idebug(inode, "name=3D%d.%s, value=3D%p, value_len=3D%ld",
-		  name_index, name, value, (long)value_len);
-
-	if (IS_RDONLY(inode))
-		return -EROFS;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		return -EPERM;
-	if (value =3D=3D NULL)
-		value_len =3D 0;
-	if (name =3D=3D NULL)
-		return -EINVAL;
 	name_len =3D strlen(name);
-	if (name_len > 255 || value_len > sb->s_blocksize)
-		return -ERANGE;
-	down_write(&EXT3_I(inode)->xattr_sem);
 	if (EXT3_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
 		bh =3D sb_bread(sb, EXT3_I(inode)->i_file_acl);
@@ -733,7 +1304,6 @@
 	brelse(bh);
 	if (!(bh && header =3D=3D HDR(bh)))
 		kfree(header);
-	up_write(&EXT3_I(inode)->xattr_sem);
=20
 	return error;
 }
Index: linux-2.6.0/fs/ext3/xattr.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.0.orig/fs/ext3/xattr.h	2003-06-24 18:04:43.000000000 +0400
+++ linux-2.6.0/fs/ext3/xattr.h	2004-01-14 18:54:12.000000000 +0300
@@ -77,7 +77,8 @@
 extern int ext3_xattr_get(struct inode *, int, const char *, void *, size_=
t);
 extern int ext3_xattr_list(struct inode *, char *, size_t);
 extern int ext3_xattr_set(struct inode *, int, const char *, const void *,=
 size_t, int);
-extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const ch=
ar *, const void *, size_t, int);
+extern int ext3_xattr_set_handle(handle_t *, struct inode *, int, const ch=
ar *,const void *,size_t,int);
+extern int ext3_xattr_block_set(handle_t *, struct inode *, int, const cha=
r *,const void *,size_t,int);
=20
 extern void ext3_xattr_delete_inode(handle_t *, struct inode *);
 extern void ext3_xattr_put_super(struct super_block *);
Index: linux-2.6.0/include/linux/ext3_fs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.0.orig/include/linux/ext3_fs.h	2004-01-14 18:54:11.000000000 =
+0300
+++ linux-2.6.0/include/linux/ext3_fs.h	2004-01-14 18:54:12.000000000 +0300
@@ -265,6 +265,8 @@
 			__u32	m_i_reserved2[2];
 		} masix2;
 	} osd2;				/* OS dependent 2 */
+	__u16	i_extra_isize;
+	__u16	i_pad1;
 };
=20
 #define i_size_high	i_dir_acl
@@ -721,6 +723,7 @@
 extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head=
 *, int);
 extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long,=
 int, int *);
 extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, i=
nt, int *);
+int ext3_get_inode_loc(struct inode *inode, struct ext3_iloc *iloc, int in=
_mem);
=20
 extern void ext3_read_inode (struct inode *);
 extern void ext3_write_inode (struct inode *, int);
Index: linux-2.6.0/include/linux/ext3_fs_i.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.0.orig/include/linux/ext3_fs_i.h	2003-12-30 08:32:44.00000000=
0 +0300
+++ linux-2.6.0/include/linux/ext3_fs_i.h	2004-01-14 18:54:12.000000000 +03=
00
@@ -96,6 +96,9 @@
 	 */
 	loff_t	i_disksize;
=20
+	/* on-disk additional length */
+	__u16 i_extra_isize;
+
 	/*
 	 * truncate_sem is for serialising ext3_truncate() against
 	 * ext3_getblock().  In the 2.4 ext2 design, great chunks of inode's

%diffstat
 fs/ext3/ialloc.c          |    5=20
 fs/ext3/inode.c           |   10=20
 fs/ext3/xattr.c           |  634 +++++++++++++++++++++++++++++++++++++++++=
++---
 fs/ext3/xattr.h           |    3=20
 include/linux/ext3_fs.h   |    2=20
 include/linux/ext3_fs_i.h |    3=20
 6 files changed, 623 insertions(+), 34 deletions(-)


--SdvjNjn6lL3tIsv0--

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBncfgpIg59Q01vtYRAmFnAJ9T0aCPYDRP3MOtBKmsz4Mnq78SBgCeLGTV
oxUKq2jQBhw1VS5Kv/3vHvE=
=zOjO
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--
