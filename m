Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUAFTXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbUAFTXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:23:19 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:36757 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S264902AbUAFTXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:23:16 -0500
Date: Tue, 6 Jan 2004 20:23:07 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: (2.6 IPsec) tcpdump: "truncated-ip - 12 bytes missing!"
Message-ID: <20040106192307.GA9759@piper.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I've not been told off with IPsec questions, so here's another one.
Using the Kame tools, I managed to get a network-to-host tunnel set
up:
                   --------------------------       --------------
  10.1.2.0/24 --- | 10.1.2.1 gateway 4.5.6.7 | --- | 4.3.2.1 host |
                   --------------------------   ^   --------------
                                                |IPsec

In words: everything between the 4.3.2.1 host and the network
10.1.2.0/24 is encrypted, with the (masquerading) gateway and the
host serving as tunnel endpoints.

This is working with the following configuration on the gateway:

  add 4.5.6.7 4.3.2.1 ah 0x200 -m tunnel -A hmac-sha1 "key1";
  add 4.3.2.1 4.5.6.7 ah 0x300 -m tunnel -A hmac-sha1 "key2";

  add 4.5.6.7 4.3.2.1 esp 0x201 -m tunnel -E twofish-cbc "key3";
  add 4.3.2.1 4.5.6.7 esp 0x301 -m tunnel -E twofish-cbc "key4";

  spdadd 10.1.2.0/24 4.3.2.1 any -P out ipsec
    esp/tunnel/4.5.6.7-4.3.2.1/require
    ah/tunnel/4.5.6.7-4.3.2.1/require;

  spdadd 4.3.2.1 10.1.2.0/24 any -P in ipsec
    esp/tunnel/4.3.2.1-4.5.6.7/require
    ah/tunnel/4.3.2.1-4.5.6.7/require;

and the same on the single host, with the policies switched.

Connectivity is fine, but as I checked the packets arriving at the
single host with tcpdump, I was kinda startled and don't know
anymore what's going on. Here's the output of one timestep (they are
all at the same time), line by line:

 1. 4.5.6.7 > 4.3.2.1: AH(spi=3D0x00000200,seq=3D0xcd):
    4.5.6.7 > 4.3.2.1: ESP(spi=3D0x00000201,seq=3D0xcd)
    (DF) [tos 0x10]  (ipip-proto-4)

perfect! the packet arrived from the gateway, the AH and ESP SPIs
are what I told them to be.

 2. 4.5.6.7 > 4.3.2.1: AH(spi=3D0x45100080,seq=3D0x67be4000):
    4.5.6.7 > 4.3.2.1: ESP(spi=3D0x00000201,seq=3D0xcd)
    (DF) [tos 0x10]  (ipip-proto-4)

what's this? i only sent one packet, and even though the ESP SPI is
correct, the AH SPI is totally random. tcpdump now says:

    truncated-ip - 12 bytes missing!
    4.5.6.7 > 4.3.2.1: AH(spi=3D0x45100080,seq=3D0x67be4000):
    4.5.6.7 > 4.3.2.1: [|ip] (ipip-proto-4) (ipip-proto-4)

and then (a fraction of a second later):

 3. 4.3.2.1 > 4.5.6.7: AH(spi=3D0x00000300,seq=3D0xfc6):
    4.3.2.1 > 4.5.6.7: ESP(spi=3D0x00000301,seq=3D0xfc6)
    (DF) [tos 0x10]  (ipip-proto-4)

this is the answer, using the appropriate SPIs for AH and ESP.

So then, where did the second packet come from?

Thanks for any input!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
there is no place like ~

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+wsbIgvIgzMMSnURAsw+AKDVpm84VP+cozaX8Cee4Tm9J0dz+gCglHsE
hww9d+i5rauYnBm9WwMN1ME=
=zuM0
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
