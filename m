Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWDYTtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWDYTtH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 15:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDYTtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 15:49:07 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:40900
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751326AbWDYTtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 15:49:06 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 21:54:08 +0200
User-Agent: KMail/1.9.1
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <444E524A.10906@argo.co.il> <4C4500F3-3A8E-4992-82FD-6E16257676CC@mac.com>
In-Reply-To: <4C4500F3-3A8E-4992-82FD-6E16257676CC@mac.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Avi Kivity <avi@argo.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1719919.8ZPpZ6jFic";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604252154.08933.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1719919.8ZPpZ6jFic
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 25 April 2006 21:22, you wrote:
> Except they can't.  Lots and lots of bits of kernel code explicitly =20
> depend on the fact that certain operations _cannot_ fail, and they =20
> make that obvious through the fact that those functions don't have =20
> any way of returning error conditions.

A function declared as
void foo(int bar) throw();
cannot fail or throw.

> >> First of all, that extra TakeLock object chews up stack, at least =20
> >> 4 or 8 bytes of it, depending on your word size.
> >
> > No, it's optimized out. gcc notices that &lock doesn't change and =20
> > that 'l' never escapes the function.
>=20
> GCC does not notice that when you use out-of-line functions.  Let me =20
> remind you that many of the kernel's spinlocks and other functions =20
> are out-of-line, inlining them has significant performance penalties.

The TakeLock object is completely different from the actual
lock object. The TakeLock object does _only_ call
spin_lock() and spin_unlock(), which are still out of line.

> {
> 	int result;
> 	struct foo *item =3D kmalloc(sizeof(*item), GFP_KERNEL);
> 	if (unlikely(!item))
> 		return ERR_PTR(-ENOMEM);
> =09
> 	spin_lock(&item_lock);
> =09
> 	result =3D item_init(item, GFP_KERNEL);

scheduling while atomic ;)

> (1)  You can't easily allocate and initialize an object in 2 =20
> different steps.

That is not true. Google for "d-pointer" for an example
on how you might do this.

> (2)  Your code either adds a refcount for "item" or unconditionally =20
> releases it at the end of the function.  Yes that's fixable, but not =20
> in a way that preserves the exception-handling properties you're =20
> espousing so much.  When you get an exception, how does the code tell =20
> which objects to free and which ones not to?

By good design of the exception objects, which carry all needed
information when handling the exception.


I _don't- want to say, that C++ is good in the kernel.
My opinion is: C++ in the kernel is bad.

=2D-=20
Greetings Michael.

--nextPart1719919.8ZPpZ6jFic
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBETn5glb09HEdWDKgRAo4LAKChawSnoFxlSMrYKOQ+sgbQpN59DACfWJ0N
OX4RlSBONRuXYfI+/KsiJfQ=
=pc3J
-----END PGP SIGNATURE-----

--nextPart1719919.8ZPpZ6jFic--
