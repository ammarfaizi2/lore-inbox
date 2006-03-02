Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWCBVLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWCBVLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWCBVLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:11:08 -0500
Received: from smtp05.auna.com ([62.81.186.15]:10117 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S932551AbWCBVLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:11:06 -0500
Date: Thu, 2 Mar 2006 22:11:02 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060302221102.2814c07a@werewolf.auna.net>
In-Reply-To: <20060301205138.12ec91b1.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<20060301152246.77c24ae8@werewolf.auna.net>
	<20060301205138.12ec91b1.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs92 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_9d0bK/1fH=wiBi12/dad=4m";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Thu, 2 Mar 2006 22:11:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_9d0bK/1fH=wiBi12/dad=4m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Mar 2006 20:51:38 -0800, Andrew Morton <akpm@osdl.org> wrote:

> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On Wed, 1 Mar 2006 02:32:35 -0800, Andrew Morton <akpm@osdl.org> wrote:
> >=20
> >  >=20
> >  > Useful, thanks.  So the second batch of /proc patches are indeed the=
 problem.
> >  >=20
> >  > If you have (even more) time you could test
> >  > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.=
gz.=20
> >  > That's the latest of everything with the problematic sysfs patches r=
everted
> >  > and Eric's recent /proc fixes.
> >  >=20
> >=20
> >  I just tried rc5-mm1 and this. With this I can run java apps/applets a=
gain
> >  without locking my system.=20
> >=20
> >  I also applied the patch you posted for inotify, but now I get this ne=
w one:
> >=20
> >  Mar  1 15:11:04 werewolf kernel: [ 1424.891482] BUG: warning at fs/ino=
tify.c:410/set_dentry_child_flags()
>=20
> Which patch was that?  The first one was doubly broken.
>=20
> This is closer.
>=20
> diff -puN fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-=
dentry-fix fs/dcache.c
> --- devel/fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-=
dentry-fix	2006-03-01 12:16:22.000000000 -0800
> +++ devel-akpm/fs/dcache.c	2006-03-01 12:18:34.000000000 -0800
> @@ -100,6 +100,7 @@ static void dentry_iput(struct dentry *=20
>  	if (inode) {
>  		dentry->d_inode =3D NULL;
>  		list_del_init(&dentry->d_alias);
> +		dentry->d_flags &=3D ~DCACHE_INOTIFY_PARENT_WATCHED;
>  		spin_unlock(&dentry->d_lock);
>  		spin_unlock(&dcache_lock);
>  		if (!inode->i_nlink)
> _
>=20
>=20

What I have collected till now is below (against -mm2-pre1). What is
(not) needed from this ? Thanks...

--- devel/fs/inotify.c~a	2006-03-01 02:47:01.000000000 -0800
+++ devel-akpm/fs/inotify.c	2006-03-01 02:47:06.000000000 -0800
@@ -390,6 +390,7 @@ static inline int inotify_inode_watched(
=20
 /*
  * Get child dentry flag into synch with parent inode.
+ * Flag should always be clear for negative dentrys.
  */
 static void set_dentry_child_flags(struct inode *inode, int watched)
 {
@@ -400,14 +401,14 @@ static void set_dentry_child_flags(struc
 		struct dentry *child;
=20
 		list_for_each_entry(child, &alias->d_subdirs, d_u.d_child) {
+			if (!child->d_inode) {
+				WARN_ON(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
+				continue;
+			}
 			spin_lock(&child->d_lock);
 			if (watched) {
-				WARN_ON(child->d_flags &
-						DCACHE_INOTIFY_PARENT_WATCHED);
 				child->d_flags |=3D DCACHE_INOTIFY_PARENT_WATCHED;
 			} else {
-				WARN_ON(!(child->d_flags &
-					DCACHE_INOTIFY_PARENT_WATCHED));
 				child->d_flags&=3D~DCACHE_INOTIFY_PARENT_WATCHED;
 			}
 			spin_unlock(&child->d_lock);
@@ -530,7 +530,6 @@ void inotify_d_instantiate(struct dentry
 	if (!inode)
 		return;
=20
-	WARN_ON(entry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
 	spin_lock(&entry->d_lock);
 	parent =3D entry->d_parent;
 	if (inotify_inode_watched(parent->d_inode))
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -100,6 +100,7 @@ static void dentry_iput(struct dentry *=20
 	if (inode) {
 		dentry->d_inode =3D NULL;
 		list_del_init(&dentry->d_alias);
+		dentry->d_flags &=3D ~DCACHE_INOTIFY_PARENT_WATCHED;
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
 		if (!inode->i_nlink)
@@ -1203,6 +1204,9 @@ void d_delete(struct dentry * dentry)
 	spin_lock(&dentry->d_lock);
 	isdir =3D S_ISDIR(dentry->d_inode->i_mode);
 	if (atomic_read(&dentry->d_count) =3D=3D 1) {
+		/* remove this and other inotify debug checks after 2.6.18 */
+		dentry->d_flags &=3D ~DCACHE_INOTIFY_PARENT_WATCHED;
+
 		dentry_iput(dentry);
 		fsnotify_nameremove(dentry, isdir);
 		return;



--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam14 (gcc 4.0.3 (4.0.3-0.20060215.2mdk for Mandriva Linux rel=
ease 2006.1))

--Sig_9d0bK/1fH=wiBi12/dad=4m
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEB19mRlIHNEGnKMMRAmnNAJsHd1rMUrauJZo3SS5Daf+Bs+uJ8QCfWoxJ
sqx4EFuVnWonUoaOMlonNyY=
=xvhB
-----END PGP SIGNATURE-----

--Sig_9d0bK/1fH=wiBi12/dad=4m--
