Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbTEGPt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTEGPt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:49:28 -0400
Received: from holomorphy.com ([66.224.33.161]:21392 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264071AbTEGPt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:49:26 -0400
Date: Wed, 7 May 2003 09:01:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Torsten Landschoff <torsten@debian.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507160144.GS8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Torsten Landschoff <torsten@debian.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507150429.GA7248@stargate.galaxy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507150429.GA7248@stargate.galaxy>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:47:36AM -0700, William Lee Irwin III wrote:
>> The kernel stack is (in Linux) unswappable memory that persists
>> throughout the lifetime of a thread. It's basically how many threads
>> you want to be able to cram into a system, and it matters a lot for
>> 32-bit.

On Wed, May 07, 2003 at 05:04:29PM +0200, Torsten Landschoff wrote:
> Okay, that makes sense. BTW: Why not go a step further and have just 
> one kernel stack (probably better one per CPU)?

Generally things are stopped in the middle of function calls when
scheduled out and the register state etc. saved nowhere but as register
spills to the stack in the task model of programming (commonly used in
UNIX implementations and for most kernels really). Each userspace thread
has a "mirror image" thread inside the kernel, and basically scheduling
happens as some thread inside the kernel deciding it's time to check
whether one should schedule, and when it does, dumping what registers
it hasn't already to the kernel stack to save state, and then switching
stacks. So the stack is implicitly used to save per-thread state and
can't really be shared on a per-cpu basis in a UNIX-like design. UNIX
IIRC dealt with the resource scalability problem that a decision to pin
the memory would cause by shoving kernel stacks in the u area, which
could be swapped when under sufficient duress, and there was a whole
layer of scheduling that decided when to dump whole processes to swap
when there were too many competing for memory, and when to swap them in.

Pure per-cpu stacks would require the interrupt model of programming to
be used, which is a design decision deep enough it's debatable whether
it's feasible to do conversions to or from at all, never mind desirable.
Basically every entry point into the kernel is treated as an interrupt,
and nothing can ever sleep or be scheduled in the kernel, but rather
only register callbacks to be run when the event waited for occurs.
Scheduling only happens as a decision of which userspace task to resume
when returning from the kernel to userspace, though one could envision
a priority queue discipline for processing the registered callbacks.

Many of the mechanics used for async io qualify as "partial conversions"
but in truth most of the truly difficult aspects are avoided by limiting
the usage of the style to io requests and not using its style for
memory allocations or other things. It's basically Not UNIX (TM). AFAIK
only a couple of research kernels from the late 80's, QuickSilver and V
(cited by Vahalia) ever used it, though Vahalia isn't likely to give an
exhaustive list of the things so there may be others. But it probably
makes for impressive resource scalability numbers wrt. threads, at the
cost of some runtime overhead for more complex state maintenance.


-- wli
