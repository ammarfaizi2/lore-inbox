Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSGYSJy>; Thu, 25 Jul 2002 14:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSGYSJy>; Thu, 25 Jul 2002 14:09:54 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:32456 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315690AbSGYSJx>;
	Thu, 25 Jul 2002 14:09:53 -0400
Date: Thu, 25 Jul 2002 11:13:04 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux-2.5.28
Message-ID: <20020725111304.H14698@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote :
> In article <20020724170752.A14089@bougret.hpl.hp.com>,
> Jean Tourrilhes  <jt@bougret.hpl.hp.com> wrote:
> >
> >	IrDA is not going to get fixed soon. Over the time I've been
> >fixing the IrDA stack, I've slowly fixed some of most dangerous
> >locking problems, but fixing the remaining code will involve some
> >serious re-work and is unfortunately not just about sprinking a few
> >spinlocks there and there.
> 
> Actually, the way to emulate cli/sti behaviour is not to "sprinkle"
> spinlocks, you can generally do it with _one_ spinlock per subsystem.

	Unfortunately, it won't work for IrDA. The reason is that you
tend to have path like this :
		IrLAP -> IrLMP -> IrTTP -> IrNET/IrCOMM/IrLAN/IrSock -> IrTTP -> IrLMP -> IrLAP
	And I can't have one global spinlock for the IrDA stack,
because the higher layers (IrNET/IrCOMM/IrLAN/IrSOCK) are totally
independant and have their own locking (for example, I can guarantee
you the IrNET is already safe).
	I'm also especially nervous about keeping a spinlock and irq
off while calling protocols higher layres, such as the various socket
function (IrSOCK), or the PPP mux (IrNET), or the TTY layer (IrCOMM).
	My feeling is that doing the _one_ spinlock properly would be
as much work than fixing the root problem (the hasbins).

> So the straightforward way to port away from cli/sti is to add one
> spinlock which takes their place for that subsystem, and then get that
> lock on entry to subsystem interrupts and timer events, and in all
> places where there used to be a cli/sti. 

	Been there, done that. I've been the one doing most the
original SMP work in most Wireless LAN drivers (and the HP100 driver),
and I'm still the one doing most testing.
	So, I feel qualified to comment about the IrDA situation.

> It gets a bit more complicated partly because you could nest cli/sti,
> and you can't nest spinlocks, but on the whole none of it is "rocket
> science". 

	No, here the problem is that the whole locking design is
broken. I know perfectly that the hashbin locking is totally unsafe
and it's a miracle that it work at all. And I'm not sure if I will
ever get something 100% safe.

> Of course, doing it _right_ (rather than try to just translate the
> semantics of cli/sti fairly directly) can be a lot more work. But even a
> straight translation improves on what used to be, since different
> subsystems will now be independent, and since it is easier later on to
> split the one lock up on a as-needed basis.
> 
> 			Linus

	Unfortunately, with the current IrDA code, I don't have much
choice but to do it somewhat right.
	Now, it's a matter of priorities. The other IrDA developpers
have been bitten by "nothing is wrong" IDE in 2.5.X, so the logical
course of action is to shift to 2.4.X until I find time to get back to
this issue and catch up.
	But having IrDA not functional in 2.5.X for a few months is
certainly not that painful compared to other problems in 2.5.X.
	And as I was saying to Ingo, the good news is that I'll
probably also no longer will need "deliver_to_old_one()" in the
networking code.

	Have fun...

	Jean
