Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSC0Vbh>; Wed, 27 Mar 2002 16:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSC0Vb2>; Wed, 27 Mar 2002 16:31:28 -0500
Received: from chaos.analogic.com ([204.178.40.224]:48514 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289815AbSC0VbL>; Wed, 27 Mar 2002 16:31:11 -0500
Date: Wed, 27 Mar 2002 16:33:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jap3003+response@ksu.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: quick Scheduler design question
In-Reply-To: <20020327144315.E8487@ksu.edu>
Message-ID: <Pine.LNX.3.95.1020327160021.15915A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Joseph Pingenot wrote:

> Howdy.
> 
> I haven't poked at it much, but some of you might have a free minute to
>   answer a fairly simple scheduler question.
> 
> Does the scheduler merely select what process is going to run next, and
>   then pause the current process and run the new one?  If so, would it be
>   beneficial to instead have the scheduler

Other tasks get run when any task is waiting for I/O to complete.
Since most tasks that are idle (sleeping) at any one time, for the
most part, only CPU-bound tasks that were preempted end up being
the next process to run anyway. This makes the tasks that had the
CPU taken forcefully away be the task that gets it back. 

>     a) run the task currently specified as being second-to-next

See above, there are no "second-to-next".

>     b) select the task which will be run second-to-next and, if necessary,
>          start to get whatever needs to be un-swapped [maybe make the
>          processes state TASK_NEXTUP or something, and have its pages
>          slowly swap in on timer or something]

Swapping occurs only when some running task accesses virtual address
space that is not currently present in memory, and/or, when the
kernel must steal pages from sleeping tasks to provide virtual
memory for some task that has page-faulted.

There is no way for the kernel to 'know' what a running task will
do next. You are free to write code that accesses all allocated
address space in a purely random manner. 

> 
> It seems to me that, if it's not already being done, this would increase
>   complexity only a *little*, while making it *seem* faster, since the
>   next process would be swapping in while the current process uses up its
>   time.  Naturally, this would cause problems if both processes can't fully
>   swap in together.
> 

The problems are that you don't seem to understand how a virtual
memory system works. Also, except in CPU-bound bench-marks that
don't relate to real tasks, tasks are seldom preempted. They
end up calling the kernel for some I/O and, while waiting for
that I/O to complete, the CPU is given to some other task.

If you do `ps -lae`, you will see a lot of tasks that are
sleeping. When the kernel needs some real RAM pages to satisfy
a tasks page-fault, it may take a page from one of these
sleeping tasks and write the contents to disk. It then marks
that PTE for the sleeping task 'not-present' and uses that
page to satisfy the current page-fault. When, if ever, the
sleeping task starts executing it may attempt to access the
missing page. This traps to the kernel, i.e., creates a page-
fault. The kernel tries to find a free page. It may find one.
If not, it may steal one from another sleeping task. In any
event, the kernel writes the contents, saved to disk, to the
replacement page, marks the PTE 'present' and returns control
to the page-faulted task. This is how a virtual memory system
works.

Eventually, you may have most all of the pages of sleeping
tasks written to disk. If the tasks never wake up (certain
network daemons, etc.). You have actually freed the sleeping
tasks pages and they become part of the resources available
for instant page-faulting. Before the kernel will steal
pages from tasks, it will exhaust most of its own buffer-pool
so, if your machine is into 'hard-swapping' it may be that
what it really is doing is writing disk file buffers to
disk, not actually writing to the swap-file. If you have
two or more disks, you can put the swap-file on the least-
used disk and see what Disk LED comes on during 'swapping'.
Usually, the I/O that occurs in a memory-starved condition is
not writing to the swap-file/device. Instead, it's writing
buffers to disk to free up RAM. So, you can see, any
for-knowledge of potential swapping isn't going to help
in the most common case.

Linux and Unix have virtual file-systems as well as virtual
address space. Basically, what you think is the file-system,
regardless of the physical device it was built upon, is really
just a RAM disk. This makes it fast. On the RAM disk, many
temporary files may be created and deleted without them ever
being written to the physical drive. This internal RAM disk
"overflows" to the physical media on a "least-recently-used"
basis. This keeps the recent file data in memory and the old
stuff on the physical drive(s). When the system needs more
memory to satisfy page-faults, it steals from the RAM disk
(disk buffers) first.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

