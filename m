Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPS7S>; Thu, 16 Nov 2000 13:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKPS7I>; Thu, 16 Nov 2000 13:59:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6890 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129076AbQKPS6v>;
	Thu, 16 Nov 2000 13:58:51 -0500
Date: Thu, 16 Nov 2000 13:28:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.21.0011161904580.30811-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.GSO.4.21.0011161317120.13047-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Jean-Marc Saffroy wrote:

> On Thu, 16 Nov 2000, Linus Torvalds wrote:
> 
> > The cwd is not the problem. The '.' is.
> > 
> > The reason for that check is that allowing "rmdir(".")" confuses a lot of
> > UNIX programs, because it wasn't traditionally allowed.
> 
> This is a point I don't understand here : do you mean that they are
> confused if they can rmdir "." but not if they can rmdir their cwd
> differently ? What's the difference ?

rmdir() is _not_ "kill the directory identified by name and remove all
links to it". It's "remove a given link and .. in directory pointed
by it, then schedule directory for removal".

BTW, cwd is irrelevant - /tmp/foo/. would demonstrate the same behaviour.

It becomes really obvious when you look at rename() - you act on links,
not on inodes. The only reason why we could try to overload that for
directories was that there is a special link - one from the parent.
However, _finding_ said link in race-free way is extremely nasty.
Especially for cases like /tmp/foo/. where /tmp/foo is a symlink to
/tmp/bar/baz. AFAIK Linux was the only system that tried to be smart
in that area. And that attempt was _not_ successful - there were rather
interesting races around the thing. Besides, we clearly violated
all relevant standards - rmdir() and rename() are required to fail
if the last component of name happens to "." or "..".

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
