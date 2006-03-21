Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWCUMXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWCUMXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWCUMXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:23:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47306 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751563AbWCUMXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:23:03 -0500
Date: Tue, 21 Mar 2006 17:53:01 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [3/3 PATCH] Kprobes: User space probes support- single stepping out-of-line
Message-ID: <20060321122301.GA32694@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060320060745.GC31091@in.ibm.com> <20060320060931.GD31091@in.ibm.com> <20060320061014.GE31091@in.ibm.com> <20060320061123.GF31091@in.ibm.com> <20060320030922.4ea9445b.akpm@osdl.org> <20060320134854.GG8662@in.ibm.com> <20060320124049.62861819.akpm@osdl.org> <20060321020257.GB3320@in.ibm.com> <20060321020521.36e98f6d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321020521.36e98f6d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 02:05:21AM -0800, Andrew Morton wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> wrote:
> >
> > > 
> >  > > > > +	addr = (kprobe_opcode_t *)kmap_atomic(page, KM_USER1);
> >  > > > > +	addr = (kprobe_opcode_t *)((unsigned long)addr +
> >  > > > > +				 (unsigned long)(uprobe->offset & ~PAGE_MASK));
> >  > > > > +	*addr = opcode;
> >  > > > > +	/*TODO: flush vma ? */
> >  > > > 
> >  > > > flush_dcache_page() would be needed.
> >  > > > 
> >  > > > But then, what happens if the page is shared by other processes?  Do they
> >  > > > all start taking debug traps?
> >  > > 
> >  > > Yes, you are right. I think single stepping inline was a bad idea, disarming
> >  > > the probe looks to be a better option
> >  > > 
> >  > 
> >  > You skipped my second question?
> > 
> >  There is a small window in which other processor will not be able to see
> >  the breakpoint if we are single step inline. But since single stepping inline
> >  is a bad idea, we will disarm the probe forever (replace with original instrcution) if we cannot single step out-of-line.
> >  Any suggestions?
> 
> This doesn't appear to be working.
> 
> Let's go back in time and pretend that these patches were never written,
> OK?  We're standing around the water cooler saying "hey, wouldn't it be
> cool if someone did X".  You guys are way too far into this and you keep on
> leaving everyone else behind.  When I try to drag you up, you resist ;)
> 
> So let me rephrase, and thrash around in the dark a little more.
> 
> >From my reading of the code (and thus far that's my _only_ source of this
> information) it appears that a design decision has been made (for reasons
> which have yet to be disclosed) that the way to implement this (yet to be
> described) requirement is to set user breakpoints upon particular
> instructions within executables.  System-wide, for all processes and
> threads.
> 
> There are other things that could have been done.  For example, you might
> have chosen to set breakpoints upon a particular virtual address within a
> heavyweight process.  That's a process-oriented viewpoint, rather than a
> file-oriented one, if you like.
> 
> This raises interesting questions, like
> 
> - How come that decision was made?  Why _is_ this an executable-oriented
>   rather than process-oriented thing?  Richard has covered that somewhat.
> 
> - What happens if the executable is writeably mapped?
> 
> - What happens if someone writes to the executable?  (I think both
>   of these were disallowed in the implementation-which-is-not-to-be-named).
> 
> - What happens if different processes map the executable at different
>   addresses?
> 
> - Various other things which you've thought of and I haven't and which it
>   would be REALLY interesting to hear about.
> 
> But this is just one example.  I don't think I'm being too picky here - my
> reaction on seeing all this stuff was, basically, "wtf is all this code
> for?".  References to dprobes won't help, sorry - I've never looked at
> dprobes and I don't know anyone apart from you guys who has.
> 
> What I'm asking you for is a description of what problem we're trying to
> solve and how this code solves that problem.  It is hard, it is inefficient
> and, worse, it is error-prone for us to try to work all that out from a
> particular implementation.

Andrew,

The basic need is to provide infrastructure for user-space dynamic
instrumentation. As with kprobes, there is no need to recompile or
restart applications for instrumentation, under a debugger for instance.

Possible approaches which were looked up

1. Attaching or loading the application into a tool.

In this method the user application must be loaded into a
tool or the tool is attached to already running application. Before
the user can instrument an application the user should decide what that
instrumentation will consist of. Dynaprof uses such a mechanism.

http://www.dyninst.org/tools.html

2. Using a "jump" instruction to a trampoline and trampoline executing
   the instrumented code in user-space.

Eg: Paradyn tool. (http://www.paradyn.org/)

Issues with method 1 and 2 are:

* Induces Intel erratum E49 where the other processors see
  stale data while one processor replaces the jump instruction.
* Instruction can only be replaced atomically if the size of
  the jump instruction is greater than or equal to the original
  instruction.
* Other processors need to be stopped if the "jump" instruction size
  is less than the original instruction.

3. Using breakpoint instruction Using a breakpoint instruction and
   executing the instrumentation code from within the breakpoint handler
   in the interrupt context.

The advantages of the approach (3) taken, apart from what Suparna listed
earlier in this thread
- User is able to collect user-space data and kernel space data using the
  same instrumenation code and getting a complete picture
- Probes are visible across fork() syscall.

Richard's mail earlier in this thread details the per process Vs per
executable file based probe.

This is just an RFC and we are looking for suggestions (like Christoph's).

Thanks
Prasanna

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
