Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPTWQ>; Thu, 16 Nov 2000 14:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKPTV4>; Thu, 16 Nov 2000 14:21:56 -0500
Received: from sisley.ri.silicomp.fr ([62.160.165.44]:23567 "EHLO
	sisley.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S129069AbQKPTVz>; Thu, 16 Nov 2000 14:21:55 -0500
Date: Thu, 16 Nov 2000 19:51:48 +0100 (CET)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.GSO.4.21.0011161317120.13047-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011161934370.30811-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Alexander Viro wrote:

> > This is a point I don't understand here : do you mean that they are
> > confused if they can rmdir "." but not if they can rmdir their cwd
> > differently ? What's the difference ?
> 
> rmdir() is _not_ "kill the directory identified by name and remove all
> links to it". It's "remove a given link and .. in directory pointed
> by it, then schedule directory for removal".

Now I see your point : by "." or "foo/." you mean the directory itself,
while "foo" or "foo/" refer to the link to the directory, and they are
obviously different objects... at least since hard links on directories
were introduced. Fine.

> BTW, cwd is irrelevant - /tmp/foo/. would demonstrate the same behaviour.

We saw it, and found it shocking for the very same reasons...

> It becomes really obvious when you look at rename() - you act on links,
> not on inodes. The only reason why we could try to overload that for
> directories was that there is a special link - one from the parent.
> However, _finding_ said link in race-free way is extremely nasty.
> Especially for cases like /tmp/foo/. where /tmp/foo is a symlink to
> /tmp/bar/baz. AFAIK Linux was the only system that tried to be smart
> in that area. And that attempt was _not_ successful - there were rather
> interesting races around the thing.

Ok, now I get it. Thanks for this much clearer explanation.

I guess that this was not a problem in 2.2 precisely because hard links on
directories were forbidden, right ?

> Besides, we clearly violated
> all relevant standards - rmdir() and rename() are required to fail
> if the last component of name happens to "." or "..".

By standard, do you imply 'de facto' ? Or does any source clearly state
this ?

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:jms@migrantprogrammer.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
