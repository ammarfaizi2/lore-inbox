Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWJ3Pyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWJ3Pyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWJ3Pyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:54:35 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:29376 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030552AbWJ3Pye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:54:34 -0500
Message-ID: <45462036.5070104@comcast.net>
Date: Mon, 30 Oct 2006 10:54:30 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Avoidable floating point save/restore?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I found this from comp.os.minix (actually part of a MINIX FAQ):

=====CUT=====
From: kjb=733301@cs.vu.nl (Kees J Bot)
Subject: Re: MMX/3DNow support was RE: MINIX Development?
Date: Wed, 23 Jul 2003 20:15:03 +0200

This is really a hardware floating point issue, because the MMX
registers share the FP registers. This was done so that MMX unaware OSen
can still support MMX programs, because when they save and restore the
FP registers then the MMX state is also saved and restored if that
happens to be what the FP registers are used for. This saving and
restoring is what Minix doesn't do. So if two processes use FP/MMX then
a context switch from one to the other will clobber the FP state of
both. What is needed to make this work is a trap handler that reacts to
the use of FP, so that Minix can save the FP state of the process that
last used FP and load the FP state of the current process. On a context
switch Minix merely sets the "don't use FP" bit in some register. Costs?
One FP interrupt handler, some FP save/restore/setup code, some memory
per process to store the FP state into, and some memory to store the FP
state when a user process catches a signal. (Not sure about the signal
business, much check with Philip.) This isn't much work, we can simply
take Minix-vmd's code, but I haven't seen any need yet. Minix has to use
software FP as distributed, or it won't run on your old 386, so Minix
itself doesn't need it. Anyone here who wants to use Minix for some
heavy number crunching? If so then I could be persuaded to add an
ENABLE_FPU to the next release, by default off. I don't care about MMX,
that's way too exotic for Minix.
=====CUT=====

I'm trying to make heads or tails about what in the heck is going on
here.  It looks like they're saying you don't need to save/restore FP
registers between context switches unless one process uses FP and the
other uses MMX; but that doesn't make ANY sense at all.  If
gnome-session divides 3.14/2.28 and then gimp divides 3.33/2.22 and then
we switch BACK to gnome-session and it wants to divide the result by
1.92, wouldn't we need the FPU registers back in the exact state they
were at before switching away?

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRUYgNAs1xW0HCTEFAQJnqBAAgMjqTSA0OC6ThwUSoG4lO0uFCdUERJKl
O0Mxtq9XqKOU4W7XnCtIkBF0Gy1HdMm8/L1MXLRM0FMv6jz17nNb3TGvLRC/4KKh
vgl4KN/2D6tYYdKyh+v0n/zgVYGJ0lZn3sNQdBhxXet1Zjm6n7REFvJJD07PzIcm
XK5vciaVHYfNb0N3SdSL7JBJdMHzrbq2DmqUD5OsVOok37e1F3S4+T3EBZy+mk/i
D6lcx2KJzp8vIWmoskN+WLBox8fihSoNtxOK/oLComHwyJ3z1FEuILTvYqEjGUGg
k1TdEQYhTrFCjkpLgK5lhn1hD8dZRldN4bVEt9uWU5WiRCGiykPog3wlVz7T6bQr
SOAVKA4157kfDvG3KY55pNTxy0j8TgBWQhPyh/dTcRlzYbZuqccRcHQbYyBEGByZ
Of7tVUnHzgNd8kuzWqVh4ULDJ7YyNj+INFegoluLi/3JcQFL/EhoUYX/QNbX1VK1
vkrwGOneAC2KttjaH/cZHUuYfwZ1hkMmDjbkHlGmb4z56TRKOtUt03ziMDDhO4Fv
WWjVn+CdAiOTkhuVgIQ+EpnNCSP/yRUTmxDrI3+KJaIW6zlaAZyS29KoWA+EH75K
mJldV7amMcD+6KGVP7tHuTOpGXKYa2tCCfwtGI65Z7rWvGD6RUzz+waiT4kPav1G
1lObgtnarqY=
=fw5+
-----END PGP SIGNATURE-----
