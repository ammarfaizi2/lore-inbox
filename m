Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVJMXSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVJMXSU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 19:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVJMXSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 19:18:20 -0400
Received: from mout2.freenet.de ([194.97.50.155]:47495 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932540AbVJMXST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 19:18:19 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: James Ketrenos <jketreno@linux.intel.com>
Subject: Re: [PATCH ieee80211] fix TX skb allocation flags and size
Date: Fri, 14 Oct 2005 01:17:21 +0200
User-Agent: KMail/1.8
References: <200510132341.56670.mbuesch@freenet.de> <434EE7FB.9010506@pobox.com>
In-Reply-To: <434EE7FB.9010506@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, ieee80211-devel@lists.sourceforge.net,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4143748.Ar5zJg6VLC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510140117.21636.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4143748.Ar5zJg6VLC
Content-Type: multipart/mixed;
  boundary="Boundary-01=_BsuTD8wnxR6HK5J"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_BsuTD8wnxR6HK5J
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 14 October 2005 01:04, you wrote:
> Michael Buesch wrote:
> > @@ -221,11 +221,13 @@ static struct ieee80211_txb *ieee80211_a
> >   txb->frag_size =3D txb_size;
> > =20
> >   for (i =3D 0; i < nr_frags; i++) {
> > -  txb->fragments[i] =3D dev_alloc_skb(txb_size);
> > +  txb->fragments[i] =3D __dev_alloc_skb(txb_size + headroom,
> > +          gfp_mask | GFP_DMA);
> >    if (unlikely(!txb->fragments[i])) {
> >     i--;
>=20
> Very wrong.  GFP_DMA means ISA DMA.
>=20
> See pci_map_xxx() and other DMA API functions.

Ok, the size issue is still valid and the real reason for doing this patch.
Please apply this:


ieee80211: Use tx_headroom

=2D-- linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c.orig 2005-10-13 22=
:45:13.000000000 +0200
+++ linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c 2005-10-14 01:11:29.=
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
=2D  txb->fragments[i] =3D dev_alloc_skb(txb_size);
+  txb->fragments[i] =3D __dev_alloc_skb(txb_size + headroom,
+          gfp_mask);
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

--Boundary-01=_BsuTD8wnxR6HK5J
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ieee80211_fix_txskb_size.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ieee80211_fix_txskb_size.diff"

ieee80211: Use tx_headroom

=2D-- linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c.orig	2005-10-13 22=
:45:13.000000000 +0200
+++ linux-2.6.14-rc4-git2/net/ieee80211/ieee80211_tx.c	2005-10-14 01:11:29.=
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
+						    gfp_mask);
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

--Boundary-01=_BsuTD8wnxR6HK5J--

--nextPart4143748.Ar5zJg6VLC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDTusBlb09HEdWDKgRAigPAJ9NeEXd9ZnFu9j2uFAQzdbmSlWf2wCgoSEk
f3mbJHNpqLYOiC+Q/pil5Jw=
=rKgU
-----END PGP SIGNATURE-----

--nextPart4143748.Ar5zJg6VLC--
