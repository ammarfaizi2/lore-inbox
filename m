Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbUJ1Vu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUJ1Vu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUJ1VsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:48:25 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:61949 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263037AbUJ1VnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:43:17 -0400
Date: Thu, 28 Oct 2004 14:42:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>
Subject: Re: Why UML often does not build (was: Re: [PATCH] UML: Build fix for TT w/o SKAS)
Message-ID: <20041028214242.GB2269@taniwha.stupidest.org>
References: <20041027053602.GB30735@taniwha.stupidest.org> <200410282104.30482.blaisorblade_spam@yahoo.it> <20041028193329.GF851@taniwha.stupidest.org> <200410282254.21944.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282254.21944.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 10:54:21PM +0200, Blaisorblade wrote:

> I'm not absolutely able, for instance, to understand the update for
> generic IRQs.

arch/um/kernel/irq.c is almost identical to the generic irq code
(ediff shows this nicely if that helps), the difference being
free_irq_by_irq_and_dev in free_irq --- which is why this was (nor
now) pushed into the UML drivers

i suspect the generated code before and after is almost identical

ideally this model needs a rework, but i don't see anyone having the
cycles to do this now so accommodating the generic-code is a sensible
solution for the interim

> For instance, Jeff rejected the mconsole-proc rewrite. So, I tried
> harder, then updated the patch to just #ifdef out his version, and
> was going to send it in.

it was later ACKed, you were cc'd on that email --- it's been merged

yes, that means we have merged code with slightly different semantics
than before --- but it also means it doesn't crash

you mentioned there is another solution to this --- i'd love to see
that before i rewrite this again to address Jeff's concern about the
requirement for /proc to be mounted (which is legitimate)

> 1) the Linux Kernel often breaks when using certain GCC versions or
> certain binutils, and has to be fixed.

this almost never happens these days, especially for i386 and amd64

i dont think i can recall it happenning in a big way for over a year
now

> But UML is a binary doing the most unusual things on the world
> around, so it must cope also with different versions of libc /
> binutils / host kernel.

UML also has to cope with ptrace changes and any semantics related to
this.  there has been some flux in this area recently and it's not
over yet sadly

UML is the most complicated ptrace-using code i think ive ever seen :)
and some of the code probably relies on semantics which are not well
defined so keeping up with those changes is important

part of that might be noticing when it breaks and screaming at roland,
i dont know

> 2) Uml is often not cared by mainline developers. It was merged in
> 2.6.9 and remained unworking for ages just because Linus ignored UML
> patches for ages.

was it submitted?  i really don't this the merge barrier is that high
from a maintainer for things like linux/arch/<foo> in most cases

the same is true for various drivers (it must be, so many of them are
horribly broken in places)

> And right now, if UML does not compile it's for the Ingo Molnar's
> hardirq patch and for a missed silly prototype change for a TTY api
> change (they fixed the UML user, ended up changing one UML function
> prototype, forgot to do a trivial update to one user.

UML has been described as 'abandonware' amongst other things, this
isn't completely unjustified.  Any efforts I think to help keep it
more inline with the rest of the kernel to change this perception I
think are great --- if we can get enough cleanups in, we might even be
able to get more of the mainline people buildling and checking against
UML so we get let breakage in the future.

I think to do this we should first fix some of the bogons we have
before adding new code and features.

> 4) We are too few. The currently active developers (and I mean only
> the one which this month have being working on it) are:

if we can get things more inline (fixes, track mainline, dont add new
features just yet) i think we can get more people to help out

right now it's too hard (too much effort) to most people to deal with

anyhow, i think enough has been said as we are mostly in voilent
agreement, if we can keep poking away at this i think we have a pretty
good shot and making UML less of a second-class citizen
