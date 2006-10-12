Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWJLTNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWJLTNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWJLTNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:13:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41601 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751125AbWJLTNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:13:34 -0400
Date: Thu, 12 Oct 2006 12:13:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Johnson <dj@david-web.co.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hardware bug or kernel bug?
In-Reply-To: <200610121753.23220.dj@david-web.co.uk>
Message-ID: <Pine.LNX.4.64.0610121158490.3952@g5.osdl.org>
References: <200610121753.23220.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Oct 2006, David Johnson wrote:
> 
> I'm having a major problem on a system that I've been unable to track down. 
> When using scp to transfer a large file (a few gig) over the network 
> (@100Mbit/s) the system will reboot after about 5-10 minutes of transfer. No 
> errors, just a reboot. I have another identical system which exhibits the 
> same behaviour.

A reboot usually indicates a serious hardware problem - it could be an 
overheating sensor tripping, but it could be some serious corruption 
causing a triple-fault or something like that too.

But the _most_ likely problem is just the power supply. If your power 
supply is border-line, having something that stresses CPU, disk, 
southbridge and networking at the same time may be just the way to cause a 
power-fail signal, which usually causes an instant reboot.

> The system is a Supermicro P4SCT+ with a hyperthreading P4. I've posted the 
> dmesg here:
> http://www.david-web.co.uk/download/dmesg
> 
> I initially tried a different NIC in case that was at fault, but the results 
> were the same.
> 
> Changing the interrupt timer frequency in the kernel makes a difference:
> 100Hz - system reboots instantly when transfer is started
> 250Hz - reboots after a few seconds
> 1000Hz - reboots after 5-10 minutes

I think it just changes timings, and there is something timing-related 
going on - like just instant power draw. The timer frequency should not 
have any serious impact on heat, so I doubt it's about overheating, but 
it's certainly worth opening the case and using one of those 
compressed-air things to cool down the CPU and/or southbridge chips.

> As the problem appears to be interrupt-related, I disabled the I/O APIC in the 
> BIOS (after first having to disable hyperthreading) which resulted in the 
> system lasting a bit longer before it reboots. I then tried disabling the 
> Local APIC as well but this made no difference.

Interrupts generally aren't problematic, I'd be more likely to suspect CPU 
overclocking or similar (does the cpuinfo match the frequency claimed by 
the BIOS?) or just some strange motherboard problem (which could be 
firmware: bad programming of memory timings etc). So a BIOS upgrade is 
worth looking into.

Soemtimes issues like this can be worked around - for example, maybe the 
problem is the chipset having issues with concurrent DMA or something, so 
turning off DMA on the disk drives could possibly at least _hide_ the 
problem.

> Does anyone have any idea whether this is likely to be a hardware problem or a 
> kernel problem?

Anything is possible, and it certainly _could_ be a kernel bug. There are 
situations that cause triple-faults and insta-reboots. If the stack 
pointer gets whacked in kernel space, you can get some bad bad stuff 
happening.

But check the power supply first. And check to see if there is a BIOS 
upgrade available. You can double-check the cooling: check that all 
heat-sinks are properly seated and have appropriate amounts of thermal 
grease. And blowing air from a compressed-air can on top of the things 
until you see the frost over is certainly a good spot-check.

In other words, I'd almost bet on bad hardware. 

			Linus
