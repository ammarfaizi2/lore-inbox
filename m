Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287387AbRL3MJf>; Sun, 30 Dec 2001 07:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287389AbRL3MJ0>; Sun, 30 Dec 2001 07:09:26 -0500
Received: from 217-126-33-148.uc.nombres.ttd.es ([217.126.33.148]:61629 "EHLO
	debian") by vger.kernel.org with ESMTP id <S287387AbRL3MJM>;
	Sun, 30 Dec 2001 07:09:12 -0500
Date: Sun, 30 Dec 2001 13:09:09 +0100
From: Tuxisuau <tuxisuau@7a69ezine.org>
To: linux-kernel@vger.kernel.org
Cc: tuxisuau@7a69ezine.org
Subject: Cannot connect() setting SO_BINDTODEVICE to another interface (2.4.17 / libc6 2.2.4)
Message-ID: <20011230120909.GA28623@tuxisuau.7a69ezine.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

I've been trying to code some client program that allow me to specify
the interface i want to connect through. I've tried to do something
like:

setsockopt(ifd, SOL_SOCKET, SO_BINDTODEVICE, interface, strlen(interface)+1=
);

Ok, it worked perfecly for raw sockets in some experiment i did in the
past... only sending.
But when i try to do that with a TCP socket, the syn is sent and the syn
& ack received in the correct interface. But then connection does not
continue.
The connection completes perfecly if the interface i use is the default rou=
te.
Then I tried to bind the source adress before, etc without good results.

I'm using libc6 2.2.4-7 Debian Unstable package, and kernel 2.4.17.

Here's a example:

#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
int main()
{
        int ifd;
        char *interface;
        struct sockaddr_in server,client;

        interface =3D (char *)malloc(4);
        strncpy(interface, "ppp0\0",5);

        server.sin_family =3D AF_INET;
        server.sin_port =3D htons(21);
        server.sin_addr.s_addr =3D inet_addr("10.0.0.1"); /* ftp server add=
ress */
        bzero(&(server.sin_zero),8);

        client.sin_port =3D htons(0);
        client.sin_addr.s_addr =3D inet_addr("172.16.0.1"); /* my ppp0 addr=
ess */

        if((ifd =3D socket(AF_INET, SOCK_STREAM, 0))=3D=3D-1)
        {
                perror("socket()");
                exit(-1);
        }
        if((setsockopt(ifd, SOL_SOCKET, SO_BINDTODEVICE, interface, strlen(=
interface)+1))=3D=3D-1)
        {
                perror("setsockopt() SO_BINDTODEVICE");
                exit(-1);
        }

        if((bind(ifd, (struct sockaddr *)&client,sizeof(struct sockaddr)))=
=3D=3D-1) /* it's really required? */
        {
                perror("bind()");
                exit(-1);
        }

        if((connect(ifd, (struct sockaddr *)&server,sizeof(struct sockaddr)=
))=3D=3D-1)
        {
                perror("connect()");
                exit(-1);
        }

        return 0;
}

--=20
tuxisuau. tuxisuau@7a69ezine.org
http://tuxisuau.7a69ezine.org

"How I need a drink, alcoholic of course, after the heavy chapters involvin=
g quantics mechanics"
George Polya

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8LwPlNtNGWNWoazERAmAmAJsH8v/Qvm50cOY84V5HgJXnE18HUQCZAbEP
u1a95p7+X5oWXZ+ZBZdA300=
=1JEz
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
