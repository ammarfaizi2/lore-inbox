Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUJRKWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUJRKWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUJRKWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:22:44 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:13895 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265800AbUJRKUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 06:20:19 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=nPi87mk871d2ompES1OQq7e/fP1jRA/aJ0Eid5OSBFr06W3Ye7QKdiNpMPJf9bz3dqwPFRC80Zr4E7USBsLKJFg2faFGcHPrwpZlriix0qbKL2voVDFfN2gOXI9MjljUjdvlab7FayoS6cPf2ZfFVefFudUM3wEVvazgqauj23M
Message-ID: <c461c0d10410180320706b0746@mail.gmail.com>
Date: Mon, 18 Oct 2004 11:20:16 +0100
From: Alex Kiernan <alex.kiernan@gmail.com>
Reply-To: Alex Kiernan <alex.kiernan@gmail.com>
To: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, viro@zenii.linux.org.uk
In-Reply-To: <c461c0d10410150935408afd96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_388_7762230.1098094816873"
References: <c461c0d10410130406714fafe3@mail.gmail.com>
	 <c461c0d104101305103792ad7a@mail.gmail.com>
	 <20041013134350.GA23987@parcelfarce.linux.theplanet.co.uk>
	 <c461c0d10410150935408afd96@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_388_7762230.1098094816873
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 15 Oct 2004 17:35:50 +0100, Alex Kiernan <alex.kiernan@gmail.com> wrote:
> On Wed, 13 Oct 2004 14:43:51 +0100,
> viro@parcelfarce.linux.theplanet.co.uk
> <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> > On Wed, Oct 13, 2004 at 01:10:10PM +0100, Alex Kiernan wrote:
> >
> >
> > > On Wed, 13 Oct 2004 12:06:29 +0100, Alex Kiernan <alex.kiernan@gmail.com> wrote:
> > > > I've run into a bug in the UFS reading code (on Solaris x86 the
> > > > major/minor numbers are in 2nd indirect offset not the first), so I've
> > > > patched it & bugzilled it
> > > > (http://bugzilla.kernel.org/show_bug.cgi?id=3475).
> > > >
> > > > But where do I go from here? There doesn't seem to be a maintainer for
> > > > UFS so I can't send it there.
> > > >
> > >
> > > After advice from Alan (thanks), here's the patch which addresses the
> > > problem I'm seeing. Specifically it appears that on x86 Solaris stores
> > > the major/minor device numbers in the 2nd indirect block, not the
> > > first.
> >
> > 1) please, move old_encode_dev()/old_decode_dev() into your helper functions.
> 
> Will do.
> 
> > 2) we could do a bit better now that we have large dev_t.  What are complete
> > rules for
> >         a) Solaris userland dev_t => on-disk data
> >         b) major/minor => Solaris userland dev_t
> > on sparc and x86 Solaris?
> >
> 
> Assuming I've followed it right...
> 
> The kernel dev_t has 14 major device bits, 18 minor device bits (with
> the major as the most significant bits).
> 
> On disk there are 32 bits stored in host byte order, the device is in
> the [0] indirect offset on Sparc, [1] on x86.
> 
> Looking at an individual entry, if the top 16 bits are clear or
> 0xffff, then the bottom 16 bits are the device number, with 7 bits of
> major (most significant), 8 bits of minor (and the most significant
> bit unused). If the top 16 bits are some other pattern, the on disk
> mapping is the same as the kernel mapping.
> 

Attached is code to implement the code move of old_decode_dev and
support for large dev_t (Solaris' own handling of this seems to be
dodgy in the extreme). I've checked Solaris x86/sparc w/ both types of
dev_t encoding for reading. I haven't checked writing as the code to
detect clean filesystems seems to be bust for Solaris UFS filesystems.
I'll have a look at whats wrong w/ it when I've a bit more time.

Because of the different Solaris/Linux large dev encodings, what
should I be doing in get/set inode_dev when the required things won't
fit?

-- 
Alex Kiernan

------=_Part_388_7762230.1098094816873
Content-Type: text/x-patch; name="ufs.solx86.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ufs.solx86.diff"

diff -xSCCS -x'*.cmd' -x'*.o' -ur linus-2.5/fs/ufs/inode.c linux-2.5/fs/ufs=
/inode.c
--- linus-2.5/fs/ufs/inode.c=092004-10-13 15:04:04.000000000 +0100
+++ linux-2.5/fs/ufs/inode.c=092004-10-13 15:44:05.000000000 +0100
@@ -629,7 +629,7 @@
 =09=09}
 =09} else
 =09=09init_special_inode(inode, inode->i_mode,
-=09=09=09old_decode_dev(fs32_to_cpu(sb, ufsi->i_u1.i_data[0])));
+=09=09=09ufs_get_inode_dev(sb, ufsi));
=20
 =09brelse (bh);
=20
@@ -705,7 +705,7 @@
 =09=09}
 =09} else   /* TODO  : here ...*/
 =09=09init_special_inode(inode, inode->i_mode,
-=09=09=09old_decode_dev(fs32_to_cpu(sb, ufsi->i_u1.i_data[0])));
+=09=09=09ufs_get_inode_dev(sb, ufsi));
=20
 =09brelse(bh);
=20
diff -xSCCS -x'*.cmd' -x'*.o' -ur linus-2.5/fs/ufs/namei.c linux-2.5/fs/ufs=
/namei.c
--- linus-2.5/fs/ufs/namei.c=092004-10-13 15:04:04.000000000 +0100
+++ linux-2.5/fs/ufs/namei.c=092004-10-13 14:58:23.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 #include "swab.h"=09/* will go away - see comment in mknod() */
+#include "util.h"
=20
 /*
 #undef UFS_NAMEI_DEBUG
@@ -125,8 +126,7 @@
 =09if (!IS_ERR(inode)) {
 =09=09init_special_inode(inode, mode, rdev);
 =09=09/* NOTE: that'll go when we get wide dev_t */
-=09=09UFS_I(inode)->i_u1.i_data[0] =3D cpu_to_fs32(inode->i_sb,
-=09=09=09=09=09=09=09old_encode_dev(rdev));
+=09=09ufs_set_inode_dev(inode->i_sb, UFS_I(inode), rdev);
 =09=09mark_inode_dirty(inode);
 =09=09lock_kernel();
 =09=09err =3D ufs_add_nondir(dentry, inode);
Only in linux-2.5/fs/ufs: ufs.ko
Only in linux-2.5/fs/ufs: ufs.mod.c
diff -xSCCS -x'*.cmd' -x'*.o' -ur linus-2.5/fs/ufs/util.h linux-2.5/fs/ufs/=
util.h
--- linus-2.5/fs/ufs/util.h=092004-10-13 15:04:04.000000000 +0100
+++ linux-2.5/fs/ufs/util.h=092004-10-18 11:12:52.002280119 +0100
@@ -223,6 +223,58 @@
 =09inode->ui_u1.oldids.ui_sgid =3D  cpu_to_fs16(sb, value);
 }
=20
+static inline dev_t
+ufs_get_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi)
+{
+=09__fs32 fs32;
+=09dev_t dev;
+
+=09if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) =3D=3D UFS_ST_SUNx86)
+=09=09fs32 =3D ufsi->i_u1.i_data[1];
+=09else
+=09=09fs32 =3D ufsi->i_u1.i_data[0];
+=09fs32 =3D fs32_to_cpu(sb, fs32);
+=09switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
+=09case UFS_ST_SUNx86:
+=09case UFS_ST_SUN:
+=09=09if ((fs32 & 0xffff0000) =3D=3D 0 ||
+=09=09    (fs32 & 0xffff0000) =3D=3D 0xffff0000)
+=09=09=09dev =3D old_decode_dev(fs32 & 0x7fff);
+=09=09else
+=09=09=09dev =3D MKDEV(sysv_major(fs32), sysv_minor(fs32));
+=09=09break;
+
+=09default:
+=09=09dev =3D old_decode_dev(fs32);
+=09=09break;
+=09}
+=09return dev;
+}
+
+static inline void
+ufs_set_inode_dev(struct super_block *sb, struct ufs_inode_info *ufsi, dev=
_t dev)
+{
+=09__fs32 fs32;
+
+=09switch (UFS_SB(sb)->s_flags & UFS_ST_MASK) {
+=09case UFS_ST_SUNx86:
+=09case UFS_ST_SUN:
+=09=09fs32 =3D sysv_encode_dev(dev);
+=09=09if ((fs32 & 0xffff8000) =3D=3D 0) {
+=09=09=09fs32 =3D old_encode_dev(dev);
+=09=09}
+=09=09break;
+
+=09default:
+=09=09fs32 =3D old_encode_dev(dev);
+=09=09break;
+=09}
+=09fs32 =3D cpu_to_fs32(sb, fs32);
+=09if ((UFS_SB(sb)->s_flags & UFS_ST_MASK) =3D=3D UFS_ST_SUNx86)
+=09=09ufsi->i_u1.i_data[1] =3D fs32;
+=09else
+=09=09ufsi->i_u1.i_data[0] =3D fs32;
+}
=20
 /*
  * These functions manipulate ufs buffers

------=_Part_388_7762230.1098094816873--
