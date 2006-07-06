Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWGFSfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWGFSfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWGFSfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:35:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11741 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750706AbWGFSfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:35:42 -0400
Date: Thu, 6 Jul 2006 10:14:01 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@us.ibm.com
Cc: akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, oleg@tv-sign.ru, jes@sgi.com
Subject: [PATCH 0/2] srcu-3: add RCU variant that permits read-side blocking
Message-ID: <20060706171401.GA1768@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 3 of the SRCU patchset.

This patch incorporates a number of improvements, many of which came
up in off-list discussions with Alan Stern.  Neither of us are sure
why these discussions ended up off-list, so I have summarized them
below.

o	Fixes some "zombie code" -- excess curly braces and the like.

o	Gets rid of the double-flip in favor of an additional
	synchronize_sched().  This turned out to be safe, despite
	my saying otherwise at http://lkml.org/lkml/2006/6/27/486.
	The trick that I was missing is that synchronize_sched()
	forces all CPUs to execute at least one memory barrier during
	the synchronize_sched()'s execution, which forces all CPUs
	to see synchronize_srcu()'s counter increment as happening
	after any memory manipulations prior to the synchronize_srcu().

	Upgraded comments to indicate what the synchronize_sched()
	calls are needed for.

o	Added a barrier() to both srcu_read_lock() and srcu_read_unlock()
	to prevent the compiler from performing optimizations that
	would cause the critical section to move outside of the
	enclosing srcu_read_lock() and srcu_read_unlock().

	However, these barrier()s in srcu_read_lock() and srcu_read_unlock()
	are needed only in non-CONFIG_PREEMPT kernels, so they compile
	to nothing in CONFIG_PREEMPT kernels (where the preempt_disable()
	and preempt_enable() calls supply the needed barrier() call).

o	Added a check to synchronize_srcu() that permits this primitive
	to take advantage of grace periods induced by concurrent executions
	in other tasks.  This can be useful in cases where you are
	using a single srcu_struct to handle all the individually-locked
	chains of a hash table, for example.

o	cleanup_srcu_struct() now contains error checks to catch cases
	where readers are still using the srcu_struct in question.
	It does a WARN_ON() and leaks the srcu_struct's per-CPU data
	in that case.

o	There is an srcu_readers_active() that returns the number of
	readers (approximate!) currently using the specified srcu_struct.
	This can be useful when terminating use of an srcu_struct, e.g.,
	at module-unload time.

o	Improved the RCU torture tests, increasing the skew on reader
	times and providing implementation-specific delay functions.
