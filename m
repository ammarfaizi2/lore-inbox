Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSGHNDi>; Mon, 8 Jul 2002 09:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSGHNDh>; Mon, 8 Jul 2002 09:03:37 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:42256 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316892AbSGHNDg>;
	Mon, 8 Jul 2002 09:03:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 08:21:59 -0400."
             <Pine.LNX.3.95.1020708082014.19138A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jul 2002 23:06:05 +1000
Message-ID: <17584.1026133565@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 08:21:59 -0400 (EDT), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>On Thu, 4 Jul 2002, Daniel Phillips wrote:
>> Is it just the mod_dec_use_count; return/unload race we're worried about?  
>> I'm not clear on why this is hard.  I'd think it would be sufficient just to 
>> walk all runnable processes to ensure none has an execution address inside the
>> module.  For smp, an ipi would pick up the current process on each cpu.
>> 
>> At this point the use count must be zero and the module deregistered, so all 
>> we're interested in is that every process that dec'ed the module's use count 
>> has succeeded in executing its way out of the module.  If not, we try again 
>> later, or if we're impatient, also bump any processes still inside the module 
>> to the front of the run queue.
>
>Assuming that there are no users of a module, i.e., the current
>MOD_DEC_USE_COUNT mechanism, checked under a lock, I think all
>you have to do to assure race-free module removal is to:
>
>(1)	Make sure that `current` isn't preempted. There are several
>        ways to do this. This may require another global variable.
>
>(2)	Execute cleanup_module(). It is assumed that the user-code
>	will deallocate interrupts, and free resources, etc.

You must not deallocate any resources until you have flushed out any
callers who have loaded the address of a module function but not yet
done MOD_INC_USE_COUNT.  It races between cleanup and a new consumer
entering the module.

>(3)	Set a global flag "module_remove", it doesn't have to be atomic.
>	It needs only to be volatile. It is used in schedule() to trap
>	all CPUs.
>        schedule()
>        {
>            while(module_remove)
>                ;
>        }
>
>(4)	Wait number-of-CPUs timer-ticks with interrupts alive and well.
>        This will make certain that everything queued on the timer gets
>        a chance to be executed and everything that would be preempted
>        gets trapped in schedule().
> 
>(5)	Remove the module, reset the flag.
>
>The cost is the single variable that must be checked every time schedule()
>is executed plus the 'don't preempt me' variable (if necessary).

(3) and (4) are the handwaving[1] bit that says 'wait until all
consumers have either left the module or incremented the use count'.  I
don't like the idea of completely stopping schedule.  Apart from the
long latency it introduces on module removal, I suspect that threads
belong to the module being removed will be a problem, they must proceed
to completion and full thread clean up.

Frankly the quiesce code is not the real problem.  The real race is
this one :-

Check use count, 0 so proceed with unload.
      Another task enters the module on another cpu.
Call cleanup_module(), remove resources.
      Increment use count.
      Use resources, oops.

There are only two viable solutions to this race.  Either _always_
increment the use count outside the module (via the owner field in
structures) or split module exit code in two, as described in [1].

The current code tries to use 'increment use count outside module' but
that has its own race in getting the address of the module.  Closing
that race relies on the interaction between three (yes, three)
unrelated locks which have to be obtained and released in the right
order.  Not only is this complex and fragile, a quick scan of the
kernel found one outright bug and several dubious sections of code.

Rusty and I think that the current method is difficult to use and to
audit, as well as scattering the complexity around the kernel.  Not to
mention that preempt breaks the existing code.  We both think that we
should give up on the current method and put all the complexity of
flushing stale references in one place[2].  The downside is the need to
split module init and exit code into two phases, i.e. change every
module to separate unregister from unallocate.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=102574568025442&w=2
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=102575536930661&w=2 

