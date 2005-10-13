Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVJMVoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVJMVoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJMVoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:44:04 -0400
Received: from mout0.freenet.de ([194.97.50.131]:20972 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1750724AbVJMVoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:44:01 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: James Ketrenos <jketreno@linux.intel.com>
Subject: [PATCH ieee80211] fix TX skb allocation flags and size
Date: Thu, 13 Oct 2005 23:41:56 +0200
User-Agent: KMail/1.8
Cc: ieee80211-devel@lists.sourceforge.net, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200510132341.56670.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart4577988.99A1yZym5K";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4577988.99A1yZym5K
Content-Type: multipart/mixed;
  boundary="Boundary-01=_kStTDW+qoLTfd7j"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_kStTDW+qoLTfd7j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ieee80211 subsystem:
* Use GFP mask on TX skb allocation.
* Allocate TX skb memory DMA mappable.
* Use the tx_headroom and reserve requested space.

=2D-- linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c.orig 2005-10-13 22=
:45:13.000000000 +0200
+++ linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c 2005-10-13 22:56:43.=
000000000 +0200
@@ -207,7 +207,7 @@ void ieee80211_txb_free(struct ieee80211
 }
=20
 static struct ieee80211_txb *ieee80211_alloc_txb(int nr_frags, int txb_siz=
e,
=2D       gfp_t gfp_mask)
+       int headroom, gfp_t gfp_mask)
 {
  struct ieee80211_txb *txb;
  int i;
@@ -221,11 +221,13 @@ static struct ieee80211_txb *ieee80211_a
  txb->frag_size =3D txb_size;
=20
 	for (i =3D 0; i < nr_frags; i++) {
=2D		txb->fragments[i] =3D dev_alloc_skb(txb_size);
+		txb->fragments[i] =3D __dev_alloc_skb(txb_size + headroom,
+						    gfp_mask | GFP_DMA);
 		if (unlikely(!txb->fragments[i])) {
 			i--;
    break;
   }
+  skb_reserve(txb->fragments[i], headroom);
  }
  if (unlikely(i !=3D nr_frags)) {
   while (i >=3D 0)
@@ -350,7 +352,8 @@ int ieee80211_xmit(struct sk_buff *skb,=20
  /* When we allocate the TXB we allocate enough space for the reserve
   * and full fragment bytes (bytes_per_frag doesn't include prefix,
   * postfix, header, FCS, etc.) */
=2D txb =3D ieee80211_alloc_txb(nr_frags, frag_size, GFP_ATOMIC);
+ txb =3D ieee80211_alloc_txb(nr_frags, frag_size,
+      ieee->tx_headroom, GFP_ATOMIC);
  if (unlikely(!txb)) {
   printk(KERN_WARNING "%s: Could not allocate TXB\n",
          ieee->dev->name);

Signed-off-by: Michael Buesch <mbuesch@freenet.de>

=2D-=20
Greetings Michael.

--Boundary-01=_kStTDW+qoLTfd7j
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ieee80211_fix_flags_and_size.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ieee80211_fix_flags_and_size.diff"

ieee80211 subsystem:
* Use GFP mask on TX skb allocation.
* Allocate TX skb memory DMA mappable.
* Use the tx_headroom and reserve requested space.

=2D-- linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c.orig	2005-10-13 22=
:45:13.000000000 +0200
+++ linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c	2005-10-13 22:56:43.=
000000000 +0200
@@ -207,7 +207,7 @@ void ieee80211_txb_free(struct ieee80211
 }
=20
 static struct ieee80211_txb *ieee80211_alloc_txb(int nr_frags, int txb_siz=
e,
=2D						 gfp_t gfp_mask)
+						 int headroom, gfp_t gfp_mask)
 {
 	struct ieee80211_txb *txb;
 	int i;
@@ -221,11 +221,13 @@ static struct ieee80211_txb *ieee80211_a
 	txb->frag_size =3D txb_size;
=20
 	for (i =3D 0; i < nr_frags; i++) {
=2D		txb->fragments[i] =3D dev_alloc_skb(txb_size);
+		txb->fragments[i] =3D __dev_alloc_skb(txb_size + headroom,
+						    gfp_mask | GFP_DMA);
 		if (unlikely(!txb->fragments[i])) {
 			i--;
 			break;
 		}
+		skb_reserve(txb->fragments[i], headroom);
 	}
 	if (unlikely(i !=3D nr_frags)) {
 		while (i >=3D 0)
@@ -350,7 +352,8 @@ int ieee80211_xmit(struct sk_buff *skb,=20
 	/* When we allocate the TXB we allocate enough space for the reserve
 	 * and full fragment bytes (bytes_per_frag doesn't include prefix,
 	 * postfix, header, FCS, etc.) */
=2D	txb =3D ieee80211_alloc_txb(nr_frags, frag_size, GFP_ATOMIC);
+	txb =3D ieee80211_alloc_txb(nr_frags, frag_size,
+				  ieee->tx_headroom, GFP_ATOMIC);
 	if (unlikely(!txb)) {
 		printk(KERN_WARNING "%s: Could not allocate TXB\n",
 		       ieee->dev->name);

Signed-off-by: Michael Buesch <mbuesch@freenet.de>

--Boundary-01=_kStTDW+qoLTfd7j--

--nextPart4577988.99A1yZym5K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDTtSklb09HEdWDKgRAvi/AKCwI2lJglpdTjkooVqTX/mdC2NjtwCeM1gq
kOR0IvsfJC8lTGATF7NMkM4=
=2yIx
-----END PGP SIGNATURE-----

--nextPart4577988.99A1yZym5K--
