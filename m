Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUAUQx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAUQx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:53:29 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:43222 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265977AbUAUQxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:53:23 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: PPC KGDB changes and some help?
Date: Wed, 21 Jan 2004 22:23:12 +0530
User-Agent: KMail/1.5
Cc: George Anzinger <george@mvista.com>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org>
In-Reply-To: <20040121153019.GR13454@stop.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401212223.13347.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here it is: ppc kgdb from timesys kernel is available at
http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2

This is my attempt at extracting kgdb from TimeSys kernel. It works well in 
TimeSys kernel, so blame me if above patch doesn't work.

ChangeLog:
2004-01-21 TimeSys Corporation
	* kgdb on powerpc.

2004-01-21 Pavel Machek <pavel@suse.cz>
	* Changes for coding conventions

2004-01-21 Tom Rini <trini@kernel.crashing.org>
	* Added a prototype for kgdb8250_add_port.


On Wednesday 21 Jan 2004 9:00 pm, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 07:46:17PM +0530, Amit S. Kale wrote:
> > Hi Tom,
> >
> > Yes. Software breakpoints have been tested in the TimeSys ppc kernel
> > source. They work quite well!! I'll be releasing that code soon.
>
> Any chance you can give me what they gave you?  I can try and merge
> and test things.
>
> > Here are a couple of questions from a quick look at this code. I may have
> > more when I do a merge this code with what I have.
> >
> > > -	bl	schedule
> > > +	bl	user_schedule
> >
> > I still have #ifdef CONFIG_KGDB_THREAD here. Threads listing is a
> > necessary feature, agreed. Do you have any ideas on reducing the overhead
> > of the code added by having to push all registers when doing a switch_to?
> >
> > if (kgdb enabled) do a full push of registers else go to usual switch_to
> >
> > Does this sound good?
>
> From what I recall of starting on this around kgdb 2.0.2, I couldn't
> link the kernel w/o this change (KGDB=n).
>
> > > +        */
> > > +#if 0
> > > +       extern atomic_t kgdb_setting_breakpoint;
> > > +       if (atomic_read(&kgdb_setting_breakpoint))
> > > +               regs->nip += 4;
> > > +#else
> > > +       if (linux_regs->nip == 0x7d821008 )
> > > +               /* Skip over breakpoint trap insn */
> > > +               linux_regs->nip += 4;
> > > +#endif
> >
> > Why is kgdb_setting_breakpoint a bad idea?
> > My guess - problems on an smp board.
>
> I don't know how well the current kgdb stub is tested on SMP, but it
> doesn't need any extra locking here.
>
> > Hardcoded nip is worse.
> > Any ideas for a better code?
>
> I've got a feeling that the nip is always the trap instruction, so we
> could always do what the TimeSys code (and before that, the current
> stub) does of skipping over it.  I used the hard-coded value there since
> I hadn't gotten around to re-arranging the code so I could do *(uint
> *)kgdb_ops->gdb_bpt_instr or so.
>
> > In following code, gdb packets and their responses appear correct. kgdb
> > is supposed handle software breakpoints.
> >
> > The breakpoint 0xc0000000 placed by gdb is _evil_ It may clobber data.
> > The gdb at kgdb.sourceforge.net places it correctly at module_event.
>
> I'm not quite sure what you're getting at.   The gdb binary I'm using is
> a good one (It's happy w/ the current kgdb stub, working in tandem w/ a
> BDI2000, etc).  If the breakpoints being set aren't right, I suspect
> that it's related to the other problems I'm seeing.
>
> > Where is the other breakpoint placed? While you would have certainly done
> > that, please confirm that kgdb actually inserts a breakpoint where you
> > have asked it to: a simple printk at the address where the breakpoint is
> > placed should be sufficient. printing from gdb will not work as gdb
> > removes all breakpoints before giving control to a user.
>
> The thing is the kernel gets into an infinite loop of stopping, as far
> as gdb can tell, at the initial breakpoint.

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

