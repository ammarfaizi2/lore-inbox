Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUH3TUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUH3TUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUH3TUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:20:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43199 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268285AbUH3TT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:19:56 -0400
Date: Mon, 30 Aug 2004 21:21:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040830192131.GA12249@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
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


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> LONG NETWORK LATENCIES
> ======================
> 
> In about 25 minutes of heavy testing, I had two latency traces with
> /proc/sys/kernel/preempt_max_latency set to 700. They had the same start /
> end location with the long delay as follows:
>   730 us, entries: 361
>   ...
>   started at rtl8139_poll+0x3c/0x160
>   ended at   rtl8139_poll+0x100/0x160

regarding this particular latency, could you try the attached patch
ontop of -Q5? It turns the ->poll() loop into separate, individually
preemptable iterations instead of one batch of processing. In theory
this should result in latency being lower regardless of the
netdev_max_backlog value.

	Ingo

--17pEHd4RhPHOinZp
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

--17pEHd4RhPHOinZp--
