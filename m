Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTJHUEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 16:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTJHUEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 16:04:15 -0400
Received: from chaos.ao.net ([65.205.176.185]:40320 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id S261758AbTJHUEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 16:04:13 -0400
Date: Wed, 8 Oct 2003 16:04:09 -0400
From: Dan Merillat <dmerillat@sequiam.com>
To: linux-kernel@vger.kernel.org
Subject: Nasty Oops in 2.6.0-test6 bind/SO_REUSEADDR
Message-ID: <20031008200409.GA2514@chaos.ao.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I can't provide a stacktrace because it hardlocks the system, but it's
trivial to reproduce.

Swap back and forth between apache2 and apache a few times, and it
hardlocks at bind.

=46rom what I copied down and backtraced we crash at tcp_v4_get_port +
0x378/390, which is in tcp_ipv4.c:194 (inline tcp_bind_conflict)

                struct inet_opt *inet2 =3D inet_sk(sk2);
                if (!inet2->rcv_saddr || !inet->rcv_saddr ||
                    inet2->rcv_saddr =3D=3D inet->rcv_saddr)
                    break;

     468:       0f b6 40 49             movzbl 0x49(%eax),%eax
     46c:       83 e0 20                and    $0x20,%eax
     46f:       84 c0                   test   %al,%al

In fact, I believe the problem to be with SO_REUSEADDR.  It only
manifests if the port has gotten traffic and there's sockets in
TIME_WAIT.

I suppose a trivial test would be to bind to a port, connect to it,
disconnect, close the socket, create a socket with SO_REUSEADDR and
rebind to it.  Pow.

I can't get UML 2.6.0 working so I can't test very well, but it's a
helluva showstopper.

The strace of apache starting up when it crashed:

socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) =3D 3
fcntl64(3, F_DUPFD, 15)                 =3D 20
close(3)                                =3D 0
setsockopt(20, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
setsockopt(20, SOL_SOCKET, SO_KEEPALIVE, [1], 4

(oopsed in bind so strace never saw it)

--Dan

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD4DBQE/hG25kycScExRgsgRAu8kAJj5WWhunKE14t8qxgrL5c9TJxrJAKCF7zuC
3EMe6K6sJCHsorfCCGGdtg==
=mR+i
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
