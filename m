Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUH3DnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUH3DnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 23:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUH3DnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 23:43:07 -0400
Received: from relay.pair.com ([209.68.1.20]:58636 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266357AbUH3DnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 23:43:00 -0400
X-pair-Authenticated: 66.188.111.210
Message-ID: <4132A243.9000607@cybsft.com>
Date: Sun, 29 Aug 2004 22:42:59 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q4
References: <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <1093762642.1348.3.camel@krustophenia.net> <20040829190655.GA8840@elte.hu> <4132793C.4030703@cybsft.com>
In-Reply-To: <4132793C.4030703@cybsft.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Ingo Molnar wrote:
> 
>> * Lee Revell <rlrevell@joe-job.com> wrote:
>>
>>
>>>> -Q4 reverts this change. (this doesnt solve the problems Scott noticed
>>>> though.)
>>>>
>>>> another solution would be to boot Q3 with preempt_hardirqs=0 and then
>>>> turn on threading for all IRQs but the keyboard.
>>>>
>>>
>>> Nope, neither of these fixes the problem.
>>
>>
>>
>> i can reproduce a PS2 keyboard problem on a testsystem. It's not clear
>> yet what the issue is, something in the atkbd.c code changed between
>> 2.6.8.1 and 2.6.9-rc1-bk4 that broke IRQ redirection - even using the P9
>> hardirq.c code doesnt fix the problem. Investigating it.
>>
>>     Ingo
>>

Actually after doing a diff on atkbd, there don't seem to be any 
differences between 2.6.9-rc1 and 2.6.8.1. :( Also after looking back 
through my logs some things worth noting here:

> 
> Something of interest on this, maybe:
> 
> Here is the (pertinent) log of the system booting:
> 
> Aug 29 09:32:50 daffy kernel: requesting new irq thread for IRQ1...
> Aug 29 09:32:50 daffy kernel: atkbd.c: Spurious ACK on isa0060/serio1. 
> Some program, like XFree86, might be trying access hardware directly.

These have been here for a while.

> Aug 29 09:32:50 daffy kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, 
> MD_SB_DISKS=27
> Aug 29 09:32:50 daffy kernel: IRQ#1 thread started up.
> 
> And some further entries:
> 
> Aug 29 16:48:50 daffy kernel: atkbd.c: Spurious NAK on isa0060/serio1. 
> Some program, like XFree86, might be trying access hardware directly.
> Aug 29 16:48:50 daffy kernel: atkbd.c: Unknown key pressed (raw set 2, 
> code 0x0 on isa0060/serio1).
> Aug 29 16:48:50 daffy kernel: atkbd.c: Use 'setkeycodes 00 <keycode>' to 
> make it known.
> Aug 29 16:48:50 daffy kernel: atkbd.c: Unknown key pressed (raw set 2, 
> code 0x18 on isa0060/serio1).
> Aug 29 16:48:50 daffy kernel: atkbd.c: Use 'setkeycodes 18 <keycode>' to 
> make it known.

Looking at the messages above, it appears to me that this is being 
detected as an AT keyboard (or default) instead of a PS/2. Could this be 
a problem?

> 
> I get the "Unknown key pressed" and "Use 'setkeycodes" messages whenever 
> I press a key on the keyboard. I don't see very many of the "Spurious 
> NAK" messages though.
> 
> kr

