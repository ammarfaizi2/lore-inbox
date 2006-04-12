Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWDLB64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWDLB64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 21:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWDLB64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 21:58:56 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:3744 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751304AbWDLB6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 21:58:55 -0400
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200604111815.25494.Serge.Noiraud@bull.net>
References: <200604061416.00741.Serge.Noiraud@bull.net>
	 <200604061705.36303.Serge.Noiraud@bull.net>
	 <200604101446.13610.Serge.Noiraud@bull.net>
	 <200604111815.25494.Serge.Noiraud@bull.net>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 21:58:46 -0400
Message-Id: <1144807126.26133.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 18:15 +0200, Serge Noiraud wrote:
> Hi,
> 
> 	It now works with all config parameters set to yes on 2.6.16-rt16.
> however, PERCPU_ENOUGH_ROOM is set to 384KB.
> I'm now trying to lower this value of PERCPU_ENOUGH_ROOM.
> With 256K and 2.6.16-rt16 : doesn't work.
> With 320K : OK
> So I need to use 320K for PERCPU_ENOUGH_ROOM to boot correctly.
> 
> I have several questions :
> Is there a problem in my config file ?

Not that I know of. (perhaps debugging options are on. Ingo?)
Or you have too many things as modules (that's our problem, not yours).

> Will this memory freed at end of kernel loading ?

No

> Why do we need such a size ?

It seems that the -rt kernel has increased the size of structures that
are used in modules and are defined per cpu.

> What usage is this for ?

There are variables that are defined per CPU.  The reason for variables
to be defined special for each CPU is that you want the variables in
their own cache line such that modifying a variable that is specific for
a CPU wont cause a write to a cache line that has a variable (say read
only) to all CPUS. Because this would cause strain on the bus and slow
things down as the write to the cache line is causing the other CPUs to
update that line and become coherent.

But to make this easier for developers and to actually save space (don't
want to waste the cache alignment just to space out variables), there is
a lot of linker magic to do all the work for you.  So all a developer
needs to do to declare a variable with DEFINE_PER_CPU(type, name) and
friends and the linker takes care of the rest.

Currently this is implemented by creating a section at compile time to
hold all these variables.  At compile time, only one set is made.  When
the machine boots up, this section is copied (cache aligned) NR_CPUS
times.  And to access these variables, a macro per_cpu(var, cpu) is used
to find the variable in this index.  Note: since the size of
PERCPU_ENOUGH_ROOM is used if it is bigger than the current compile time
section, PERCPU_ENOUGH_ROOM must be a multiple of the cache size or
there can be an overlap in the CPU cache lines. (hmm, this looks like a
patch is needed.)

Now the problem you have is with modules.  Since the variables in the
per_cpu() macro are looked up via an index and cpu, all these variables
must be located in the same section.  Currently, to make this easier,
(and this too probably should change), the per_cpu variables of a module
are put in this same section.  So when a module is loaded, it finds a
block in the per cpu area that is available and makes a copy of its per
cpu variables into each section (per cpu).  But since this is static
memory (the per cpu section cant grow) it must be allocated at boot up
hoping that there's enough room for the modules that will be loaded in
the future.  Don't worry about leaks, when a module is unloaded, it
frees up the space in the per cpu area.

What you have seen, is that the -rt patch grew something that the
modules were using per cpu.  So when it tried to allocate the space in
the per cpu area, there wasn't enough room.  So your module failed to be
loaded.

Hope this helps,

-- Steve


