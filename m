Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVLSSgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVLSSgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVLSSgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:36:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5906 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932343AbVLSSgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:36:03 -0500
Date: Mon, 19 Dec 2005 19:36:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Light-weight dynamically extended stacks
Message-ID: <20051219183604.GT23349@stusta.de>
References: <20051219001249.GD11856@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219001249.GD11856@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 04:12:49PM -0800, Matt Mackall wrote:

> Perhaps the time for this has come and gone, but it occurred to me
> that it should be relatively straightforward to make a form of
> dynamically extended stacks that are appropriate to the kernel.
> 
> While we have a good handle on most of the worst stack offenders, we
> can still run into trouble with pathological cases (say, symlink
> recursion for XFS on a RAID built from loopback mounts over NFS
> tunneled over IPSEC through GRE). So there's probably no
> one-size-fits-all when it comes to stack size.

My count of bug reports for problems with in-kernel code with 4k stacks 
after Neil's patch went into -mm is still at 0. That's amazing 
considering how many people have claimed in this thread how unstable
4k stacks were...

> Rather than relying on guard pages and VM faults like userspace, we
> can use a cooperative scheme where we "label" call paths that might be
> extra deep (recursion through the block layer, network tunnels,
> symlinks, etc.) with something like the following:
> 
> 	  ret = grow_stack(function, arg, GFP_ATOMIC);
> 
> This is much like cond_resched() except for stack usage rather than
> CPU usage. grow_stack() checks if we're in the danger zone for stack
> usage (say 1k remaining), and if so, allocates a new stack and
> swizzles the stack pointer over to it.
>...

If more than 3 kB of stack is used on i386 that's a bug.
And we should fix bugs, not work around them.

CONFIG_DEBUG_STACKOVERFLOW in arch/i386/kernel/irq.c shows the correct 
approach:
- a debug option for not harming performance
- dump_stack() when too much stack is used

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

