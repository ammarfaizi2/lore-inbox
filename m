Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUAHKaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUAHKaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:30:07 -0500
Received: from [193.138.115.2] ([193.138.115.2]:54532 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264265AbUAHKaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:30:00 -0500
Date: Thu, 8 Jan 2004 11:27:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl -
 arg is unsigned.
In-Reply-To: <Pine.LNX.4.58.0401071846160.2131@home.osdl.org>
Message-ID: <Pine.LNX.4.56.0401081034200.10083@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk>
 <Pine.LNX.4.58.0401071846160.2131@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jan 2004, Linus Torvalds wrote:
>
> On Thu, 8 Jan 2004, Jesper Juhl wrote:
> >
> > The 'arg' argument to the function do_fcntl in fs/fcntl.c is of type
> > 'unsigned long', thus it can never be less than zero (all callers of
> > do_fcntl take unsigned arguments as well and pass on unsigned values),
>
> I'm not sure I like these kinds of patches.
>

Ok, let me try and argue in favour of it, and if you think the arguments
are bogus then I won't be doing any more of this type of patches.


> I _like_ the code being readable.

I can't argue with that, but I don't think this patch actually decreases
readabillity. It's still perfectly clear what the remaining code does, and
if anybody is wondering if 'arg' could ever be <0 then a quick glance at
the type will answer that.

Would you like this sort of patch better if removing the code went
hand-in-hand with the addition of a one-line comment stating something
like  /* the test for arg < 0 is not done since arg is unsigned */ or ?


>  The fact that the compiler can optimize
> away one of the tests if the type is right i2Ds fine. It seems to be
> draconian to remove code that is correct and safe, especially when the
> code has no real downsides to it.

>From my point of view it's a matter of correctness. Testing an unsigned
value for <0 makes no sense, and doing things that make no sense is a bad
habbit in my oppinion. Yes, the code will be optimized away, so it doesn't
actually do any harm, and in this case it's a very small amount of code,
but that's not always so. A little while ago I posted a similar patch that
removes some dead code in (amongst others) ReiserFS, and in that case it's
a bit more code (not much, but a bit more) and there I think removing the
impossible code makes the code easier to read since a person trying to
find out what's going on does not have to spend time tracing the workings
of something that can never execute in any case.


>
> Do we have a compiler that needlessly complains again?
>

Gcc /will/ warn about the fact that the result of an unsigned comparison
with <0 is always false if the code in question is compiled with
"-W -Wall", with the standard compile options no such warning is given.


> Sometimes it is the _complaints_ that are bogus.
>

I'm not arguing against that. My mission here is not to silence any
warning just for the sake of silencing the warning, although I must admit
that I am trying to get rid of as many potential warnings as I can - It
would be nice to be able to compile the kernel with "-W -Wall" and not
have the output too cluttered, and some of the things that gcc will warn
about could potentially hide real bugs, so I believe it's a valid
exercise. But my real goal is mainly to find and fix potential problems,
squishing potential warnings is a secondary bennefit.


-- Jesper Juhl

