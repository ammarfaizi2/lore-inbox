Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVBJNn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVBJNn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 08:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVBJNn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 08:43:27 -0500
Received: from lug-owl.de ([195.71.106.12]:26827 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262119AbVBJNnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 08:43:13 -0500
Date: Thu, 10 Feb 2005 14:43:12 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050210134311.GP10594@lug-owl.de>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
References: <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com> <20050209213930.GM10594@lug-owl.de> <20050209215335.GA2634@ucw.cz> <20050210104655.GO10594@lug-owl.de> <420B5C66.8040408@grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYHLzUxHEKq3fcvW"
Content-Disposition: inline
In-Reply-To: <420B5C66.8040408@grupopie.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oYHLzUxHEKq3fcvW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-10 13:06:46 +0000, Paulo Marques <pmarques@grupopie.com>
wrote in message <420B5C66.8040408@grupopie.com>:
> We are seriously diverging now....
>=20
> Let me try to put things into perspective:
>=20
>   ---------------
>  |               |                                        --------
>  |  Touch        |          -----------                  |        |
>  |  Screen       |---------|    TS     |   serial port   |   PC   |
>  |               |       __|controller |-----------------|        |
>  |               |      /  |           |                 |        |
>   ---------------       |   -----------                   --------
>        \_______________/
>=20
> In a previous post you said:
>=20
> >		Basically all these touchscreens are capable of being
> >		calibrated. It's not done with just pushing the X/Y
> >		values the kernel receives into the Input API. These
> >		beasts may get physically mis-calibrated and eg. report
> >		things like (xmax - xmin) <=3D 20, so resolution would be
> >		really bad and kernel reported min/max values were only
> >		"theoretical" values, based on the protocol specs.
>=20
> To get raw values that are (xmax-xmin)<=3D20, the TS controller must be=
=20
> "trying" to do some calibration itself.

All touchscreens get calibrated once during their production AFAIK. This
should result at least in a "useable" resolution. ...but have a tight
look at today's touches: their [xy]{min,max} values don't cover all the
theoretical range of values that could be sent with the protocol in use.
Just taking an example, one screen here (it has never ever been
physically recalibrated except right after production) used values (for
X as well as for Y) in the range of about [350..3800]. The protocol does
allow a lot more...

> That's the brain-damaged part.

It's not :)  The foil layers aren't all that equal after production.
They're (from the protocol point of view) generalized by calibrating
them once (during production). However, if the screen gets injured, this
must either be re-done, or the screen may need to be replaced. However,
replacing parts in the field is expensive and service staff tries to not
do that, but instead a recalibration is tried first. IFF the touchscreen
is then found to be *really* dead, it's replaced.

> The TS controller should not be doing any calibration at all, and send=20
> the widest range it can through the serial port to the PC.

But it needs to know the exact range of possible resistance/capacity to
be able to do that. This is where the trouble starts that I'm talking
about. Of course you can *assume* that capacity will be in a
(well-known) range (you know the range because you can just test a
production example), but this range is a bit different for each
touchscreen produced, let alone the fact that the foils may get
scratches or other injuries. In a bad case, you get a near-short-circuit
so that your (new) range of values is near-zero. Recalibrating the A/D
converter may revive this almost-dead screen.

> On the PC we must have a library that is capable of scaling / rotating=20
> those values so that it converts them into "screen absolute"=20
> coordinates. I call these screen absolute because they shouldn't depend=
=20
> on the actual resolution.
>
> So there is no doubt that calibration must be done. We are past that. I=
=20
> too work with touch screens in restaurants for more than 10 years now,=20
> so I surely know what an agrssive environment is, and what damage a=20
> touchscreen might be exposed to.

Right, but there are two kinds of calibration:

(1) Mapping the raw capacity/resistor values (that only the TS controller
    is aware of) to something the HID API can output. (This, too, includes
    that the kernel dictates the range of values that can be reached).
(2) Mapping the range of reachable HID coordinates to actual on-screen
    pixels. (This accounts for a person't fat and/or un-even fingers...)

"Calibration" in X11 with all it's drivers is done at the (2) level. You
first have to figure out the range of generated values and then place
these as [xy]{min,max} values.

However, the hardware-internal mapping (1) isn't covered anywhere right
now. This usually isn't much of a problem during real use, but it *is* a
problem if the hardware ever gets damaged (or the controller's flash
breaks). Ever tried to use a serial sniffer on vendor's original MS
Windows drivers? They almost always update the controller's internal
mapping, too.

> So, if the inputattach program initializes the TS controller to make it=
=20
> send the widest range (1:1 calibration) it can deliver, we can do all=20
> the calibration on the PC and not depend on the TS being able to do the=
=20
> calibration itself.

This is nice, but even cannot be done with all TS controllers. The very
old ones actually just hand over the pure A/D values as a 10bit integer.
For sure, you won't ever see a touchscreen that covers the whole scale:)

> Actually a calibration that can do scaling and rotation, can=20
> automatically compensate for mirroring and/or switched X/Y axes. We=20
> probably need the user to press 4 points for that, though (3 points are=
=20
> enough, but just barely enough).

ACK. We'd do a lib for that and have a X11 driver to make use of it.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--oYHLzUxHEKq3fcvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCC2TvHb1edYOZ4bsRAkaGAKCRgGvGb9hVnFFKZAb2PZEgreDahQCfcn0l
Fxs7IIPexl7Ru8Ntj8SyMts=
=ib4a
-----END PGP SIGNATURE-----

--oYHLzUxHEKq3fcvW--
