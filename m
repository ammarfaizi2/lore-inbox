Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUCHPT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUCHPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:19:27 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:53956 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262508AbUCHPTO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:19:14 -0500
Date: Mon, 8 Mar 2004 08:19:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040308151912.GD15065@smtp.west.cox.net>
References: <200403081504.30840.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org> <200403081650.18641.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403081714.05521.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 05:14:05PM +0530, Amit S. Kale wrote:
> On Monday 08 Mar 2004 4:50 pm, Amit S. Kale wrote:
> > On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> > > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > > On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> > > >  > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > >  > > Here are features that are present only in full kgdb:
> > > >  > >  1. Thread support  (aka info threads)
> > > >  >
> > > >  > argh, disaster.  I discussed this with Tom a week or so ago when it
> > > >  > looked like this it was being chopped out and I recall being told
> > > >  > that the discussion was referring to something else.
> > > >  >
> > > >  > Ho-hum, sorry.  Can we please put this back in?
> > > >
> > > >  Err., well this is one of the particularly dirty parts of kgdb. That's
> > > > why it's been kept away. It takes care of correct thread backtraces in
> > > > some rare cases.
> > >
> > > Let me just make sure we're taking about the same thing here.  Are you
> > > saying that with kgdb-lite, `info threads' is completely missing, or does
> > > it just not work correctly with threads (as opposed to heavyweight
> > > processes)?
> >
> > info threads shows a list of threads. Heavy/light weight processes doesn't
> > matter. Thread frame shown is incorrect.
> >
> > I looked at i386 dependent code again. Following code in it is incorrect. I
> > never noticed it because this code is rarely used in full version of kgdb:
> >
> > +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct
> > task_struct *p)
> > ....
> > +	gdb_regs[_EBP] = *(int *)p->thread.esp;
> >
> > We can't guss ebp this way. This line should be removed.
> >
> > +	gdb_regs[_DS] = __KERNEL_DS;
> > +	gdb_regs[_ES] = __KERNEL_DS;
> > +	gdb_regs[_PS] = 0;
> > +	gdb_regs[_CS] = __KERNEL_CS;
> > +	gdb_regs[_PC] = p->thread.eip;
> > +	gdb_regs[_ESP] = p->thread.esp;
> >
> > This should be gdb_regs[_ESP] = &p->thread.esp
> 
> That's not correct it. It should be gdb_regs[_ESP] = p->thread.esp;
> Even with these changes I can't get thread listing correctly.
> 
> Here is the intrusive piece of code that helps get thread state correctly. Any 
> ideas on cleaning it?

Here's where what Andi said about being able to get the pt_regs stuff
off the stack (I think that's what he said at least) started to confuse
me slightly.  But if I understand it right (and I never got around to
testing this) we can replace the do_schedule() stuffs at least with
something like kgdb_get_pt_regs(), since (and I lost my notes on this,
so it's probably not quite right) (thread_info->esp0)-1

-- 
Tom Rini
http://gate.crashing.org/~trini/
