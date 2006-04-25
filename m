Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWDYM1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWDYM1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWDYM1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:27:09 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42495 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932206AbWDYM1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:27:08 -0400
Date: Tue, 25 Apr 2006 14:27:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       schwidefsky@de.ibm.com
Subject: [patch] RCU: introduce rcu_needs_cpu() interface
Message-ID: <20060425122706.GB9421@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com> <20060425115226.GA9421@osiris.boeblingen.de.ibm.com> <20060425120854.GF16719@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425120854.GF16719@us.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: "Paul E. McKenney" <paulmck@us.ibm.com>

Introduce rcu_needs_cpu() interface. This can be used to tell if there
will be a new rcu batch on a cpu soon by looking at the curlist pointer.
This can be used to avoid to enter a tickless idle state where the cpu
would miss that a new batch is ready when rcu_start_batch would be called
on a different cpu.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

This one replaces rcu-introduce-rcu_soon_pending-interface.patch .

 include/linux/rcupdate.h |    1 +
 kernel/rcupdate.c        |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5673008..970284f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -132,6 +132,7 @@ static inline void rcu_bh_qsctr_inc(int 
 }
 
 extern int rcu_pending(int cpu);
+extern int rcu_needs_cpu(int cpu);
 
 /**
  * rcu_read_lock - mark the beginning of an RCU read-side critical section.
diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
index 13458bb..651ac14 100644
--- a/kernel/rcupdate.c
+++ b/kernel/rcupdate.c
@@ -485,6 +485,14 @@ int rcu_pending(int cpu)
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
+int rcu_needs_cpu(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
+
+	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
+}
+
 void rcu_check_callbacks(int cpu, int user)
 {
 	if (user || 
