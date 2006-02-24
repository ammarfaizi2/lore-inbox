Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWBXW2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWBXW2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWBXW2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:28:07 -0500
Received: from ozlabs.org ([203.10.76.45]:65240 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932615AbWBXW2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:28:06 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for !MULTIPLATFORM
Date: Sat, 25 Feb 2006 09:27:32 +1100
User-Agent: KMail/1.8.3
Cc: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13277966.5RCjuinqP1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602250927.36954.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13277966.5RCjuinqP1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Kumar,

On Sat, 25 Feb 2006 03:54, Kumar Gala wrote:
> mem=3D command line option was being ignored in arch/powerpc if we were n=
ot
> a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The initial
> command line extraction and parsing needed to be moved earlier in the boot
> process and have code to actual parse mem=3D and do something about it.

> @@ -1004,6 +991,41 @@ static int __init early_init_dt_scan_cho
>                 crashk_res.end =3D crashk_res.start + *lprop - 1;
>  #endif
>
> +	/* Retreive command line */
> + 	p =3D of_get_flat_dt_prop(node, "bootargs", &l);
> +	if (p !=3D NULL && l > 0)
> +		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
> +
> +#ifdef CONFIG_CMDLINE
> +	if (l =3D=3D 0 || (l =3D=3D 1 && (*p) =3D=3D 0))
> +		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#endif /* CONFIG_CMDLINE */
> +
> +	DBG("Command line is: %s\n", cmd_line);
> +
> +	if (strstr(cmd_line, "mem=3D")) {
> +		char *p, *q;
> +		unsigned long maxmem =3D 0;
> +
> +		for (q =3D cmd_line; (p =3D strstr(q, "mem=3D")) !=3D 0; ) {
> +			q =3D p + 4;
> +			if (p > cmd_line && p[-1] !=3D ' ')
> +				continue;
> +			maxmem =3D simple_strtoul(q, &q, 0);
> +			if (*q =3D=3D 'k' || *q =3D=3D 'K') {
> +				maxmem <<=3D 10;
> +				++q;
> +			} else if (*q =3D=3D 'm' || *q =3D=3D 'M') {
> +				maxmem <<=3D 20;
> +				++q;
> +			} else if (*q =3D=3D 'g' || *q =3D=3D 'G') {
> +				maxmem <<=3D 30;
> +				++q;
> +			}
> +		}
> +		memory_limit =3D maxmem;
> +	}
> +

Why not make the mem=3D parsing an early_param() handler and then call=20
parse_early_param() here?

And I think a switch would be easier to read for the K/M/G handling.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart13277966.5RCjuinqP1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/4hYdSjSd0sB4dIRArQ/AKC368q4DSgCr+MJiQNqMATvRtJ3rwCfbl54
Gywv3o2JGw65e+zsRaJssgo=
=hWGX
-----END PGP SIGNATURE-----

--nextPart13277966.5RCjuinqP1--
