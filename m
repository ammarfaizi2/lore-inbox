Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTDDW5L (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 17:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbTDDW5L (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 17:57:11 -0500
Received: from [12.47.58.55] ([12.47.58.55]:53817 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261464AbTDDW5I (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 17:57:08 -0500
Date: Fri, 4 Apr 2003 15:07:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>
Cc: hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030404150744.7e213331.akpm@digeo.com>
In-Reply-To: <20030404214547.GB16293@dualathlon.random>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
	<20030404105417.3a8c22cc.akpm@digeo.com>
	<20030404214547.GB16293@dualathlon.random>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 23:08:32.0377 (UTC) FILETIME=[1CA1DE90:01C2FAFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Fri, Apr 04, 2003 at 10:54:17AM -0800, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > Truncating a sys_remap_file_pages file?  You're the first to
> > > begin to consider such an absurd possibility: vmtruncate_list
> > > still believes vm_pgoff tells it what needs to be done.
> > 
> > Well I knew mincore() was bust for nonlinear mappings.  Never thought about
> > truncate.
> 
> IMHO sys_remap_file_pages and the nonlinear mapping is an hack and
> should be dropped eventually.

It has created exceptional situations which are rather tying our hands in
other areas.

> I mean it's not too bad but it's a mere
> workaround for:
> 
> 1) lack of 64bit address space that will be fixed
> 2) lack of O(log(N)) mmap, that will be fixed too

Yes, mmap() overhead due to the linear search, VMA space consumption,
additional TLB invalidations and additional faults.  The latter could be
fixed up via MAP_PREFAULT and are independent of nonlinearity.

Here's Ingo's original summary:

- really complex remappings (used by databases or virtualizing
  applications) create a *huge* amount of vmas - and vma's are per-process
  which puts a really big load on kernel memory allocations, especially on
  32-bit systems. I've seen applications that had a mapping setup that
  generated 128 *thousand* vmas per process, causing lots of problems.

- setting up separate mappings is expensive, causes one pagefault per page
  and also causes TLB flushes.

- even on 64-bit systems, when mapping really large (terabyte size) and
  really sparse files, sparse mappings can be a disadvantage - in the
  worst-case there can be as much as 1 more pagetable page allocated for
  every file page that is mapped in.

> 1) and 2) are the only reason why there's huge interest in such syscall
> right now. So I don't like it too much and I'm not convinced it was
> right to merge it in 2.5 given 2) is a software problem and I've the
> design to fix it with a rbtree extension, and 1) is an hardware problem
> that will be fixed very soon. the API is not too bad but there is a
> reason we have the vma for all other mappings.
> 
> Maybe I'm missing something, I'm curious to hear what you think and what
> other cases needs this syscall even after 1) and 2) are fixed.

I think that's right - the system call is very specialised and is targeted at
solving problems which have been encountered in a small number of
applications, but important ones.

Right now, I do not feel that we are going to be able to come up with an
acceptably simple VM which has both nonlinear mappings and objrmap.

