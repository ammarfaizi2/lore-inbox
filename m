Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTJAHU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTJAHU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:20:27 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42374 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262002AbTJAHUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:20:20 -0400
Date: Wed, 1 Oct 2003 08:20:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata  patch
Message-ID: <20031001072011.GJ1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <p73k77pzc69.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k77pzc69.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Looking at Andi's patch, it is also a dead box if the fault happens inside
> > down_write(mmap_sem).  That should be fixed, methinks.
> 
> The only way to fix all that would be to move the instruction checks early
> into the fast path.
> 
> [On a P4 the overhead is 3.7268 vs 3.6594 microseconds for a fault that 
> doesn't hit as measured by lmbench2's lat_sig. This was before the latest 
> changes which added more checking, so the overhead is probably bigger now]

Hi Andi!

I think the mmap_sem problems are fixed by an appropriate "address >=
TASK_SIZE" check at the beginning do_page_fault, which should jump
straight to bad_area_nosemaphore.  As there is already such a check,
there's no penalty for rearranging the logic there, and it will in
fact speed up kernel faults slightly by avoiding the mmap_sem and
find_vma() which are redundant for kernel faults.

I have some ideas for speeding up __is_prefetch().  First, take the
get_segment_eip() stuff from my patch - that should speed up your
latest "more checking" slightly, because it replaces the access_ok()
checks with something slightly tighter.

Second, instead of masking and a switch statement, do test_bit on a
256-bit vector.  (I admit I'm not quite sure how fast variable
test_bit is; this is assuming it is quite fast).  If it's zero, return
0 from __is_prefetch().  If it's one, it's either a prefix byte to
skip or 0x0f, to check the next byte for a prefetch.  That'll probably
make the code smaller too, because the vector is only 32 bytes,
shorter than the logic in the switch().

Third, once you have taken the "limit" variable idea from my patch,
clamp that at "instr + 14", and so remove the small amount of loop
setup and iteration overhead which is there to restrict the
instruction to 15 bytes.  Build it in to the other limit check.

Fourth, without a switch statement that's no need for a scan_more
variable.  Setting a boolean variable in one place to test it on
another is still surprisingly poor with GCC - it doesn't remove the
variable and turn the code into direct jumps as you'd think, much of
the time.  Just test the bit vector and if it's zero, return 0,
otherwise carry on to check if the byte is 0x0f, and if not, loop.

Fifth, the "if (regs->eip == addr)" check - is it helpful on 32-bit?

Thoughts for the day,
-- Jamie
