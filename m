Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUB0G0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUB0G0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:26:41 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:30627 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261707AbUB0G0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:26:39 -0500
Date: Fri, 27 Feb 2004 14:26:31 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Cc: "Mark Gross" <mgross@linux.co.intel.com>, arjanv@redhat.com,
       "Tim Bird" <tim.bird@am.sony.com>, root@chaos.analogic.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <1077859968.22213.163.camel@gaston>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr30muhyf4evsfm@smtp.pacific.net.th>
In-Reply-To: <1077859968.22213.163.camel@gaston>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004 16:32:48 +1100, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>
>> Is the assumption that hardirq handlers are superfast also the reason
>> why Linux calls all handlers on a shared interrupt, even if the first
>> handler reports it was for its device?
>
> With level irqs only, it would be possible to return at this
> point. But with edge irqs, we could miss it completely if another
> device had an irq at the same time

Is this to imply that edge triggered shared interrupts are used anywhere?

Never occured to me to use shared IRQ's edge triggered as this mode
_cannot_ work reliably for HW limitations.

Consider this scenario:

Two devices A) having it's IRQa and B) with it's IRQB.
Both devices "ored" on IRQBUS.

For simplicity lets assume these timings:
	IRQa,IRQB > IRQBUS: 		10ns
	IRQx transition time 		10ns
	PIC IRQ latch recovery time	10ns
	  This is the time IRQBUS input must be passive
	  for another edge on it to be detected

Here, by murphy IRQb arrives at the same time IRQa is reset.

Lets say one step (hyphen) is 5 ns
~ is a break in time
^ is a instable state glitch

           /-------~--------\	
IRQa  ---/                  \-------~------

                             /-------~------
IRQb  ------------~--------/

             /-----~--------^^-------~------
IRQBUS-----/


So, as you can see, IRQb gets lost as the PIC IRQ latch recovery
time is violated.

A work around would be to poll the _entire_ chain once more before
exiting the ISR - this would be rather clumsy though.

Regards
Michael
