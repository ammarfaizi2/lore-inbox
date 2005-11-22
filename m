Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVKVREE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVKVREE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVKVREE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:04:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965010AbVKVREB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:04:01 -0500
Date: Tue, 22 Nov 2005 09:03:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>,
       Ingo Molnar <mingo@elte.hu>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <1132668939.20233.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
 <24299.1132571556@warthog.cambridge.redhat.com>  <20051121121454.GA1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>  <20051121190632.GG1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>  <20051121194348.GH1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>  <20051121211544.GA4924@elte.hu>
  <17282.15177.804471.298409@cargo.ozlabs.ibm.com> 
 <1132611631.11842.83.camel@localhost.localdomain> 
 <1132657991.15117.76.camel@baythorne.infradead.org>
 <1132668939.20233.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Alan Cox wrote:
>
> On Maw, 2005-11-22 at 11:13 +0000, David Woodhouse wrote:
> > Yes, there are drivers which are currently broken and assume irq 0 is
> > 'no irq'. They are broken. Let's just fix them and not continue the
> > brain-damage.
> 
> 0 in the Linux kernel has always meant 'no IRQ' and it makes it natural
> to express in C (and on some cpus more efficient too).

Ahh, a voice of sanity!

> What if my hardware has an IRQ -1 ;)

And "-1" isn't actually a valid value in the first place.

The struct pci_device definition is:

	unsigned int irq;

and anybody who uses -1 is just a total idiot and nincompoop. It's going 
to be a major pain in the ass (others use "int irq", others use "unsigned 
long irq").

Using (~0u) would be more correct, but still insane.

The fact is, 0 _is_ "no interrupt". Always has been. And anybody who says 
that "-1" is "correct" is just totally wrong. Making it -1 would be 
guaranteed to generate tons of breakage, and most people won't ever even 
notice, because in most cases the irq _is_ actually there, and you never 
hit the path. Which just makes the breakage EVEN WORSE.

So David Woodhouse, you're just wrong. But hey, you seem to (sadly) not be 
alone.

In short: NO_IRQ _is_ 0. Always has been. It's the only sane value. And 
btw, there is no need for that #define at all, exactly because the way you 
test for "is this no irq" is by doing "!dev->irq".

Anybody who does anything else is a bug waiting to happen.

		Linus

