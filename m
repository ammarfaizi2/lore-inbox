Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268779AbUH3SPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268779AbUH3SPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUH3SAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:00:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42949 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268758AbUH3R6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:58:31 -0400
Date: Mon, 30 Aug 2004 20:00:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040830180011.GA7419@elte.hu>
References: <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093875939.5534.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <1093875939.5534.9.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Thomas Charbonnel <thomas@undata.org> wrote:

> Ingo Molnar wrote :
> > i've uploaded -Q5 to:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5
> > 
> 
> Here are the problematic spots for me with Q5:
> 
> rtl8139_poll (this one was also present with previous versions of the
> patch) :
> http://www.undata.org/~thomas/q5_rtl8139.trace

ok, rx processing latency again. You've set netdev_max_backlog to a low
value, right? I think we can break this particular loop independently of
netdev_max_backlog, could you try the attached patch ontop of -Q5, does
it help?

> =======>
> 00000001 0.000ms (+0.000ms): resolve_symbol (simplify_symbols)
> 00000001 0.000ms (+0.000ms): __find_symbol (resolve_symbol)
> 00000001 0.154ms (+0.154ms): use_module (resolve_symbol)
> 00000001 0.154ms (+0.000ms): sub_preempt_count (resolve_symbol)

seems resolve_symbol() is quite expensive ... no idea how to fix this
one right away, it seems to be pure algorithmic overhead.

> and a weird one with do_timer (called from do_IRQ) taking more than 1ms
> to complete :
> http://www.undata.org/~thomas/do_irq.trace

hm, indeed this is a weird one. 1 msec is too close to the timer 
frequency to be accidental. According to the trace:

 00010000 0.002ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 00010001 0.002ms (+0.000ms): mark_offset_tsc (timer_interrupt)
 00010001 1.028ms (+1.025ms): do_timer (timer_interrupt)
 00010001 1.028ms (+0.000ms): update_process_times (do_timer)

the latency happened between the beginning of mark_offset_tsc() and the
calling of do_timer() - i.e. the delay happened somewhere within
mark_offset_tsc() itself. Is this an SMP system?

	Ingo

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=2

--- linux/net/core/dev.c.orig2	
+++ linux/net/core/dev.c	
@@ -1903,7 +1903,7 @@ static void net_rx_action(struct softirq
 {
 	struct softnet_data *queue = &__get_cpu_var(softnet_data);
 	unsigned long start_time = jiffies;
-	int budget = netdev_max_backlog;
+	int budget = netdev_max_backlog, loops;
 
 	
 	local_irq_disable();
@@ -1926,7 +1926,10 @@ static void net_rx_action(struct softirq
 		dev = list_entry(queue->poll_list.next,
 				 struct net_device, poll_list);
 
-		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
+		loops = 1;
+		if (dev->quota <= 0 || dev->poll(dev, &loops)) {
+			if (loops < 1)
+				budget--;
 			local_irq_disable();
 			list_del(&dev->poll_list);
 			list_add_tail(&dev->poll_list, &queue->poll_list);

--MGYHOYXEY6WxJCY8--
