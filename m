Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262772AbTCKAyJ>; Mon, 10 Mar 2003 19:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbTCKAyJ>; Mon, 10 Mar 2003 19:54:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262772AbTCKAyH>; Mon, 10 Mar 2003 19:54:07 -0500
Date: Mon, 10 Mar 2003 17:02:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@user.it.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status
 field.
In-Reply-To: <200303110056.h2B0uo6U005286@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0303101658210.6802-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Mikael Pettersson wrote:

> On Mon, 10 Mar 2003 11:25:55 -0800 (PST), Linus Torvalds wrote:
> ...
> >As it was, the x86 state was pretty much random after fork(), and that can 
> >definitely lead to problems for real programs if they depend on things 
> >like silent underflow etc. 
> 
> Do you mean x87 control or the x87 stack here?

everything was random - the child would (if the fork() happened while the 
parent had a lazy pending x87 state) get a random state from somebody 
else.

HOWEVER: this only happens if the fork() actually has pending state on
that CPU, which is often not the case (if it has slept at all since the
last x87 op, or has been timesliced away etc, it won't have any pending
state on the CPU).

> >(Now, in _practice_ all processes on the machine tends to use the same
> >rounding and exception control, so the "random" state wasn't actually very
> >random, and would not lead to problems. It's a security issue, though).
> 
> Sorry for being dense, but can you clarify: will current 2.{2,4,5}
> kernels preserve or destroy the parent process' FPU control at fork()?

They're guaranteed to preserve the control state (it has to: you can't 
just change the exception mask over a function call). However, that was 
buggy at least in 2.5.x, and very possibly in 2.4.x too - haven't checked.

And since preserving the exception mask basically implies doing the whole 
fxsave/fxrestor thing, in practice _everything_ is saved over fork() into 
the child.

		Linus

