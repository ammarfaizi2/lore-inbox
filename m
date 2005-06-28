Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVF1C6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVF1C6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 22:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVF1C6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 22:58:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:60034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262310AbVF1C6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 22:58:43 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org,
       hch@infradead.org
Subject: Re: reiser4 merging action list
References: <42BB7B32.4010100@slaphack.com.suse.lists.linux.kernel>
	<200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl.suse.lists.linux.kernel>
	<20050627092138.GD11013@nysv.org.suse.lists.linux.kernel>
	<20050627124255.GB6280@thunk.org.suse.lists.linux.kernel>
	<42C0578F.7030608@namesys.com.suse.lists.linux.kernel>
	<20050627212628.GB27805@thunk.org.suse.lists.linux.kernel>
	<42C084F1.70607@namesys.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Jun 2005 04:58:33 +0200
In-Reply-To: <42C084F1.70607@namesys.com.suse.lists.linux.kernel>
Message-ID: <p73vf3zuqzq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

>    * metafiles should be disabled until we can present code that works
> right.  Half the list thinks we cannot solve the cycles problem ever. 
> Disable metafiles and postpone problem until working code, or the
> failure to produce it, makes it possible to do more than rant at each
> other.  This is currently already done in the -mm patches, but is
> mentioned lest someone think it forgotten.
> 
>    * update the locking documentation
> 
> Probably I forget something.

These are all big picture issues, but I think some low level attention to
the individual code is still needed.

Some stuff that stood out from a very quick look:

I would like for the custom spin lock debugging (spin_macros.h) and
profiling code to be removed (prof.[ch], spinprof.[ch]). Such code shouldn't 
be in specific subsystems. 

The division functions in lib.h are useless IMHO, both callers seem
to use divide by a power of two. And gcc supports shift in 64bit
fine in the kernel. Can you remove that please? 

statcnt.h: This is completely useless because you don't align
the individual fields for cache lines - so you will still
have false sharing everywhere. Also using NR_CPUS is nasty
because it can be very big - num_possible_cpus() is better. 
It should use the new dynamic per cpu allocator.

Best you just remove it for now and use atomic_t and readd properly
when you do real SMP tuning with measurements.

debug.[ch]: A lot of these functions like "schedulable" are name space
space polluting. 
reiser4_kmalloc() such wrappers are deprecated. Please remove.
xmemset et.al should be replaced with the normal functions everywhere

Best would be probably to remove most of these files for submission.

What is reiser4_internal? Can't you just use static like
everybody else?

status_flags.c: Please remove that CONFIG_FRAME_POINTER code.
In general i think it would be better if you removed that 
"private mini crashdumping".

Is there any reason you can't just use wait queues like everybody
else instead of these reimplemented condition variables in kcond.[ch]?

In general it would be good if someone experienced not from the reiser team
would read the whole source and looks for obvious problems
(I didn't, just mentioning stuff I from a quick look at some support
files) 

-Andi

