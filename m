Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTL0UXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 15:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTL0UXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 15:23:10 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:65430 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264563AbTL0UXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:23:01 -0500
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Edward Tandi <ed@efix.biz>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>
In-Reply-To: <1960000.1072550125@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
	 <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]>
	 <1072523478.12308.52.camel@nosferatu.lan>
	 <1072525450.3794.8.camel@wires.home.biz>  <1960000.1072550125@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F+0QHKkfgpRlvsKDE5Sg"
Message-Id: <1072555431.12308.471.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 22:25:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F+0QHKkfgpRlvsKDE5Sg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 20:35, Martin J. Bligh wrote:
> >> > Something appears to have broken OSS sound emulation between=20
> >> > test2 and test3. Best I can tell (despite the appearance of the BK l=
ogs),=20
> >> > that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
> >> > understands the sound architecture better than I can fix this?
> >> >=20
> >>=20
> >> I wont say I understand it, but a quick look seems the major change is
> >> the addition of the 'whole-frag' and 'no-silence' opts.  You might try
> >> the following to revert what 'no-silence' change at least does:
> >>=20
> >> --
> >>  # echo 'xmms 0 0 no-silence' > /proc/asound/card0/pcm0p/oss
> >>  # echo 'xmms 0 0 whole-frag' > /proc/asound/card0/pcm0p/oss
> >> --
> >=20
> > Thanks, that fixes it for me. I too have been seeing terrible problems
> > with XMMS since the early 2.6 pre- kernels.
> >=20
> > Because it only happens in XMMS I thought it was one of those
> > application bugs brought out by scheduler changes. I now use Zinf BTW
> > -It's better for large music collections (although not as stable or
> > flash).
> >=20
> > I guess someone ought to revert the standard behaviour.
>=20
> OK, the following patch from Andrew fixes it up 80% or so, but I still=20
> don't think it's as good as test2 was - turning on whole-frag seems to
> fix the rest of it. It's much more difficult to tell now though, so I'd=20
> like other people's opinions on it. If you want to switch between the
> two, the above switches it on, and:
>=20
> # echo 'clear' > /proc/asound/card0/pcm0p/oss
>=20
> switches whole-frag back off. I'm using a 192kbps MP3 to test it, repeati=
ng
> the first 30s of the same song again and again (I'm gonna hate that song=20
> soon ;-)). Different bitrates might give better differentation of the pro=
blem.
>=20
> Please, please experiment with this, and let us know.
>=20
> M.
>=20
> --- compile/sound/core/oss/pcm_oss.c.old	Mon Nov 17 18:29:43 2003
> +++ compile/sound/core/oss/pcm_oss.c	Sat Dec 27 10:32:30 2003
> @@ -814,7 +814,7 @@
>  			xfer +=3D tmp;
>  			if (substream->oss.setup =3D=3D NULL || !substream->oss.setup->wholef=
rag ||
>  			    runtime->oss.buffer_used =3D=3D runtime->oss.period_bytes) {
> -				tmp =3D snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->=
oss.buffer_used, 1);
> +				tmp =3D snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->=
oss.period_bytes, 1);
>  				if (tmp <=3D 0)
>  					return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
>  				runtime->oss.bytes +=3D tmp;

I cannot see that this is a very clean approach.  Sure, this is how it
was, but the test was also different:

--
if (runtime->oss.buffer_used =3D=3D runtime->oss.period_bytes) {
--

Meaning the buffer was only written when it was full (period_bytes is
your period size, meaning buffer size).  What you will have now, is that
you will write the full buffer with your valid data, and whatever crud
is left from a previous pass that used the buffer to its full extend,
or at least more of it than this pass (which might very well be the
reason for the 20% noise/whatever left).  Basically writing a chunk of
crap at the end of every user buffer.

You might try something like below, but I will be honest if I do not
know for a fact that

--
--- a/sound/core/oss/pcm_oss.c    2003-12-27 12:53:06.000000000 +0200
+++ b/sound/core/oss/pcm_oss.c    2003-12-27 22:00:47.323058872 +0200
@@ -814,6 +814,12 @@
                        xfer +=3D tmp;
                        if (substream->oss.setup =3D=3D NULL || !substream-=
>oss.setup->wholefrag ||
                            runtime->oss.buffer_used =3D=3D runtime->oss.pe=
riod_bytes) {
+                               if (runtime->oss.buffer_used !=3D runtime->=
oss.period_bytes) {
+
+                                       memset(runtime->oss.buffer + runtim=
e->oss.buffer_used,
+                                               (u_int8_t)snd_pcm_format_si=
lence_64(snd_pcm_oss_format_from(runtime->oss.format)),
+                                               runtime->oss.period_bytes -=
 runtime->oss.buffer_used);
+                               }
                                tmp =3D snd_pcm_oss_write2(substream, runti=
me->oss.buffer, runtime->oss.buffer_used, 1);
                                if (tmp <=3D 0)
                                        return xfer > 0 ? (snd_pcm_sframes_=
t)xfer : tmp;
--

But I would imagine the 'silent parts' in the song (if that long, and
dont anyhow sound like skips or choppy) will still be annoying =3D)


--=20
Martin Schlemmer

--=-F+0QHKkfgpRlvsKDE5Sg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7eWnqburzKaJYLYRAk5UAJ0XkZFIweaqF61FId4wIBYK7XiRFwCfSTYS
j9nX583QDb8RVop2CYvKj60=
=Bmvf
-----END PGP SIGNATURE-----

--=-F+0QHKkfgpRlvsKDE5Sg--

