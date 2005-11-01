Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVKAPyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVKAPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVKAPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:54:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750915AbVKAPyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:54:24 -0500
Date: Tue, 1 Nov 2005 07:54:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       David Brownell <david-b@pacbell.net>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
In-Reply-To: <Pine.LNX.4.44L0.0511011029040.5081-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.64.0511010748430.27915@g5.osdl.org>
References: <Pine.LNX.4.44L0.0511011029040.5081-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Alan Stern wrote:
> 
> In theory, is it possible for a UHCI controller still to be running, doing 
> DMA and/or generating interrupts, even if PCI_COMMAND_IO isn't set?

Yes, it's possible in theory. I guess we could check whether BUS_MASTER is 
enabled (which _does_ need to be enabled, otherwise it couldn't function), 
and then enable it.

> Or is this scenario not worth worrying about?

It's probably not worth worrying about. After all, this is really just for 
when something else (firmware) has enabled the USB controller for its own 
nefarious purposes (ie it also wanted keyboard input), and left it 
running. If something has left it running by mistake, it won't have 
disabled IO access either.

And if it _has_ disabled IO access, we wouldn't know how to enable it at 
this point. Sure, we could enable the command bit, but this is too early 
for us to know where in the IO address space it would be safe to enable 
it.

But an alternative strategy (which might be very sensible) is to forget 
about the handoff entirely, and just shut down the bus master flag 
unconditionally. Just make sure that the eventual driver will reset the 
controller before it re-enables bus mastering.

That would seem to be the simplest possible "handoff". The only danger is 
that I could imagine that there would be controllers out there that get 
really confused (ie "I'm not going to play nice any more") if we shut them 
up that way.

		Linus
