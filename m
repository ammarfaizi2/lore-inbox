Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVBUMAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVBUMAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 07:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVBUMAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 07:00:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24035 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261956AbVBUMAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 07:00:25 -0500
Date: Mon, 21 Feb 2005 03:58:08 -0800
From: Paul Jackson <pj@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       elsa-devel@lists.sourceforge.net, gh@us.ibm.com, efocht@hpce.nec.com,
       jlan@engr.sgi.com
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Message-Id: <20050221035808.48401cd2.pj@sgi.com>
In-Reply-To: <1108981982.8418.120.camel@frecb000711.frec.bull.fr>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	<1108655454.14089.105.camel@uganda>
	<1108969656.8418.59.camel@frecb000711.frec.bull.fr>
	<20050221014728.6106c7e1.pj@sgi.com>
	<1108981982.8418.120.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank-you for your quick answer.

Guillaume wrote:
>
> If a process belongs to several group of processes, an new integer in
> the task_struct is not enough, you need a list or something like this.
> If you're using a list you need to add function to manage this list in
> the kernel but we don't want to add this kind of management inside the
> kernel because with the fork connector we can keep it outside.

Ok - fork connect.  From your patch of a couple days ago, for the
benefit of lurkers:
> 
>     It's a new patch that implements a fork connector in the
> kernel/fork.c:do_fork() routine. The connector sends information about
> parent PID and child PID over a netlink interface. It allows to several
> user space applications to be alerted when a fork occurs in the kernel.

Whoaa ... you're saying that because you might have several groups a
task could belong to at once, you'll use netlink to avoid managing lists
in the kernel.  Seems that you're spending thousands of instructions to
save dozens.  This is not a good trade off.

I can imagine several way cheaper ways to handle this.

If the number of groups to which a task could belong has some small
finite upper limit, like at most 5 groups, you could have 5 integer id's
in the task struct instead of 1.  If the number of elements in a
particular group has a small upper bound, you could even replace the
ints with bit fields.

Or you could enumerate the different combinations of groups to which a
task might belong, assign each such combination a unique integer, and
keep that integer in the task struct.  The enumeration could be done
dynamically, only counting the particular combinations of group
memberships that actually had use.  This has the disadvantage that a
particular combination, once enumerated, would have to stay around until
the next boot - a potential memory leak.  Probably not acceptable,
unless the cost of storing a no longer used combination is nearly zero.

Or you could have a little 'jobids' struct that held a list and a
reference counter, where the list held a particular combination of ids,
and the reference counter tracked how many tasks referenced that jobids
struct. Put a single pointer in the task struct to a jobids struct, and
increment and decrement the reference counter in the jobids struct on
fork and exit.  Free it if the count goes to zero on exit.  This solves
the memory leak of the previous, with increased cost to the fork.  Since
we really do design these systems to stay up 'forever', this is perhaps
the winner.  Any time a particular task is added to, or removed from, a
group, if the ref count of its jobids struct is one, then modify the id
list attached to that jobids struct in place.  If the ref count is more
than one, copy the jobids struct and list to a new one, decrement the
count in the old one, and modify the new one in place.  Such list and
counter manipulations are the daily stuff of kernel code.  No need to
avoid such.

Just because you have more than one id doesn't mean each task has to be
connected directly into its own custom list, and even if you needed
that, I don't see that it's a win to avoid such a list by using netlink.

It can be a worthwhile exercise to single step through each machine
instruction that you add to fork, in the forking task or any other task
that is sent data or a signal therefrom.  You really do want to keep the
number of added instructions (and number of additional cache lines and
memory pages accessed, especially written) to a minimum.  If the effort
of single stepping through such would require the patience of
Copernicus, then it's back to the drawing board for a more efficient
solution.

> I don't know if there is some work around 1) and 4). 

Well, you might have dodged the (1) bullet up until now by using netlink
and not extending the accounting record at exit.  Bullet (1) was
extending the accounting record past its fairly constrained size, if
that's still a problem; it's been years since I looked.  But if you
adapt one of the above suggestions, and don't send anything out of the
task context at fork, then you will have to deal with (1) in order to
include the list of job id's in the record written at exit.

If you want to collect any other data, bullet (3), you will also to
solve bullet (1).

Item (4), collecting accounting data for long running tasks, is probably
less pressing.  Its solution will also likely require solving (1),
however.

Taking a quick look at init/Kconfig and include/linux/acct.h, it seems
we are using BSD_PROCESS_ACCT_V3 format, which is the latest 64 byte
format, allowing for larger uid/gid.

With slight variations, this 64 byte format has lasted about 25 years.
It's time to replace it, especially if you have designs on collecting
any additional information, which you clearly do.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
