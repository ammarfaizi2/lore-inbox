Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSHaJH4>; Sat, 31 Aug 2002 05:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSHaJH4>; Sat, 31 Aug 2002 05:07:56 -0400
Received: from ppp-217-133-219-1.dialup.tiscali.it ([217.133.219.1]:37083 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S316576AbSHaJHz>;
	Sat, 31 Aug 2002 05:07:55 -0400
Subject: logbuf_lock deadlock on NMI
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-6BgrZ4sGKJFosg8pRtQc"
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 Aug 2002 11:12:19 +0200
Message-Id: <1030785139.1569.26.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6BgrZ4sGKJFosg8pRtQc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I already mentioned this in an unrelated thread but I got no responses.

NMIs, by definition and documentation, are non maskable. This means that
we can get them anywhere, even when interrupts are disabled.

The problem is that in some paths of the NMI handler (mem_parity_error,
io_check_error, mca_handle_nmi), we call printk without busting
spinlocks first.
As a consequence, if I'm not missing something, if we get e.g. a memory
parity error while inside printk, we deadlock on logbuf_lock.

Apart from removing logbuf_lock and other locks that might be held in
printk, we could solve this by telling the APIC (I think that the same
can be done with the 8259 but I'm not sure) to send an interrupt to the
current CPU.
The interrupt, being maskable, will be triggered only outside
irq-protected spinlocks so we can safely do the NMI printk inside it.

Alternatively we may just reset the locks but since some errors are
non-fatal it probably isn't a good idea.

Any comments?


--=-6BgrZ4sGKJFosg8pRtQc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cIhzdjkty3ft5+cRAkp8AKC6qdRxgGrgcgsjs7wsJkego+P4LgCgiR8q
0G0ex1W1m152pFq0IkXcSeg=
=g8Md
-----END PGP SIGNATURE-----

--=-6BgrZ4sGKJFosg8pRtQc--
