Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263481AbTC2V7b>; Sat, 29 Mar 2003 16:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263483AbTC2V7b>; Sat, 29 Mar 2003 16:59:31 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:31104 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S263481AbTC2V73>;
	Sat, 29 Mar 2003 16:59:29 -0500
Message-ID: <3E8619D3.7070201@colorfullife.com>
Date: Sat, 29 Mar 2003 23:10:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, "Shawn Starr" <spstarr@sh0n.net>
Subject: Re: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:

>> Code: 89 50 04 89 02 c7 41 30 00 00 00 00 81 3d 60 98 41 c0 3c 4b
>>  kernel/timer.c:258: spin_lock(kernel/timer.c:c0419860) already locked by
>> kernel/timer.c/398
>> Kernel panic: Aiee, killing interrupt handler!
>> In interrupt handler - not syncing
>
>This is not a panic, just an oops.  And it was just a debugging check
>from spin lock debugging, but unfortunately you were in an interrupt
>handler so the machine went bye bye.
>
>It is probably a simple double-lock deadlock, detected by spin lock
>debugging.  Knowing the EIP would help... but timer_interrupt() is a
>good first guess.
>  
>
No, this is wrong. spinlock debugging never forces an oops, it just 
complains with printk and tries to continue.

What happened is that someone registered a timer, and then kfreed the 
timer while it was still active. Then the call from run_timers() caused 
a crash, which corrupted the spinlock state, which provoked a spinlock 
debugging message.

Shawn: If you want to debug this, then you should try to print the "last 
user" field of the slab object that contains the timer. Add a test into 
run_timers that checks if timer->function is < 0xC0000000.

Something like

    kmem_cache_t *c = GET_PAGE_CACHE(virt_to_page(timer));
    struct slab *slabp = GET_PAGE_SLAB(virt_to_page(timer));
    void * obj = slabp->s_mem+c->objsize*((timer-slabp->s_mem)/c->objsize);
    unsigned long last_user = *(unsigned 
long*)(obj+c->objsize-BYTE_PER_WORD);

finds address of the last caller of kfree() or kmem_cache_free() on the 
slab object. It only works if slab debugging is enabled. Just print 
last_user, and look it up in System.map. Or use print_symbol (see 
mm/slab.c for an example).

If you need help I can write a patch.
--
    Manfred


