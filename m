Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbULSE10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbULSE10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 23:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbULSE1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 23:27:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261263AbULSE1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 23:27:15 -0500
Date: Sat, 18 Dec 2004 23:26:52 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Con Kolivas <kernel@kolivas.org>
cc: Mikhail Ramendik <mr@ramendik.ru>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.7 backport request, spinoff idea
In-Reply-To: <41C4D990.1060507@kolivas.org>
Message-ID: <Pine.LNX.4.61.0412182325470.23136@chimarrao.boston.redhat.com>
References: <200412171504.41234.mr@ramendik.ru> <41C4A670.9090009@kolivas.org>
 <41C4A899.10102@kolivas.org> <200412190321.16567.mr@ramendik.ru>
 <41C4CE77.40601@kolivas.org> <41C4D990.1060507@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004, Con Kolivas wrote:

> Sorry for cc'ing the wrong email Rik. Do you have a simple link to the 
> patch or can you send it on this thread please?

Here it is.  The patch should have the effect of reducing the
swap token timeout to the minimum value at times when there is
little to no memory pressure, while allowing it to grow in times
where it is needed.


Date: Sat, 11 Dec 2004 14:24:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org
Subject: PATCH: automatic tuning of swap token timeout

At Marcelo's request.  I made this patch a while ago so I'm
not sure if it will still apply to the recent kernel, but it
should give you an idea of what I tried to achieve.

The idea is to keep the swap token timeout short on a system
with mostly small tasks, even if there is one big hog running
in the background.  The big thrashing program should not hold
the swap token for unfair amounts of time.

The swap token timeout should be the minimum required to keep
most of the processes in the system from thrashing, while
keeping some amount of fairness.

This patch is untested.  Have fun.

===== mm/thrash.c 1.2 vs edited =====
--- 1.2/mm/thrash.c	Wed Oct 20 04:37:11 2004
+++ edited/mm/thrash.c	Mon Nov  1 22:35:01 2004
@@ -19,10 +19,44 @@
   struct mm_struct * swap_token_mm = &init_mm;

   #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+#define MIN_SWAP_TOKEN_TIMEOUT (2 * SWAP_TOKEN_CHECK_INTERVAL)
+#define SWAP_TOKEN_TIMEOUT (HZ * 30)
+#define MAX_SWAP_TOKEN_TIMEOUT (HZ * 300)
   unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;

   /*
+ * We count how often the swap token times out, and how often the
+ * swap token hold time is long enough for processes to regain their
+ * working set and make progress.
+ *
+ * The goal is to have processes in the system make progress, with the
+ * lowest possible latency.  If the token times out too often, processes
+ * are not making progress and the timeout needs to be increased.  If
+ * processes are making progress, we can decrease the timeout and improve
+ * system latency.
+ */
+#define SWAP_TOKEN_RECALC 32
+#define SWAP_TOKEN_TOO_LONG 1
+static int swap_token_timed_out;
+static int swap_token_enough_rss;
+
+static void recalculate_swap_token_timeout(void)
+{
+	unsigned long delta = (swap_token_default_timeout / 4) + 1;
+	if (swap_token_timed_out > SWAP_TOKEN_TOO_LONG) {
+		swap_token_default_timeout += delta;
+		if (swap_token_default_timeout > MAX_SWAP_TOKEN_TIMEOUT)
+			swap_token_default_timeout = MAX_SWAP_TOKEN_TIMEOUT;
+	} else {
+		swap_token_default_timeout -= delta;
+		if (swap_token_default_timeout < MIN_SWAP_TOKEN_TIMEOUT)
+			swap_token_default_timeout = MIN_SWAP_TOKEN_TIMEOUT;
+	}
+	swap_token_enough_rss /= 2;
+	swap_token_timed_out /= 2;
+}
+
+/*
    * Take the token away if the process had no page faults
    * in the last interval, or if it has held the token for
    * too long.
@@ -32,11 +66,18 @@
   static int should_release_swap_token(struct mm_struct *mm)
   {
   	int ret = 0;
-	if (!mm->recent_pagein)
+	if (!mm->recent_pagein) {
+		swap_token_enough_rss++;
   		ret = SWAP_TOKEN_ENOUGH_RSS;
-	else if (time_after(jiffies, swap_token_timeout))
+	} else if (time_after(jiffies, swap_token_timeout)) {
+		swap_token_timed_out++;
   		ret = SWAP_TOKEN_TIMED_OUT;
+	}
   	mm->recent_pagein = 0;
+
+	if (swap_token_timed_out + swap_token_enough_rss > SWAP_TOKEN_RECALC)
+		recalculate_swap_token_timeout();
+
   	return ret;
   }

