Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVEHOfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVEHOfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 10:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVEHOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 10:35:36 -0400
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:46568 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S262874AbVEHOfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 10:35:19 -0400
Date: Sun, 8 May 2005 10:32:59 -0400
From: Stuffed Crust <pizza@shaftnet.org>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix long-standing bug in 2.6/2.4 skb_copy/skb_copy_expand
Message-ID: <20050508143259.GA30676@shaftnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-milter-date-PASS: YES
X-milter-7bit-Pass: YES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>

This patch tweaks the skb_copy_bits() call in skb_copy() and=20
skb_copy_expand().  In the sace of skb_copy():

if (skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len))

Basically, this call assumes that n->head+headerlen =3D=3D n->data.

This is, fortunately, generally true.  But if the alloc_skb function=20
allocates extra head room (ie calls skb_reserve() on the skb before it=20
passes it to the callee, this doesn't quite work.  Instead, it should be=20
rewritten as:

if (skb_copy_bits(skb, -headerlen, n->data-headerlen, headerlen + skb->len))

Rewriting it this way works; n->data-headerlen is equal to n->data=20
before the skb_reserve() call.  This seems MoreCorrect(tm), as it makes=20
no assumptions about the state of the skb passed into it.  (n->data just=20
so happens to equal n->head too)

skb_copy_expand() has the same problem as well, and has a similar fix.

This patch is against 2.6.12-rc4, though it should apply cleanly to any=20
2.4/2.6 kernel.

=2E..

The history behind this is a little sordid -- We were trying to
implement a "poor man's zerocopy" transmit path for a braindead USB
wireless controller.  It needed a descriptor packet prepended to the
frame contents, but couldn't handle it in a separate USB packet -- so
we'd have to do a realloc on the skb to give us the headroom we eneded.=20
memcpy()s on the very underpowered target were expensive, so we tried
modifying skb_alloc to always ensure there would be enough headroom for
the descriptor (allocating extra, and then skb_reserve()ing it).  It was
a crude hack, but it gained us a few much-needed percentage points of
throughput.  That is once we fixed skb_copy()..

Anyway, please consider this patch for inclusion.=20

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					 JID: pitha@myjabber.net
Quidquid latine dictum sit, altum viditur

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="skb_copy_fixes.diff"
Content-Transfer-Encoding: quoted-printable

--- /linux/net/core/skbuff.c	2005-05-08 09:57:37.000000000 -0400
+++ skbuff.c	2005-05-08 10:27:17.000000000 -0400
@@ -486,7 +486,7 @@
 	n->csum	     =3D skb->csum;
 	n->ip_summed =3D skb->ip_summed;
=20
-	if (skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len))
+	if (skb_copy_bits(skb, -headerlen, n->data-headerlen, headerlen + skb->le=
n))
 		BUG();
=20
 	copy_skb_header(n, skb);
@@ -680,7 +680,7 @@
 		head_copy_off =3D newheadroom - head_copy_len;
=20
 	/* Copy the linear header and data. */
-	if (skb_copy_bits(skb, -head_copy_len, n->head + head_copy_off,
+	if (skb_copy_bits(skb, -head_copy_len, n->data-newheadroom + head_copy_of=
f,
 			  skb->len + head_copy_len))
 		BUG();
=20

--IS0zKkzwUGydFO0o--

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCfiMbPuLgii2759ARAv3LAKC73SZw03bGQBGWXhWK6+bIZJpjRQCfSgI/
dktrg/ZcP143Jpai3KHvvRM=
=fRL8
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
