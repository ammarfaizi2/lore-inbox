Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266620AbUAWTLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUAWTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:11:07 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:57746 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266620AbUAWTKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:10:51 -0500
Date: Fri, 23 Jan 2004 12:10:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040123191040.GB15271@stop.crashing.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <200401211916.49520.amitkale@emsyssoft.com> <400F0490.6000209@mvista.com> <200401221039.14979.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401221039.14979.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 10:39:14AM +0530, Amit S. Kale wrote:
> On Thursday 22 Jan 2004 4:30 am, George Anzinger wrote:
> > Amit S. Kale wrote:
> > > On Sunday 18 Jan 2004 1:24 am, George Anzinger wrote:
> > >>Amit S. Kale wrote:
> > >>>On Saturday 17 Jan 2004 6:53 am, George Anzinger wrote:
> > >>>>>This seems to be needed (if I unselect CONFIG_KGDB_THREAD, I get
> > >>>>>compile error on x86-64).
> > >>>>
> > >>>>Amit, could you explain why this is an option?  It seems very useful
> > >>>> and not really too much code...
> > >>>
> > >>>It saves all registers before switch_to. It does that two times at
> > >>>present. Once (implicit) register save by gcc and an explicit register
> > >>>save in arch/<proc>/kernel/entry.S Second register save in kern_schedule
> > >>>generates a pt_regs structure which gdb can get all registers at once
> > >>>from. If it's omited, gdb has to figure out where gcc has saved
> > >>> registers from the non-standards code in switch_to, which it can't do
> > >>> correctly all the time.
> > >>>
> > >>>We can have a check for (a new variable) debugger_enabled before calling
> > >>>kern_schedule. That'll be add negligible overhead and will allow extra
> > >>>thread info to be saved only when a debugger is enabled. There will not
> > >>>be any need for CONFIG_KGDB_THREAD also.
> > >>
> > >>I don't seem to have such a problem with the mm kgdb.  No kern_schedule
> > >>there...
> > >
> > > Have you confirmed that you see correct values for all the registers? I
> > > had found some problems with gdb not being able to locate all the
> > > registers correctly. Explanation on the problem below:
> > >
> > > Besides getting gdb's fault there  is one more benefit of kern_schedule.
> > > All threads are shown by gdb as sleeping _at_ the place where schedule
> > > call is present: So instead of gdb showing all threads sleeping in
> > > __switch_to, it shows several functions. That's better than having to
> > > look at back trace of each thread to figure out what it is.
> >
> > The mm version of kgdb does this, but by lying to gdb during the info
> > thread command.  IMNSHO, the real way to do this is to process the info
> > thread output with an awk script, but I haven't done that just yet.  The
> > problem with lying to gdb is that it sometimes remembers...
> >
> > > This functionality is complemented by printing of thread names in 2.0.X
> > > kgdb info threads listing.
> >
> > as in the mm version.
> >
> > > Now back to gdb problem of not being able to locate registers.
> > > schedule results in code of this form:
> > >
> > > schedule:
> > > framesetup
> > > registers save
> > > ...
> > > ...
> > > save registers
> > > change esp
> > > call switchto
> > > restore registers
> > > ...
> >
> > I have not analyzed this as yet.  However, it does seem to me to be the
> > same problem as trying to bt through an interrupt frame.  The correct way
> > to do this is to build the dwarf frame descriptors.  I have done this for
> > the interrupt frame and intend to send said patch out in a day or so.
> 
> Great! I had to do it this ackward way:
[snip]
> Powerpc ->
>  	int irq, first = 1;
> +	unsigned long *lrptr;
> +	if (!(regs->msr & MSR_PR)) {
> +		/* Came in from the kernel. Save call link. */
> +		lrptr = (unsigned long *)(regs->gpr[1] + 4);
> +		*lrptr = regs->nip;
> +	}

Amit, this is broken and causes a lockup on my machine.  I haven't tried
to find the 'correct' way to do this, but in the next verion of the kgdb
patches can you please if 0 this section?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
