Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312509AbSCYTGH>; Mon, 25 Mar 2002 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSCYTF5>; Mon, 25 Mar 2002 14:05:57 -0500
Received: from air-2.osdl.org ([65.201.151.6]:3467 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S312503AbSCYTFp>;
	Mon, 25 Mar 2002 14:05:45 -0500
Date: Mon, 25 Mar 2002 11:02:34 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Anders Gustafsson <andersg@0x63.nu>, <arjanv@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <3C92AD1F.30909@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203251051450.3237-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Sorry, been on vacation...)

On Fri, 15 Mar 2002, Jeff Garzik wrote:

> Linus Torvalds wrote:
> 
> >
> >On Sat, 16 Mar 2002, Anders Gustafsson wrote:
> >
> >>this patch fixes "undefined reference to `local symbols in discarded
> >>section .text.exit'" linking error.
> >>
> >
> >Looking more at this, I actually think that the _real_ fix is to call all
> >drivers exit functions at kernel shutdown, and not discard the exit
> >section when linking into the tree.
> >
> >That, together with the device tree, automatically gives us the
> >_correct_ shutdown sequence, soemthing we don't have right now.
> >
> >Anybody willing to look into this, and get rid of that __devexit_p()
> >thing?
> >
> 
> (thinking vaguely long-term)
> 
> I wonder if mochel already code for this, or has thought about this... 
>  Just like suspend, IMO we ideally should use the device tree to 
> shutdown the system, agreed?

Yes, I have thought about this, and we should be doing it. Not necessarily 
for the case of shutdown, but for the case of reboot, and things like 
linux-linux booting. 

The code is simply a depth-first walk of the device tree. I had code to do 
it once upon a time, for the purpose of suspending devices; it's 
straightforward. 

> Further, I wonder if the reboot/shutdown notifiers can be replaced with 
> device tree control over those events...

Yes, I think so. And the old PM code can also be replaced with the generic 
interface, with similar walks of the tree. I've been procrastinating, but 
now is a good time to start making the change.

What I'm thinking for the reboot case is that we just use the remove() 
callback. This would queisce the device and put it in a low power state. 
This would be different that module_exit, though. Perhaps it would only 
decrement the module usage count. Maybe it already does that; I haven't 
looked.

	-pat

