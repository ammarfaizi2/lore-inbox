Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWKEWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWKEWxz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWKEWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:53:55 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:38969
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1422793AbWKEWxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:53:54 -0500
Date: Sun, 5 Nov 2006 14:33:19 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: ego@in.ibm.com, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061105223319.GB5065@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <20061104173716.GA618@in.ibm.com> <454CDBA4.4040503@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <454CDBA4.4040503@cosmosbay.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 07:27:48PM +0100, Eric Dumazet wrote:
> Gautham R Shenoy a écrit :
> >On Thu, Nov 02, 2006 at 10:52:47PM +0100, Mikulas Patocka wrote:
> >>Hi
> >
> >Hi Mikulas
> >>As my PhD thesis, I am designing and writing a filesystem, and it's now 
> >>in a state that it can be released. You can download it from 
> >>http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> >>
> >>It has some new features, such as keeping inode information directly in 
> >>directory (until you create hardlink) so that ls -la doesn't seek much, 
> >>new method to keep data consistent in case of crashes (instead of 
> >>journaling), free space is organized in lists of free runs and converted 
> >>to bitmap only in case of extreme fragmentation.
> >>
> >>It is not very widely tested, so if you want, test it.
> >>
> >>I have these questions:
> >>
> >>* There is a rw semaphore that is locked for read for nearly all 
> >>operations and locked for write only rarely. However locking for read 
> >>causes cache line pingpong on SMP systems. Do you have an idea how to 
> >>make it better?
> >>
> >>It could be improved by making a semaphore for each CPU and locking for 
> >>read only the CPU's semaphore and for write all semaphores. Or is there a 
> >>better method?
> >
> >I am currently experimenting with a light-weight reader writer semaphore 
> >with an objective to do away what you call a reader side cache line
> >"ping pong". It achieves this by using a per-cpu refcount.
> >
> >A drawback of this approach, as Eric Dumazet mentioned elsewhere in this
> >thread, would be that each instance of the rw_semaphore would require
> >(NR_CPUS * size_of(int)) bytes worth of memory in order to keep track of
> >the per-cpu refcount, which can prove to be pretty costly if this
> >rw_semaphore is for something like inode->i_alloc_sem.
> 
> We might use an hybrid approach : Use a percpu counter if NR_CPUS <= 8
> 
> #define refcount_addr(zone, cpu) zone[cpu]
> 
> For larger setups, have a fixed limit of 8 counters, and use a modulo
> 
> #define refcount_addr(zone, cpu) zone[cpu & 7]
> 
> In order not use too much memory, we could use kind of vmalloc() space, 
> using one PAGE per cpu, so that addr(cpu) = base + (cpu)*PAGE_SIZE;
> (vmalloc space allows a NUMA allocation if possible)

The fact that counters are shared forces use of atomic instructions.

If the situation is highly read-intensive, another memory-saving
approach would be to share the "lock" among multiple inodes, for
example, hashing the inode address.  That way there would be NR_CPUS
counters per hash bucket, but (hopefully) far fewer hash buckets
than inodes.

						Thanx, Paul

> So instead of storing in an object a table of 8 pointers, we store only the 
> address for cpu0.
> 
> 
> >
> >So the question I am interested in is, how many *live* instances of this
> >rw_semaphore are you expecting to have at any given time?
> >If this number is a constant (and/or not very big!), the light-weight
> >reader writer semaphore might be useful.
> >
> >Regards
> >Gautham.
> 
