Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUAUNrH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUAUNrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:47:07 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:39361 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265952AbUAUNrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:47:01 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Date: Wed, 21 Jan 2004 19:16:48 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
References: <200401161759.59098.amitkale@emsyssoft.com> <200401171459.01794.amitkale@emsyssoft.com> <40099301.6000202@mvista.com>
In-Reply-To: <40099301.6000202@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401211916.49520.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 Jan 2004 1:24 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Saturday 17 Jan 2004 6:53 am, George Anzinger wrote:
> >>Pavel Machek wrote:
> >>>Hi!
> >>>
> >>>>KGDB 2.0.3 is available at
> >>>>http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> >>>>
> >>>>Ethernet interface still doesn't work. It responds to gdb for a couple
> >>>> of packets and then panics. gdb log for ethernet interface is pasted
> >>>> below.
> >>>>
> >>>>It panics and enter kgdb_handle_exception recursively and silently. To
> >>>>see the panic on screen make kgdb_handle_exception return immediately
> >>>> if kgdb_connected is non-zero.
> >>>>
> >>>>Panic trace is pasted below. It panics in skb_release_data. Looks like
> >>>>skb handling will have to changed to be have kgdb specific buffers.
> >>>
> >>>This seems to be needed (if I unselect CONFIG_KGDB_THREAD, I get
> >>>compile error on x86-64).
> >>
> >>Amit, could you explain why this is an option?  It seems very useful and
> >>not really too much code...
> >
> > It saves all registers before switch_to. It does that two times at
> > present. Once (implicit) register save by gcc and an explicit register
> > save in arch/<proc>/kernel/entry.S Second register save in kern_schedule
> > generates a pt_regs structure which gdb can get all registers at once
> > from. If it's omited, gdb has to figure out where gcc has saved registers
> > from the non-standards code in switch_to, which it can't do correctly all
> > the time.
> >
> > We can have a check for (a new variable) debugger_enabled before calling
> > kern_schedule. That'll be add negligible overhead and will allow extra
> > thread info to be saved only when a debugger is enabled. There will not
> > be any need for CONFIG_KGDB_THREAD also.
>
> I don't seem to have such a problem with the mm kgdb.  No kern_schedule
> there...


Have you confirmed that you see correct values for all the registers? I had 
found some problems with gdb not being able to locate all the registers 
correctly. Explanation on the problem below:

Besides getting gdb's fault there  is one more benefit of kern_schedule. All 
threads are shown by gdb as sleeping _at_ the place where schedule call is 
present: So instead of gdb showing all threads sleeping in __switch_to, it 
shows several functions. That's better than having to look at back trace of 
each thread to figure out what it is.

This functionality is complemented by printing of thread names in 2.0.X kgdb 
info threads listing. 

Now back to gdb problem of not being able to locate registers.
schedule results in code of this form:

schedule:
framesetup
registers save
...
...
save registers
change esp
call switchto
restore registers
...
...

GDB can't analyze code other than frame setup and registers save. It may not 
show values of variables that are present in registers correctly. This used 
to be a problem some time ago (gdb 5.X). Perhaps gdb 6.x does a better job.
hmm...
May be its time I should look at gdb's x86 register info code again.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

