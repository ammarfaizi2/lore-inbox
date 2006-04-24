Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDXLNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDXLNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 07:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDXLNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 07:13:19 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33130 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750712AbWDXLNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 07:13:18 -0400
Date: Mon, 24 Apr 2006 13:13:16 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch] s390: exploit rcu_soon_pending() interface
Message-ID: <20060424111316.GD16007@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Exploit rcu_soon_pending() interface to keep the cpu 'ticking'.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---  

 arch/s390/kernel/time.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index fea043b..1c06c9c 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -249,18 +249,20 @@ static inline void stop_hz_timer(void)
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
+	if (rcu_pending(cpu) || rcu_soon_pending(cpu) ||
+	    local_softirq_pending()) {
+		cpu_clear(cpu, nohz_cpu_mask);
 		return;
 	}
 
