Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWISRfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWISRfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWISRfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:35:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:62154 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030334AbWISRfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:35:07 -0400
Date: Tue, 19 Sep 2006 12:35:16 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919070516.GD23836@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45102641.7000101@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 10:17:53AM -0700, Martin Bligh wrote:
> >>>>It seems like all we'd need to do
> >>>>is "list all references to function, freeze kernel, update all
> >>>>references, continue"
> >>>
> >>>
> >>>"overwrite first 5 bytes of old function with `jmp new_function'".
> >>
> >>Yes, that's simple. but slower, as you have a double jump. Probably
> >>a damned sight faster than int3 though.
> >
> >
> >The advantage of using int3 over jmp to launch the instrumented
> >module is that int3 (or breakpoint in most architectures) is an
> >atomic operation to insert.
> 
> Ah, good point. Though ... how much do we care what the speed of
> insertion/removal actually is? If we can tolerate it being slow,
> then just sync everyone up in an IPI to freeze them out whilst
> doing the insert.
> 
I guess using IPI occasionally would be acceptable. But I think
using IPI for each probes will lots of overhead.

> 
> Surely this still carries the overhead of doing the breakpoint,
> which was part of what we were trying to get away from? I suppose
> we get more flexibility this way. Or does the slowness not actually
> come from the int3, but only the single-stepping?
Yes, it comes from int3 as well.
> 
> How about we combine all three ideas together ...
> 
> 1. Load modified copy of the function in question.
> 2. overwrite the first instruction of the routine with an int3 that
> does what you say (atomically)
> 3. Then overwrite the second instruction with a jump that's faster
> 4. Now atomically overwrite the int3 with a nop, and let the jump
> take over.
> 

That's a good solution.

Thanks
Prasanna

> >Adv:
> >Can be enabled/disabled dynamically by inserting/removing
> >breakpoints.  No overhead of single stepping.
> >No restriction of running the handler in interrupt context.
> >You can have pre-compiled instrumented routines.
> >This mechanism can be used for pre-defined set of routines and for
> >arbiratory probe points, you can use kprobes/jprobes/systemtap.
> >No need to be super-user for predefined breakpoints.
> >                                                                                                                                               
> >Dis:
> >Maintainence of the code, since it can code base need to be
> >duplicated and instrumented.
> 
> CONFIG_FOO_BAR .... turn it on or off to turn on the instrumentation.
> compiled out by default. Compiled in when making the tracing functions.
> 
> >The above idea is similar to runtime or dynamic patching, but here we
> >use int3(breakpoint) rather than jump instruction.
> 
> Depends what we're trying to fix. I was trying to fix two things:
> 
> 1. Flexibility - kprobes seem unable to access all local variables etc
> easily, and go anywhere inside the function. Plus keeping low overhead
> for doing things like keeping counters in a function (see previous
> example I mentioned for counting pages in shrink_list).
> 
> 2. Overhead of the int3, which was allegedly 1000 cycles or so, though
> faster after Ingo had played with it, it's still significant.
> 
> M.

-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
