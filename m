Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932971AbWGAGAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbWGAGAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 02:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbWGAGAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 02:00:10 -0400
Received: from o2.escape.de ([194.120.234.254]:10708 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S932971AbWGAGAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 02:00:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Q: locking mechanisms
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 01 Jul 2006 07:58:20 +0200
Message-ID: <m2odw9g937.fsf@janus.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to lock concurrent access to a list and I am unsure what the
best locking mechanism is in this case.

I have 3 functions which access the list, 2 functions called from a
syscall, i.e. in process context, need write access, and one called
from the softirq for network packet reception.

Currently, I have something like this (much simplified):

	HLIST_HEAD(head);
	rwlock_t lock = RW_LOCK_UNLOCKED;
    
	add_item(...)  /* called_from_syscall */
	{
		...
		write_lock_bh(&lock);
		some_read_operations_on_the_list();
		if (some_condition) {
			p = kmalloc(...);
			initialize(p);
			hlist_add_head(p->list, &head);
		}
		write_unlock_bh(&lock);
	}
    
	del_item(...)  /* called_from_syscall */
	{
		...
		write_lock_bh(&lock);
		p = find_item_to_delete();
		hlist_del(p->list);
		kfree(p);
		write_unlock_bh(&lock);
	}
    
	receive_function(...)
	{
		...
		read_lock(&lock);
		hlist_for_each_entry(p, n, &head, list) {
			deliver_packet_to_recv_queue(p);
		}
		read_unlock(&lock);
	}

The problem here is, that the receive_function() may have to wait very
long for the lock while the add_item() function holds the lock and
blocks in the call to kmalloc().  For some reasons it's not easy to
move the kmalloc() outside the locked region.

I have also thought about using RCU.  But I don't understand it
toroughly enough.

The straight-forward way would be to remove the calls to write_lock(),
replace the list operations by their _rcu counterpart, and replace the
calls to read_lock/read_unlock by calls to rcu_read_lock/rcu_read_unlock,
and replace the call to kfree() by a call to call_rcu(..., kfree, p);
Right?

This would make the list traversal for packet delivery atomic, by
disabling preemption on that CPU.  However, since the list may contain
quite a number of receivers, preemption may be disabled for a time
longer than I'd like it to.

So my question is, is it really necessary for the list traversal to be
atomic, i.e. to disable preemption?  According to "Linux Device
Drivers", this is needed for the callback function, so it can be
called after the scheduler has been run on all CPUs and no reader is
still accessing the list item to be freed.  Is it right, that the
rcu_read_lock() wouldn't be necessary if I only would call
list_add_rcu() and list_del_rcu() since these make atomic changes and
can run in parallel anyway, even with rcu_read_lock(), on a SMP
system?

If so, I could possibly find another way to kfree() the list item when
no one is still using it.  Without the need to disable preemption for
too long a time.


Yet another solution would be to have two locks, one to synchronize
multiple processes trying to modify the list, similar to the code
above, and a rwlock to synchronize between writes from the processes
and the softirq routine receiving packets.  The receiving function
would use read_lock as in the code above, and the del_item() function
would get a write-lock just for the two lines

    write_lock_bh(&other_lock);
    hlist_del(p->list)
    kfree(p)
    write_unlock_bh(&other_lock)

However, if possible, I would prefer avoiding a second lock.

BTW, while working on this I thought about two functions I would like
to see in the kernel:  upgrade a read_lock to write_lock and downgrade
a write_lock to read_lock.


urs
