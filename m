Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318864AbSHEUTw>; Mon, 5 Aug 2002 16:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318865AbSHEUTw>; Mon, 5 Aug 2002 16:19:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29715 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318864AbSHEUTv>; Mon, 5 Aug 2002 16:19:51 -0400
Date: Mon, 5 Aug 2002 13:23:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating usermode
 linux]
In-Reply-To: <17boD0-1BMTyaC@fmrl08.sul.t-online.com>
Message-ID: <Pine.LNX.4.44.0208051317480.11693-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Aug 2002, Oliver Neukum wrote:
> 
> > Also, people who play games with FP actually change the FP data on the
> > stack frame, and depend on signal return to reload it. Admittedly I've
> > only ever seen this on SIGFPE, but anyway - this is all done with integer
> > instructions that just touch bitpatterns on the stack.. The kernel can't
> > catch it sanely.
> 
> Could the fp state be put on its own page and the dirty bit
> evaluated in the decision whether to restore fpu state ?

I'm sure anything is _possible_, but there are a few problems with that 
approach. In particular, playing VM games tends to be quite expensive on 
SMP, since you need to make sure that the TLB entry for that page is 
invalidated on all the other CPU's before you insert the FPU page.

Also, you'd need to play games with dirty bit handling, since the page
_is_ dirty (it contains FP data), so the VM must know to write it out if
it pages things. That's ok - we have separate per-page and per-TLB-entry 
dirty bits anyway, but right now the VM layer knows it can move the TLB 
entry dirty bit into the per-page dirty bit and drop it - which wouldn't 
be the case if we also have a FPU dirty bit.

That's fixable - we could just make a "software TLB dirty bit" that it
updated whenever the hardware TLB dirty bit is cleared and moved into the
per-page dirty bit.

But the end result sounds rather complicated, especially since all the
page table walking necessary for setting this all up is likely to be about 
as expensive as the thing we're trying to avoid..

Rule of thumb: it almost never pays to be "clever".

		Linus

