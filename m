Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTEFNuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTEFNux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:50:53 -0400
Received: from rth.ninka.net ([216.101.162.244]:43984 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263722AbTEFNus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:50:48 -0400
Subject: Re: [2.5.69-mm1] kernel BUG at include/linux/module.h:284!
From: "David S. Miller" <davem@redhat.com>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br, rusty@rustcorp.com.au
In-Reply-To: <200305061544.37612.rabbit80@mbnet.fi>
References: <200305061544.37612.rabbit80@mbnet.fi>
Content-Type: multipart/mixed; boundary="=-MWHIdMNROrjDB/oE3Hx9"
Organization: 
Message-Id: <1052227331.983.46.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 06:22:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MWHIdMNROrjDB/oE3Hx9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-05-06 at 05:44, Kimmo Sundqvist wrote:
> Got one like this...
...
> Call Trace:
>  [<f8d7d060>] rawv6_protosw+0x0/0x20 [ipv6]
>  [<c0232b51>] sock_create+0x149/0x264
>  [<f8d7f848>] __icmpv6_socket+0x0/0x8 [ipv6]

Crap.  Well, two problems. Attached is a fix for the first
one, the second one is harder.

Arnaldo, ipv6 creates a socket of it's own type during
module init, try_module_get() on the current module fails
during module load... do you see the problem?

Rusty, you said you were working on a solution for modules
that call themselves during their own init?

-- 
David S. Miller <davem@redhat.com>

--=-MWHIdMNROrjDB/oE3Hx9
Content-Disposition: attachment; filename=diff
Content-Type: text/plain; name=diff; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.1074  -> 1.1075=20
#	 net/ipv6/af_inet6.c	1.32    -> 1.33  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/06	davem@nuts.ninka.net	1.1075
# [IPV6]: Kill spurious module_{get,put}().
# --------------------------------------------
#
diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Tue May  6 06:16:05 2003
+++ b/net/ipv6/af_inet6.c	Tue May  6 06:16:05 2003
@@ -111,7 +111,6 @@
 #ifdef INET_REFCNT_DEBUG
 	atomic_dec(&inet6_sock_nr);
 #endif
-	module_put(THIS_MODULE);
 }
=20
 static __inline__ kmem_cache_t *inet6_sk_slab(int protocol)
@@ -243,11 +242,6 @@
 	atomic_inc(&inet6_sock_nr);
 	atomic_inc(&inet_sock_nr);
 #endif
-	if (!try_module_get(THIS_MODULE)) {
-		inet_sock_release(sk);
-		return -EBUSY;
-	}
-
 	if (inet->num) {
 		/* It assumes that any protocol which allows
 		 * the user to assign a number at socket
@@ -259,7 +253,6 @@
 	if (sk->prot->init) {
 		int err =3D sk->prot->init(sk);
 		if (err !=3D 0) {
-			module_put(THIS_MODULE);
 			inet_sock_release(sk);
 			return err;
 		}

--=-MWHIdMNROrjDB/oE3Hx9--
