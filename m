Return-Path: <linux-kernel-owner+w=401wt.eu-S967788AbWLILho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967788AbWLILho (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967799AbWLILho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:37:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46471 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967788AbWLILhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:37:43 -0500
Date: Sat, 9 Dec 2006 12:36:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] high-res timers: next_event calculation fix
Message-ID: <20061209113632.GA31648@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] high-res timers: next_event calculation fix
From: Ingo Molnar <mingo@elte.hu>

do not set expires_next to KTIME_MAX if a too short timeout
is being set - this can result in the clock events device
being shut down completely.

found via a stresstest on a C3-lapic-plagued laptop that did
very short sleeps.

This bug could explain the 'Synaptics hang' that was reported.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/clockevents.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux/kernel/time/clockevents.c
===================================================================
--- linux.orig/kernel/time/clockevents.c
+++ linux/kernel/time/clockevents.c
@@ -510,10 +510,8 @@ int clockevents_set_next_event(ktime_t e
 	struct clock_event_device *nextevt = devices->nextevt;
 	int64_t delta = ktime_to_ns(ktime_sub(expires, ktime_get()));
 
-	if (delta <= 0 && !force) {
-		devices->expires_next.tv64 = KTIME_MAX;
+	if (delta <= 0 && !force)
 		return -ETIME;
-	}
 
 	devices->expires_next = expires;
 
