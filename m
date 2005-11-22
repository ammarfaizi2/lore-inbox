Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVKVX6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVKVX6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVKVX6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:58:54 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:14249 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S1030266AbVKVX6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:58:53 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0511221113390.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org>
	 <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	 <1132611631.11842.83.camel@localhost.localdomain>
	 <1132657991.15117.76.camel@baythorne.infradead.org>
	 <1132668939.20233.47.camel@localhost.localdomain>
	 <9497.1132684676@warthog.cambridge.redhat.com>
	 <1132686213.15117.135.camel@baythorne.infradead.org>
	 <Pine.LNX.4.64.0511221113390.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 23:58:34 +0000
Message-Id: <1132703914.15117.148.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 11:21 -0800, Linus Torvalds wrote:
> Of _course_ "irq0" is a valid irq. On PC's, it's usually the timer 
> interrupt.
> 
> It's the "dev->irq" _cookie_ zero that means it is does not have an irq.
> 
> If you have a physical "irq 0" that is bound to a device, it needs a 
> cookie, and that cookie can't be 0, because that means the device has no 
> interrupt.
> 
> How hard is that to understand? Why do people mix these up?

Mostly I'd suggest that people mix them up because you've only just made
up this 'cookie' nonsense, and the number we store in dev->irq has
always been just the irq number -- at least on all but SPARC, which was
always 'special'. That's precisely _why_ we have a mix of 'int' and
'long' and other types in which we store it, as you've said. It's never
been considered a 'cookie'.

But turning it into a cookie makes enough sense, I suppose, as long as
we stop confusing it with irq 'numbers' -- and that includes banning
anyone from printing it with '%d'.

I'm inclined to agree with David's suggestion of making it a pointer.
Then it can point to a structure which is part a proper _tree_ of
interrupts which actually resembles reality. And SPARC can stop being a
special (and probably saner) case. And all the mess which platforms have
with assigning interrupt 'number' ranges for various PICs can go away.
And hotplug interrupt controllers (it happens, on CardBus or with
hotplug PCI) can work sanely. But Matthew still can't have his pony.

Yes, you still need a mapping at _setup_ time from stuff like isapnp and
OpenFirmware interrupt numbers to the appropriate 'cookie', but that's
not so hard.

-- 
dwmw2


