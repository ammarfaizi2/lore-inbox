Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFSUPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFSUPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFSUOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:14:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39611 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261309AbVFSUOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:14:21 -0400
Date: Sun, 19 Jun 2005 13:14:40 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel() calls
Message-ID: <20050619201439.GA1302@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050618002021.GA2892@us.ibm.com> <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 11:53:24AM -0600, Zwane Mwaikambo wrote:
> On Fri, 17 Jun 2005, Paul E. McKenney wrote:
> 
> > Please let me know if there are any problems with any of these changes.
> 
> Hi Paul,
> 	Do you have any pending patches to update Documentation/RCU/* too? 
> The best i can find explaining usage is from;
> 
> http://lwn.net/Articles/130341/

Hello, Zwane,

I did update Documentation/RCU/* to change the uses of synchronize_kernel(),
but was relying on the documentation-extraction stuff to build the API
documentation.  So I have the following header comments in mainline:

/**
 * synchronize_rcu - wait until a grace period has elapsed.
 *
 * Control will return to the caller some time after a full grace
 * period has elapsed, in other words after all currently executing RCU
 * read-side critical sections have completed.  RCU read-side critical
 * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
 * and may be nested.
 *
 * If your read-side code is not protected by rcu_read_lock(), do -not-
 * use synchronize_rcu().
 */

/**
 * synchronize_sched - block until all CPUs have exited any non-preemptive
 * kernel code sequences.
 *
 * This means that all preempt_disable code sequences, including NMI and
 * hardware-interrupt handlers, in progress on entry will have completed
 * before this primitive returns.  However, this does not guarantee that
 * softirq handlers will have completed, since in some kernels
 *
 * This primitive provides the guarantees made by the (deprecated)
 * synchronize_kernel() API.  In contrast, synchronize_rcu() only
 * guarantees that rcu_read_lock() sections will have completed.
 */

Hmmm...  Looks like some repair is needed in the synchronize_sched()
header comment -- and I vaguely remember someone pointing this out. :-/
See patch below for a fix.

Glancing through the Documentation/RCU/* stuff again, it could definitely
use some help.  Would it help if I added an example use of
synchronize_sched() that interacted with NMIs?

						Thanx, Paul

---

Signed-off-by: paulmck@us.ibm.com

 rcupdate.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff -urpN -X dontdiff linux-2.6.12-rc6/include/linux/rcupdate.h linux-2.6.12-rc6-ssdoc/include/linux/rcupdate.h
--- linux-2.6.12-rc6/include/linux/rcupdate.h	Fri Jun 17 16:35:13 2005
+++ linux-2.6.12-rc6-ssdoc/include/linux/rcupdate.h	Sun Jun 19 12:53:51 2005
@@ -260,10 +260,15 @@ static inline int rcu_pending(int cpu)
  * synchronize_sched - block until all CPUs have exited any non-preemptive
  * kernel code sequences.
  *
- * This means that all preempt_disable code sequences, including NMI and
- * hardware-interrupt handlers, in progress on entry will have completed
- * before this primitive returns.  However, this does not guarantee that
- * softirq handlers will have completed, since in some kernels
+ * This means that all preempt_disable code sequences in progress on entry
+ * will have completed before this primitive returns.  It also means that
+ * all NMIs and hardware interrupts pending on entry will have completed
+ * their handlers before exit, where "pending" means that the interrupt
+ * assertion has reached the CPU.  Note however that some kernel
+ * configurations and some patches cause interrupt handlers and softirqs
+ * to run in process context, sometimes preemptably.  In such kernels,
+ * only the beginning portion of the handler that runs with preemption
+ * disabled will be guaranteed to have completed.
  *
  * This primitive provides the guarantees made by the (deprecated)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
