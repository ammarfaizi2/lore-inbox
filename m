Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUILEo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUILEo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 00:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUILEo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 00:44:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:25085 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267618AbUILEoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 00:44:24 -0400
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Simon.Derr@bull.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
In-Reply-To: <20040911192156.1da7c636.pj@sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	 <20040911082834.10372.51697.75658@sam.engr.sgi.com>
	 <20040911141001.GD32755@krispykreme> <20040911100731.2f400271.pj@sgi.com>
	 <1094923728.3997.10.camel@localhost>  <20040911192156.1da7c636.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1094964209.16406.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 21:43:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 19:21, Paul Jackson wrote:
>   Just as code in kernel/sched.c:move_task_off_dead_cpu()
>   updates the affected tasks cpus_allowed to move off a dead
>   CPU, calling cpuset_cpus_allowed() to get a new list of
>   candidate CPUs to be set in task->cpus_allowed, similarly I
>   expect that disabling a Memory Node should result in some
>   "move_task_off_dead_memory()" routine, that called a cpuset
>   routine to be called "cpuset_mems_allowed()", to get a new
>   list of Memory Nodes, to be set in task->mems_allowed.
> 
>   Does this expectation fit for you?  If so, let me know when
>   you want the"cpuset_mems_allowed()" routine - or take a stab
>   at it yourself if you find that easier.

That seems pretty reasonable to me.  The fallback order that's
implemented in move_task_off_dead_cpu() seems very similar to what needs
to be done for memory.  However, those operations might have to occur a
bit earlier in the process for memory.

Consider a case where a zone is shrinking, and memory is being moved out
of a section inside of it.  We should try to allocate the memory to move
pages from the shrinking area in the same zone, the same node, then in
other ever-less-optimal NUMA nodes.

But, this has to occur in any removal case, even before the node is
completely gone.  So, for now, I think that we probably need to go about
the normal removal process, and make sure to update mems_allowed if a
process's page is migrated to a place that wasn't in its mems_allowed.

Is it easy to tell if a given page was influenced by a cpusets
allocation?  How would the memory removal code know which task[s] to go
and update?

>   There are other ways to skin this cat - feel free to offer
>   such up if that fits your work better.

My only other idea is just to leave it alone for now.  We're still a
good bit of time away from removing NUMA nodes and I'll probably have a
much better idea about what we need when that occurs.  

Somebody correct me if you disagree, but I don't see merging memory
removal as something that's going to happen in the next couple of
months.  The work that I'm doing on it now is more so that I can
robustly test addition over, and over, and over again and get
_additiion_ in a mergable state.

I hate to have you or anyone else do a bunch of work for something that
isn't in-tree or planned to be in-tree for a while.  We'll fix it when
we get there :)

-- Dave

