Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTLOGW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTLOGW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:22:28 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:5134 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263292AbTLOGWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:22:21 -0500
Message-ID: <3FDD531B.40306@nishanet.com>
Date: Mon, 15 Dec 2003 01:22:19 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IRQ disabled (SATA) on NForce2 and my theory
References: <200312151113.52165.ross@datscreative.com.au>
In-Reply-To: <200312151113.52165.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:

><snip>
>  
>
>>It was most noticeable for the timer interrupt, because the timer 
>>interrupt is basically always at "high load" and a lack of it would 
>>result in a hard lockup of the board. However, it now seems like the 
>>timer interrupt isn't the only interrupt suffering from this issue. 
>>    
>>
> 
>
>>, I think inserting the small delay in the appropriate IRQ 
>>handler might fix this, too.  
>>
>>    
>>
>>But there's still the question, why the delay is actually needed for 
>>NForce2 boards. That would basically mean that you'll have to 
>>introduce the delay for *every* IRQ, to avoid a lockup of any device 
>>that will do high load at some time. I bet that, if I put my Firewire 
>>Card back in (or just use the onboard Firewire ports) and stream a 
>>video from my DV cam onto the harddisk, it would lock up as well after 
>>a very short time, since those who know DV also know that DV has a 
>>very high bandwidth, half an hour of film is like 40GB or the 
>>like. (However, I can't test this right now, because my DV cam is 
>>currently not accessible) 
>>    
>>
I can't get usb or agp8 to work without crashing,
though ide onboard and on cards is stable. Might
be that delay on all interrupts is neededs.

>>So, we're still not "rock solid" with NForce2, I guess... 
>>Any idea? 
>>    
>>
>>Regards, 
>>Julien 
>>- 
>>    
>>
>
>
>If it is a C1 disconnect reconnection as we suspect then it should affect all
>local apic interrupts so the following is the conservative approach which may help.
>
>here is one of many educated? guesswork posts on topic
>
>http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2307.html
>
>If you want to put the delay in all local apic irq acks then remove the delay code
>from apic.c and put it in 
>
>/usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h
>
>also needs to bring in delay.h
>
>I am trying it now for my patched 2.4.23 (it boots and runs OK so far) kern as 
>follows but if it is really needed there then it would be better merged within
>the macro style of the bad ioapic selection code and given a kernel config
>selection mechanism.
>
>
>#ifndef __ASM_APIC_H
>#define __ASM_APIC_H
>
>#include <linux/config.h>
>#include <linux/pm.h>
>#include <asm/apicdef.h>
>#include <asm/system.h>
>#include <linux/delay.h>
>
><snip>
>
>static inline void ack_APIC_irq(void)
>{
>
>#if defined(CONFIG_MK7) && defined(CONFIG_BLK_DEV_AMD74XX)
>	/*
>	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
>	 * to stop lockups with udma100 drive. try to scale delay time
>	 * with cpu speed. Ross Dickson.
>	 */
>	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
>#endif
>
>	/*
>	 * ack_APIC_irq() actually gets compiled as a single instruction:
>	 * - a single rmw on Pentium/82489DX
>	 * - a single write on P6+ cores (CONFIG_X86_GOOD_APIC)
>	 * ... yummie.
>	 */
>
>	/* Docs say use 0 for future compatibility */
>	apic_write_around(APIC_EOI, 0);
>}
><snip>
>
>Also note I stuffed up the syntax of the original #ifdef, code still works but
>only tests the first param not both. The ifdef code should also be adjusted for
>the ioapic patch if it is to be used widely on other chipsets and processor types.
>Also others more familiar with the kernel build system could choose better
>config params to test against.
>
>Anyhow we are still flying blind so far as manufacturers comments on this 
>topic.
>  
>
...instead of sending nforce2 boards back saying they don't
work with linux, try using competitive jealousy between
Phoenix and Award, since Award has a bios update which
fixes the lockups(except usb and agp8 and maybe firewire).

>So maybe occasional lockups could be caused by this on other AMD cpu systems?
>I don't know.
>
>Don't forget to recompile & install modules given the inline code above.
>
>Please cc me as to how it goes if you try it.
>
>Regards
>Ross
>
Another clue to all of this is there is a delay for onboard
amd74xx and that never crashed for me, but offboard
promise and sii did, on fsck or grep etc. I'm hoping these
latest patches with debug=1 will give a clue what the
Award bios update does!

-Bob
