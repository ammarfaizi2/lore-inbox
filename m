Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFAWwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFAWwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFAWwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:52:21 -0400
Received: from pat.uio.no ([129.240.130.16]:8952 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261153AbVFAWwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:52:11 -0400
Subject: Re: RT and Cascade interrupts
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: john cooper <john.cooper@timesys.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Olaf Kirch <okir@suse.de>
In-Reply-To: <429E21B8.2070404@timesys.com>
References: <42974F08.1C89CF2A@tv-sign.ru> <4297AF39.4070304@timesys.com>
	 <42983135.C521F1C8@tv-sign.ru> <4298AED8.8000408@timesys.com>
	 <1117312557.10746.6.camel@lade.trondhjem.org>
	 <4299332F.6090900@timesys.com>
	 <1117352410.10788.29.camel@lade.trondhjem.org>
	 <429B8678.1000706@timesys.com> <429DC4A8.BFF69FB3@tv-sign.ru>
	 <429DF8DE.7060008@timesys.com>
	 <1117650718.10733.65.camel@lade.trondhjem.org>
	 <429E0A86.7000507@timesys.com>
	 <1117657267.10733.106.camel@lade.trondhjem.org>
	 <429E21B8.2070404@timesys.com>
Content-Type: multipart/mixed; boundary="=-M+yxdc0JQEtNpOZutYUf"
Date: Wed, 01 Jun 2005 18:51:58 -0400
Message-Id: <1117666319.10822.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.562, required 12,
	autolearn=disabled, AWL 1.39, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M+yxdc0JQEtNpOZutYUf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

on den 01.06.2005 Klokka 16:59 (-0400) skreiv john cooper:
> Yes later versions of the patch do.  The version at hand
> 40-04 is based on 2.6.11.  We intend to sync-up with a
> more recent version of the RT patch pending resolution
> of this issue.

Well it is pointless to concentrate on an obviously buggy patch. Could
you please sync up to rc5-rt-V0.7.47-15 at least: that looks like it
might be working (or at least be close to working).

Could you then apply the following debugging patch? It should warn you
in case something happens to corrupt base->running_timer (something
which would screw up del_timer_sync()). I'm not sure that can happen,
but it might be worth checking.

Cheers,
  Trond

--=-M+yxdc0JQEtNpOZutYUf
Content-Disposition: inline; filename=linux-2.6.12-rt-warn.dif
Content-Type: text/plain; name=linux-2.6.12-rt-warn.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

 timer.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc5-rt-V0.7.47-15/kernel/timer.c
===================================================================
--- linux-2.6.12-rc5-rt-V0.7.47-15.orig/kernel/timer.c
+++ linux-2.6.12-rc5-rt-V0.7.47-15/kernel/timer.c
@@ -436,7 +436,7 @@ static int cascade(tvec_base_t *base, tv
 
 static inline void __run_timers(tvec_base_t *base)
 {
-	struct timer_list *timer;
+	struct timer_list *timer = NULL;
 
 	spin_lock_irq(&base->lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
@@ -444,6 +444,10 @@ static inline void __run_timers(tvec_bas
 		struct list_head *head = &work_list;
  		int index = base->timer_jiffies & TVR_MASK;
 
+		if (unlikely(base->running_timer != timer)) {
+			printk("BUG in line %d: __run_timers() is non-reentrant!\n", __LINE__);
+			return;
+		}
 		if (softirq_need_resched()) {
 			/* running_timer might be stale: */
 			set_running_timer(base, NULL);
@@ -459,6 +463,10 @@ static inline void __run_timers(tvec_bas
 			 * valid. Any new jiffy will be taken care of in
 			 * subsequent loops:
 			 */
+			if (unlikely(base->running_timer != timer)) {
+				printk("BUG in line %d: __run_timers() is non-reentrant!\n", __LINE__);
+				return;
+			}
 		}
 		/*
 		 * Cascade timers:
@@ -498,6 +506,10 @@ repeat:
 			goto repeat;
 		}
 	}
+	if (unlikely(base->running_timer != timer)) {
+		printk("BUG in line %d: __run_timers() is non-reentrant!\n", __LINE__);
+		return;
+	}
 	set_running_timer(base, NULL);
 	spin_unlock_irq(&base->lock);
 //	if (waitqueue_active(&base->wait_running_timer))

--=-M+yxdc0JQEtNpOZutYUf--

