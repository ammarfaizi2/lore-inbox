Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264381AbRFOMuk>; Fri, 15 Jun 2001 08:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbRFOMub>; Fri, 15 Jun 2001 08:50:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264381AbRFOMuU>; Fri, 15 Jun 2001 08:50:20 -0400
Date: Fri, 15 Jun 2001 08:49:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Roger Larsson <roger.larsson@norran.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP spin-locks
In-Reply-To: <20010615141047.K754@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.3.95.1010615084626.26538A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2001, Ingo Oeser wrote:

> On Thu, Jun 14, 2001 at 05:05:07PM -0400, Richard B. Johnson wrote:
> > The problem is that a data acquisition board across the PCI bus
> > gives a data transfer rate of 10 to 11 megabytes per second
> > with a UP kernel, and the transfer drops to 5-6 megabytes per
> > second with a SMP kernel. The ISR is really simple and copies
> > data, that's all.
> > 
> > The 'read()' routine uses a spinlock when it modifies pointers.
> > 
> > I started to look into where all the CPU clocks were going. The
> > SMP spinlock code is where it's going. There is often contention
> > for the lock because interrupts normally occur at 50 to 60 kHz.
> 
> Then you need another (better?) queueing mechanism.
> 
> Use multiple queues and a _overflowable_ sequence number as
> global variable between the queues. 
> 
> N Queues (N := no. of CPUs + 1), which have a spin_lock for each
> queue.
> 
> optionally: One reader packet reassembly priority queue (APQ) ordered by
>    sequence number (implicitly or explicitly), if this shouldn't
>    be done in user space.
> 
> In the writer ISR: 
> 
>    Foreach Queue in RR order (start with remebered one):
>    - Try to lock it with spin_trylock (totally inline!)
>      + Failed
>         * if we failed to find a free queue for x "rounds", disable
>           device (we have no reader) and notify user space somehow
>        * increment "rounds" 
>        * next queue
>      + Succeed
>        * Increment sequence number
>        * Put data record into queue
>       (* remember this queue as last queue used)
>       (* mark queue "not empty")
>        * do other IRQ work...
> 
> In the reader routine:
>    Foreach Queue in RR order (start with remebered one):
>    - No data counter above threshold -> EAGAIN [1] 
>    - Try to lock it with spin_trylock (totally inline!)
>      + Failed -> next queue
>      + Succeed
>        * if queue empty, unlock and try next one
>       (* remember this queue as last queue used)
>        * Get one data record from queue (in queue order!)
>        * Move data record into APQ
>        * Unlock queue
>        * Deliver as much data from the APQ, as the user wants and
>          is available
>     - if all queues empty or locked -> increment "no data round"
>       counter
>   
> 
> Notes:
>    The "last queue used" variable is static, but local to routine.
>    It is there to decrease the number of iterations and distribute
>    the data to all queues as more equally.
> 
> 
>    Statistics about lock contention per queue, per round and per
>    try would be nice here to estimate the number of queues
>    needed.
> 
>    The APQ can be quite large, if the sequences are bad
>    distributed and some queues tend to be always locked, if the
>    reader wants to read from this queue.
> 
>    The above can be solved by 2^N "One entry queues" (aka slots)
>    and sequence numbers mapping to this slots. If you need many
>    slots (more then 256, I would say) then this is again 
>    inaccaptable, because of the iteration cost in the ISR.
>    
> What do you think? After some polishing this should decrease lock
> contention noticibly.
> 
> 
> Regards
> 
> Ingo Oeser
> 
> [1] Blocking will be harder to implement here, since we need to
>    notify the reader routine, that we have data available, which
>    involves some latency you cannot afford. Maybe this could be
>    done via schedule_task(), if needed.
> -- 
> Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
> 

For further discussion I will take this off-list. However, you are
correct. The very simple ISR that I have (I did preallocate buffers)
leaves a great deal of room for improvement.

However, the logic that you mention has execution overhead as well.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


