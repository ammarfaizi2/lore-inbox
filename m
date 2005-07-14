Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVGNQWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVGNQWF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVGNQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:22:04 -0400
Received: from bay108-dav7.bay108.hotmail.com ([65.54.162.79]:38500 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261578AbVGNQVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:21:55 -0400
Message-ID: <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl>
X-Originating-IP: [65.54.162.200]
X-Originating-Email: [multisyncfe991@hotmail.com]
Reply-To: <multisyncfe991@hotmail.com>
From: <multisyncfe991@hotmail.com>
To: <linux-kernel@vger.kernel.org>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl> <20050714051653.GP8907@alpha.home.local>
Subject: Re: About a change to the implementation of spin lock in 2.6.12 kernel.
Date: Thu, 14 Jul 2005 09:21:51 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 14 Jul 2005 16:21:52.0879 (UTC) FILETIME=[2515EFF0:01C58890]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

I think at least I can remove the LOCK instruction when the lock is already 
held by someone else and enter the spinning wait directly, right?
0: cmpb $0, slp

    jle      2f                    # lock is not available, then spinning 
directly without locking the bus

1: lock; decb slp           # lock the bus and atomically decrement

    jns   3f                      # if clear sign bit jump forward to 3

2: pause                       # spin - wait

    cmpb $0,slp             # spin - compare to 0

    jle 2b                       # spin - go back to 2 if <= 0 (locked)

    jmp 1b                     # unlocked; go back to 1 to try to lock again

3:                                 # we have acquired the lock .

But based on the Lockmeter report, the lock success is dominant 99.8%, so 
maybe this will not make much change.
Thanks,

Liang

----- Original Message ----- 
From: "Willy Tarreau" <willy@w.ods.org>
To: <multisyncfe991@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 13, 2005 10:16 PM
Subject: Re: About a change to the implementation of spin lock in 2.6.12 
kernel.


> Hi,
>
> On Wed, Jul 13, 2005 at 07:20:06PM -0700, multisyncfe991@hotmail.com 
> wrote:
>> Hi,
>>
>> I found _spin_lock used a LOCK instruction to make the following
>> operation "decb %0" atomic. As you know, LOCK instruction alone takes
>> almost 70 clock cycles to finish and this add lots of cost to the
>> _spin_lock. However _spin_unlock does not use this LOCK instruction and
>> it uses "movb $1,%0" instead since 4-byte writes on 4-byte aligned
>> addresses are atomic.
>
> _spin_unlock does not need locked operations because when it is run, the
> code is already known to be the only one to hold the lock, so it can
> release it without checking what others do.
>
>> So I want rewrite the _spin_lock defined spinlock.h
>> (/linux/include/asm-i386) as follows to reduce the overhead of _spin_lock
>> and make it more efficient.
>
> It does not work. You cannot write an inter-cpu atomic test-and-set with
> several unlocked instructions.
>
>> #define spin_lock_string \
>>        "\n1:\t" \
>>        "cmpb $0,%0\n\t" \
>>        "jle 2f\n\t" \
>
> ==> here, another thread or CPU can get the lock simultaneously.
>
>>        "movb $0, %0\n\t" \
>>        "jmp 3f\n" \
>>        "2:\t" \
>>        "rep;nop\n\t" \
>>        "cmpb $0, %0\n\t" \
>>        "jle 2b\n\t" \
>>        "jmp 1b\n" \
>>        "3:\n\t"
>>
>> Compared with the original version as follows, LOCK instruction is
>> removed. I rebuilt the Intel e1000 Gigabit driver with this _spin_lock.
>> There is about 2% throughput improvement.
>> #define spin_lock_string \
>>            "\n1:\t" \
>>            "lock ; decb %0\n\t" \
>>            "jns 3f\n" \
>>            "2:\t" \
>>            "rep;nop\n\t" \
>>            "cmpb $0,%0\n\t" \
>>            "jle 2b\n\t" \
>>            "jmp 1b\n" \
>>            "3:\n\t"
>>
>> Do you think I can get a better performance if I dig further?
>>
>> Any ideas will be greatly appreciated,
>
> well, of course with those methods you can improve performance, but you
> lose the warranty that you're alone to get a lock, and that's bad.
>
> another similar method to get a lock in some very controlled environment
> is as follows :
>
>  1:  cmp $0, %0
>      jne 1b
>      mov $CPUID, %0
>      membar
>      cmp $CPUID, %0
>      jne 1b
>
> This only works with same speed CPUs and interrupts disabled. But in 
> todays
> environments, this is very risky (hyperthreaded CPUs, etc...). However, 
> this
> is often OK for more deterministic CPUs such as microcontrollers.
>
> Regards,
> Willy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
