Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266587AbUBQUud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUBQUud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:50:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:28600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266587AbUBQUti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:49:38 -0500
Date: Tue, 17 Feb 2004 12:49:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040217203056.GC24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402171236180.2154@home.osdl.org>
References: <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org> <Pine.LNX.4.58.0402171134180.2154@home.osdl.org>
 <20040217203056.GC24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Jamie Lokier wrote:
> 
> Nope.  That wouldn't help for a bundle of libraries that goes:
> 
>     1. Eliminate "." and ".." components, leaving only leading ".."s.

Who does this anyway? It's wrong. It gives the wrong answer if there was a 
symlink somewhere.

I remember this exact bug in gcc (I think), at some point - trying to
"optimize" the path "aa/bb/../cc" into "aa/cc" is WRONG WRONG WRONG. They
are not the same thing at all.

Any library that does the above is broken.

>     2. Reject path if it has a leading "..".
>     3. Shove it in a string with some other text and pass to other library.
> 
> Next program does:
> 
>     4. Extract path from string.
>     5. open ("/var/public/files/$PATH", ...)
> 
> O_NODOTDOT won't protect against that.

Ok, so explain why? O_NODOTDOT will certainly guarantee that it stays
inside "/var/public/files", since it has no way to escape (modulo
symlinks/mounts, of course).

The point being that with O_NODOTDOT | O_NOMOUNT | O_NOFOLLOW, you can
just do a simple "prepend my beginning pathname" operation, and do the
open that way without having to be careful.

Then, if the thing fails, you now need to be really careful, and perhaps
do a user-space "walk one component at a time" thing to see where it
failed. But what the O_NODOTDOT | O_NOMOUNT | O_NOFOLLOW thing gave you is
that you get a fast-path for the common case (ie you don't _always_ have
to do the "walk one component at a time" crud - only if you hit a case you
might be worried about).

(Now, O_NOMOUNT isn't actually useful if you use an absolute path like the
above example - it kind of assumes that you start from pwd which woul dbe
your "safe point", and that you expect all "safe" files to be under that
one filesystem. With an absolute path, you'll clearly often end up having 
to cross mount-points unless your whole thing is on the root filesystem, 
which kind of makes O_NOMOUNT useless in the first place).

Btw, right now O_NOMOUNT isn't a big issue, since only root can mount 
things anyway. But if we start allowing user mounts (likely with 
restrictions like you can only mount if the mount-point is owned by you 
and writable), O_NOMOUNT may actually become a good idea.

		Linus
