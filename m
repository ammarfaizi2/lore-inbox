Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUJWUdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUJWUdS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbUJWUdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:33:18 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:63332 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261306AbUJWUc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:32:28 -0400
Date: Sat, 23 Oct 2004 13:27:23 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] RCU: rcu_assign_pointer() removal of memory barriers
Message-ID: <20041023202723.GA1930@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the rcu_assign_pointer() API that helps reduce the
need for explicit memory barriers in code that uses RCU.  This API
buries the required memory barriers in a macro that also does the
assignment.  This has been tested successfully on i386 and ppc64.

Signed-off-by: <paulmck@us.ibm.com>

---

 rcupdate.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)

diff -urpN -X ../dontdiff linux-2.5/include/linux/rcupdate.h linux-2.5-rap/include/linux/rcupdate.h
--- linux-2.5/include/linux/rcupdate.h	Tue Sep  7 10:04:29 2004
+++ linux-2.5-rap/include/linux/rcupdate.h	Tue Sep  7 12:12:09 2004
@@ -238,6 +238,24 @@ static inline int rcu_pending(int cpu)
 				(_________p1); \
 				})
 
+/**
+ * rcu_assign_pointer - assign (publicize) a pointer to a newly
+ * initialized structure that will be dereferenced by RCU read-side
+ * critical sections.  Returns the value assigned.
+ *
+ * Inserts memory barriers on architectures that require them
+ * (pretty much all of them other than x86), and also prevents
+ * the compiler from reordering the code that initializes the
+ * structure after the pointer assignment.  More importantly, this
+ * call documents which pointers will be dereferenced by RCU read-side
+ * code.
+ */
+
+#define rcu_assign_pointer(p, v)	({ \
+						smp_wmb(); \
+						(p) = (v); \
+					})
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
