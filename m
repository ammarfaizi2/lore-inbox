Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266207AbUG0D35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUG0D35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUG0D35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:29:57 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:2466 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266207AbUG0D3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:29:49 -0400
From: Daniel Phillips <phillips@istop.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 26 Jul 2004 23:31:43 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, lmb@suse.de, arjanv@redhat.com,
       sdake@mvista.com, teigland@redhat.com, linux-kernel@vger.kernel.org
References: <1089501890.19787.33.camel@persist.az.mvista.com> <200407122219.17582.phillips@istop.com> <40F34978.60709@yahoo.com.au>
In-Reply-To: <40F34978.60709@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407262331.44176.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 July 2004 22:31, Nick Piggin wrote:
> Daniel Phillips wrote:
> > On Monday 12 July 2004 16:54, Andrew Morton wrote:
> >>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >>>I don't see why it would be a problem to implement a "this task
> >>>facilitates page reclaim" flag for userspace tasks that would take
> >>>care of this as well as the kernel does.
> >>
> >>Yes, that has been done before, and it works - userspace "block drivers"
> >>which permanently mark themselves as PF_MEMALLOC to avoid the obvious
> >>deadlocks.
> >>
> >>Note that you can achieve a similar thing in current 2.6 by acquiring
> >>realtime scheduling policy, but that's an artifact of some brainwave
> >> which a VM hacker happened to have and isn't a thing which should be
> >> relied upon.
> >
> > Do you have a pointer to the brainwave?
>
> Search for rt_task in mm/page_alloc.c

Ah, interesting idea: realtime tasks get to dip into the PF_MEMALLOC reserve, 
until it gets down to some threshold, then they have to give up and wait like 
any other unwashed nobody of a process.  _But_ if there's a user space 
process sitting in the writeout path and some other realtime process eats the 
entire realtime reserve, everything can still grind to a halt.

So it's interesting for realtime, but does not solve the userspace PF_MEMALLOC 
inversion.

> >>A privileged syscall which allows a task to mark itself as one which
> >>cleans memory would make sense.
> >
> > For now we can do it with an ioctl, and we pretty much have to do it for
> > pvmove.  But that's when user space drives the kernel by syscalls; there
> > is also the nasty (and common) case where the kernel needs userspace to
> > do something for it while it's in PF_MEMALLOC.  I'm playing with ideas
> > there, but nothing I'm proud of yet.  For now I see the in-kernel
> > approach as the conservative one, for anything that could possibly find
> > itself on the VM writeout path.
>
> You'd obviously want to make the PF_MEMALLOC task as tight as possible,
> and running mlocked:

Not just tight, but bounded.  And tight too, of course.

> I don't particularly see why such a task would be any safer in-kernel.

The PF_MEMALLOC flag is inherited down a call chain, not across a pipe or 
similar IPC to user space.

> PF_MEMALLOC tasks won't enter page reclaim at all. The only way they
> will reach the writeout path is if you are write(2)ing stuff (you may
> hit synch writeout).

That's the problem.

Regards,

Daniel
