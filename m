Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUKBTS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUKBTS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUKBTSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:18:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59104 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261292AbUKBTSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:18:09 -0500
Date: Tue, 2 Nov 2004 20:18:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102191858.GB1216@elte.hu>
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> This build appears to run OK and then in the middle of the real time
> tests stops doing useful work (during network test).

weird, the deadlock detector did not trigger, although it is a clear
circular deadlock:

R     ksoftirqd/0/    3 [dffe8020, 105] blocked on: [dfcafc20] {r:0,a:-1,&((sk)->sk_lock.slock)}
.. held by:               rcp/ 4791 [d84bd910, 118]
... acquired at:  ip_send_reply+0x12b/0x250

D             rcp/ 4791 [d84bd910, 118] blocked on: [c03cb900] {r:0,a:-1,ptype_lock}
.. held by:       ksoftirqd/0/    3 [dffe8020, 105]
... acquired at:  netif_receive_skb+0xae/0x330

i.e. ksoftirqd blocked on rcp and rcp blocked on ksoftirqd, cleanly
deadlocking each other.

anyway, does the patch below, ontop of -V0.6.8, fix this type of hang?

	Ingo

--- linux/net/core/dev.c.orig
+++ linux/net/core/dev.c
@@ -1916,7 +1916,9 @@ static void net_rx_action(struct softirq
 		dev = list_entry(queue->poll_list.next,
 				 struct net_device, poll_list);
 
+		rcu_read_lock_read(&ptype_lock);
 		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
+			rcu_read_unlock_read(&ptype_lock);
 			local_irq_disable();
 			list_del(&dev->poll_list);
 			list_add_tail(&dev->poll_list, &queue->poll_list);
@@ -1926,6 +1928,7 @@ static void net_rx_action(struct softirq
 				dev->quota = dev->weight;
 		} else {
 			dev_put(dev);
+			rcu_read_unlock_read(&ptype_lock);
 			local_irq_disable();
 		}
 
