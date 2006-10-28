Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWJ1PF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJ1PF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWJ1PF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:05:28 -0400
Received: from h155.mvista.com ([63.81.120.155]:22336 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1750761AbWJ1PF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:05:28 -0400
Message-ID: <454371AC.4030902@ru.mvista.com>
Date: Sat, 28 Oct 2006 19:05:16 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, tglx@linutronix.de, mgreer@mvista.com
Subject: Re: [PATCH -rt] powerpc update
References: <20061003155358.756788000@dwalker1.mvista.com> <20061018072858.GA29576@elte.hu>
In-Reply-To: <20061018072858.GA29576@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:

>>Pay close attention to the fasteoi interrupt threading. I added usage 
>>of mask/unmask instead of using level handling, which worked well on 
>>PPC.

> this is wrong - it should be doing mask+ack.

    It's what it was doing effectively. And what was wrong was calling ack() 
which OpenPIC driver didn't (and was not obliged to) support.

> also note that you changed:

>>-		goto out_unlock;

> to:

>>+		goto out;

> and you even tried to hide your tracks:
> 
> 
>> out:
>> 	desc->chip->eoi(irq);
>>-out_unlock:
>> 	spin_unlock(&desc->lock);

> :-)

> really, the ->eoi() op should only be called for true fasteoi cases. 

    Why is that? eoi() is effectively the same as ack() in this case. I must 
note that what's the "standard" 8259 driver is doing in mask_ack() seems 
misleading since it actually masks IRQ and sends EOI there.

> What we want here is to turn the fasteoi handler into a handler that 
> does mask+ack and then unmask. Not 'mask+eoi ... unmask' as your patch 
> does.

    That's effectively the same for OpenPIC. Maybe that implemetation just 
didn't look graceful but it was *correct*. And the current one is at least 
incomplete.

    I can see 3 ways to get out of this situation now:

1. Revert this change and use mask() + eoi() approach suggested by Daniel.

2. Add the ack() handler to OpenPIC driver -- and point it to mpic_eoi().

3. Do the same as x86 APIC driver does and use level/egde flows instead of 
fasteoi for the case when IRQs are threaded -- that ensues doing (2) as well.

    Note that all three aproaches lead to the effectively the same behavior 
WRT OpenPIC (except for the edge-triggered IRQs in 3rd case). Opinions?

> 	Ingo

WBR, Sergei
