Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTLOBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 20:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTLOBO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 20:14:56 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:35339 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S262902AbTLOBOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 20:14:49 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: lkml-2315@mc.frodoid.org
Subject: IRQ disabled (SATA) on NForce2 and my theory   
Date: Mon, 15 Dec 2003 11:13:52 +1000
User-Agent: KMail/1.5.1
Cc: Jamie Lokier <jamie@shareable.org>, forming@charter.net,
       Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312151113.52165.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>It was most noticeable for the timer interrupt, because the timer 
> interrupt is basically always at "high load" and a lack of it would 
> result in a hard lockup of the board. However, it now seems like the 
> timer interrupt isn't the only interrupt suffering from this issue. 
 


>So, I think inserting the small delay in the appropriate IRQ 
> handler might fix this, too. 
 


>But there's still the question, why the delay is actually needed for 
> NForce2 boards. That would basically mean that you'll have to 
> introduce the delay for *every* IRQ, to avoid a lockup of any device 
> that will do high load at some time. I bet that, if I put my Firewire 
> Card back in (or just use the onboard Firewire ports) and stream a 
> video from my DV cam onto the harddisk, it would lock up as well after 
> a very short time, since those who know DV also know that DV has a 
> very high bandwidth, half an hour of film is like 40GB or the 
> like. (However, I can't test this right now, because my DV cam is 
> currently not accessible) 
 


>So, we're still not "rock solid" with NForce2, I guess... 
> Any idea? 
 


>Regards, 
> Julien 
> - 


If it is a C1 disconnect reconnection as we suspect then it should affect all
local apic interrupts so the following is the conservative approach which may help.

here is one of many educated? guesswork posts on topic

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2307.html

If you want to put the delay in all local apic irq acks then remove the delay code
from apic.c and put it in 

/usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h

also needs to bring in delay.h

I am trying it now for my patched 2.4.23 (it boots and runs OK so far) kern as 
follows but if it is really needed there then it would be better merged within
the macro style of the bad ioapic selection code and given a kernel config
selection mechanism.


#ifndef __ASM_APIC_H
#define __ASM_APIC_H

#include <linux/config.h>
#include <linux/pm.h>
#include <asm/apicdef.h>
#include <asm/system.h>
#include <linux/delay.h>

<snip>

static inline void ack_APIC_irq(void)
{

#if defined(CONFIG_MK7) && defined(CONFIG_BLK_DEV_AMD74XX)
	/*
	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
	 * to stop lockups with udma100 drive. try to scale delay time
	 * with cpu speed. Ross Dickson.
	 */
	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
#endif

	/*
	 * ack_APIC_irq() actually gets compiled as a single instruction:
	 * - a single rmw on Pentium/82489DX
	 * - a single write on P6+ cores (CONFIG_X86_GOOD_APIC)
	 * ... yummie.
	 */

	/* Docs say use 0 for future compatibility */
	apic_write_around(APIC_EOI, 0);
}
<snip>

Also note I stuffed up the syntax of the original #ifdef, code still works but
only tests the first param not both. The ifdef code should also be adjusted for
the ioapic patch if it is to be used widely on other chipsets and processor types.
Also others more familiar with the kernel build system could choose better
config params to test against.

Anyhow we are still flying blind so far as manufacturers comments on this 
topic.

So maybe occasional lockups could be caused by this on other AMD cpu systems?
I don't know.

Don't forget to recompile & install modules given the inline code above.

Please cc me as to how it goes if you try it.

Regards
Ross




