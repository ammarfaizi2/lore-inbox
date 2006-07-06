Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWGFGjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWGFGjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGFGjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:39:05 -0400
Received: from pool-72-66-201-79.ronkva.east.verizon.net ([72.66.201.79]:45507
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030219AbWGFGjE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:39:04 -0400
Message-Id: <200607060638.k666cf8V003016@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Thu, 06 Jul 2006 02:37:25 +0200."
             <Pine.LNX.4.64.0607051406480.12900@scrub.home>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home> <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home> <Pine.LNX.4.64.0606281335380.17704@scrub.home> <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu> <1151695569.5375.22.camel@localhost.localdomain> <200606302104.k5UL41vs004400@turing-police.cc.vt.edu> <Pine.LNX.4.64.0607030256581.17704@scrub.home> <200607050429.k654TXUr012316@turing-police.cc.vt.edu>
            <Pine.LNX.4.64.0607051406480.12900@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152167921_2733P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jul 2006 02:38:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152167921_2733P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Jul 2006 02:37:25 +0200, Roman Zippel said:

> Ok, I see now the problem, the last cycle value is always at least 50 
> times incremented between adjustments and that also means any error 
> adjustment is applied at least 50 times, which quickly gets out of 
> control.
> Is it possible that your console output is really slow? Otherwise I can't 
> explain these numbers, everything looks initialized fine for a 1.6GHz 
> clock, but it seems to take ages to print a single line.

Oh.. this is a real Homer Simpson moment.... "D'Oh!" :)

The grub definition:

title 2.6.17-mm2 testing
        kernel /vmlinuz-2.6.17-mm2-test single console=tty0 vga=794
        initrd /initrd-selinux.img

Yes, this laptop has a real actual DB-9 serial port on the back, and I've had
it defined as a console for forever (since trying to debug a problem against
2.5.60 or so).  So maybe that's where it's coming from.  But a quick boot
test or 3 shows the console=tty0 isn't the problem.  It turns out to be
the 'vga=794', which selects this mode:

[   16.633604] Console: colour dummy device 80x25
[   17.685983] Console: switching to colour frame buffer device 160x64

And we promptly get a timing problem.  I tried booting with 'vga=ask' and
choosing mode 1, and got this mode instead:

[   31.003715] Console: colour VGA+ 80x50

And things came up fine at that point.  Apparently, trying to scroll a big
160x64 is sufficiently slower than scrolling an 80x50 to trigger the problem.

I'd look at John's patch in the morning:

> Implement P-D control for clocksource_adjust()

> diff --git a/kernel/timer.c b/kernel/timer.c
> index 396a3c0..f4e7681 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1007,81 +1007,108 @@ static int __init timekeeping_init_devic

Too many 2:30AM's in the past 2 weeks for a guy my age.. (Actually, the
2:30AM isn't the problem - it's the office hours 7 hours later. ;)


--==_Exmh_1152167921_2733P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErK/xcC3lWbTT17ARAmJkAJwIXej8/Jx09YSak22rMC9Xn0N4RACdHVBB
2gLPCv9RMG01xBf1wAdSPnw=
=mIlg
-----END PGP SIGNATURE-----

--==_Exmh_1152167921_2733P--
