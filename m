Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbSJCQGZ>; Thu, 3 Oct 2002 12:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSJCQGZ>; Thu, 3 Oct 2002 12:06:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4881 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261443AbSJCQGY>; Thu, 3 Oct 2002 12:06:24 -0400
Date: Thu, 3 Oct 2002 09:13:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Andreas Dilger <adilger@clusterfs.com>, <peterc@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Large Block device patch part 3/4
In-Reply-To: <15772.7481.604681.575483@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.44.0210030905520.2066-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002, Peter Chubb wrote:
> 
> No, because the purpose of the cast is to avoid dividing a 64-bit
> quantity by an int.  If you cast *after* the division,	you still end
> up doing a 64-bit division.

Note that you could just use "do_div64()", which does a 64/32->64 division
(which is a _hell_ of a lot faster than a generic 64/64 division, and it's
a shame that gcc is too stupid to generate the right code directly - since
it's trivially visible to the compiler when somebody does a 64/32
division).

NOTE! do_div() has some rather strange but usefule calling conventions (it
will change the 64-bit argument to be the result of the division, and the
actual return value is the 32-bit modulus). Those are just because it ends 
up being the most convenient way to efficiently return both values.

[ Explanation ]

The reason Linux doesn't include libgcc.a is that gcc is totally braindead
in some places, not because we don't like 64-bit divisions per se. Think
of it as a "uhhuh, if gcc needed libgcc.a, then gcc did something truly
horrible code generation" (and realize that quite often it is our fault,
it's not just gcc doing stupid things. 99% of the time we can just
simplify a division to a shift by hand, for example).

		Linus

