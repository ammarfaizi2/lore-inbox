Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRDUWQi>; Sat, 21 Apr 2001 18:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRDUWQ2>; Sat, 21 Apr 2001 18:16:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7691 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132959AbRDUWQU>;
	Sat, 21 Apr 2001 18:16:20 -0400
Message-ID: <3AE206AC.E196AEBA@linux-m68k.org>
Date: Sun, 22 Apr 2001 00:16:12 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Roman Zippel <zippel@fh-brandenburg.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Races in affs_unlink(), affs_rmdir() and affs_rename()
In-Reply-To: <Pine.GSO.4.21.0104211457420.25186-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alexander Viro wrote:

> unlink("/B/b") locks /B, removes "b" and unlocks /B. Then it calls
> affs_remove_link(), which blocks.
> 
> unlink("/A/a") locks /A, removes "a" and unlocks /A. Then it calls
> affs_remove_link(). Which locks /B, renames removed entry into "b",
> removes old "b" and inserts renamed "a" into /B.
> 
> The rest is irrelevant - we're already in it.

Thanks for finding that one, but it should be easy to fix. I can remove
the parent pointer in aff_remove_hash and check for that before I try to
rename that entry.

> Since you don't lock /B for affs_empty_dir(), you can hit the
> window between removing old /B/a and inserting renamed /A/a into /B.
> Notice that VFS _does_ lock /B (->i_zombie), but affs_remove_link()
> for /A/a doesn't even look at it.

I thought about that one and I know it should be locked. The reason I
don't do right now is, that affs supports hardlinks to dirs. The problem
are especially recursive links, e.g.:

mkdir A
ln A A/B
rm A/B

This is possible with affs, but will already deadlock in vfs.

mkdir A
mkdir A/B
ln A A/B/C
rm A/B/C/A &
rm A/B/C &
rm A/B

Every rm already takes the hash lock of the parent and then I can't
simply also take the hash lock of the dir itself. What I actually want
to do is to insert a reverse is_subdir() check before taking the lock.
On the other hand I was thinking whether I should allow links to dirs at
all and just show them as empty/readonly dirs. For 2.4 that's probably
safer, as it would require a lot of locking changes in vfs and the other
fs to support this properly, particularly moving most of the locking
from vfs into the fs.

bye, Roman
