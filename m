Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUA3Rfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUA3Rfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:35:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:29056 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262913AbUA3Rff
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:35:35 -0500
Date: Fri, 30 Jan 2004 17:34:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040130173440.GB6285@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com> <20040130041708.GA2816@mail.shareable.org> <4019E713.1010107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4019E713.1010107@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Your entire scheme is based on this and therefore not worth the bits
> used to store it.  Your understanding of how and where syscalls are made
> and how ELF works is flawed.  There is no "group the syscalls nicely
> together", they are all over the place, inlined in many places.

That's a choice.  There is no reason why you cannot put the entry path
of all the stub functions called "read", "write" etc. in a special
section.  For syscalls inlined in larger functions, then it's
reasonable to avoid text relocation in those places and use an
indirect call as done now.  Surely there aren't too many of those,
though, because LD_PRELOAD libraries which override syscall stubs
rather depend on all normal calls to a syscall going through the stubs?

> there is no concept of weak aliases in dynamic linking.  Finding all
> the "aliases" requires lookups by name for now more than 200 syscall
> names and growing.

See Ingo's post.

> Prelinking can help if it is wanted, but if the vDSO address is
> changed or randomized (this is crucial I'd say) or the vDSO is not
> setup up for a process, the full price has to be paid.

I agree; it is not reasonable to depend on prelinking.

> With every kernel change the whole prelinking has to be redone.

Not really, that's an implementation limitation, there's no reason to
prelink the entire system just to alter the jumps in libc.so on those
occasions when a new kernel is run.  If vDSO randomisation is per boot
rather than per task (because the latter implies an MSR write per
context switch), then a libsyscall.so can be patched at boot time.

Yes I know, extravagent ideas, just wanted to write them for folk to
be aware of the possibilities.

> If gettimeofday() is the only optimized syscall, just add a simple
> 
>   cmp $__NR_gettimeofday, %eax
>   je  __vsyscall_gettimeofday
> 
> to the __kernel_vsyscall code.

That does seem to be a very practical answer for now :)

-- Jamie
