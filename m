Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVFHWO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVFHWO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:14:57 -0400
Received: from fmr14.intel.com ([192.55.52.68]:34690 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261440AbVFHWOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:14:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Dynamic tick for x86 version 050602-1 
Date: Wed, 8 Jun 2005 15:14:39 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Dynamic tick for x86 version 050602-1 
Thread-Index: AcVroO7W9tYoXQlETi+O6m9wNoSAPQA1gHBg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jonathan Corbet" <corbet@lwn.net>, "Tony Lindgren" <tony@atomide.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jun 2005 22:14:03.0061 (UTC) FILETIME=[60C8D650:01C56C77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Jonathan Corbet
>Sent: Tuesday, June 07, 2005 1:36 PM
>To: Tony Lindgren
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1 
>
>Tony Lindgren <tony@atomide.com> wrote:
>
>> --- linux-dev.orig/arch/i386/kernel/irq.c	2005-06-01 
>17:51:36.000000000 -0700
>> +++ linux-dev/arch/i386/kernel/irq.c	2005-06-01 
>17:54:32.000000000 -0700
>> [...]
>> @@ -102,6 +103,12 @@ fastcall unsigned int do_IRQ(struct pt_r
>>  		);
>>  	} else
>>  #endif
>> +
>> +#ifdef CONFIG_NO_IDLE_HZ
>> +	if (dyn_tick->state & (DYN_TICK_ENABLED | 
>DYN_TICK_SKIPPING) && irq != 0)
>> +		dyn_tick->interrupt(irq, NULL, regs);
>> +#endif
>> +
>>  		__do_IRQ(irq, regs);
>
>Forgive me if I'm being obtuse (again...), but this hunk doesn't look
>like it would work well in the 4K stacks case.  When 4K stacks 
>are being
>used, dyn_tick->interrupt() will only get called in the nested 
>interrupt
>case, when the interrupt stack is already in use.  This change also
>pushes the non-assembly __do_IRQ() call out of the else branch, meaning
>that, when the switch is made to the interrupt stack (most of 
>the time),
>__do_IRQ() will be called twice for the same interrupt.
>
>It looks to me like you want to put your #ifdef chunk *after* the call
>to __do_IRQ(), unless you have some reason for needing it to happen
>before the regular interrupt handler is invoked.
>

Good catch. This indeed looks like a bug. 
With 050602-1 version I am seeing double the number of calls to 
timer_interrupt routine than expected. Say, when all CPUs are fully
busy, 
I see 2*HZ timer interrupt count in /proc/interrupts

And things look normal once I change this hunk as below

>>  	} else
>>  #endif
>> +
   + {
>> +#ifdef CONFIG_NO_IDLE_HZ
>> +	if (dyn_tick->state & (DYN_TICK_ENABLED | 
>DYN_TICK_SKIPPING) && irq != 0)
>> +		dyn_tick->interrupt(irq, NULL, regs);
>> +#endif
>> +
>>  		__do_IRQ(irq, regs);
   + }



Thanks,
Venki
