Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUIZSTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUIZSTb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUIZSTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 14:19:31 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15299 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261451AbUIZST0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 14:19:26 -0400
Message-ID: <4157083E.8050200@comcast.net>
Date: Sun, 26 Sep 2004 14:19:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gnoppix-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Compressed Memory, Feature Enhancements
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(I'm not subscribed to gnoppix-devel, CC me replies)

(LKML readers:  Look to the end for why this is on LKML; the rest is
here just to give you a RL scenario)

I have been wrestling with the idea of multi-CD gnoppix for about 5
minutes now, and upon looking at another problem, I think I've gotten
the answer.

Gnoppix requires several things to run.  They are, obviously, the icon
and window theme, X itself, Gnome itself, init, and the core daemons
that run at boot.

With the ability to cache to a tmpfs, these things could be loaded and
Gnoppix could be logged into Gnome with the user not running anything
else, and being able to switch CDs.  This would have pitfalls, of
course; cds can't be changed if the user is running another program.

Two things can be done to be done to handle this.  First, the most
common programs can be on both CDs (i.e. web browser, GAIM, XMMS).  The
problem here is that you can't predict the combination variations that
the user wants to use programs in; and the user can't switch CDs while
any program is running.

A more sophiscated approach could be used instead of or in conjunction
with the first.  Gnoppix could have a database (on the CD of course) of
which files a program needs.  It could be capable of allowing a user to
transfer programs including all dependent libs to tmpfs, calculating the
amount of memory it'd need to use based on what libs are already
transfered (from grabbing other apps) and what's left to go and warning
the user how much he's going to use.  In this way, the main Gnoppix CD
could be supplimented by an applications CD which could load programs to
the tmpfs.

The second approach has many implications.  First, programs can be
transferred off the tmpfs later, only when they're not running.  This
would include restarting X and in the process removing X and Gnome from
the tmpfs to free up memory (re-symlinking them up to the CD).  This
would allow a user to boot Gnoppix, grab apps off CD2, and free up the
memory for Gnome and X.

This method also needs a lot of ram, and thus would NEED to be optional,
and selected at boot time.  Enabling it by default leaves Gnoppix
unbootable on many machines with modest amounts of memory.

*******************************************************************
*(LKML readers may like to start reading here if avoiding the above fluff)*
*******************************************************************

To further enhance this method, two venues could be taken.  The first,
most obvious would be that memory could be compressed.  Unfortunately,
the compressed page cache patch at http://linuxcompressed.sf.net/ hasn't
been updated, and the author is a busy man.  I'm not going to do it,
because I'm no kernel hacker, and I'm too busy myself to grok the kernel
and learn its innards.

This method of course has other benefits; Gnoppix/Knoppix won't always
run on a machine with a hard disk, or on one with a disk they can use
for swap.  Thus, other methods are needed to move the upper bound of
memory a bit farther.  With WK4x4 and WKdm compression algorithms, I've
seen Rodrigo's patch do a good 30-50% compression ratio; I don't recall
being able to get it below 20%.  At least 2M for every 10M of memory is
an aweful damn lot.

The second avenue would be to have a tmpfs that behaves like a zisofs
(transparantly handling compressed files); or even better, some sort of
generic compressed file objects architecture.  This would allow the
files to be directly compressed on the tmpfs as they are on the isofs.

This method has the benefit of allowing tmpfs users to eat less ram with
tmpfs.  In the case of a generic compressed-file-on-disk architecture,
users mounting with the "compress" option (or rootfs=compress or such on
the kernel command line) would gain more disk space.  Obviously it can
be abused (i.e. compressed swap file!) to the point that the system eats
itself alive; but it's useful.

Combining both methods would be viable as well.  The compressed cache
method would need to not compress pages that get bigger, of course; in
that scenario, it would peacefully and properly coexist with compressed
tmpfs.

It's in the interest of livecd vendors like Gnoppix and Knoppix for the
compressed page cache patch to work; because it has a definite and
demonstratable use, it may also be in the interest of some kernel
developers to log some time up-porting or re-implementing it.  The
compressed tmpfs/generic compressed file architecture concept may also
be of interest, but may be mitigated by compressed cache.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBVwg9hDd4aOud5P8RAlmdAJ4vhdYLt1yCUAieBN4R0be2Zjkv4gCfaSba
G/e2M503+Q+322AF5juxqIo=
=9gaw
-----END PGP SIGNATURE-----
