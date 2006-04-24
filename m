Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWDXW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWDXW0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWDXW0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:26:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751319AbWDXW0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:26:45 -0400
Date: Mon, 24 Apr 2006 15:26:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <20060424212038.GC4942@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.64.0604241521210.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org>
 <1145908402.3116.63.camel@laptopd505.fenrus.org> <20060424201646.GA23517@devserv.devel.redhat.com>
 <1145911417.3116.69.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
 <20060424212038.GC4942@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Alan Cox wrote:
> 
> > The fake interrupt could even print out a warning if somebody returns 
> > SA_HANDLED (since normally there _shouldn't_ have been any work to handle 
> > for it), and if that means that for somebody, things go from "the machine 
> > hung" to "the machine got very slow, and printed out 'fake interrupt for 
> > ide0 returned SA_HANDLED!'", that would potentially be a big debug aid.
> 
> There are high rate IRQ sources that would trigger that erratically due to
> races but it could be useful in some kind of "linux irqdebug" mode

I was thinking that an interrupt actually happening on that irq would set 
the "already done" flag, so that if it's a high-rate irq, then we'd not 
inject any new fake ones.

So the algorithm would be something like "clear the 'already done' flag 
every five seconds, and sending the fake one if it was already cleared", 
with normal interrupts always setting the flag.

And yes, you could still hit it in a blue moon (nothing happened for five 
seconds, and then it happens _just_ as we send a fake event), but if the 
only thing we do is do a printk() on it, no big deal if you get a false 
positive every five years.

(The bigger problem is that some drivers just return IRQ_HANDLED whether 
they had work to do or not, because people - including me - were lazy in 
some of the conversion of the irq_handler_t stuff).

I dunno. It _sounds_ simple enough..

			Linus
