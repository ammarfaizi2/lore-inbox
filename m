Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWCBXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWCBXDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWCBXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:03:19 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:31401 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750988AbWCBXDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:03:19 -0500
X-Sasl-enc: 0G9Rxh7Q/uKOZUC2/cdN54mIqu1tBDokSSQ4wvcCe2jX 1141340594
Message-ID: <440779AF.5060202@imap.cc>
Date: Fri, 03 Mar 2006 00:03:11 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de> <1141032577.2992.83.camel@laptopd505.fenrus.org>
In-Reply-To: <1141032577.2992.83.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A19A8853C5E94D55B1C4B13"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A19A8853C5E94D55B1C4B13
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thank you very much, Arjan, for your review of our code and your
extensive comments. We are working on taking them into account for the
next attempt at submitting the driver. Most of them are quite clear and
don't need discussing. Just a few remarks and questions:

On 27.02.2006, Arjan van de Ven wrote:
> as a general review remark: you seem to use a LOT of atomic variables.
> This I think is not too good an approach in general, because you get
> into all kinds of race situations if you need to access multiple (and
> you do).

I see. We'll try to reduce our atomic consumption. :-)

> In addition I've seen a lot of your code using 2 or more
> atomics in the same function, at which point it's most likely cheaper t=
o
> just have a spinlock instead... (yes a single atomic is same cost as a
> spinlock, but once you do multiple in the same function the price is
> thus higher than a spinlock ;)

So you are saying that, for example

	spin_lock_irqsave(&cs->ev_lock, flags);
	head =3D cs->ev_head;
	tail =3D cs->ev_tail;
	spin_unlock_irqrestore(&cs->ev_lock, flags);

is (mutatis mutandis) actually cheaper than

	head =3D atomic_read(&cs->ev_head);
	tail =3D atomic_read(&cs->ev_tail);

? That's interesting. I wouldn't have expected that after reading
Documentation/atomic_ops.txt and Documentation/spinlock.txt.

>>+#define IFNULL(a) \
>>+       if (unlikely(!(a)))
>=20
> please please get rid of this!
> (same goes for the variants of this just below this)

Ok, these were mainly debugging aids. We'll just drop them and let the
oops mechanism catch the (hopefully non-existent) remaining cases of
pointers being unexpectedly NULL.

>> +void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *m=
sg,
>> +			size_t len, const unsigned char *buf, int from_user)
>=20
> such "from_user" parameter is highly evil, and also breaks sparse and
> friends.. (btw please run sparse on the code and fix all warnings)

Are you referring to anything in particular? We do run sparse regularly,
and it did not emit any warnings for the submitted version, not even for
this function. (But heaps of them for other parts of the kernel, if you
pardon the remark.)

>> +       spin_lock_irqsave(&cs->lock, flags);
>> +       ret =3D kmalloc(sizeof(struct at_state_t), GFP_ATOMIC);
>> +       if (ret) {
>> +               gigaset_at_init(ret, NULL, cs, cid);
>=20
> if you move the kmalloc one line up, can it use GFP_KERNEL ?

Sorry but no - this is executed within a tasklet.

> (GFP_ATOMIC is evil in the sense that spurious use of it gives trouble
> for the VM)

Does that mean that every function doing kmalloc() and which may be
called from both interrupt and non-interrupt context needs a gfp_t flags
argument?

Thanks again for your time and effort
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig9A19A8853C5E94D55B1C4B13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEB3m3MdB4Whm86/kRAvrLAJ43AfnRZhQZj0ELZwZDYRphwTUaFQCfYCt3
gZjKP8znZpgRzIKJUSL9Fv4=
=vfFe
-----END PGP SIGNATURE-----

--------------enig9A19A8853C5E94D55B1C4B13--
