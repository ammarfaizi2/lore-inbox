Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWC3Vew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWC3Vew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWC3Vew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:34:52 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:23976 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750974AbWC3Vev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:34:51 -0500
Message-ID: <442C4ECF.3080505@tlinx.org>
Date: Thu, 30 Mar 2006 13:34:07 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
References: <4426515B.5040307@tlinx.org> <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr> <20060326100639.GE4053@stusta.de> <4427BCCC.4080506@tlinx.org> <4427CE4D.5010109@grupopie.com>
In-Reply-To: <4427CE4D.5010109@grupopie.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> AFAICR, the problem with gcc3 and unit-at-a-time was stack usage with 
> local variables on automatically inlined functions.
>
> For instance, if function A called B and after B returned called C, 
> both local variables of B and C would be given a reserved space on the 
> stack during the execution of A if both functions were automatically 
> inlined. So the space needed now was A+B+C whereas before was Max(A+B, 
> A+C).
>
Hmmm...that at least makes some sense for disabling it, but jeez,
this stack "thing" is such an "unknown quantity".  It would be
"nice" if we had some clue about how much stack our systems actually
use -- I'm using a 4K stack size and system has been rock-solid
stable since around release of 2.15.2. 

If I "doubled" my stack back to 8K, that would lower the "random
probability" of hitting a stack limit, but right now, it seems like
amount of stack "needed" is nearly guesswork.  Sigh.  Having my
kernel fairly static and minimalistic (no unused modules; no loadable
modules, etc) I might only "need" 3K.

1) It would be nice if a "stack usage" option could be turned on
that would do some sort of run-time bounds checking that could
display the max-stack used "so far" in "/proc".

2) How difficult would it be to place kernel stack in a "pageable" pool 
where the limit of valid data in a 4K page is only 3.5K - then
when a kernel routine tries to exceed the stack boundary, it takes a
page fault where a "note" could be logged that more stack was "needed",
then automatically map another 4K page into the stack and return to
interrupted routine.

It sounds a bit strange -- the kernel having to call another part of
the kernel to handle a pagefault within the kernel, but perhaps there
could be another level of "partitioning" w/in kernel space that would
allow the non-paging part of the kernel to be paged in/out in a similar
way to user code. 

I have *no clue*, if it is the same idea, but the NT kernel has *parts*
of the kernel marked swappable by default.  If one wants to lock all of
the kernel in memory, there is a flag that can be set in the registry
 to disable paging the "Executive".  Could that be applicable in
Linux?

-l


