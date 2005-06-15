Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVFONGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVFONGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 09:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVFONGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 09:06:41 -0400
Received: from alog0529.analogic.com ([208.224.223.66]:12196 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261440AbVFONGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 09:06:36 -0400
Date: Wed, 15 Jun 2005 09:06:21 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Gene Heskett <gene.heskett@verizon.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>, cutaway@bellsouth.net
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <200506150818.24465.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0506150849380.20514@chaos.analogic.com>
References: <000b01c57187$ade6b9b0$2800000a@pc365dualp2>
 <200506150818.24465.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LEA was designed for address calculation on ix86 processors.
If it is used to ready the value of an index register for the
next memory access, it can run in parallel with the next operations.
However, if it is just used to put a value into a register, where
the CPU can't proceed until that value is finalized, it does
nothing more useful than shifts and adds.

In other words, don't substitute LEA for INC or ADD just because
you can.

 	leal	0x04(%ebx), %ebx
... and
 	addl	$0x04, %ebx

... are functionally the same if the CPU needs the value in ebx
immediately. In the code sequence....

 	movl	(%ebx), %eax
 	leal	0x04(%ebx), %ebx	# Next address
 	xorl	%ecx, %eax
 	movl	%eax, (%ebx)

... the address calculation for the marked next address can proceed
in parallel with the xorl operation that follows. This makes LEA
helpful. However, in the following...

>> leal (%%eax,%%edi,8),%%eax

... the CPU needs to complete the whole operation before proceeding.
If you measure this, LEA with two index registers, you will find
that the shift and add is faster, guaranteed.

On Wed, 15 Jun 2005, Gene Heskett wrote:

> On Wednesday 15 June 2005 04:53, cutaway@bellsouth.net wrote:
>> In find_first_bit() there exists this the sequence:
>>
>> shll $3,%%edi
>> addl %%edi,%%eax
>>
>> LEA knows how to multiply by small powers of 2 and add all in one
>> shot very efficiently:
>>
>> leal (%%eax,%%edi,8),%%eax
>>
>>
>> In find_first_zero_bit() the sequence:
>>
>> shll $3,%%edi
>> addl %%edi,%%edx
>>
>> could similarly become:
>>
>> leal (%%edx,%%edi,8),%%edx
>>
> To what cpu families does this apply?  eg, this may be true for intel,
> but what about amd, via etc?
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
> -- 
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
> soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.35% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
