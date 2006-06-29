Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWF2Vj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWF2Vj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWF2Vj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:39:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22416 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932667AbWF2Vj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:39:26 -0400
Subject: [PATCH] rcu: Add lock annotations to RCU locking primitives
From: Josh Triplett <josht@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Paul McKenney <paulmck@us.ibm.com>, Dipkanar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 14:39:23 -0700
Message-Id: <1151617163.6507.15.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add __acquire annotations to rcu_read_lock and rcu_read_lock_bh, and add
__release annotations to rcu_read_unlock and rcu_read_unlock_bh.  This allows
sparse to detect improperly paired calls to these functions.

Signed-off-by: Josh Triplett <josh@freedesktop.org>

---

 include/linux/rcupdate.h |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

0a6ff66d5cf24cf6106c933e1f183687358ebc7e
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 48dfe00..b4ca73d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -163,14 +163,22 @@ extern int rcu_needs_cpu(int cpu);
  *
  * It is illegal to block while in an RCU read-side critical section.
  */
-#define rcu_read_lock()		preempt_disable()
+#define rcu_read_lock() \
+	do { \
+		preempt_disable(); \
+		__acquire(RCU); \
+	} while(0)
 
 /**
  * rcu_read_unlock - marks the end of an RCU read-side critical section.
  *
  * See rcu_read_lock() for more information.
  */
-#define rcu_read_unlock()	preempt_enable()
+#define rcu_read_unlock() \
+	do { \
+		__release(RCU); \
+		preempt_enable(); \
+	} while(0)
 
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
@@ -193,14 +201,22 @@ #define rcu_read_unlock()	preempt_enable
  * can use just rcu_read_lock().
  *
  */
-#define rcu_read_lock_bh()	local_bh_disable()
+#define rcu_read_lock_bh() \
+	do { \
+		local_bh_disable(); \
+		__acquire(RCU_BH); \
+	} while(0)
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
-#define rcu_read_unlock_bh()	local_bh_enable()
+#define rcu_read_unlock_bh() \
+	do { \
+		__release(RCU_BH); \
+		local_bh_enable(); \
+	} while(0)
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an


