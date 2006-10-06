Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWJFQjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWJFQjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWJFQjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:39:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11938 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932439AbWJFQjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:39:11 -0400
Message-ID: <452686A3.9050004@garzik.org>
Date: Fri, 06 Oct 2006 12:38:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH, RAW] IRQ: Maintain irq number globally rather than passing
 to IRQ handlers
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <4525A8D8.9050504@garzik.org> <1160133932.1607.68.camel@localhost.localdomain> <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu> <45263D9C.9030200@garzik.org> <452673AC.1080602@garzik.org> <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 6 Oct 2006, Jeff Garzik wrote:
>> Here is the raw, un-split-up first pass of the irq argument removal patch
>> (500K):	http://gtf.org/garzik/misc/patch.irq-remove
> 
> So I'm not at all as sure about this as about the "regs" stuff.
> 
> The "regs" value has always been controversial. It's pretty much always 
> existed (due to the keyboard hander and the magic debugging keysequences), 
> and anybody who looks at 0.01 will quickly realize that the keyboard 
> driver was one of the very first drivers (I think it's even written in 
> assembly at that point: originally _all_ of what was to become Linux was 
> pure asm, the whole "oh, cool, I could write this part in C" came later). 
> But it's been pretty much a special case since day #1, purely for that 
> "press a key to see where the h*ck we hung" case.

Chuckle :)

> In contrast, the irq argument itself is really no different from the 
> cookie we pass in on registration - it's just passing it back to the 
> driver that requested the thing. So unlike "regs", there's not really 
> anything strange about it, and there's nothing really "wrong" with having 
> it there.

It doesn't have the colorful history of pt_regs, but the 'irq' argument 
is dead weight.  I'd say the wrongness stems from its utter uselessness.

Out of ~1100 irq handlers, the irq parameter is used in ~50.  The vast 
majority of those 50 uses are debug printks, or abused as a "did I call 
myself?" internal driver flag.  The number of "real" uses is under 15, 
and those are all ancient ISA or platform drivers that pre-date my ~10 
year history with Linux.

So, I don't see any convincing argument to keep it.  And if we are going 
to kill it, given the pt_regs churn, this is probably the best 
opportunity we'll have in years.

Another weak-but-still-present argument in favor of killing it is that 
this change would IMO future-proof irq handlers, against more exotic irq 
handling methods that may come down the pipe.

	Jeff


