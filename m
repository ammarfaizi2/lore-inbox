Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWCAOWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWCAOWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWCAOWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:22:49 -0500
Received: from smtp04.auna.com ([62.81.186.14]:31165 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S932216AbWCAOWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:22:49 -0500
Date: Wed, 1 Mar 2006 15:22:46 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060301152246.77c24ae8@werewolf.auna.net>
In-Reply-To: <20060301023235.735c8c47.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs86 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_M6MTYVaF7E7UmJYBGLlzyOP;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Wed, 1 Mar 2006 15:22:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_M6MTYVaF7E7UmJYBGLlzyOP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Mar 2006 02:32:35 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> Useful, thanks.  So the second batch of /proc patches are indeed the prob=
lem.
>=20
> If you have (even more) time you could test
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz.=20
> That's the latest of everything with the problematic sysfs patches revert=
ed
> and Eric's recent /proc fixes.
>=20

I just tried rc5-mm1 and this. With this I can run java apps/applets again
without locking my system.=20

I also applied the patch you posted for inotify, but now I get this new one:

Mar  1 15:11:04 werewolf kernel: [ 1424.891482] BUG: warning at fs/inotify.=
c:410/set_dentry_child_flags()
Mar  1 15:11:04 werewolf kernel: [ 1424.891494]  <b0177dae> set_dentry_chil=
d_flags+0x10b/0x113   <b0178109> remove_watch_no_event+0x138/0x171
Mar  1 15:11:04 werewolf kernel: [ 1424.891545]  <b0178195> inotify_release=
+0x53/0x193   <b01556fa> __fput+0x91/0x181
Mar  1 15:11:04 werewolf kernel: [ 1424.891578]  <b0152e37> filp_close+0x3e=
/0x62   <b0146011> exit_mmap+0xc5/0x116
Mar  1 15:11:04 werewolf kernel: [ 1424.891619]  <b011b297> put_files_struc=
t+0x8b/0xf8   <b011c2ee> do_exit+0x152/0x8c0
Mar  1 15:11:04 werewolf kernel: [ 1424.891660]  <b011ca85> do_group_exit+0=
x29/0x72   <b01256dd> get_signal_to_deliver+0x27c/0x42a
Mar  1 15:11:04 werewolf kernel: [ 1424.891686]  <b01025fc> do_notify_resum=
e+0x1a0/0x670   <b02a83d4> unix_sock_destructor+0x7a/0x10a
Mar  1 15:11:04 werewolf kernel: [ 1424.891721]  <b02a6e25> unix_release_so=
ck+0x237/0x26f   <b0158742> invalidate_inode_buffers+0xa/0x53
Mar  1 15:11:04 werewolf kernel: [ 1424.891748]  <b016b01d> destroy_inode+0=
x28/0x37   <b0130383> sys_futex+0xcc/0x122
Mar  1 15:11:04 werewolf kernel: [ 1424.891781]  <b0102c92> work_notifysig+=
0x13/0x19 =20

It looks like there are couple more WARN_ONs spread over inotify.c.
Full patch:

--- devel/fs/inotify.c~a	2006-03-01 02:47:01.000000000 -0800
+++ devel-akpm/fs/inotify.c	2006-03-01 02:47:06.000000000 -0800
@@ -402,12 +402,8 @@
 		list_for_each_entry(child, &alias->d_subdirs, d_u.d_child) {
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

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam14 (gcc 4.0.3 (4.0.3-0.20060215.2mdk for Mandriva Linux rel=
ease 2006.1))

--Sig_M6MTYVaF7E7UmJYBGLlzyOP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEBa42RlIHNEGnKMMRAjfIAJ9idA2rjBvqyX6RLuSwCdWeq7rz/ACcCyO/
3ObxpB1EkITWSz4dbzj5Bgc=
=SEIU
-----END PGP SIGNATURE-----

--Sig_M6MTYVaF7E7UmJYBGLlzyOP--
