Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVCHN6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVCHN6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVCHN6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:58:48 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:30081 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261332AbVCHN6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:58:39 -0500
Date: Tue, 8 Mar 2005 15:58:36 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-ID: <20050308135836.GC12820@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the BUG_ON() use in linux/list.h I get this:

  CC      init/initramfs.o
In file included from include/linux/wait.h:23,
                 from include/linux/fs.h:205,
                 from init/initramfs.c:2:
include/linux/list.h: In function `list_del':
include/linux/list.h:164: warning: implicit declaration of function `printk'
In file included from include/linux/spinlock.h:13,
                 from include/linux/wait.h:25,
                 from include/linux/fs.h:205,
                 from init/initramfs.c:2:
include/linux/kernel.h: At top level:
include/linux/kernel.h:116: error: conflicting types for 'printk'
include/linux/kernel.h:116: note: a parameter list with an ellipsis can't m=
atch an empty parameter name list declaration
include/linux/list.h:164: error: previous implicit declaration of 'printk' =
was here
make[1]: *** [init/initramfs.o] Error 1
make: *** [init] Error 2

It looks like this is a result of having asm/bug.h included and not
having linux/kernel.h included before it, as adding that makes this go
away. This seems like it will be a problem for platforms that use
printk() in their BUG() definitions (in the HAVE_ARCH_BUG case) without
dragging in this header from somewhere else.

With this I can build on sh again. The other solution is to add the
include to asm/bug.h directly, but it would be nice to avoid linux/
includes from asm/ context in general..

Thoughts? Or ideas for a more appropriate fix?

--- linux-sh-2.6.11-mm2.orig/include/linux/list.h	2005-03-08 15:46:50.60156=
5604 +0200
+++ linux-sh-2.6.11-mm2/include/linux/list.h	2005-03-08 15:46:53.882114403 =
+0200
@@ -5,6 +5,7 @@
=20
 #include <linux/stddef.h>
 #include <linux/prefetch.h>
+#include <linux/kernel.h>
 #include <asm/system.h>
 #include <asm/bug.h>
=20

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCLa+M1K+teJFxZ9wRAllsAJ953ucmH6NkNthqJj0463yXgU2XfACfR26Y
KEVh0OwjXj+g7OhzMPZbpTQ=
=F73w
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
