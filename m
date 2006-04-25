Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWDYM2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWDYM2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWDYM2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:28:21 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:52944 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932209AbWDYM2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:28:21 -0400
Date: Tue, 25 Apr 2006 14:28:18 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       schwidefsky@de.ibm.com
Subject: [patch] s390: exploit rcu_needs_cpu() interface
Message-ID: <20060425122818.GC9421@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com> <20060425115226.GA9421@osiris.boeblingen.de.ibm.com> <20060425120854.GF16719@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425120854.GF16719@us.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Exploit rcu_needs_cpu() interface to keep the cpu 'ticking' if necessary.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

This one replaces s390-exploit-rcu_soon_pending-interface.patch .

 arch/s390/kernel/time.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index fea043b..029f099 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -249,18 +249,19 @@ static inline void stop_hz_timer(void)
 	unsigned long flags;
 	unsigned long seq, next;
 	__u64 timer, todval;
+	int cpu = smp_processor_id();
 
 	if (sysctl_hz_timer != 0)
 		return;
 
-	cpu_set(smp_processor_id(), nohz_cpu_mask);
+	cpu_set(cpu, nohz_cpu_mask);
 
 	/*
 	 * Leave the clock comparator set up for the next timer
 	 * tick if either rcu or a softirq is pending.
 	 */
-	if (rcu_pending(smp_processor_id()) || local_softirq_pending()) {
-		cpu_clear(smp_processor_id(), nohz_cpu_mask);
+	if (rcu_needs_cpu(cpu) || local_softirq_pending()) {
+		cpu_clear(cpu, nohz_cpu_mask);
 		return;
 	}
 
