Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVANVc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVANVc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVANVb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:31:58 -0500
Received: from alog0392.analogic.com ([208.224.222.168]:21632 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262058AbVANV2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:28:42 -0500
Date: Fri, 14 Jan 2005 16:28:03 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Hubicka <jh@suse.cz>
cc: Tigran Aivazian <tigran@veritas.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <20050114205651.GE17263@kam.mff.cuni.cz>
Message-ID: <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
 <20050114205651.GE17263@kam.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Jan Hubicka wrote:

>> Hello,
>>
>> I am trying to boot a 2.6.x kernel (on x86_64) compiled with -mregparm=0
>> and it does not boot, i.e. hangs at the very first stage.
>>
>> I know this breaks ABI/x86_64 but the reason I need to compile such a
>> kernel is because kdb on x86_64 cannot show the function arguments and the
>> only way to make it work that I found was to pass all arguments on the
>> stack (then kdb works fine and shows correct values for all arguments).
>> But obviously the module and the kernel need to match, otherwise it will
>> panic easily; and so I have to use the same argument passing convention in
>> the kernel. This is obviously for debugging only, nobody would ever ship
>> such "incorrectly" compiled module anywhere.
>>
>> So, I have to find a "boundary" between the parts of the kernel that can
>> be safely compiled with -mregparm=0 and which must stay as they are. Any
>> ideas as to what to do in this situation?
>
> Actually -mregparm=0 is not supposed to be even accepted by x86-64
> compiler (I've disabled the function attribute but apparently missed
> this one) and even if GCC produced valid code by miracle, you will get
> into trouble with hand written assembly.

Huh? That's the default for a 'C' compiler (not to pass parameters
in registers). The parameters are passed on the stack as the default!
The return values don't count. They are, by default passed in eax
or edx-eax pair for a long long.

-mregparm=0 should therefore be a no-op unless overridden by
an __attribute__ macro.

I recall that Linus changed some code when it was discovered that
there was a bug in linux-2.6.8/arch/i386/kernel/semaphore.c

This forced some parameters to be passed in registers, using
the __attribute__((regparm(3))) macro in ../asm/linkage.h. This
might not be a GoodThing(tm) with x86_64.


>
> Honza
>>
>> Kind regards
>> Tigran
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
