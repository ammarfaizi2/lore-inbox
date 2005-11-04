Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbVKDJxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVKDJxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 04:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVKDJxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 04:53:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:27881 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161126AbVKDJxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 04:53:53 -0500
Date: Fri, 4 Nov 2005 01:52:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bron@bronze.corp.sgi.com, pbadari@gmail.com, jdike@addtoit.com,
       rob@landley.net, nickpiggin@yahoo.com.au, gh@us.ibm.com, mingo@elte.hu,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       mbligh@mbligh.org, kravetz@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051104015250.42364430.pj@sgi.com>
In-Reply-To: <20051104000212.2e0e92bd.akpm@osdl.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
	<20051103213538.7f037b3a.pj@sgi.com>
	<20051103214807.68a3063c.akpm@osdl.org>
	<20051103224239.7a9aee29.pj@sgi.com>
	<20051103231019.488127a6.akpm@osdl.org>
	<20051103234530.5fcb2825.pj@sgi.com>
	<20051104000212.2e0e92bd.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A per-task stat requires walking the tasklist, to build a list of the
> > tasks to query.
> 
> Nope, just task->mm->whatever.

Nope.

Agreed - once you have the task, then sure, that's enough.

However - a batch scheduler will end up having to figure out what tasks
there are to inquire, by either listing the tasks in a cpuset, or
by listing /proc.  Either way, that's a tasklist scan.  And it will
have to do that pretty much every iteration of polling, since it has
no a priori knowledge of what tasks a job is firing up.


> Well no.  Because the filtered-whatsit takes two spinlocks and does a bunch
> of arith for each and every task, each time it calls try_to_free_pages(). 

Neither spinlock is global - the task and a lock in its cpuset.

I see a fair number of existing locks and semaphores, some global
and some in loops, that look to be in the code invoked by
try_to_free_pages(). And far more arithmetic than in that little
filter.

Granted, its cost seen by all, for the benefit of few.  But other sorts
of per-task or per-mm stats are not going to be free either.  I would
have figured that doing something per-page, even the most trivial
"counter++" (better have that mm locked) will likely cost more than
doing something per try_to_free_pages() call.


> The frequency of that could be very high indeed, even when nobody is
> interested in the metric which is being maintained(!)

When I have a task start allocating memory as fast it can, it is only
able to call try_to_free_pages() about 10 times a second on an idle
ia64 SN2 system, with a single thread, or about 20 times a second
running several threads at once allocating memory.

  That's not "very high" in my book.

What sort of load would hit this much more often?  


If more folks need these detailed stats, then that's how it should be.

But I am no fan of exposing more than the minimum kernel vm details for
use by production software.

We agree that my per-cpuset memory_reclaim_rate meter certainly hides
more detail than the sorts of stats you are suggesting.  I thought that
was good, so long as what was needed was still present.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
