Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUEKSCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUEKSCd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUEKSCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:02:33 -0400
Received: from mail.tmr.com ([216.238.38.203]:51205 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262951AbUEKSC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:02:29 -0400
Date: Tue, 11 May 2004 13:59:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>, Andrew Morton <akpm@osdl.org>,
       Helge Hafting <helgehaf@aitel.hist.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: several messages
In-Reply-To: <40A0929A.7040609@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1040511134825.16430I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank all of you for this information. This is an interesting way to
overcome the kernel memory fragmentation issue. I would have thought it
was more important to address having the memory so fragmented that there
is no 8k chunk left "even with many megabytes free" as someone wrote.


On Mon, 10 May 2004, Horst von Brand wrote:

> Bill Davidsen <davidsen@tmr.com> said:
> 
> [...]
> 
> > I tried 4k stack, I couldn't measure any improvement in anything (as in 
> > no visible speedup or saving in memory).
> 
> 4K stacks lets the kernel create new threads/processes as long as there is
> free memory; with 8K stacks it needs two consecutive free page frames in
> physical memory, when memory is fragmented (and large) they are hard to
> come by...
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> 

On Mon, 10 May 2004, Andrew Morton wrote:

> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> >
> > Bill Davidsen <davidsen@tmr.com> said:
> > 
> > [...]
> > 
> > > I tried 4k stack, I couldn't measure any improvement in anything (as in 
> > > no visible speedup or saving in memory).
> > 
> > 4K stacks lets the kernel create new threads/processes as long as there is
> > free memory; with 8K stacks it needs two consecutive free page frames in
> > physical memory, when memory is fragmented (and large) they are hard to
> > come by...
> 
> This is true to a surprising extent.  A couple of weeks ago I observed my
> 256MB box freeing over 20MB of pages before it could successfully acquire a
> single 1-order page.
> 
> That was during an updatedb run.
> 
> And a 1-order GFP_NOFS allocation was actually livelocking, because
> !__GFP_FS allocations aren't allowed to enter dentry reclaim.  Which is why
> VFS caches are now forced to use 0-order allocations.
> 
> 

On Tue, 11 May 2004, Helge Hafting wrote:

> Bill Davidsen wrote:
> 
> > Arjan van de Ven wrote:
> >
> >>> It's probably a Bad Idea to push this to Linus before the vendors 
> >>> that have
> >>> significant market-impact issues (again - anybody other than NVidia 
> >>> here?)
> >>> have gotten their stuff cleaned up...
> >>
> >>
> >>
> >> Ok I don't want to start a flamewar but... Do we want to hold linux back
> >> until all binary only module vendors have caught up ??
> >
> >
> > My questions is, hold it back from what? Having the 4k option is fine, 
> > it's just eliminating the current default which I think is 
> > undesirable. I tried 4k stack, I couldn't measure any improvement in 
> > anything (as in no visible speedup or saving in memory). 
> 
> The memory saving is usually modest: 4k per thread. It might make a 
> difference for
> those with many thousands of threads.   I believe this is unswappable 
> memory,
> which is much more valuable than ordinary process memory.
> 
> More interesting is that it removes one way for fork() to fail. With 8k 
> stacks,
> the new process needs to allocate two consecutive pages for those 8k.  That
> might be impossible due to fragmentation, even if there are megabytes of 
> free
> memory. Such a problem usually only shows up after a long time.  Now we 
> only need to
> allocate a single page, which always works as long as there is any free 
> memory at all.
> 
> > For an embedded system, where space is tight and the code paths well 
> > known, sure, but I haven't been able to find or generate any objective 
> > improvement, other than some posts saying smaller is always better. 
> > Nothing slows a system down like a crash, even if it isn't followed by 
> > a restore from backup.
> 
> Consider the case when your server (web/mail/other) fails to fork, and then
> you can't login because that requires fork() too.  4k stacks remove this 
> scenario,
> and is a stability improvement.
> 
> Helge Hafting
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

