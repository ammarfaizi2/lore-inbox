Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWAMKwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWAMKwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWAMKwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:52:14 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:59865 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964823AbWAMKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:52:14 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Fri, 13 Jan 2006 21:51:53 +1100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <20051227190918.65c2abac@localhost> <200601131213.14832.kernel@kolivas.org> <20060113114607.54c83fc8@localhost>
In-Reply-To: <20060113114607.54c83fc8@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2146720.FDNXKrIOLz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132151.55742.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2146720.FDNXKrIOLz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 13 January 2006 21:46, Paolo Ornati wrote:
> On Fri, 13 Jan 2006 12:13:11 +1100
>
> Con Kolivas <kernel@kolivas.org> wrote:
> > Can you try the following patch on 2.6.15 please? I'm interested in how
> > adversely this affects interactive performance as well as whether it
> > helps your test case.
>
> "./a.out 5000 & ./a.out 5237 & ./a.out 5331 &"
> "mount space/; sync; sleep 1; time dd if=3Dspace/bigfile of=3D/dev/null
> bs=3D1M count=3D256; umount space/"
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  5445 paolo     16   0  2396  288  228 R 34.8  0.1   0:05.84 a.out
>  5446 paolo     15   0  2396  288  228 S 32.8  0.1   0:05.53 a.out
>  5444 paolo     16   0  2392  288  228 R 31.3  0.1   0:05.99 a.out
>  5443 paolo     16   0 10416 1104  848 R  0.2  0.2   0:00.01 top
>  5451 paolo     15   0  4948 1468  372 D  0.2  0.3   0:00.01 dd
>
> DD test takes ~20 s (instead of 8s).
>
> As you can see DD priority is now very good (15) but it still suffers
> because also my test programs get good priority (15/16).
>
>
> Things are BETTER on the real test case (transcode): this is because
> transcode usually gets priority 16 and "dd" gets 15... so dd is quite
> happy.

This seems a reasonable compromise. In your "test app" case you are using=20
quirky code to reproduce the worst case scenario. Given that with your quir=
ky=20
setup you are using 3 cpu hogs (effectively) then slowing down dd from 8s t=
o=20
20s seems an appropriate slowdown (as opposed to the many minutes you were=
=20
getting previously).

See my followup patches that I have posted following "[PATCH 0/5] sched -=20
interactivity updates". The first 3 patches are what you tested. These=20
patches are being put up for testing hopefully in -mm.

> BUT what is STRANGE is this: usually transcode is stuck to priority 16
> using about 88% of the CPU, but sometimes (don't know how to reproduce
> it) its priority grows up to 25 and then stay to 25.
>
> When transcode priority is 25 the DD test is obviously happy: in
> particular 2 things can happen (this is expected because I've observed
> this thing before):
>
> 1) priority of transcode stay to 25 (when the file transcode is
> reading from, through pipes, IS cached).
>
> 2) CPU usage and priority of transcode go down (the file transcode is
> reading from ISN'T cached and DD massive disk usage interferes with
> this reading). When DD finish trancode priority go back to 25.

I suspect this is entirely dependent on the balance between time spent read=
ing=20
on disk, waiting on pipe and so on.

Thanks for your test case and testing!

Cheers,
Con

--nextPart2146720.FDNXKrIOLz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx4ZLZUg7+tp6mRURAnnVAKCSIwrFX7Dwzb6M2EJOKcNhr2GbywCfSWUX
+GsMhmpofhiOoJd0vIFLCkY=
=ASvH
-----END PGP SIGNATURE-----

--nextPart2146720.FDNXKrIOLz--
