Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVBNPeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVBNPeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 10:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVBNPeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 10:34:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:28809 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261447AbVBNPd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 10:33:57 -0500
Date: Sat, 12 Feb 2005 06:12:28 -0600
From: Robin Holt <holt@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050212121228.GA15340@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf8yf2nu.fsf@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 12:17:25PM +0100, Andi Kleen wrote:
> Ray Bryant <raybry@sgi.com> writes:
> > set of pages associated with a particular process need to be moved.
> > The kernel interface that we are proposing is the following:
> >
> > page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> 
> [Only commenting on the interface, haven't read your patches at all]
> 
> This is basically mbind() with MPOL_F_STRICT, except that it has a pid 
> argument. I assume that's for the benefit of your batch scheduler.
> 
> But it's not clear to me how and why the batch scheduler should know about
> virtual addresses of different processes anyways. Walking
> /proc/pid/maps? That's all inherently racy when the process is doing
> mmap in parallel. The only way I can think of to do this would be to
> check for changes in maps after a full move and loop, but then you risk
> livelock.

For our use, the batch scheduler will give an intermediary program a
list of processes and a series of from-to node pairs.  That process would
then ensure all the processes are stopped, scan their VMAs to determine
what regions are mapped by more than one process, which are mapped
by additional processes not in the job, and make this system call for
each of the unique ranges in the job to migrate their pages from one
node to the next.  I believe Ray is working on a library and a standalone
program to do this from a command line.

> 
> And you cannot also just specify va_start=0, va_end=~0UL because that
> would make the node arrays grow infinitely.

Across the job, you could be moving some memory regions multiple times.

> 
> Also is there a good use case why the batch scheduler should only
> move individual areas in a process around, not the full process?

Overlapping regions.

> 
> I think the only sane way for an external process to move another 
> around is to do it for the whole process. For that you wouldn't need
> most of the arguments, but just a simple move_process_vm call,
> or perhaps just a file in /proc where the new node can be written to.

But when you take into consideration multiple processes in a job that
all started from one set of mappings and has since tweaked their
mappings to suite their particular needs, there doesn't appear to
be any way to do it without some form of leg work as described
above.

> 
> There may be an argument to do this for individual 
> tmpfs/hugetlbfs/sysv shm segments too, but mbind() already supports
> that (just map them from a different process and change the policy there)
> 
> For process use you could just do it in mbind() or perhaps
> part of the process policy (move page around when touched by process). 

This functionality will be used by the batch scheduler to not only
move the processes memory to a different set of nodes, but also reduce
the memory usage on the old set of nodes.  For that reason, you can not
rely on touch as the process that _NEEDS_ the memory moved does not
have control of program flow to ensure that after the SIGCONT is sent
the process will touch all of its address space.

Thanks,
Robin Holt
