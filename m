Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBBJ0a>; Fri, 2 Feb 2001 04:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBBJ0U>; Fri, 2 Feb 2001 04:26:20 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:40944 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S129104AbRBBJ0L>;
	Fri, 2 Feb 2001 04:26:11 -0500
Date: Fri, 2 Feb 2001 01:25:50 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Chris Evans <chris@scary.beasts.org>
Cc: Malcolm Beattie <mbeattie@sable.ox.ac.uk>, linux-kernel@vger.kernel.org,
        davem@redhat.com
Subject: [Patch]Re: Serious reproducible 2.4.x kernel hang
Message-ID: <20010202012550.A9756@turbolinux.com>
In-Reply-To: <20010201165247.D27009@sable.ox.ac.uk> <Pine.LNX.4.30.0102011826060.397-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0102011826060.397-100000@ferret.lmh.ox.ac.uk>; from Chris Evans on Thu, Feb 01, 2001 at 06:28:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/socket.h>
>=20
> int
> main(int argc, const char* argv[])
> {
>   int retval;
>   int sockets[2];
>   char buf[1];
>=20
>   retval =3D socketpair(PF_UNIX, SOCK_DGRAM, 0, sockets);
>   if (retval !=3D 0)
>   {
>     perror("socketpair");
>     exit(1);
>   }
>   shutdown(sockets[0], SHUT_RDWR);
>   read(sockets[0], buf, 1);
> }

I tried to debug this issue with the kdb on 2.4.1-pre7.
Here is the stack trace

mcount+0x1f9
wait_for_packet+0x13
skb_recv_datagram+0xbb
unix_dgram_recvmsg+0x53
sock_recvmsg+0x41
sock_read+0x8f
sys_read+0xa4
system_call+0x3c

I looked at the skb_recv_datagram code and noticed that wait_for_packet is =
not
returning an error, even while trying to read a closed socket.
Anyways here is a patch against 2.4.1 that will fix the issue.
Please feel free to flame me about the patch :)

thanks
--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Q: How do you keep a moron in suspense?=20
of a GNU generation   -o)  |=20
Kernel 2.2.16         /\\  |=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

--VbJkn9YxBvnuCH5J
Content-Type: application/x-patch
Content-Disposition: attachment; filename="dgram.patch"
Content-Transfer-Encoding: quoted-printable

--- 2.4.1/net/core/datagram.c	Fri Feb  2 01:00:10 2001=0A+++ linux/net/core=
/datagram.c	Fri Feb  2 01:06:59 2001=0A@@ -74,15 +74,15 @@=0A 	if (error)=
=0A 		goto out;=0A =0A-	if (!skb_queue_empty(&sk->receive_queue))=0A-		goto=
 ready;=0A-=0A+	error =3D -ENOTCONN;=0A 	/* Socket shut down? */=0A 	if (sk=
->shutdown & RCV_SHUTDOWN)=0A 		goto out;=0A =0A+	if (!skb_queue_empty(&sk-=
>receive_queue))=0A+		goto ready;=0A+=0A 	/* Sequenced packets can come dis=
connected. If so we report the problem */=0A-	error =3D -ENOTCONN;=0A 	if(c=
onnection_based(sk) && !(sk->state=3D=3DTCP_ESTABLISHED || sk->state=3D=3DT=
CP_LISTEN))=0A 		goto out;=0A =0A
--VbJkn9YxBvnuCH5J--

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6en0e5UrYeFg/7bURAtClAJ4gyoZhZgiXLP8OaKYr1J45IcA01QCcCFfm
0lT4amgxIc0kDwh+dudHYQ4=
=dng3
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
