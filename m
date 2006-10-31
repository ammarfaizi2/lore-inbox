Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946130AbWJaXIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946130AbWJaXIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946132AbWJaXIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:08:24 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:50168 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1946130AbWJaXIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:08:23 -0500
Date: Wed, 01 Nov 2006 00:08:16 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
In-reply-to: <4547CB25.3080603@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>
Message-id: <4547D760.9000200@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <1162199005.24143.169.camel@taijtu>
 <4546FA81.1020804@cosmosbay.com> <45471A05.20205@yahoo.com.au>
 <200610311151.33104.dada1@cosmosbay.com> <4547CB25.3080603@yahoo.com.au>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :
> Eric Dumazet wrote:
> 
>> On Tuesday 31 October 2006 10:40, Nick Piggin wrote:
>>
>>
>>> Uh, there is nothing that says mutex_unlock or any unlock
>>> functions contain an implicit smp_mb(). What is given is that the
>>> lock and unlock obey aquire and release memory ordering,
>>> respectively.
>>>
>>> a = x;
>>> xxx_unlock
>>> b = y;
>>>
>>> In this situation, the load of y can be executed before that of x.
>>> And some architectures will even do so (i386 can, because the
>>> unlock is an unprefixed store; ia64 can, because it uses a release
>>> barrier in the unlock).
>>>
>>
>> Hum... it seems your mutex_unlock() i386/x86_64 copy is not same as 
>> mine :)
>>
> 
> OK, replace xxx with mutex, and what I've said still holds true for ia64.
> 
>> Maybe we could document the fact that mutex_{lock|unlock}() has or has 
>> not an implicit smp_mb().
>>
> 
> It does not, none of the unlock functions ever have.
> 
>> If not, delete smp_mb() calls from include/asm-generic/mutex-dec.h
> 
> They should be deleted (and from mutex-xchg). NOT because there is no 
> need for
> a memory barrier, but because the atomic_alter_value_and_return_something
> functions always provide a barrier before and after the operation, as per
> Documentation/atomic_ops.txt
> 
> Again, lock / unlock operations require acquire / release consistency. 
> This is a
> memory ordering operation. It is not equivalent to smp_mb, though.

This thread just show how difficult it is to have consistent use of all this 
stuff in all kernel. Maybe it is just me ? Should I work on IA64 to have a 
chance to learn ?


For example, Documentation/atomic_ops.txt comments about atomic_inc_return() 
and atomic_dec_return() seems in contradiction with itself.

--------------------------

Unlike the above routines, it is required that explicit memory
barriers are performed before and after the operation.  It must be
done such that all memory operations before and after the atomic
operation calls are strongly ordered with respect to the atomic
operation itself.

-------------------------

When I read this, I understand we (the user of such functions) need to add 
smp_mb(). (That is, those functions wont do it themselves)

Then following text is :

----------------------------
For example, it should behave as if a smp_mb() call existed both
before and after the atomic operation.

--------------------------

Now I understand the reverse.


Time to sleep for sure :) And find a IA64 platform tomorrow morning :)

