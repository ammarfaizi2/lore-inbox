Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317682AbSFSAAO>; Tue, 18 Jun 2002 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317683AbSFSAAN>; Tue, 18 Jun 2002 20:00:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49157 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317682AbSFSAAL>; Tue, 18 Jun 2002 20:00:11 -0400
Date: Tue, 18 Jun 2002 16:57:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH+discussion] symlink recursion
In-Reply-To: <UTC200206182219.g5IMJru27250.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.33.0206181646220.2562-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002 Andries.Brouwer@cwi.nl wrote:
> 
> As promised below an implementation of nonrecursive symlink resolution.

There is no such thing as a non-recursive symlink resolution.

Symlink walking is by it's very nature recursive, since we have to be able 
to look a symlink up in the middle of another one.

So either it's recursive in C (caller ends up calling itself) or it
linearizes the recursion by hand (caller keeps track of the stack by hand
using a linked list or by expanding the pathname in place or whatever,
instead of using the C stack).

Both are recursive, it's only a question of whether the recursion is
handled by the language or by hand, and whether the interim state is held
on the stack or in explicit data structures.

I see no advantages to handling it by hand, since this isn't even a very
deep recursion, and since even if you do the recursive part by hand by a
linked list you still need to limit the depth _anyway_ to avoid DoS
attacks.

In fact, we avoid following symlinks too deeply even for the
_non_recursive_ case (see "total_link_count") exactly because of these DoS
issues.

Could we allow deeper recursion if we did it by hand? Sure. Are there any
real advantages in 15 levels of recursion over 5 levels of recursion? I
don't see any.

			Linus

