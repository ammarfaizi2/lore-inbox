Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRILNzO>; Wed, 12 Sep 2001 09:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272822AbRILNzF>; Wed, 12 Sep 2001 09:55:05 -0400
Received: from [195.66.192.167] ([195.66.192.167]:26884 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S272818AbRILNyr>; Wed, 12 Sep 2001 09:54:47 -0400
Date: Wed, 12 Sep 2001 16:48:00 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <2415359415.20010912164800@port.imtp.ilyichevsk.odessa.ua>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
In-Reply-To: <E15h9RE-0004Qe-00@the-village.bc.nu>
In-Reply-To: <E15h9RE-0004Qe-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,
Wednesday, September 12, 2001, 3:48:20 PM, you wrote:
>> So why it is oopses then?
AC> On correct hardware it doesnt seem to oops.

>> Also, we don't want this data to arrive late or whatever.
>> fast_copy_page must copy page (make it so that memcpy()==0).
>> If it does not, it is too much "optimized".
AC> See the "sfence" instruction

I meant instrumented fast_copy_page() cannot fail due to
late movntq commit to memory since memcmp() is behind sfence
and kernel_fpu_end():
>>         ...
>>         kernel_fpu_end();
>> +       /* Check for "Athlon bug" - remove when resolved */
>> +       from-=4096;
>> +       to-=4096;
>> +       if(memcmp(from,to,4096)!=0) {
>> +               printk(KERN_ERR "Athlon bug! from=%08X to=%08X\n", from, to);
>> +               memcpy(to,from,4096);
>> +       }
>> }

If we still see an oops with this instrumentation,
then fast_copy_page() must be clobbering
RAM elsewhere, right?

>> A better way to do it is to bencmark several routines at
>> startup time and pick the best one. It is done now
>> for RAID xor'ing routine.
AC> Not in this case. It is Athlon specific code. It was fine
AC> tuned when it was written

Yes, but sometimes we have routines which perform
differently on different CPUs. See inslude/asm-i386/string.h
and string-486.h: on Pentium rep movsd is faster, on 386 unrolled
loop is faster... so optimal routine can be picked only at runtime.
CPU-specific routines can compete in such runtime benchmark
too when proper processor is detected - see how KNI-specific
RAID xor routine does that.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


