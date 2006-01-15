Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWAOTs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWAOTs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWAOTs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:48:56 -0500
Received: from ns.dn.farlep.net ([213.130.10.10]:48906 "EHLO dn.farlep.net")
	by vger.kernel.org with ESMTP id S932117AbWAOTsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:48:55 -0500
Posted-Date: Sun, 15 Jan 2006 21:48:43 +0200 (EET)
X-Sagator-id: 20060115-214842-0001-67689-BruVdf
Date: Sun, 15 Jan 2006 21:48:38 +0200
From: "Vitaly V. Bursov" <vitalyb@telenet.dn.ua>
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.15.1 ppp_async panic on x86-64.
Message-Id: <20060115214838.2034a56c.vitalyb@telenet.dn.ua>
Organization: Telenet
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__15_Jan_2006_21_48_38_+0200_/ZFhhTNhiYC2k6O3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__15_Jan_2006_21_48_38_+0200_/ZFhhTNhiYC2k6O3
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

PPP doesn't work for me on a x86-64 kernel. Kernel panics with a message

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dcut: dmesg
Jan 15 20:24:12 vb skb_over_panic: text:ffffffff886700d9 len:1 put:1
head:ffff81002b7ed000 data:ffff81012b7ed000 tail:ffff81012b7ed001
end:ffff81002b7ed600 dev:<NULL>
Jan 15 20:24:12 vb ----------- [cut here ] --------- [please bite here ] --=
-------
Jan 15 20:24:12 vb Kernel BUG at net/core/skbuff.c:94
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dcut
note the "tail" and "end" difference:
0xffff81012b7ed001-0xffff81002b7ed600 =3D 0xfffffa01


It looks like that problem is caused by this peace of code.
At least it works better after commenting out "skb_reserve" line.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dcut: ppp_async.c
 err:
        /* frame had an error, remember that, reset SC_TOSS & SC_ESCAPE */
        ap->state =3D SC_PREV_ERROR;
        if (skb) {
                /* make skb appear as freshly allocated */
                skb_trim(skb, 0);
                skb_reserve(skb, - skb_headroom(skb));
        }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dcut

skb_headroom returns 32bit "int", skb_reserve takes 32bit "unsigned int" and
adds it to a 64bit pointer, which is bad.

I'm not at the list.
--=20
Thank you,
Vitaly                                                              DON'T P=
ANIC
GPG Key ID: F95A23B9

--Signature=_Sun__15_Jan_2006_21_48_38_+0200_/ZFhhTNhiYC2k6O3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDyqca73PAj/laI7kRAuvbAJ4nDW5KrNbnmpSek/RkUr00vrgaJgCglQai
wpV6fiecr5g7lv705CJKnKs=
=8QQr
-----END PGP SIGNATURE-----

--Signature=_Sun__15_Jan_2006_21_48_38_+0200_/ZFhhTNhiYC2k6O3--
