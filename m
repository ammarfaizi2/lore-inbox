Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUCII7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUCII7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:59:05 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:55440 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261826AbUCII67
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:58:59 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Tue, 9 Mar 2004 14:28:42 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com> <20040308151912.GD15065@smtp.west.cox.net>
In-Reply-To: <20040308151912.GD15065@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403091428.42560.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 8:49 pm, Tom Rini wrote:
> On Mon, Mar 08, 2004 at 05:14:05PM +0530, Amit S. Kale wrote:
> > On Monday 08 Mar 2004 4:50 pm, Amit S. Kale wrote:
> > > On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> > > > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > > > On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> > > > >  > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > > >  > > Here are features that are present only in full kgdb:
> > > > >  > >  1. Thread support  (aka info threads)
> > > > >  >
> > > > >  > argh, disaster.  I discussed this with Tom a week or so ago when
> > > > >  > it looked like this it was being chopped out and I recall being
> > > > >  > told that the discussion was referring to something else.
> > > > >  >
> > > > >  > Ho-hum, sorry.  Can we please put this back in?
> > > > >
> > > > >  Err., well this is one of the particularly dirty parts of kgdb.
> > > > > That's why it's been kept away. It takes care of correct thread
> > > > > backtraces in some rare cases.
> > > >
> > > > Let me just make sure we're taking about the same thing here.  Are
> > > > you saying that with kgdb-lite, `info threads' is completely missing,
> > > > or does it just not work correctly with threads (as opposed to
> > > > heavyweight processes)?
> > >
> > > info threads shows a list of threads. Heavy/light weight processes
> > > doesn't matter. Thread frame shown is incorrect.
> > >
> > > I looked at i386 dependent code again. Following code in it is
> > > incorrect. I never noticed it because this code is rarely used in full
> > > version of kgdb:
> > >
> > > +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
> > > task_struct *p)
> > > ....
> > > +	gdb_regs[_EBP] = *(int *)p->thread.esp;
> > >
> > > We can't guss ebp this way. This line should be removed.
> > >
> > > +	gdb_regs[_DS] = __KERNEL_DS;
> > > +	gdb_regs[_ES] = __KERNEL_DS;
> > > +	gdb_regs[_PS] = 0;
> > > +	gdb_regs[_CS] = __KERNEL_CS;
> > > +	gdb_regs[_PC] = p->thread.eip;
> > > +	gdb_regs[_ESP] = p->thread.esp;
> > >
> > > This should be gdb_regs[_ESP] = &p->thread.esp
> >
> > That's not correct it. It should be gdb_regs[_ESP] = p->thread.esp;
> > Even with these changes I can't get thread listing correctly.
> >
> > Here is the intrusive piece of code that helps get thread state
> > correctly. Any ideas on cleaning it?
>
> Here's where what Andi said about being able to get the pt_regs stuff
> off the stack (I think that's what he said at least) started to confuse
> me slightly.  But if I understand it right (and I never got around to

That's an in interesting idea. We can at least get first pt_regs from the 
stack. That way we can get to user space eip in case a thread is in user 
space.

The do_schedule and save all regs is definitely required if we want _exact_ 
state of all kernel threads. [exact state: all registers]

Finding function frames below pt_regs becomes difficult or impossible, as 
exact dept of stack for each function in a stack is not known. EBP chains 
allow walking "up" but not "down".
-Amit


> testing this) we can replace the do_schedule() stuffs at least with
> something like kgdb_get_pt_regs(), since (and I lost my notes on this,
> so it's probably not quite right) (thread_info->esp0)-1

