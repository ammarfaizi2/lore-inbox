Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTEGS2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEGS2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:28:16 -0400
Received: from watch.techsource.com ([209.208.48.130]:64394 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264151AbTEGS2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:28:14 -0400
Message-ID: <3EB953FA.8020802@techsource.com>
Date: Wed, 07 May 2003 14:44:10 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Roland Dreier <roland@topspin.com>,
       Jonathan Lundell <linux@lundell-bros.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com> <Pine.LNX.4.53.0305071424290.13499@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:
> On Wed, 7 May 2003, Roland Dreier wrote:
> 
> 
>>    Richard> The kernel stack, at least for ix86, is only one, set
>>    Richard> upon startup at 8192 bytes above a label called
>>    Richard> init_task_unit. The kernel must have a separate stack
>>    Richard> and, contrary to what I've been reading on this list, it
>>    Richard> can't have more kernel stacks than CPUs and, I don't see
>>    Richard> a separate stack allocated for different CPUs.
>>
>>This is total nonsense.  Please don't confuse matters by spreading
>>misinformation like this.  Every task has a separate (8K) kernel
>>stack.  Look at the implementation of do_fork() and in particular
>>alloc_task_struct().
>>
>>If there were only one kernel stack, what do you think would happen if
>>a process went to sleep in kernel code?
>>
>> - Roland
>>
> 
> 
> No, No. That is a process stack. Every process has it's own, entirely
> seperate stack. This stack is used only in user mode. The kernel has
> it's own stack. Every time you switch to kernel mode either by
> calling the kernel or by a hardware interrupt, the kernel's stack
> is used.
> 
> When a task sleeps, it sleeps in kernel mode. The kernel schedules
> other tasks until the sleeper has been satisfied either by time or
> by event.


I don't think this is quite accurate either.  I have been reading this 
thread, and putting that together with what makes sense to me, I gather 
that Linux uses the following stacks:

1) A variable sized user-space stack, one per process (maybe more for 
user-level threads?).  This is swappable.

2) One 8K kernel stack for each process.  This is used for situations 
such as when a user process makes a system call that then needs to use a 
stack.  This has to be separate from the user stack for two reasons:
    (a) If the user process borked the user stack pointer, the kernel 
still needs to have something valid.
    (b) The stack used by the kernel cannot be swappable.

3) One single interrupt stack for hardware interrupts.  I don't know how 
various CPU's deal with this, so either the CPU knows to use this for 
hardware interrupts, or the hardware interrupt starts using the current 
process's kernel stack then realizes this and switches over.


At the moment, I'm assuming that when the kernel is preempted, the stack 
switched to is one which is the kernel stack for some other process.

