Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293326AbSBYGQq>; Mon, 25 Feb 2002 01:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293327AbSBYGQh>; Mon, 25 Feb 2002 01:16:37 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:1408
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S293326AbSBYGQ1>; Mon, 25 Feb 2002 01:16:27 -0500
Date: Sun, 24 Feb 2002 22:16:16 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj1 - IPv6 not loading correctly.
In-Reply-To: <Pine.LNX.4.33.0202241300100.11220-100000@barbarella.hawaga.org.uk>
Message-ID: <Pine.LNX.4.33.0202242203080.21716-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 24 Feb 2002, Ben Clifford wrote:

> When ipv6.o is loaded, I get:
>
> IPv6 v0.8 for NET4.0
> Failed to initialize the ICMP6 control socket (err -97)
>
> and lsmod shows:
> ipv6    147968    -1 (uninitialized)

More info on this:

Looking at the code, the the ICMP6 control socket error is occurring
because sock_register isn't called for inet6 until after the ICMP6 control
socket is created (in af_inet6.c).

However, the ICMP6 control socket create calls sock_create, which requires
sock_register to have already been called.

I have made the below change, which moves the protocol family registration
higher up in the code.  It seems to make ipv6 work now.

However, I'm concerned that this gives a small amount of time when the
family is registered but not fully initialised.

Is this bad?



- --- /mnt/dev/hda11/2.5.5-dj1-snark-not-changed-much/net/ipv6/af_inet6.c	Tue Feb 19 18:10:53 2002
+++ 2.5.5-dj1/net/ipv6/af_inet6.c	Sun Feb 24 22:13:38 2002
@@ -675,6 +675,13 @@
 	 */
 	inet6_register_protosw(&rawv6_protosw);

+	/* register the family here so that the init calls below will
+	 * work. ?? is this dangerous ??
+	 */
+
+	(void) sock_register(&inet6_family_ops);
+
+
 	/*
 	 *	ipngwg API draft makes clear that the correct semantics
 	 *	for TCP and UDP is to consider one TCP and UDP instance
@@ -719,9 +726,6 @@
 	udpv6_init();
 	tcpv6_init();

- -	/* Now the userspace is allowed to create INET6 sockets. */
- -	(void) sock_register(&inet6_family_ops);
- -
 	return 0;

 #ifdef CONFIG_PROC_FS

- -- 


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8eda0sYXoezDwaVARAn+uAJ4o8hCamGZzX6UnJVH8PWYfjLzBFQCeLZxw
Fofq4Yo27N2juaxaMdZ+aXw=
=so8+
-----END PGP SIGNATURE-----

