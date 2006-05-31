Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWEaJMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWEaJMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWEaJMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:12:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:3981 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964876AbWEaJMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:12:19 -0400
Subject: Re: genirq vs. fastack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1149064735.20582.85.camel@localhost.localdomain>
References: <1149040361.766.10.camel@localhost.localdomain>
	 <1149064735.20582.85.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 May 2006 19:11:57 +1000
Message-Id: <1149066718.766.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I see your point, but isn't EOI the chip specific implementation of
> chip->ack() in that case ? 

Not ack, end :)

The ack is implicit when retreiving the irq number (when the irq
happens), the register is even called the ack register :) the EOI isn't
ack'ing, it's really "end of interrupt", that is end of handling by the
processor, thus the CPU local priority can be lowered to what it was
when the interrupt happened.
 
> The intention was to get down to the chip primitives and away from the
> flow type chip->functions. Your patch would actually force the flow
> control part (if (!(desc->status & IRQ_DISABLED))) back into the end()

No. end() for mpic and xics will be the exact same one-liner. The whole
point is that on those chips, mask/unmask are completely disconnected
from the interrupt flow. Mask should happen when disable_irq() is called
wether the irq is in progress or not, independently, and thus the
handler shouldn't mask. Beside, eoi _must_ be called wether it was
masked in between or not or the controller will lose track.

> function for Ingo's x86 implementation. So the intended seperation of
> low level chip functions and flow control would be moot.

Nope. Both MPIC and xics will mask/unmask in ... mask() and unmask()
_and_ have a end() handler that does a EOI without testing if the irq
was disabled. There is no flow handling. That's the whole point of the
handler for "smart" controllers. Non smart controllers can use normal
flow handlers as far as I'm concerned.

Ben.


