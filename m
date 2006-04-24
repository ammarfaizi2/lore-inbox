Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDXLLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDXLLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 07:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDXLLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 07:11:44 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51579 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750715AbWDXLLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 07:11:43 -0400
Date: Mon, 24 Apr 2006 13:11:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce rcu_soon_pending() interface. This can be used to tell if there
will be a new rcu batch on a cpu soon by looking at the curlist pointer.
This can be used to avoid to enter a tickless idle state where the cpu
would miss that a new batch is ready when rcu_start_batch would be called
on a different cpu.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

See also here: http://www.ussg.iu.edu/hypermail/linux/kernel/0604.3/0057.html
Better solutions welcome :)

 include/linux/rcupdate.h |    1 +
 kernel/rcupdate.c        |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5673008..80bcbce 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -132,6 +132,7 @@ static inline void rcu_bh_qsctr_inc(int 
 }
 
 extern int rcu_pending(int cpu);
+extern int rcu_soon_pending(int cpu);
 
 /**
  * rcu_read_lock - mark the beginning of an RCU read-side critical section.
diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
index 13458bb..e8cf09f 100644
--- a/kernel/rcupdate.c
+++ b/kernel/rcupdate.c
@@ -485,6 +485,14 @@ int rcu_pending(int cpu)
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
+int rcu_soon_pending(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
+
+	return (!!rdp->curlist || !!rdp_bh->curlist);
+}
+
 void rcu_check_callbacks(int cpu, int user)
 {
 	if (user || 
