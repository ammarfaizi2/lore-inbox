Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTE1ODo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTE1ODo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:03:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47374 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263250AbTE1ODn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:03:43 -0400
Date: Wed, 28 May 2003 07:16:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ryan Anderson <ryan@michonline.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sparse errors
In-Reply-To: <20030528053832.GH585@michonline.com>
Message-ID: <Pine.LNX.4.44.0305280703520.7569-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 May 2003, Ryan Anderson wrote:
>
> I'm not totally grokking how sparse is put together yet, but I've got
> this:
> 
> Some symbols with type SYM_NODE are getting ctype->base_type==NULL,

This means they have no type at all, either because of a parse error, or 
because the lazy evaluation hasn't evaluated it yet (ie it was a tad _too_ 
lazy).

> causing a segfault in type_difference:422.   (If I work around that one,
> there's another spot at line 680.  I started to follow what was going on
> a bit at that point and realized they were probably symptoms, not the
> actual bug, so I stopped working around it.)

Right.

The first thing to do is to see where it happens, in gdb do

	up 		(to get to compatible_assignment_types)
	p expr->pos	(to get where in the soruce file it is)

it's triggered in cramfs_uncompress_block():

	zlib_inflateReset(&stream);

on "stream", and the problem _seems_ to be that the target type for the
function call comparison is non-existent.

And that, in turn, seems to be because of the old K&R style function 
prototype due to

#ifndef OF /* function prototypes */
#  ifdef STDC   
#    define OF(args)  args
#  else
#    define OF(args)  ()
#  endif
#endif

and check not defining STDC.

It appears to be fixed by just adding -DSTDC to the check command line, to 
make zlib use ANSI prototypes.

In short: sparse doesn't handle K&R function declarations very well,
although clearly it shouldn't have segfaulted (it should have warned about
it). I don't know why it didn't warn.

> Oh, BTW, the way you have struct ctype_sym declared inside struct symbol
> confuses the crap out of gdb, but gcc appears to like it, so... *shrug*.

Yeah, gdb is crap when it comes to anonymous structures, but I can't live 
without them these days, so..

> Should this be cc:ed to linux-kernel, or do you have another place in
> mind?

It probably shouldn't be CC'd to linux-kernel, but there isn't any other 
place either.

		Linus

