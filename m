Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSEVHsu>; Wed, 22 May 2002 03:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSEVHst>; Wed, 22 May 2002 03:48:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38639 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316883AbSEVHss>;
	Wed, 22 May 2002 03:48:48 -0400
Message-Id: <200205220748.g4M7mc2157646@northrelay01.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
To: "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Wed, 22 May 2002 13:26:41 +0530
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com>
Reply-To: vamsi_krishna@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice. This also closes another issue pointed out: freezing
a process while it is holding the mmap_sem, which may be needed later
while collecting thread registers on IA64.

Now that Linus has accepted Pavel's swsusp, do you have any thoughts 
on using Pavel's scheme to freeze processes?

Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com

On Wed, 22 May 2002 04:40:56 +0530, Gross, Mark wrote:

> Please see the updated tcore-2517.pat file.
> 
> After some investigations I concluded that the down_write(current->mm->mmap_sem)
> in elf_core_dump was to protect crashing multithreaded applications from dumping
> corrupted and possibly illegal mm data due to the actions of the other, still
> running, thread processes.
> 
> As my patch has these thread processes suspended on the phantom run queue we
> don't need to grab this semaphore in elf_core_dump any more.
> 
> However; we did see another potential issue on 4+ way systems with 3 or more
> processes of the same thread group entering suspend threads at about the same
> time.  In tcore_suspend_threads between the release of the spin locks and the
> calls to set_cpus_allowed, one of the other, crashing, thread processes could
> move this task, currently in set_cpus_allowed, to the phantom queue before it
> returns.  (a bad thing)
> 
> I've put in a fix for this possibility by doing down_write/up_write on
> current->mm->mmap_sem for the scope of tcore_suspend_threads.  This also as the
> benefit of stopping VM operations for the thread group until the thread group
> process are suspended.
> 
> This updated tcore patch has been tested on 2 and 4 way i386 systems, dumping
> core for pthread applications with 300+ thread process, while running the chat
> room benchmark.  It "seems" stable.
> 
> comments?
> 
> --mgross
> 
> (W) 503-712-8218
> MS: JF1-05
> 2111 N.E. 25th Ave.
> Hillsboro, OR 97124
> 
> 
>> -----Original Message-----
>> From: Gross, Mark
>> Sent: Monday, May 20, 2002 8:44 AM
>> To: Erich Focht; mark.gross@intel.com
>> Cc: linux-kernel; Robert Love; Daniel Jacobowitz; Alan Cox Subject: RE: PATCH
>> Multithreaded core dump support for the 2.5.14 (and 15) kernel.
>> 
>> 
>> The first thing I would like to get right is besides the mmap_sem are there any
>> other semaphores that need looking out for.  I'm working on this now.  Are
>> there any thoughts on this issue?
>> 
>> Is simply not grabbing the mmap_sem inside of elf_core_dump for multithreaded
>> dumps a viable option?
>> 
>> I like your second suggestion more than the first.  I think it isolates the
>> changes needed to make TCore work more than tweaking the task struct and
>> _down_write (to write to the proposed new task data member).
>> 
>> (W) 503-712-8218
>> MS: JF1-05
>> 2111 N.E. 25th Ave.
>> Hillsboro, OR 97124
>> 
>> 
>> > -----Original Message-----
>> > From: Erich Focht [mailto:efocht@ess.nec.de] Sent: Friday, May 17, 2002 5:26
>> > AM
>> > To: mark.gross@intel.com
>> > Cc: linux-kernel; Robert Love; Daniel Jacobowitz; Alan Cox Subject: Re: PATCH
>> > Multithreaded core dump support for the
>> 2.5.14 (and
>> > 15) kernel.
>> > 
>> > 
>> > > The original question was:
>> > > Couldn't the TCore patch deadlock in elf_core_dump on a
>> semiphore held by a
>> > > sleeping process that gets placed onto the phantom runque?
>> > > 
>> > > So far I can't tell the problem is real or not, but I'm worried :(
>> > > 
>> > > I haven't hit any such deadlocks in my stress testing,
>> such as it is. In my
>> > > review of the code I don't see any obviouse problems
>> dispite the fact that
>> > > the mmap_sem is explicitly grabbed by elf_core_dump.
>> > > 
>> > > --mgross
>> > 
>> > Here are two different examples:
>> >  - some ps [1] does __down_read(mm->mmap_sem). - meanwhile one of the soon
>> >  crashing threads [2] does sys_mmap(),
>> >    calls __down_write(current->mmap_sem), gets on the wait queue because the
>> >    semaphore is currently used by ps.
>> >  - another thread [3] crashes and wants to dump core, sends [2] to
>> >    the phantom rq, calls __down_read(current->mmap_sem) and waits.
>> >  - [1] finishes the job, calls __up_read(mm->mmap_sem), activates
>> >    [2] on the phantom rq, exits.
>> > deadlock
>> > 
>> > Or:
>> >  - thread [2] does sys_mmap(), calls
>> __down_write(current->mmap_sem),
>> >    gets the semaphore.
>> >  - thread [2] is preempted, taken off the cpu - meanwhile thread [3] crashes,
>> >  etc...
>> > 
>> > I think the problem only occurs if one of the related threads calls
>> > __down_write() for one of the semaphores we need to get inside elf_core_dump
>> > (which are these?). So maybe we could do two things:
>> > 
>> >  - remeber the task which _has_ the write lock (add a "task_t
>> > sem_writer;"
>> > variable to the semaphore structure)
>> > 
>> >  - inside elf_core_dump use a special version of __down_read() which
>> > checks whether any related thread is enqueued and waiting for this semaphore
>> > or whether sem_writer points to a member of the own thread group. The phantom
>> > rq lock should be held. This new __down_read() could wait until only related
>> > threads are enqueued and waiting and just deal as if the semaphore is free
>> > (temporarilly set the
>> value to zero),
>> > and add its original value at the end, when calling __up_read().
>> > 
>> > Just some thoughts... any opinions?
>> > 
>> > Regards,
>> > Erich
>> > 
>> > --
>> > Dr. Erich Focht                                <efocht@ess.nec.de> NEC
>> > European Supercomputer Systems, European HPC Technology Center
>> > 
>> >
