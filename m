Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312949AbSCZEk1>; Mon, 25 Mar 2002 23:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312950AbSCZEkS>; Mon, 25 Mar 2002 23:40:18 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:17287 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312949AbSCZEkE>; Mon, 25 Mar 2002 23:40:04 -0500
Date: Mon, 25 Mar 2002 23:39:43 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020326043943.GR1853@ufies.org>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe.ml@online.fr>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9FC76F.6050900@mandrakesoft.com> <20020326014050.GP1853@ufies.org> <3C9FF4B3.3070408@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7tUYVWcdYzDJoZW"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r7tUYVWcdYzDJoZW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 11:10:27PM -0500, Jeff Garzik wrote:
> christophe barb=E9 wrote:
>=20
> >On Mon, Mar 25, 2002 at 07:57:19PM -0500, Jeff Garzik wrote:
> >
> >>This patch causes module defaults to be reused -- potentially incorrect=
ly.
> >>
> >
> >Wrong. How can the fact that a suspend/resume cycle increment the id be
> >worst than the fact that the same cycle return idx to the previous
> >state?
> >
> >The argument you have against this patch is WRONG.
> >
> >You think about NICs in a PCI slot.=20
> >That's changed the day the cardbus support was moved from pcmcia to the
> >today implementation.
> >You can't expect cardbus user to stop using the suspend mode because you
> >expect your id to be attributed one time (that doesn't even make sense).
> >
> >I agree that this patch is not a full fix (I said it in my original
> >post) but I disagree that it does any bad things. I would be interested
> >to learn about a real case ?
> >
>=20
> Just exactly what I described.
>=20
> The current system increments the card id on each ->probe, and does not=
=20
> decrement on ->remove, which makes sense if you are hotplugging one card=
=20
> and then another -- you don't want to reuse the same module options for=
=20
> a different card.  Your patch changes this logic to, "oh wait, let's=20
> stop doing this and have a special case once we reach MAX_UNITS"  Thus,=
=20
> you could potentially reuse the final slot when that was not the desired=
=20
> action.

Ok I really appreciate your work but here I can't believe I read what I
read. Please reread the patch :

+       if (vp->card_idx =3D=3D vortex_cards_found - 1)
+         vortex_cards_found--;

It is NOT a special case when we reach MAX_UNITS.
It is a special case when we remove the last inserted card.
Even in your case where the order is important it still works.

vortex_cards_found is used to attribute the next ID.

> Note that I am not defending this method of card_idx usage, because=20
> different use cases have different requirements (as indeed you do).  But=
=20
> your patch fixes one thing at the expense of another.

No and I hope you will agree with me now.
It fixes one thing at the expense of nothing.

> I just had another idea.  Create a new module option 'default_options',=
=20
> a single integer value.  Instead of assigning "-1" to options when we=20
> run out of MAX_UNITS ids, assign the default_options value.

This would be bloat code.
IMHO MAX_UNITS is a proof of unadequate design here.=20

Options should be set on a per-device basis by a userland tool which has
the required information to set them in a persistent way.

Is it not the purpose of ethtool ?
By the way the only problem in this tool is its name. It solves a
general problem for a particular subset : network device. Why not the
same tool for all modules ?

I will try to ethtoolize the vortex driver.

> >>This is a personal solution, that might live on temporary as an=20
> >>outside-the-tree patch... but we cannot apply this to the stable kernel.
> >>
> >>I agree the card idx is wrong on remove.  Insert and remove a 3c59x=20
> >>cardbus card several times, and you will lose your module options too.=
=20
> >>
> >
> >NO -- If I can remove/insert suspend/remove my card as I want I ever get
> >the same ID.=20
> >
> "same id" is vague.  Same PCI id?  Sure, but that doesn't mean it's the=
=20
> same card, from the driver's point of view. The driver really needs to=20
> keep track of whether or not a new ->probe indicates a card whose MAC=20
> address we have seen before.

Here by 'same' ID I mean the same id used in the driver to attribute the
option. But we agree (I hope) that it is not a good way to attribute
options to a given card.

> To reiterate another issue, however, suspend/resume should _not_ be=20
> calling the code added in your patch.  That's a non-3c59x bug somewhere.

Good Point.=20

Christophe

>    Jeff

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

A qui sait comprendre, peu de mots suffisent.
(Intelligenti pauca.)=20

--r7tUYVWcdYzDJoZW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8n/uPj0UvHtcstB4RAnP7AJ95Nfx88v2r2d92h1o870tlvoEF9ACffyJM
fUaPzeEN4wKsoRw/r1xPUVI=
=Ovip
-----END PGP SIGNATURE-----

--r7tUYVWcdYzDJoZW--
