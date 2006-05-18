Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWERUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWERUyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWERUyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:54:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:28676 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751396AbWERUyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:54:13 -0400
Message-ID: <446CDDAE.1070908@vmware.com>
Date: Thu, 18 May 2006 13:48:46 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, schwidefsky@de.ibm.com,
       george@mvista.com, Xen-devel <xen-devel@lists.xensource.com>
Subject: [PATCH] Fix a NO_IDLE_HZ timer bug
Content-Type: multipart/mixed;
 boundary="------------080705030004080500090309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705030004080500090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This bug affects at least s390, Xen, and occurred during testing of 
NO_IDLE_HZ with our VMI patches.  The bug is rather subtle and rare.  
Jiffies can be advanced by other CPUs, but if the current CPU has not 
processed timer softirqs in a while, the timer wheel can be behind 
jiffies, causing an overflow when comparing the next timer wheel 
expiration with the default high resolution timeout (no timeout), which 
is relative to jiffies.

It also looks like s390 has another bug.  When compiling the 32-bit 
kernel, doesn't this computation overflow:

arch/s390/kernel/time.c, stop_hz_timer:274

        /*
         * This cpu is going really idle. Set up the clock comparator
         * for the next event.
         */
        next = next_timer_interrupt();
        do {
                seq = read_seqbegin_irqsave(&xtime_lock, flags);
                timer = (__u64)(next - jiffies) + jiffies_64;
        } while (read_seqretry_irqrestore(&xtime_lock, seq, flags));


Since jiffies can advance between next_timer_interrupt and the read 
under xtime lock, next-jiffies could be negative.  I would think you 
want to cast that to signed long instead of __u64, but I'm not totally 
qualified to talk about s390.

Zach

--------------080705030004080500090309
Content-Type: text/plain;
 name="no-idle-hz-timer-race"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-idle-hz-timer-race"

Under certain timing conditions, a race during boot occurs where timer ticks
are being processed on remote CPUs.  The remote timer ticks can increment
jiffies, and if this happens during a window when a timeout is very close to
expiring but a local tick has not yet been delivered, you can end up with

1) No softirq pending
2) A local timer wheel which is not synced to jiffies
3) No high resolution timer active
4) A local timer which is supposed to fire before the current jiffies value.

In this circumstance, the comparison in next_timer_interrupt overflows, because
the base of the comparison for high resolution timers is jiffies, but for the
softirq timer wheel, it is relative the the current base of the wheel
(jiffies_base).

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.17-rc/kernel/timer.c
===================================================================
--- linux-2.6.17-rc.orig/kernel/timer.c	2006-05-18 13:32:22.000000000 -0700
+++ linux-2.6.17-rc/kernel/timer.c	2006-05-18 13:34:59.000000000 -0700
@@ -541,6 +541,22 @@ found:
 	}
 	spin_unlock(&base->lock);
 
+	/*
+	 * It can happen that other CPUs service timer IRQs and increment
+	 * jiffies, but we have not yet got a local timer tick to process
+	 * the timer wheels.  In that case, the expiry time can be before
+	 * jiffies, but since the high-resolution timer here is relative to
+	 * jiffies, the default expression when high-resolution timers are
+	 * not active,
+	 *
+	 *   time_before(MAX_JIFFY_OFFSET + jiffies, expires)
+	 *
+	 * would falsely evaluate to true.  If that is the case, just
+	 * return jiffies so that we can immediately fire the local timer
+	 */
+	if (time_before(expires, jiffies))
+		return jiffies;
+
 	if (time_before(hr_expires, expires))
 		return hr_expires;
 

--------------080705030004080500090309--
