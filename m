Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270298AbUJTJtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270298AbUJTJtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270176AbUJTJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:44:18 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:28340 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S270067AbUJTJla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:41:30 -0400
Date: Wed, 20 Oct 2004 11:41:23 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: iproute2 and 2.6.9 kernel headers (was Re: [ANNOUNCE] iproute2 2.6.9-041019)
Message-ID: <20041020094123.GF19899@sunbeam.de.gnumonks.org>
References: <41758014.4080502@osdl.org> <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com> <20041020070017.GA19899@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <20041020070017.GA19899@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2004 at 09:00:17AM +0200, Harald Welte wrote:
> I'll take care of this. sorry fort he inconvenience.

I should actually read mails befor replying ;)  I thought the bug was in
lnstat - but apparently it wasn't.

The include bug seems non-trivial to fix. (how do I hate kernel include
=66rom userspace issues):

apparently __KERNEL_STRICT_NAMES is definde somewhere (glibc?) which
prevents __le16, __le64 and others from being defined in linux/types.h.

Just reietting it like this doesn't help much:


diff -Nru iproute2-2.6.9-041019/ip/iptunnel.c iproute2-2.6.9-laf/ip/iptunne=
l.c
--- iproute2-2.6.9-041019/ip/iptunnel.c	2004-10-19 22:49:02.000000000 +0200
+++ iproute2-2.6.9-laf/ip/iptunnel.c	2004-10-20 11:26:24.489444052 +0200
@@ -26,6 +26,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <sys/ioctl.h>
+#undef __KERNEL_STRICT_NAMES
 #include <asm/byteorder.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>

Since now we have conflicting definitions

gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include -DRESOLVE_H=
OSTNAMES   -c -o iptunnel.o iptunnel.c
In file included from /usr/include/linux/byteorder/big_endian.h:11,
                 from /usr/include/asm/byteorder.h:74,
                 from iptunnel.c:30:
/usr/include/linux/types.h:20: error: conflicting types for `fd_set'
/usr/include/sys/select.h:78: error: previous declaration of `fd_set'
/usr/include/linux/types.h:21: error: conflicting types for `dev_t'
/usr/include/sys/types.h:62: error: previous declaration of `dev_t'
/usr/include/linux/types.h:24: error: conflicting types for `nlink_t'
/usr/include/sys/types.h:77: error: previous declaration of `nlink_t'

I'm done with this, maybe somebody with more clue about kernel include
magic will take on from this.

Additional issue:  the iproute2 makefile didn't stop the build process
in the event of an error.   Stephen, plase consider this patch to fix
it:

diff -Nru iproute2-2.6.9-041019/Makefile iproute2-2.6.9-laf/Makefile
--- iproute2-2.6.9-041019/Makefile	2004-10-19 22:49:02.000000000 +0200
+++ iproute2-2.6.9-laf/Makefile	2004-10-20 11:33:33.223545024 +0200
@@ -29,10 +29,12 @@
=20
 LIBNETLINK=3D../lib/libnetlink.a ../lib/libutil.a
=20
-all: Config
-	@for i in $(SUBDIRS); \
-	do $(MAKE) $(MFLAGS) -C $$i; done
+all: Config $(SUBDIRS)
=20
+.PHONY: $(SUBDIRS)
+$(SUBDIRS):
+	$(MAKE) $(MFLAGS) -C $@;
+=09
 Config:
 	./configure $(KERNEL_INCLUDE)
=20
--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdjLDXaXGVTD0i/8RAkXvAKCKOmfiHlj2IA9ibkC7yeBMxNkctwCgodsT
Hb+mk8qh2WufqP4gX7oLKKY=
=lLyY
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
