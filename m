Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWH3Vli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWH3Vli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWH3Vli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:41:38 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:28197 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S932118AbWH3Vlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:41:37 -0400
Subject: Re: [RFC] [Crash-utility] Patch to use gdb's bt in crash - works
	great with kgdb! - KGDB in Linus Kernel.
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: vgoyal@in.ibm.com, George Anzinger <george@wildturkeyranch.net>,
       Andrew Morton <akpm@osdl.org>
Cc: Piet Delaney <piet@bluelane.com>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060830204032.GD30392@in.ibm.com>
References: <44EC8CA5.789286A@redhat.com>
	 <20060824111259.GB22145@in.ibm.com> <44EDA676.37F12263@redhat.com>
	 <1156966522.29300.67.camel@piet2.bluelane.com>
	 <20060830204032.GD30392@in.ibm.com>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Wed, 30 Aug 2006 14:41:32 -0700
Message-Id: <1156974093.29300.103.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Aug 2006 21:41:36.0676 (UTC) FILETIME=[11B60E40:01C6CC7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 16:40 -0400, Vivek Goyal wrote:
> On Wed, Aug 30, 2006 at 12:35:21PM -0700, Piet Delaney wrote:
> > > 
> > > Simple question -- and to be quite honest with you -- I don't
> > > understand why you wouldn't want to simply use gdb alone
> > > in this case?
> > 
> > I don't see any reason for core file not to be read correctly by
> > gdb. It's convenient to use gdb directly sometimes, for example
> > while using the ddd GUI.
> > 
> 
> You can run gdb to open core files as of today but the debugging
> capability will be limited. For ex. kernel core headers have the info
> of linearly mapped region only and they don't contain the virt address
> info of non-linearly mapped regions. So one can not debug the non-linearly
> mapped regions like modules.

Amit's modified gdb might help for that problem. I haven't used
it but it allows gdb to load debug information about modules. You
can also use a script Amit wrote to explicitly load module info
into stock gdb; that also might work with kernel core files.

> 
> > kgdb isn't having any problems with kernel threads back traces.
> > The kernel objects are tweaked with dwarf code, but I see no
> > problem with using the same paradigm with crash. Works great.
> > 
> 
> Can you give some more details on what do you mean by kernel objects
> are tweaked with dwarf code. 

Attached is the cfi_annotations.patch patch from the kgdb-2.6.16 patch
which is part of the kgdb patch series. I believe George Anzinger used 
a similar dwarf patch in the 2.6 mm series patches that Andrew provided.
I think Tom Rini wrote both of them. 


> 
> > I'd prefer to have crash and ddd+gdb operate on kernel core files.
> > 
> 
> You can already do that. Its just a matter of figuring out how to
> get good backtraces both with "crash" as well as "gdb".

I think Tom Rini's cfi_annotations could be a big part of that solution.

> 
> > Even better it would be nice to be able to simulate execution on
> > a stack of a core file to be able to re-execute code that caused
> > the crash. I frequently found it convenient after a panic to move
> > the pc to the end of panic, and continue back up the stack to a 
> > break point at the system call. Then I'd use the GUI to move the
> > pc to before the execution of the system call and execute it again
> > and watch how the return value was derived that caused the panic.
> > 
> > I expect that if you run a kgdb kernel, including the drarf code,
> > that gdb will have no problem with core dumps. It's convenient to
> > have kgdb configured in the kernel and have the option to continue
> > analysis later with gdb/crash.
> >
> 
> Is kgdb mainline? I think some time back Andrew had dropped the patches
> from -mm too.

Yes, I think he had a number of issues with the kgdb patch but I can't
recall reading exactly what they are. One I believe is that the kgdb
patch should be completly non-invasive if not configured in. Currently
some files that are patched don't have #ifdef CONFIG_KGDB in them. I
noticed one last night while checking in some code. 

I'd like to put those #ifdef's back in and make it part of the std
distribution. As I recall George Anzinger's patch had absolutely no
impact on the kernel if not configured in. Seems very important to me.


>  I don't know if distros carry kgdb or not?  So not sure
> for how many people will it be helpful to enable kgdb and then take
> core dumps for better back traces.

More for larger servers like a Sun NUMA system. I'd find it convenient
to be able to go back a look at a crash of something that I looked at
previously. Might be good for bug reports to have references to core
files backing up a bug fix.

> 
> I don't know much about tweaking objects with dwarf code but got a 
> general question. Why can't it be an independent patch in kernel 
> independent of kgdb. (If it helps in getting better backtraces.)

Exactly. Locally I just checked in code that I expect will be useful for
kgdb or kdump. Stuff like compiling the kernel -O0 and converting
static inline functions to inline. Code to provide dwarf info and
save registers during a panic seem to also qualify.

My preference is for kgdb, like kexec, to become part of the 
mainstream kernel as a configurable component. Perhaps Andrew 
could enumerate his issues. It would make cooperation between
kgdb and crash a bit easier and make kernel debugging a lot 
easier for the masses. Recent kgdb patches seem to be getting
much better.

-piet

> 
> Thanks
> Vivek
>  
-- 
Piet Delaney
BlueLane Teck
W: (408) 200-5256; piet@bluelane.com
H: (408) 243-8872; piet@piet.net


