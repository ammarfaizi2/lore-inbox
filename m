Return-Path: <linux-kernel-owner+w=401wt.eu-S1754980AbXABVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbXABVeF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbXABVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:34:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:51458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754980AbXABVeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:34:03 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] use cycle_t instead of u64 in struct time_interpolator
Date: Tue, 2 Jan 2007 22:33:25 +0100
User-Agent: KMail/1.9.5
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,7X
	?Bt1Wb:L7K6z-<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(e}
	`-QV{#%&[?^fAke6t8QbP;b'XB,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"
	["ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
Cc: parisc-linux@lists.parisc-linux.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701022233.25697.deller@gmx.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 32bit and 64bit PARISC Linux kernels suffers from the problem, that the gettimeofday() call sometimes returns non-monotonic times.
The easiest way to fix this, is to drop the PARISC-specific implementation and switch over to the generic TIME_INTERPOLATION framework.
But in order to make it even compile on 32bit PARISC, the patch below which touches the generic Linux code, is mandatory. 
More information and the full patch with the parisc-specific changes is included in this thread: http://lists.parisc-linux.org/pipermail/parisc-linux/2006-December/031003.html

As far as I could see, this patch does not change anything for the existing architectures which use this framework (IA64 and SPARC64), since "cycles_t" is defined there as unsigned 64bit-integer anyway (which then makes this patch a no-change for them).

Ok, not Ok ?

Regards, Helge


Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/include/linux/timex.h b/include/linux/timex.h
index db501dc..9a24e50 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -255,10 +255,10 @@ struct time_interpolator {
 	u8 jitter;			/* if set compensate for fluctuations */
 	u32 nsec_per_cyc;		/* set by register_time_interpolator() */
 	void *addr;			/* address of counter or function */
-	u64 mask;			/* mask the valid bits of the counter */
+	cycles_t mask;			/* mask the valid bits of the counter */
 	unsigned long offset;		/* nsec offset at last update of interpolator */
 	u64 last_counter;		/* counter value in units of the counter at last update */
-	u64 last_cycle;			/* Last timer value if TIME_SOURCE_JITTER is set */
+	cycles_t last_cycle;		/* Last timer value if TIME_SOURCE_JITTER is set */
 	u64 frequency;			/* frequency in counts/second */
 	long drift;			/* drift in parts-per-million (or -1) */
 	unsigned long skips;		/* skips forward */
diff --git a/kernel/timer.c b/kernel/timer.c
index c2a8ccf..d38801a 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1624,7 +1624,7 @@ struct time_interpolator *time_interpola
 static struct time_interpolator *time_interpolator_list __read_mostly;
 static DEFINE_SPINLOCK(time_interpolator_lock);
 
-static inline u64 time_interpolator_get_cycles(unsigned int src)
+static inline cycles_t time_interpolator_get_cycles(unsigned int src)
 {
 	unsigned long (*x)(void);
 
@@ -1650,8 +1650,8 @@ static inline u64 time_interpolator_get_
 
 	if (time_interpolator->jitter)
 	{
-		u64 lcycle;
-		u64 now;
+		cycles_t lcycle;
+		cycles_t now;
 
 		do {
 			lcycle = time_interpolator->last_cycle;
