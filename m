Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbTIKFLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbTIKFLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:11:19 -0400
Received: from colin2.muc.de ([193.149.48.15]:53513 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266088AbTIKFLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:11:17 -0400
Date: 11 Sep 2003 07:11:21 +0200
Date: Thu, 11 Sep 2003 07:11:21 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: dada1 <dada1@cosmosbay.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911051121.GA7751@colin2.muc.de>
References: <uqD5.3BI.3@gated-at.bofh.it> <m3iso0arlx.fsf@averell.firstfloor.org> <0a5801c37821$54eb8180$890010ac@edumazet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5801c37821$54eb8180$890010ac@edumazet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 06:58:23AM +0200, dada1 wrote:
> 
> From: "Andi Kleen" <ak@muc.de>
> >
> > Of course they may want to also fix it in a different way to run on older
> > kernels (e.g. handling the signal in user space or avoiding the
> conditions).
> > But doing it centrally in the kernel is a bit cleaner and at some point
> > people have to update their kernels anyways.
> 
> Could you be kind enough to post here the example code for a SIGSEGV handler
> that would be necessary for old kernels ?

I don't have any. But it would be very similar to the in kernel checking
code (see the is_prefetch function in my patches). Just you feed it
the fields from sigcontext in the signal handler and replace __get_user 
with a normal memory access.

> 
> I do think it woul help some people like me, for the future googling on the
> prefetch errata.
> 
> I do use preftechnta instructions on my programs, and this errata could
> explain some strange crashes.

The bogus faults are very easy to diagnose. When you have a core dump
and disassemble the faulting instruction (in gdb x/i $eip) and it is
a prefetch (prefetch/prefetchw/prefetchnt*) then it could be that.

If it is a different instruction it is unrelated.

It would also only happen when you prefetch ever on unmapped addresses.

> 
> As the program crashing is a huge multi-threaded network application, with
> up to 300000 opened TCP sockets, the SIGSEGV fault is usually followed by a
> system crash (networks buffers using all of lowmem)

That sounds like an unrelated issue.

When user space crashes on this the kernel is unaffected.

In case the 2.6 kernel crashes on this (2.4 does not trigger it)
then you can also run the oops through ksymoops and check if the 
faulting instruction is prefetch. If it isn't  then it is something else.

Network buffers using up all of low mem and then crash 
is likely some OOM handling problem. If you're on 2.4 try an -aa kernel, 
they handle this much better than the marcelo tree. If it's 2.6 then 
I would recommend posting oopses on this list, maybe someone can fix 
it. I suspect 2.6's OOM handling could be still improved.

-Andi
