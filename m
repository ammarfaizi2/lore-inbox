Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTI3Jlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTI3Jlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:41:44 -0400
Received: from mx1.actcom.co.il ([192.114.47.13]:32650 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261242AbTI3Jlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:41:39 -0400
Date: Tue, 30 Sep 2003 12:24:03 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Miles Bader <miles@gnu.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20030930092403.GR29313@actcom.co.il>
References: <20030929090629.GF29313@actcom.co.il> <20030929153437.GB21798@mail.jlokier.co.uk> <20030930071005.GY729@actcom.co.il> <buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030930074138.GG729@actcom.co.il> <buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/KohU7xR/z4Rz7fl"
Content-Disposition: inline
In-Reply-To: <buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/KohU7xR/z4Rz7fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2003 at 04:59:56PM +0900, Miles Bader wrote:
> Muli Ben-Yehuda <mulix@mulix.org> writes:
> > Ok, that's a pretty convincing argument for scraping that
> > version. I'll rewrite it to evaluate the arguments at compile time if
> > they're constants, which they are, in our case. Unless someone else
> > beats me to it, of course ;-)=20
>=20
> What's wrong with the macro version?  The presence of a __ prefix
> suggests that it's only used in controlled circumstances anyway, so is
> validity-checking on the bit arguments really worthwhile?

I like code that is "future proof", especially when it doesn't cost
anything. These examples generate identical code for me with gcc-3.3
and almost identical code with gcc-2.96 (one instruction difference,
and I can't tell which is faster), and the inline function barfs when
its arguments are incorrect during compile time, whereas the macro
will silently give you the wrong results. How does it fare on your
arch?

#include <stdio.h>=20
#include <assert.h>=20

#define BUG_ON(x) assert(x)=20

/* compiler trap for assert_single_bit. */=20
extern void __assert_single_bit_failed_dont_exist(void);=20

/*=20
 * assert that only a single bit is on in 'bit'=20
 */=20
#define assert_single_bit(bit) do { \
        if (__builtin_constant_p(bit)) {			        \
		if ((bit & (bit -1)))					\
			__assert_single_bit_failed_dont_exist();	\
	}  else								\
		BUG_ON(!(bit & (bit - 1)));				\
	} while(0)
/*=20
 * Optimisation function.  It is equivalent to:=20
 *      (x & bit1) ? bit2 : 0
 * but this version is faster. =20
 * ("bit1" and "bit2" must be single bits).=20
 */
static inline unsigned long=20
inline_calc_vm_trans(unsigned long x, unsigned long bit1, unsigned long bit=
2)=20
{
	assert_single_bit(bit1);=20
	assert_single_bit(bit2);=20

	return ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1))
		: ((x) & (bit1)) / ((bit1) / (bit2)));=20
}

/* Optimisation macro. */
#define macro_calc_vm_trans(x,bit1,bit2) \
  ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
   : ((x) & (bit1)) / ((bit1) / (bit2)))


int test3(unsigned long arg)
{
	return macro_calc_vm_trans(arg, 0x20, 0x80);=20
}

int test4(unsigned long arg)
{=20
	return inline_calc_vm_trans(arg, 0x20, 0x80);=20
}

int main(void)
{
	int l1 =3D test4(~0UL);=20
	int l2 =3D test3(~0UL);=20
	return l1 & l2; /* don't optimize them out */=20
}

gcc-2.96:=20

test3:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	andl	$32, %eax
	sall	$2, %eax
	popl	%ebp
	ret

test4:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	andl	$32, %eax
	sall	$2, %eax
	leave
	ret
--=20
Muli Ben-Yehuda
http://www.mulix.org


--/KohU7xR/z4Rz7fl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/eUuzKRs727/VN8sRAoB8AJwNMJhoG1wLeD7j4wMzZwc2eEbiagCfXzup
b2HbB5jMSe5DO3I7Ic3ZjUE=
=kN8Q
-----END PGP SIGNATURE-----

--/KohU7xR/z4Rz7fl--
