Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSFJWpf>; Mon, 10 Jun 2002 18:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSFJWpe>; Mon, 10 Jun 2002 18:45:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25076 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316500AbSFJWpc>; Mon, 10 Jun 2002 18:45:32 -0400
Subject: Re: [CHECKER] 24 memory leaks on error paths in 2.4.17
From: Robert Love <rml@tech9.net>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU, marcelo@conectiva.com.br
In-Reply-To: <200206100355.UAA17053@csl.Stanford.EDU>
Content-Type: multipart/mixed; boundary="=-lzs03iHhoZ0b0HiO0RIs"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 10 Jun 2002 15:45:32 -0700
Message-Id: <1023749132.21176.122.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lzs03iHhoZ0b0HiO0RIs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-06-09 at 20:55, Dawson Engler wrote:
> This checker warns when you do not free allocated memory on failure paths.
> Note: while we only include 24 errors, there were lots in general; let me
> know if more are useful.

Yes they are very useful!  The work you do is amazingly useful and you
have quite a neat tool there ;)

> 1	|	/2.4.17/socket.c
> 
> 	if ((sk=sock->sk) == NULL)
> Error --->
> 		return -EINVAL;

Yep, this is a bug.  It is tricky because in cases where !on, fna does
not need to be freed... so I can see how this was missed.

Marcelo, attached patch, against 2.4.19-pre10, fixes this bug...

	Robert Love


--=-lzs03iHhoZ0b0HiO0RIs
Content-Disposition: attachment; filename=socket-leak-rml-2.4.19-pre10-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=socket-leak-rml-2.4.19-pre10-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre10/net/socket.c linux/net/socket.c
--- linux-2.4.19-pre10/net/socket.c	Mon Jun 10 15:26:30 2002
+++ linux/net/socket.c	Mon Jun 10 15:37:48 2002
@@ -743,11 +743,13 @@
 			return -ENOMEM;
 	}
=20
-
 	sock =3D socki_lookup(filp->f_dentry->d_inode);
 =09
-	if ((sk=3Dsock->sk) =3D=3D NULL)
+	if ((sk=3Dsock->sk) =3D=3D NULL) {
+		if (fna)
+			kfree(fna);
 		return -EINVAL;
+	}
=20
 	lock_sock(sk);
=20

--=-lzs03iHhoZ0b0HiO0RIs--

