Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbULEX6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbULEX6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbULEX6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:58:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5283 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261427AbULEX6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:58:07 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: paulmck@us.ibm.com
Date: Mon, 6 Dec 2004 10:57:52 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16819.41088.159731.651102@cse.unsw.edu.au>
Cc: andmike@us.ibm.com, dipankar@us.ibm.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] RCU questions on md driver
In-Reply-To: message from Paul E. McKenney on Saturday December 4
References: <20041205003104.GA1914@us.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday December 4, paulmck@us.ibm.com wrote:
> Hello!
> 
> A few questions and comments on md driver locking, my best guess at
> answers may be found in the patch below (which I have not even attempted
> to compile, let alone test).

Thanks for the input.

> 
> o	Need some rcu_dereference() primitives in a number of places.

I don't understand the need for these.
In the first place, it would seem from a quick reading of rcupdate.h
that rcu_dereference would normally be paired with rcu_assign_pointer,
however you haven't inserted any calls to rcu_assign_pointer.

Secondly, the usage of "rcu_read_[un]lock" in md is not about
protecting data in the these data structures.  It is purely about
synchronising with synchronize_kernel in raid1_remove_disk (and
similar).

*_remove_disk sets ->rdev to NULL, calls synchronize_kernel, and then
checks ->nr_pending on the thing that used to be in ->rdev.  It will
have "lost the race" (and so must put the value of ->rdev back) only
if some other code called atomic_inc(&rdev->nr_pending) under an
rcu_read_lock.   Presumably atomic_inc and atomic_read have enough
barriers to make this work.

> 
> o	The reference counts must be decremented after rcu_read_lock().
> 	Otherwise, unless I am missing something, a preemption (in a
> 	CONFIG_PREEMPT kernel) occuring just before the rcu_read_lock()
> 	looks like it could destroy the element subsequently used.

I don't think so.  The "element" isn't "subsequently used" after
rdev_dec_pending is called (or have I missed something?)

> 
> o	How does the locking work in read_balance() in drivers/md/raid1.c?
> 	It looks to me that the conf->mirrors[] array could potentially
> 	be changing during the read_balance() operation, which I cannot
> 	see how is handled correctly.

There is no locking on "head_position" and it could well change
underneath read_balance.  However read_balance is at-best a fuzzy
heuristic.  If it mostly makes a reasonably good decision about which
device to use, that is the best we can hope for anyway.  Random
changes in head_position won't affect correctness of the code, only
performance. 

However there is some code in there that isn't quite right:

		while (!conf->mirrors[new_disk].rdev ||
		       !conf->mirrors[new_disk].rdev->in_sync) {
should really read
		while ((rdev=conf->mirrors[new_disk].rdev)== NULL ||
		       !rdev->in_sync) {

(much as your patch does) to avoid the second de-reference getting a
NULL which the first didn't see (Though I suspect the compile will
optimise  out the extra de-ref anyway.


> 
> 	For that matter, I don't see what prevents multiple instances
> 	of read_balance() from executing concurrently on the same
> 	set of disks...

Nothing.

> 
> o	Ditto for read_balance in drivers/md/raid10.c.  And raid5.c.

ditto for raid10.  raid5 doesn't read-balance.


Have I adequately answered your concerns?

NeilBrown

