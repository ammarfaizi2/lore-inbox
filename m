Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWFIFOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWFIFOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWFIFOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:14:14 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:65172 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965149AbWFIFON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:14:13 -0400
Message-ID: <4489038C.3050901@intel.com>
Date: Thu, 08 Jun 2006 22:13:48 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
References: <44886381.9050506@goop.org> <20060608210702.GD24227@waste.org> <4488D4DE.3000100@goop.org>
In-Reply-To: <4488D4DE.3000100@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Matt Mackall wrote:
>> That's odd. Netpoll holds a reference to the device, of course, but so
>> does a normal "up" interface. So that shouldn't be the problem.
>> Another possibility is that outgoing packets from printks in the
>> driver are causing difficulty. Not sure what can be done about that.
>>   
> I only tried once; maybe I misunderstood what was going on.  I'll try 
> again tonight.
> 
> Oh, I think I see what's happening.  The e1000 suspend routine does this:
> 
>     if (netif_running(netdev))
>         e1000_down(adapter);
> 
> This leaves the interface up, but it stops the queue.  Then 
> netpoll_send_skb() has this loop:
> 
>     do {
>         npinfo->tries--;
>         spin_lock(&np->dev->xmit_lock);
>         np->dev->xmit_lock_owner = smp_processor_id();
> 
>         /*
>          * network drivers do not expect to be called if the queue is
>          * stopped.
>          */
>         if (netif_queue_stopped(np->dev)) {
>             np->dev->xmit_lock_owner = -1;
>             spin_unlock(&np->dev->xmit_lock);
>             netpoll_poll(np);
>             udelay(50);
>             continue;
>         }
> /* ... */
> again: /* proposed */
>     } while (npinfo->tries > 0);
> 
> 
> so this will end up in an infinite loop, since netif_queue_stopped() 
> will always return true, and it never looks at npinfo->tries.  Should 
> the "continue" be "goto again"?

netconsole should retry. There is no timeout programmed here since that might
lose important information, and you rather want netconsole to survive an odd
unplugged cable then to lose vital debugging information when the system is
busy for instance. (losing link will cause the interface to be down and thus
the queue to be stopped)

> Also, e1000_down does a netif_poll_disable(), but I'm not sure what that 
> actually does...  Should it prevent netpoll from even trying to send?

polling is for receives. We're basically telling the stack not to poll our
interface anymore.

>> It's generally going to suck, because unlike a polled serial port, the
>> device needs to be put to sleep. But if you're doing suspend to RAM,
>>   
> I'm interested in suspend-to-ram.  I presume that with suspend-to-disk, 
> booting with built-in netconsole will tell me useful stuff; that'll be 
> the next experiment.
> 
>> you might be able to do something like this:
>>
>> - unhook net device from suspend machinery (possibly just return success)
>> - bounce out of suspend before the final call to ACPI is made
>>
>> Net effect is you do OS-level suspend and resume of everything but the
>> NIC without actually powering down the core. Which should let you
>> debug just about everything.
> 
> Well, the machine has to really suspend so that I can see (and debug) a 
> mostly normal resume.  In particular, I need the hardware to be zapped 
> so I can see if it is being restarted properly.
> 
> What might work is to change the e1000 suspend routine to save enough 
> state for resume to work, but keep the interface up so that netconsole 
> can keep transmitting all the way up to the point that the final acpi 
> call powers off the machine.

e1000_suspend saves the entire configuration of the device and puts it in
Wake-on-Lan mode, allowing it to be waken up by your 'zap' in the proper way.

> Then the e1000 would resume normally, including restarting the xmit 
> queue so that netconsole can start again immediately; any netconsole 
> output before the e1000 resume would be lost, of course (I guess it 
> could be buffered).  That would suit me for now.

after coming out of suspend, e1000_resume is called which basically
reinitializes the entire device. In the entire sequence it is unlikely that
you'll actually be able to maintain netconsole in the first boot stage - the
network device will not be initialized by the kernel yet, and obviously will
be useless until e1000_resume is called!

I'm not sure that tweaking e1000 to survive longer is the answer here, and you
might be better off trying to have netconsole graciously wait
(msleep_interruptable instead of udelay?) In any case, I see the biggest
problem in the early boot stage when all nics are basically uninitialized
until resume starts. You just can't assign it an IP address for instance that
easy, and even resume causes the device to reset and thus link renegotiation,
adding crucial seconds to the time that the link is down, in which time you're
stacking up netconsole messages, or worse, fail to initialize netconsole

I hope this helps - I can't help but thinking that netconsole definately
wasn't designed with this in mind.

Cheers,

Auke

