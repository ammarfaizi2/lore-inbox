Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWDLH3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWDLH3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 03:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWDLH3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 03:29:54 -0400
Received: from odin2.bull.net ([129.184.85.11]:41160 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932088AbWDLH3x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 03:29:53 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Date: Wed, 12 Apr 2006 09:30:11 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200604061416.00741.Serge.Noiraud@bull.net> <200604111815.25494.Serge.Noiraud@bull.net> <1144807126.26133.21.camel@localhost.localdomain>
In-Reply-To: <1144807126.26133.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604120930.11764.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	many thanks for all these explanations.

mercredi 12 Avril 2006 03:58, Steven Rostedt wrote/a écrit :
> On Tue, 2006-04-11 at 18:15 +0200, Serge Noiraud wrote:
> > Hi,
...
> > 
> > I have several questions :
> > Is there a problem in my config file ?
> 
> Not that I know of. (perhaps debugging options are on. Ingo?)
> Or you have too many things as modules (that's our problem, not yours).
> 
> > Will this memory freed at end of kernel loading ?
> 
> No
> 
> > Why do we need such a size ?
> 
> It seems that the -rt kernel has increased the size of structures that
> are used in modules and are defined per cpu.
> 
> > What usage is this for ?
> 
> There are variables that are defined per CPU.  The reason for variables
> to be defined special for each CPU is that you want the variables in
> their own cache line such that modifying a variable that is specific for
> a CPU wont cause a write to a cache line that has a variable (say read
> only) to all CPUS. Because this would cause strain on the bus and slow
> things down as the write to the cache line is causing the other CPUs to
> update that line and become coherent.
> 
> But to make this easier for developers and to actually save space (don't
> want to waste the cache alignment just to space out variables), there is
> a lot of linker magic to do all the work for you.  So all a developer
> needs to do to declare a variable with DEFINE_PER_CPU(type, name) and
> friends and the linker takes care of the rest.
> 
> Currently this is implemented by creating a section at compile time to
> hold all these variables.  At compile time, only one set is made.  When
> the machine boots up, this section is copied (cache aligned) NR_CPUS
> times.  And to access these variables, a macro per_cpu(var, cpu) is used
> to find the variable in this index.  Note: since the size of
> PERCPU_ENOUGH_ROOM is used if it is bigger than the current compile time
> section, PERCPU_ENOUGH_ROOM must be a multiple of the cache size or
> there can be an overlap in the CPU cache lines. (hmm, this looks like a
> patch is needed.)
> 
> Now the problem you have is with modules.  Since the variables in the
> per_cpu() macro are looked up via an index and cpu, all these variables
> must be located in the same section.  Currently, to make this easier,
> (and this too probably should change), the per_cpu variables of a module
> are put in this same section.  So when a module is loaded, it finds a
> block in the per cpu area that is available and makes a copy of its per
> cpu variables into each section (per cpu).  But since this is static
> memory (the per cpu section cant grow) it must be allocated at boot up
> hoping that there's enough room for the modules that will be loaded in
> the future.  Don't worry about leaks, when a module is unloaded, it
> frees up the space in the per cpu area.
> 
> What you have seen, is that the -rt patch grew something that the
> modules were using per cpu.  So when it tried to allocate the space in
> the per cpu area, there wasn't enough room.  So your module failed to be
> loaded.
> 
> Hope this helps,
> 
> -- Steve


-- 
Serge Noiraud
