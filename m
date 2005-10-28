Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbVJ1OHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbVJ1OHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbVJ1OHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:07:06 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57568 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S965231AbVJ1OHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:07:00 -0400
Date: Fri, 28 Oct 2005 16:07:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/14] s390: stop_hz_timer vs. xtime updates.
Message-ID: <20051028140706.GC7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 3/14] s390: stop_hz_timer vs. xtime updates.

The calculation of the value return by next_timer_interrupt from
jiffies to jiffies_64 is racy against xtime updates. We need to
protect the calculation with read_seqbegin/read_seqretry.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2005-10-28 14:04:45.000000000 +0200
@@ -241,6 +241,8 @@ int sysctl_hz_timer = 1;
  */
 static inline void stop_hz_timer(void)
 {
+	unsigned long flags;
+	unsigned long seq, next;
 	__u64 timer, todval;
 
 	if (sysctl_hz_timer != 0)
@@ -261,7 +263,11 @@ static inline void stop_hz_timer(void)
 	 * This cpu is going really idle. Set up the clock comparator
 	 * for the next event.
 	 */
-	timer = (__u64) (next_timer_interrupt() - jiffies) + jiffies_64;
+	next = next_timer_interrupt();
+	do {
+		seq = read_seqbegin_irqsave(&xtime_lock, flags);
+		timer = (__u64)(next - jiffies) + jiffies_64;
+	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 	todval = -1ULL;
 	/* Be careful about overflows. */
 	if (timer < (-1ULL / CLK_TICKS_PER_JIFFY)) {
