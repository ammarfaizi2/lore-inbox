Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSJWOKu>; Wed, 23 Oct 2002 10:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSJWOKt>; Wed, 23 Oct 2002 10:10:49 -0400
Received: from cpe-66-1-217-65.fl.sprintbbd.net ([66.1.217.65]:18948 "EHLO
	chef.linux-wlan.com") by vger.kernel.org with ESMTP
	id <S265019AbSJWOKs>; Wed, 23 Oct 2002 10:10:48 -0400
Date: Wed, 23 Oct 2002 10:16:51 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
To: "David S. Miller" <davem@rth.ninka.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New ARPHRD types
Message-ID: <20021023141651.GA6644@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com> <1035330936.16084.23.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <1035330936.16084.23.camel@rth.ninka.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2002 at 04:55:36PM -0700, David S. Miller wrote:
> If ARPHRD_IEEE80211 assumes 24 bytes, and like you say it shouldn't,
> fix that bug instead.  Don't add new ARP header types just to put
> a bandaid on another bug.

Oh, I completely agree.  Unfortunately, the underlying problem is that
the IEEE 802.11 spec has a variable-length hardware header, and that's
not fixable, ruby slippers or no.

I admit that the 80211_FULL was the easy way out, so let me ramble on a
bit and perhaps you can correct and/or clue me in...

AFAIK, no driver currently exposes a native 802.11 interface to the os
(instead exposing ethernet and converting on the fly to 802.11). I'd
like to change this, eventually submitting an equivalent of the stuff in
net/ethernet/eth.c, perhaps as part of the wireless extensions. =20

hard_header_len is used on skb allocations to ensure we have enough
space for all of the various hardware headers without having to
reallocate/memcpy the skbs all over the place.

This would infer that we need to set hard_header_len to 30.  On a
transmit, we'd pre-allocate this skb, then pass it off to hard_header to
add in the hardware header, then pass it on to the hard_start_xmit call.
So in the case of "cooked" transmits, hard_header_len+hard_header() can
be anything they want to be, and the ARP type doesn't need to change.

Enter AF_PACKET, and things get messier.  According to the comments in
af_packet.c in 2.4.19, skb->mac.raw and skb->data are used for all
operations, both tx and rx, so they should be able to handle any header
length with no problems.

Now here's the crucual question.  Because of this variable-length
header, (skb->mac.raw - skb->data !=3D hard_header_len).  My understanding
was that this (at least used to) cause problems.  If this isn't the
case... then there's no reason to create a new ARPHRD type with a
max-fixed-length header. =20

Anyway, the native 802.11 OS interface is a ways off (mostly on paper
still), so there's plenty of time to work this out. =20

In the shorter run, do you have any objections to the creation of the
ARPHRD_IEEE80211_CAPTURE type?  (and if not, what's the final number?)

Thanks!

 - Pizza
--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
715-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tq9TgW9b/nAvdc4RAtdpAJ9Khie0Cl+XAp6cuWCIXyYe4xKFkQCeObD/
UuQgvZdewaOM8ZP941y+paY=
=6air
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
