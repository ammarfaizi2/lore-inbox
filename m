Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTJAHj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 03:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTJAHjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 03:39:25 -0400
Received: from ns.suse.de ([195.135.220.2]:740 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261973AbTJAHjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 03:39:24 -0400
Date: Wed, 1 Oct 2003 09:39:22 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata  patch
Message-ID: <20031001073922.GL15853@wotan.suse.de>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <p73k77pzc69.fsf@oldwotan.suse.de> <20031001072011.GJ1131@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001072011.GJ1131@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 08:20:11AM +0100, Jamie Lokier wrote:
> I think the mmap_sem problems are fixed by an appropriate "address >=
> TASK_SIZE" check at the beginning do_page_fault, which should jump

Assuming vsyscalls never contain prefetch. 

> straight to bad_area_nosemaphore.  As there is already such a check,
> there's no penalty for rearranging the logic there, and it will in
> fact speed up kernel faults slightly by avoiding the mmap_sem and
> find_vma() which are redundant for kernel faults.

I guess that would work, agreed.

I will fix it this way for x86-64.

> 
> I have some ideas for speeding up __is_prefetch().  First, take the
> get_segment_eip() stuff from my patch - that should speed up your
> latest "more checking" slightly, because it replaces the access_ok()
> checks with something slightly tighter.

At least for x86-64 I just switched to checking the three possible
segments explicitely.

Imho that's the best way for 32bit too, non zero segment bases are
just not worth caring about.

> 
> Second, instead of masking and a switch statement, do test_bit on a
> 256-bit vector.  (I admit I'm not quite sure how fast variable
> test_bit is; this is assuming it is quite fast).  If it's zero, return
> 0 from __is_prefetch().  If it's one, it's either a prefix byte to
> skip or 0x0f, to check the next byte for a prefetch.  That'll probably
> make the code smaller too, because the vector is only 32 bytes,
> shorter than the logic in the switch().

I had the same idea earlier, but discarded it because it would make
the code much more ugly. It's better to just keep that stuff out of
the fast path, not optimize it to the last cycle.

Also I already have wasted too much time on this errata so I won't
do further updates. Feel free to take up the ball.

> Fifth, the "if (regs->eip == addr)" check - is it helpful on 32-bit?

It avoids one fault recursion for the kernel jumping to zero.

-Andi
