Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264389AbSIQRNb>; Tue, 17 Sep 2002 13:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264403AbSIQRNb>; Tue, 17 Sep 2002 13:13:31 -0400
Received: from smtpout.mac.com ([204.179.120.85]:27614 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S264389AbSIQRN3>;
	Tue, 17 Sep 2002 13:13:29 -0400
Date: Tue, 17 Sep 2002 19:18:19 +0200
Subject: Re: Oops in sched.c on PPro SMP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
To: Andrea Arcangeli <andrea@suse.de>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <20020916231303.GF11605@dualathlon.random>
Message-Id: <7617860B-CA61-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag den, 17. September 2002, um 01:13, schrieb Andrea Arcangeli:

> On Mon, Sep 16, 2002 at 11:16:20PM +0200, Peter Waechtler wrote:
>> Am Montag den, 16. September 2002, um 17:44, schrieb Andrea Arcangeli:
>>
>>> On Mon, Sep 16, 2002 at 03:49:27PM +0100, Alan Cox wrote:
>>>> Also does turning off the nmi watchdog junk make the box stable ?
>>>
>>> good idea, I didn't though about this one since I only heard the nmi 
>>> to
>>> lockup hard boxes after hours of load, never to generate any
>>> malfunction, but certainly the nmi handling isn't probably one of the
>>> most exercised hardware paths in the cpus, so it's a good idea to
>>> reproduce with it turned off (OTOH I guess you probably turned it on
>>> explicitly only after you got these troubles, in order to debug them).
>>>
>>
>> I only turned the nmi watchdog on, on the one "unknown" version Oops.
>>
>> This box was running fine with 2.4.18-SuSE with uptimes 40+days. _Now_
>> I am almost sure, that it's _not_ a hardware problem (FENCE counting
>> here as software - since there is a software workaround).
>>
>> I had 3 lockups in 2 days, when I switched to 2.4.19 - and even lower
>> room temperature. No, there _must_ be a bug :)
>
> possible. Which was the previous kernel running in the machine before
> 2.4.18-SuSE?
>

I guess 2.4.10-SuSE from 7.3
In january I switched to 2.4.14 and 2.4.17 and applied the xfs patches.
At exactly the same instruction: kaboom!

http://marc.theaimsgroup.com/?l=linux-kernel&m=101113532211430&w=2


>> Can someone explain me the difference for label 1 and 2?
>> Why is the "js 2f" there? This I don't understand fully -
>> it looks broken to me.
>
> it's correct, if not we would have noticed since a long time ;)
>
> What it does is to subtract 1 to the lock, if it goes negative (signed)
> it jumps into  the looping slow path  (label 2), then when it finally
> stops looping because it acquired the lock, it jumps back to 1 and
> enters the critical section. The slow path takes care of acquiring the
> lock internally, first polling and doing without requiring the cacheline
> exclusive the trylock again.

After studying the disassembly I now see the "trick" with a jump
to a new section.

>>
>> include/asm-i386/rwlock.h
>>
>> #define __build_read_lock_ptr(rw, helper)   \
>>     asm volatile(LOCK "subl $1,(%0)\n\t" \
>>              "js 2f\n" \
>>              "1:\n" \
>>              LOCK_SECTION_START("") \
>>              "2:\tcall " helper "\n\t" \
>>              "jmp 1b\n" \
>>              LOCK_SECTION_END \
>>              ::"a" (rw) : "memory")

