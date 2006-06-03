Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWFCSah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWFCSah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 14:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWFCSah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 14:30:37 -0400
Received: from master.altlinux.org ([62.118.250.235]:60175 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751766AbWFCSah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 14:30:37 -0400
Date: Sat, 3 Jun 2006 22:30:03 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       stable@kernel.org
Subject: Re: lock_kernel called under spinlock in NFS
Message-Id: <20060603223003.5665a426.vsu@altlinux.ru>
In-Reply-To: <20060602134346.73019624.akpm@osdl.org>
References: <20060601195535.GA28188@tsunami.ccur.com>
	<1149192820.3549.43.camel@lade.trondhjem.org>
	<20060602202436.GA4783@tsunami.ccur.com>
	<1149280078.5621.63.camel@lade.trondhjem.org>
	<20060602134346.73019624.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__3_Jun_2006_22_30_03_+0400_Wf0DwKt72PFseUOg"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__3_Jun_2006_22_30_03_+0400_Wf0DwKt72PFseUOg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Jun 2006 13:43:46 -0700 Andrew Morton wrote:

> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> >
> > On Fri, 2006-06-02 at 16:24 -0400, Joe Korty wrote:
> > > On Thu, Jun 01, 2006 at 04:13:39PM -0400, Trond Myklebust wrote:
> > > > On Thu, 2006-06-01 at 15:55 -0400, Joe Korty wrote:
> > > >> Tree 5fdccf2354269702f71beb8e0a2942e4167fd992
> > > >>=20
> > > >>         [PATCH] vfs: *at functions: core
> > > >>=20
> > > >> introduced a bug where lock_kernel() can be called from
> > > >> under a spinlock.  To trigger the bug one must have
> > > >> CONFIG_PREEMPT_BKL=3Dy and be using NFS heavily.  It is
> > > >> somewhat rare and, so far, haven't traced down the userland
> > > >> sequence that causes the fatal path to be taken.
> > > >>=20
> > > >> The bug was caused by the insertion into do_path_lookup()
> > > >> of a call to file_permission().  do_path_lookup()
> > > >> read-locks current->fs->lock for most of its operation.
> > > >> file_permission() calls permission() which calls
> > > >> nfs_permission(), which has one path through it
> > > >> that uses lock_kernel().
> > >=20
> > > > Nowhere should anyone be calling file_permission() under a spinlock.
> > > >=20
> > > > Why would you need to read-protect current->fs in the case where yo=
u are
> > > > starting from a file? The correct thing to do there would appear to=
 be
> > > > to read_protect only the cases where (*name=3D=3D'/') and (dfd =3D=
=3D AT_FDCWD).
> > > >=20
> > > > Something like the attached patch...
> > >=20
> > >=20
> > > Hi Trond,
> > > I've been running with the patch for the last few hours, on an nfs-ro=
oted
> > > system, and it has been working fine.  Any plans to submit this for 2=
.6.17?
> >=20
> > It probably ought to be, given the nature of the sin. Andrew?
> >=20
>=20
> OK.
>=20
> Just to confirm, this is final?
>=20
>=20
> From: Trond Myklebust <Trond.Myklebust@netapp.com>
>=20
> We're presently running lock_kernel() under fs_lock via nfs's ->permission
> handler.  That's a ranking bug and sometimes a sleep-in-spinlock bug.  Th=
is
> problem was introduced in the openat() patchset.
>=20
> We should not need to hold the current->fs->lock for a codepath that does=
n't
> use current->fs.
>=20
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> Cc: Al Viro <viro@ftp.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>=20
>  fs/namei.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff -puN fs/namei.c~fs-nameic-call-to-file_permission-under-a-spinlock-i=
n-do_lookup_path fs/namei.c
> --- 25/fs/namei.c~fs-nameic-call-to-file_permission-under-a-spinlock-in-d=
o_lookup_path	Fri Jun  2 13:39:52 2006
> +++ 25-akpm/fs/namei.c	Fri Jun  2 13:39:52 2006
> @@ -1080,8 +1080,8 @@ static int fastcall do_path_lookup(int d
>  	nd->flags =3D flags;
>  	nd->depth =3D 0;
> =20
> -	read_lock(&current->fs->lock);
>  	if (*name=3D=3D'/') {
> +		read_lock(&current->fs->lock);
>  		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
>  			nd->mnt =3D mntget(current->fs->altrootmnt);
>  			nd->dentry =3D dget(current->fs->altroot);
> @@ -1092,9 +1092,12 @@ static int fastcall do_path_lookup(int d
>  		}
>  		nd->mnt =3D mntget(current->fs->rootmnt);
>  		nd->dentry =3D dget(current->fs->root);
> +		read_unlock(&current->fs->lock);
>  	} else if (dfd =3D=3D AT_FDCWD) {
> +		read_lock(&current->fs->lock);
>  		nd->mnt =3D mntget(current->fs->pwdmnt);
>  		nd->dentry =3D dget(current->fs->pwd);
> +		read_unlock(&current->fs->lock);
>  	} else {
>  		struct dentry *dentry;
> =20
> @@ -1118,7 +1121,6 @@ static int fastcall do_path_lookup(int d
> =20
>  		fput_light(file, fput_needed);
>  	}
> -	read_unlock(&current->fs->lock);
>  	current->total_link_count =3D 0;
>  	retval =3D link_path_walk(name, nd);
>  out:

1) This bug is also present in the 2.6.16 tree.

2) The patch above is broken - it needs the fix below (or the fix should
be folded into the patch directly):

--------------------------------------------------------------------

Fix do_path_lookup() failure path after locking changes

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 fs/namei.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a2f79d2..d6e2ee2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1104,17 +1104,17 @@ static int fastcall do_path_lookup(int d
 		file =3D fget_light(dfd, &fput_needed);
 		retval =3D -EBADF;
 		if (!file)
-			goto unlock_fail;
+			goto out_fail;
=20
 		dentry =3D file->f_dentry;
=20
 		retval =3D -ENOTDIR;
 		if (!S_ISDIR(dentry->d_inode->i_mode))
-			goto fput_unlock_fail;
+			goto fput_fail;
=20
 		retval =3D file_permission(file, MAY_EXEC);
 		if (retval)
-			goto fput_unlock_fail;
+			goto fput_fail;
=20
 		nd->mnt =3D mntget(file->f_vfsmnt);
 		nd->dentry =3D dget(dentry);
@@ -1129,13 +1129,12 @@ out:
 				nd->dentry->d_inode))
 		audit_inode(name, nd->dentry->d_inode, flags);
 	}
+out_fail:
 	return retval;
=20
-fput_unlock_fail:
+fput_fail:
 	fput_light(file, fput_needed);
-unlock_fail:
-	read_unlock(&current->fs->lock);
-	return retval;
+	goto out_fail;
 }
=20
 int fastcall path_lookup(const char *name, unsigned int flags,
--=20
1.3.3.g3d95c



--Signature=_Sat__3_Jun_2006_22_30_03_+0400_Wf0DwKt72PFseUOg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEgdUyW82GfkQfsqIRAnesAJ9tWm0DJdyl4q4OcNdkNa+xCtEihgCglglC
wThcUki+FU4nmdJuhkA0kas=
=B/PC
-----END PGP SIGNATURE-----

--Signature=_Sat__3_Jun_2006_22_30_03_+0400_Wf0DwKt72PFseUOg--
