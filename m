Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSCLXNN>; Tue, 12 Mar 2002 18:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSCLXMT>; Tue, 12 Mar 2002 18:12:19 -0500
Received: from [217.79.102.244] ([217.79.102.244]:8189 "EHLO
	monkey.beezly.org.uk") by vger.kernel.org with ESMTP
	id <S289191AbSCLXLI>; Tue, 12 Mar 2002 18:11:08 -0500
Subject: Dropped packets on SUN GEM
From: Beezly <beezly@beezly.org.uk>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-96E9w+s5VLkz7R0Ml+qW"
X-Mailer: Evolution/1.0.2 
Date: 12 Mar 2002 23:11:04 +0000
Message-Id: <1015974664.2652.10.camel@monkey>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-96E9w+s5VLkz7R0Ml+qW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi David,

I've been running some more tests on the GEM card. It seems to be
recovering from the RX hangs ok, but when I ping another host on the
network (with a .1s interval).. I get the following


monkey:/home/andy# ping -s 1472 -i .1 10.0.0.15
PING 10.0.0.15 (10.0.0.15) from 10.0.0.12 : 1472(1500) bytes of data.
1480 bytes from 10.0.0.15: icmp_seq=3D1 ttl=3D255 time=3D0.586 ms
1480 bytes from 10.0.0.15: icmp_seq=3D2 ttl=3D255 time=3D0.554 ms
1480 bytes from 10.0.0.15: icmp_seq=3D3 ttl=3D255 time=3D0.561 ms
1480 bytes from 10.0.0.15: icmp_seq=3D4 ttl=3D255 time=3D0.565 ms
<snip>
1480 bytes from 10.0.0.15: icmp_seq=3D570 ttl=3D255 time=3D0.557 ms
1480 bytes from 10.0.0.15: icmp_seq=3D571 ttl=3D255 time=3D0.550 ms
1480 bytes from 10.0.0.15: icmp_seq=3D572 ttl=3D255 time=3D0.558 ms
1480 bytes from 10.0.0.15: icmp_seq=3D573 ttl=3D255 time=3D0.552 ms
1480 bytes from 10.0.0.15: icmp_seq=3D574 ttl=3D255 time=3D0.558 ms
1480 bytes from 10.0.0.15: icmp_seq=3D575 ttl=3D255 time=3D0.570 ms
1480 bytes from 10.0.0.15: icmp_seq=3D590 ttl=3D255 time=3D0.565 ms
1480 bytes from 10.0.0.15: icmp_seq=3D591 ttl=3D255 time=3D0.562 ms
1480 bytes from 10.0.0.15: icmp_seq=3D592 ttl=3D255 time=3D0.567 ms
1480 bytes from 10.0.0.15: icmp_seq=3D593 ttl=3D255 time=3D0.526 ms
1480 bytes from 10.0.0.15: icmp_seq=3D594 ttl=3D255 time=3D0.560 ms
1480 bytes from 10.0.0.15: icmp_seq=3D595 ttl=3D255 time=3D0.562 ms

notice the missing 14 packets.

Now, if I reproduce the test with a .2s interval between pings, I get
the following results.

monkey:/home/andy# ping -s 1472 -i .2 10.0.0.15
PING 10.0.0.15 (10.0.0.15) from 10.0.0.12 : 1472(1500) bytes of data.
1480 bytes from 10.0.0.15: icmp_seq=3D1 ttl=3D255 time=3D0.645 ms
1480 bytes from 10.0.0.15: icmp_seq=3D2 ttl=3D255 time=3D0.578 ms
1480 bytes from 10.0.0.15: icmp_seq=3D3 ttl=3D255 time=3D0.592 ms
1480 bytes from 10.0.0.15: icmp_seq=3D4 ttl=3D255 time=3D0.585 ms
1480 bytes from 10.0.0.15: icmp_seq=3D5 ttl=3D255 time=3D0.575 ms
1480 bytes from 10.0.0.15: icmp_seq=3D6 ttl=3D255 time=3D0.577 ms
<snip>
1480 bytes from 10.0.0.15: icmp_seq=3D292 ttl=3D255 time=3D0.564 ms
1480 bytes from 10.0.0.15: icmp_seq=3D293 ttl=3D255 time=3D0.559 ms
1480 bytes from 10.0.0.15: icmp_seq=3D294 ttl=3D255 time=3D0.568 ms
1480 bytes from 10.0.0.15: icmp_seq=3D295 ttl=3D255 time=3D0.561 ms
1480 bytes from 10.0.0.15: icmp_seq=3D310 ttl=3D255 time=3D0.588 ms
1480 bytes from 10.0.0.15: icmp_seq=3D311 ttl=3D255 time=3D0.568 ms
1480 bytes from 10.0.0.15: icmp_seq=3D312 ttl=3D255 time=3D0.572 ms
1480 bytes from 10.0.0.15: icmp_seq=3D313 ttl=3D255 time=3D0.576 ms
1480 bytes from 10.0.0.15: icmp_seq=3D314 ttl=3D255 time=3D0.569 ms

notice, 14 missing packets again.=20

I'm pretty confident (as confident I can be whilst doing a "watch -n1
ifconfig"!) that it's doing this *during* the RX hang recovery, so it
appears that the RX hang recovery is taking 15 packets-worth of time,
rather than a set period of time (as I would expect - incorrectly?).=20

Is this normal? - Because it seems the amount of time to recover from a
hang is inversely proportional to the amount of work it is doing, I am
able to artificially improve the "uptime" of the card by permanantly
running a ping -f <host> on the box!!

Cheers,

Beezly



--=-96E9w+s5VLkz7R0Ml+qW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8josIXu4ZFsMQjPgRAjmrAJ9eC9kp8ti15WYJNYvXfpt6hfT15QCdHnJi
GguywQp2HNacs84jU/roqJs=
=xpx+
-----END PGP SIGNATURE-----

--=-96E9w+s5VLkz7R0Ml+qW--
