Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTDCTde 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263472AbTDCTdZ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:33:25 -0500
Received: from intranet.resilience.com ([12.36.124.2]:14483 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id S263437AbTDCTbh 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:31:37 -0500
Mime-Version: 1.0
Message-Id: <p05210605bab23f34f677@[10.2.0.101]>
Date: Thu, 3 Apr 2003 11:42:56 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: ISA vs PCI interrupt handling
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:20am +0200 4/3/03, Krzysztof Halasa wrote:
>I mean, in situation where the handler terminates with the IRQ line
>being still active, will the handler be called again, or will the
>driver deadlock? Does is behave differently on ISA and PCI?
>...
>My experiments with ISA devices show that after the handler terminates
>without i.e. handling all requests, the IRQ line is stuck at +5V
>(= logical "active" level) and the handler isn't called anymore.
>
>Or does that mean the IRQ is edge-triggered, and the handler is being
>called just once a low-to-high edge is detected?

The "legacy" ISA interrupt controller has various modes, but the 
legacy mode is to be edge-sensitive. Edge-sensitivity here isn't 
quite what a hardware engineer would mean by it, but it does mean 
that, once an interrupt has been triggered, it has to go low before 
another interrupt can be recognized. That's consistent with your 
experiments. In general, an ISA interrupt service loop needs to be of 
the form: while (device is interrupting) { service the interrupt }

Shared interrupts (eg PCI) are different, of course. Because they're 
shared, the interrupt controller can't be edge-sensitive. One problem 
would be that another (interrupt sharing) device can hold the 
interrupt line active (low for PCI), so two devices could in 
principle interrupt alternately and the interrupt line itself never 
go inactive, and no edges would be seen by the interrupt controller.

The same service loop should work just fine, but the penalty for not 
servicing a PCI interrupt should just be that the ISR will get 
invoked again. Of course, that will go on forever unless the 
interrupt *is* serviced, but you can get away with servicing one at a 
time, and taking an interrupt for each event. Not necessarily 
efficient, but it should work.

Depending on the interrupt controller, an interrupt may need to be 
ACKed; this is definitely true for legacy ISA interrupt controllers. 
That's not typically a driver function, as I recall.
-- 
/Jonathan Lundell.
