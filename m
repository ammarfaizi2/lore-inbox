Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTDDU34 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTDDU3z (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:29:55 -0500
Received: from holomorphy.com ([66.224.33.161]:6803 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261320AbTDDU3t (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:29:49 -0500
Date: Fri, 4 Apr 2003 12:40:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030404204051.GF993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antonio Vargas <wind@cocodriloo.com>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <200304021144.21924.frankeh@watson.ibm.com> <20030403125355.GA12001@wind.cocodriloo.com> <20030403192241.GB1828@holomorphy.com> <20030404112704.GA15864@wind.cocodriloo.com> <20030404140447.GC1828@holomorphy.com> <20030404201241.GB15864@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404201241.GB15864@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 06:04:47AM -0800, William Lee Irwin III wrote:
>> Possible, though I'd favor a per-user spinlock.

On Fri, Apr 04, 2003 at 10:12:41PM +0200, Antonio Vargas wrote:
> So, when trying to add a task to the per-user pending tasks, I'd have
> to do this:
> 1. spin_lock_irqsave(uidhash_lock, flags)
> 2. spin_lock(my_user->user_lock)
> 3. spin_unlock_restore(uidhash_lock, flags);
> Is this any good?
> Could I simply do "spin_unlock(my_user->user_lock)" at end without
> taking the uidhash_lock again?

Well, you should unlock in the opposite order you acquired, and also
unlock all the locks you acquired in general.

But you shouldn't need to do this. There's a trick with reference
counting that saves you from the ostensible hierarchy:

You know the user won't go away b/c you hold a reference. You've now
forked a child, and are looking to set it up. You get a reference for
the child so it won't go away in the child's lifetime, and then take
the per-user lock _only_. The per-user lock keeps two things looking at
a user's task list from interfering with each other, but isn't needed
for looking at the rest of the user. Now you can safely park a new
task on the list or remove an old one, and when you're done, you drop
the per-user lock only.

The per-user and uidhash locks shouldn't be taken simultaneously; the
reference count on the user should be moved to or from zero,and the
thing allocated or freed, and the uidhash_lock taken and dropped to
hash or unhash without ever taking the per-user lock. Then we can just
take the per-user lock when adding to it (we hold a reference) or not
take any lock at all when freeing it (we were the last reference; no
one will ever use this again without re-initializing it). Fresh
allocations can also allow the task to add itself to the per-user
tasklist without taking the per-user lock.

The actual tricky parts are setuid and so on, where you have to move
a task between users. For this just compare the addresses of the two
per-user locks and acquire them in address order, much like something
in the scheduler, double_rq_lock(). Then you can modify both lists
while holding both the locks to make the move happen, and when done,
just unlock in the same order you acquired.


On Fri, Apr 04, 2003 at 06:04:47AM -0800, William Lee Irwin III wrote:
>> The code looks reasonable now, modulo that race you asked about.

On Fri, Apr 04, 2003 at 10:12:41PM +0200, Antonio Vargas wrote:
> What do I need to lock when I want to add a task to a runqueue?
> I'm doing a "spin_lock_irq(this_rq()->lock);"
> As you can see, I'm not yet at speed with the locking rules... any
> online references to the latest locking rules? The BKL was really
> easy to understand in comparison! *grin*

That's fine for the runqueue. Seems you've gotten it right. There are
hard problems with using the BKL; be glad the lock you're taking has a
specific relationship to what you're doing and what you're doing it to.

BTW, this probably won't actually be very efficient on SMP or with large
numbers of users, but you're probably having fun writing it anyway. =)
Best to get something running and tweak it later.

Hubertus & rml & others know more about scheduling policy in general,
so you should probably ask them about the details of that; I just
occasionally debug this stuff when it explodes.


-- wli
