Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTJIRD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTJIRD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:03:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15760 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262297AbTJIRDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:03:25 -0400
Message-ID: <3F8594CD.1030504@pobox.com>
Date: Thu, 09 Oct 2003 13:03:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
References: <3F858885.1070202@colorfullife.com> <3F858EF8.5080105@pobox.com> <1065718629.663.3.camel@gaston>
In-Reply-To: <1065718629.663.3.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Thu, 2003-10-09 at 18:38, Jeff Garzik wrote:
> 
>>Manfred Spraul wrote:
>>
>>>I'd like to use that for nic shutdown for natsemi:
>>>
>>>   disable_irq();
>>>   shutdown_nic();
>>>   free_irq();
>>>   enable_irq();
>>
>>
>>Why not just shutdown the NIC inside spin_lock_irqsave or disable_irq, 
>>and then free_irq separately?
>>
>>If you can't stop the NIC hardware from generating interrupts, that's a 
>>driver bug.  And if the driver cannot handle its interrupt handler 
>>between the spin_unlock_irqrestore() and free_irq() (shared irq case), 
>>it's also buggy.
> 
> 
> Actually you may still get a stale irq ;) The problem is that IRQs are
> typically an asynchronous event, and an irq can be sort of "queued" up
> (especially if it's a level one) in the PIC... though at least this
> won't be a stale level irq so you won't deadlock in an irq handler that
> can do nothing...

Easily solved with a synchronize_irq()  ;-)

As a slight tangent, with MSI coming up, as well as the presence of 
hardware that queues IRQ events asynchronously, we'll want 
synchronize_irq() to handle those cases, even for uniprocess (often 
synchronize_irq is only defined for SMP).


> Anyway, I quite like the idea. I've been trying to avoid taking a lock
> in some similar shutdown routine for sungem, because some bits in there
> need a few ms delay to workaround a chip bug (or machine sleep will
> break) and I want to schedule. Breaking the lock makes things ugly,
> beeing able to just disable_irq before/after is nice.
> 
> The problem of course is when that irq is shared... you are suddently
> shutting off for a potentially long time a neighbour irq, bad bad...
> (at least I know that on pmac, sungem irq is never shared).

You want to disable_irq() then sleep?  ewww...  :)  I think we could 
figure out a better way...

	Jeff



