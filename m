Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUEMRjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUEMRjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUEMRjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:39:52 -0400
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:34573 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264329AbUEMRjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:39:48 -0400
In-Reply-To: <20040512221823.GK1397@holomorphy.com>
References: <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu> <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com> <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu> <20040512202807.GA16849@elte.hu> <20040512203500.GA17999@elte.hu> <20040512205028.GA18806@elte.hu> <20040512140729.476ace9e.akpm@osdl.org> <20040512211748.GB20800@elte.hu> <20040512221823.GK1397@holomorphy.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-45-936026051"
Message-Id: <61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com,
       davidel@xmailserver.org, Valdis.Kletnieks@vt.edu,
       Andrew Morton <akpm@osdl.org>
From: Paul Wagland <paul@wagland.net>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Date: Thu, 13 May 2004 19:38:44 +0200
To: William Lee Irwin III <wli@holomorphy.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-45-936026051
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Nit pick I'm sure... but....

On May 13, 2004, at 0:18, William Lee Irwin III wrote:

> Optimize the cases where HZ is a divisor of 1000 or vice-versa in
> JIFFIES_TO_MSECS() and MSECS_TO_JIFFIES() by allowing the 
> nonvanishing(!)
> integral ratios to appear as a parenthesized expressions eligible for
> constant folding optimizations.
>
>
> -- wli
>
>
> Index: linux-2.5/include/linux/time.h
> ===================================================================
> --- linux-2.5.orig/include/linux/time.h	2004-05-12 15:04:10.000000000 
> -0700
> +++ linux-2.5/include/linux/time.h	2004-05-12 15:12:49.000000000 -0700
> @@ -184,12 +184,12 @@
>   * Avoid unnecessary multiplications/divisions in the
>   * two most common HZ cases:
>   */
> -#if HZ == 1000
> -# define JIFFIES_TO_MSECS(x)	(x)
> -# define MSECS_TO_JIFFIES(x)	(x)
> -#elif HZ == 100
> -# define JIFFIES_TO_MSECS(x)	((x) * 10)
> -# define MSECS_TO_JIFFIES(x)	(((x) + 9) / 10)
> +#if HZ <= 1000 && !(1000 % HZ)
> +# define JIFFIES_TO_MSECS(j)	((1000/HZ)*(j))
> +# define MSECS_TO_JIFFIES(m)	(((m) + (1000/HZ) - 1)/(1000/HZ))
> +#elif HZ > 1000 && !(HZ % 1000)
> +# define JIFFIES_TO_MSECS(j)	(((j) + (HZ/1000) - 1)/(HZ/1000))
> +# define MSECS_TO_JIFFIES(m)	((m)*(HZ/1000))
>  #else
>  # define JIFFIES_TO_MSECS(x)	(((x) * 1000) / HZ)
>  # define MSECS_TO_JIFFIES(x)	(((x) * HZ + 999) / 1000)

Also, can we keep the same parameter name across all of the macros?

This changes behaviour when HZ==(z)000

JIFFIES_TO_MSECS  goes from
((x) * 1000) / (z)000  to (((x) + (z) - 1)/(z))

i.e. for x=1, z=2 this goes from ((1)*1000)/2000)=0 to (((1)+(2)-1)/2)=1

However, MSECS_TO_JIFFIES remains the same going from
(((x) * (z)000 + 999) / 1000) to ((x)*(z))

I.e. they basically reduce down to the same thing (modulo overflows)

All of the other permuations look correct to me...

Cheers,
Paul

--Apple-Mail-45-936026051
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAo7Kotch0EvEFvxURArAUAJwNpR4JSiDhL3UppN0nUK6JAj6P+ACfXGX+
sQEy00pbB2arDZ8XGgg3i0s=
=7wHH
-----END PGP SIGNATURE-----

--Apple-Mail-45-936026051--

