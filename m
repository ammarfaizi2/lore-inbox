Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261632AbTCKVv5>; Tue, 11 Mar 2003 16:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbTCKVv5>; Tue, 11 Mar 2003 16:51:57 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:27325 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261632AbTCKVvy>;
	Tue, 11 Mar 2003 16:51:54 -0500
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
In-Reply-To: <3E6E5989.6060301@mvista.com>
References: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>
	 <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>
	 <3E6E5989.6060301@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FDVI/z4gXZBvDBsHHj+z"
Organization: 
Message-Id: <1047419933.16615.704.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 13:58:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FDVI/z4gXZBvDBsHHj+z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-03-11 at 13:47, george anzinger wrote:
> Some comments below on the scaling.

Thanks, I'll try to digest your comments and get back to you.


> On a related note, I would like to extend the CLOCK_MONOTONIC code to=20
> the same res as CLOCK_REALTIME in the POSIX clocks and timers patch.=20
> The patch uses jiffies_64 for CLOCK_MONOTONIC, so what I would like to=20
> do is use get_offset() to fill in the sub_jiffies part. Is this=20
> function available (i.e. timer->get_offset()) on all archs?


Nope, the timer_opts structure is i386 only. Further, the need for the
monotonic_clock() interface is because timer->get_offset() only returns
32bits of information, which on a 2Ghz cpu is only ~2 seconds worth of
time. We need multiple minutes worth of time to be returned, thus the 64
bit return of monotonic_clock.=20

I considered making get_offset() return a 64bit value, but worried that
the cost of the 64bit math would hurt gettimeofday too much to be worth
it. So rather then complicate a heavily used function to handle a very
rare case, we decided to implement a new interface that doesn't need to
be as fast as gettimeofday, but can handle long periods of time w/o
interrupts.


> It seems to me that the lost jiffies should be rolled into=20
> get_offset().  Have you considered doing this?

I'm not sure I'm following this? get_offset returns the amount of time
since mark_offset() was called(last interrupt). The lost-jiffies
compensation code I added uses get_offset() to detect how many jiffies
should have passed. How do you suggest rolling it into get_offset?

thanks
-john



--=-FDVI/z4gXZBvDBsHHj+z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+blwdMDAZ/OmgHwwRAlLDAJ9DAN0+YzVOoNBa7Bg9LoSC5a2xQQCfYImz
LGjkLBgL4l9CRN0XRIY4qSo=
=zp/J
-----END PGP SIGNATURE-----

--=-FDVI/z4gXZBvDBsHHj+z--

