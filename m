Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265909AbSKBJwG>; Sat, 2 Nov 2002 04:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265910AbSKBJwG>; Sat, 2 Nov 2002 04:52:06 -0500
Received: from ns.suse.de ([213.95.15.193]:2316 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265909AbSKBJwF>;
	Sat, 2 Nov 2002 04:52:05 -0500
To: Akira Tsukamoto <at541@columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1/2 2.5.45 cleanup & add original copy_ro/from_user
References: <20021102024957.220C.AT541@columbia.edu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 Nov 2002 10:58:35 +0100
In-Reply-To: Akira Tsukamoto's message of "2 Nov 2002 10:12:07 +0100"
Message-ID: <p737kfws378.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Tsukamoto <at541@columbia.edu> writes:

> The original copy_to/from_user routine, existed for long time, was 
> deleted in 2.5.45 when the new faster_intel_copy went in.
> But it was very compact and was also optimal for old
> none-heavily-pipelined CPU, such as, i386/486/clasic pentium.
> 
> This patch will:
> 1) If it is not X86_MPENTIUMIII or 4, use the original copy routines, 
>    which does not exist in 2.5.45.

First you're ignoring Athlon, which also prefers unrolled copies.

Often distribution kernels are compiled for i386 to work on all possible
machines, but the majority of boxes they run on are ppro class or better.
With your patch they would all use the inefficient user copy, penalizing
the majority.

To really use it it would be better to split the existing CPU options
in two (similar to gcc): 
- optimized for
- and minimum level supported

The old user copy functions should then only used when not optimizing for
modern cpus, but not when the minimum level is 386. And perhaps when
CONFIG_SMALL is defined.

In theory it may make sense to even add a third option to cover an important
special case: the P4 has 128byte L2 cache lines, which tend to bloat all
SMP aware data structures a lot. Using only 64byte cache lines as needed
on P3 or Athlon makes for a much more compact SMP kernel. But performance
on SMP P4 will be bad if the 128 byte cache line is not taken into account,
so if you may ever plan to use the kernel on P4 SMP you should definitely
assume 128 byte cachelines.
So it may make sense to add an "smp supported on" or perhaps "smp not supported
on" menu for this case too.

-Andi
