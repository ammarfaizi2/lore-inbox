Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130085AbRASJcK>; Fri, 19 Jan 2001 04:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRASJcA>; Fri, 19 Jan 2001 04:32:00 -0500
Received: from [172.16.18.67] ([172.16.18.67]:16768 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129818AbRASJbs>; Fri, 19 Jan 2001 04:31:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010119094130.A7816@bfrey.dev.cn.tlan> 
In-Reply-To: <20010119094130.A7816@bfrey.dev.cn.tlan>  <01011823245400.01549@statler.ether-net> 
To: Bob Frey <bfrey@turbolinux.com.cn>
Cc: Stephen Kitchener <stephen@g6dzj.demon.co.uk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Scanning problems - machine lockups 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Jan 2001 09:30:50 +0000
Message-ID: <11746.979896650@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bfrey@turbolinux.com.cn said:
> For Linux I think the right way to handle this is to have each
> (SA_SHIRQ) sharing capable interrupt handler return a TRUE or FALSE
> value indicating whether the interrupt belongs to the driver. In
> kernel/irq.c:handle_IRQ_event() check the return value. If after one
> pass through all of the interrupt (action) handlers no one has claimed
> the inerrupt then log a warning message (spurious interrupt) and clear
> the interrupt.

There exists hardware on which it's impossible to know for sure whether an 
interrupt was generated or not. Upon receiving what might have been a 
'status change' IRQ you check the status register. If it's reading the same 
as when you last looked at it, you have know way to be sure that it hasn't 
actually changed twice.

So you'd have to have a YES/NO/MAYBE return code, which means you'd still 
want to deal with the case of an IRQ storm with the only handler returning 
MAYBE. And in reality, your first pass through all the drivers would simply 
be to change the prototype and make them return MAYBE. And many 
of them would stay that way for a _loooong_ time. 

Also, you don't necessarily need to mask the IRQ just because you got a 
single spurious trigger. It's only really necessary if you're getting 
inundated with so many IRQs that the system is falling over.

So your heuristic might be something like...

 Each jiffy, reset the 'spurious IRQ' count for each IRQ.


 Each time an IRQ is triggered, note the 'maximum' return code from the
	handlers called (where NO < MAYBE < YES).

 If YES, goto out:

 If MAYBE, increase the spurious IRQ count for this IRQ by 1

 If NO, increase the spurious IRQ count for this IRQ by 100

 If the spurious IRQ count for this IRQ has reached <a suitable number>,
	then disable the IRQ.

out:
 Return from irq.


Perhaps you don't want to touch the whole list of IRQ counts every jiffy. 
Perhaps you could reset it to zero on each YES response. Or something.

And if you start randomly disabling IRQs because they're triggering too 
often, then you'll probably need a way for a device driver to force you to 
turn them back on again, like kick_irq().

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
