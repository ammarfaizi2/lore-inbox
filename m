Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275115AbRJAOui>; Mon, 1 Oct 2001 10:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJAOu2>; Mon, 1 Oct 2001 10:50:28 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:60134 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S275097AbRJAOuR>; Mon, 1 Oct 2001 10:50:17 -0400
Date: Mon, 1 Oct 2001 09:49:46 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200110011449.JAA80750@tomcat.admin.navo.hpc.mil>
To: riel@conectiva.com.br, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: Load control  (was: Re: 2.4.9-ac16 good perfomer?)
Cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>:
> On Mon, 1 Oct 2001, Daniel Phillips wrote:
> 
> > Nice.  With this under control, another feature of his memory manager
> > you could look at is the variable deactivation threshold, which makes
> > a whole lot more sense now that the aging is linear.
> 
> Actually, when we get to the point where deactivating enough
> pages is hard, we know the working set is large and we should
> be _more careful_ in chosing what to page out...
>
> When we go one step further, where the working set approaches
> the size of physical memory, we should probably start doing
> load control FreeBSD-style ... pick a process and deactivate
> as many of its pages as possible. By introducing unfairness
> like this we'll be sure that only one or two processes will
> slow down on the next VM load spike, instead of all processes.
> 
> Once we reach permanent heavy overload, we should start doing
> process scheduling, restricting the active processes to a
> subset of all processes in such a way that the active processes
> are able to make progress. After a while, give other processes
> their chance to run.

Just a comment:
This begins to sound like the old VMS handling:
1. When not loaded down, all processes allocate freely.
2. When getting tight, trim all processes down some amount, until enough is
   free (balanced by page fault rate measure - process with the lowest fault
   rate gets trimmed first).
3. Continue triming until required space available or all processes are at
   their working set minimum.
4. if still tight, swap a process completely (determined by length of time
   since last IO wait - larger CPU bound jobs/processes got swaped first),
   reclaim memory. Note, at this point OOM may occur.
5. If swap full, do not start new processes (ENOMEM)
6. When a process exits, reclaim memory - if working set minimum available
   then swapin a process.

I also vaguely remember something about processes spawning new processes -
if memory wasn't immediately available (working set minimum for the new
process) then the process attempting the spawn is put to sleep (or swapped,
or both - this may have only occured if there was room in swap for the
process, if not - ENOMEM on the fork, in case that causes the parent to
exit and free more memory).

The trimming action did not immediately cause a pageout - all that was
needed was to reduce the working set size. The process that needed memory
would then cause the system to scan memory for pages that could be freed.
The first process examined (may have been the process asking for memory)
would have the excess pages paged out. (I believe they were chosen by a
LRU mechanism)

There was also a scheduling fairness rule about swapped processes geting
a schedule increment of 1, in memory processes got incremented 4, IO wait
processes got +6. When they were selected for run: if previous state was IO,
then decrement by 2, if state run, decrement by 2. If a swapped process
schedule value > in memory process, swap the memory resident process out,
swapin  the swaped process. (Oviously this isn't quite right :-)



-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
