Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSKCGau>; Sun, 3 Nov 2002 01:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSKCGau>; Sun, 3 Nov 2002 01:30:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61363 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261612AbSKCGat>;
	Sun, 3 Nov 2002 01:30:49 -0500
Date: Sun, 3 Nov 2002 01:37:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.LNX.4.44.0211022128050.2633-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Nov 2002, Linus Torvalds wrote:

> Why? Because then the suid check will work, and not only will you get all 
> capabilities (_if_ the suid was root), you will also have changed your ID 
> (since that was how you got enough capabilities to be able to mask them 
> off).

Umm...  As for getting all capabilities, I was planning to do the following:
modify suid check to give you everything except the mask taken from vfsmount.
So that's no problem - this is exactly the place I would modify.
 
> Which you do _not_ want to do.  You just want the capabilities, you don't 
> necessarily want to run as somebody else (or if you do, that "somebody 
> else" might well be "nobody"). So suid vs capabilities are different: you 
> may even want them to be complementary.

Now, _that_ may be more serious.  However...

> In other words, it would actually make perfect sense to have 
> 
>   -r-sr-sr-x    1 nobody  mail  451280 Apr  8  2002 /usr/bin/sendmail
> 
>   mount --bind --capability=chown,bindlow /usr/bin/sendmail /usr/bin/sendmail

*blam*

Congratulations with potential crapload of security holes - now anyone
who'd compromised a process running as nobody can chmod the damn thing
and modify it.

And that is the reason why suid-nonroot is bad.  It creates a class of
binaries that can easily give you a root compromise if one of them has
an exploit - even if that one is never run by root.  That is the reason
why such things are done with sgid-nonroot and not with suid.  Member of
group can't chmod.  Owner can.  And yes, you can take away chmod - but
you need to do that for everything that will run with that UID.  Which
might be impossible - some might need chmod(2).

FWIW,
$ ls -l /usr/sbin/sendmail
-rwxr-sr-x    1 root     smmsp      617672 Oct  2 13:33 /usr/sbin/sendmail

- no suid at all.  And making it suid-nobody would decrease security.

Note that _all_ binaries that need any capabilities now are written to
be suid-root.  So the only case left from your scenario is
	* new binary
	* runs with UID of caller
	* wants some capabilities
	* doesn't want to be portable (it won't work on any other Unix,
since we had assumed that it doesn't want to be suid-root and still
relies on caps present)
	* doesn't use any of $BIGNUM portable mechanisms (separate
helpers, descriptor-passing, yadda, yadda).

Umm...  Do we really want to help these out?  We don't even have an
excuse of that being an important 3rd-party program brought from some
other system - it will be Linux-only and new, at that.

Now, _removal_ of capabilities on exec makes a whole lot of sense -
suid or not.  So IMO correct way to look at the stuff that adds them
as suid-root slighlty mitigated by removal of some things.

I can do addition of capabilities via the same mechanism - it's trivial.
But I really doubt that we want it as first-class thing.

Comments?

