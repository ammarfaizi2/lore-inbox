Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTCFAzF>; Wed, 5 Mar 2003 19:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTCFAzF>; Wed, 5 Mar 2003 19:55:05 -0500
Received: from ns.suse.de ([213.95.15.193]:12300 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267602AbTCFAzC>;
	Wed, 5 Mar 2003 19:55:02 -0500
Date: Thu, 6 Mar 2003 02:05:17 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030306010517.GB17865@wotan.suse.de>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E668267.5040203@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 03:04:07PM -0800, Ulrich Drepper wrote:
> >>1. every process will already use the prctl(ARCH_SET_FS).  We are
> >>talking here only about the 2nd thread and later.  We need to use
> >>prctl(ARCH_SET_FS) for TLS support.
> > 
> > 
> > Not when you put it into the first four GB. Then you can use the same
> > calls as 32bit.
> 
> Show me numbers.  Or even better: fix the kernel so that I can run it

You want the change, not me ;)

I did benchmark it some time ago (cannot share numbers sorry) and it 
didn't look like a good idea.

> myself.  What is the time difference between using the segment register
> switching with all the different allocated thread areas version using wrmsr.

It should already work on the current kernel, modulo clone.
(but arch_prctl, set_thread_area in 2.5, ldt in 2.4 etc.) 

> 
> 
> *Iff* using the MSR is slower, as far as I'm concerned the
> set_thread_area syscall should complete go away from x86-64.  Require

It's needed for 32bit emulation at least. The code is 100% shared
between the emulation and the native 64bit model.
In theory it could be removed from the system call table for 64bit
but there didn't seem a good reason to do so - after all 64bit programs
can put their thread local data into the first 4GB and 
fast context switches.

> the use of prctl to get and set the base address.  Then internally in
> the prctl call map it to either the use of a 32 base address segment or
> use the MSR.

The problem is that the 64bit base has different semantics. 

When you use a segment register you have to do:

	call kernel to set gdt/ldt
	movl index,%%fs

But when the kernel did set the 64bit base in the kernel call the
following movl to the selector would destroy it again

Loading the index inside the system call would also be problematic:
First it would be different from what i386 does, causing porting headaches.
Also you could not easily do it from a different thread unlike the 
LDT load.
	

> This way whoever needs a segment base address can preferably allocate it
> in the low 4GB, but if it fails the kernel support still work.  And with
> the same interface.  Currently this is not the case and this is not
> acceptable.

That should already work and it is in fact how I imagined this to be: 

do MAP_32BIT - if yes use set_thread_area or an LDT entry;

if not use arch_prctl

The NPTL signal race problem for the clones in case you have a 64bit
base is a bit ugly though I agree.

I don't like your patch currently because it'll guarantee slow 
context switch times for 64bit.

Automatic switching based on the set bits in the base may be possible 
(in fact I had something like this in set_thread_area for some time, but 
removed it because of the ugly semantics because set_thread_area doesn't
already load the selector). If the selector load is forced
in clone however it would not be as weird, just only somewhat
ugly. You'll have to guarantee in user space then that you don't
reload it.

Real solution would be Windowish - Create clone7() with both
selectors and bases 

[I suspect 2.8 and 3.0 will get that anyways as experience
on other operating systems who started on the same path 
shows. e.g. AmigaOS grew more CreateTask
variants with more arguments with each release until they eventually
settled on passing tag lists.]

-Andi
