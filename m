Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274417AbRITK5v>; Thu, 20 Sep 2001 06:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272839AbRITK5m>; Thu, 20 Sep 2001 06:57:42 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:45162 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S274417AbRITK5c>; Thu, 20 Sep 2001 06:57:32 -0400
Message-ID: <3BA9CB84.16616163@stud.uni-saarland.de>
Date: Thu, 20 Sep 2001 10:57:08 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: andrea@suse.de, David Howells <dhowells@redhat.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Deadlock on the mm->mmap_sem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 20, 2001 at 09:01:13AM +0100, David Howells wrote:
> > 
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > > the process doesn't need to lock multiple mm_structs at the same time.
> > 
> > fork, ptrace, /proc/pid/mem, /proc/pid/maps
> >

David, coredump is the only difficult recursive user of mmap_sem.
ptrace & /proc/pid/mem double buffer into kernel buffers, fork just
doesn't lock the new mm_struct - it's new, noone can get a pointer to it
before it's linked into the various lists.

> for /proc/<pid>/maps this check takes care of it of course (or it could
> get unfair again: only when we're faulting on our vm we're allowed to go
> through):
> 
>         if (task == current)
>                 down_read_recursive(&mm->mmap_sem, &current->mm_recursor);
>         else
>                 down_read(&mm->mmap_sem);
> 
Andrea, my rewrite of proc_pid_read_maps fixes that without any ugly
recursive/nonrecursive tests.

Short summary of the possible fixes for the deadlock:

* A simple unfair mmap_sem (rw_lock like) is not possible.
* Copying the mm_struct is ugly.
* A fair, recursive mmap_sem (a task that already owns the mmap_sem can
acquire it again without deadlocking, all other cases are fair). That's
what Andrea proposes. (Andrea, is that correct?)
* moving the locking into each coredump handler. The main advantage is
that for some coredump handlers down_read is not enough - e.g.
elf_core_dump should call down_write to prevent concurrent expand_stack
calls, and acquire the pagetable_lock around some lines (right now it
walks the page tables without locking). I'll check the other coredump
handlers - during a quick check I couldn't find any oopsable races if
only a read lock is taken.

I'll write a patch that moves the locking into the coredump handlers,
then we can compare that with Andrea's proposal.

--
	Manfred
