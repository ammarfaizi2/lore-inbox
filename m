Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSKCEW1>; Sat, 2 Nov 2002 23:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSKCEWY>; Sat, 2 Nov 2002 23:22:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12673 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261613AbSKCEWX>;
	Sat, 2 Nov 2002 23:22:23 -0500
Date: Sat, 2 Nov 2002 23:28:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211022310240.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> But I like Al's idea of mount binds even more, although it requires maybe
> a bit more administration.

OK, will do - will be fun to take a break from drivers/* and devfs excrements
I'm digging in...

BTW, here's a fresh demonstration (found half an hour ago) that capabilities
do *not* permit more lax attitude when writing stuff with elevated priveleges:
	* /usr/lib/games/nethack/recover is run at the boot time (as root)
to recover crashed games.
	* Debian nethack 3.4.0-3.1 has it installed root.games and it
is group-writable - cretinism in debian/rules, upstream is not guilty
in that (BTW, so is /usr/lib/games/nethack/recover-helper).
	* ergo, any exploitable hole in sgid-games binary (rogue, for
instance) is trivially elevated to root exploit.

	Capabilities will *not* help that one - suid-games binaries need
to be able to write as 'games', that's the whole reason why they are
suid-games.  Normally they use it to create save files.  And quite a
few of them are ripe with exploits - c.f. recent rogue(6) holes.

	Normally that would lead only to ability to screw others' save
files (and potentially to compromise their accounts, if corrupted save
file can trigger a hole in another game).  Besides, many of these beasts
are old and didn't get too much attention.

	Now, combined with packaging fuckup (which is a nice prototype of
ACL fuckups to come) we get a lovely path leading to root exploit.  Bugger
all, one *still* has to think when writing code.  A shame, isn't it?

