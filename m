Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWF2KOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWF2KOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWF2KOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:14:50 -0400
Received: from [82.133.102.210] ([82.133.102.210]:18421 "EHLO
	cockermouth.uk.xensource.com") by vger.kernel.org with ESMTP
	id S1751663AbWF2KOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:14:50 -0400
Date: Thu, 29 Jun 2006 11:14:36 +0100
From: Emmanuel Ackaouy <ack@xensource.com>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com
Subject: [PATCH] no_idle_hz (s390/xen) 2.6.16.13: fix next_timer_interrupt() when timer pending
Message-ID: <20060629101436.GA18542@cockermouth.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix next_timer_interrupt() to return the expired timeout of any
pending timer instead of the default "nothing scheduled" timeout
value of jiffies+MAX_JIFFY_OFFSET. See comment in patch for details.

Signed-off-by: Emmanuel Ackaouy <ack@xensource.com>


diff -pruN pristine-linux-2.6.16.13/kernel/timer.c linux-2.6.16.13-xen/kernel/timer.c
--- pristine-linux-2.6.16.13/kernel/timer.c	2006-05-02 22:38:44.000000000 +0100
+++ linux-2.6.16.13-xen/kernel/timer.c	2006-06-28 21:38:58.000000000 +0100
@@ -555,7 +555,17 @@ found:
 	}
 	spin_unlock(&base->t_base.lock);
 
-	if (time_before(hr_expires, expires))
+	/*
+	 * If timers are pending, "expires" will be in the recent past
+	 * of "jiffies". If there are no hr_timers registered, "hr_expires"
+	 * will be "jiffies + MAX_JIFFY_OFFSET"; this is *just* short of being
+	 * considered to be before "jiffies". This makes it very likely that
+	 * "hr_expires" *will* be considered to be before "expires".
+	 * So we must check when there are pending timers (expires <= jiffies)
+	 * to ensure that we don't accidently tell the caller that there is
+	 * nothing scheduled until half an epoch (MAX_JIFFY_OFFSET)!
+	 */
+	if (time_before(jiffies, expires) && time_before(hr_expires, expires))
 		return hr_expires;
 
 	return expires;
