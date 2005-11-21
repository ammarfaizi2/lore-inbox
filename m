Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVKUXUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVKUXUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVKUXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:20:33 -0500
Received: from ozlabs.org ([203.10.76.45]:12526 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932468AbVKUXUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:20:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.22077.670148.356981@cargo.ozlabs.ibm.com>
Date: Tue, 22 Nov 2005 10:20:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	<24299.1132571556@warthog.cambridge.redhat.com>
	<20051121121454.GA1598@parisc-linux.org>
	<Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	<20051121190632.GG1598@parisc-linux.org>
	<Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	<20051121194348.GH1598@parisc-linux.org>
	<Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	<20051121211544.GA4924@elte.hu>
	<17282.15177.804471.298409@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> On all PC hardware, having a zero in the PCI irq register basically means 
> that no irq is enabled. That's a _fact_. It's a fact however much you may 
> not like it. It's how the hardware comes up, and it's how the BIOS leaves 
> it. So "0" absolutely does mean "not allocated". 

First, are you talking about the interrupt pin register or the
interrupt line register?

Secondly, I would say that any driver that looks at either of those
registers is broken.  Drivers should be looking at dev->irq, which is
set up by platform code, and may be quite different from what is in
the interrupt line register.

So the question of what PCI devices do with the value in the interrupt
line register is pretty much irrelevant.  Those few devices that can
control their interrupt routing (such as cardbus bridges) don't use
the interrupt line register for that AFAIK.

I think all we need is for the convention for drivers to be that they
test for whether the device has an interrupt is to test (dev->irq !=
NO_IRQ).  Then x86 can have NO_IRQ = 0 and PPC can have NO_IRQ = -1
and I think everyone is happy (well, nearly everyone, anyway :).

Paul.
