Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWBYANK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWBYANK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWBYANK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:13:10 -0500
Received: from ozlabs.org ([203.10.76.45]:45031 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964816AbWBYANJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:13:09 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for !MULTIPLATFORM
Date: Sat, 25 Feb 2006 11:12:33 +1100
User-Agent: KMail/1.8.3
Cc: Kumar Gala <galak@kernel.crashing.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602241717340.11527-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602241717340.11527-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1775872.qG02lxQnDg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602251112.38582.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1775872.qG02lxQnDg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 25 Feb 2006 10:18, Kumar Gala wrote:
> On Sat, 25 Feb 2006, Michael Ellerman wrote:
> > On Sat, 25 Feb 2006 09:43, Kumar Gala wrote:
> > > On Feb 24, 2006, at 4:27 PM, Michael Ellerman wrote:
> > > > Hi Kumar,
> > > >
> > > > On Sat, 25 Feb 2006 03:54, Kumar Gala wrote:
> > > >> mem=3D command line option was being ignored in arch/powerpc if we
> > > >> were not
> > > >> a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The
> > > >> initial
> > > >> command line extraction and parsing needed to be moved earlier in
> > > >> the boot
> > > >> process and have code to actual parse mem=3D and do something about
> > > >> it.
> > > >>
> > > >> @@ -1004,6 +991,41 @@ static int __init early_init_dt_scan_cho
> > > >>                 crashk_res.end =3D crashk_res.start + *lprop - 1;
> > > >>  #endif
> > > >>
> > > >> +	/* Retreive command line */
> > > >> + 	p =3D of_get_flat_dt_prop(node, "bootargs", &l);
> > > >> +	if (p !=3D NULL && l > 0)
> > > >> +		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
> > > >> +
> > > >> +#ifdef CONFIG_CMDLINE
> > > >> +	if (l =3D=3D 0 || (l =3D=3D 1 && (*p) =3D=3D 0))
> > > >> +		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > > >> +#endif /* CONFIG_CMDLINE */
> > > >> +
> > > >> +	DBG("Command line is: %s\n", cmd_line);
> > > >> +
> > > >> +	if (strstr(cmd_line, "mem=3D")) {
> > > >> +		char *p, *q;
> > > >> +		unsigned long maxmem =3D 0;
> > > >> +
> > > >> +		for (q =3D cmd_line; (p =3D strstr(q, "mem=3D")) !=3D 0; ) {
> > > >> +			q =3D p + 4;
> > > >> +			if (p > cmd_line && p[-1] !=3D ' ')
> > > >> +				continue;
> > > >> +			maxmem =3D simple_strtoul(q, &q, 0);
> > > >> +			if (*q =3D=3D 'k' || *q =3D=3D 'K') {
> > > >> +				maxmem <<=3D 10;
> > > >> +				++q;
> > > >> +			} else if (*q =3D=3D 'm' || *q =3D=3D 'M') {
> > > >> +				maxmem <<=3D 20;
> > > >> +				++q;
> > > >> +			} else if (*q =3D=3D 'g' || *q =3D=3D 'G') {
> > > >> +				maxmem <<=3D 30;
> > > >> +				++q;
> > > >> +			}
> > > >> +		}
> > > >> +		memory_limit =3D maxmem;
> > > >> +	}
> > > >> +
> > > >
> > > > Why not make the mem=3D parsing an early_param() handler and then c=
all
> > > > parse_early_param() here?
> > >
> > > This would put constraints on the early_param()'s that I dont think
> > > we should impose.
> >
> > All they should really be doing is parsing the string and setting some
> > variables, so that seems reasonable to me. Is there anything in
> > particular?
>
> If you ever had to do some memory allocation as part of the parsing that
> might be an issue, since we haven't setup the LMB at that point.

Sure, but I think it's reasonable to say "don't allocate memory in an=20
early_param handler", it is an _early_ param after all. But I guess we'll=20
have to agree to disagree until someone else chimes in with an opinion :)

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart1775872.qG02lxQnDg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/6D2dSjSd0sB4dIRAiKjAJ0Sbh1T4JQK7h+SenfgDHrDEAaHVACgnL6N
++oiuwADOA1uplxMY8E3zhY=
=+Eiq
-----END PGP SIGNATURE-----

--nextPart1775872.qG02lxQnDg--
