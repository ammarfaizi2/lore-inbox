Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTJTWEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTJTWEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:04:10 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:29894 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262864AbTJTWEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:04:00 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test8-mm1
Date: Tue, 21 Oct 2003 00:01:01 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201811.18310.schlicht@uni-mannheim.de> <20031020144836.331c4062.akpm@osdl.org>
In-Reply-To: <20031020144836.331c4062.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_ksFl/u3rQZn2u7y";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310210001.08761.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_ksFl/u3rQZn2u7y
Content-Type: multipart/mixed;
  boundary="Boundary-01=_dsFl/vYGfSfRo5V"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_dsFl/vYGfSfRo5V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 October 2003 23:48, Andrew Morton wrote:
> A colleague here has discovered that this crash is repeatable, but goes
> away when the radeon driver is disabled.
>
> Are you using that driver?

No, I'm not... I use the vesafb driver. Do you think disabling this could c=
ure=20
the Oops?

Btw. a similar Oops at the same place occours when the uhci-hcd module is=20
unloaded...

The attached patch prevents the kernel from Oopsing, so it seems some inode=
=20
lists are corrupted (NULL terminated!). Don't know how the FB driver could =
be=20
the reason...

Regards
   Thomas

--Boundary-01=_dsFl/vYGfSfRo5V
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="hack-invalidate_list.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="hack-invalidate_list.diff"

=2D-- linux-2.6.0-test8-mm1/fs/inode.c.orig	Mon Oct 20 20:52:26 2003
+++ linux-2.6.0-test8-mm1/fs/inode.c	Mon Oct 20 22:43:52 2003
@@ -292,14 +292,16 @@
 	int busy =3D 0, count =3D 0;
=20
 	next =3D head->next;
=2D	for (;;) {
=2D		struct list_head * tmp =3D next;
+	while (next !=3D head) {
 		struct inode * inode;
=2D
=2D		next =3D next->next;
=2D		if (tmp =3D=3D head)
+#if 1
+		if (!next) {
+			printk(KERN_ERR "Badness in invalidate_list() !\n");
 			break;
=2D		inode =3D list_entry(tmp, struct inode, i_list);
+		}
+#endif
+		inode =3D list_entry(next, struct inode, i_list);
+		next =3D next->next;
 		if (inode->i_sb !=3D sb)
 			continue;
 		invalidate_inode_buffers(inode);

--Boundary-01=_dsFl/vYGfSfRo5V--

--Boundary-03=_ksFl/u3rQZn2u7y
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lFskYAiN+WRIZzQRAql1AKCQ0xAdDINpDANJsfhyoeCYz/73rwCdF/Mn
B++kh++gSrj63mAscziiFJs=
=B76l
-----END PGP SIGNATURE-----

--Boundary-03=_ksFl/u3rQZn2u7y--
