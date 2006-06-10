Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWFJAVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWFJAVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWFJAVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:21:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:57785 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932607AbWFJAVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:21:47 -0400
Date: Fri, 9 Jun 2006 17:21:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com, akpm@osdl.org, davem@redhat.com, torvalds@osdl.org,
       josh@freedesktop.org
Subject: [PATCH] RCU documentation: self-limiting updates and call_rcu()
Message-ID: <20060610002110.GA16751@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update to the RCU documentation calling out the self-limiting-update-rate
advantages of synchronize_rcu(), and describing how to use call_rcu()
in a way that results in self-limiting updates.  Self-limiting updates
are important to avoiding RCU-induced OOM in face of denial-of-service
attacks.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 checklist.txt |   44 +++++++++++++++++++++++++++++++++++++++++---
 whatisRCU.txt |   12 +++++++++++-
 2 files changed, 52 insertions(+), 4 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-rc3/Documentation/RCU/checklist.txt linux-2.6.17-rc3-RCUDOC/Documentation/RCU/checklist.txt
--- linux-2.6.17-rc3/Documentation/RCU/checklist.txt	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3-RCUDOC/Documentation/RCU/checklist.txt	2006-06-09 17:01:11.000000000 -0700
@@ -144,9 +144,47 @@ over a rather long period of time, but i
 	whether the increased speed is worth it.
 
 8.	Although synchronize_rcu() is a bit slower than is call_rcu(),
-	it usually results in simpler code.  So, unless update performance
-	is important or the updaters cannot block, synchronize_rcu()
-	should be used in preference to call_rcu().
+	it usually results in simpler code.  So, unless update
+	performance is critically important or the updaters cannot block,
+	synchronize_rcu() should be used in preference to call_rcu().
+
+	An especially important property of the synchronize_rcu()
+	primitive is that it automatically self-limits: if grace periods
+	are delayed for whatever reason, then the synchronize_rcu()
+	primitive will correspondingly delay updates.  In contrast,
+	code using call_rcu() should explicitly limit update rate in
+	cases where grace periods are delayed, as failing to do so can
+	result in excessive realtime latencies or even OOM conditions.
+
+	Ways of gaining this self-limiting property when using call_rcu()
+	include:
+
+	a.	Keeping a count of the number of data-structure elements
+		used by the RCU-protected data structure, including those
+		waiting for a grace period to elapse.  Enforce a limit
+		on this number, stalling updates as needed to allow
+		previously deferred frees to complete.
+
+		Alternatively, limit only the number awaiting deferred
+		free rather than the total number of elements.
+
+	b.	Limiting update rate.  For example, if updates occur only
+		once per hour, then no explicit rate limiting is required,
+		unless your system is already badly broken.  The dcache
+		subsystem takes this approach -- updates are guarded
+		by a global lock, limiting their rate.
+
+	c.	Trusted update -- if updates can only be done manually by
+		superuser or some other trusted user, then it might not
+		be necessary to automatically limit them.  The theory
+		here is that superuser already has lots of ways to crash
+		the machine.
+
+	d.	Use call_rcu_bh() rather than call_rcu(), in order to take
+		advantage of call_rcu_bh()'s faster grace periods.
+
+	e.	Periodically invoke synchronize_rcu(), permitting a limited
+		number of updates per grace period.
 
 9.	All RCU list-traversal primitives, which include
 	list_for_each_rcu(), list_for_each_entry_rcu(),
diff -urpNa -X dontdiff linux-2.6.17-rc3/Documentation/RCU/whatisRCU.txt linux-2.6.17-rc3-RCUDOC/Documentation/RCU/whatisRCU.txt
--- linux-2.6.17-rc3/Documentation/RCU/whatisRCU.txt	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3-RCUDOC/Documentation/RCU/whatisRCU.txt	2006-06-09 17:08:01.000000000 -0700
@@ -184,7 +184,17 @@ synchronize_rcu()
 	blocking, it registers a function and argument which are invoked
 	after all ongoing RCU read-side critical sections have completed.
 	This callback variant is particularly useful in situations where
-	it is illegal to block.
+	it is illegal to block or where update-side performance is
+	critically important.
+
+	However, the call_rcu() API should not be used lightly, as use
+	of the synchronize_rcu() API generally results in simpler code.
+	In addition, the synchronize_rcu() API has the nice property
+	of automatically limiting update rate should grace periods
+	be delayed.  This property results in system resilience in face
+	of denial-of-service attacks.  Code using call_rcu() should limit
+	update rate in order to gain this same sort of resilience.  See
+	checklist.txt for some approaches to limiting the update rate.
 
 rcu_assign_pointer()
 
