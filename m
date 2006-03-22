Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWCVPQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWCVPQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWCVPQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:16:58 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:16559 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751292AbWCVPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:16:56 -0500
Date: Wed, 22 Mar 2006 16:17:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, ryan@funsoft.com, linux-kernel@vger.kernel.org
Subject: [patch 7/24] s390: cpu up retries.
Message-ID: <20060322151723.GG5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ryan <ryan@funsoft.com>

[patch 7/24] s390: cpu up retries.

Retry starting of new cpu if sigp restart returns condition code 2 (busy).

Signed-off-by: Michael Ryan <ryan@funsoft.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-03-22 14:36:17.000000000 +0100
@@ -665,7 +665,9 @@ __cpu_up(unsigned int cpu)
         cpu_lowcore->current_task = (unsigned long) idle;
         cpu_lowcore->cpu_data.cpu_nr = cpu;
 	eieio();
-	signal_processor(cpu,sigp_restart);
+
+	while (signal_processor(cpu,sigp_restart) == sigp_busy)
+		udelay(10);
 
 	while (!cpu_online(cpu))
 		cpu_relax();
