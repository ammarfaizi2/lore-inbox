Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSJXP3v>; Thu, 24 Oct 2002 11:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSJXP3u>; Thu, 24 Oct 2002 11:29:50 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:5141 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265506AbSJXP3t>;
	Thu, 24 Oct 2002 11:29:49 -0400
Message-ID: <3DB81376.90403@mvista.com>
Date: Thu, 24 Oct 2002 10:36:22 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
References: <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Thu, Oct 24, 2002 at 08:28:20AM -0500, Corey Minyard wrote:
>
>  
>
>>diff -ur linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
>>--- linux.orig/arch/i386/kernel/traps.c	Mon Oct 21 13:25:45 2002
>>+++ linux/arch/i386/kernel/traps.c	Thu Oct 24 08:11:14 2002
>>    
>>
>
>At this point I'd quite like to see :
>
>	mv nmi.c nmi_watchdog.c
>
>and put all this stuff in always-compiled nmi.c.  traps.c is getting
>bloated.
>
I agree.

>
>  
>
>> static void default_do_nmi(struct pt_regs * regs)
>> {
>> 	unsigned char reason = inb(0x61);
>>  
>> 	if (!(reason & 0xc0)) {
>>-#if CONFIG_X86_LOCAL_APIC
>> 		/*
>>-		 * Ok, so this is none of the documented NMI sources,
>>-		 * so it must be the NMI watchdog.
>>+		 * Check the handler list to see if anyone can handle this
>>+		 * nmi.
>> 		 */
>>-		if (nmi_watchdog) {
>>-			nmi_watchdog_tick(regs);
>>+		if (call_nmi_handlers(regs))
>>    
>>
>
>Now you're using RCU, it's a real pity that we have the inb() first -
>if it wasn't for that, there would be no reason at all to have the "fast
>path" setting code too (the latter code is ugly, which is one reason I
>want to ditch it).
>
>How about adding default_do_nmi as the minimal-priority handler, then
>add the watchdog with higher priority above that ? Then oprofile can add
>itself on top of those both and return NOTIFY_OK to indicate it should
>break out of the loop. As a bonus, you lose the inb() for the watchdog
>too.
>
Is there any way to detect if the nmi watchdog actually caused the 
timeout?  I don't understand the hardware well enough to do it without 
some work, but it would be a VERY good idea to make sure the nmi 
watchdog actully caused the operation.

Plus, can't you get more than one cause of an NMI?  Shouldn't you check 
them all?

>>+++ linux/include/asm-i386/irq.h	Wed Oct 23 16:47:24 2002
>>    
>>
>
>I thought you agreed the stuff should be in asm/nmi.h ?
>
I will (I had forgotten), and I will move nmi.h to nmi_watchdog.h.

-Corey

