Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUCHLUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 06:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUCHLUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 06:20:34 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:47340 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262453AbUCHLUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 06:20:31 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 16:50:18 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081619.16771.amitkale@emsyssoft.com> <20040308030722.01948c93.akpm@osdl.org>
In-Reply-To: <20040308030722.01948c93.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081650.18641.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 4:37 pm, Andrew Morton wrote:
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > On Monday 08 Mar 2004 3:56 pm, Andrew Morton wrote:
> >  > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> >  > > Here are features that are present only in full kgdb:
> >  > >  1. Thread support  (aka info threads)
> >  >
> >  > argh, disaster.  I discussed this with Tom a week or so ago when it
> >  > looked like this it was being chopped out and I recall being told that
> >  > the discussion was referring to something else.
> >  >
> >  > Ho-hum, sorry.  Can we please put this back in?
> >
> >  Err., well this is one of the particularly dirty parts of kgdb. That's
> > why it's been kept away. It takes care of correct thread backtraces in
> > some rare cases.
>
> Let me just make sure we're taking about the same thing here.  Are you
> saying that with kgdb-lite, `info threads' is completely missing, or does
> it just not work correctly with threads (as opposed to heavyweight
> processes)?

info threads shows a list of threads. Heavy/light weight processes doesn't 
matter. Thread frame shown is incorrect.

I looked at i386 dependent code again. Following code in it is incorrect. I 
never noticed it because this code is rarely used in full version of kgdb:

+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct 
*p)
....
+	gdb_regs[_EBP] = *(int *)p->thread.esp;

We can't guss ebp this way. This line should be removed.

+	gdb_regs[_DS] = __KERNEL_DS;
+	gdb_regs[_ES] = __KERNEL_DS;
+	gdb_regs[_PS] = 0;
+	gdb_regs[_CS] = __KERNEL_CS;
+	gdb_regs[_PC] = p->thread.eip;
+	gdb_regs[_ESP] = p->thread.esp;

This should be gdb_regs[_ESP] = &p->thread.esp 

>
> >  If you consider it an absolutely must, we can do something so that the
> > dirty part is kept away and info threads almost always works.
>
> Yes, I'd consider `info threads' support a must-have.  I'm rather surprised
> that others do not?

Present threads support code changes calling convention of do_IRQ. Most 
believe that to be an absolute no.

Since you consider it a must-have, I'll check whether above changes suggested 
by me make info threads listing correct in most cases.

-Amit

