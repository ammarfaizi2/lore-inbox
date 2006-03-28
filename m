Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWC1Qvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWC1Qvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC1Qvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:51:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50350 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750780AbWC1Qvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:51:45 -0500
Date: Tue, 28 Mar 2006 10:51:27 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       roe@sgi.com, steiner@sgi.com, clameter@sgi.com
Subject: Re: [PATCH] Call get_time() only when necessary in run_hrtimer_queue
Message-ID: <20060328165127.GC10411@sgi.com>
References: <20060324175136.GA10186@sgi.com> <20060324142849.5cc27edb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324142849.5cc27edb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 02:28:49PM -0800, Andrew Morton wrote:
> This code has been extensively redone in -mm and I am planning on sending
> all that to Linus within a week.
> 
> The hrtimer rework in -mm might fix this performance problem, although from
> a quick peek, perhaps not.
> 
> So could you please verify that the problem still needs fixing in
> 2.6.16-mm1 and if so, raise a patch against that?
>

The hrtimer work in -mm does improve on the situation, although there
appears to be some occasional cache line contention for xtime.  The
following patch (which is similiar to my previously submitted patch)
is applicable to 2.6.16-mm1 and does take care of at least a good
portion of that.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c	2006-03-27 09:43:40.000000000 -0600
+++ linux/kernel/hrtimer.c	2006-03-27 12:35:47.416054373 -0600
@@ -604,14 +604,17 @@ int hrtimer_get_res(const clockid_t whic
  */
 static inline void run_hrtimer_queue(struct hrtimer_base *base)
 {
-	struct rb_node *node;
+	struct rb_node *node = base->first;
+
+	if (!node)
+		return;
 
 	if (base->get_softirq_time)
 		base->softirq_time = base->get_softirq_time();
 
 	spin_lock_irq(&base->lock);
 
-	while ((node = base->first)) {
+	while (node) {
 		struct hrtimer *timer;
 		int (*fn)(struct hrtimer *);
 		int restart;
@@ -633,6 +636,7 @@ static inline void run_hrtimer_queue(str
 			BUG_ON(hrtimer_active(timer));
 			enqueue_hrtimer(timer, base);
 		}
+		node = base->first;
 	}
 	set_curr_timer(base, NULL);
 	spin_unlock_irq(&base->lock);
