Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSEQM00>; Fri, 17 May 2002 08:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEQM0Z>; Fri, 17 May 2002 08:26:25 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:39367 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S315427AbSEQMZp> convert rfc822-to-8bit; Fri, 17 May 2002 08:25:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: mark.gross@intel.com
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Fri, 17 May 2002 14:26:00 +0200
X-Mailer: KMail [version 1.4]
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
        Daniel Jacobowitz <dan@debian.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205171426.00502.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The original question was:
> Couldn't the TCore patch deadlock in elf_core_dump on a semiphore held by a
> sleeping process that gets placed onto the phantom runque?
> 
> So far I can't tell the problem is real or not, but I'm worried :(
> 
> I haven't hit any such deadlocks in my stress testing, such as it is. In my
> review of the code I don't see any obviouse problems dispite the fact that
> the mmap_sem is explicitly grabbed by elf_core_dump.
> 
> --mgross

Here are two different examples:
 - some ps [1] does __down_read(mm->mmap_sem).
 - meanwhile one of the soon crashing threads [2] does sys_mmap(),
   calls __down_write(current->mmap_sem), gets on the wait queue
   because the semaphore is currently used by ps.
 - another thread [3] crashes and wants to dump core, sends [2] to
   the phantom rq, calls __down_read(current->mmap_sem) and waits.
 - [1] finishes the job, calls __up_read(mm->mmap_sem), activates
   [2] on the phantom rq, exits.
deadlock

Or:
 - thread [2] does sys_mmap(), calls __down_write(current->mmap_sem),
   gets the semaphore.
 - thread [2] is preempted, taken off the cpu
 - meanwhile thread [3] crashes, etc...

I think the problem only occurs if one of the related threads calls
__down_write() for one of the semaphores we need to get inside
elf_core_dump (which are these?). So maybe we could do two things:

 - remeber the task which _has_ the write lock (add a "task_t sem_writer;"
variable to the semaphore structure)

 - inside elf_core_dump use a special version of __down_read() which
checks whether any related thread is enqueued and waiting for this
semaphore or whether sem_writer points to a member of the own thread
group. The phantom rq lock should be held. This new __down_read()
could wait until only related threads are enqueued and waiting and just
deal as if the semaphore is free (temporarilly set the value to zero),
and add its original value at the end, when calling __up_read().

Just some thoughts... any opinions?

Regards,
Erich

-- 
Dr. Erich Focht                                <efocht@ess.nec.de>
NEC European Supercomputer Systems, European HPC Technology Center

