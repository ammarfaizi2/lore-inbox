Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269682AbUJMMK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269682AbUJMMK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 08:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269686AbUJMMK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 08:10:29 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:37006 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269682AbUJMMKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 08:10:23 -0400
Message-ID: <c461c0d104101305103792ad7a@mail.gmail.com>
Date: Wed, 13 Oct 2004 13:10:10 +0100
From: Alex Kiernan <alex.kiernan@gmail.com>
Reply-To: Alex Kiernan <alex.kiernan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
Cc: akpm@osdl.org, viro@ZenII.linux.org.uk
In-Reply-To: <c461c0d10410130406714fafe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_253_14801366.1097669410898"
References: <c461c0d10410130406714fafe3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_253_14801366.1097669410898
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 13 Oct 2004 12:06:29 +0100, Alex Kiernan <alex.kiernan@gmail.com> wrote:
> I've run into a bug in the UFS reading code (on Solaris x86 the
> major/minor numbers are in 2nd indirect offset not the first), so I've
> patched it & bugzilled it
> (http://bugzilla.kernel.org/show_bug.cgi?id=3475).
> 
> But where do I go from here? There doesn't seem to be a maintainer for
> UFS so I can't send it there.
> 

After advice from Alan (thanks), here's the patch which addresses the
problem I'm seeing. Specifically it appears that on x86 Solaris stores
the major/minor device numbers in the 2nd indirect block, not the
first.

-- 
Alex Kiernan

------=_Part_253_14801366.1097669410898
Content-Type: text/x-patch; name="ufs.solx86.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ufs.solx86.diff"

=3D=3D=3D=3D=3D namei.c 1.24 vs edited =3D=3D=3D=3D=3D
--- 1.24/fs/ufs/namei.c=092004-03-12 09:30:20 +00:00
+++ edited/namei.c=092004-09-27 16:52:58 +01:00
@@ -30,6 +30,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include "swab.h"=09/* will go away - see comment in mknod() */
+#include "util.h"
=20
 /*
 #undef UFS_NAMEI_DEBUG
@@ -125,8 +126,8 @@
 =09if (!IS_ERR(inode)) {
 =09=09init_special_inode(inode, mode, rdev);
 =09=09/* NOTE: that'll go when we get wide dev_t */
-=09=09UFS_I(inode)->i_u1.i_data[0] =3D cpu_to_fs32(inode->i_sb,
-=09=09=09=09=09=09=09old_encode_dev(rdev));
+=09=09ufs_set_inode_dev(inode->i_sb, UFS_I(inode),
+=09=09=09old_encode_dev(rdev));
 =09=09mark_inode_dirty(inode);
 =09=09lock_kernel();
 =09=09err =3D ufs_add_nondir(dentry, inode);
=3D=3D=3D=3D=3D inode.c 1.24 vs edited =3D=3D=3D=3D=3D
--- 1.24/fs/ufs/inode.c=092004-09-17 07:58:42 +01:00
+++ edited/inode.c=092004-09-27 16:50:47 +01:00
@@ -629,7 +629,7 @@
 =09=09}
 =09} else
 =09=09init_special_inode(inode, inode->i_mode,
-=09=09=09old_decode_dev(fs32_to_cpu(sb, ufsi->i_u1.i_data[0])));
+=09=09=09old_decode_dev(ufs_get_inode_dev(sb, ufsi)));
=20
 =09brelse (bh);
=20
@@ -705,7 +705,7 @@
 =09=09}
 =09} else   /* TODO  : here ...*/
 =09=09init_special_inode(inode, inode->i_mode,
-=09=09=09old_decode_dev(fs32_to_cpu(sb, ufsi->i_u1.i_data[0])));
+=09=09=09old_decode_dev(ufs_get_inode_dev(sb, ufsi)));
=20
 =09brelse(bh);
=20
=3D=3D=3D=3D=3D util.h 1.9 vs edited =3D=3D=3D=3D=3D
--- 1.9/fs/ufs/util.h=092004-03-12 09:30:20 +00:00
+++ edited/util.h=092004-09-27 16:49:21 +01:00
@@ -223,6 +223,24 @@
 =09inode->ui_u1.oldids.ui_sgid =3D  cpu_to_fs16(sb, value);
 }
=20
+static inline u32
+ufs_get_inode_dev(struct super_block *sb, struct ufs_inode_info *inode)
+{
+=09if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) =3D=3D UFS_ST_SUNx86)
+=09=09return fs32_to_cpu(sb, ufsi->i_u1.i_data[1]);
+=09else
+=09=09return fs32_to_cpu(sb, ufsi->i_u1.i_data[0]);
+}
+
+static inline void
+ufs_set_inode_dev(struct super_block *sb, struct ufs_inode_info *inode, u3=
2 value)
+{
+=09if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) =3D=3D UFS_ST_SUNx86)
+=09=09ufsi->i_u1.i_data[1] =3D cpu_to_fs32(sb, value);
+=09else
+=09=09ufsi->i_u1.i_data[0] =3D cpu_to_fs32(sb, value);
+}
+
=20
 /*
  * These functions manipulate ufs buffers

------=_Part_253_14801366.1097669410898--
