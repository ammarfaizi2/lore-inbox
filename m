Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSETPo0>; Mon, 20 May 2002 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316091AbSETPoZ>; Mon, 20 May 2002 11:44:25 -0400
Received: from fmr01.intel.com ([192.55.52.18]:17610 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S316089AbSETPoY>;
	Mon, 20 May 2002 11:44:24 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C05F0ED87@orsmsx111.jf.intel.com>
From: "Gross, Mark" <mark.gross@intel.com>
To: Erich Focht <efocht@ess.nec.de>, mark.gross@intel.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
        Daniel Jacobowitz <dan@debian.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: PATCH Multithreaded core dump support for the 2.5.14 (and 15)
	 kernel.
Date: Mon, 20 May 2002 08:44:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first thing I would like to get right is besides the mmap_sem are there
any other semaphores that need looking out for.  I'm working on this now.
Are there any thoughts on this issue?

Is simply not grabbing the mmap_sem inside of elf_core_dump for
multithreaded dumps a viable option?

I like your second suggestion more than the first.  I think it isolates the
changes needed to make TCore work more than tweaking the task struct and
_down_write (to write to the proposed new task data member).

(W) 503-712-8218
MS: JF1-05
2111 N.E. 25th Ave.
Hillsboro, OR 97124


> -----Original Message-----
> From: Erich Focht [mailto:efocht@ess.nec.de]
> Sent: Friday, May 17, 2002 5:26 AM
> To: mark.gross@intel.com
> Cc: linux-kernel; Robert Love; Daniel Jacobowitz; Alan Cox
> Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and
> 15) kernel.
> 
> 
> > The original question was:
> > Couldn't the TCore patch deadlock in elf_core_dump on a semiphore held
by a
> > sleeping process that gets placed onto the phantom runque?
> > 
> > So far I can't tell the problem is real or not, but I'm worried :(
> > 
> > I haven't hit any such deadlocks in my stress testing, such as it is. In
my
> > review of the code I don't see any obviouse problems dispite the fact
that
> > the mmap_sem is explicitly grabbed by elf_core_dump.
> > 
> > --mgross
> 
> Here are two different examples:
>  - some ps [1] does __down_read(mm->mmap_sem).
>  - meanwhile one of the soon crashing threads [2] does sys_mmap(),
>    calls __down_write(current->mmap_sem), gets on the wait queue
>    because the semaphore is currently used by ps.
>  - another thread [3] crashes and wants to dump core, sends [2] to
>    the phantom rq, calls __down_read(current->mmap_sem) and waits.
>  - [1] finishes the job, calls __up_read(mm->mmap_sem), activates
>    [2] on the phantom rq, exits.
> deadlock
> 
> Or:
>  - thread [2] does sys_mmap(), calls __down_write(current->mmap_sem),
>    gets the semaphore.
>  - thread [2] is preempted, taken off the cpu
>  - meanwhile thread [3] crashes, etc...
> 
> I think the problem only occurs if one of the related threads calls
> __down_write() for one of the semaphores we need to get inside
> elf_core_dump (which are these?). So maybe we could do two things:
> 
>  - remeber the task which _has_ the write lock (add a "task_t 
> sem_writer;"
> variable to the semaphore structure)
> 
>  - inside elf_core_dump use a special version of __down_read() which
> checks whether any related thread is enqueued and waiting for this
> semaphore or whether sem_writer points to a member of the own thread
> group. The phantom rq lock should be held. This new __down_read()
> could wait until only related threads are enqueued and 
> waiting and just
> deal as if the semaphore is free (temporarilly set the value to zero),
> and add its original value at the end, when calling __up_read().
> 
> Just some thoughts... any opinions?
> 
> Regards,
> Erich
> 
> -- 
> Dr. Erich Focht                                <efocht@ess.nec.de>
> NEC European Supercomputer Systems, European HPC Technology Center
> 
