Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWCXRv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWCXRv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCXRv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:51:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:20141 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751318AbWCXRvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:51:55 -0500
Date: Fri, 24 Mar 2006 11:51:36 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       roe@sgi.com, steiner@sgi.com, Christoph Lameter <clameter@sgi.com>
Subject: [PATCH] Call get_time() only when necessary in run_hrtimer_queue
Message-ID: <20060324175136.GA10186@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that run_hrtimer_queue() is calling get_time() much more often
than it needs to.

With this patch, it only calls get_time() if there's a pending timer.

Following is from a profile done without the patch:
kernel ticks:           30841           1.02 %
      13572       44.01    44.01      time_interpolator_get_offset
        155        0.50    96.91      hrtimer_run_queues

And with the patch:
	kernel ticks:           18334           0.58 %
         74        0.40    97.81      hrtimer_run_queues
         43        0.23    98.63      time_interpolator_get_offset


Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux-2.6.15/kernel/hrtimer.c
===================================================================
--- linux-2.6.15.orig/kernel/hrtimer.c	2006-03-23 14:37:49.032686221 -0600
+++ linux-2.6.15/kernel/hrtimer.c	2006-03-23 14:39:10.655542086 -0600
@@ -586,12 +586,17 @@ int hrtimer_get_res(const clockid_t whic
  */
 static inline void run_hrtimer_queue(struct hrtimer_base *base)
 {
-	ktime_t now = base->get_time();
-	struct rb_node *node;
+	ktime_t now;
+	struct rb_node *node = base->first;
+
+	if (!node)
+		return;
+
+	now = base->get_time();
 
 	spin_lock_irq(&base->lock);
 
-	while ((node = base->first)) {
+	while (node) {
 		struct hrtimer *timer;
 		int (*fn)(void *);
 		int restart;
@@ -620,6 +625,7 @@ static inline void run_hrtimer_queue(str
 
 		spin_lock_irq(&base->lock);
 
+		node = base->first;
 		/* Another CPU has added back the timer */
 		if (timer->state != HRTIMER_RUNNING)
 			continue;
