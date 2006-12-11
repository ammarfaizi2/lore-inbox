Return-Path: <linux-kernel-owner+w=401wt.eu-S1762917AbWLKNtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762917AbWLKNtx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762919AbWLKNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:49:53 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:47520 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762917AbWLKNtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:49:53 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Optimize calc_load()
Date: Mon, 11 Dec 2006 14:50:07 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com> <20061211021718.a6954106.akpm@osdl.org> <200612111152.56945.dada1@cosmosbay.com>
In-Reply-To: <200612111152.56945.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PIWfFK6VKqIl6p/"
Message-Id: <200612111450.07722.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PIWfFK6VKqIl6p/
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

calc_load() is called by timer interrupt to update avenrun[].
It currently calls nr_active() at each timer tick (HZ per second), while the 
update of avenrun[] is done only once every 5 seconds. (LOAD_FREQ=5 Hz)

nr_active() is quite expensive on SMP machines, since it has to sum up 
nr_running and nr_uninterruptible of all online CPUS, bringing foreign dirty 
cache lines.

This patch is an optimization of calc_load() so that nr_active() is called 
only if we need it.

The use of unlikely() is welcome since the condition is true only once every 
5*HZ time.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_PIWfFK6VKqIl6p/
Content-Type: text/plain;
  charset="utf-8";
  name="calc_load.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="calc_load.patch"

--- linux-2.6.19/kernel/timer.c	2006-12-11 12:27:28.000000000 +0100
+++ linux-2.6.19-ed/kernel/timer.c	2006-12-11 12:29:11.000000000 +0100
@@ -1008,11 +1008,15 @@ static inline void calc_load(unsigned lo
 	unsigned long active_tasks; /* fixed-point */
 	static int count = LOAD_FREQ;
 
-	active_tasks = count_active_tasks();
-	for (count -= ticks; count < 0; count += LOAD_FREQ) {
-		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
-		CALC_LOAD(avenrun[1], EXP_5, active_tasks);
-		CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+	count -= ticks;
+	if (unlikely(count < 0)) {
+		active_tasks = count_active_tasks();
+		do {
+			CALC_LOAD(avenrun[0], EXP_1, active_tasks);
+			CALC_LOAD(avenrun[1], EXP_5, active_tasks);
+			CALC_LOAD(avenrun[2], EXP_15, active_tasks);
+			count += LOAD_FREQ;
+		} while (count < 0);
 	}
 }
 

--Boundary-00=_PIWfFK6VKqIl6p/--
