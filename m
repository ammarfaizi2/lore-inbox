Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTEHMO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbTEHMO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:14:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37192 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261355AbTEHMON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:14:13 -0400
To: Steffen Persvold <sp@scali.com>
Cc: petter wahlman <petter@bluezone.no>, linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>
Subject: Re: The disappearing sys_call_table export.
References: <Pine.LNX.4.44.0305071807250.3573-100000@sp-laptop.isdn.scali.no>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 May 2003 06:23:25 -0600
In-Reply-To: <Pine.LNX.4.44.0305071807250.3573-100000@sp-laptop.isdn.scali.no>
Message-ID: <m1el398w5e.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold <sp@scali.com> writes:

> On 7 May 2003, petter wahlman wrote:
> 
> >  
> > It seems like nobody belives that there are any technically valid
> > reasons for hooking system calls, but how should e.g anti virus
> > on-access scanners intercept syscalls?
> > Preloading libraries, ptracing init, patching g/libc, etc. are
> > obviously not the way to go.
> > 
> 
> Well, for a system wide system call hook, a kernel mechanism is necessary 
> (and useful too IMHO). However for our usage (MPI) it is enough to know 
> when the current process calls either sbrk(-n) or munmap glibc functions, 
> thus it is sufficient to implement some kind of callback functionality for 
> certain glibc functions, sort of like the malloc/free hooks but on a more 
> general basis since some applications doesn't use malloc/free but 
> implement their own alloc/free algorithms using the syscalls (one example 
> is f90 apps).
> 
> Ideas anyone ?

I think the complete list of functions to be hooked needs to be at least:
mmap(MAP_FIXED), munmap, sbrk(-n), shmat, shdt.  The mapping cases
are needed because a mmap(MAP_FIXED) can implicitly unmap an area under
them, before the new address is used.

This is not a kernel issue as this is purely a user space problem,
the kernel provides all of the necessary functionality.

I suspect what is needed is something like:
int on_unmap(void (*func)(void *start, size_t length, void *), void *arg);

With the function called before the unmap actually occurs, that way
the multi thread case is safe.  It needs to be built so that multiple libraries
can cooperate cleanly.

Ulrich what do you think.  Is the above function reasonable?
Something like it is needed to manage caches of pinned memory for high
performance kernel bypass libraries.

Eric
