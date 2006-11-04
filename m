Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753698AbWKDTke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbWKDTke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbWKDTke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:40:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753697AbWKDTkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:40:33 -0500
Date: Sat, 4 Nov 2006 11:35:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <454CE576.3000709@vmware.com>
Message-ID: <Pine.LNX.4.64.0611041117360.25218@g5.osdl.org>
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <454CE576.3000709@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Nov 2006, Zachary Amsden wrote:
>
> Every processor I've ever measured it on, popf is slower.  On P4, for example,
> pushf is 6 cycles, and popf is 54.  On Opteron, it is 2 / 12.  On Xeon, it is
> 7 / 91.

This meshes with my memory of doing the same.

A "pushf" at most needs to wait for previous ALU operations to serialize, 
it's not fundamnetally a very expensive operation at all (ie you should 
generally be able to do it totally pipelined, perhaps with a cycle of two 
of latency to the previous thing that could set a flag).

In _practice_, I suspect popfl is always microcoded (because parts of the 
flags are "slow" flags - all the stuff that isn't the pure arithmetic 
flags - and tend to be maintained in separate registers), which almost 
inevitably tends to mean that it isn't well pipelined, and that probably 
explains why it tends to be bigger than one or two cycles in practice (ie 
I'm surprised that your Opteron numbers are _that_ good - not because it's 
a hard operation to do, but simply because I wouldn't have expected the 
decode to be as efficient as all that).

In contrast, "popf" is actually a rather complicated instruction. It needs 
to write some of the "slow" bits, especially NT, AC and IF, which have 
fundamental effects on the instructions around them. So a popf should 
really be at _least_ as slow as a "sti" or a "cli", both of which are much 
simpler instructions, but both of which are actually complicated exactly 
because they need to make sure they serialize any interrupt delivery 
(which sounds like an easy thing to do, but isn't necessarily easy at 
all).

On a P4, for example, with the trace cache, I would expect that popfl 
would at a minimum force a trace to end, exactly because it can have 
unexpected consequences for subsequent memory ops (ie they now need to 
potentially check for alignment issues etc).

That said, it is quite possible that "popf" has microcode that notices 
when none of the expensive flags change, and that it's thus sometimes much 
faster (also, popfl is possibly faster in kernel mode than it is in user 
mode, because things like AC don't matter in the kernel).

Anyway, I'm not at all surprised by Zach's numbers. popfl is really a lot 
nastier than pushfl from a CPU standpoint. Neither are necessarily 
"trivial", but writing bits with side effects is still a lot more work 
than reading them.

I suspect that any lmbench differences that Chuck sees are either:

 - incidental (ie instruction length changes resulted in slightly 
   different alignment and cacheline usage)

 - due to noise that can be "consistent" over a boot, ie things like 
   memory allocation can cause things like L2 allocation that ends up 
   having cache way-capacity issues, and depending on how things _happen_ 
   to be allocated, you can get consistently different results even for 
   otherwise identical kernels.

 - some interesting side effect, like the fact that the saved flags value 
   was saved with interrupts enabled, and maybe a "popfl" with interrupts 
   enabled in the value is faster than one with them disabled. However, in 
   this case, I think that would be a bug - we're not supposed to enable
   interrupts yet (we're holding the runqueue lock, I think).

   There may be other side effects, and it would be interesting to see if 
   this can be explained. But "pushfl is slow" is not an explanation - 
   that could at most explain a couple of CPU cycles.

Hmm?

		Linus
