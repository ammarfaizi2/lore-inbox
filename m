Return-Path: <linux-kernel-owner+w=401wt.eu-S1755029AbXACI2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbXACI2g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 03:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbXACI2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 03:28:36 -0500
Received: from brick.kernel.dk ([62.242.22.158]:2853 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028AbXACI2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 03:28:36 -0500
Date: Wed, 3 Jan 2007 09:31:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org
Subject: [PATCH] 3/4 qrcu: add documentation
Message-ID: <20070103083123.GJ11203@kernel.dk>
References: <11678105083001-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11678105083001-git-send-email-jens.axboe@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Jens Axboe <jens.axboe@oracle.com>
---
 Documentation/RCU/checklist.txt |   13 +++++++++++++
 Documentation/RCU/rcu.txt       |    6 ++++--
 Documentation/RCU/torture.txt   |   15 +++++++++------
 Documentation/RCU/whatisRCU.txt |    3 +++
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index f4dffad..36d6185 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -259,3 +259,16 @@ over a rather long period of time, but improvements are always welcome!
 
 	Note that, rcu_assign_pointer() and rcu_dereference() relate to
 	SRCU just as they do to other forms of RCU.
+
+14.	QRCU is very similar to SRCU, but features very fast grace-period
+	processing at the expense of heavier-weight read-side operations.
+	The correspondance between QRCU and SRCU is as follows:
+
+		QRCU			SRCU
+
+		struct qrcu_struct	struct srcu_struct
+		init_qrcu_struct()	init_srcu_struct()
+		cleanup_qrcu_struct()	cleanup_srcu_struct()
+		qrcu_read_lock()	srcu_read_lock()
+		qrcu_read-unlock()	srcu_read_unlock()
+		synchronize_qrcu()	synchronize_srcu()
diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.txt
index f84407c..ae1e54e 100644
--- a/Documentation/RCU/rcu.txt
+++ b/Documentation/RCU/rcu.txt
@@ -45,8 +45,10 @@ o	How can I see where RCU is currently used in the Linux kernel?
 
 	Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
 	"rcu_read_lock_bh", "rcu_read_unlock_bh", "call_rcu_bh",
-	"srcu_read_lock", "srcu_read_unlock", "synchronize_rcu",
-	"synchronize_net", and "synchronize_srcu".
+	"qrcu_read_lock", qrcu_read_unlock", "srcu_read_lock",
+	"srcu_read_unlock", "synchronize_rcu", "synchronize_qrcu",
+	"synchronize_net", "synchronize_srcu", rcu_assign_pointer(),
+	and rcu_dereference().
 
 o	What guidelines should I follow when writing code that uses RCU?
 
diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
index 25a3c3f..2cb0a3b 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.txt
@@ -35,7 +35,8 @@ nfakewriters	This is the number of RCU fake writer threads to run.  Fake
 		different numbers of writers running in parallel.
 		nfakewriters defaults to 4, which provides enough parallelism
 		to trigger special cases caused by multiple writers, such as
-		the synchronize_srcu() early return optimization.
+		the synchronize_srcu() and synchronize_qrcu() early return
+		optimizations.
 
 stat_interval	The number of seconds between output of torture
 		statistics (via printk()).  Regardless of the interval,
@@ -54,11 +55,13 @@ test_no_idle_hz	Whether or not to test the ability of RCU to operate in
 		idle CPUs.  Boolean parameter, "1" to test, "0" otherwise.
 
 torture_type	The type of RCU to test: "rcu" for the rcu_read_lock() API,
-		"rcu_sync" for rcu_read_lock() with synchronous reclamation,
-		"rcu_bh" for the rcu_read_lock_bh() API, "rcu_bh_sync" for
-		rcu_read_lock_bh() with synchronous reclamation, "srcu" for
-		the "srcu_read_lock()" API, and "sched" for the use of
-		preempt_disable() together with synchronize_sched().
+		"rcu_sync" for rcu_read_lock() with synchronous
+		reclamation, "rcu_bh" for the rcu_read_lock_bh() API,
+		"rcu_bh_sync" for rcu_read_lock_bh() with synchronous
+		reclamation, "srcu" for the "srcu_read_lock()" API,
+		"qrcu" for the "qrcu_read_lock()" "quick grace period"
+		form of SRCU, and "sched" for the use of preempt_disable()
+		together with synchronize_sched().
 
 verbose		Enable debug printk()s.  Default is disabled.
 
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index e0d6d99..e91650b 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -780,6 +780,8 @@ Markers for RCU read-side critical sections:
 	rcu_read_unlock_bh
 	srcu_read_lock
 	srcu_read_unlock
+	qrcu_read_lock
+	qrcu_read_unlock
 
 RCU pointer/list traversal:
 
@@ -807,6 +809,7 @@ RCU grace period:
 	synchronize_sched
 	synchronize_rcu
 	synchronize_srcu
+	synchronize_qrcu
 	call_rcu
 	call_rcu_bh
 
-- 
1.4.4.2.g02c9

-- 
Jens Axboe

