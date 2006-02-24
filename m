Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWBXX03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWBXX03 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWBXX03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:26:29 -0500
Received: from ozlabs.org ([203.10.76.45]:12003 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964793AbWBXX02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:26:28 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for !MULTIPLATFORM
Date: Sat, 25 Feb 2006 10:25:49 +1100
User-Agent: KMail/1.8.3
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org> <200602250927.36954.michael@ellerman.id.au> <815A460C-BAB0-4770-8357-68136D31EDC3@kernel.crashing.org>
In-Reply-To: <815A460C-BAB0-4770-8357-68136D31EDC3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5393860.eOWRnffA4e";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602251025.55741.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5393860.eOWRnffA4e
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 25 Feb 2006 09:43, Kumar Gala wrote:
> On Feb 24, 2006, at 4:27 PM, Michael Ellerman wrote:
> > Hi Kumar,
> >
> > On Sat, 25 Feb 2006 03:54, Kumar Gala wrote:
> >> mem=3D command line option was being ignored in arch/powerpc if we
> >> were not
> >> a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The
> >> initial
> >> command line extraction and parsing needed to be moved earlier in
> >> the boot
> >> process and have code to actual parse mem=3D and do something about it.
> >>
> >> @@ -1004,6 +991,41 @@ static int __init early_init_dt_scan_cho
> >>                 crashk_res.end =3D crashk_res.start + *lprop - 1;
> >>  #endif
> >>
> >> +	/* Retreive command line */
> >> + 	p =3D of_get_flat_dt_prop(node, "bootargs", &l);
> >> +	if (p !=3D NULL && l > 0)
> >> +		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
> >> +
> >> +#ifdef CONFIG_CMDLINE
> >> +	if (l =3D=3D 0 || (l =3D=3D 1 && (*p) =3D=3D 0))
> >> +		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> >> +#endif /* CONFIG_CMDLINE */
> >> +
> >> +	DBG("Command line is: %s\n", cmd_line);
> >> +
> >> +	if (strstr(cmd_line, "mem=3D")) {
> >> +		char *p, *q;
> >> +		unsigned long maxmem =3D 0;
> >> +
> >> +		for (q =3D cmd_line; (p =3D strstr(q, "mem=3D")) !=3D 0; ) {
> >> +			q =3D p + 4;
> >> +			if (p > cmd_line && p[-1] !=3D ' ')
> >> +				continue;
> >> +			maxmem =3D simple_strtoul(q, &q, 0);
> >> +			if (*q =3D=3D 'k' || *q =3D=3D 'K') {
> >> +				maxmem <<=3D 10;
> >> +				++q;
> >> +			} else if (*q =3D=3D 'm' || *q =3D=3D 'M') {
> >> +				maxmem <<=3D 20;
> >> +				++q;
> >> +			} else if (*q =3D=3D 'g' || *q =3D=3D 'G') {
> >> +				maxmem <<=3D 30;
> >> +				++q;
> >> +			}
> >> +		}
> >> +		memory_limit =3D maxmem;
> >> +	}
> >> +
> >
> > Why not make the mem=3D parsing an early_param() handler and then call
> > parse_early_param() here?
>
> This would put constraints on the early_param()'s that I dont think
> we should impose.

All they should really be doing is parsing the string and setting some=20
variables, so that seems reasonable to me. Is there anything in particular?

> > And I think a switch would be easier to read for the K/M/G handling.
>
> I should probably use memparse() now that I've found it :)

Even better.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart5393860.eOWRnffA4e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/5YDdSjSd0sB4dIRAhUDAJ4+bptWvLm5OPmnwlivi9plF1U2swCfWGO7
IrTp+TrsPDZHUSPDajJGI44=
=IMB2
-----END PGP SIGNATURE-----

--nextPart5393860.eOWRnffA4e--
