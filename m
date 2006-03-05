Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWCETWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWCETWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCETWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:22:23 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:41388 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751014AbWCETWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:22:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JPXCJAOZuQfB6PPjpDTeM35552tqNioAKaSnbYe5d+XEM/NJzYWjBq/8muLNC4NA9jvhQgHZJENIoM/5gLGZeqd0Z3Tya8XTZk2NlX0qitKV6aQLFg28PnWtlKvnJJEpMQsaWLMpLcmYO5Y4V5VGS3Qf472Ajiag7J3+RKs14+o=
Message-ID: <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com>
Date: Sun, 5 Mar 2006 21:22:20 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget options
Cc: "linux kernel" <linux-kernel@vger.kernel.org>, bfennema@ix.netcom.com,
       "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <4409EB37.5050308@cfl.rr.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5607_7234676.1141586540119"
References: <4409EB37.5050308@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5607_7234676.1141586540119
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/4/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> This patch fixes a bug in udf where it would write uid/gid =3D 0 to the
> disk for files owned by the id given with the uid=3D/gid=3D mount options=
.

I don't think it does. You can still get zero uid/gid written on disk
if you specify uid/gid mount options when not specifying uid=3Dforget. I
am not against new features but lets fix the bug first, okay? Adding
new mount options to work around buggy code is not the right solution.

The unconditional memset() is clearly a regression caused by Ben
Fennema's commit "[PATCH] UDF sync with CVS" in the old-2.6-bkcvs.git
repository and should be fixed. Care to try out the included untested
patch to see if it fixes the problem? (Sorry for the attachment, I am
replying via web mail.)

                                   Pekka

[PATCH] udf: fix uid/gid changing to zero

This patch fixes uid/gid changing to zero when uid/gid mount option is
used for UDF. The problem appears when the overriding uid/gid matches
inode. The fix is simple, instead of unconditionally zeroing buffer,
we now only do it for new inodes.

The regression appeared in commit "[PATCH] UDF sync with CVS" and was
first reported by Phillip Susi.

Cc: Phillip Susi <psusi@cfl.rr.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/udf/ialloc.c          |    1 +
 fs/udf/inode.c           |    9 +++++++--
 fs/udf/udf_i.h           |    1 +
 include/linux/udf_fs_i.h |    3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index c9b707b..4bc3dc9 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -146,6 +146,7 @@ struct inode * udf_new_inode (struct ino
 =09=09UDF_I_ALLOCTYPE(inode) =3D ICBTAG_FLAG_AD_LONG;
 =09inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D
 =09=09UDF_I_CRTIME(inode) =3D current_fs_time(inode->i_sb);
+=09UDF_I_NEW_INODE(inode) =3D 1;
 =09insert_inode_hash(inode);
 =09mark_inode_dirty(inode);
 =09up(&sbi->s_alloc_sem);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 395e582..6937da2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1003,6 +1003,8 @@ static void udf_fill_inode(struct inode
 =09long convtime_usec;
 =09int offset;

+=09UDF_I_NEW_INODE(inode) =3D 0;
+
 =09fe =3D (struct fileEntry *)bh->b_data;
 =09efe =3D (struct extendedFileEntry *)bh->b_data;

@@ -1307,11 +1309,14 @@ udf_update_inode(struct inode *inode, in
 =09=09return -EIO;
 =09}

-=09memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
-
 =09fe =3D (struct fileEntry *)bh->b_data;
 =09efe =3D (struct extendedFileEntry *)bh->b_data;

+=09if (UDF_I_NEW_INODE(inode) =3D=3D 1) {
+=09=09memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
+=09=09UDF_I_NEW_INODE(inode) =3D 0;
+=09}
+
 =09if (le16_to_cpu(fe->descTag.tagIdent) =3D=3D TAG_IDENT_USE)
 =09{
 =09=09struct unallocSpaceEntry *use =3D
diff --git a/fs/udf/udf_i.h b/fs/udf/udf_i.h
index d7dbe6f..87f82f7 100644
--- a/fs/udf/udf_i.h
+++ b/fs/udf/udf_i.h
@@ -16,6 +16,7 @@ static inline struct udf_inode_info *UDF
 #define UDF_I_EFE(X)=09=09( UDF_I(X)->i_efe )
 #define UDF_I_USE(X)=09=09( UDF_I(X)->i_use )
 #define UDF_I_STRAT4096(X)=09( UDF_I(X)->i_strat4096 )
+#define UDF_I_NEW_INODE(X)=09( UDF_I(X)->i_new_inode )
 #define UDF_I_NEXT_ALLOC_BLOCK(X)=09( UDF_I(X)->i_next_alloc_block )
 #define UDF_I_NEXT_ALLOC_GOAL(X)=09( UDF_I(X)->i_next_alloc_goal )
 #define UDF_I_CRTIME(X)=09=09( UDF_I(X)->i_crtime )
diff --git a/include/linux/udf_fs_i.h b/include/linux/udf_fs_i.h
index 1e75084..c21415a 100644
--- a/include/linux/udf_fs_i.h
+++ b/include/linux/udf_fs_i.h
@@ -51,7 +51,8 @@ struct udf_inode_info
 =09unsigned=09=09i_efe : 1;
 =09unsigned=09=09i_use : 1;
 =09unsigned=09=09i_strat4096 : 1;
-=09unsigned=09=09reserved : 26;
+=09unsigned=09=09i_new_inode : 1;
+=09unsigned=09=09reserved : 25;
 =09union
 =09{
 =09=09short_ad=09*i_sad;

------=_Part_5607_7234676.1141586540119
Content-Type: application/octet-stream; name=udf-fix
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ekfr1hxb
Content-Disposition: attachment; filename="udf-fix"

[PATCH] udf: fix uid/gid changing to zero

This patch fixes uid/gid changing to zero when uid/gid mount option is
used for UDF. The problem appears when the overriding uid/gid matches
inode. The fix is simple, instead of unconditionally zeroing buffer,
we now only do it for new inodes.

The regression appeared in commit "[PATCH] UDF sync with CVS" and was
first reported by Phillip Susi.

Cc: Phillip Susi <psusi@cfl.rr.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/udf/ialloc.c          |    1 +
 fs/udf/inode.c           |    9 +++++++--
 fs/udf/udf_i.h           |    1 +
 include/linux/udf_fs_i.h |    3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index c9b707b..4bc3dc9 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -146,6 +146,7 @@ struct inode * udf_new_inode (struct ino
 		UDF_I_ALLOCTYPE(inode) = ICBTAG_FLAG_AD_LONG;
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 		UDF_I_CRTIME(inode) = current_fs_time(inode->i_sb);
+	UDF_I_NEW_INODE(inode) = 1;
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 	up(&sbi->s_alloc_sem);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 395e582..6937da2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1003,6 +1003,8 @@ static void udf_fill_inode(struct inode 
 	long convtime_usec;
 	int offset;
 
+	UDF_I_NEW_INODE(inode) = 0;
+
 	fe = (struct fileEntry *)bh->b_data;
 	efe = (struct extendedFileEntry *)bh->b_data;
 
@@ -1307,11 +1309,14 @@ udf_update_inode(struct inode *inode, in
 		return -EIO;
 	}
 
-	memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
-
 	fe = (struct fileEntry *)bh->b_data;
 	efe = (struct extendedFileEntry *)bh->b_data;
 
+	if (UDF_I_NEW_INODE(inode) == 1) {
+		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
+		UDF_I_NEW_INODE(inode) = 0;
+	}
+
 	if (le16_to_cpu(fe->descTag.tagIdent) == TAG_IDENT_USE)
 	{
 		struct unallocSpaceEntry *use =
diff --git a/fs/udf/udf_i.h b/fs/udf/udf_i.h
index d7dbe6f..87f82f7 100644
--- a/fs/udf/udf_i.h
+++ b/fs/udf/udf_i.h
@@ -16,6 +16,7 @@ static inline struct udf_inode_info *UDF
 #define UDF_I_EFE(X)		( UDF_I(X)->i_efe )
 #define UDF_I_USE(X)		( UDF_I(X)->i_use )
 #define UDF_I_STRAT4096(X)	( UDF_I(X)->i_strat4096 )
+#define UDF_I_NEW_INODE(X)	( UDF_I(X)->i_new_inode )
 #define UDF_I_NEXT_ALLOC_BLOCK(X)	( UDF_I(X)->i_next_alloc_block )
 #define UDF_I_NEXT_ALLOC_GOAL(X)	( UDF_I(X)->i_next_alloc_goal )
 #define UDF_I_CRTIME(X)		( UDF_I(X)->i_crtime )
diff --git a/include/linux/udf_fs_i.h b/include/linux/udf_fs_i.h
index 1e75084..c21415a 100644
--- a/include/linux/udf_fs_i.h
+++ b/include/linux/udf_fs_i.h
@@ -51,7 +51,8 @@ struct udf_inode_info
 	unsigned		i_efe : 1;
 	unsigned		i_use : 1;
 	unsigned		i_strat4096 : 1;
-	unsigned		reserved : 26;
+	unsigned		i_new_inode : 1;
+	unsigned		reserved : 25;
 	union
 	{
 		short_ad	*i_sad;

------=_Part_5607_7234676.1141586540119--
