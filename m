Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbTACVYI>; Fri, 3 Jan 2003 16:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267669AbTACVYI>; Fri, 3 Jan 2003 16:24:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:11137 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267668AbTACVYG>;
	Fri, 3 Jan 2003 16:24:06 -0500
Message-ID: <3E16016B.8D6092BE@digeo.com>
Date: Fri, 03 Jan 2003 13:32:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <94F20261551DC141B6B559DC4910867204491F@blr-m3-msg.wipro.com.suse.lists.linux.kernel> <3E155903.F8C22286@digeo.com.suse.lists.linux.kernel> <p734r8qnkkp.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 21:32:30.0594 (UTC) FILETIME=[9EC04E20:01C2B36F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@digeo.com> writes:
> >
> > The teeny little microbenchmarks are telling us that the rmap overhead
> > hurts, that the uninlining of copy_*_user may have been a bad idea, that
> > the addition of AIO has cost a little and that the complexity which
> > yielded large improvements in readv(), writev() and SMP throughput were
> > not free.  All of this is already known.
> 
> If you mean the signal speed regressions they caused - I fixed
> that on x86-64 by inlining 1,2,4,8,10(used by signal fpu frame),16.
> But it should not use the stupud rep ; ..., of the old ersio but direct
> unrolled moves.

Yes, that would help a bit.  We should do that for ia32.  It's a little
worrisome that the return value from such a copy_*_user() implementation
will be incorrect - it is supposed to return the number of uncopied bytes.
Probably doesn't matter.

Most of the optimisation opportunities wrt signal delivery were soaked up
by replacing the copy_*_user() calls with put_user() and friends.

We could speed up signals heaps by re-lazying the fpu state storage in
some manner.

> x86-64 version in include/asm-x86_64/uaccess.h, could be ported
> to i386 given that movqs need to be replaced by two movls.
> 
> -Andi
> 
> P.S.: regarding recent lmbench slow downs: I'm a bit
> worried about the two wrmsrs which are in the i386 context switch
> in load_esp0 for sysenter now. Last time I benchmarked WRMSRs on
> Athlon they were really slow and knowing the P4 it is probably
> even slower there. Imho it would be better to undo that patch
> and use Linus' original trampoline stack.

hm.  How slow?  Any numbers on that?
