Return-Path: <linux-kernel-owner+w=401wt.eu-S932877AbWLNRcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877AbWLNRcd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932882AbWLNRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:32:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41683 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932877AbWLNRcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:32:32 -0500
Date: Thu, 14 Dec 2006 09:32:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.61.0612141224190.6223@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612140926290.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0612141224190.6223@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Jan Engelhardt wrote:
> 
> Rather than IRQ_HANDLED, it should have been: remove this irq handler 
> from the irq handlers for irq number N, so that it does not get called 
> again until userspace has acked it.

Wrongo.

That just means that the _handler_ won't be called.

But the irq still stays active, and if it's shared, ALL THE OTHER HANDLERS 
FOR THAT INTERRUPT will be called. 

Over and over again. Forever. Because the machine won't be making any 
progress, and the user-level code (which might know how to shut it up) 
won't ever be called, because the machine is busy just doing interrupt 
delivery all the time.

> See, maybe I don't have enough clue yet to exactly figure out why you 
> say it does not work. However, this is how simple people see it 8)

You may be a bit simple. But I think it's more polite to call you 
"special". Or maybe just not very used to how hardware works.

Btw, this is not something theoretical. We used to have this particular 
problem _all_ the time with PCMCIA back when we weren't as good at 
interrupt routing. You'd insert a PCMCIA card, and the machine just hung. 
Hard.

And the reason was that it would send an irq, but we were expecting it on 
another interrupt. But if it showed up on something that was shared, you'd 
have a hung machine, because you'd just have the (say) ethernet driver 
saying "not for me", and returning. And obviously not able to actually 
shut it up, so when we returned from the interrupt handler, the interrupt 
happened immediately again.

So this really isn't theoretical. It's a very common failure schenario for 
mishandled interrupts. In fact, exactly because it's so common, these days 
we have all this special logic in the generic interrupt layer that 
notices, and shuts them up entirely (but does so by disabling _all_ the 
devices on that interrupt, so when this happens, you might well lose your 
disk driver or somethign else).

			Linus
