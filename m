Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUIACIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUIACIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 22:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUIACGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 22:06:02 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:63394 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S268783AbUIACFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 22:05:08 -0400
Message-ID: <41352E4B.1080709@slaphack.com>
Date: Tue, 31 Aug 2004 21:04:59 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: flx@msu.ru, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040829150041.GD9471@alias> <4133CA74.6070906@slaphack.com> <41341F08.7050401@namesys.com>
In-Reply-To: <41341F08.7050401@namesys.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
| David Masover wrote:
|
|>
|>
|> And I did mention before about how it'd be nice for it to be an fs
|> chunk...
|
|
| Please define fs chunk. My mind has an open door.;-)

I think this is sort of like dump/restore, but for a subset of the tree.
~ So it's faster for all the reasons dump/restore are faster than tar for
a whole filesystem.  But I don't know all that much about either
dump/restore or reiser4 format plugins.

I'm defining an "fs chunk" as a complete, read-only reiser4 filesystem
of the data in question.  As a snapshot.  I'm imagining it being faster
to create and ultimately smaller and more intelligently packed than a
tarball.

What if you could get a blocklist for a directory?  Of course some
things would have to be changed to completely divorce it from the parent
filesystem and have it still be usable.

I'm imagining that literally grabbing a chunk of the filesystem -- using
its own storage layer -- would be faster than tarring.  Think like if
directories had blocklists as well as files.  It would also be smaller
- -- see below.  And it completely eliminates the question of "what may I
never back up" -- the fs already knows that.  Without having to be told
by plugins.  If the fs stores it to disk, the backup stores it, unless
it's part of the "cache" proposal.

This is a rough idea, and has issues.  For instance, how do we know
what's cache and what's not?  If you have foo.gz/ugz cached and someone
writes to foo.gz/ugz, I think that should be written to the cache and
the original foo.gz should be removed -- regenerated if necessary from
foo.gz/ugz.  But the reverse is true -- write to foo.gz and foo.gz/ugz
should go away, to be regenerated if necessary.  Only one should go into
the backup, though.  I think foo.gz goes into the backup and is
regenerated from foo.gz/ugz if necessary.  More generally, when you have
two redundant streams, backup the smaller one.

|>
|> Imagine 5000 tiny little files that, by the time reiser's done with
|> them, fit inside 5 blocks or so. It's insanely cheaper to copy the five
|> blocks than to tar them up. It also means that we don't have to worry
|> about supporting tar on other platforms -- if they don't have reiser4,
|> they need a separate converter. If apps are going to use reiser4
|> metadata for anything significant, they probably would link against some
|> sort of userland implementation of reiser4 as a Windows library, say, to
|> access the files elsewhere.
|>
|> That's extreme, but you get the idea.
|
|

P.S.  Sorry for the dupe, Hans, accidently hit "reply" instead of
"reply-to-all"...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTUuS3gHNmZLgCUhAQKWCQ/+LTNqHvndRAMqzdAJ0rugZl30bqqPmrFs
vNqSwEx09RUxN6caOd+C4F7oVj/as0AJrNqyN5YR6/t6BKGxh+xEDnKdKiIRR5qp
/TJmsMSkh54MSqaZZPL5EB6/DjWscBN7zKCaaCN6f8xB6KU2BCOK5pNSHDvYhISA
uyD8AXrsOLRGC82dNtmh68KdrG+7VcTZMohulXNnosLLRJSuKeYEphB0i5HrvXQn
nZ010yb6LnmKtNKD+w7bFxt3ul+lQo8gti7zBJqb7mV4pa1MnQNhGZRgvey/Pq/l
ahXrrABauUFNwM4PfFWUoY9zjOdCufQpWev/mNGuoo9BS2ZiRg8LXoUpf2bOvi6I
yOTMRb37w6+w37Jv8B0vYPehW3bmuJpb+jDyZ5AYS0GygJmm3bEIFZYupYt2pU/v
7EBIzLszCEnqPbm0glGdWT5jyYiZGucvDK+W4qQ3ymEqaBIdGIti4G56mQ7bTQer
DPVT4dv38OE/PEtKb6xLQUaos7hBg+sWM5+mT9B+7kX/cYDhtdBkZpYqf10jAg34
4ufl2NS48CxqCcml7RayPVAuKT1ZN9sDcfXVYnPw33R94/lziZnfJrIInbnf9MZK
+P9v6WlFi6+9GZjwqFK9ZCJBoTCKRq1lGiy5flTDf1APAgpmU6CS/0Da4s1QiLLI
YRoeX8Nv8Us=
=WFSh
-----END PGP SIGNATURE-----
