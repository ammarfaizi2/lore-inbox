Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbTI3HKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTI3HKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:10:24 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:58272 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263155AbTI3HKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:10:15 -0400
Date: Tue, 30 Sep 2003 10:10:05 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20030930071005.GY729@actcom.co.il>
References: <20030929090629.GF29313@actcom.co.il> <20030929153437.GB21798@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hEi834+foqWOL7fK"
Content-Disposition: inline
In-Reply-To: <20030929153437.GB21798@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hEi834+foqWOL7fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2003 at 04:34:37PM +0100, Jamie Lokier wrote:

> I agree with the intent of that comment, but the code in it is
> unnecessarily complex.  See if you like this, and if you do feel free
> to submit it as a patch:

Ah, much nicer, thank you. I'll submit it, but first, what do you
think about this version? it keeps the optimization and enforces the
"bit1 and bit2 must be single bits only" rule. It could probably be
improved to be done at  build time, if bit1 and bit2 and compile time
constants. Against 2.6.0-t6-cvs, compiles and boots for me.=20

--- linux-2.5/include/linux/mman.h	Sun Sep  7 10:05:18 2003
+++ calc-vm-bit-optimizing-macro-2.6.0-t6//include/linux/mman.h	Tue Sep 30 =
10:02:01 2003
@@ -28,10 +28,28 @@
 	vm_acct_memory(-pages);
 }
=20
-/* Optimisation macro. */
-#define _calc_vm_trans(x,bit1,bit2) \
-  ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
-   : ((x) & (bit1)) / ((bit1) / (bit2)))
+/*=20
+ * assert that only a single bit is on in 'bit'=20
+ */=20
+static inline void assert_single_bit(unsigned long bit)
+{
+	BUG_ON(bit & (bit - 1));=20
+}
+/*=20
+ * Optimisation function.  It is equivalent to:=20
+ *      (x & bit1) ? bit2 : 0
+ * but this version is faster. =20
+ * ("bit1" and "bit2" must be single bits).=20
+ */
+static inline unsigned long=20
+_calc_vm_trans(unsigned long x, unsigned long bit1, unsigned long bit2)=20
+{
+	assert_single_bit(bit1);=20
+	assert_single_bit(bit2);=20
+
+	return ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1))
+		: ((x) & (bit1)) / ((bit1) / (bit2)));=20
+}
=20
 /*
  * Combine the mmap "prot" argument into "vm_flags" used internally.

--=20
Muli Ben-Yehuda
http://www.mulix.org


--hEi834+foqWOL7fK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eSxNKRs727/VN8sRAlKEAJsEfT8ClNMJlAATMDJMxThED+noiACeKFjG
PM4npbA6b4mWKD3tz4xsZ9E=
=Axi0
-----END PGP SIGNATURE-----

--hEi834+foqWOL7fK--
