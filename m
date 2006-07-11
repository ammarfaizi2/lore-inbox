Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWGKOS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWGKOS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWGKOS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:18:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:979 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750839AbWGKOS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:18:56 -0400
Date: Tue, 11 Jul 2006 07:19:30 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       stern@rowland.harvard.edu, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com, jes@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060711141930.GA1288@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060706171401.GA1768@us.ibm.com> <20060706172022.GA1901@us.ibm.com> <20060709235029.GA194@oleg> <20060710165118.GC1446@us.ibm.com> <44B29212.1070301@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B29212.1070301@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 03:44:50AM +1000, Nick Piggin wrote:
> Paul E. McKenney wrote:
> >On Mon, Jul 10, 2006 at 03:50:29AM +0400, Oleg Nesterov wrote:
> 
> >>As I see it, 1) + 2) is NOT enough for synchronize_srcu() to be correct
> >>(the 2-nd and 3-rd synchronize_sched() calls). I think synchronize_sched()
> >>should also guarantee the completion of mem ops on all CPUs before return,
> >>not just mb() (which does not have any timing guaranties).
> >>
> >>Could you clarify this issue?
> >>
> >>(Again, I do not see any problems with the current RCU implementation).
> >
> >
> >However, this -does- seem to be to be a problem with the comment headers
> >and the documentation.  Does the following patch make things better?
> >
> >David, would it be worthwhile adding this global-memory-barrier effect
> >of synchronize_rcu(), synchronize_sched(), and synchronize_srcu() to
> 
> And call_rcu? (or is that already tucked away in the documentation
> somewhere?) ie. there is a memory barrier between the call_rcu() call
> and the actual callback.
> 
> This is something I needed clarification with (as you might remember),
> which might not be clear from an RCU API user's point of view.

Good point -- since synchronize_rcu() is just a wrapper around call_rcu(),
they do have the same properties.  How about the following?

						Thanx, Paul

Signed-off-by:  Paul E. McKenney <paulmck@us.ibm.com>

 Documentation/RCU/checklist.txt |    4 +++-
 include/linux/srcu.h            |    5 +++++
 kernel/rcupdate.c               |    4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-5/Documentation/RCU/checklist.txt linux-2.6.17-srcu-LKML-6/Documentation/RCU/checklist.txt
--- linux-2.6.17-srcu-LKML-5/Documentation/RCU/checklist.txt	2006-07-10 09:43:19.000000000 -0700
+++ linux-2.6.17-srcu-LKML-6/Documentation/RCU/checklist.txt	2006-07-11 07:12:25.000000000 -0700
@@ -224,4 +224,6 @@ over a rather long period of time, but i
 
 14.	The synchronize_rcu(), synchronize_sched(), and synchronize_srcu()
 	primitives force at least one memory barrier to be executed on
-	each active CPU before they return.
+	each active CPU before they return.  Similarly, call_rcu()
+	forces at least one memory barrier to be executed on each active
+	CPU before the corresponding callback is invoked.
diff -urpNa -X dontdiff linux-2.6.17-srcu-LKML-5/kernel/rcupdate.c linux-2.6.17-srcu-LKML-6/kernel/rcupdate.c
--- linux-2.6.17-srcu-LKML-5/kernel/rcupdate.c	2006-07-10 09:48:32.000000000 -0700
+++ linux-2.6.17-srcu-LKML-6/kernel/rcupdate.c	2006-07-11 07:11:07.000000000 -0700
@@ -116,6 +116,10 @@ static inline void force_quiescent_state
  * read-side critical sections have completed.  RCU read-side critical
  * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
  * and may be nested.
+ *
+ * There will be at least one memory barrier executed on each active
+ * CPU between the time call_rcu() is invoked and the time that the
+ * corresponding callback is invoked.
  */
 void fastcall call_rcu(struct rcu_head *head,
 				void (*func)(struct rcu_head *rcu))
