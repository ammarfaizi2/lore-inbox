Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFOEld (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 00:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTFOEld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 00:41:33 -0400
Received: from iucha.net ([209.98.146.184]:53098 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S261852AbTFOEl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 00:41:29 -0400
Date: Sat, 14 Jun 2003 23:55:19 -0500
To: Linus Torvalds <torvalds@transmeta.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
Message-ID: <20030615045519.GE25303@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030615014221.GA25303@iucha.net> <Pine.LNX.4.44.0306141849290.20728-100000@home.transmeta.com> <20030615020055.GB25303@iucha.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eGwqSfc1DN4LzNjY"
Content-Disposition: inline
In-Reply-To: <20030615020055.GB25303@iucha.net>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eGwqSfc1DN4LzNjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2003 at 09:00:55PM -0500, Florin Iucha wrote:
> On Sat, Jun 14, 2003 at 06:58:26PM -0700, Linus Torvalds wrote:
> > Ok, that does look like the list poisoning. The poisoning uses 0x001001=
00
> > as the poison value, and that's the address that oopsed for you:
> [snip]=20
> > Florin, does it work for you if you remove the poisoning in=20
> > <linux/list.h>? (Just search for "POISON" and remove those lines).
> >=20
> > Trond, any ideas?
>=20
> I am compiling now 2.5.71 with Tron's patch
> (http://bugme.osdl.org/attachment.cgi?id=3D414&action=3Dview). If that
> does not fix it I will try without the poison.

Trond's patch fixes the problem. The box has been up an running for
three hours under normal usage (web, mail, nfs share browsing) it even
rebooted without problem.

florin

diff -u --recursive --new-file linux-2.5.71/net/sunrpc/rpc_pipe.c linux-2.5=
=2E71-fix_rpcpipe/net/sunrpc/rpc_pipe.c
--- linux-2.5.71/net/sunrpc/rpc_pipe.c	2003-06-11 19:24:29.000000000 -0700
+++ linux-2.5.71-fix_rpcpipe/net/sunrpc/rpc_pipe.c	2003-06-14 16:58:21.0000=
00000 -0700
@@ -472,30 +472,37 @@
 rpc_depopulate(struct dentry *parent)
 {
 	struct inode *dir =3D parent->d_inode;
-	HLIST_HEAD(head);
 	struct list_head *pos, *next;
-	struct dentry *dentry;
+	struct dentry *dentry, *dvec[10];
+	int n =3D 0;
=20
 	down(&dir->i_sem);
+repeat:
 	spin_lock(&dcache_lock);
 	list_for_each_safe(pos, next, &parent->d_subdirs) {
 		dentry =3D list_entry(pos, struct dentry, d_child);
+		spin_lock(&dentry->d_lock);
 		if (!d_unhashed(dentry)) {
 			dget_locked(dentry);
 			__d_drop(dentry);
-			hlist_add_head(&dentry->d_hash, &head);
-		}
+			spin_unlock(&dentry->d_lock);
+			dvec[n++] =3D dentry;
+			if (n =3D=3D ARRAY_SIZE(dvec))
+				break;
+		} else
+			spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
-	while (!hlist_empty(&head)) {
-		dentry =3D list_entry(head.first, struct dentry, d_hash);
-		/* Private list, so no dcache_lock needed and use __d_drop */
-		__d_drop(dentry);
-		if (dentry->d_inode) {
-			rpc_inode_setowner(dentry->d_inode, NULL);
-			simple_unlink(dir, dentry);
-		}
-		dput(dentry);
+	if (n) {
+		do {
+			dentry =3D dvec[--n];
+			if (dentry->d_inode) {
+				rpc_inode_setowner(dentry->d_inode, NULL);
+				simple_unlink(dir, dentry);
+			}
+			dput(dentry);
+		} while (n);
+		goto repeat;
 	}
 	up(&dir->i_sem);
 }

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--eGwqSfc1DN4LzNjY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6/w3NLPgdTuQ3+QRAgTeAJ4royVjBiyhjSYS7qrirUOuTAO6pgCfVHud
lXE1ATV0WWcFIZBnPvwxk24=
=BSDn
-----END PGP SIGNATURE-----

--eGwqSfc1DN4LzNjY--
