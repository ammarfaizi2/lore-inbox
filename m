Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264373AbRFOMKm>; Fri, 15 Jun 2001 08:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRFOMKc>; Fri, 15 Jun 2001 08:10:32 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:4557 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264373AbRFOMKX>; Fri, 15 Jun 2001 08:10:23 -0400
Date: Fri, 15 Jun 2001 14:10:47 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP spin-locks
Message-ID: <20010615141047.K754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200106142045.f5EKjLI14289@mailf.telia.com> <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Jun 14, 2001 at 05:05:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 05:05:07PM -0400, Richard B. Johnson wrote:
> The problem is that a data acquisition board across the PCI bus
> gives a data transfer rate of 10 to 11 megabytes per second
> with a UP kernel, and the transfer drops to 5-6 megabytes per
> second with a SMP kernel. The ISR is really simple and copies
> data, that's all.
> 
> The 'read()' routine uses a spinlock when it modifies pointers.
> 
> I started to look into where all the CPU clocks were going. The
> SMP spinlock code is where it's going. There is often contention
> for the lock because interrupts normally occur at 50 to 60 kHz.

Then you need another (better?) queueing mechanism.

Use multiple queues and a _overflowable_ sequence number as
global variable between the queues. 

N Queues (N := no. of CPUs + 1), which have a spin_lock for each
queue.

optionally: One reader packet reassembly priority queue (APQ) ordered by
   sequence number (implicitly or explicitly), if this shouldn't
   be done in user space.

In the writer ISR: 

   Foreach Queue in RR order (start with remebered one):
   - Try to lock it with spin_trylock (totally inline!)
     + Failed
        * if we failed to find a free queue for x "rounds", disable
          device (we have no reader) and notify user space somehow
       * increment "rounds" 
       * next queue
     + Succeed
       * Increment sequence number
       * Put data record into queue
      (* remember this queue as last queue used)
      (* mark queue "not empty")
       * do other IRQ work...

In the reader routine:
   Foreach Queue in RR order (start with remebered one):
   - No data counter above threshold -> EAGAIN [1] 
   - Try to lock it with spin_trylock (totally inline!)
     + Failed -> next queue
     + Succeed
       * if queue empty, unlock and try next one
      (* remember this queue as last queue used)
       * Get one data record from queue (in queue order!)
       * Move data record into APQ
       * Unlock queue
       * Deliver as much data from the APQ, as the user wants and
         is available
    - if all queues empty or locked -> increment "no data round"
      counter
  

Notes:
   The "last queue used" variable is static, but local to routine.
   It is there to decrease the number of iterations and distribute
   the data to all queues as more equally.


   Statistics about lock contention per queue, per round and per
   try would be nice here to estimate the number of queues
   needed.

   The APQ can be quite large, if the sequences are bad
   distributed and some queues tend to be always locked, if the
   reader wants to read from this queue.

   The above can be solved by 2^N "One entry queues" (aka slots)
   and sequence numbers mapping to this slots. If you need many
   slots (more then 256, I would say) then this is again 
   inaccaptable, because of the iteration cost in the ISR.
   
What do you think? After some polishing this should decrease lock
contention noticibly.


Regards

Ingo Oeser

[1] Blocking will be harder to implement here, since we need to
   notify the reader routine, that we have data available, which
   involves some latency you cannot afford. Maybe this could be
   done via schedule_task(), if needed.
-- 
Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
