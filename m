Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132771AbRDIP0e>; Mon, 9 Apr 2001 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRDIP0Z>; Mon, 9 Apr 2001 11:26:25 -0400
Received: from colorfullife.com ([216.156.138.34]:8964 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132772AbRDIP0J>;
	Mon, 9 Apr 2001 11:26:09 -0400
Message-ID: <3AD1D4A3.1E7FACD8@colorfullife.com>
Date: Mon, 09 Apr 2001 17:26:27 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: softirq buggy
In-Reply-To: <200104081758.VAA15670@ms2.inr.ac.ru> <3AD0D9A8.189AA43C@colorfullife.com> <20010409155052.H7108@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> your cpu_is_idle will return 0 in the need_resched != 0 check even if the cpu
> is idle (because of the -1 trick for avoiding the SMP-IPI to notify the cpu).
>
Fixed.

> The issue you are addressing is quite londstanding and it is not only related
> to the loop with an idle cpu.
> 
> This is the way I prefer to fix it:
> 
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre1/ksoftirqd-1
>
The return path to user space checks for pending softirqs. A delay of
1/HZ is only possible if the cpu loops in kernel space without returning
to user space - and the functions that can loop check
'current->need_resched'. That means that either cpu_is_idle() must be
renamed to schedule_required() and all 'need_resched' users should use
that function, or something like your patch.

Is a full thread really necessary? Just setting 'need_resched' should be
enough, schedule() checks for pending softirqs.
And do you have a rough idea how often that new thread is scheduled
under load?

Btw, you don't schedule the ksoftirqd thread if do_softirq() returns
from the 'if(in_interrupt())' check.
I assume that this is the most common case of delayed softirq
processing:

; in process context
spin_lock_bh();
; hw interrupt arrives
; do_softirq returns immediately
spin_unlock_bh();


--
	Manfred
