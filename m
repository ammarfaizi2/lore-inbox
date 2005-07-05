Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVGESTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVGESTK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVGESTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:19:10 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:39082 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261948AbVGESRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:17:33 -0400
Date: Tue, 5 Jul 2005 13:17:27 -0500
From: serge@hallyn.com
To: Tony Jones <tonyj@immunix.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050705181727.GA5209@vino.hallyn.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050704031820.GA6871@immunix.com> <20050704115135.GA27617@vino.hallyn.com> <20050704193753.GA28893@immunix.com> <20050704200646.GA4211@vino.hallyn.com> <20050704204155.GA30210@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704204155.GA30210@immunix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Jones (tonyj@immunix.com):
> I'm going to have to give it some thought, but a new rmmod hook does seem
> a good solution off the top of my head.

In reponse to some prodding by Tony, here is a summary of the current
locking scheme in stacker, sprinkled with some notes about one way lsm
removal could be supported.

This will likely be added to the Documentation/stacker.txt file.

thanks,
-serge

The following describes the locking used by the lsm stacker as of
July 1, 2005:

Things which require locking include:

	1. module list
	2. per-kernel-object security lists

The module list is protected as follows:

	Walking the list is done under a partial rcu_read_lock.  In
	particular, we cannot hold the rcu_read_lock while calling a
	module_entry->lsm_hook(), as these are very likely to sleep.
	Therefore we call rcu_read_lock() only when we rcu_dereference
	module_entry->next.

	module_entries are not to be deleted.  By using the
	stacker_unload() function, they may be removed from the
	stacked_modules list.  The forward pointer is not changed, so
	that any stacker hook which is currently on module_entry
	can safely and correctly dereference module_entry->next.
	The module_entry remains on the all_modules list, which is
	used when kernel objects are freed.  In this way, any memory
	allocated by module_entry can still be freed.

	In the past, module deletion was supported in this scheme as
	follows: we added a reference count to the module_entry,
	which was incremented (under the rcu_read_lock) whenever a
	stacker hook was going to execute module_entry->lsm_hook().
	Module deletion was then done from a call_rcu().  If the
	refcount was not null after an rcu cycle, the del_func could
	delete the module.  Otherwise, it decremented the usage count,
	so that when the stacker hook returned from lsm_hook() it would
	find the refcount at 1, and delete the module.

	Re-enabling module deletion in this way should have a performance
	impact, and would require all modules to delete all their
	allocated kernel memory during module_exit().

The kernel object security lists are protected as follows:

	The security_set_value and security_del_value are only to
	be called during security_alloc_object and security_del_object,
	respectively.  Since these are automatically safe from
	concurrent accesses, no locking is required here.

	The security_add_value() function is protected from concurrent
	access using the stacker_value_spinlock.  security_get_value()
	is protected from security_add_value() using rcu.

	To allow module deletion, it would be desirable for modules
	to be able to delete kernel object security entries at any
	time.  This should be safe to do using RCU.  Modules would use
	security_unlink_value(), which would use hlist_del_rcu() to free
	the value, and LSMs would have to use call_rcu() to free the
	data in order to protect racing security_get_value()s.  This
	would happen as follows:

	1. security_unlink_value() would basically be security_del_value
	protected using the stacker_value_spinlock().
	2. An LSM would delete a value using:

		my_struct = security_unlink_value_type(&inode->i_security,
				MY_LSM_ID, struct my_struct);
		< do any necessary freeing of LSM data>
		security_free_value_type(my_struct);
	3. security_free_value_type would use call_rcu to kfree my_struct.
