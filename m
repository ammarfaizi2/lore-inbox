Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131006AbQKPQU0>; Thu, 16 Nov 2000 11:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbQKPQUQ>; Thu, 16 Nov 2000 11:20:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6155 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131006AbQKPQUF>; Thu, 16 Nov 2000 11:20:05 -0500
Date: Thu, 16 Nov 2000 07:49:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
cc: viro@math.psu.edu, linux-kernel@vger.kernel.org,
        Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.21.0011161400290.24271-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.LNX.4.10.10011160747260.2184-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Jean-Marc Saffroy wrote:
> 
> As you see, it looks like the rmdir fails simply because the dir name ends
> with a dot !! This is confirmed by sys_rmdir in fs/namei.c, around line
> 1384 :
> 
>         switch(nd.last_type) {
>                 case LAST_DOTDOT:
>                         error = -ENOTEMPTY;
>                         goto exit1;
>                 case LAST_ROOT: case LAST_DOT:
>                         error = -EBUSY;
>                         goto exit1;
>         }
> 
> Should we rip off the offending "case LAST_DOT" ? Or do we need a smarter
> patch ? Is it really a problem that a process has its current directory
> deleted ? How about the root ?

The cwd is not the problem. The '.' is.

The reason for that check is that allowing "rmdir(".")" confuses a lot of
UNIX programs, because it wasn't traditionally allowed.

> The man page for rmdir(2) should be updated as well, the current one
> states :
>        EBUSY  pathname is the current working directory  or  root
>               directory of some process.

That's definitely wrong. You can do 

	rmdir `pwd`

and that's fine (not all filesystems will let you do that, but that's a
low-level filesystem issue). It's really only the special names "." and
".." that cannot be removed.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
