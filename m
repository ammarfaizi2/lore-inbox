Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWCMWv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWCMWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWCMWv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:51:57 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:20420 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964835AbWCMWv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:51:57 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Date: Mon, 13 Mar 2006 21:10:01 +1000
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603131144.01462.ncunningham@cyclades.com> <20060313101214.GB2136@elf.ucw.cz>
In-Reply-To: <20060313101214.GB2136@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2156200.krxFy1eWge";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603132110.08324.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2156200.krxFy1eWge
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 13 March 2006 20:12, Pavel Machek wrote:
> On Po 13-03-06 11:43:55, Nigel Cunningham wrote:
> > Hi.
> >
> > On Monday 13 March 2006 08:30, Con Kolivas wrote:
> > > On Monday 13 March 2006 08:32, Andreas Mohr wrote:
> > > > And... well... this sounds to me exactly like a prime task
> > > > for the newish swap prefetch work, no need for any other
> > > > special solutions here, I think.
> > > > We probably want a new flag for swap prefetch to let it know
> > > > that we just resumed from software suspend and thus need
> > > > prefetching to happen *much* faster than under normal
> > > > conditions for a short while, though (most likely by
> > > > enabling prefetching on a *non-idle* system for a minute).
> > >
> > > Adding a resume_swap_prefetch() called just before the resume finishes
> > > that aggressively prefetches from swap would be easy. Please tell me =
if
> > > you think adding such a function would be worthwhile.
> >
> > My 2c would be that swsusp is broken in a number of ways in discarding
> > those pages in the first place:
>
> Yep, feel free to submit a patch.
>
> > - Forcing pages out to swap by vm pressure is an inefficient way of
> > writing the pages.
>
> Really? VM subsystem is supposed to be effective.

All the scanning of pages and so on when freeing memory takes time. Likewis=
e=20
at resume, figuring out what to fault back in or swap back in takes time.=20
Then you have to wait for the read to get processed, perhaps while other=20
processes are running, demanding disk to swap back in the file backed pages=
=20
that were just discarded. The alternative is not discarding them, taking a=
=20
little longer to write them to disk and read them back in at resume, but=20
having fewer calculations to do and less thrashing of the disk because the=
=20
data is stored as contiguously as storage allows.

> > - It doesn't get the pages compressed, and so makes inefficient use of
> > the storage and forces more pages to be discarded that would otherwise =
be
> > necessary.
>
> "more pages to be discarded" is untrue. If you want to argue that swap
> needs to be compressed, feel free to submit patches for swap
> compression.

If I'm trying to store an image of 5000 pages and I have 3000 pages of stor=
age=20
available, I can compress them with LZF and put all 5000 on disk (assuming=
=20
the common 50% compression), or dicard 2000. More pages are discarded witho=
ut=20
compression.

> (Compression is actually not as important as you paint it. Rafael
> implemented it, only to find out that it is 20 percent speedup in
> common cases -- and your gzip actually slows things down.)

I don't use gzip. I agree it slows things down. But 20%? What algorithm did=
=20
you use? It will also depend on the speed of your cpu and drive. (If the cp=
u=20
is fast but the drive is slow or you're still only using synchronous I/O,=20
yes, the improvement might only be 20%).

> > - Bringing the pages back in by swap prefetching or swapoffing or
> > whatever is equally inefficient (I was going to say 'particularly in low
> > memory situations', but immediately ate my words as I remembered that if
> > you've just swsusp'd, you've freed at least half of memory anyway).
>
> ...but allows you to use machine immediately after resume, which
> people want, as you have just seen.

Just?

> > - This technique doesn't guarantee that the pages you end up with in
> > memory are the pages that you're actually most likely to want. The vast
> > majority of what you really want will simply have been discarded rather
> > than swapped.
> >
> > Having said that, Rafael is making some progress in these areas, such
> > that swsusp is eating less memory than it used to, so that swap
> > prefetching will be less important at resume time than it has been in t=
he
> > past.

Regards,

Nigel

--nextPart2156200.krxFy1eWge
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFVMQN0y+n1M3mo0RAq9jAKCAUvZnYnb5+upL4vVCanQNVDHFlwCfVVSm
oNGmSAzpOnWb9qkalAUrbgc=
=fqPX
-----END PGP SIGNATURE-----

--nextPart2156200.krxFy1eWge--
